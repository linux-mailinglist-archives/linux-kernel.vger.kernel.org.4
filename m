Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C16177EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKCHrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKCHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:47:06 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340FD2ACB;
        Thu,  3 Nov 2022 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667461625; x=1698997625;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRwPWrkGE7degRDri4hXYNTnqTFNSsZa5q0SiPQaUTA=;
  b=A2ZK/pcJIxXevsN3BIjF1fs3wtjKEaFLQ7peERrcnOK5gKWB3nw8AndO
   iG+uT/KTdNUXLLnEJ4jen/VNialYs0W+tviZXdJKBW307nDCDqf4nO41P
   reLXuQdkLSC6wYnLFW/SnGFJCdnPNRqCmYCi//LQzx7j2n1mzwiA2IKyH
   37v42yXVJwzmRdbVXVhL4X4VRPyGlrmNhk+dio0mtSzAAedvMkXMwR5Pv
   bDDTopuNKn1SG1KfW2/xvqL3lB7nKRbnhU1dS3XPtqYqC+eD4WkrD1s4Y
   JTXkoVApYcGTPXvvwG95hTiec1VxFXzsh5fwuZnZgkEQjn+CbCDGI2iLQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27125458"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Nov 2022 08:47:02 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Nov 2022 08:47:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Nov 2022 08:47:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1667461622; x=1698997622;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=cRwPWrkGE7degRDri4hXYNTnqTFNSsZa5q0SiPQaUTA=;
  b=jG4qNGDicOAsZKHjaqo1RtWVOnk7Sg6OEfKudFXSye7e1JMTSmxI3ZVl
   QC+DCn6RnRS2+wBnI2VHYZNAKZmsr7zJr7E+o8r9TC1yBP9qQF87v2pqG
   hbrkt7uL5cyM3XtyNuNSgpb/AaW8TdKkwL2RQ1QK+odYeS53dEfK7UpfN
   7Hsccwla4QvbUEC1z3f2GR3IMe7lkuYUkxhPGyHgGLToeqfnXEFExH1z1
   MDKmAwIyYiJHzaXt3dFATeUqKh1xQrgp2tG0kysBX5NZav2jk1BdbROlW
   nDe4i9D7WGECE0t5bXBesJmHOe9SIUn1wMMCQzWs6265abfS9uFMr9mO1
   A==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="27125456"
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Enable dual-role switching
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Nov 2022 08:47:01 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A1271280056;
        Thu,  3 Nov 2022 08:47:01 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philippe Schenker <dev@pschenker.ch>
Date:   Thu, 03 Nov 2022 08:46:58 +0100
Message-ID: <4964263.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221102155226.51587-1-dev@pschenker.ch>
References: <20221102155226.51587-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Am Mittwoch, 2. November 2022, 16:52:26 CET schrieb Philippe Schenker:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> The Colibri standard provides a GPIO called USBC_DET to switch from
> USB Host to USB Device and back. The Colibri iMX6ULL does have the SoC
> ball USB_OTG1_VBUS connected in series with a capacitor to ground.
> 
> This means that we need to provide to the extcon framework VBUS and ID
> events using the single GPIO we have. The Extcon USB GPIO driver does
> use id-gpio also for VBUS event, as in our case where vbus-gpio is
> absent.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> b/arch/arm/boot/dts/imx6ull-colibri.dtsi index 577a424b0e1d..feb1fcd9a684
> 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> @@ -24,6 +24,13 @@ backlight: backlight {
>  		status = "okay";
>  	};
> 
> +	extcon_usbc_det: usbc-det {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>; /* SODIMM 137 / 
USBC_DET */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -275,6 +282,7 @@ &uart5 {
>  /* Colibri USBC */
>  &usbotg1 {
>  	dr_mode = "otg";
> +	extcon = <&extcon_usbc_det>, <&extcon_usbc_det>;

How came you up with this double entries? Is there some documentation you need 
two phandles?
I have a problem on imx8mm (same USB host controller) where on USB device mode 
no device is attached on host side. I fixed it by using usb-role-switch 
instead [1].
But it also works on imx8mm using extcon with two phandles instead of just 
one.

Regards,
Alexander

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/
20221101093031.278241-1-alexander.stein@ew.tq-group.com/
>  	srp-disable;
>  	hnp-disable;
>  	adp-disable;




