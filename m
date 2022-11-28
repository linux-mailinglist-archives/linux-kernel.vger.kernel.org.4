Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2663A194
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiK1Gws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK1Gwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:52:46 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F65657B;
        Sun, 27 Nov 2022 22:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0BEBYXOypV5ow0VRRCvJbaex9jJLpZ9efXVCO2PW4y0ob8YD0SfddJDUuQrGOogxscgcitzbAQhGPAwuPLTQ4J/CPL9gwou4MW/AZ6D+un3vpQf0m0c+2DelNRiQP65RNoOGZLwiFe3cTTmX/YyzbmQDPHVp62mdDm7RyxRMUkrzYdCoAreumFZxQbW2gm1nz4wHT54VdjuW4g2+pp0IVRJFkEvbPAQZXro6J8B8o9/Q72GTdGhNZMu6e3E2+TSBTd+c2pLex0D8tOms/x7rNMDNLxFnGkJNLF8HX0JH+pzWknTl5DGMTupLc0XpjH5N8C6jhpiWKGXl0MXoGsl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LeaUuNIif0a7QqXvpOSXqDJD3RK/W+5O3RV2jm8k54=;
 b=dz3jvhHdEI9LFqDWNXwRDMNO6TbQmmhKE/Qwgk97LfEcNX1rMEi0KWRlFtk1kFHz6SXL+N6kQBG1G+4ylJDL1APVUx8WCZwV054WXgHkg5JyhhuH3ZwduD2qXvP90cpHpWghaIZKMrQPmWMLAjhaDNKVNHNMRc8okr/rrh8Pzbj3dyTYHlrXes5a2kw8ewrxV5Mz8BgLZ6IKamLdu9krbWLDl0V8Smobvn8CPJwXjerXtnsjo4jLbvs6kzuoJ/ahTYhvs+fMIiT27N/ylLpPEAvmNjr8foI6wd96UT758JQBhZxAai0LWjcGPZp0bMzAWpXB0uKBCAgNIfd/I9sf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LeaUuNIif0a7QqXvpOSXqDJD3RK/W+5O3RV2jm8k54=;
 b=Di/6V2jbzjqycIhHYF+DH/4oT+qbTxPSGhwo60Ck7cyYMHDxiFPBe7S4Mi3mdt7je6/DI1nVOFSpUoMb8iCptBL0HScm/EO4TbhwmL5o6i5YpNnTvrD2k1xIAM9KcdjmaJN+BtarVo1+S49E8fZGuRqUn1yrOuYPivKBKQ+aCmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB6079.eurprd08.prod.outlook.com (2603:10a6:102:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 06:52:42 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 06:52:42 +0000
Message-ID: <1afb1586-ebd9-6b99-580b-531e8ba7df32@wolfvision.net>
Date:   Mon, 28 Nov 2022 07:52:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv4 6/7] arm64: dts: rockchip: Add rock-5a board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221124144928.35381-1-sebastian.reichel@collabora.com>
 <20221124144928.35381-7-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221124144928.35381-7-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 089ae183-5e17-4867-9464-08dad10d256f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdifIzizyq+/D+Ny/Wjl5ESQD7U2oRn6/pJzFWL9QcK0tFctJ+BNLA6U/QURNzrRXnTJiUSyvzyzjaamzZKIEpJ8rBTejXcMKhecsvmcZIDf3BCXXrmQnaFnoWhJFQdnFIAFFQLnTnJshUbvhMSuKOsGgB220B6pOVvvKblTmZ3wl05iTgyBPuD3uR7ajE3ffgpIhujSuF0Bn9OwtIMqejxe6VZ+ThwVBeLbP7vJxdBWb/+LRftZ7BN8bWiMDUFNTCCFprwwp2JBDjGHtTmdSABbW2jmgoCe7sPQs0P4HWF2/qm/hY3gIBB1hZtdJr/QoQsbHH44BnymC/KbIrhjW1tg3jQdarFpx02THyVWvXr6QerSGrjSOhUioIPvdVut9MrMMRhYpAVwqnww6L0IbMTkRXoF03KBgPjnw+T6x3GbippyX9lDssLZ/7n4MvrhpQkOFalT9IfPtdPZ1poGntWkjHeEGfHJezKjQF+OLjIyPPF1iNORp8REMUMkwZW8QeFnMxFHH3zCdoxley4tQnFj0MIqaWUMSNfdVKqCeMNprlWXsrpy0zMR//wYTmdItIARLSpu/Nx6+BsfsxUYWJSEi18p6b5/whPxanz1WIvJgczZnEESEdLeJN+7HjiO4U5MkHZjwwCIR5yB6tAeYzhutx5N/SUtlTDFmW3oijGxCUlSX7kmv8gyjoYxwqVeL7VVLc+6TRcxUAX6wBdq5cMaLJ4+ziT+0tS8qzj1WW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39840400004)(396003)(346002)(366004)(136003)(451199015)(53546011)(36756003)(52116002)(6506007)(6666004)(6512007)(478600001)(6486002)(38100700002)(41300700001)(66556008)(66476007)(8676002)(66946007)(86362001)(31696002)(4326008)(7416002)(54906003)(316002)(44832011)(110136005)(5660300002)(8936002)(186003)(66899015)(2616005)(31686004)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRGdDM4K1E0VjVtNG5tOU9lUXN5QkJnRkJOWExMa2h5VVJQWlFLdUhkNUxG?=
 =?utf-8?B?ZEdpNzF0SFFZMGFCQXFVM29KdEdxNVYrcURxRUpyV0lUcEs0Q0lkUTEvUmlu?=
 =?utf-8?B?ekFYckNJMURjZnRoS0k2M1d3VUFidnpMaE04NUZyMXZQRVlQK2w0KzMya3VV?=
 =?utf-8?B?aU1FQ0VkSDhhVUdSTUptOHNiYVN2U1JjZW1OL2xHaVU5ZGpRc0FreC9MNVZS?=
 =?utf-8?B?MFJkQ0tmV01ybDNyYW1jcmd2R2t1OTU5bWJkNnlVdEVIdTZyTEg4TlFOTjIx?=
 =?utf-8?B?d3FOMkNqdWtqUVNrMEEvVjZxblNmWUpIWXlqWmJrNWowdm9LTHVSUXlodXF3?=
 =?utf-8?B?NmNESjkxWlZDcmZyQzQ2bFc1T3VVdUtvenRqQ3hjcWtBRGhGYnBvWnluOVFC?=
 =?utf-8?B?eWZrUEY5UDhVZGwzNE5CbHNOWEFUMXArbWtaZzFxZUt0TGY1K0U3L1RhVzZF?=
 =?utf-8?B?ZUxsOGdyNnlKTThYNXI2emh0bEtneTFHS1ZZcGFIUXk0cWpxZDZUN1U0K04r?=
 =?utf-8?B?L1BkWTluKzZZa0lpendYQ2tNbEduLzR3eS9PWHZjYlg4MzQ2b0J4c0pRcWNQ?=
 =?utf-8?B?WW5qWElQdDl4MWYyeGZGYlNLMElSRkJobjk3ZHgwVFZFQlV0MEhvUTRKSzV2?=
 =?utf-8?B?cWlnUGI1ejYzN3ZpNld5Ymc5ZytkRXdubjZqa3ZGdnIxM2JqVk1uUkRhSkZJ?=
 =?utf-8?B?aFkvd2w2bHJxdHRVL3drT1NKU0NVSGYrZ3prb29RSUZZQit0SmU4RFYrNjNG?=
 =?utf-8?B?QS9JbldsdFZWQm1yN0NaSjZtQVA1V2ZxZ2FWY3l1TnZvK0MxUTEvaGJ3Tnk3?=
 =?utf-8?B?Ujg2NGZ0Kzk1dWpia1hMcHBncW5jeGpydzEwK3EwVVFnZjk0cEZ6Y3VnQzNy?=
 =?utf-8?B?aVAvRFZ0eHAya2t5eXdVSm52Y2hrdnRBZGxTV2ZRWEpaT0lWSTBOZmphSG5X?=
 =?utf-8?B?OStPdTN5d0NLK2JzZGh3Yy93c0szTUVURGp2VXBLZnM4M0NXMEF5WWxSM0hM?=
 =?utf-8?B?VHErREhiNGFtcGpOWmFOU2haZUhvTnFjb2NVeXZYWFlIbDBmRVBBaENXUTRQ?=
 =?utf-8?B?QUc0dkZjK1hYditZdlpGejVCTkZYM1BqWnNObzZGYnBwdFJqU2U4c2NMdXdV?=
 =?utf-8?B?Vm1tWjR6bU02MWEvUys3MHZNSmpnZysxT0tNaHBJclJDVVpIaS9oaEpjR0lJ?=
 =?utf-8?B?WGVVOXRsT3MvSng0SUlVOG4zRXNMamljaDZkL2hoeEhaVmRGRThhZCtkSHBt?=
 =?utf-8?B?a1MvRmw3RWZKYTY1UmRnZENkeVJjYThSdTJOMVJyVDRMYjJiSlZ0N2hyTnpz?=
 =?utf-8?B?MHdSRnp6L0FBWkJTRnRwcWR3TVF1ZVRMUnpYSk1WbTlHYkRTZlR5enlzUVZ5?=
 =?utf-8?B?UWwvZ3lrVkp5bzVvS29lcnFUZWNnYXpLajk2Q2t5bU45YkE1U2twMHhKQkpN?=
 =?utf-8?B?ejBTbE1XQVNTZllCRmkwWlg4a0t6dzRGQUd0OW5VVVpxaitld2FxWWVOSGVB?=
 =?utf-8?B?aHl2Rm9Mak9QaDB2M0d5MlZXWm9HYzJjVWYyUjh1Wk00bWpwWnVXZmN1S1l0?=
 =?utf-8?B?MTgxSXR4eGVmUmRKMlBjUndydGJmRy9qMGJVcW5aUDZwb2Nxa2xNUjc4Q0Vn?=
 =?utf-8?B?U2YyTFFjcTZNRVRpTXdvYU9vUjhnVnRvbTRHUENBNW9qcjBKb1ZGOUMrdHRy?=
 =?utf-8?B?aUQvUFFzUU9tUUNyTWE0Sk8wSDV2THhuZGRJUUZGYVdEVlJIYlMvUVJyaU1h?=
 =?utf-8?B?RGJLZHZyZVhvNDcxR1ljUzczVE1zVE04aittMGpjT3lxaWRCZ3dnOXc5bWQ3?=
 =?utf-8?B?ZWFSdlZ0SHo5WW8zUXkvMzRZc3VOR09wNkhPeE9xRjdHdVNua1VKTTFLZDdO?=
 =?utf-8?B?MFpHZDcybDJRcURjU0hKcXBieFNRN2tycmtnM2hlSTRzdVlaVEJnZUM5VmZw?=
 =?utf-8?B?a0g2T2J2RVlqL3ZNWmRmc1dHM2xpYjJDbFpvR25uclhXaWVhNWdhbnZyT1NE?=
 =?utf-8?B?VitTaFpDOTdmSXlCTzBVWFE4RXhPdWxFQis5NklmOUdpODBTdnl4QTN1ZGVQ?=
 =?utf-8?B?QjJyQkVLVks2N3p2L2hrTUJJVHk5UEtlY1E0WnRJOWlUbVVjamlSWXBqV0FH?=
 =?utf-8?B?YUlpeE5vN29XcE9wTDRZQTZvMUdhZWpaMGFaS3YyWXFJZm9RZ3BmbHNtNmRJ?=
 =?utf-8?B?M2hzcDFsTWFnZjhyMHgwdXBPMW5wZldkTzJKQU9laElFNnp5RE9PK2xiYXI3?=
 =?utf-8?B?V3d1WFMwTTJvb2theFlVVW9HR093PT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ae183-5e17-4867-9464-08dad10d256f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 06:52:42.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktjqUIb5yxM5swgOhM1S7X5r1IJFq4jPo6REN4w5e56M6K4J8NoNeLkupV2Zmq2naLacNxRjR9Q5uYKAqjnmPINIBHKsq8POKhQilbHDpz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6079
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 11/24/22 15:49, Sebastian Reichel wrote:
> Add board file for the RK3588s Rock 5A board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to access eMMC, UART and Ethernet (i.e.
> enough to successfully boot Linux).
> 
> Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Isn't your Signed-off-by: tag supposed to come first? (This question
also holds for patches 1, 2 (your S-o-B before the Reviewed-by) and 4 of
this series.

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 63 +++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 12ed53de11eb..31fa55750a0f 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -73,3 +73,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> new file mode 100644
> index 000000000000..b9d1ade62b4c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "Radxa Rock 5A Board";
> +	compatible = "radxa,rock-5a", "rockchip,rk3588s";
> +
> +	aliases {
> +		mmc1 = &sdhci;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&gmac1 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +	pinctrl-names = "default";
> +	rx_delay = <0x3e>;

Documentation says that the MAC should not add an RX delay in the
"rgmii-rxid" case, but it is specified. Is this really necessary?

> +	tx_delay = <0x3a>;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: ethernet-phy@1 {
> +		/* RTL8211F */
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;

No pinctrl required for this reset pin?

With this addressed:

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

> +	};
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
