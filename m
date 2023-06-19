Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC10B736010
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFSXSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:18:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D6F9;
        Mon, 19 Jun 2023 16:18:10 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so53415171fa.0;
        Mon, 19 Jun 2023 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687216689; x=1689808689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mekOaT6pTNlMip7QzXX14X+Vd/c6EeWkfjPSdnkJdI=;
        b=cBH2PYcc0OfvE+2Xx4e+aeq/Uc0XGQd8NgfRYAwalf16FZ4rz+BhtRHxmFCp6GScAd
         laewfcNh/0tJF/qBK08Acx1PrK3gqpSJGwkYnf6z3687VXQfYm8tVOYEUikP74Bxj4L+
         RJjxZii/SWvHsZjMSosSBK1pKbW4du5kj3yb47B0oKcRx83SPRM/Q/TdMiYL5IjPEQHo
         61S0hC4MoekTMBJ4QlK4gfMTYDtufFlUcW3UYRE7mAyOr0Arm1vFjYstRAOTMsgjZVMQ
         vbizpB76V2b3JOZL9Z00AF4IcNiqxjPzPvfOcbsAeidis8/xsQTwtA8FF4wj1jK/Lf7O
         pmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216689; x=1689808689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mekOaT6pTNlMip7QzXX14X+Vd/c6EeWkfjPSdnkJdI=;
        b=NgBXPF2rWeDDtV56iFm6/WbqBkH3HFtAdQkaujaNWLAoLGr0nIK7oQKTVfmeazgjc7
         yWvZBLRkfCDT8c1Qt3EuXm38ITC3vzHZY49AxGJdablM2uThskPVOVUOdyqM4ql9K4y4
         /PT8vBWDjdIaI2exKJAh+TAI6+o/g9xe+zN1ZYpN2wjF/Q038sBlgW1zaXb5BEJA9vhx
         VIE5FY9wO6thkpTtthbH1heUsPVydgtT1sVrj/fqIl7ftQLvjlpN6ue+gOPTD6fZ4AKQ
         AOjugwY8H7G5TfxdxtJ33YCH+AkWRkS54/UMU1zBuKzRxJHgne0lBFGTA229N/mxSAiE
         5B/A==
X-Gm-Message-State: AC+VfDxHUTRAXH/Tw7lW1uaVdQ0xXND7ka8EsAokZwm+yPtUsvp2BXhB
        F72dewUyrcFyA6U5rEj4XjNhd0UvmOB9qXESowc=
X-Google-Smtp-Source: ACHHUZ7EXzw6HOWw+uagO/6lmUztHkWmTwH6KA+qSPMZKyLdzUGohJIrBiNTRziYJvQlA5266MP/YVp/MRF9fg8sFrs=
X-Received: by 2002:a2e:9e58:0:b0:2ac:78d5:fd60 with SMTP id
 g24-20020a2e9e58000000b002ac78d5fd60mr6773953ljk.9.1687216688617; Mon, 19 Jun
 2023 16:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230620083005.5660d209@canb.auug.org.au>
In-Reply-To: <20230620083005.5660d209@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 19 Jun 2023 18:17:57 -0500
Message-ID: <CAH2r5msDxud4GWx28vUM1Xe=8Z9DMKHWSK3oZm+O17q3LV+N7Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed

On Mon, Jun 19, 2023 at 5:30=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   a1fc457f016e ("SMB3: Do not send lease break acknowledgment if all file=
 handles have been closed")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve
