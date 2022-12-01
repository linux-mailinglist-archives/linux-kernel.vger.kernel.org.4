Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D015263F2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiLAOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:25:24 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070F21F2DE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:25:20 -0800 (PST)
X-KPN-MessageId: e0c39b2a-7183-11ed-be70-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id e0c39b2a-7183-11ed-be70-005056aba152;
        Thu, 01 Dec 2022 15:24:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=x0Smebnf5TxeVaY4P4m+XdlW9/dcq0V22p+rTifwwpw=;
        b=I0N9XZo8BorG3+28MFugns+vBm3M22ZxS+DbR6q4zPkBdvTQqaq4W+Wyxthl8WFcLTRyfz4umc607
         hfTH6is+uFBiuJZRtTjHJrbemSlq6+gYBDYK4oXNjZR2Pm9S1fagp73u76j94DtAWZ24XH1qv5Ac1q
         h1Y0KS+cimpY6wdTzHiqaGexM2d5KfExZA0GCFqwTttwopFc0/CeK2KupjhMYlNfIcd3x78eVTGEAp
         Otqm6UgqkiCJozlkNDxJMBPa/G0ZhVI/l9yRSvzNKC9JqrnpEdp8rPmSdp+BjlaQQXBEpWTC2rqUHJ
         Vvi46lxNDUVY0v/G8ELF7lINDMbc9YA==
X-KPN-MID: 33|RnuDBWKoOaDHr5WOt8Abx6wgvvKHloXXr/SyvV/YdX1xlF5I7zXryvYbX0wY/zH
 F/Q86XAbgi0dPpZVMSonWmSswAM6R5dkT7Ze6TorLOAY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RiFza7j0OV5VYQ8PaJpConECk/cNuWv9/x3CVtZKOYihro0cSycjhcjCiGm7gXn
 hHi8j/Lc5ltPh3Dj19B8hgA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id f96e0c46-7183-11ed-9ebc-005056ab7584;
        Thu, 01 Dec 2022 15:25:16 +0100 (CET)
Date:   Thu, 01 Dec 2022 15:25:15 +0100
Message-Id: <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        alyssa@rosenzweig.io, sven@svenpeter.dev, marcan@marcan.st,
        akihiko.odaki@daynix.com
In-Reply-To: <20221201103651.27807-1-akihiko.odaki@daynix.com> (message from
        Akihiko Odaki on Thu, 1 Dec 2022 19:36:51 +0900)
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
References: <20221201103651.27807-1-akihiko.odaki@daynix.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> Date: Thu,  1 Dec 2022 19:36:51 +0900
> 
> u-boot overrides stdout-path so that it points to /chosen/framebuffer
> with some condition.
> > arm: apple: Point stdout-path to framebuffer when keyboard present
> >
> > Unless you have a spare Apple Silicon machine, getting access to
> > the serial port on Apple Silicon machines requires special
> > hardware. Given that most machines come with a built-in screen
> > the framebuffer is likely to be the most convenient output device
> > for most users. While U-Boot will output to both serial and
> > framebuffer, OSes might not. Therefore set stdout-path to point
> > at /chosen/framebuffer when a keyboard is connected to the machine.
> https://github.com/AsahiLinux/u-boot/commit/a609353e82fd757b7635d18ed6a0828fff657d59
> 
> Perhaps it made sense to specify serial0 as stdout-path when the
> framebuffer and keyboard support was inmature, but today it is
> preferrable to use /chosen/framebuffer instead of serial0 for the
> console in the most cases as the u-boot change states.
> 
> Remove stdout-path to allow the kernel to choose the appropriate
> console. For Linux, it will be VT, which will be eventually backed by
> the framebuffer, if it is enabled. Otherwise, it will fall back to the
> serial.

U-Boot still relies on serial being the default.  It will not touch
stdout-out when running under the m1n1 hypervisor for example.  The
m1n1 hypervisor emulates the serial port hardware and developers rely
on this quite heavily.  Also, U-boot will only switch to the
framebuffer if a keyboard is connected.  This is currently disabled in
the builds for Asahi Linux because the type-A USB ports are not
supported yet in U-Boot.  But the plan is to fix that eventually.

So as far as I am concerted NAK.

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 2 --
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 2 --
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      | 2 --
>  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      | 2 --
>  4 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> index 5547f5e7ac5a..14b6bf234f82 100644
> --- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> @@ -30,8 +30,6 @@ chosen {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		stdout-path = "serial0";
> -
>  		framebuffer0: framebuffer@0 {
>  			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>  			reg = <0 0 0 0>; /* To be filled by loader */
> diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
> index 7c207b1df949..22e96b436bf2 100644
> --- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
> @@ -28,8 +28,6 @@ chosen {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		stdout-path = "serial0";
> -
>  		framebuffer0: framebuffer@0 {
>  			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>  			reg = <0 0 0 0>; /* To be filled by loader */
> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> index 3c5da0e5a41d..d2483f618d44 100644
> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> @@ -27,8 +27,6 @@ chosen {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		stdout-path = "serial0";
> -
>  		framebuffer0: framebuffer@0 {
>  			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>  			reg = <0 0 0 0>; /* To be filled by loader */
> diff --git a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
> index b6b815d93c3e..af4153dcb55d 100644
> --- a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
> @@ -22,8 +22,6 @@ chosen {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		stdout-path = "serial0";
> -
>  		framebuffer0: framebuffer@0 {
>  			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>  			reg = <0 0 0 0>; /* To be filled by loader */
> -- 
> 2.38.1
> 
> 
> 
