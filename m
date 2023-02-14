Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E48695CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjBNI0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjBNI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:26:16 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2113.outbound.protection.outlook.com [40.107.6.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEB1351B;
        Tue, 14 Feb 2023 00:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbGrNPoSf7cCIBt7Ggg7ous/9G4ErBMZBXXpFPIDifSjquDTYmcoacT1/JD4s9V703CA+P2qPovjIR+c8B6dsAqELN0b7a+5vGjfuyDGarSjj710Wl8PI5qRJ6jdTs/PuyxenwSRJiDDUaI4n5JFGaak5bupuSRqMgPq0quBacWHKBuGPz8osFKNFj6lHz8n8ACI1UI7ZbzyOBlMGlDMKkyFiPx+HQ+cZerzEJSF7zPoMuC7gKx6i4c4EITNSN3lTpF5MH+a+oMkpUlhM4nMGuse2jfCc0EXSp/cYD4VWE8hqJQMSMGrslHgZocGNRVA5GsN+gmMQfQqkv0/Q0xEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRZLEW4Vo9xcaDK4cifuoiwrZT9RKGXGM0wdXt29/Dg=;
 b=lnsNJMyExuSOx0G5zdTuXuzcCxO2k1BYg6ZF4ec8zjDZdo89VHyHotrQR0CV/zU1XofJYUIhZCx1FoHGT6EEwbhTcR2W5QlNZAeodaEY9WzL40EMIj7eq55fRMQGCLCRVRuaH0uuxjmcgPcF1PynpaUy46DD/rNjSdLNRIzPvza7w66LISXOCiHOoYx6DYpoxyO2jraB7Z6wWDK+y31GxRdVBhuUUdfoLJwfC/aDRskkyFMAB/BZl8wejmW5cb2YUOgUEMcUST8RQnC864RvX7ulXDf7wt2EHi/HGXlqwSN7vgaYSrbQRFKn5CFRzwcg/InO8EEhuLorLsgOpJnt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRZLEW4Vo9xcaDK4cifuoiwrZT9RKGXGM0wdXt29/Dg=;
 b=nxTmw9dcM1VkyOSD/mjczY2UCE+uPlKwhSf6cEbSu1I8JR5cCwpG710jLODyGoRHcNyuoXzoFpe3rb7RwLnJ/H0m37NkU1IS/dH0a3TayOXCE6fNuc+O7vTHx63PB+WFTw6yJ+x2ASopu2EYVi4XrUYw/lBS1+tRvXKLfVVMjUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 08:26:11 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 08:26:11 +0000
Message-ID: <c61891e7-4db0-4000-b6f5-ec3f2b347063@kontron.de>
Date:   Tue, 14 Feb 2023 09:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
 <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
 <eef49a1c-4dc3-7517-c760-ecc20704f943@denx.de>
 <20230213195617.xndagbarc3k5kegr@pengutronix.de>
 <b900238d-b06a-a9d7-6892-6a726603b63b@denx.de>
 <20230214081041.6rys3eydmakim2yy@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230214081041.6rys3eydmakim2yy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3138:EE_
X-MS-Office365-Filtering-Correlation-Id: 197fffff-356d-47bb-c300-08db0e6520d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02zTEit2z9iE7wtzT4PfjLkXwfj0S9SnMZlImv6Mm4O7Ft6z/UI7iret1QyjTpw0nAXwP8359stGaaPPKa7juIpiv+5kgl1jgDZ6Wcaq7DHAiOUgcUopm/k/8pW4vtDXx5uPV6BGVFIxsXI6Sz16rIbAWjLGVwzRnuUcZkBilp3grruQYWv5dtHSJJOT0j8mXjPByzMR8Lhk8xkZ4rgygcpltdcPb7wzaVYTL6zPdF0Cv9ihYDAI2QYYYncd0hd71lNvVTflSx2BlbelQXdb8BwOzcc0beU0fkFCVDwIZlcd7kcl+Q5LaHw/1mrxU+ZILa7BmpOL/7nowcAXKWLGuPNT1GSTh4u5t5TSeG6DjrK8CvcrBZ3dMzZNDMvvRaBJxVzF7eXq59Dvvjr5GmxY7//KGjOZDtK/yIF/eVlmWnmNGNFPH7DhtwU21KEVSGV95pAB+JcthDogjJoqCW9+SfF6kXYbS6U5Vu3VsCqGn4HWrtlmHSxp71NIOUrsNn5oaMLQjBZWel/Xu/Kdeg5ZLwH1piqK5M6YsDOZddfDzGy6G3vkhQ0OwD360E5/C1/HHTACrtZjLay8KDEi+eESK9fAis95c4rSkN6388h0Vnb3L9kkdeWluGL4cyDl84rOBqq5QHlqTxz5m8gtxEsG+PPUUtSHxnCrwoDKDmhtYBtA87sXlfaC3RHx/H2FOChf867T2wzqJLU41ZafYRa6POznxpIjbvFoIB8K9pIcPC5WLOBcRn8NGqNtl/EshEw6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199018)(31686004)(316002)(8676002)(66476007)(66556008)(66946007)(5660300002)(4326008)(7416002)(41300700001)(8936002)(44832011)(38100700002)(31696002)(36756003)(86362001)(6666004)(6506007)(53546011)(6512007)(478600001)(186003)(110136005)(2906002)(966005)(83380400001)(6486002)(54906003)(2616005)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU10OEFRMDBSUU5ESjh3bU4xYU8reS9aNk9yS1FXS2R3eEE3Tkp1T3dBUHM4?=
 =?utf-8?B?R2FzUnNhK2FFZHNnOGw4bjdpWVhXU3ZmRTNiSlFrRGpXQjZEMzJhdzRXd2pj?=
 =?utf-8?B?bGR0VjJkUDB4d0JGelJTT0phTzhlSFQ3MWJlS2RTTUZybWJTaHpCNE9KZVgy?=
 =?utf-8?B?UHkxOUFrWklLSWxQdDIzcVZTMDZRalBaaGVoeTZ0Y3BDUGNvMmtXWGpyaUs1?=
 =?utf-8?B?VUwzSDhKN0Z5aVIzUFlOTmE3ZkNuVm51M3UxOFFxNW1LbkJrd1UwdC8xaVh2?=
 =?utf-8?B?MEltYjYybG5mY0pBazFhckM3TDRLeTdzY2NlcjZnSlU3c3R0WElWNUVkdmFP?=
 =?utf-8?B?aWFDeHUySW1GKzFXWXJta1NTS29VZmFKYjhTMHRQb3JPdTRockRvazNSNEh0?=
 =?utf-8?B?V2tkOHp4Vy8raVViU2Nrd1U2Z2JSSUU3WUNlemNnU0MyYXkwN1dydEFiTWJz?=
 =?utf-8?B?dmdUVzlXZmNVWVhCUGh5dDNyV3pEMHdGZkZmNlY4TGlrSlNiWWFOaE82aGpC?=
 =?utf-8?B?ZUhITERDbm1FcllXWXNZS3hkM21jNFlqZzFNYytVVkNxeXhYSzdvMTdlNE15?=
 =?utf-8?B?Z09VeDZEQmVuZUNwVXNXTTY0T2d2UG9CN3pZRlZKcmMzUmtFT1JRUTIzVEFF?=
 =?utf-8?B?TktLdTRXRGpEWjlqVWRpRUN6cS96aWFjQnhRM3BId0Fma0JXMU5SSkp1cGdK?=
 =?utf-8?B?YmNYOXM4R2pFeEltdnV0OWlMR0xGZUh6SXh4enFMNWlPTHh6ZStoM2JRbnVC?=
 =?utf-8?B?cXJKRDE5clE3aDBrby9Vc21FM3cyWVh2dFFhRnlnTlUza1BMQjJYWjQrTU5t?=
 =?utf-8?B?aUNLVUNySTYzSU8yRWNaNzgwaFQ1K3lzRGFPSmhSemRkREJvOG5wdEd2MmFo?=
 =?utf-8?B?bUNnVndtZU5jbUIyeS9xYkxMNml6NGpmUzhScm1QdlZzYVpySWZmc2tMODUz?=
 =?utf-8?B?b0U2TW4yVmYzT2JYWDVQbEJVeUFQTmRROHNPZjFPc2c1TGp6UkJzRE81Vk03?=
 =?utf-8?B?dkZvK0gzb1cyN0NlbXNZUnBUZEJIVkl5NC9CREhOOHFzMWViS2VxZzBGenJF?=
 =?utf-8?B?ZjVKdkZZSTlrVFVHYmxncGRjSXpscy9iTVE0ODlRWmxDQm8rdzk4dTV4Skkz?=
 =?utf-8?B?azRtYnQ1K2JScGdvNUNpVGhqQUlIcTFxMVFIcmQ2cUwwNDFhOVF1bThlRnRu?=
 =?utf-8?B?Zm93elVVNE5YS1JpTzIyb1VmY0hoTWU4V2dJWXJYZ3BvWWxleTE3VlpHSVV2?=
 =?utf-8?B?S3Z0R05YZmcxekp5MlRVdHZmU1JidkZNcllvZHhnY25JUGNObE1xVHEyUklM?=
 =?utf-8?B?emZYQ2pPbXcvYXFFTE9SS3dKUXlWUTNZZDQxRi9kdkNla1FEM2oycU9qL09n?=
 =?utf-8?B?ekxBVE9FVDVWQXErZCtna29aZFB2ZUZqK3RmV2QwR3UxSEdxRWpYbVh6VDNH?=
 =?utf-8?B?RytLdjlBa05rV2s4Vyt4MS8rVVY4OGNsaUtVZmd2T3JzNnVkelNjZmk1eFh4?=
 =?utf-8?B?aERDcy9MeDhjaExtU2dvS2FiTjdWSU9kLy9IbjJyRWdBK0FXL2VRV3o1MmxP?=
 =?utf-8?B?VUdYM3hjU0lkcmdsUFhnTERUWHRoVlZOVk9SaGhRQkczNHVRZVM0WWZJam9B?=
 =?utf-8?B?YjFDUVRtcUZMNFJQZkEySWpCcWV3eTlmZ0owNlJSbWlZMW5aajJGZXRjRjRY?=
 =?utf-8?B?aWJXV3BJT3JraGt2bnJOTGxxMGVzeCtRNTB0K040eStVYUxQb3NwQXliT2p4?=
 =?utf-8?B?dzRQcERRUllSZXRJSmlMdmI0SER2eE5JejFTWnVJNFpjOWt2TzB1YUloeTBx?=
 =?utf-8?B?c09TdEhBZExjNWhkUlVtVk1SRGxmV00wMkpObmVHR05pREtwLzhVaHA1eFFO?=
 =?utf-8?B?NnBkVXh6NWFHOEwwZmZKNCtTeXNNYzNCMWZUam42eG1NNis3dW9GSDNkQ0VW?=
 =?utf-8?B?UW0weVBvaWVoZHI4bDBMdjBOa0lMNmRISlA5aUF2Wk54QmZKSmZSb0lEeGd2?=
 =?utf-8?B?d2daSnBVUTlHQXgvamxuOC9KV2FMTEV3WUcrOUNPa1c1K2doLy80eSswZEti?=
 =?utf-8?B?U29Ob1JkL1JBYk05dDNwSEVybElhclJ0K2ZicWVuY3dyQTBLVFdaamJlZ0JR?=
 =?utf-8?B?d2piZi9WOHUzRjhBa1J3RjNkMUwwVjBFeGdzdEJuajF0Y2dqWWx1ZmV0MGE5?=
 =?utf-8?Q?kC5FMtlWtwrjoAMsTN71GzccJSJAr4+cWDZmeBT4std0?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 197fffff-356d-47bb-c300-08db0e6520d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 08:26:10.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D28W6Ob+whdTqvScfG7DK5Pns5I1wLDL7O2Fr3DjF1mVaJ+jzqOXc4w4ZyVRIRBzaJb8C1EHKQxGWZxBEqVrMKEBJhY/ntYvPEtHHJqTO7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3138
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 14.02.23 09:10, Marco Felsch wrote:
> On 23-02-13, Marek Vasut wrote:
>> On 2/13/23 20:56, Marco Felsch wrote:
>>> Hi Marek, Frieder,
>>
>> Hi,
>>
>>> On 23-02-13, Marek Vasut wrote:
>>>> On 2/13/23 17:15, Marco Felsch wrote:
>>>>
>>>> [...]
>>>>
>>>>>> @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>>>>>>    			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>>>>>>    			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>>>>>>    			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>>>>>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>>>>>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>>>>
>>>>> The VSELECT pin should be driven by the (u)sdhc core...
>>>>>
>>>>>>    		>;
>>>>>>    	};
>>>>>>    };
>>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>>>> index 5172883717d1..90daaf54e704 100644
>>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>>>> @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
>>>>>>    				regulator-name = "NVCC_SD (LDO5)";
>>>>>>    				regulator-min-microvolt = <1800000>;
>>>>>>    				regulator-max-microvolt = <3300000>;
>>>>>> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>>>>>
>>>>> and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
>>>>> muxed as GPIO, which is not the case. So I think that u-boot have a bug
>>>>> within the (u)sdhc core.
>>>>
>>>> The trick here is that the VSELECT is operated by the usdhc block as a
>>>> function pin, but the PMIC driver can read the current state of the VSELECT
>>>> pin by reading out the GPIO block SR register. Since the IOMUX SION bit is
>>>> set on the VSELECT pin, the state of the pin is reflected in the GPIO block
>>>> SR register even if the pin is muxed as function pin.
>>>>
>>>
>>> Thanks for this explanation :) Why does the regulator driver need to
>>> know the current state of this pin?
>>
>> Because that regulator has an input pin which selects between two states of
>> that regulator, L and H, and whatever L or H is depends on what is
>> configured into the regulator via I2C. To correctly report the state of the
>> regulator, you have to know the state of that input (selector) pin.
>>
>>> Since the voltage switching requires
>>> some cmd's before the actual voltage level switch. So this must be
>>> handled within the core.
>>>
>>> Also after checking the driver, adding the sd-vsel-gpios will request
>>> the specified gpio as output-high.
>>
>> The GPIO would have to be requested as input, obviously.
> 
> But that isn't the case. According the driver comment they just want to
> make sure that this GPIO is high to ensure that the correct regulator
> config registers are used.

It seems like you look at the wrong code. We previously had the
sd-vsel-gpios used as you describe, as an output set to a fixed high
level to make sure that the SD_VSEL state matches the driver using the H
register. This code is reverted in patch 3 and patch 5 implements the
sd-vsel-gpios as input as described by Marek. See:

https://lore.kernel.org/lkml/20230213155833.1644366-4-frieder@fris.de/
https://lore.kernel.org/lkml/20230213155833.1644366-6-frieder@fris.de/

Sorry, my scripts didn't cc everyone for all patches, which is probably
why you missed these changes.


> 
>>> Out of curiosity, what's the bug you
>>> triggering within U-Boot?
>>
>> AFAICT the readback of the initial state of the regulator (see paragraph
>> above), which affects Linux all the same.
> 
> According the binding the driver should check this and apply the value
> to the corresponding L/H register but unfortunately this isn't the case
> yet. Does U-Boot handle this correctly?

See above.

Thanks
Frieder
