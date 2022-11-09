Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E846226A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKIJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiKIJRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:17:11 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A5264A;
        Wed,  9 Nov 2022 01:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCCk8sTewuz0HGA9vFm92/hfoDuPttDy2JCWnyBWUrDc4FfHpGxgolYQc8c2D6K2Mmr0hL0mVDYONi6zdP4OuN57kR0Az+KT9UHZ1t/CwDSScr1Z6o9rRBOdnbLJG7Hq8iqsTAMheO8CAQ3d+AXOu1xhY1/uyQ6ndbdzAHXOB5LMjHqbu0k5kc5Go6RPKpTU84iv8OSZsHLUWMqr3BYkVQgwbfh4JoXfXK0AEV8/P0lXZpws3eDjBzBJrxbMlB3BuYGhyYJmSW433bpaI3lKn0Sa/K6O+JluHS+xEhPedeeM/7CXGIG+gnK1QMcA2vp9g4WGlh6tkAPAdssT19kuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoUcQv00v2rxBTuBq6gaaUcy3CAyMtnJyKLLJ48FWfI=;
 b=Js6+bCnmAMYVfUY7LhTKR+wmuC5G7IE5lKaBigC/dgKfwcjfZ/RUdT+QVBlg0Rk9dKWExjz51jncKaAAxdZOkj46x/VRhHFaNisHjXU9BF9eEaxIqjvx8tWswuYrjLR767K7iN39TPjJRSsAV0WKRCH86GkeHr+9hQviG105B/qp5BpKxrryUrUz4LOFBzxkJKIEj9uqjEQ0DePPOblZOYwQETzk3TP3QMc1YxhWX2Ui9n+lh9MfwRc/eExR7mKGLgP+0TmSe/SY65/nh9IhpLrXKUoi0UDaTkLI3CWKZHY0SdmHdAHsOIfReCjtuI/7RIQLPNOVzGag+hgMzOe4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoUcQv00v2rxBTuBq6gaaUcy3CAyMtnJyKLLJ48FWfI=;
 b=vYf6C1GZQx1EhTFKoWAsNZCxKgkUFoBbTbu9FETJZUcQVJ6ET507pn1YU2/VQkcpoYt5VIzQhJKMLE7DV+Jv50+l3AE4wxt7TT5N/gO5FVpCgnTimddQeVcovlg+sJJ3Clof86O/eg/x0Wpt013sgWgWBStSMp39FlxvNpG6XoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6412.eurprd08.prod.outlook.com (2603:10a6:10:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 09:17:01 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::3643:6226:28c:e637%2]) with mapi id 15.20.5813.011; Wed, 9 Nov 2022
 09:17:01 +0000
Message-ID: <9bdc7e3b-a57b-7247-39ae-ece7bf1566fc@wolfvision.net>
Date:   Wed, 9 Nov 2022 10:16:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: Add rock-5a board
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
References: <20221108171500.99599-1-sebastian.reichel@collabora.com>
 <20221108171500.99599-6-sebastian.reichel@collabora.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221108171500.99599-6-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0062.eurprd02.prod.outlook.com
 (2603:10a6:802:14::33) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8466df3b-2564-41d5-603a-08dac23328b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYbk3mKh4xcXWR3TJMMPEIjn1PqHG075p935USt2rOq5UOmX6rGC8wDC6M/KSrUDUPjtaDul8vaTrUZLs+SCvlZSR2upB2bQmXhVjpqgwJi2opWzqxIu0CkvuoYtSG+liua7Y1fKdcggcAjTM3ydUKiOw13KM79688lI60ZutSl//8evKkiLmr9XYbiNn5eMlWnNIdb6cZNWU++Hke1icDEmeVBzm8ETlpc+RN6P4k6CBpZM8y0CYb6WJgrus5y3OXqAIzPnyFwa637nnm74BwVSQwz5wW6lGnvDE115fPJVpMk15HMoK85R1yvfJVAc8WsNgIlucMcM5rcM1ZmiLbfvA+v1Gch+XosmRjXBkDTKZT45105910Wh6Jno7CQIIE7TRTsuA8RHwt854LyOoZl0SIY9hEGpKigaQfLV0nxipa667E/ns8pBZuIH1WYMQB+1qpKQoc0+h1vnVbEoFAiLcT0P1fE956cdCpQnWPOxbXaCrMJE7U8rZna936WiqiDCvfw/5RGggX03YupoidSrMqNOmj9kXQUHWDOXR2BczgJ6WzswOktu5FJoPeTdNQqzFB9GSpa5466sJB5RLLFA/BxXWM7YNMhiw/vkFhs5IbxOuGK/zRt5SXKG2uTCUpt0+2DLl+BhYvXNv8gnSzkUqh2zLaxI89UoxsQcR0h1jC0EwPRQqiIfKy990rWa1IFhaoBeTucMBM2PPRt03ha/rRIW8n/tC9vWnr4XeCneK1anqP0yVi++8P7zuoF0ZrlLxUp03POnWlhPO7/rIRlrnf7fu6DzA2i7Em2+qhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(451199015)(66899015)(6512007)(54906003)(38100700002)(31686004)(110136005)(316002)(83380400001)(2616005)(2906002)(41300700001)(36756003)(6486002)(66476007)(66556008)(31696002)(86362001)(4326008)(8676002)(66946007)(8936002)(186003)(6666004)(53546011)(6506007)(52116002)(5660300002)(7416002)(44832011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1VRXhlU2xnQzhtRzA1T2hMUDhpYVlwakdPUzlUUmdmWExWQ3VRUUJ1eGl6?=
 =?utf-8?B?R3MxY2FWYlZZYnFtK2hjUlZnNWFvK0duYWw3bE9JQWVWZFUrNHRsWDUyOG50?=
 =?utf-8?B?WWJPTlliMmlaOWgzZ3Q5NzRMWE1DWDF6NFlyTFZXMU5kMlI0QThsM3M4ZUNQ?=
 =?utf-8?B?UFBpMHJDQjROKy9RYTd0bnFzVnVoMmgwT1d3U3RzNFRWWXpHekdNYkhlVS9x?=
 =?utf-8?B?Y0o4UFpEeEc4UVMwV3ZqclgxMWJwZVB0cEdEcFc5VlR0azI2SEEwM3ZTUjYy?=
 =?utf-8?B?N0NiMnk3Nm5UUTIxYVZ6VHI3UzNsRmZHVW1ZK2VRWHEvTGhYTy9sSlNEbzVu?=
 =?utf-8?B?UXdaT1lCRjR5UGVDUEt2dm1zQ3dzTi9iTnZiUTZTVERsYTNxOXNhSy9GaFdn?=
 =?utf-8?B?OE5QTFY5ZFlvK0RvRGlWK05YZzlySXBZMXhVMUJEQnpsRjFIOWZTODRodVUv?=
 =?utf-8?B?bThHNGVIYkhtZWdVaURkZUpmT2w5STM3UWtmR21Ic3RLd1I3OGkrZEIzWmlH?=
 =?utf-8?B?MU5qMDVObjN2QjI3c2xLQ1VxdEtFZzBtQ2JJRW1qbTNCVDRBNEd4SEFnajF6?=
 =?utf-8?B?MEpUUjdCdENJZHhoK1k3Zlh0VlhIVStGS0lTaitnUFQzMFlob0h6VG8zdFV6?=
 =?utf-8?B?ZnVMZUFYUE10S3lhTHh2MlBTNFA4N2FScEdUWlMrZ3VVbU5SUmdUQ054R05Q?=
 =?utf-8?B?bExMeTdYdm9sckh4RjFnVWNRQzZKZ21ZVzlQSkNTM2c2ZUZRbjZoZVFudndt?=
 =?utf-8?B?VkpBT1p4UTVNUWNiZmFZNS9YOUpvcHRUQmlSb3JaMll0UFcvbWVyaDBwcVdn?=
 =?utf-8?B?SWpqZGpRUi9XMFAxRmgzRnM0ZDJkWXNjUnBxaXovQURwZFNEeERCRUhkV2ZP?=
 =?utf-8?B?TTVYMVlwNXR3cUY1aXVXekgzb2VGVWFyTnhKdmlRMUhkckFwZmI1ZXl0SWRJ?=
 =?utf-8?B?VUpnbFpGRnBGYzNEYm9CenZxajNHQWZqQ1BFR2ZpeEhzNW5MY2FaQkd2Qmov?=
 =?utf-8?B?UmgyRm83Q0cyTmdBbFdjK2NTZCtFMXlKU2ZCRGYwV1lOS2NSQ3NKTkxRRGRj?=
 =?utf-8?B?bnhoc2pzT1g2Ti9UN1E0cHl2S0N1RDM0VXpwQ3pINVk2cjNJWUFHc05GRU1Q?=
 =?utf-8?B?UlZvQTl2R1gvNG5VcXFZbnRLdGVHT0h1L1ppM2pUbW1xeC8xazByQ0llSEVj?=
 =?utf-8?B?ZHFYaS8xaTFIbGFTNzk1ZFBoRitPK283M20yZDA4c3RXU0FUejdVSHdEWUlv?=
 =?utf-8?B?S3ZQeXcrVkRzR2RBR0gxZWhSd2Zkd3FRZytRL3dNbTRobUdiT0FSdDREakww?=
 =?utf-8?B?bUJWVFJHOUtKMVl5YVlvMTNHd3VJdHExSkxRODA1TnNxaUJXK1VZRlgxVDNj?=
 =?utf-8?B?dFc3Z1MvTkFLQnRFZ3BvSC9qZVdPV0wrYVpHUHZEVjAzMzNVVXFXN1RZK0ZV?=
 =?utf-8?B?MlVWc3JwWDkxd2tCMzR5RzhlWVBaRnJNN1VIMXJjeGhnVnZnSEI2UjVnMCtV?=
 =?utf-8?B?VEdRZ1hBUUhBaDVrVnkva2lQWXNwa1R0K2k2NWZIcGhNMkNTUVI0RmNoejBZ?=
 =?utf-8?B?RkNRaXVtRUxsa0xGWllSUlRWeWl6SDZ4MWx4YjNnLy9CM01FcG5uOExOa0Zp?=
 =?utf-8?B?dnJkV2xzbDJYL040dzN2LzFSVGdxK1AvSDJkSFRxUjZ1RGVSZnhaUWhKQm92?=
 =?utf-8?B?WkNZa1lqbXIyN2l2d0R2UlNGTkdSRDlXVDY4ckJnRjVZdFcxdDMwTURvWkRk?=
 =?utf-8?B?aDU0K0poL1BITThjWDdGQWRZT3U3MDFRMzhuU3pjekc2SWI4dlFFUkc1bExx?=
 =?utf-8?B?QksxVGwyZFdxR3lrdFJGRW1jdjFvWlYvU2N4YVpZVzd5aXRTRFlVUkhoSWVV?=
 =?utf-8?B?YUxSRXRpUlFwQnVoVzA3UDhzY09SaEo0dEdtZzQ1eGlQUkxSM2lEOUNWc2pJ?=
 =?utf-8?B?Q3ArYytUN29CcytMYnlGb1BaSmlWT202T0huMHFhTm9GVU1teDd3TVd0bUMz?=
 =?utf-8?B?dzFXcFhKdTRsUmsvV2Z3SENFeVhRYU5TVVVtU0hQUjUvQ1pQN1VjaUJLWmhh?=
 =?utf-8?B?YWdzV0F2cnJLZEVuZDdZYkxEdEQ0UFh2dXZhVnpvTi9mUng3c0xuS0Q4Nzhu?=
 =?utf-8?B?OHVTYXhObThLdi9QVzhmaldPMVNiMngxRVRMSkJFakZYRnRNYjZjVS9tZ0Ry?=
 =?utf-8?B?ZUlVNzlDL0VRU0xWbkhTSkpTZHBESGRxY0R6Mml5RGQyQUJKMWwyQ3F6OGNn?=
 =?utf-8?B?OWpTZStZOWFQTmlpMVhVT2JYN1JBPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8466df3b-2564-41d5-603a-08dac23328b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 09:17:00.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk5nFL9Wj8iL86XcCAx/ZrwTbsOAhU7vIK1CrfJcW5BUj0P186xRes1gF/e/94SRAsvjhw6vDFJ3awM7YoozWP+8s0X2BR8SVpSaUnwBduY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6412
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

On 11/8/22 18:15, Sebastian Reichel wrote:
> Add board file for the RK3588s Rock 5A board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to access eMMC, UART and Ethernet (i.e.
> enough to successfully boot Linux).
> 
> Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |  5 ++
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 63 +++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 4230881371fa..6bff4c42d815 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -744,6 +744,11 @@ properties:
>            - const: rockchip,rk3588-evb1-v10
>            - const: rockchip,rk3588
>  
> +      - description: Radxa Rock 5A
> +        items:
> +          - const: radxa,rock-5a

FYI: I was wondering what the convention was when I submitted the
rk3568-rock-3a.dts. There are boards with the compatible
"radxa,rockpi4a", "radxa,rockpi4b", "radxa,rockpis", but also the
"radxa,rock-4c-plus". I went with the slight majority and named it
"radxa,rock3a". Maybe you would like to consider "radxa,rock5a" in order
to follow suit.

Best regards,
Michael

> +          - const: rockchip,rk3588s
> +
>  additionalProperties: true
>  
>  ...
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
> index 000000000000..25387a000341
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "Radxa Rock 5A Board";
> +	compatible = "radxa,rock-5a", "rockchip,rk3588s";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +};
> +
> +&gmac1 {
> +	phy-mode = "rgmii-rxid";
> +	clock_in_out = "output";
> +
> +	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	/* Reset time is 20ms, 100ms for rtl8211f */
> +	snps,reset-delays-us = <0 20000 100000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1_miim
> +		     &gmac1_tx_bus2
> +		     &gmac1_rx_bus2
> +		     &gmac1_rgmii_clk
> +		     &gmac1_rgmii_bus>;
> +
> +	tx_delay = <0x3a>;
> +	rx_delay = <0x3e>;
> +
> +	phy-handle = <&rgmii_phy1>;
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	rgmii_phy1: phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0x1>;
> +		#phy-cells = <0>;
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
