Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE369DD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjBUJoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjBUJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:44:16 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A87241E7;
        Tue, 21 Feb 2023 01:44:12 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id bt6so3771554qtb.4;
        Tue, 21 Feb 2023 01:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCnM9wXqkmlFB6XnS3dzL0q9gjTVsqjq14K4eWvtVZg=;
        b=Nw9IxtCEXDvwEZvbD/aDwTiMVLbCtx8YXxbzE9dHEezq5UUlIqoAECJcE/MqhdzQb4
         M+soudesqmvm4lbYVynSo5ouY2ESLIcJ1knntEBJqx6865Q3WRLgNBNQJ46jwGsVan/w
         WPBeAqX1KKaE3P3rz9JTp6pFWLZwVbD1RqtaEgRTpa7McucfvDbB/2Pg3tN8AM1BGemI
         kE7SkEry6TwIS633BxpddpH55pes4ObJXjD8IYdYbTb0kaZHx+i0hnTUqleurAL8Db1g
         CYLr3YHiQadSOoDGt++7dvh+bsogAkmeINGpHA+Ir3yIvkrGo3EJmnD65tClqdO1mXBp
         sbmQ==
X-Gm-Message-State: AO0yUKVZe7mexwIy2OWwQYxdjwY4AQpV1x32r+iX8yuh1mJWehN532h2
        0cVNLpmXEb618OjZQmwrY6i2zGXpBDM0qQ==
X-Google-Smtp-Source: AK7set8Jzc01sdrswJREkxD3EmcR5f9hxxyMDyo2+Zn28PtYd+zrgG2wCsxz7Mot4825XGtXy9zJbA==
X-Received: by 2002:ac8:594b:0:b0:3b4:79f8:26c3 with SMTP id 11-20020ac8594b000000b003b479f826c3mr8439258qtz.33.1676972651355;
        Tue, 21 Feb 2023 01:44:11 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s204-20020a3745d5000000b0071b368cf074sm1593926qka.118.2023.02.21.01.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:44:10 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id d14so4038041ybn.2;
        Tue, 21 Feb 2023 01:44:09 -0800 (PST)
X-Received: by 2002:a05:6902:2d0:b0:920:2b79:84b4 with SMTP id
 w16-20020a05690202d000b009202b7984b4mr1039329ybh.386.1676972649696; Tue, 21
 Feb 2023 01:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20230214124001.5f5341b4@canb.auug.org.au>
In-Reply-To: <20230214124001.5f5341b4@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 10:43:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXC2n9dg=D4QqJQzv6cnk-WpUUSZXby-umdtGkU8fmF_A@mail.gmail.com>
Message-ID: <CAMuHMdXC2n9dg=D4QqJQzv6cnk-WpUUSZXby-umdtGkU8fmF_A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Feb 14, 2023 at 2:47 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the usb tree got a conflict in:
>
>   arch/arm64/configs/defconfig
>
> between commit:
>
>   85d81e15862a ("arm64: defconfig: Enable DisplayPort on SC8280XP laptops")
>
> from the qcom tree and commit:
>
>   1f6d59f7f82d ("arm64: defconfig: Enable UCSI support")
>
> from the usb tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for your resolution!

> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@@ -960,7 -946,8 +961,9 @@@ CONFIG_TYPEC_TCPCI=
>   CONFIG_TYPEC_FUSB302=m
>   CONFIG_TYPEC_TPS6598X=m
>   CONFIG_TYPEC_HD3SS3220=m
>  +CONFIG_TYPEC_MUX_GPIO_SBU=m
> + CONFIG_TYPEC_UCSI=m
> + CONFIG_UCSI_CCG=m

CONFIG_TYPEC_MUX_GPIO_SBU=m should be last, cfr.
drivers/usb/typec/Kconfig:source "drivers/usb/typec/ucsi/Kconfig"
drivers/usb/typec/Kconfig:source "drivers/usb/typec/mux/Kconfig"

>   CONFIG_MMC=y
>   CONFIG_MMC_BLOCK_MINORS=32
>   CONFIG_MMC_ARMMMCI=y

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
