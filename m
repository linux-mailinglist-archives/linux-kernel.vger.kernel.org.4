Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E622263A1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiK1G6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiK1G6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:58:07 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4017431;
        Sun, 27 Nov 2022 22:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO5r6o7Fpk1oPmsit4vIZ9fDrQmlD8qzT0iBEyuOQSPdM1zLJqyvR8uALMZfp9vrPfmGsckNHXf7vf6s4QuG/PADu/UeqmOOGlG0cga5UvQ6lncQgoMEDG4njmFfHWRDtttCDBNaJTGwPboOFgLcPZP/JbmcmhEqpjUkLQGfgrHvsIlJPdc1eQ4P6rrfqBQuXyGhsvC0FCRUCFnWBp2z+LsOvooY7cKHcHq/oEp2xDmnNJt8v91KMWAsQgmFDpUvIWnixyX7oHwXb60zfuRkZB3MEktu2t8d5beG3S6F5VaCwTyn+oBCbv1XjiRBgL8PHNNbINO72+K4ylNTzTYj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP16cuEI98LzbTgBiuU/vZNXjsjokcxbD4SoXx3McHs=;
 b=afDIHDMLF0riuczztegwHUfLEzB+NovO2S5UlvDzoRGPSIJWU1e+y4ZoXAVXthIOeKI775SyQEFDHhTaEbf7+xGngXEKZR6xHyQ4yuoy6AfHWderq+/Gj751n/tEqNQm+J/abVRLU1L/nHAIKSIRcD7kp8P1fUZucgDRcxWoxi3N/JYav3iRpW13iV1cVAgyB06sEiZ7qeuF/c2ClfO7JnYHupgPvb+pzbrvfj3vU5zHn1A1aleT78OFDP8zodix+y/7/CoEibH6HXCOig35qJjEQihS2yXcW+NymxciWmKHbtQpLSopayNSNyjcvL44C7tAkSKd6oMGtqHx80yZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP16cuEI98LzbTgBiuU/vZNXjsjokcxbD4SoXx3McHs=;
 b=jHhM6pE0k+ONfyEjWRr+gO/pmSbQV0xdtAzl/7oV6AsZQ799F7vMlGVS8kFnEFI9gldw1SVi0x0fIclM+QeOITCoYHidZCWmdkkAAlBS0LqdsrJuSGwHHrJyPfNH8x/J4brMZjeEjRNmZdYjlzNfAv3F78wSE0Tpyzo01X9c4Bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAXPR08MB6573.eurprd08.prod.outlook.com (2603:10a6:102:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 06:56:55 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 06:56:54 +0000
Message-ID: <081e54df-6ddb-4570-3427-369a61a97d6a@wolfvision.net>
Date:   Mon, 28 Nov 2022 07:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv4 5/7] arm64: dts: rockchip: Add rk3588-evb1 board
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
References: <20221124144928.35381-1-sebastian.reichel@collabora.com>
 <20221124144928.35381-6-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221124144928.35381-6-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0119.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::16) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAXPR08MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c5fbdd-ea11-4973-6949-08dad10dbc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERj2ozULUWsxgnY53R119VUbflMoYgwXGbxH0HQoBPXQ6/V1oxlUU48gma8+D/MPe9bL5nA4g9kO8GoedWalWMzGoFNLYygLXlpRXDEHV9CL8LEpZMcsSpjTSVu4N5YSZtFBGppuoSNjUy5OwQzdaWv3cyeb6rbcyiSY2vozsFBxfGYtsYCKl4l1C7l+l3mUqCo1O5zrWmZ+faFbqYMiRCt8w7j6ocmoegoYKMVpUhyQMubTgAuHy1wloGAPTqh152ruHOBO3yUrnrVjqwlHkV+W2fP/7VsrZgikGooC7uVLPVNeTUf/Ar8JScePNj2TITyUFz1HAh0ijKWYi1MneKrxG4o7ss05zLGz7SgidVaOSqS+bLQKBd3GtwLWW4q7z67J/t7vo7vP8VuHi20iCfzzcN92ch2QpyjjKmr4Z83VSB+DTfIkCMvWxgOPaMQ32Qc96Prk7pi3STudzsH1l5PYasW606r3KJ0l3GunWZOWPm8PKVYAQzPaSOtAGHzYhxqeRUFB36r3yI3v2866xPVvpdqWsMNHsqfmbBaitqKv4seThe2JwVaAt+gQqJz76M48wtUYDq/Ra25rDDXeMR1oWBVNCp4EPjC1CrkghNPhd9oM6zVB28zZz7rmgiNDHy4YCs/xSG6gNGNY5BjrQuvM5h0SA6N26HgE18g9/+TvjeKSTg/7WBpntCYfyZ2qp6UVAVE2zOZ/JdJ/uGz2hGq4IRYeQqQqHpssmVw94gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39840400004)(396003)(366004)(136003)(451199015)(36756003)(53546011)(52116002)(6506007)(478600001)(6486002)(6512007)(38100700002)(41300700001)(8676002)(66946007)(66476007)(66556008)(86362001)(31696002)(4326008)(7416002)(110136005)(316002)(54906003)(44832011)(8936002)(5660300002)(186003)(66899015)(31686004)(2616005)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFHYzU0dXI2VTh6L2g4RmdaemF4SndTQzVpZlZuWTNETVlYZDYvdlY5KzFi?=
 =?utf-8?B?NlVyVmw5WTZMSWJXWkhieXhkcndYUEQwMkhyWTlJa3Y2U2h0UStTdytESklq?=
 =?utf-8?B?UVZjSlBCSXY3M2NITERjY0o2K0oxcUNrbVFoQ1dHbFZYSE9mV1o3UEhFRDFK?=
 =?utf-8?B?dnRwMnpyb0orVk5JZmhYcjJHVHUzM2VmdzQzODlYd0o5SEozUDduVUt6b2l6?=
 =?utf-8?B?cUtoTGNIUyt6K3ZMWWo4ckJYTTdkb0NFdXNmcEJaa3Z2MVBYQjUvQXp6NlRO?=
 =?utf-8?B?OWg2Q1pmbElsanpGemN5dVlITURIWk5lYVVOYWY2aU9LVUoyL1E0UWZvREor?=
 =?utf-8?B?RGQyM013SHVPenFzU1BRako1KzhwVTNla3BNYldXbUQ2NjFiZHdsNCtRMEV6?=
 =?utf-8?B?VGdPRVRtVzBIQSsxSGVSOEtnQnFySWZLS1MrM3F1Q3NURThGdWU4enVZQmV4?=
 =?utf-8?B?eHlCaUhQcURVcmhZOE5pRnR2V1RoZkh0K2dtSkFBRzlTblEzdXhOeGpaaWJR?=
 =?utf-8?B?TVVja1V4WlZmWUdrNVFBS3pkZEwrUDc0eUE3dk5GQTh4amJYRExCazNkMjFr?=
 =?utf-8?B?NWtheTMrNkVRaHgwMjRSMFJOclAwNDR4ZFRHZmtjOUMweThvU3l3eHBNcHI3?=
 =?utf-8?B?aXZ2LzNWNTgzd1VycW9SRG44SGdzM1loTDFTQSszc1R5UldrQ2V2ZTF0ZGhi?=
 =?utf-8?B?V0RSWXlxdkxmVXp0NlR6dmowdzJEckhvblp5K0ZXeitrSW91djM1Y0EzNzll?=
 =?utf-8?B?NXhQN0J1S3g1bm9HWXovRm1SOUVQOFE1eGtYMEJqMjlBVUZEdlNpRm1uZjJ6?=
 =?utf-8?B?YkdMY3dGR2Q3dk5naTFBWnlBTzVmQmpia1N4QmhyUEoxamJrVm4zSzVKTHln?=
 =?utf-8?B?cUZZQUhwRnBudnFHQmY4RjVya0RBL3BpbklyS2VCbUVHbUE3ZHVtVFdMNTRC?=
 =?utf-8?B?NXFwTW5nMnRjODQxa2R5RzYxYS9udzUvZURRYXpqMTJVTElGR1VvaDN2dDMr?=
 =?utf-8?B?UGFIQUQya2FLOHZYbHEwa0h0V0IzdWtvek9ZV1ZCRUJLK2xDVVFoY2NlczFz?=
 =?utf-8?B?UTc0bWFJZFJlRjdJWHNLSVVvamF6VzJCVFF5VEMxblpXUlg3R0NYU3NaazlO?=
 =?utf-8?B?L1JNUjRLN0RFQkI0MzJUZWhIZkpqdDkzMEMweFdNQVZ2VjFFQjRqTjFRVzhO?=
 =?utf-8?B?UlFuUHgvMFVaMldoSXF5V1VTYzNIU3R3d1lYeHd6NFU3WFhPY0I2WTJmSi9Y?=
 =?utf-8?B?RVcyaG1NUUlTd3YwRHExTWt4eTJDMDJ3ZFRjTmI1dHZ2WGZ5WGE0N3ZQejN6?=
 =?utf-8?B?MkdMWVM0akNrRnBtWWhDaHN5Z1E2WGQ5OTF6RDlrT3lQakNIL1ZjMUhrV3RX?=
 =?utf-8?B?TnU4VzFLNDRRQ3hOREtoR2QvT0JnVi9ZbkFQaEJxZkdZd0hQVlExNTM2MG1h?=
 =?utf-8?B?QmNwVzdaV1BKK1cxVkZkQ0hVanhTZ1ZFMXMzdjVyOUdwcks1L1VGWTFRckxG?=
 =?utf-8?B?QUxKZml2bXh4NEkzQWZWR3pjZHBOdUd1ajdjVlF6Vmx1VTQ3eGViTmFaYm5L?=
 =?utf-8?B?Zi9NdGd4NFh4RHNueHE1VHZvd0MzU0tSL2w0VkJuZlRNdWxyTTJPYUVaamZp?=
 =?utf-8?B?ZWZ5SnpTc0JBQnV3SFFJaktnRjhFdktQenFVdGNuOHBtZEVBZUlpZld2U1Er?=
 =?utf-8?B?NGNwdXk0aTN4Yk85UEQ0amZrSUtPZDBWT3NETlJlclhWN0pJK3BKdGk0bUgr?=
 =?utf-8?B?WVRsUmRPamlNSkxxcWZhdHlkanF2MEFmVlVUN016bGlFV000b2lVM2JpT0Z2?=
 =?utf-8?B?WTVlMyt2djU2OEZoVnJ3M0dGZGxtY284VFp3azdNSldTbHV2d01jRHJoVmsv?=
 =?utf-8?B?Rm9JK2hDU3Zvc0Y5T0RRclp1RzNaTWV6K3N4eUs1MU5sbm12dU4wczQ1YjZC?=
 =?utf-8?B?NmZ5V1RObExVTjVHTC9NQU9BSGlaQnR5NE51b1Q5SVloRGR1R3o0M2RQWTVW?=
 =?utf-8?B?SzZnWmZZMVBuekdHbGJKaGt4VEV5WjR1UUI1VFpGS3FmbCtuNzFSTXVBTk4w?=
 =?utf-8?B?OEFSSWlGd1RoRml0QUtlalBWanZ0NmZlaVRreUhOdm1iQnVvOXF3S01xQ0Vh?=
 =?utf-8?B?c0x0dU5Ka09uUWpnTkNDT1VoUVhwcDU0Q3dlbjVwaHRHMGVES2s3UU5TUEpm?=
 =?utf-8?B?RDQ2eFZhSHZLeTdYT0g0US9EYVBYVkNHWWVxSHUxdzlvdHlzNVRPdHBKSGdJ?=
 =?utf-8?B?bjlJZTl6MHFpNTd5K0NVN0FhMjBnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c5fbdd-ea11-4973-6949-08dad10dbc2a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 06:56:54.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf/pbXacnZOx0FCV9bhkKC45yyrtuXmtVlDrh6Eho1ZbK2Qny0UI/gzQ8wu/vNWIcMXa34Vb6vKqVUEGr0gBSI2vyIhGzai9fN2ffNfuPug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6573
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
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 156 ++++++++++++++++++
>  2 files changed, 157 insertions(+)
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
> index 000000000000..d43d70228d3b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -0,0 +1,156 @@
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
> +		serial2 = &uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
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
> +
> +	vcc12v_dcin: vcc12v-dcin-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc12v_dcin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc12v_dcin>;
> +	};
> +};
> +
> +&gmac0 {
> +	clock_in_out = "output";
> +	phy-handle = <&rgmii_phy>;
> +	phy-mode = "rgmii-rxid";
> +	pinctrl-0 = <&gmac0_miim
> +		     &gmac0_tx_bus2
> +		     &gmac0_rx_bus2
> +		     &gmac0_rgmii_clk
> +		     &gmac0_rgmii_bus>;
> +	pinctrl-names = "default";
> +	rx_delay = <0x00>;
> +	tx_delay = <0x43>;
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
> +		/* RTL8211F */
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		reset-assert-us = <20000>;
> +		reset-deassert-us = <100000>;
> +		reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_LOW>;

No pinctrl required for this pin?

With this addressed:

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

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
