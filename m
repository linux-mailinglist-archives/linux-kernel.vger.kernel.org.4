Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8922D643678
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiLEVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiLEVHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:07:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9436CC27;
        Mon,  5 Dec 2022 13:07:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c66so11293103edf.5;
        Mon, 05 Dec 2022 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YyjWNhacttlG/+fLR1iZBtdi1pM5GJQVC7qwybysfY=;
        b=b5OX02cg7SErXkv4WY3gJwWSacUK9wlUWppABaoFuNN+gGzLCR6G0TWPiizgWwbRiH
         4JnzvXpCbRbY+6kR8rzADqQ9u91D76LD794OjSyevq3Z8M5erx8f+VjYMhhMW70obv2k
         gi1rzWHjW2ROOIpiBPdqsArA6dMyQMMFOA5W7LDUR5bECF4xg7XC64dDtQEmQWthN4L2
         Lcl3ugi1seZewMO0N0Zzjs0NWsbLomjuwsyylLroCl0b9io5Fu5Tte/FW+wxvtXLTSzH
         V5qfhCyLEasVrbKquMyUxCXTmbwhU/AW86pvoRyHeqBY8PN9DZX97OusD12jBFMhNVJc
         KE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YyjWNhacttlG/+fLR1iZBtdi1pM5GJQVC7qwybysfY=;
        b=nyRyXW9xasgakVgRgRTomWRDqffSknWz3k+nVNisCrRXCofTKioE2+f3DM9prreWcl
         3XkxRwIO4RnjG0vU72F8uAtP2cruqJqFrQsKOhLVGHEV+Tl0lVa0EXv2A/oSuB6no+kN
         rRa2SwaAR0oY9yvcvJluyw8KUF6DKQm5BHpaKjS+LGyLsyb4cNCa3IhzqT4eHSeJoATd
         SNhT3l5ilns6fVN64zkbM1IKYR4kmaCvLRrtkiILf/GCIKdKuM2kZy5fHVd770PWjAxJ
         k6wEjJBcGfp0WvBw6NJtfaPrOjMMDsqAmrmSWXKxcpkbMEmz0dX+BXbq/rtGSpaZHutz
         mYhg==
X-Gm-Message-State: ANoB5pkAgGd5QUvG7HspLU9MZXj7TfJs6AjISR1OcDzTTH+Lin33Ls+T
        gWbyWzVHiNy59f3IGnHqx6g=
X-Google-Smtp-Source: AA0mqf5XnFwWpw+Bq5wUA3Blf/UMVsZH5iz85hcQ0084cyKJEKCGzQLnnYAQrR5En+CrMn2lauzzNQ==
X-Received: by 2002:a05:6402:1c1a:b0:46c:74f0:c064 with SMTP id ck26-20020a0564021c1a00b0046c74f0c064mr8969352edb.85.1670274442174;
        Mon, 05 Dec 2022 13:07:22 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0045723aa48ccsm206135edb.93.2022.12.05.13.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:07:21 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH 1/2] ARM: dts: sunxi: Fix GPIO LED node names
Date:   Mon, 05 Dec 2022 22:07:20 +0100
Message-ID: <2324364.NG923GbCHz@kista>
In-Reply-To: <2979be86-e561-e5ff-b348-367a7c20fab1@sholland.org>
References: <20221125195401.61642-1-samuel@sholland.org> <20221125214050.711997f1@slackpad.lan> <2979be86-e561-e5ff-b348-367a7c20fab1@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Dne petek, 25. november 2022 ob 22:50:07 CET je Samuel Holland napisal(a):
> Hi Andre,
> 
> On 11/25/22 15:40, Andre Przywara wrote:
> > On Fri, 25 Nov 2022 13:54:00 -0600
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > Hi Samuel,
> > 
> >> These board devicetrees fail to validate because the gpio-leds schema
> >> requires its child nodes to have "led" in the node name.
> >> 
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > 
> > That looks alright, though the comment in the binding says that we
> > should just have led-0, led-1 instead, so just (hex) numbers. The
> > "status" name is also in the label, so we wouldn't lose information.
> 
> I am not a fan of giving the LEDs meaningless enumerators, but I can do
> that if the maintainers insist.

I'm not a fan of that either, but binding really wants enumerator. So let's 
conform to that.

Best regards,
Jernej

> 
> > Actually, also "label" is deprecated, in favour of "color" and
> > "function", shall this be fixed on the way? Or is there anything that
> > breaks (older kernels) when removing the label property?
> 
> The label is exposed to userspace as the path in sysfs, so we cannot
> change it. There is no way to construct that exact label using function
> and color -- see led_compose_name().
> 
> Regards,
> Samuel
> 
> >> ---
> >> 
> >>  arch/arm/boot/dts/sun5i-gr8-chip-pro.dts | 2 +-
> >>  arch/arm/boot/dts/sun5i-r8-chip.dts      | 2 +-
> >>  arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> >> b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts index
> >> a32cde3e32eb..3222f1490716 100644
> >> --- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> >> +++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> >> @@ -70,7 +70,7 @@ chosen {
> >> 
> >>  	leds {
> >>  	
> >>  		compatible = "gpio-leds";
> >> 
> >> -		status {
> >> +		led-status {
> >> 
> >>  			label = "chip-pro:white:status";
> >>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
> >>  			default-state = "on";
> >> 
> >> diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts
> >> b/arch/arm/boot/dts/sun5i-r8-chip.dts index 4bf4943d4eb7..303191c926c2
> >> 100644
> >> --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> >> +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> >> @@ -70,7 +70,7 @@ chosen {
> >> 
> >>  	leds {
> >>  	
> >>  		compatible = "gpio-leds";
> >> 
> >> -		status {
> >> +		led-status {
> >> 
> >>  			label = "chip:white:status";
> >>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
> >>  			default-state = "on";
> >> 
> >> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> >> b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts index
> >> 0af48e143b66..b84822453381 100644
> >> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> >> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> >> @@ -67,7 +67,7 @@ hdmi_con_in: endpoint {
> >> 
> >>  	leds {
> >>  	
> >>  		compatible = "gpio-leds";
> >> 
> >> -		status {
> >> +		led-status {
> >> 
> >>  			label = "sina31s:status:usr";
> >>  			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* 
PH13 */
> >>  		
> >>  		};


