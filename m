Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A0566C24F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjAPOhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAPOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:37:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972058289;
        Mon, 16 Jan 2023 06:16:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 141so19773625pgc.0;
        Mon, 16 Jan 2023 06:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLAmxtbvbkDxW+iBsIugh8S7b5E8nXWQC/fzzGTrlWA=;
        b=D3nWBw6wsGTazWT6xL2kTEetRM6eQ7cpaqSyDIC/zfBGtFONTuOK6eAS0VDGk+/KFB
         reS/be7U+RTU7Xq1MW/YxdaLyEy0fLm9pubp3F+rUZTJcYSkIphuGblldQgR+3B+wPFd
         XxQSnPTi5rvI6hM1FOb57Nbwckc5a0w0G2p6MEkx7/9/t3URdUbbt4ErbaN7h/Y7pZSP
         fxFG/f+hgfoEwJ4hUXeztPilPMzEfNqHyVC+pnP3IsXYCcbv/qVLArA2WRoclicmn2wa
         XPmQaX4vNtIHkehHH4uz23oIlv5a8pAt3Rii4su0ukfBO63F7XtzlRNx36wIOuc5VJhG
         M4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLAmxtbvbkDxW+iBsIugh8S7b5E8nXWQC/fzzGTrlWA=;
        b=AJGuxvBNmL2LYIWhO78/ba7dogiF2/V73u6LXzaPDdadYaNRKRlD25Vk+JMOAWxR0h
         sZs5OM1AcyLxo1sga1aiCShqyH0Ys7uLU2yBaGRbKbcGVyX61WBPZRR89+wCqUGsaSzG
         fQ5XRgIk0AjQaNrCSPDYpqIncRYQ/HgCy+jWiVaFHjNFE4LRSnmjocnYw6eOwUmylJpC
         EXtk66OdPpAfqB06CWxZLFwYsD+TsAWQL2eNOApLTfPUiPy2Q1TNebEqYCNMXVTmrGn4
         LOXSfdnUl58g4AYqMIZHtFLGaZkfre6fWgthGjXfktFCcqFsxSYCMSTDz6OdYGZJkvgf
         Oliw==
X-Gm-Message-State: AFqh2kqhG1zFxBiAVzXH5kTpP4FK+xB0u/Xncp+Yef8bvYdP6c1yrC0b
        OGwrHbJ+68xtWLlJN6RebPv+LhW0TrTDB8Q9mJE=
X-Google-Smtp-Source: AMrXdXsUpoS09bzHoL5jMxwjB5R9+SnTJwiJglkoi7GkJe8ks1MVTbTsf3nEy4kcF/dLw1QKQ+UjVaI8RblKfhS/ZuI=
X-Received: by 2002:a05:6a00:2382:b0:588:f646:fb3e with SMTP id
 f2-20020a056a00238200b00588f646fb3emr2457194pfc.53.1673878597997; Mon, 16 Jan
 2023 06:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20230113211151.2314874-1-andreas@kemnade.info>
In-Reply-To: <20230113211151.2314874-1-andreas@kemnade.info>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 16 Jan 2023 08:16:26 -0600
Message-ID: <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 3:12 PM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> OMAP processors support 32 channels but there is no check or
> inspect this except booting a device and looking at dmesg reports
> of not available channels.
>
> Recently some more subsystems with DMA (aes1+2) were added filling
> the list of dma channels beyond the limit of 32 (even if other
> parameters indicate 96 or 128 channels). This leads to random
> subsystem failures i(e.g. mcbsp for audio) after boot or boot
> messages that DMA can not be initialized.
>
> Another symptom is that
>
> /sys/kernel/debug/dmaengine/summary
>
> has 32 entries and does not show all required channels.
>
> Fix by disabling unused (on the GTA04 hardware) mcspi1...4.
> Each SPI channel allocates 4 DMA channels rapidly filling
> the available ones.
>
> Disabling unused SPI modules on the OMAP3 SoC may also save
> some energy (has not been checked).

Tony,

Would it make sense to make this default in the omap3.dtsi file and
enable them in the individual boards that need it?

From what I can tell the following use mcspi1:

logicpd-som-lv.dtsi
logicpd-torpedo-som.dtsi
omap3-evm-common.dtsi
omap3-ldp.dts
omap3-n900.dts
omap3-pandora-common.dtsi
omap3-tao3530.dtsi

The following use mcspi2:
omap3-lilly-a83x.dtsi

mscpi3 is used on:
omap3-tao3530.dtsi

and mcspi4:
omap3-n900.dts

In theory that would save a bunch of boards duplicating the disabled
status if they were to all follow suit.

I was looking into doing something like that for the mmc drivers on
various OMAP3 boards while disabling it on the omap3.dtsi. It seems
like some drivers are disabled by default (dss, ssi, mcbsp)  while
others are enabled by default (i2c, spi, mmc, usb_otg_hs, gpmc,
usbhshost, and a bunch of timers).  Disabling some of these also might
help speed up boot times if less devices need to enumerate.  I am
willing to do some of that work if the idea makes sense.

adam
>
> Fixes: c312f066314e ("ARM: dts: omap3: Migrate AES from hwmods to sysc-omap2")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> [re-enabled aes2, improved commit subject line]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 87e0ab1bbe95..e0be0fb23f80 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -612,6 +612,22 @@ &i2c3 {
>         clock-frequency = <100000>;
>  };
>
> +&mcspi1 {
> +       status = "disabled";
> +};
> +
> +&mcspi2 {
> +       status = "disabled";
> +};
> +
> +&mcspi3 {
> +       status = "disabled";
> +};
> +
> +&mcspi4 {
> +       status = "disabled";
> +};
> +
>  &usb_otg_hs {
>         interface-type = <0>;
>         usb-phy = <&usb2_phy>;
> --
> 2.30.2
>
