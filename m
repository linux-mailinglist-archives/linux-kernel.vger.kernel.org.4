Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840716046B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiJSNRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJSNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:17:33 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C84E402;
        Wed, 19 Oct 2022 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666184588; x=1697720588;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93p6LX+Ewu3rCVdZcsXWSNEp7EfDushKgpEKzPy47FQ=;
  b=cTcVCQJrGOvWvthlW2LIMOEY/Eq3uP5+nUptWomNwgX+bF1TUunYOtCB
   7qwff03/+kgQnuPCC7XUrexk6AAXleL3gCzy5PcH2XAQyURlMFapfJF7a
   x1AlW3OmkyB8iCVIbnlvpF6D01FuOE+Gg731Gy78SKCT/3zwiP6MKZOob
   Q1QSSzAiZS6VDpq81H6AKrEFxeWUc98QGnO78HkGL67NUdVlyyNf9bZto
   eTAdtNNulL20O23PNCsUU9u3K0PcllJroefZOg5qNaO3X0+ud0xJ2QR1Z
   CbNne9tn7WwG9cchUktMuAPEpIanFvbWaQT/2D5ISj19dMPaHC0wOwaAW
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="26842869"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Oct 2022 12:45:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 19 Oct 2022 12:45:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 19 Oct 2022 12:45:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1666176313; x=1697712313;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject;
  bh=93p6LX+Ewu3rCVdZcsXWSNEp7EfDushKgpEKzPy47FQ=;
  b=L641wtOtlNmC+t2Uqkw+LRpWIYhfg7cGAAsCvRqQAaqwB+/WCGUhSntp
   u60ot7ftL8SUt4I0OjPi3jzS6guL5fVeAD//pOS/w3+gbbv1/Fh7LCtKC
   LdhuAvM3QauGBd0BtlCqIwz5FgYr/AHzBnBXMcyryBEl3d68q3CxKj51J
   OdCqbW1UeaueZ1U6YP/fXRZjdky1KaeUFoJkaQUr+XSLlsN1L5DxG/d8V
   Bk+bLLHEw+6xEaCDn6hcm9zLlPn26snWLmI1YojULfA77vU5UlRppcYZ2
   /w2kwMzuqq3ihHGlJy0Esqz7KMhrqFA5YkbsG2GKo4Ou+ROJhTY5TnpWU
   g==;
X-IronPort-AV: E=Sophos;i="5.95,196,1661810400"; 
   d="scan'208";a="26842868"
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on Odroid
 N2/N2+
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Oct 2022 12:45:13 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C62CB280056;
        Wed, 19 Oct 2022 12:45:12 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 19 Oct 2022 12:45:10 +0200
Message-ID: <7193025.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221018195122.8877-1-linux.amoon@gmail.com>
References: <20221018195122.8877-1-linux.amoon@gmail.com>
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

Am Dienstag, 18. Oktober 2022, 21:51:19 CEST schrieb Anand Moon:
> Odroid N2/N2+ support active cooling via gpio-fan controller.
> Add fan controls and tip point for cpu and ddr thermal sensor
> on this boards.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi index
> fd3fa82e4c33..e61a4285a910 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -39,6 +39,14 @@ emmc_pwrseq: emmc-pwrseq {
>  		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
>  	};
> 
> +	fan: gpio-fan {
> +		compatible = "gpio-fan";
> +		gpios = <&gpio_ao GPIOAO_10 GPIO_ACTIVE_HIGH>;
> +		/* Using Dummy Speed */
> +		gpio-fan,speed-map = <0 0>, <1 1>;
> +		#cooling-cells = <2>;
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
> 
> @@ -410,6 +418,40 @@ &cpu103 {
>  	clock-latency = <50000>;
>  };
> 
> +&cpu_thermal {
> +	trips {
> +		cpu_active: cpu-active {
> +			temperature = <60000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map {
> +			trip = <&cpu_active>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 
THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
> +&ddr_thermal {
> +	trips {
> +		ddr_active: cpu-active {

I suspect this node name shall be 'ddr-active', not 'cpu-active'.

Best regards,
Alexander

> +			temperature = <60000>; /* millicelsius */
> +			hysteresis = <2000>; /* millicelsius */
> +			type = "active";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map {
> +			trip = <&ddr_active>;
> +			cooling-device = <&fan THERMAL_NO_LIMIT 
THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>  &ext_mdio {
>  	external_phy: ethernet-phy@0 {
>  		/* Realtek RTL8211F (0x001cc916) */
> 
> base-commit: aae703b02f92bde9264366c545e87cec451de471




