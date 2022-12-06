Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32316644214
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLFL1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiLFL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:26:33 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2123.outbound.protection.outlook.com [40.107.6.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804F527B0F;
        Tue,  6 Dec 2022 03:25:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpMlpsVaCQfUdCCWauHhrR7IK+D4wYv6ekEFR6bYXdDhSI8uui5IyIseBFxs0fkPPQdNDJVOI4DL9pCZ3Y2QpXkfhl36XAYQvToeBqvVQJ/a3xLoh5ifTxGgCQXY8nW+PYubV5fQrfPdOHDTlh8lwT6QGMpES+hKOJURBu/Ml2ihhZfdquVQicL/rimZVtSdphpBwqSVWY4yhk3abvir37SHQC4iw763bakjlZHCUb5KQDGM4mLpT2zT7sm+0vrve363HSL+1s2Jt3TxYt32PKumNgX+BsLGKF8x8FjwpTc7bafOjgzX6hruEU3H3Q/gssTU30S1qCiPnqguwxC1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE2ZyYjd2tO+FxYg8/3Ezo4quS+dXd6Jb387hhZAQTQ=;
 b=nv0hzG7yCwZBY8JVzzhBvEtklALEqhLvVuXx5WXUukE6eFi/vxO3dOTQsbEkShU8nkvx1ldfdutBHKKm3FSakOHpUPWObTFgCNyX0OHizvK5ukyFO3NzGbt39fWxvS7rsYXaINwvSKJhZAd88ZR/8TNiGSV+pAbPB5/84wSVDixwvbMWSu8rSaDqqp+Fu1yylBHcXLBW0bh67UJxTGJZ4/Fy9VxJ/cHpQ7mRJ9EP4OnRPSffxFsHY3A59TpCl05FVuZbLe/rytTvjpOrI9wyJXgZ7ONPI3it82biP2BOvcU7vYFiP4l8CVgyC0m4OrPC2W5jCFykkWCkHsA4813eOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE2ZyYjd2tO+FxYg8/3Ezo4quS+dXd6Jb387hhZAQTQ=;
 b=egf4LrOHMbEHSxMFDVfsnNGTascd9K1U4Egv8di1PRJ9+LKRM41M12BCa2bbToYl5vzPqboUIr21tXIoa2MhQuiPttDmE2LzXCk/TREac6ZO9teQb+raoxpAHdJyj9zUupRjlQaG8g9d5enxaYAQqi1afn/KPTzdYz05W5ZX7EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DBAPR10MB4027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:25:34 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%6]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 11:25:34 +0000
Message-ID: <b37272ae-a939-1dce-de47-e237c6363a0f@kontron.de>
Date:   Tue, 6 Dec 2022 12:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 4/9] ARM: dts: imx: fix touchscreen reset GPIO polarity
Content-Language: en-US
To:     Quentin Schulz <foss+kernel@0leil.net>,
        Samuel Holland <samuel@sholland.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Angus Ainslie <angus@akkea.ca>,
        Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Andy Gross <agross@kernel.org>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v3-4-0975809eb183@theobroma-systems.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221103-upstream-goodix-reset-v3-4-0975809eb183@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DBAPR10MB4027:EE_
X-MS-Office365-Filtering-Correlation-Id: 760605ec-c539-4cbb-1011-08dad77c972a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWZmjOT8RRHUlJsT1m5MGrQYSU1nwlGUWJm10HFnqEj0UUhdd+BmIOZQBpQp+hdQOG/UCrTVhLtMsM27mZgsGg5qKGuVaEc5vPCfjNpanZ/oqseeliYOjlUnRhWxPwqYRh5PH5inx/S/7i2Vtd8yGquekNFZpZqK53He1j4XmzOrBWwre6YQmCh57iiPw4QY8i1wApGZaucgtuSjh9bbwCfrqxN0AIYi6NQGfbov2cYcy8ecKZitdL/e4/C5Glwz6PAnql/GDB5yLPCK1ctQ2Je4LYX9o8UJqpMifC0fQKU7A65giu+2pUiW7Ck/1isshdmPNOwfz/uEd3mUqHc6DYmwc8OTgCOkdVR+LxMHmczBbxQGM5aFN3ALbqfNQzctBmTDnyugY4vc++H3NwKFUTBp25MYx5FxWiG0coXa6SyJM8UldxpAK98rZAwy29ubBuCQ42wgtUuiz0R6Od7KClO+rqt6hFJeIpwKXrq4bZbHisxjwX+cbeaJgygYuiThhx41wQMIwBwxf6+Qnfp1DIOXKOb2IG03LpVssESpDO+Plp4MWXt/8MKU6YYLAhC7e5oQ4wFdnwzC++/6Nk6dR3NZT1R8GXegDjH4OIyXLOf4iqfRVUGP+d3ONUt5C0PiiqUB//0FI8rhN2bTdkv04Q6YzMep18K8bbmsWruhA5VwBsTPAoG24EohYhEvOE/HP6VoRbb0WhPVQmls3rouwwgqfLNYOuSeKPX8qOrvexyBqB0zQi7e3+rqJQGtFxkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(316002)(4326008)(26005)(6512007)(110136005)(8936002)(2906002)(7416002)(44832011)(83380400001)(5660300002)(7406005)(66946007)(41300700001)(186003)(36756003)(8676002)(66476007)(2616005)(66556008)(6666004)(31686004)(478600001)(6486002)(38100700002)(53546011)(921005)(6506007)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXQyd1JBaUNReUFsNGNyMlJRTXNEZG5ieVhlZTBNRWl6Z0NZUGhqc0wxU09r?=
 =?utf-8?B?dFhrWkNRalY5bDczMTZZV3VJV1MvQ1dDa3ZRSW9BZ0JRSkNQUy9qdENNMnd1?=
 =?utf-8?B?TTdKUDdIUzFVeEdGZm9Fd0hqa2t2ZWhwZG55RVB5ZDhCeFlObWlaUDd4K3NW?=
 =?utf-8?B?Rk5ucVU1SDVrTTJSeklhTDFaZ0RNb3JxNmlpd0l0blljUzlmU2lldnhRWHZP?=
 =?utf-8?B?RnJOWEc3bjVZVjdkUHViZXVOemswb2Zma1F2amJsVWJ2dlFFYjducmw1QUQr?=
 =?utf-8?B?L29GSU5ENmxzVXRwWFZxQlBsN2haWTRXWVd3OUNmM3pBQXhHT3hOYk1wdTFI?=
 =?utf-8?B?WTVWOG5CTFk3WEtBRTFJTWRuaVdCdWxWaGt3c2sxS2pEazhNcFJCK1Nsc0RQ?=
 =?utf-8?B?ZnFRZkxGOEpWY2VmRXI4NFdzRGw3N2xnRGNhb3l6emw3N21pbUppMU5WU1dZ?=
 =?utf-8?B?cXVCbU1jS0JRVGx5UzdFRkNlNTVWTzBBRFhGcE9oWHRhMzRJWXowcEd5OHF1?=
 =?utf-8?B?c1Ivam0rdG12OUd0MVh1MURoZVZPSVhDZ1VYZVpSYnFVNHJ5TVgwcG11Y0hW?=
 =?utf-8?B?MVN4bUxQTmR4aWl5UnBLWHBuRElUTnZIYkc0Q3JJSm1ibWFTdE5uMWVpaGZF?=
 =?utf-8?B?YnRENzJuNUFMWHNySEhYaDA4L29GdDV3aUpMRW9xM2dIdU1Hcmc2VXRiMU5W?=
 =?utf-8?B?K0czZEJjS2I5R24rWEtrZVZWQmdKOXdKbnZYNnBPU0RyUVljczlESXBYdDVQ?=
 =?utf-8?B?eWQvVVpRR214THhoYVMveXhEVUNUaGNEK1NhUXltQVRjTTFuRmhzTUNiT2ND?=
 =?utf-8?B?TmdSL2dwYkFERlVmbjM5NjZzN0dGYWR6cU5iR2hidWhjZUJtQkU5U0hoOXRx?=
 =?utf-8?B?NWpkV2xQUWVMMkdQS3BiZ1BCZStsb2VEZFRmMHoxNGg3Z0wvVXkvVGFEeXBV?=
 =?utf-8?B?SGxLQThxL0s4L1BPVytvSjd2V2FjMzBTbklFZ2xKTDFlMkt2UEkzTytub2N3?=
 =?utf-8?B?RnBHdndHTlpRY2JhNnoxdmVEMktQTTRNaFpuRHFUSDdpN0prMVIxWXNkMitE?=
 =?utf-8?B?Q21HdXpuay9wMElsczJsejVKNmpBL1dkOTBXMnd0V3ZncGg2LzBNZ2xPMEJR?=
 =?utf-8?B?TWlmNnFNWDZLZFRrV2hoaVRhZG9PQzg2UlZ3OWp6d1JrR0dUSnFMeXljUTFh?=
 =?utf-8?B?VDZESWFmbnNkMnUvdFYydnVvN2lPQ25kc3ZDNnJCWkZDZktRVVI0aVZhWTBL?=
 =?utf-8?B?Yk5QT2JGYngrZU90eEd3ZlN4ZDRHSGFsalhYeDZSSFd0SEZFZEpSTExhOXd0?=
 =?utf-8?B?VnNtSHkvUEx0ZzVLNlMzTUF6WFpjYWZwQkxpTGlTdnZXQlBzSUFEMFF6M1Zq?=
 =?utf-8?B?ekpqRHdyM0xTdXpvZWsvU1p4MnBDRWIyYmR3b3Q3NTh6RU9iVUJDYnp6aVpM?=
 =?utf-8?B?VEtpV00rM0Izc1Z3cm1QM1MyamlNV0pSSE5teHk1Y1JuRWJxUGtpNU53M0dt?=
 =?utf-8?B?TTVnZ255MjJVWjBwWGhZdWpFaGZnVU1naGFxSi93WHVIL1o4TkppUXgvdWs1?=
 =?utf-8?B?dHJLS3M1dDR3SUNucVpuS2E3UWNrKzdIZTl0NDN4MzZwc05IV1FySzF4MWhO?=
 =?utf-8?B?YzlIOUJDRHp6SW83TXRlMUZOZmoxUVNlNXNiVlM2VWtsLzNVWU5OVkhqYjJz?=
 =?utf-8?B?RS9Cd3UrSUx6NGw1WlF5cEp6RGgxZVNyNFNHRWU1VW5KZU5tTnhKa3lvdHd6?=
 =?utf-8?B?UVBRNG5CUTJEZVVZdWp2dGttNzNtcHN2dkxJWEhLTnIxaFNKQzBGTUN4ejJO?=
 =?utf-8?B?REZpLzEyWC95UzdKTGplaVRIYlBIY1IyVkxYeS9VZlNZMGtXbnZxZXBXVnZS?=
 =?utf-8?B?dENkblRuOHVsUVEyaGxMWmtpWUI4eC9CcEZuaEorYjVvYlJSTndkakc1NEtU?=
 =?utf-8?B?MWh1M3E0RnZOcndpRmRnWHM0N2o2emtldmpUU2N6bU5zazR1QllET1VhNmJr?=
 =?utf-8?B?QVdaK244clU3WUs1SkE2RDBadzNvT2FoTnBtUWtDTkJ6dGQvNFk3a2pzRUFO?=
 =?utf-8?B?SFF3b2dlYzNuZDJZOW5mTk5MRVAza1R3YlpiL1p2d0ZkMUhKNnZLUCtFYlkw?=
 =?utf-8?B?UC81aVJVTW9SWUhJK1BGVHNkTUQ5M24xSk83R2dBNTNzRXhaRVlwWVRBQ0d4?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 760605ec-c539-4cbb-1011-08dad77c972a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 11:25:33.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1UfdtVZ4rD5MuFzpdkVY/VVoK5CC0St3HB79xaYsS8d35p+KuLTn+VnZ5jaG5IlOgEFrmH7R8WyNBKwlil1cP02dp4WYbxdbyR5U7mJaHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4027
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.22 14:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The reset line is active low for the Goodix touchscreen controller so
> let's fix the polarity in the Device Tree node.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm/boot/dts/imx6q-kp.dtsi            | 2 +-
>  arch/arm/boot/dts/imx6ul-kontron-bl-43.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
> index 1ade0bff681d6..dae14aaf803a8 100644
> --- a/arch/arm/boot/dts/imx6q-kp.dtsi
> +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> @@ -188,7 +188,7 @@ touchscreen@5d {
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
>  		irq-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	ds1307: rtc@32 {
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
> index 0c643706a158b..767ef5da76136 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
> +++ b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
> @@ -29,7 +29,7 @@ touchscreen@5d {
>  		pinctrl-0 = <&pinctrl_cap_touch>;
>  		interrupt-parent = <&gpio5>;
>  		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> -		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
>  		irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
>  	};
>  };

The imx6ul-kontron-bl-43.dts misses a working panel node, so I'm pretty
sure it is not used and nobody will bother about change breaking
compatibility. I don't have the hardware at hand at the moment to
perform a test, so for now:

Acked-by: Frieder Schrempf <frieder.schrempf@kontron.de> #
imx6ul-kontron-bl-43.dts
