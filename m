Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419C72389C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjFFHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjFFHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:14:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2090.outbound.protection.outlook.com [40.107.6.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6410FD;
        Tue,  6 Jun 2023 00:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biCTU6lxDXqs4ZWlzNL1PYAwStS8UY5CvP78sw6dkooc1AM/OfP4uP03SB3VTkniVt46frKnE3XcOegaXcVa0QcHg225zZVSSjQqBO6fhSNM6oJG/DfpADhQ+/X0K6hKcisdDjfqnBwLxMUJOg5ZjOoEBwNou5hqkaMm5v9yxzHKJqcIQN9rCzu7cENI5ZUbborrXqtF66A06pp7n/h22eezsLwdpTtvSMm9/aaw0TbQnTvx+xSdIds0NOdgr8GdZve01FEOfLSsvhNYJQvxj9aY20w52wc0W6w7B1ZiAR6SxsPAGb47Xot4JADL/aAeG/ap1QvtMGYH4MQvt7sOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC3IjfN/GlAtIDChixGSQrmJ0t/Zdl0mC9KceILmrkI=;
 b=HLjiAz+ouWt87ouQTaBI0rTVvJpCSNwJG0FFid5HZukOYvlZzsc0K88nZt+ENGrTf3Kz2jatQCnBIkH4L1QbZFTi03zU33P+HfgSMxr/5Sgu4xgrb0DSDtbghWsFvMdxROCm8jElHTGhEyY8QBnclRm4UhAeR9hHeovzewoG1Hmq/b9SUuybaqJvqaPuzB1QAIWpyMyAJpAiqLxTkD75UoKPufHSuM1INkEkFB60xRrzR5KFUmQqLxgNHR0TVoH6FEqEkiX9eoHvyOrpvBRz4Fe3RznKEGTGuHqjKpNK4AuJ/eePJ4CLIOaedQUZKiZymd0IzpUD+JoPC2on8Q1eqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC3IjfN/GlAtIDChixGSQrmJ0t/Zdl0mC9KceILmrkI=;
 b=DF//Gq5iln87sc3c7GBEFSYT4KeeyUceqGcY0FUPTnJIjVSCQF8eI5AGMdkSrBR82Fail5qd1UTh8eP3gr0S/ZO8H6FBxT0reG08waleqMZE/ESN/SIa8yf4gCshGxZLOFtEryghRsBF0jDFe92uYIy3Z+MdNTYxBDbCiTodV9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB4016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 07:13:26 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:13:26 +0000
Message-ID: <f821e008-c984-2f60-60c0-46220cada909@kontron.de>
Date:   Tue, 6 Jun 2023 09:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mn-beacon: Add HDMI video with
 sound
Content-Language: en-US, de-DE
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230605223323.578198-1-aford173@gmail.com>
 <20230605223323.578198-2-aford173@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230605223323.578198-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB4016:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e8d82d-0162-47ab-0ab2-08db665d85d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fnc4sH5Ir1eIEhhnmXTKlYKN1mtix4idYtBi7hoh7yo/tZl06Ac1qqnHyuhKHmZmG1JgSaaYtK6cvsshj4QcdlPb9uLpjqgei9hL7wXLyarT6PioZn+7Uz6vQ1icthpFzdcF3hyIG0aOzjNt1T5vDtaMR7Mujx/VYBDZdxMIrArz9pk4AfORbbJGm8F/Y2wfbSYlOf5vKnxVWZbi1wuAU5sptC/QS0cpqU0tkLg6kH6+gzg15IeYLJ+/17aufQ/gOt1ZciJqwy4kzYYKxng8Z95QL/8oDbvaYwyEAkxnAEdVd4+6Oe+YVa6NsJIg0Pjqx/pRKuGfPuWSR56mOaPAoD86GfavpkXlK/s5bCbffpg5L1q4JGmZDikq/jO8Pde2Ug1Ga+CUDOjfxbb62W6REqPaSUjwjU4i+kgZl7nYpR455zjQHG76FNRb4oaAYGXF7kYGKEY+5jh88f4VwNfoN4r2sxPrSIynmAag4yS5xAV4dIdVFpRoQJtdZwpq27dls5rLayXHCI7zMM3cyKf4rUtmTJ64DwhYpyy+cBHsXM26Om1vOnzi4hX93PPXHtXrOS12zFcaV7hdyjrlrUmeBN+uFmQ7oSxIKkAVcbecdhzKLFpC7zM1dN8k1i3AoUThV7Zz22KzPOWJj/crnzRXFcsBPKfSeIfwSjFqFUxtY7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(2906002)(6486002)(36756003)(2616005)(83380400001)(31696002)(6512007)(86362001)(53546011)(6506007)(26005)(38100700002)(186003)(5660300002)(316002)(31686004)(7416002)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(44832011)(54906003)(41300700001)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDl0R2FpNTZ3UHJBZkxOdnZlWWh1QXZ6TXZkSnpZU0Y4dm93ekE2RHY0NXhM?=
 =?utf-8?B?K016NWRKc1lBQ0RIQzJ5U3hvakN1UkQ2b0h3dUxaMkZHZ2w0K2Q0Q0xGNmc1?=
 =?utf-8?B?VzNnM0dLc3Nac2ZVNVhsbytiNXJBVTc0YVNDNEJRRTVMQi90ZTJ0MTc1cGFP?=
 =?utf-8?B?WVRrbFlVVkxkUlVEVnNxeU5Id1FwUFpVZEdCbFJ6bjBTdUFvVXlWeWtkcUlr?=
 =?utf-8?B?TXJWaENYK2RYWU01QUVLamJPdVBZbXJoU1dxTlRuMFdqTkp5eU1zNVlUeHl1?=
 =?utf-8?B?N21lTklFcE1mdU9wVnhKK2pnODJRdWJBR0o3M1k1cVdyRGhKaEVGUUhES2lz?=
 =?utf-8?B?eDkwNThvNjBLSWx3Y0RDbDFTL2xJb2s1cHJ1SXdCakljSmE4UnFCdHplZVdV?=
 =?utf-8?B?QTRMcEF5MmNkdThYdGZGNUpjcEJMT3ZiYzNISDFiSjNIVjVXYzlGZzllb1Ex?=
 =?utf-8?B?ZFExaUFJbnh6d2ZNNXpuVFRoekFxdUR3VjhDNWZ3dkNQN0tKT09wQzdZd3RM?=
 =?utf-8?B?cmxsc25QclEzWlFYTDcyVUZYdklYRVJJMUZSa3YrbG9BczlpTXBBamw1RGxN?=
 =?utf-8?B?dnBiMUVMbS9IMW1hcVR5ZFdtUjB6dEYyUjY2STBBcnEwbkJnMTk5cE1qTzYy?=
 =?utf-8?B?QWwzekFZdjArcGtTWUNuYjFHb21ETjUyeFRyalNHOG1RVm1hQ0tKUEFJL25q?=
 =?utf-8?B?SE9rT045QXBoY2dpb1dGczkzWm9qTlJMdVRBdVoyZ1gzOHpYb0paZHl0K1pa?=
 =?utf-8?B?SndFSHo1UGtzaWUvNUdqTjdhc0Z3WnA0WGVvbkxDcnpRS3RVUjhDOXdXNm81?=
 =?utf-8?B?VDVpSGU1bjlQbmxGdzFKcVRDenlQS2pKZmptUkt2dlczb25TUi9LVzJkcTZF?=
 =?utf-8?B?d1B6M3QyT1Y2c3dpREZIaFFOWEZhdGN6WVNWVG1ibjBwd2RVaVJlRVlycTRF?=
 =?utf-8?B?RlMzUXBMYWpiaE4ydXBJQkNBbzBiRVc4TWg2d2JhL3ZoUXdZVkZuOThLWlJy?=
 =?utf-8?B?Y0pHSG1takdLc0VOOGVRUGxRU2hXYzMyRmE1Q2pqQ2R6WlJ3VlBoMFVwSWRO?=
 =?utf-8?B?OVpvclpGL2kzLzFXNUl3RUhHZDVKWWd4ZW54QXA4MG1UWjdaVTF3WWpxTHAv?=
 =?utf-8?B?S3FMbDhKa0lTZGJGa1FRSHJxWUNLYktDb3hWOTRMaG1yczBJbVpEMFZNcFky?=
 =?utf-8?B?OHlLR3REc1cvdTh0OU9CMC9jcmREVzVGM1dEVjkyMm1JUEMwOGpkWkp5cEQ5?=
 =?utf-8?B?VzlxdjFMa09UZFdaYXdRQXE0Q25GT2JkQk1lYWxnVTBIakY5MFZ1TStWM2c0?=
 =?utf-8?B?SDNzekczVXdnRFRZZUVQRElyRldqQ1NwcjduTWVUSVR6L0dRb0dPallHTzc1?=
 =?utf-8?B?RXQrOXdIejRDQldObzBhT08vKy85ek9ZQ1RUd3lkUHc1MC9GYk4zcG9abFdJ?=
 =?utf-8?B?Q1c0Rk9jajBIL01jUWYvMHlHUUd0MmFTbDBYWUczL2lqRThqcDNISDJxaFVz?=
 =?utf-8?B?dEN0TXRDbFJzdTBPYlZLRmZ6SnE1ZTdGc3RuWDlRdzlSYnBBa3IydzhwYUVr?=
 =?utf-8?B?cHFsUU1UeEgzNmVFV0ZpT2dxWVIxRXdCK2VQSWZvTVVWendtZ3p3NWo4S0dZ?=
 =?utf-8?B?Y01EYnRTZFluR2UyZVlXVmlhYVBOTWxNK3AyQkZuTTdDSXc5dWlDRmIxUE50?=
 =?utf-8?B?UlhDNWcvaWo4S3FPSTdMTUtMSklXNU1oTmNwL1R0V2g4L1JpemZuM0sraE9K?=
 =?utf-8?B?VVgwT1pXeUhyU3hMcW9CZzd0dTNVVkxDZVZEL1BQVzR4bklZZm9IQ3N6Vk1u?=
 =?utf-8?B?RE05dmlPVzZ3ZVp4MkZlNGtlVEdiTno5Y1BUT0QyNG4yZ2tlYVZ6cXZZbjhR?=
 =?utf-8?B?VjVxK2pzS1QzV0daKzcwdWIrU01oSXRTRks5dVNoYVc1TUE5YitJeklOK3o1?=
 =?utf-8?B?U3JaTXpCdHlKV1F5Z216R2FyUmFyOStDbkkxeDZLNW53T1pwMlBYd0YyMmNj?=
 =?utf-8?B?NC9LMFA2SVFONXNSZTFCRVNaakY2VlpPaVpLY2FSVnZHRHJzNVJJeGd1VlRI?=
 =?utf-8?B?VTBaRzN6Wjl2UmxoTzl0bld2NHVnQ24vekxhNnVlcVRjMkxWYUFaSTlsUy92?=
 =?utf-8?B?aWFobml5Tnp6U3laUlR4ZTVDSmxtb1Z6STlSdDZvenFJK3ZvZk9MNE41Z0I4?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8d82d-0162-47ab-0ab2-08db665d85d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:13:26.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bm1rJ+5p1ls/J//MC0Gh+LrJ4SVpjVmhhBI00LeKIhV8Yg0zhS7B/qAhJ1LWX+CtXVDJr1RNrJm3Fs1yaA2w4wDp//lrrZBpJKSZNjMLlSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4016
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 06.06.23 00:33, Adam Ford wrote:
> The Beacon Embedded imx8mn development kit has a DSI
> to HDMI bridge chip.  The bridge supports stereo audio
> and hot-plug detection.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> index 1392ce02587b..2108ec8c019c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts

I have to minor comments below, otherwise this looks good to me.

As I'm trying to come up with similar changes for our boards I also have
some questions below. Maybe you could share your knowledge on these.

Thanks!
Frieder

> @@ -16,4 +16,138 @@ / {
>  	chosen {
>  		stdout-path = &uart2;
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&adv7535_out>;
> +			};
> +		};
> +	};
> +
> +	reg_hdmi: regulator-hdmi-dvdd {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_hdmi>;
> +		regulator-name = "hdmi_pwr_en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <70000>;
> +		regulator-always-on;
> +	};
> +
> +	sound-hdmi {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "sound-hdmi";
> +		simple-audio-card,format = "i2s";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai5 0>;
> +			system-clock-direction-out;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&adv_bridge>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	adv_bridge: hdmi@3d {
> +		compatible = "adi,adv7535";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hdmi_bridge>;
> +		reg = <0x3d>, <0x3b>;
> +		reg-names = "main", "cec";
> +		adi,dsi-lanes = <4>;

On our boards we have this working with 4 lanes. But we also have some
boards that only have 2 DSI lanes connected. We don't get any image in
on the display in this case. Did you ever try 2 lanes or do you have an
idea what could be wrong?

> +		adi,fixed-lanes;

I think this property comes from downstream and should be removed. I
don't see it anywhere in the upstream driver or bindings.

> +		dvdd-supply = <&reg_hdmi>;
> +		v3p3-supply = <&reg_hdmi>;
> +		v1p2-supply = <&reg_hdmi>;
> +		a2vdd-supply = <&reg_hdmi>;
> +		avdd-supply = <&reg_hdmi>;
> +		pvdd-supply = <&reg_hdmi>;

Please sort the reg properties above alphabetically.

> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +		#sound-dai-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				adv7535_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				adv7535_out: endpoint {
> +					remote-endpoint = <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&lcdif {
> +	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
> +	assigned-clock-rates = <594000000>;

Just out of interest: Why do you need to set the video PLL clock here
and how did you determine the "correct" value? Why is this missing in
the i.MX8MM dts?

> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,esc-clock-frequency = <20000000>;

Same here, I'm interested in how you determined the "correct" value for
this property. Are there any rules to follow?

> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +
> +			dsi_out: endpoint {
> +				remote-endpoint = <&adv7535_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&sai5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai5>;
> +	assigned-clocks = <&clk IMX8MN_CLK_SAI5>;
> +	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_hdmi_bridge: hdmibridgegrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_hdmi: reghdmigrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11              0x16
> +		>;
> +	};
> +
> +	pinctrl_sai5: sai5grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0	0xd6
> +			MX8MN_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK	0xd6
> +			MX8MN_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC	0xd6
> +		>;
> +	};
>  };
