Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C476188E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKCToU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:44:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15E1C433
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:44:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k2so8158108ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F73NVh4G3T8S2yU6hsKMODcKxPv5yAwi4/v2CzLveEg=;
        b=KVnkgAFjjkl9n+rm/oZKENhs6RKrqltUzzJ6tjSEd5aBgeBud65YYMIo94P8IRRCnB
         JHFMyMhXBlUXVaL+knKT2Pkp8uC0s0Zf2dM88KEosi92h25NpSD4Bj/6M+FqG+ZmavqZ
         xhZJFhh064eZshWoexLt3Yb9OB5V49HgndfM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F73NVh4G3T8S2yU6hsKMODcKxPv5yAwi4/v2CzLveEg=;
        b=CQUJh1vrgT1b8AZK32K/gxpFn0J+9Z3p9xFTxekxnWaSS0wLp89sZMM1toIBO4rN18
         BO3plShB5+l0NyM98i3OPXBiMHKJVc2kCi/zh/eAgn1xq/hkb2Qn8vq4JsSogM4GwEgv
         YFwo4Dm36lUKXWxIx7YCHH/HEMC0SxLzZq6EnsdHu52L4CN6/w1JYnjSY5n69PXTZQh5
         HsEsGgMlRAuT5niryH9mqn5Y5pL1g1iZOe2nn0veiMdKkNlE6yT4ZbQppoImIofGt0qa
         7S2lR1Vf25Lbjk0f/K/PbEB5JUuoU5Fv0P3PYlX4GSnhb4WMuRGPW36E29e/Rm5iBm1x
         fDeg==
X-Gm-Message-State: ACrzQf0tqwktr2wRRkyQbFPouvGdvOyVU2VLipc8m3pMWsN0UwVk4F4Y
        ENOPeXnm0VboMRBpXLse869rjbhZW2SxKh9ndusdYA==
X-Google-Smtp-Source: AMsMyM5ANFOKjZj2yIVNDYDiQ3nCa7qxoied3mzht3cE4j4IfN/LdAJLNmHmKpHWljc2OX8PMv3XprDEwHQe6D0neHU=
X-Received: by 2002:a17:906:371a:b0:7ad:c01c:6fa0 with SMTP id
 d26-20020a170906371a00b007adc01c6fa0mr26238935ejc.267.1667504655022; Thu, 03
 Nov 2022 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com>
In-Reply-To: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Nov 2022 20:44:04 +0100
Message-ID: <CAJfpegsU5ezACm_6CDSJfcN5fqz5vWje6UE_erNefr_e03nuaw@mail.gmail.com>
Subject: Re: [GIT PULL] fuse fixes for 6.1-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 at 20:42, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Hi Linus,
>
> Please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

Sorry, this was meant to be:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.1-rc4

Thanks,
Miklos
