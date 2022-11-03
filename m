Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA9617ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiKCK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:27:45 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C107DE87;
        Thu,  3 Nov 2022 03:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWY+u8cTKhfk1YxmHN36vUzLCZsLgbU8vSWCCjZ6a6EYYWeUcTX5WtxY7QHE5KzSRLoncNifm8ZY+CXDf5pQ7zN80q7bDKawpfOiV8USxU3xwFPjyrZbIjWK+ThCBw9JEH+75oS2toMiEb5F6lsQOCRxcI8eqydyculW8ZUkVDg+qfUZeJ0OwFDV5Mi1F26Pxi+N5ZeV1BPA+Jeh1wb7kIMeo80hYsyRkbkcE2VhAnWg58cGUcxewVMGdrSQES4AJCNWWSzDJyh/QL7ornFQshNYLt8tPaMoMJhyH4Gap0HeRqrVBUro2lWcyEOjvdcd51hDRDRwlxcECEZB2F8dOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hbg+omnVbXXF8eScSlUsXJeAtDLJ1P7eMjfNskEzUEI=;
 b=QBatqZ+XD3w3UU2HTQqw+gCzfryBg2N7D1GuLL2Zb0Pkvn9+AeDgveXy/QZujLREQr6e/bMjaLgvql57i0ScjSG57nug7tJkSL1yl0DLoaJ7LS13gV4n3vzU9XGbGLwgBflLcKrHFmCWnrM2bagE1dqMKW4HHmBjyBzw3Jy1hcg0ISGgSM5BWL6RQaoUYLWeJUI5wunBkdUxfQeb1e6F9VcYhaSmqEXFOMk0E5hySSII09LaiSAQzv32ftHlcYVtpvJ/oMDPf6YbTufsx52lk+Bf2haYtPhgleyB/A0nlFk9edA++d7u161zRDz6BbUxLaFV6LPYrZYn3XKfvGCVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbg+omnVbXXF8eScSlUsXJeAtDLJ1P7eMjfNskEzUEI=;
 b=TUkYZEgHZRZFb+LyTc/Ye3dR1Auad1S06Hcppw+3UmSCbnS73Z71oBy87JgJ0KwabexryNwgpEpAJtTkXx5CdVavh8C7Humf/9EuAfGwKT3yMYaGhkG+tnLAJu2kmvqt3cjASKWlDN5f3AN70H6wJEkfYbZFCpDlzO9nN3sLZVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 10:27:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 10:27:40 +0000
Message-ID: <790922e7-e5e4-4752-f1b3-8417b302464d@oss.nxp.com>
Date:   Thu, 3 Nov 2022 18:27:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2 13/15] arm64: dts: imx8mm-evk: Enable usdhc1 to support
 wifi
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        Sherry Sun <sherry.sun@nxp.com>, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-14-peng.fan@oss.nxp.com>
 <20221028144224.dthligupldj2wift@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221028144224.dthligupldj2wift@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdf7707-68e4-4219-7628-08dabd8608e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4xiwqyKTzp042AWXXizSH3w01bX1ctps9tMLuhDFmTCKk2nLq5FP7TSWfLvgo2Sru/GjCmGZkuotgPTebEiROs0rCUe1P8PW8fsH9V1E1uSyDWHaBxgTIh52BCUWgHDwcCXTL2hPfIgapDAivzPNZsgnJIUO46Y0CjQV96Ike5QSwqENG5BNT7MZ9M6Kxk8PLhFzZE9royglYYVkvymFPRCItztRyKPw/+zi+hg/n1HgeHwKxu2uqpv7UKlAhKiI+W4SZU4KP4mNZzaKjHRuu4tdgCg1AtStKXO4tIFHQxKcNHhVPYieNAI0o9V/Ja45+AEJXR0Nt43lhcRffyXOmKxpPF2fkwGbmILv1uGQrQvHKMRUeOOaY8DMUljf/sm4kP02LnokOd7Bb+YuUu9KxTd87vI7eZbHngULCj+rH5Bb6gX6GYQ7vLLV/8JBrzsRagHhfArn2EyP+mxBz263TW6Dn/4R/oObfcq5zexho06BafOHIx9kH5WztMOypF/w/qaAvKWAiSTGsByykcXW9kL5JDJwxcxqf9moB9cnAu6HBWtya1orq1KHiBwTkCoTyUJdsxihqfHBlWqZ9BaUx6X7Yq28o4zBQwYq3y/OC84ekuNEP5bzK2zaHVNhABV2/oBk1ujNdh97SwjnoSvQHX2G875oJl76FfQEr0tSApSSRO+jvC7Gl9TZ5xD+8KbW6PCR1206q7V3tHQtuQ+19qnE5LXaiVreOCCGjoY+qgVZoDwmdZNlXs9rKvE14m0Vvz19d53agkrO0kLJmqxFajQl8eMErBkpuQpl5e8HONBMW4uxE28O7kXcWiuotPr3cQ0OI4R17/KH9xxwEK3NrNS3kc411lAi7Mrc+6qAgFDIIFf+MramqCSdFYpuowz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(86362001)(31696002)(6486002)(6666004)(6506007)(2906002)(44832011)(54906003)(4326008)(6916009)(66556008)(8676002)(66946007)(66476007)(41300700001)(8936002)(5660300002)(316002)(7416002)(52116002)(478600001)(53546011)(186003)(26005)(2616005)(38350700002)(31686004)(6512007)(83380400001)(32563001)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEFjNnkyZnQ0N3dndUg3Y3dDajVmU0g3Zm0xa2FSYS9iYVJpaUJvMzhVcEZV?=
 =?utf-8?B?aWd1QnZEdXhSdUJFdmNDekJFR0QzYjFkN0RsSTl4TWlkWVVjU2dId250N1pO?=
 =?utf-8?B?QW03ZXh6U04rcVU5NDBEOVNjQm52QlhhWkZiQ0p0eXVYbmNMMTNjWWQzTU9w?=
 =?utf-8?B?dFlZVmZSeWFjVzd0cWJVMHUrZjkyeUxXempodDJWRFpBWUcrK2ppTnZjUWh0?=
 =?utf-8?B?bXJmLzY2emsyY0YyVHFBVHlKKzR2aCtBYnlGcXk3bG52eU9MMzVpOURsQ2xw?=
 =?utf-8?B?TlNTQm8yclRaajRYTkdPTW5nbTg5SExzM0lyUHh0ZXNpYzNCZHdsWTVoTW5p?=
 =?utf-8?B?N2ZxeHZPTGhibWkvNGZOWCtPaXF4cmNLbW5RYlJuRFdtVGVvVUd3RmxNWTkr?=
 =?utf-8?B?MGEvTTRVNDZNNzlTRXBHU0dyVytzVlNTL3lydjJLWDBQdXBwVzd3TkVxQm9B?=
 =?utf-8?B?a3Vxd1hBWTAralRvWG9xYnFLbXAzQnVVZG8yYTA4OFhlNjNnMVdlSjVNZ0lP?=
 =?utf-8?B?MDFJL0hrT2dYL0w1QjBtc0RmT2V1cHBPQWloeWRpSEVrRWNXSkVqbmt2ZnFl?=
 =?utf-8?B?cEZQQ3NoYnNnRVZwNDZTdWd2YlFUbmxOclFkWis3SDVwWnNiQ1hlemdlR0ZJ?=
 =?utf-8?B?TlB4RGNodlA2ekVyWENzd1o0SmtOK0c2em1XWDBJaExORGJYSFo0VVZabkxp?=
 =?utf-8?B?azlWQVFwZnFHb1duMkFQYlB0SWxxMnZaUmRDdS9jbTRVSTNFYTh4QU4vaXg1?=
 =?utf-8?B?N1g0SUlBVi9NSVltMzB4QTlVbU5udTdoUllHWkVzdEpLMndweWkxamU4V0to?=
 =?utf-8?B?ckdPMldXN3dEeS9QdU9NY3NGNVZWbitodzVJdWdlZlpRNFN3L3hWbDNMaEZt?=
 =?utf-8?B?MXk0dHYzTmNoRG9CdTR5WDJVTUl1a3JJYlN4aUc5TWx2Vm5OUFljbUJjMHhq?=
 =?utf-8?B?ajNxNWlIaDJ4QTdHS1pKNEpKbE1GNTlpdFdoSHRmUTQ2Y3BWa3RXMmdIVHlD?=
 =?utf-8?B?YnRmYVBabUpBd1psU3p0eS9LckNST0FTc3J6dmpkZm5YdVY1b2gvRFhNL3pq?=
 =?utf-8?B?dzRoczAreVNicUVkc3JhcFZldTlSZWxESmc0bVBiNkEvZ1JBdFlzRlBlcGdF?=
 =?utf-8?B?a2hLL0NZeXMzdUZVTDQ4MDNlTVlQVks2bm9vSnBHN3NnQWpXUnJSQTZmMkVy?=
 =?utf-8?B?WXp4VWhnMUJFdVc2TllrUG5jR3hnZVhDVXVqc0ZGelBqeVN4T1RPWWVrSzRq?=
 =?utf-8?B?d1JQY0dKaWRhcGZod2VNTkRYT25kV1dIblN6Z2ViYVpKUno2ci9iL29hTXZa?=
 =?utf-8?B?aStTdSt1V1BFVEh2T09EQzBJb09CalliQWUzZnlGSnkyRm95UmdNUUFVTUxY?=
 =?utf-8?B?dW5jaEY2ek1UZXRXYnRnaVF6ejhWZjVVMGx5NU1RRUxhOVZWR0ZRaVZUaVhl?=
 =?utf-8?B?NE90Q0ZVb3BUbHNjL3pLem5ET1VPVEo2eFg2Unlqd2JtVGg0bDVpaHNDN0lQ?=
 =?utf-8?B?bkJhSWdqREZBSUJncG9kcTFKYk9ZekJtVDAyV0FpR0NOUGRQV2pTMkRzd0dh?=
 =?utf-8?B?czRsMTVxeWxHQTB2cWJPTTFqNkdrWE1tbm16OGpaQXludlcvODhDV3hHa2VV?=
 =?utf-8?B?bW11bUxyR0VzQzZlRFd0czFlelZvM00vdzIxNi9HN051TmwyUk10dE85RjZE?=
 =?utf-8?B?di95Zm1hRkpDWXhoK05ITVhBMldYOGd5eVgxTSsvQVZxNGdrQkVBbW5LWmJS?=
 =?utf-8?B?YnAySUZjT0hmN1BLclBBT3VOSTBORG1KWGhKQ0RRcnRzbzc5TDd0UEdnYWtU?=
 =?utf-8?B?Wi9HbDVTTjk1MUtrSUtrT1VzaGtWNFVraEQxM2NNeVExczVtc0RJcXRmZUx4?=
 =?utf-8?B?Q0hDZ2ZVWmZFL0JTTFdxa0lBYUxtMTRzME5GRGZvWVZ4c3NVQ1dETmRIeVpU?=
 =?utf-8?B?eTFLUGFDQStSd2dCQldnL2JvaXdaTTlBWDlEUDRmMkR6dTdVeWNwZENOOTN0?=
 =?utf-8?B?ejlMYmt5TG53Wk53WG1TMklTbS9GNnNFV2swdDI0MlN2cDhXbVVVdWdKY1B0?=
 =?utf-8?B?dnR1bFlqdXZGOEF5VHNLQk52RlRjYnJnSU9NY0oyTXZnVyt6ZDhZcW9zWmdz?=
 =?utf-8?Q?AAbG9RuxucUpU/y28YVQnn1b8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdf7707-68e4-4219-7628-08dabd8608e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 10:27:40.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KswJZqG4rhtH0BA288xtVJ+fLuctFjrz/ZQDPm3i7wq2YOwaIroTjbCj+Ei0Q39wxI19w0C/6GSyQWTy9WjYrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 10:42 PM, Marco Felsch wrote:
> On 22-10-24, Peng Fan (OSS) wrote:
>> From: Sherry Sun <sherry.sun@nxp.com>
>>
>> Enable usdhc1 which is used for wifi.
>>
>> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 23 +++++++++++
>>   arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39 +++++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
>> index a2b24d4d4e3e..c93387fcd498 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
>> @@ -15,6 +15,17 @@ / {
>>   	aliases {
>>   		spi0 = &flexspi;
>>   	};
>> +
>> +	reg_sd1_vmmc: sd1_regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "WLAN_EN";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
>> +		off-on-delay = <20000>;
> 
> This is wrong and also unnecessary for wifi?

Patch 14 fixed this. Directly cherry-pick downstream
patch cause this, I will fix.

Thanks,
Peng.

> 
> Regards,
>    Marco
> 
>> +		startup-delay-us = <100>;
>> +		enable-active-high;
>> +	};
>>   };
>>   
>>   &ddrc {
>> @@ -53,6 +64,18 @@ flash@0 {
>>   	};
>>   };
>>   
>> +&usdhc1 {
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
>> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
>> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
>> +	bus-width = <4>;
>> +	vmmc-supply = <&reg_sd1_vmmc>;
>> +	keep-power-in-suspend;
>> +	non-removable;
>> +	status = "okay";
>> +};
>> +
>>   &usdhc3 {
>>   	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
>>   	assigned-clock-rates = <400000000>;
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> index 7d6317d95b13..ce450965e837 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
>> @@ -559,6 +559,45 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
>>   		>;
>>   	};
>>   
>> +	pinctrl_usdhc1_gpio: usdhc1grpgpio {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1: usdhc1grp {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
>> +			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
>> +			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
>> +		>;
>> +	};
>> +
>>   	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
>>   		fsl,pins = <
>>   			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
>> -- 
>> 2.37.1
>>
>>
>>
