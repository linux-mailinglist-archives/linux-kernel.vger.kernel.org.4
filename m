Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6E617ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKCKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKCKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:22:58 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2695A6;
        Thu,  3 Nov 2022 03:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niIJJ60AfJIKC+wISRNWEeiylR2GVGPOIzInv/r5OKXG5DrR4GusXxjhgRmyJf5WoUSo3j4kIwCgpEULWLftZCk3IGF/DqkAPEtWxjnzUUrwErMI6kd0oJHovGVVrv+LMELmp/tJ8uWHs+MSg3p+m7ybOR2olmYP/lr6Ud+Idks6XrZdMfh5gQELXTyFxrW3ixOZVjeE7Kj1F4QIuDlqkXalxLkExwHF9eA4WzduFT1ZtPr1jx6CQ9W0QmRwwSCUCM0eBfTrAS5pooUt6sN46M/TSK6ePGIlpgCK+i30r9YZU1gKTFSCOjnpMeBAeDpt1TrgZFo5LBl2XTPdXy7hAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRqqkP8qkEao8Bpu05CXAMOU7J66OWkJdfMwfXWj2+k=;
 b=ZUmYa/2IQbNosB6dCDBiMeieCjV2AiUuVoW6wUj0bt4nyI2gyE9q+pcJ61ZCevdNCILgxLhV4yCOmG80jRl49EOAfnxVcL7AUJQhNoCL4qdhOajp+R6rOhvoJPN+uNEVwOqvi99UxPar7rf5Vyg3EZjpQ9ih85xga0elIcMi1ZfcrhLWK0lRKQyglN2WRK9iC4JVvp/9zHD7Jg9G+SmqTa3aa8xeGqVhLvTFTzCMDuxq3cRwUdXyRvVBxk9sqd5NWvCM2WNJTo/hx0eZqvA26vYe94Nrm5vbzKk3APWK2BU7tnBt7+8v1tFjL+jzJlvqoxdMYIyQK+4MZkZvALt81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRqqkP8qkEao8Bpu05CXAMOU7J66OWkJdfMwfXWj2+k=;
 b=WGqbx0cKilA8yWXPFoq4HYt4uKi0qmrsgCvZl8RdLZ7cCEOc2+tZkbGx/nXZCpC/jZZZBRtXl553pQNETVyE41N/wy4NB+Pd9L3nI9qNA0lquyM0PZFGJ4a7vqse1NMCglURbw2YavGlol992bYpX9PIPbnhfn9zSN/W5RRjl50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 10:22:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 10:22:53 +0000
Message-ID: <fbb62cdc-ad27-d2f9-2f5c-ee64f14b103f@oss.nxp.com>
Date:   Thu, 3 Nov 2022 18:22:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2 03/15] arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-4-peng.fan@oss.nxp.com>
 <20221028145306.66lcoycuzmfb5yug@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221028145306.66lcoycuzmfb5yug@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c11220a-eeb2-465b-0b5f-08dabd855dcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSf2FClM7SuMlKhT3lar5DPjgCT/FulT4UGAS4Aq1Zjetnt8YmJBts5DeSf6Z/Emdwid2pAgvCcsHXETmvWU94wZix/Ho0/sQSHKfa/q+ogkVgashzfjwaYXHh5sNG6ojRpXyvActMNNGTH6UDUxjvVQVGWk/OOOqakjOcXjvZmu9w6PAQR7/bLFarG9hg1ZQcFI0phtC8U4J/2G2ur777cwLO7v8BnwYj1wL1azjM7AJwo0nC6PrQ/OIa/GrRqdZYURd1g1F9MTZwiFyHOzuVVSy3lAqY+dUFljDoWE+iBsPof6u0er/cNbUmzWz1kJaxi76u0Ay07Z+MfOO8Ef6rI2qhwQQFJiKtFzURJyILpdcOHhIZ4fnrCZSUxQAWPSQ7ywV86yDNa1O34fmNiycMaK+g5gM0f36vKGqIRpEcZFtCvRoJN1Y053JpQBd7CXyt1qKynkGJQRGGdckCk8Zfw6cy3ascN+5SR7RaYgH1bqyc2OEWIplGuh+TioxWrF5ZEeJ3714ZAFuuI6WyE9hj3lkjh1+sUpoEB6v4dWujFiV1XADgYjhEQcuc21L4HqiEjuNeBdGZJS+QgrjDdxerDbSgwJdzmWuuYa/p+8BYfEKyJWn9av6ya1jcroyag15WHIfcf70pjVNkL6NtZ6StYe5Z/jydxwSaWEiJKQeh9CYwWUUgVQStDSouIbzRIc301MNSP6BusClVWsLZUB+KTs9XfPY4q/4LCvhtdRk/w+nP+AkFNxpLTbJ1wswTrN8pLVl9uk2NJc+NUnqddEYiOqzY97plCbCmhXrwAPF5ol+Z/iIhOtfm+eXqhB7V3iHt5fWEi/ZoCy31FEV0jbSwEE3l5frxAa9Gbzpt2BP5FssOUCFHeUwhUrlQqxJi4F1YXxUeZzbSflYfL8f8dtQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(41300700001)(316002)(5660300002)(2906002)(44832011)(4326008)(6916009)(66476007)(66946007)(6506007)(66556008)(8676002)(8936002)(7416002)(6486002)(478600001)(6666004)(52116002)(86362001)(31696002)(186003)(38100700002)(83380400001)(26005)(2616005)(53546011)(6512007)(38350700002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1NSRFNRb3BJb0FtMlFvVkw0MmtoTzJ5Zi9pVzNMRDkyc25mbnhNd2U4YnVy?=
 =?utf-8?B?d0NtWXc3djV3WnFjY1pWdUI4UkYxbWFaRFdQNUMvVTkvWnd0cnE5MUNuK2VS?=
 =?utf-8?B?UFdoR285QmpZaUg3YjlzOFIvbVBObmRBbHNJTmRaNTdwYUVnQUN4ZE00cEdr?=
 =?utf-8?B?TDJyV0paMUlQcFpMQXYwVEVoUjRwc21nclZiK2tYNjEzUjVidnFuNmpFeEUz?=
 =?utf-8?B?QkRhSm1Ha1E1c2JETy9hQ0pYaHFLTzBvOVUyTDdEZkZZMmlTWk9RTkZXc3NI?=
 =?utf-8?B?djhNd2NEblcwelRVVS9IbFhNQTliRlVERVFLc1dqTXdCWlhoZ2M1bVNEbjV2?=
 =?utf-8?B?R1Vnb1NTUk9TRVdvUWVhTHBvbzNvZHlzN3BMYzZwaGpCR1FQbmZXb0hXTnlU?=
 =?utf-8?B?MmpsNTZIRlpuVFQ5Z0NtcjVpR1dSVWVCcFJndUdsa21jbzdQUGtyMm9ZR2Vw?=
 =?utf-8?B?bkNScTgvUVZxMmJGdTljb2U0ZGtCSGZhRlBBZ1djeWVWSFpHL20rS0hlL2p6?=
 =?utf-8?B?Vk9iYUpMZXdwQkVDbWhwbUt2cVQ0UStsMnRjT3FZb3Jvdmp0cUVOL0tPTXZp?=
 =?utf-8?B?SWx3d2xwTGJKUXcwdzB6MTV5dzhNelpiUCtnK0YraVNtN2tWZ0J4LzI2OEZl?=
 =?utf-8?B?MFB3aVZGZmF4b2Jub0g1MUd4Y3R5ekljOXYxZnlvVlh2V3prcGFuY1R5cS9Y?=
 =?utf-8?B?NzdXeGxNL3A4UGtWRFNYa3pmZWZVVEtSeWJ3RDFnZzJyV1pQb1ZYWlNJa0la?=
 =?utf-8?B?RnhuNHBDbjlFU0JtWDV0Tng2c3pleXFWb1lYd1UrWXRqUUpIdUNJZVZGeGFU?=
 =?utf-8?B?c0FHbTBaWnIxVDVhb1lnc0hDZ056UngrVi9yNFg2aHJhKytQZGpBVVJGOUJl?=
 =?utf-8?B?MkhMSkhMU1ZYTUpwcGhILzdOYWp0dko5TGpXU20zcXFWdGpJOGNSSkx2TFRx?=
 =?utf-8?B?ckJRTTJIdEtsTkNFSnlMb2gybUwwQk1LeHo1aVQxblFWUGV2TExBWm9LZWtw?=
 =?utf-8?B?TzdBNnB5b0czZHg2UFJBM3BjTmhBZkNVeHQxbGN5MU1DZnRFUDNPUUlzSUI5?=
 =?utf-8?B?TEhCOXJ2WTJ2c0lyNHBub3o4eWY4eGlGaW9qRFJKbitZaTN0MzlZOE5UL3Uy?=
 =?utf-8?B?K2YzcEJkSHEwNmpENXhGRDMyaG55RFlwNThIU3VXTVRZeDFlV3hLNlBpYlZ1?=
 =?utf-8?B?VkoxU0JDV0MzaS81ZXJVK0lNb2NsVkl5RktrT2xIZlVaKzNvbUs5Wm5YSjRt?=
 =?utf-8?B?S3NZQVRDcUdTWTB5MWhveC83b1JqalkwQlNwT0xNRGltMjMvWi83OTBsVFBp?=
 =?utf-8?B?SVlLWUZvK0RFVVJFT1R2T2ExZ1ZXcVhaRkw3bHJwcFdPdFcyVjZSempGNTlE?=
 =?utf-8?B?UDJmVzhnaGJGNGtYM2gySkRaMjdyanlYbk02eHRQb3U2VEpXLy9tZmZIWHVz?=
 =?utf-8?B?bVBPT21ZZUkwYUJJck55VlR4RGFIVTlDSjMrSFpieEM0b2FLVUhxZ1l0b1pE?=
 =?utf-8?B?b29DVDhFQVZBaEFRN0dRclRzbFJLQjF6TGZvYlN5SEhDYkFLMXNPUm1UeTA0?=
 =?utf-8?B?QkF1bEpsK0o5WThDVTJQQVlySVc3VlVEZ012L0p3ZVc1cjI1WVlBUDZydzB2?=
 =?utf-8?B?cTc3MW5YZEx5c1J0eXBWcDVlQjZEVHNKM3F1bTZaMVlaTlhGUUR2azdqVDNB?=
 =?utf-8?B?dCt0UVoyRk14RDJHcnZjSVFTY2xYL2h5eDk4SHBSa3V6UzZpU1hKaS8yK0pE?=
 =?utf-8?B?eWdxaldUVTdvd204eStOYlM5VlBQbXhkVmdzcWtxWGZMQzd1NTVjTFNtcDhR?=
 =?utf-8?B?Z0xkc1lYU0lRcENneXd1ZXRGYVBka0NKdXQ2U0xzem5kWHAwQy9DUTlSK0xC?=
 =?utf-8?B?cUtuM3JIRFJTSU56Nk9YZjVtQ2RVdkdMcmhVMU9yY3VoVmdkamRlbFYwZ0pi?=
 =?utf-8?B?YjdoektSR0JlWU1KemE1aXZhTTQ3UitFdXkvQk5Jbm5kaFhvcFIwdTFaSTRW?=
 =?utf-8?B?V01TR1ljdlg0b2tUR2k0M2dSMzZ2d3lJUzVNLzNRM01ISnZkYS9iZUczYzBS?=
 =?utf-8?B?dWRxdEdYcEx4M2h5QkJCUUV1d0NPOUllejl5RDdqbHJ4RXRtUjUyQnVmRC8y?=
 =?utf-8?Q?u7F/beq0GI8GuxRUXmyakjhlv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c11220a-eeb2-465b-0b5f-08dabd855dcc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 10:22:53.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVOkjT0U5bK5bjI3WOrq2kcSoWFydOE+I4NoQqa+sp0wEV3N6fytijfkH0dsCzu1sgtILfUcUgNw+AE921Ttrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 10:53 PM, Marco Felsch wrote:
> On 22-10-24, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Per PCA9450C datasheet, the voltage range as below:
>> BUCK1 0.6 - 2.1875
>> BUCK2 0.6 - 2.1875
>> BUCK4 0.6 - 3.4
>> BUCK5 0.6 - 3.4
>> BUCK6 0.6 - 3.4
>>
>> LDO1 1.6-1.9, 3.0-3.3
>> LDO2 0.8 – 1.15
>> LDO3 0.8 - 3.3
>> LDO4 0.8 - 3.3
>> LDO5 1.8 - 3.3
>>
>> Currently we set the board voltage range same as PMIC regulator
>> range.
> 
> We did not therefore you aligned it. Also are you sure that this will
> not damage the boards since you're lowering the min-voltage and raising
> the max. voltage? According the schematic, BUCK1 is for VDD_SOC which is
> min. 0.805V and max. 1.0V. After you're change someone could set it to
> 2.1875V. Same applies to BUCK2 which is for VDD_ARM and should be within
> min. 0.805V and max. 1.05V.

You are right. But I think DVFS already limit it.

I am not sure very sure, let me drop this patch for now. I need confirm
with HW team.

Thanks,
Peng.

> 
> Regards,
>    Marco
> 
>> Also add LDO[2,4] in this patch
>>
>> Fixes: 5497bc2a2bff ("arm64: dts: imx8mp-evk: Add PMIC device")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 +++++++++++++-------
>>   1 file changed, 30 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> index b4c1ef2559f2..a4cddc5a8620 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
>> @@ -248,8 +248,8 @@ pmic@25 {
>>   		regulators {
>>   			BUCK1 {
>>   				regulator-name = "BUCK1";
>> -				regulator-min-microvolt = <720000>;
>> -				regulator-max-microvolt = <1000000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <2187500>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   				regulator-ramp-delay = <3125>;
>> @@ -257,8 +257,8 @@ BUCK1 {
>>   
>>   			reg_arm: BUCK2 {
>>   				regulator-name = "BUCK2";
>> -				regulator-min-microvolt = <720000>;
>> -				regulator-max-microvolt = <1025000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <2187500>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   				regulator-ramp-delay = <3125>;
>> @@ -268,40 +268,56 @@ reg_arm: BUCK2 {
>>   
>>   			BUCK4 {
>>   				regulator-name = "BUCK4";
>> -				regulator-min-microvolt = <3000000>;
>> -				regulator-max-microvolt = <3600000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			BUCK5 {
>>   				regulator-name = "BUCK5";
>> -				regulator-min-microvolt = <1650000>;
>> -				regulator-max-microvolt = <1950000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			BUCK6 {
>>   				regulator-name = "BUCK6";
>> -				regulator-min-microvolt = <1045000>;
>> -				regulator-max-microvolt = <1155000>;
>> +				regulator-min-microvolt = <600000>;
>> +				regulator-max-microvolt = <3400000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			LDO1 {
>>   				regulator-name = "LDO1";
>> -				regulator-min-microvolt = <1650000>;
>> -				regulator-max-microvolt = <1950000>;
>> +				regulator-min-microvolt = <1600000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			LDO2 {
>> +				regulator-name = "LDO2";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <1150000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>>   
>>   			LDO3 {
>>   				regulator-name = "LDO3";
>> -				regulator-min-microvolt = <1710000>;
>> -				regulator-max-microvolt = <1890000>;
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3300000>;
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +			};
>> +
>> +			ldo4: LDO4 {
>> +				regulator-name = "LDO4";
>> +				regulator-min-microvolt = <800000>;
>> +				regulator-max-microvolt = <3300000>;
>>   				regulator-boot-on;
>>   				regulator-always-on;
>>   			};
>> -- 
>> 2.37.1
>>
>>
>>
