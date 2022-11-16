Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1063C62B338
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKPGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiKPGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:23:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B921582D;
        Tue, 15 Nov 2022 22:23:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so27980027lfv.2;
        Tue, 15 Nov 2022 22:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsr7OsB8wB98rNVEI9QRhf9lR0zwcVT6qNdfdodmdlw=;
        b=mfFlllbzPTyEVyif9qC2QIPaMpl/raWnKGEqr6DAtzKsGd1nv8m9sjTqdFOG40jo0K
         dgwz3yBugrdHu1TDYzpVyGtURkhUSdhi14BRZj6HLjhoUzi+PO+FuAFrr2qDZ7M/9hrf
         Ue7U+4591f3hhlewOHxulJsPuoF+PDz/W9opqmaH52zhZln1l9s5jlta+SrjzQO/lm9N
         8820F719epsY1B3vX+cfYiucNQOhTIYlTovlgRGGnAX5Ba3uwjKcQguq47Sso+2lMeOj
         fOJFUMG/lTzg/Owh/oMf24+0/HcuVjFoHYCE0HyAlX+m/M/n0BLmV0r//IeV57KgVyd3
         DnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsr7OsB8wB98rNVEI9QRhf9lR0zwcVT6qNdfdodmdlw=;
        b=LyXUSBmtMGXtuJPHRCECQJ2tCXyF49JwdYkpkhtCvUiD/SZycApIz7MK1F73qHDJaR
         bTlKdyGppeJ5YfWEqLfmn0V3EnVGs41c7m+Z5ThoQeMk6RD9doH4NVJRJ/ABMTPWz3Uw
         MAqthXSIs84lqgfETduiqZsfbS1zsLnqAlG1kc8ybD6ovh9wfiT6fipGRUSVE9YJCr1L
         389a8DedF0rHbE/9Y4Vhi28LQPYSUeLBXs+3+ztPM6G+14P7tvVaq5Zm+Fwy0AT9MD4w
         3yulsS5b5NUfUXSMMEeTWyxu33Vk2U3DVIF84WqKK85yXAdNmP9iW5ukjacmdSZqKVl5
         st0A==
X-Gm-Message-State: ANoB5pnkfD7gkd3TGUyk9WWq2P3D8wnAmkqYG+Gf5IEhA3fkgYGus5zB
        qn3xSS7RZyp3yc87ve6T44qHleuBDcTMTDL0oE0=
X-Google-Smtp-Source: AA0mqf5hlPGejSK5eNDPIzypAZth5+Edami5qB75CSiwQJvI62yZWoxUrqui61+XJGYexg2ogWzR3m8Bno+az1U18a0=
X-Received: by 2002:a05:6512:1115:b0:4a2:3924:de36 with SMTP id
 l21-20020a056512111500b004a23924de36mr6620878lfg.663.1668579784635; Tue, 15
 Nov 2022 22:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20221116074146.6e7cbce9@canb.auug.org.au>
In-Reply-To: <20221116074146.6e7cbce9@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 16 Nov 2022 00:22:52 -0600
Message-ID: <CAH2r5muADC_ow81cGPppTQ2zuMHvB_7aadb2WAbyZFFD7ELi0g@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updated Fixes tag for that commit in cifs-2.6.git for-next

On Tue, Nov 15, 2022 at 2:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   9898f0456aa3 ("cifs: Fix wrong return value checking when GETFLAGS")
>
> Fixes tag
>
>   Fixes: 64a5cfa6db9 ("Allow setting per-file compression via SMB2/3")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
