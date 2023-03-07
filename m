Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FED6AD8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCGIQj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 03:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCGIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:16:32 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A1B50997;
        Tue,  7 Mar 2023 00:16:31 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id c18so13526454qte.5;
        Tue, 07 Mar 2023 00:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjZIlXQTpJ24PjO5Zb7phOIg9/5X/qOSvWi0SXZ0qlg=;
        b=cWJYXA8g2I9BMvqLFQTJktFLE0djSfaQD338DLADU+XFxwafja68e7wdmc4yQ1yckb
         tulKhBIcgZwYJ2CVNn30vXA349qT8L9XYo1ZDcmX/EzNIezT1avylhMBCcYrnGPKSnch
         H/84elGIBd/+8ynnkyLtlp4/RBfd5c9V+EnzocndWwhO5cG2oqlRzbiqw2JM6f1TXLlv
         vauIig8reNow6GqCaGQw+SANdPAm5Dv1/YfVnEUhnqeL2yJc0JJtmtO9VBfE5Pn4qnYm
         STy6kqEqSfnuyfrAYSIWIDDFT+aBejtpEjtsko0gnAgCkQtv0W/nh5k8m7d74npRMc1z
         tz/A==
X-Gm-Message-State: AO0yUKXD5vXmC4luBGdV/213Ud/QQRSTo669Ql0mg4D7e9YcUR5dbgXA
        ozXNXrXamivaS3bsmi0oDmpuD3lyHrsjYQ==
X-Google-Smtp-Source: AK7set/q89VBoBwSUxxrPgcoIGi81XAI2rtm+SJ0GrPhnuL13aqHOpDXwEliwQK24YXbclySAJnQ5w==
X-Received: by 2002:a05:622a:15ce:b0:3b8:6442:2575 with SMTP id d14-20020a05622a15ce00b003b864422575mr23256946qty.49.1678176990249;
        Tue, 07 Mar 2023 00:16:30 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a138600b003b63a734434sm9411780qtk.52.2023.03.07.00.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:16:29 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-53852143afcso231552817b3.3;
        Tue, 07 Mar 2023 00:16:28 -0800 (PST)
X-Received: by 2002:a81:af0c:0:b0:52f:1c23:ef1 with SMTP id
 n12-20020a81af0c000000b0052f1c230ef1mr8939020ywh.5.1678176988688; Tue, 07 Mar
 2023 00:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20230307075923.28821-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230307075923.28821-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Mar 2023 09:16:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV1eYWhDKwTAxC32Qp0CcxrWxgu=uRNTdu_G8K=gHS9Yw@mail.gmail.com>
Message-ID: <CAMuHMdV1eYWhDKwTAxC32Qp0CcxrWxgu=uRNTdu_G8K=gHS9Yw@mail.gmail.com>
Subject: Re: [PATCH] arch: sh: remove references to config USB_OHCI_SH
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Tue, Mar 7, 2023 at 9:02 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") left some
> references to the config USB_OHCI_SH in ./arch/sh/ around, expecting those
> to be removed with the whole SH architecture deletion.
>
> As that did not happen, do minor clean-up instead and remove the references
> to the removed config USB_OHCI_SH instead.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for your patch!

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -326,7 +326,6 @@ config CPU_SUBTYPE_SH7720
>         select CPU_SH3
>         select CPU_HAS_DSP
>         select SYS_SUPPORTS_SH_CMT
> -       select USB_OHCI_SH if USB_OHCI_HCD

Shouldn't this select USB_OHCI_HCD_PLATFORM instead, as the (now
removed) Kconfig help text for USB_OHCI_SH used to say?

    +       select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD

I completely forgot I already made that comment before, cfr.
https://lore.kernel.org/all/CAMuHMdVM3BpvVD3c4gp1OidnwF5zFd4MJecij7zWBnahzNaSNw@mail.gmail.com

The same is true for the three selects below.
As USB is now broken, the proper solution will need
Fixes: 4f6dfc2136fb2e8d ("usb: remove the dead USB_OHCI_SH option")

>         select PINCTRL
>         help
>           Select SH7720 if you have a SH3-DSP SH7720 CPU.
> @@ -336,7 +335,6 @@ config CPU_SUBTYPE_SH7721
>         select CPU_SH3
>         select CPU_HAS_DSP
>         select SYS_SUPPORTS_SH_CMT
> -       select USB_OHCI_SH if USB_OHCI_HCD
>         help
>           Select SH7721 if you have a SH3-DSP SH7721 CPU.
>
> @@ -425,7 +423,6 @@ config CPU_SUBTYPE_SH7757
>  config CPU_SUBTYPE_SH7763
>         bool "Support SH7763 processor"
>         select CPU_SH4A
> -       select USB_OHCI_SH if USB_OHCI_HCD
>         help
>           Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.
>
> @@ -451,7 +448,6 @@ config CPU_SUBTYPE_SH7786
>         select CPU_SHX3
>         select CPU_HAS_PTEAEX
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> -       select USB_OHCI_SH if USB_OHCI_HCD
>         select USB_EHCI_SH if USB_EHCI_HCD
>         select PINCTRL
>
> diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
> index f10fb730b6f4..cd404818e33f 100644
> --- a/arch/sh/configs/sh7757lcr_defconfig
> +++ b/arch/sh/configs/sh7757lcr_defconfig
> @@ -58,7 +58,6 @@ CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_SH=y
>  CONFIG_USB_OHCI_HCD=y
> -CONFIG_USB_OHCI_SH=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHI=y

This part is fine.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
