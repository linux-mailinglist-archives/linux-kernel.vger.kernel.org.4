Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FC6489F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLIVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLIVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:20:09 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDAB4E15
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:20:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 65so4575735pfx.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7BYSJsyYbjfUSGto8PSIeWcxdhQleYdsTdMfBA5rws=;
        b=poYdTDQKQ+ROqrDeu33rphBnUYHE36o3J4O2/FZpPVcfSspcGclae9TpsGfhyYWhjQ
         4YwNOph218hSnfjvOl1wL5TBw0fJzOOEBW+Src+idIoyG+T9csEXq/70CKPw3wErkO5r
         z6zACaCkskUz6r7Sni9s0/wpC3nxmsnQd2ktAukR6cx+iRj1bo4gD0A3oPkJR+H+py6K
         y/bOvkOKQDu7lG7Byw5tYUTKflkKOWvvfqA1FhUsJ/MPewau+YMZk1XLXRYX/xRpeQ+g
         oAp1V9eLurl6VehkrIxrxfYkSvBfRjblCtSI7ndTZxswL7UI4IyEAEve3FljlLh/isCt
         DS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7BYSJsyYbjfUSGto8PSIeWcxdhQleYdsTdMfBA5rws=;
        b=6MlQsP/c0dsGfeuiPUGP5dYRKP1RPBC6oAOKIc+h/9Iacnk7zkuqdw2SE8xB3TJ4ZI
         JmFJaIva6ncbaKUbclg0shTVmel9+lOKnokun0dD9mN8rnxWWvSWvFGgadQf1S0DQV3y
         lQrOX7agCx8bADmTgc9onCSHAjPx4OaNLmJwS3ojNBIeDbAwTac9mCs4+7qbhrl146Px
         RwOnOrnr/PNFMyYVfpH0i6G4F6lmTM9E/2UXVik6tgTg1pt4f/EDFpbKVCP3Zt+R+K3W
         s5FHCUa+ojGqRZvhfQVlb4zp5KfezC+7PGPnyTWwcH6V4pbg4LrAZKChhTQMrv2CSkMu
         g+2w==
X-Gm-Message-State: ANoB5pnjnR3KEO4vBZPbBbsNr0iqQoaNGe13lmXVjyFb/R3AXL9Z6/PU
        kFduF9CweGj9KkG7cTqi2/BgPcL45XCg3zBRtvw=
X-Google-Smtp-Source: AA0mqf6sEubPuERGkwWEOObIj21HTGq7DSfivpf0d8UFwNoO2hH1b2bSt0fj9k/MZR8E0SMuqumrwGc7UqrHdrGHvzI=
X-Received: by 2002:a63:e444:0:b0:477:6a3a:e614 with SMTP id
 i4-20020a63e444000000b004776a3ae614mr69123199pgk.81.1670620807481; Fri, 09
 Dec 2022 13:20:07 -0800 (PST)
MIME-Version: 1.0
References: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
 <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com> <202208091600.D19DFF9C7D@keescook>
 <CAC=U0a3F6172JH+xvA0pSb0bewu_0PX9XFKmL32ge+KyTOdaZA@mail.gmail.com> <202212071412.1B1BF97@keescook>
In-Reply-To: <202212071412.1B1BF97@keescook>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 9 Dec 2022 16:19:56 -0500
Message-ID: <CAC=U0a20oYLjh_m3N2oUpEGhVZTyARKn_rTgwscTG0HdCZU_Tg@mail.gmail.com>
Subject: Re: Invalid pstore_blk use?
To:     Kees Cook <keescook@chromium.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
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

Kees,

Thanks for your reply. I will send the RFC patch.

Kamal

On Wed, Dec 7, 2022 at 5:13 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 18, 2022 at 03:41:44PM -0500, Kamal Dasu wrote:
> > Kees,
> >
> > I am in the process of implementing  mmcpstore  backend for mmc  based
> > on the mtdpstore driver
> >
> > This is what is registered with register_pstore_device(&cxt->dev);
> > cxt->dev.flags = PSTORE_FLAGS_DMESG;
> > cxt->dev.zone.read = mmcpstore_read;
> > cxt->dev.zone.write = mmcpstore_write;
> > cxt->dev.zone.erase = mmcpstore_erase;
> > cxt->dev.zone.panic_write = mmcpstore_panic_write;
> >
> > # dmesg | grep pstor
> > [    0.000000] Kernel command line: pstore_blk.blkdev=/dev/mmcblk1p8
> > crash_kexec_post_notifiers printk.always_kmsg_dump
> > [    1.993986] pstore_zone: registered pstore_blk as backend for
> > kmsg(Oops,panic_write) pmsg
> > [    2.002582] pstore: Using crash dump compression: deflate
> > [    2.008133] pstore: Registered pstore_blk as persistent store backend
> > [    2.020907] mmcpstore: /dev/mmcblk1p8 size 131072 start sector
> > 34468 registered as psblk backend
> > [   17.868753] psz_kmsg_recover_meta: pstore_zone: no valid data in
> > kmsg dump zone 0
> > [   18.298933] psz_recover_zone: pstore_zone: no valid data in zone pmsg
> > [   18.305398] psz_recovery: pstore_zone: recover end!
> >
> > The driver is successfully registered and the read path works when
> > /sys/fs/pstor is mounted , however mmc_pstore_panic_write is not
> > called.
> > Need help in understanding what could be missing. I am using the
> > latest upstream kernel for testing.
>
> Hi!
>
> Can you send an RFC patch? I'd expect this to work as you've currently
> described it, but without code I'd just be guessing. :)
>
> -Kees
>
> --
> Kees Cook
