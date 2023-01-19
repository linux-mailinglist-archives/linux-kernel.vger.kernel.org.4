Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9767473B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjASX35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjASX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:29:52 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A659CF;
        Thu, 19 Jan 2023 15:29:51 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JNTcAG086208;
        Thu, 19 Jan 2023 17:29:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674170978;
        bh=pv/BJBZQWuA5pZ5fIapkG0QMcRukkJ5Acn8LQFjIHIY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=m2LACbCZ4PWduLizBigw9Y7L9kyP8ymvQ3oeflgZvFYBdsWlZZpaUPyseJ6jE5yI7
         43JIXMy5bXIZDPEsvX896Dw5qgSnuwVD5wuL/M07p3xC+ciOc3nXrxXocj3/ctX9Rq
         IIzjh43izHG8iZgk0WysyELY4L04AUIj/nVlkwsw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JNTcDG024170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 17:29:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 17:29:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 17:29:38 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JNTcYP003617;
        Thu, 19 Jan 2023 17:29:38 -0600
Date:   Thu, 19 Jan 2023 17:29:38 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-am62a-wakeup: add VTM node
Message-ID: <20230119232938.n5qh5qb4mj6xdv6w@bryanbrattlof.com>
References: <20230119221322.12563-1-bb@ti.com>
 <20230119221322.12563-7-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230119221322.12563-7-bb@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK: My apologies for the noise :(

On January 19, 2023 thus sayeth Bryan Brattlof:
> The am62ax supports a single Voltage and Thermal Management (VTM) device
> located in the wakeup domain with three associated temperature monitors
> located in various hot spots of the die.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi | 47 ++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi  |  8 ++++
>  arch/arm64/boot/dts/ti/k3-am62a.dtsi         |  2 +
>  3 files changed, 57 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
>

...

> +
> +	main1_thermal: main1-thermal {
> +		polling-delay-passive = <250>;	/* milliSeconds */
> +		polling-delay = <500>;		/* milliSeconds */
> +		thermal-sensors = <&wkup_vtm0 0>;
				  ^^^^^^^^^^^^^^
This should be <&wkup_vtm0 1>

> +
> +		trips {
> +			main1_crit: main1-crit {
> +				temperature = <125000>;	/* milliCelsius */
> +				hysteresis = <2000>;	/* milliCelsius */
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	main2_thermal: main2-thermal {
> +	       polling-delay-passive = <250>;	/* milliSeconds */
> +	       polling-delay = <500>;		/* milliSeconds */
> +	       thermal-sensors = <&wkup_vtm0 0>;
				 ^^^^^^^^^^^^^^
<&wkup_vtm0 2>

> +		trips {
> +			main2_crit: main2-crit {
> +				temperature = <125000>;	/* milliCelsius */
> +				hysteresis = <2000>;	/* milliCelsius */
> +				type = "critical";
> +			};
> +		};
> +	};
> +};

Apologies for the noise again
~Bryan
