Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD66353AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiKWIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbiKWIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:54:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99998EC0B0;
        Wed, 23 Nov 2022 00:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVej/Om+kPla4fFIUFhVSWLOIH5wQY4crje8BD1wYKSFhEFSH7TG8mdh6cA/p1MP8a6bDqY+r9j0qq3YprGYNsz1pJLPDXJJYBOr6m7JdNH1CAnrh1P02V718aHocjHI98YXCoYsEe7LkdRz13N/fgwZtdicoWyvA3ybgI5Knbo1cPyzkOHKpS9HRZuh3/PxEZDzGoPdU4CpFM5plUYfRIcEoGX4C/4CjKzMnGJnWBhxxPugW3hK7wse9xK8vzvJtiDiTcWq7fBAeAbIK3DYjqcdyL1+yWsmMqlnTEGyCukAfxgWlg2ByU+uy1oAkP4KXmXbJuNkKKQi5jd69zgKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tX6bhswAUuvQIZpyMC7NuCU0J8PVnhpIp1m6IAE998=;
 b=lnRy2SRrVmBPAmo3IXVUAtPpnXoGGOA79xKXfEGkN1xHa19C6DqisdubnuB4W23Vx6qh8MWv/a83KZ/wP5mWiCXUXp0liaz2Q7f4QTtJxkHDSvxveWGBI8Fj06Hpz9Q/bfAgqritgnllqs38sqN3YpZi3tuJRR4LK1s/xa7ekFzi5TdCwwWx5WaNII0TpbfBoDjqxhGOqY4LfX+L/uNzEL7WqiyJ23hKP8Z43t4i50zUaqoERG4Mzi7JCh08MGRmnggvAt0jN+U9/VGn8fQB4fk9YjeZI6YK0FeHqeIxpptR2aRKwGtpoL2QRHjU3yiQfpUUfhOGTCO9NIU1EAKtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tX6bhswAUuvQIZpyMC7NuCU0J8PVnhpIp1m6IAE998=;
 b=gPt7T5YfK9CRzIcQt2HVLsE+NiG6dcZaCKqx/KQ41O+7tBtfOR2gZrpoXsK6nvV7CpnfztzfeytSvJhEKmeJOBhh3MNbTLbhS4E/wMEE8NDEBVbf5VTg0XoKRI6DKTN/sTxk1+SC7+slcuVTGrMLhSVG6FfVywBeRZHtJJSPfTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB7891.eurprd08.prod.outlook.com (2603:10a6:10:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 08:54:26 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%3]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 08:54:26 +0000
Message-ID: <fcf83d1e-e940-457f-8f10-fcbe877a3a36@wolfvision.net>
Date:   Wed, 23 Nov 2022 09:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv3 7/9] arm64: dts: rockchip: Add rk3588-evb1 board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com
References: <20221121175814.68927-1-sebastian.reichel@collabora.com>
 <20221121175814.68927-8-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20221121175814.68927-8-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: b87787c4-9c79-45d7-5b62-08dacd30530c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prqjhXm7DU/xKxli2qnMGTfZ9Ex8EZNHQPNCeNEnduWTXygj6+geJrXdoTWKA0XGFkXIE6fu1//O4Ykvx60YUxM+ikEQDzdgH7jidLBWi+PJe/LblxInQut17Cfj26z5/Q/ZFEIt2lHWZpjwq6f+kIQukGAqnSktVWncg77o/mytdMAshEaSNW2N7yHg/gqfsBsMzFYkGmxV/v5nOu3MJr3ajcAra76W7uB2X7ARE7QlTlAkQFSDaVPd6s1XIP7cmjesh0ZgwHAFM09DDHTumV9T9Ghw+HHEB/04GwdI6FM1E43wuIlb0cfg5DoAegeuSaVvG8J8jENY8rMXU0OW07e2f/dyysNT9Zlxci65Z7u59oJjVjCASmmMx9XdgCwzB/Kv9TzPIfnGR02+szoXMO/7EkAvmCGNnAq/dk1ZYb2SRjg5pTNUNO04/UpnGDVIfPidais0wR1+lNe3SoOkCWfWSl9+XgBTYKAvn0rikFSnC1YLb5xtEFXaKWm0UZHr02aDFdR0aNeWF5YV5YXo2kr1vOKZ84nWcpDQ3GvRmaaCCpGAbLlksKv/Fu6e+5MNsby/W2ig6EleFgAw58Vl+qRSfFRLwDC6aRmznNugrD8zlBxVeS+mP9DArnwUWh9IGgbJR2b1jAI2+TJ6hdxFxMbozm9aK8YvlDYyXQRJvMEVTKcWj/lVzl/xw+rQTmDnQkEI5whh0EpOxwN55+V/lqP6FO/mz3N/2Yp+U8Cp3mqhom6QkO4Nfc0ZcaHHcz4i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39850400004)(346002)(451199015)(5660300002)(31696002)(44832011)(7416002)(26005)(41300700001)(36756003)(38350700002)(8936002)(38100700002)(86362001)(66899015)(31686004)(316002)(54906003)(66556008)(8676002)(36916002)(66946007)(478600001)(2906002)(66476007)(6486002)(186003)(52116002)(83380400001)(2616005)(110136005)(6506007)(6512007)(53546011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K200a3FYa3p5R2swbUFkUi94ZTdZUjBRTXNCd3JocUhpUUlDRDlUNVVpV1cw?=
 =?utf-8?B?TEk3YTdmR0hJYXZNcFo2RlcrcVV4M1Q2OUpTQldoSGJWRkdpZWxscTBXVlpl?=
 =?utf-8?B?QWM2S253S2UxTTljSzVJMHZ4M1F6MVZtbkZWVmVHbk9GbmhIS3p5WUl6TzNY?=
 =?utf-8?B?RDFJckYzZlAvU0JFOVZZS3g5VzBOdDVxcEI5QWRuRnB0aWErMDc4ZWVjbE9x?=
 =?utf-8?B?MXBLMXQ0emI1c29iaHpTNDhlSGdldDRjYVhRd2NYWFVLOEZlbE9GZHZXTFlu?=
 =?utf-8?B?cTNocmg4M3NqWDUxN0hSN0ZNY1dudkg3Y0RKN0RxV2tRUHdUNHowRHo5aTFz?=
 =?utf-8?B?RERkbjhTVGtkVy9qbUJudXFCV0dKZ2lqTVFjOHV3NTVqOFhMVndZU1hyWHZt?=
 =?utf-8?B?ZFVDVTRGakhvUFplem1PSEJXWEpPcnhXRnBxRFdlMGFBV2todFFJWExxMTM5?=
 =?utf-8?B?ZEFTVy9aUWE5YTlySFZnQUxwcGlpUk9xMHpZdVMyKy8reDl3Zi85SmVYSzdX?=
 =?utf-8?B?UDkzTkpERllLTmFRaUozN3NLWGxnQk1GTVRQMjBGVzN6ZFVYMjNPS1pWdlBL?=
 =?utf-8?B?aEZSdTVwaGRRV1pRcVBvWkE0TzMvbmM1VXVNWUtDU1AwMytzV0JpTWEzVVBQ?=
 =?utf-8?B?R0RpMVJsL016RUt2eTZWQmpYKytHWEJSa0FxeCtqc0VBQ1hndEFpSFMweU1D?=
 =?utf-8?B?bGtGd1cvalk0UEh3cjh3SWtvS1pQRDRIRFFlbWNKTzliK3hLdks3UFVkZW5h?=
 =?utf-8?B?TmI0TkFyYmdDcnh6TWpPL1RUcjJvOTRELzVTRXNPaTNPelZZS0NkVWRQNEYr?=
 =?utf-8?B?RGQrbUZhaktjMUd3SXc4K1k0TWVPSFhWVytUVmJDUlpDbU9HbXZ4dW5jSFB6?=
 =?utf-8?B?ajRpRW05TkhJL0h1U0ZhS0RwVWVrRXpWSENYTGJnQnlhWUVOS0dwNmhoaUdJ?=
 =?utf-8?B?WEx6RW12aWYyNWgraVpReUtvY3NNbnVIVi9NUnJzWDFzVnVWSXFUOEtEOENM?=
 =?utf-8?B?ZHFlRW9vL0llR2paUUxVQmpqamk3VDQrZ1p3NlpzNklsSURwcmVDTlYrUG1X?=
 =?utf-8?B?WCtqTElNdUVRaldEczBoR0tRMmpjcDBCQThCcDAxL3BIQjdtSFYwRVEyU1o3?=
 =?utf-8?B?OFVLRk43RysvTHFtSmJ6UDc5dWNRRFV0T2IzZHE5ajIrMHVyTFNLNjZQQkJp?=
 =?utf-8?B?YkhCb2t5UlpaRlhmVHBWTC9RaWdaWUdDNkxiUlFVTlFKbnVHdHJyOG00TWlL?=
 =?utf-8?B?bmNnak1UNWs2RTUzTm5HYW1wS3JMMnRrVitscGVTeFp5N3VtUFRYbElDMXlY?=
 =?utf-8?B?SjQ0ZyswcnJCckJxcmdTYjlJNzlmVWVvTzlaVlR6a0krYzZzOEo1eWt5eU9m?=
 =?utf-8?B?dWV3emZJM2lIVFcxcFJOTHl2T1dEcG5IZ251QlFOQmQ1dFJNdkQ2RFphOUNS?=
 =?utf-8?B?cDBia2VOdlI3d3JRUXp3VGtIdmN3Z0xVbFVYQk4xM1loaWFsclhDMzJrVVFE?=
 =?utf-8?B?V09OTlJmeE1kL0kxMmJDeHBnRGtMMlE4T1hqK1hYa3FhWHgwUjhteUUzNStN?=
 =?utf-8?B?YitZYmhBczFnMzZyaVFDa0Vqc2ZmYWNRT3FDMnBBY2NaeVJJNHM1OGlSTG9Q?=
 =?utf-8?B?d1BjcnY0ZTVuK0ZnM1ZVcytTeW1TMjlsc0hrUzd2cnpiSG5YWWRZUlFyVnJ0?=
 =?utf-8?B?eWdhcS94UGxPODd0L2c1R2ZpUDZlSGZzRldkeGRwcFphT1Y1QXFxeWNFakFZ?=
 =?utf-8?B?WXRGTUp3RkptL0lNZzBoRXVjR3IzZlhaUWVUdWF4MTl2bitDUUxUR0x2V212?=
 =?utf-8?B?Vjc0czNsTmlxaStPTFpmWlNTa2lDNHpRMnozRS9oUWpqN0VtN1RkV3QwUlFw?=
 =?utf-8?B?cjdXdVBwQ1ZheVd6WVh2bHB1amJjcU40N1FHNVljWFhSanFJeHVRQlJvZXZy?=
 =?utf-8?B?MzNnY3VuSDFrZC9MQWxxZmRGZlhjSFMwVS9KcnVOL3hNUnpSb1Z5aDluOWFZ?=
 =?utf-8?B?Q2pYSkxidjdUUldvMnR1WEFoSXAxWExMTS9TZTVrejg2TFFLVURIam9JR3Jt?=
 =?utf-8?B?Yy9VTk5JUyt0TnhWSzVrUGlYRzhMcXNwbHNmWlZORXRUNnhtNm1aYk5VRlZu?=
 =?utf-8?B?NElnTmYrVGNnVjlqUHdZc1hwcGl1cFVKeHlFb0ZiM1N2SUJkNGttcGhpNk1i?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b87787c4-9c79-45d7-5b62-08dacd30530c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 08:54:26.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UN6/wMgmc3qvpAT3DrbEUq1m+owRJ7A85IlvJRr7yY94yl7xW2z2xpqUOoYuwY2XCfZC7rnPk/okkdgrBeFxrb2cFimW8YkKexncaw9PZzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 11/21/22 18:58, Sebastian Reichel wrote:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC,
> connect via UART or Ethernet.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 159 ++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 8c15593c0ca4..12ed53de11eb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -72,3 +72,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> new file mode 100644
> index 000000000000..e6c5df2163ba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "Rockchip RK3588 EVB1 V10 Board";
> +	compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc0 = &sdhci;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	vcc12v_dcin: regulator-vcc12v-dcin {

I believe new regulator node names should have a "-regulator" suffix.

This comment also holds for the rock-5b patch.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc5v0_sys: regulator-vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <
> +			  0  20  20  21  21  22  22  23
> +			 23  24  24  25  25  26  26  27
> +			 27  28  28  29  29  30  30  31
> +			 31  32  32  33  33  34  34  35
> +			 35  36  36  37  37  38  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255
> +		>;
> +		default-brightness-level = <200>;
> +
> +		pwms = <&pwm2 0 25000 0>;
> +		power-supply = <&vcc12v_dcin>;
> +	};
> +};
> +
> +&gmac0 {
> +	phy-mode = "rgmii-rxid";
> +	clock_in_out = "output";
> +
> +	snps,reset-gpio = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;

These three properties are deprecated according to snps,dwmac.yaml ->
the reset GPIO should be implemented in the Ethernet PHY node.

This comment also holds for the rock-5a patch.

Best regards,
Michael

> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +
> +	tx_delay = <0x43>;
> +	rx_delay = <0x00>;
> +
> +	phy-handle = <&rgmii_phy>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +
> +	hym8563: rtc@51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		#clock-cells = <0>;
> +		clock-output-names = "hym8563";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hym8563_int>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PD4 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mdio0 {
> +	rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +	};
> +};
> +
> +&pinctrl {
> +	hym8563 {
> +		hym8563_int: hym8563-int {
> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +};
> +
> +&pwm2 {
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	no-sdio;
> +	no-sd;
> +	non-removable;
> +	max-frequency = <200000000>;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
> +	status = "okay";
> +};
