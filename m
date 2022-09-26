Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80B45E9B92
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiIZIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiIZIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:04:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0777E3BC78;
        Mon, 26 Sep 2022 01:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpWMPTYAkgFga7+nFiSpdI60x9mmSD3XcLUcxTalYBoquM8ivb7FCdmkocD+iWY+L6FqEMnWoaYWPQyi+4vNyEfl89dErqfU7x3eCLGqyPau9lsF+tWYyry2sPzWuxReyg0it1XH2Znu3aUxfeW0gkUd5zbuRHNpEvdSPbb/0UE1nqwP/tdjwbZEPYuSFZOxEahIcIEd8rMSuUDmjLG22FQl0RC//YNx+L56u4lFd3uhYVy9bmPFmAO1EtMPTCG18pZwEQGV72QYnUMdXhhQqimw6tCJFz+gb9b1ZLy7WjxzNJFthDYnlh/KcmbSCY0XBNfQukqZQaFW8thlefC8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=douLsr7CZgTUXgdheX/spDItnNLPiZQyrdhbDS7+XZA=;
 b=CLOjmEVjkPSXQxSgbQwrBoMKdVB2X8tdBbX/Ld5nD0N5AHEawbcrHrir+5renie67Cs5MXb5xk3FBLFcPpjb0INAWacCdbgEWk0P78qUSFLPE5ahfHmGxKWgPSmzFq59eAVEcKfPizgoZ5k//gIVGaFWStL+aw/pfAL9TnJv4fdQkF8E+qK6ktYkQf2qqR+meumk7lZspVy4w3LpZgRQKdE6M8n3i7BlB1zBzts6aTx/qj5mB6x546FFYoKKiZkc1L9lMmfz//VRPgMEY2SyjZPUxWrsUez5fESNR2xNOo0SawxZ7/bQEuNSjrsutGg1P/9xv+OH/JfN9CUh0ed+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=douLsr7CZgTUXgdheX/spDItnNLPiZQyrdhbDS7+XZA=;
 b=ITB8r98pj1Zwav8xpVQkamBmsnXMqgRHopZ9zkYcfkMnH+k7tGjD3yis60zLSYMGkBa+Y41B31pih+hLka1+TDhi0Dym30oqbHIDye+UwCUhVexbua6GP0Ig9ymq8O0v8D9j1Xf+BCPKCheagZxf1+qRVcAjubdM1o8+ThL72Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6954.eurprd04.prod.outlook.com (2603:10a6:10:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Mon, 26 Sep
 2022 08:01:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 08:01:29 +0000
Message-ID: <4e386714-84ad-c9bb-f94a-bda70c8f95c9@oss.nxp.com>
Date:   Mon, 26 Sep 2022 16:01:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V4 1/2] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de, sboyd@kernel.org,
        abel.vesa@linaro.org, abelvesa@kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220923074943.981127-1-peng.fan@oss.nxp.com>
 <20220923074943.981127-2-peng.fan@oss.nxp.com>
 <20220923092758.krr64sqhn7zyjges@krzk-bin>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220923092758.krr64sqhn7zyjges@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: af76ac8f-83cb-4b9f-3892-08da9f955176
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBX0xu7eBw3PR9oeGPQupvOaz92mq9Wtdu2Y2pCHtWK7pR7Hc/WsdTVza+SBXduZg+Fv5kouR0Kk8FW1GHJ79brsrNJc2epmS5ZYA2JNm9RAxRZGRyJVGD57U0ahC+8SoTZ5tlUCy1rRtK9p3A4OpfBCyYYL6bCJBmx0K96frDK4NWZx8SwJvd1QW6bbO7kGrMP2dJH109ho8Y5JA5yt7mCHyY6TUhoQTM/6veU3IkOzLSlcGPsop96Toa7MeLCmKGsJIfRd2G4zTdBzAI8CWmiKeKvsWQKT3enm/TOfDctsgsl5PMGV8rVbJ0B2+0cNwfznljnMhl+k4lmZ32EJPy9c1RQ/EFOfhyusGKVw5KIGDg8ZiQ3VKQdAFSDFnulNeDaaTugah4VKWyhC24nwnC/1lunFwPtQwf2Qp1shbfWDJRTzp9DBtQtI8+on4FQzd/NUj5da8yqLH2mxcjfdddEAnU2SYVBVZ2aACLf5STcpccMtDuRCLIhU4wLRBmXuzgruzle9bnHYoA9ddB+nsq7L0LojbF+5phFp/qm7NmzYA+U/7CS+ZiGFWTz+0WFmnp4/KnDGWDaYDIHlwwQK9N5LAdIokl2MuwRaqeyBtQ6LyTwCd6WwJ6GSrOPF3omy9kA8/lu7mNhmRqmTFX28tlDV85PrnTsa5kEUT9Z5F4GRnqQbh8r3Boz2TyaRw5ZT7WMXBsJhGJyzj7Z0W25XL3x8m3ySJvAPGPjwWe1veR/ayDUOULL5RDzkXGYaiHP7HHry2VRRaN/x/rk1Bn8h5cYWeohsaVzSELaULJmvRfQ8atcZso8yoMsHO3a/J8PkVfwjGGxJTqn92bVPYJSYulODgH4UPU1j0SUfE5clJUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(8676002)(966005)(6512007)(8936002)(6486002)(66556008)(66946007)(66476007)(5660300002)(2616005)(6506007)(26005)(316002)(6916009)(7416002)(4326008)(52116002)(2906002)(83380400001)(186003)(86362001)(44832011)(31696002)(41300700001)(6666004)(478600001)(31686004)(38350700002)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9RcGVRem5hN0t0NWR0cEx4MHRpYmpSRHNDNXN0dXNQdmthMVRiWW1CTU5p?=
 =?utf-8?B?TDdqNFc2ME9uT0d3TWVCRWpjUUFxanN4bXBSRFE2c1NUMUQ4SXpRV3p0M1ll?=
 =?utf-8?B?aW5UUVdzL090NDZxazBVRXVOcjduNzZCYTJKOVJNUEtlWTkzN0lBU3RaL2U4?=
 =?utf-8?B?ZUF3YUgrTXZpSGlhZURvTFppYy91bWdSZHhiOEJiNmVoNmFJVlNWbEJyRzRQ?=
 =?utf-8?B?NFhxVkxnZzNJMFl0RW9MbkhRZkxkbi9SWWREcDFHSkpPWUpDQSt5YjBmUGlH?=
 =?utf-8?B?Zm1IeEhGMnB2TXRXWFUyMWNJS2FrM0lHN2N1TTAxeWx6Y3FtS05pZ1lHWDJM?=
 =?utf-8?B?bituNDNWOHd5KzA2d0hGTFpzc3dZOTFuNk5sV3kvUEpFQ0hlUm4yQlVmOFY1?=
 =?utf-8?B?QVlTc2wzbjlSYk9PTTJ5TWZ5RjVvQWhCYjBDcEtOdzZ0cjloZDlkZWZENCt4?=
 =?utf-8?B?b01aODVaWlZjTHY3SlNhcGFJU21UeWZremw0KzR3TkJkN2dVckxxYTRLaXpr?=
 =?utf-8?B?ZjFkNk9oQ3dUT0RmVTVEbmVkMDJzZmEybHlVR2hwWm0yd2xONVdzWm5lNHBz?=
 =?utf-8?B?aGJLbmlOQnVKRGR5SXdvWks4YmcvalVOejZwc3grNFhCK0pZRUw5SlNLNWg4?=
 =?utf-8?B?djhYeDU5aUYrRTBOc0gydDJzWTZWa09YakNqTk9hZlFxM1pRLzNTeDRDV0VX?=
 =?utf-8?B?MmU3ZENrQVNTazMwcWlBOTVRdUMyd1JDRllmUnA5c0FOUFVwRzlIS3RwSVZj?=
 =?utf-8?B?b0tTQ0d5amNBM1pIdFl0b3M3U2FNRFpVcXo3Y3J1bVpRVnB1M3Q4b1oxUG5I?=
 =?utf-8?B?UCtEOXJpU25nb0RPVEFXV1FzVm04VGV0UzhkNW5OMDdsYWg5K0tGTEZPNDdj?=
 =?utf-8?B?azNJMUttRVc2QW5VYzdnYyswVExlV1lLVFNsbS9RVm4rMGwrSWJzS2E1ekhl?=
 =?utf-8?B?ZWhBZ1J4dXhkVFZmSU1GL2NjUVZvdzZPaUJhVmFkdlE2Wmp4NitGWkJITVBh?=
 =?utf-8?B?SGpveUt5aWxyL1pZLzZWNTRmb3JPaEFzcUQ4TWNiRG9zV3JuZlVNN3JlSG8r?=
 =?utf-8?B?eHpsMHhlbWZ0SFZMTzZFdEFNNCsrK0JadTNYQ3dmcHhqN3BZNyswQ2I2MHMz?=
 =?utf-8?B?WFk3SUkwSWVyMVZaNXl2TlVUdCtoSklvMUpKVzM2Tm94cWlkVGtFdFpjeDg1?=
 =?utf-8?B?ZjdIenlQSitMZ09wUURIem5QQjBRdVRYMVZDYjAyWFlhZVl6NnVndXZuRFNO?=
 =?utf-8?B?RzhoTGFNSC9FTDFXYTBoK2hTOWpFd0tpSEhZTlZjZFRLcEVjMWIvYmFHcEFk?=
 =?utf-8?B?ZngrRnRhczYwK3pzbDlObWNjWVJEK3FDMFZTeGYvZzYxT2VTUTRaS3JvdjM1?=
 =?utf-8?B?b2QxMEtldXhvYkpQL3kyNVZmSGc3a090aHloWFRiQ2pLRnUxUkN1K3FxREZ4?=
 =?utf-8?B?OU81OE4wZXpuUHdsaHU5M1BMb0dFMXJaYjRJWGp3YjVDWnk2UTREVjQxdEFF?=
 =?utf-8?B?SUM3SmljM1NxbHczRW0xNGNjeGpHNHZhdFZRODhnS3NxSTJ4Y0FUQjZ4K1dY?=
 =?utf-8?B?ckwzZi92NW1hTCtURlFrcjloL2x3K29taytxZEwvWXAxOXBRTGFFMVRlSlJB?=
 =?utf-8?B?YXcvUStwL0x4NDlyM3ZZNEVpaWM1NXIxSHllRWhJaWZuQ21UNnoyazZldjZ0?=
 =?utf-8?B?VzY1clBQaER5VENxN1FwYzZsbEhxN0lCRFpWV2xOVVBLZ1BiWjVrM1RjbVFv?=
 =?utf-8?B?dnI0OFZndXpYTjNkRmRlNHFnV1ZpdUVWNmNMb3NudS9weTdNOCszUEpuMjVp?=
 =?utf-8?B?dDZoRWk0RnZ3NTlYM3ZFbHJUeEY0UHZsMU1qT1R3ZjNTYkhZbXk1ejljOUN4?=
 =?utf-8?B?QS84cjl5d3J4dk9aMzhkbHQvZ3dTZ0JlZ0dndlVWYWlCUm1CcVZQYW1xOHhI?=
 =?utf-8?B?YU9hcU5Rb0RLRGpNR1owcHMzdENKUS9MZHNZL0FhQ3pOVVZ6RXljdk8wN1pq?=
 =?utf-8?B?MGRuWjBHOHJRazZrdExKRm1XVXJiNmY3YVAwRG1SeXA1bFBYZlJWY1lRSGJB?=
 =?utf-8?B?MllaSThLUVNweDFJd2FYU3ZHSVg2bUlQOGdHTnNLUTh4NUtIQzJETmVNTjk1?=
 =?utf-8?Q?okehMzrZ18o84jjaCle8AIn63?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af76ac8f-83cb-4b9f-3892-08da9f955176
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 08:01:29.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRkC03hfzesR6+XfJ1EoidCCBYCBy7xPQ6Np73fByjToiNM3oIgdLeMzHSqc6tQHc7sEFPAAivj2CO51sbwrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6954
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/2022 5:27 PM, Krzysztof Kozlowski wrote:
> On Fri, 23 Sep 2022 15:49:42 +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX8M Family features an anatop module the produces PLL to clock
>> control module(CCM) root clock. Add the missing yaml file.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/clock/fsl,imx8m-anatop.yaml      | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

This is expected as reported in patch V3, patch v4 2/2 has dts aligned 
with binding doc.

Thanks,
Peng.

> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1681462
> 
> 
> anatop@30360000: '#clock-cells' is a required property
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> anatop@30360000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
> 
> syscon@30360000: '#clock-cells' is a required property
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
> 
> syscon@30360000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
