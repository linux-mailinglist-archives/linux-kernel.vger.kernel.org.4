Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C5463A197
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK1GyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiK1GyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:54:16 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80D14D3A;
        Sun, 27 Nov 2022 22:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COk2/Bv0vi3VijWeavq1YuXjAuYEmn5H+575lIfOIFy7gUG6QVJQ3AAWdWy6OMdmlu6IfgYOBtBpJ4UtBs+c/0wL3gbfgeRzjq+l+KdRQYZbU6p72VS/GSdLJw0A+b7kNLNYDrC4VqI3Vh8HNim8oFXKnp26+1qzs/7+gTklpFvDWrPsH+2xAthXhuXItUPk44IaAxnmnd//lO8GqL+L5WmYF12iD8bqtYSWuPwZIYYOejbXr5vvbr+Kpckvd77ms0hv6+7G/teLtmhhdXqNXv6WnF5mXujAQ2oZ83KEc0ixUerKThAFJvW2l6SknAsoGKckcZSExlEAV1wH8/QE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFKqgRXp3iMjvLQm6wzQttXhflLVwxNZB78R2sTI7tg=;
 b=G3SWyiO82ykqfL2/JfVvks450qcxc8tDxgv2sQxV9sBt3OCWr5NtLqyoAHbsQL0CkRzRyyfagCy4NgL8VxB79nPXc/z8nMntmUU25+OVdcVEaxMsU0GfZ1eD50BrWo0ANkwNGGWBgku1UnkfQYlNpGSyjGsmH85yWxFATRqn+ZrqLeSuUZClhUDJgVTLiXQPFSxqd3Y/fTKbrJqH7uQ9ZJFp7g6ojYloD1Jit5MXgtBRsCkDBmdE6NqjdpbU9Zmsh0oVcIh8EiTvfzW5DtoA4gZ/Oxv8pk3iWp4IDJJIM524RFAbSThYAB8DQXFGxzTje3VqblBm0oJZ+6GEzV2hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFKqgRXp3iMjvLQm6wzQttXhflLVwxNZB78R2sTI7tg=;
 b=Pz3ZJK4X9acPxHhNLtI0N3lTETIVwKRix2s8YO9jJlS6/Kk0w+SrPagy0PtuKCn9yBE6I8/dBC4vj3WP2q2JUMmWvcMrl3QW9XLDFhJ7GmG8MEH1u0JDhe3Ns9x+OnzG50y6NVmfAh/SudLyv2cjzp0R0WWJKYevx5s3cMaOfwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PA4PR08MB6079.eurprd08.prod.outlook.com (2603:10a6:102:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 06:54:11 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 06:54:11 +0000
Message-ID: <2f0a504e-99a9-deb4-8693-c490d13f52a8@wolfvision.net>
Date:   Mon, 28 Nov 2022 07:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv4 7/7] arm64: dts: rockchip: Add rock-5b board
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
 <20221124144928.35381-8-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221124144928.35381-8-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PA4PR08MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: a366c21b-3ce4-421b-d421-08dad10d5a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1yKwTK8meR3O7FM9tmgsZhUYDrCu1ELtAFnLY29HHjpX7e5NidL0X8ltZ7ka5r+EQH0LbF0bPOJr74d0P2nsblivGA+a0rKc8KPqfOQH8TkI/mCeSZmX+4c+zKdW3zPRJkLHCd9SQ4canFTtH5e96skJcyEF1n3Kv2OIK3ena32NfMIA+xCYgBDsDNq1QE4d8TTZ/kSO7Ci1i1s/n7W0wlj3/9ameCtUGPm/GL4WVf5UTQMOrllsK1BEeNC+lAM4f9S6rzvL3g2wSsXFajsNaWZgiOBILb3ScPa4JCe2IUUOit6EQYnk8IO+NOv5hbpUKHp7PoNJeLiVQ305oqZd+GOJ58XnTDk8bX5B2EmSiY/NGO1vPYvbeNk8eP9U26V5YMr4eP422XL0ZY9DmME6U3Z4xfAjXDC48zl0G+XmoSBWSgzX201AwJ18VaLXjig1XsYsf9F522dvlrKA5zyeVaRq932dnPC58x4SIJD9A5MZaORDu0/VBIPRiDcZzHG/B3mjs5AexL5flHOQg1lekWhMvSFSQyYma5hKASjYfFqkHCKIfkdMcywlCOteNYh6xoWjY4G2pRQLKbWLwkMdK7lVYMXhpE2NstTnIMdPJuJjCEhuFpLVClxwt3q+qfPn+pJus1b+9HRDxFwiax63rG6gqS1vXH82LT/tcbzbgG5gayZkao4fgMEwbAtlH3h1JhuxLn2oUjMu6xZYfzlS5DtQ/+6ZCWlD4oQXA9z32A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39840400004)(396003)(346002)(366004)(136003)(451199015)(53546011)(36756003)(52116002)(6506007)(6512007)(478600001)(6486002)(38100700002)(41300700001)(66556008)(66476007)(8676002)(66946007)(86362001)(31696002)(4326008)(7416002)(54906003)(316002)(44832011)(110136005)(5660300002)(8936002)(186003)(2616005)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1Y5cGpMSER3YklnVlVtM29tRzVxTkVwOFZ5MHluL0x5UjBGMTY5M0laVzMr?=
 =?utf-8?B?Qk5XV2ZyYmNYbTQ3VTJKYlRuczBLUUlvdFFSL1gzTnZvUVlCL0M4NTUwaXZr?=
 =?utf-8?B?eG96R0hBOWpBQjhPMFlscThLS1lVb2hJTjBnakFEdWdFdE0zZDJGN2ZaQXZo?=
 =?utf-8?B?YUtROUpha0RMdTlrRkF1OXJRU0xLVENEWVExUjhUK2dSWmk2M1Q3Q01DWFRi?=
 =?utf-8?B?UklTV2htZm9qaUpjb2YyaThmdWJveDNqeGZKekZjQy91Qll1V2ZkU0RBYjBa?=
 =?utf-8?B?a3J2Zlc3bXdKOUlRY01VZDdSeXZGNHVCM0RyVXZacWxwYlNjajFWMHc4dDE0?=
 =?utf-8?B?cGlWMEp4dU5GYU5oQUJlRG9lMTVUbnFmeGRTdkJjZTQ0Ym4wL2RIK3JNQytK?=
 =?utf-8?B?bEx2OGxyaDJlZEtFeXZHRG9CRDNVSFUwVWxtaFg1WGtSZWJqV25CNGVweUpO?=
 =?utf-8?B?QW8vanNlcWVWWFJCalYwOFhtMVVvTXVFanBKTU1hNnJzbS9SbVBoZURxY25o?=
 =?utf-8?B?dFh1UEFlZ00wOUlVc21GWnhSdjVySU1wc0V4N0ZoWWdNdDNpVnZCUFpiamU3?=
 =?utf-8?B?RlFqRDVKTDc3RHJTVDNaMjQ3VVMyNmFpVzFGNUtvY1lmanMrUUFscUV1cEt2?=
 =?utf-8?B?REQ4TGQ3NmJsRUNoUmFVZjkxOU5QOFlEbG5RdllNZE9LcTM2dFJjQXRFaWhy?=
 =?utf-8?B?dEptM1pRRXF1ZzRyTHpPblIvd3hoc2RWQU4vcVZWL1lFVlVqQmdFQ09qSU5q?=
 =?utf-8?B?cW5sS2txRkx2dTJrdFVvVDdQUGdQd3ZOMnVaM0QrT29ybm9HakhOM3ZFUDBS?=
 =?utf-8?B?eFFXU1FzQ1FIOGI3SmZxK1B3cWlhVXBHbUhLZ284Y21KeVd5QjM2YThlR2l5?=
 =?utf-8?B?UXYyaWFmb0JaVmw1WEFvRTYzQzd0RFdSbDBIT0tReE1aMTN0aWs0cHNNTWdU?=
 =?utf-8?B?YkU0WTNZcjcrajZzdkZ6cTBURVd3RENpOU1XaUljRVRsamU4YVN0QldiakRR?=
 =?utf-8?B?R3pnVmFZRlIrYks0ZUR5VExpQndpTW05N1lUa1IyQXdBMXlyUE5jWWEzMkdm?=
 =?utf-8?B?YzhiQ0FFOG94TkxBKzhDS0IvVnljbmRKSE9pdEpRaWhQSGV6WFU5RDhRRWU2?=
 =?utf-8?B?UEZmZWNNSjArQzRDalFsZ0lTcjdBanh1U3poRXZCLytOem0wU1VGYXl6R2Jl?=
 =?utf-8?B?TkpROVVhOVB1eGxtZXRKdlBUanQ2MVlhcTFOS1RWblBiVXoxSmF5b2lHeEdr?=
 =?utf-8?B?VXl2SkdURUpidkJvWGtOTkxrZ3FSclFoK3VMaXgxVTZjOERWSlh3Q2JxcnE3?=
 =?utf-8?B?NWNJSiszMFVBUGZlbElicHlvV2tiNk9FemM5VE9OeC9VZDhaU0RBTVMxZDR2?=
 =?utf-8?B?QjBNekd4WWdpYmJTMmEzakpCWXV0bWdDa242OXJRRWRiNzJBNVRHV3J4bm9a?=
 =?utf-8?B?VXRiLzh4UDZBbHpkbUpJMW83cGh2ZUpHM1FlNEdneER0V0QzY1BSQlQydElp?=
 =?utf-8?B?cXJ0eGk5WFFqWHEvb29wL1VZckd0R0RrSWVQZDBRcEFTcHN3Ymo0WE1JQy9s?=
 =?utf-8?B?VHhBekJSVENXeGM0cnRXNXpscGlrb251SVVyMWFaam1WMlpNOWFiNXdxTEp1?=
 =?utf-8?B?RUk4WTNoSCsxRUtvZ1VYa1k0dHhKSlJ4OVRWVHpTK2c1SG00TGhtalRUdVky?=
 =?utf-8?B?YzE5Q0V3S29GUm5jcDEyRW51YnJ3Q3NBY1ltVm96L3loVjZWbGZ6OUNyNGVY?=
 =?utf-8?B?aVFoc1ZVSXBOQi95OWVtRUtUdFdZcmxDNmwxRWFiSTNJR2NRZkRMZURGMmhC?=
 =?utf-8?B?Y1ZQdWt3TXFIUHJsMGpBdjYzOXlxSEwyQ0srenNZcE5jUDR5Q3pFQ0ZoZnd3?=
 =?utf-8?B?WGdrTlFKcmtkMHA0TlRpV2xrNWRiVmxTVk1tOWZXREJVN1ZjcGVhR2svTEZ0?=
 =?utf-8?B?dUV2b0kzUFVZcEtLVGszeXQzdDJHZm90QzJaY1dqUU9zenBvU01wVDhHMVZo?=
 =?utf-8?B?VzhXZENSa1pqOFdFUkVVckhwTWd2QkQ0V1ByWXZ6ZzJlSHJ5TjRHSHhyQU9u?=
 =?utf-8?B?QXlLckJDK2R2d1lRU2VGSVliRmorTUYvT0J4amovalhza1BjU052ZDA3amNT?=
 =?utf-8?B?b05DZ3ZiKzdzTEM4bWEvNmhHc3pBVHNET0ttcXYxOGY5b0x4cmkxaWVUcUpG?=
 =?utf-8?B?VXFSM1cyRHhEUEtYMy9ObTgydmpjWTFsSXBGR043SEhxc1lDQnpJTkJlUHFN?=
 =?utf-8?B?NVB4aGcyNElJRzR5UzROZzJ0VFJnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a366c21b-3ce4-421b-d421-08dad10d5a81
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 06:54:11.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f053+6/TKxNbpCMxXZqlKm99p1a+ZtBiCY832mEYoBFPJq/tjcid7vEs6JRcTOjRbmGgoiryU3U3VbR+gG9kDzQ06ImItfn03OB8aGtEq78=
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
> From: Christopher Obbard <chris.obbard@collabora.com>
> 
> Add board file for the RK3588 Rock 5B board. This is a basic
> implementation which just brings up the eMMC and UART which is
> enough to successfully boot Linux.
> 
> The ethernet controller is connected via PCIe so support will
> come in a follow-up patch.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 31fa55750a0f..b31aa1b0e9e3 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -73,4 +73,5 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> new file mode 100644
> index 000000000000..baf46bd30b38
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588.dtsi"
> +
> +/ {
> +	model = "Radxa Rock 5B Board";
> +	compatible = "radxa,rock-5b", "rockchip,rk3588";
> +
> +	aliases {
> +		mmc1 = &sdhci;
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
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
