Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133D64B334
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiLMKZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiLMKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:24:54 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C165D6;
        Tue, 13 Dec 2022 02:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYR5bL+fcxf3pPPGNkaT2J+iUfUhNIQE0lfYrZ4nu+XqTE0igUyym+MjoGgXpkMdEN6Lp+ZV6y0xtYZZi12RSycv4VZ42R4QZTRFhc+fExZv7HAHtYFLT+86772KlAi6IfeXfvPLuR0JB9SdbqleCxE73h42Ai2uSfc2VMn1RcOthM13dSKiX9lKJNBBLxbnMEJy7TMw+ypW61/ADmu5rkQNcd2d03YG77EST4gewvJb69/u9w1VVXQXmSEKKmJYOAV//VADs8cTxubsoqxC1d6+KbPnZ/v8m6M+cqQ9Mi6OS7+aBMQmom75/GGDz4aHxwIr08g4q568M2tma7tItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhe1r/1mKK+FL5sFLCtadnDGu7CiL5WhfA6EKLXPpdY=;
 b=UAweBDeZcUlJNuO49Np0rCv6HFtFy/Nw+MpNq0tjVZLZm+yd5Mz9fEFIseyCyUr9DHIUOIxruNBPjjlAidy3lHohh//06Dljk8jR+WM2mMjRMS2ZmTu2YVw4X08cYfDW0yDB77h6JojEZCj8lCFbSspFMPPtDwsKie2adOoyQlWvCp053Xpg0pKs0hi9gwpGdjPRf3EsiEtHGnFPhYJj5NkFhj5EtONtCz799cd+DpBtWcja0okXHB8VELKO0O9XnvY7rb3SyVvSEd1/W0n1aqsuTA2Q/PkiRhaOiuIa6qmrSm3A8Ezrx79i4OthfdSR92H043N72LiMh4SaULFBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhe1r/1mKK+FL5sFLCtadnDGu7CiL5WhfA6EKLXPpdY=;
 b=erix2YCn+nl9ZOy9ZH3dMUbICit+sDy0yig4krE1wDjkpTIk/gHuF3HgzYGwUZKMjCBIdW2u1nsjrTMH1eGqRo3C+7IhGw+K1PIQmoeaRrDiigEp2yN3quDqtK7y2Hck1vpyWw+gnqbcJz/YNvd29GDZOuvHNmC/0a0LfG9L8HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB8682.eurprd08.prod.outlook.com (2603:10a6:20b:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 10:24:48 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%6]) with mapi id 15.20.5924.008; Tue, 13 Dec 2022
 10:24:48 +0000
Message-ID: <dc192963-3229-7cba-6a46-a809e39cc7bb@wolfvision.net>
Date:   Tue, 13 Dec 2022 11:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 9/9] arm64: dts: rockchip: fix touchscreen reset GPIO
 polarity
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
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
 <20221103-upstream-goodix-reset-v3-9-0975809eb183@theobroma-systems.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20221103-upstream-goodix-reset-v3-9-0975809eb183@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4399a8fb-c642-49f1-c99c-08dadcf44302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iGvEiNPHJnXwGefgq0TAWA/aWHkf5msIrp3YNri2+1AuVCAZQ+TfkoYIMtq0F4q1BgGAGQGFb6aDfT5+u/SqWE4oh2KSJSMdt+MPBgzFtyHHSqUJRdUAK16Zoav6G992P2MmauLZdEqIot7c7Bw8Qqqq5FLWAgujC6MQEeNJQMWMDZYDoJUzn3Lgo/+OT+iYN8Ej+XTDWI6RkDzw7H4n2cx+O7tyXzlI2HN34RTspnkQzzQhnfbqaeNpZkpqJQOkNo1LIw5nbumq+E9AFRgQ782Vj/v9q5cjP9DRNlCt7c/4K2w0SCI9ZVWBSQ0343mGaJav5p79AQAjZw90H5bdPDJno/apI1HIB4DVUj+ddt1o7+RnOc9m3W5GFhjF8yJ1Z8jnSvlzkhXysHDxZeZ1WOKCu1mTfOn+pmdESoR7wETxGlb4/Nf4qS8LOLsbnOHJrpy/LCFo584PbVeftGQuAQcfcAWXNRqiIQSi1TBTD0EzvxvsWiabxMMioWMTo0KEbUDXA6XfGNuTrAvDBXKBLhYKCzM09T6LhTqs3GVsnbIvHvCpCJ3msn3NgFypw4MFOQTarjbZOcmQD2v6lOSqRkpxMyB5HP5AwY18FHj72168e6/vVt2IxUfq//27/SAKol+gU1MOyTA+17b0cbPOaItC1751wxNdfa7BsCLxg1lkHSDvDJq0a5CmhZ6Hm52K4YG3ukRDVzrM4hTOptEPk5AvWIA9HjZmwrul2fcPDITchjrlkdG2rfgUs7/iQC4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39850400004)(376002)(396003)(451199015)(6666004)(31686004)(316002)(52116002)(110136005)(86362001)(478600001)(6486002)(31696002)(83380400001)(36756003)(921005)(53546011)(2616005)(38100700002)(5660300002)(8936002)(44832011)(186003)(7406005)(7416002)(6512007)(66556008)(41300700001)(66476007)(6506007)(8676002)(4326008)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJrOGlweDRSeHV5aG1ubGJ1b0hISk01WDRwczRnREhlbkErMEcxZ3FUZFo1?=
 =?utf-8?B?QlFrcXVEZlovUGUxUGk5MktxeDdIM0Z0cEY1RUtMM2ZXZlRyY0M5QXlhNzFY?=
 =?utf-8?B?TlR3alROOVVmR3NxZkp3bHQxMlJxcmNaR2RKdFlRdjFpdlFSSWZyd2hGekJj?=
 =?utf-8?B?SHUxOHZWVnNpSXJaVHliTSs1dGFRd2tnMWcrVldBdnVST1lUMGh6OFZqTzJ3?=
 =?utf-8?B?REFPRkY0YjFTOEdoNGRMaTlERmtSUkZLb2Rzelo3Uk9qWGxGTUIzamRhNTl2?=
 =?utf-8?B?MlFKN1g0SktNNFFadURKeml1RzQ1Zm9ZdE01OEJIQktUR1p3V1FuK0UweVhU?=
 =?utf-8?B?MDYvZUhIUDBYT256d1gwY0hTOGx0c1hSaEYyVEhidzdIQ3JsMFV6Y1hWaUZs?=
 =?utf-8?B?MzdYa09qeUxhTUVSd2VkalBtZkV1Vnp5dXcrUld3NGJHVjFEd1FXZjhLeEIz?=
 =?utf-8?B?WTZ4YXZDTi9IOFNKdFc1dDNWNkxCRDZqcTd4QXVTdUF5bFQ2YzZldTBtZ2tl?=
 =?utf-8?B?Mk1ib3A4RzFCTG5DcitlUUg4Zm5QVnpxazd0ekdFcUc2djNFTXZEWDZEeEpX?=
 =?utf-8?B?RmpZenBXdEtmakJNQ0JSYUpRYUwyZUJBSkRSaXFpZVpvdFlBUnVxMVJCWDRI?=
 =?utf-8?B?K2FhVVNCR1hrYlR3NFNjaFRwYU5NYnR1azA0MGFhVG4zY0c3dzlPeGtCUDhy?=
 =?utf-8?B?alNDcnBtYzhqeEkxd2xXWTRkd3g2TVZQSFlpQ3Judm5xeHpKVXNaYU9zR0lP?=
 =?utf-8?B?eTJNVjRZWkVUYyt2VldHdVNHSEFjOGNPNVg0L004QitsT285REpMVk5QcmF0?=
 =?utf-8?B?azc4Vk5FZFd5eS9uVGtHSkdyMXlnN3NGNE5VUVoyYVVrdzMyMUVXVnZHaTFr?=
 =?utf-8?B?blVmTytzS3ZRdzdmTFJvVVExd3I0OS9kVFl1d2lETzU3OHB5TmVPZGpuU3Rp?=
 =?utf-8?B?MDdoK3QwZ1k5bkRBMitYanFYOVRaU0o0ZXljK200ZnlSZlQ2Rkk1aXFJWFZq?=
 =?utf-8?B?WFduYlFzanZTa2tPdG81Tkc5MXdEK2pWMkRvblJIZE4wMkV3Z3BPcGZWUWJk?=
 =?utf-8?B?TzEwK0xiODJORmVuTXBYaFpwN01XdTBCeHVDN09mU08vOHhzQ09kUE5ueDZP?=
 =?utf-8?B?WXhacUdUVlZFKzl6ZElXZ1ZxV3FsTEJvd3cwamtLVEVNZGhzZjN3VVVJSXlJ?=
 =?utf-8?B?SHJSSEdCQ1NkaG9RTWgzdnBzYWlTekVjOC8rNFRhcnJHeW1PbzVLaVdsdlhr?=
 =?utf-8?B?dFBMMnFGRkRnRkNvZHVJWlVrVTEyTERMNjU3Und4eTlHTXNaWHArZjFySFlO?=
 =?utf-8?B?N0haamtMQnJLNGZPbFh1WXFOTDJmS2pQajVvbVd0Qm5JdlNFYmNHZTlTUDA3?=
 =?utf-8?B?dXFjVzFKNS9GMlYzWmVwY24rV2I5REluSnoxOS92aXBMMXIvNStudmRzR1Vs?=
 =?utf-8?B?bkV6Wmg1Yk9abVJwRGJ5M3RHUzVWOERnbFBPblAxU1llVXBzOG9YSGt6QzNl?=
 =?utf-8?B?Nm1HME5sWFdQQVZTa3NFSkc1Qmd4NkFXNnVFcm9idVJPY25idHdJZWtTOG5k?=
 =?utf-8?B?am14Z2pBNmZGQXhDbkpVWHoxTjZ3YWh6OWF2N2JIUUFOOXNmTUJEQnMwS0NK?=
 =?utf-8?B?dkI0d2NNb1NaeEpHemphbEtpc3l1bW5pVnR6Z3FzRFJ0Q0trbngwMTZwazNs?=
 =?utf-8?B?UFpTMVBxc3N3aGRxVGVNaXNHNlE1cnBBWGVkVGlQenpEbUtyY1VyY2d3QnRW?=
 =?utf-8?B?aWlQREpPUVhJS1p4VXZYV3FGK0FObmsvbnZGcGQvRmR2T1ZObmFtZjQwVUVS?=
 =?utf-8?B?aW1QVXo1b084aEhKckFCVWZDRHhoL2cwMXpnQmVyZkdFRW1NMkJSQ2hWcmpl?=
 =?utf-8?B?TXpjWE9zVWlsQmc0N0NvbkFCUUkyNEpKTUpPUFZGTzJ5a1BLMnRYeFpmSVhv?=
 =?utf-8?B?a0hOMjdlcE9oeFVmekRGZ1FSU091dXBZWUVRQ1BoR1daMzZ1dTg2R216MjBn?=
 =?utf-8?B?SUlOV2N5R2NUMnRDbjR2bW9Jc2tPbmhpeVBuNG0rdXh5YUd4NFdJV28zemdm?=
 =?utf-8?B?cHNsK0NOeGdLZllZZ0xqUHNkbG9SbVh3bTNpU2dmMExhOFZiM3BMREJSc1Zt?=
 =?utf-8?B?SmorMlRCQjBrTWEreHlhTzFFZzZVdThhUVM1WTE2OERBS1NabmdCY01MNm8z?=
 =?utf-8?B?K2F6NHQ0N0RQLytqOHV4a3RiUjhzTGNTUHgvYXltZDBMbFlkdXdaTkFUQlBt?=
 =?utf-8?Q?LBywzEyFEgq9M2BY7jIRrkXsAiq+7AzE1q2q5do89c=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4399a8fb-c642-49f1-c99c-08dadcf44302
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 10:24:48.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ik5UiOkBWAJA62gWeNuZf6osdvP63Q7XL4dc6HHz0IeZRpT+2hRFmi3eFW3UpY6cqcMQRgLVOqUoM27k5FnSG5CZCEHMbcsndY67m6/knjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8682
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 12/5/22 14:40, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The reset line is active low for the Goodix touchscreen controller so
> let's fix the polarity in the Device Tree node.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Cannot test at the moment, but LGTM!

At least as far as the RK3568 EVB1 is concerned:

Acked-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

> ---
>  arch/arm64/boot/dts/rockchip/px30-evb.dts          | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> index c1bbd555f5f5b..2087dc7299446 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> @@ -420,7 +420,7 @@ touchscreen@14 {
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
>  		irq-gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> -		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
>  		VDDIO-supply = <&vcc3v3_lcd>;
>  	};
>  
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 78157521e9449..e63491fb443be 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -588,7 +588,7 @@ touch: touchscreen@5d {
>  		AVDD28-supply = <&vcc3v0_touch>;
>  		VDDIO-supply = <&vcc3v0_touch>;
>  		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
>  		status = "disabled";
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> index 674792567fa6e..234531aaa430a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
> @@ -495,7 +495,7 @@ touchscreen0: goodix@14 {
>  		irq-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&touch_int &touch_rst>;
> -		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
>  		VDDIO-supply = <&vcc3v3_lcd0_n>;
>  	};
>  };
> 
