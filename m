Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED23617ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKCKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:25:50 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E172BCB3;
        Thu,  3 Nov 2022 03:25:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6+XCqVTpBgCYsJJpm5V8o3/j9kKvGD9g02sAAfanFVxao3XncOqgZdpKDF4+4LoZ+WyynGcV/LnQwUWJC+i5VyfK6IR8NcOiv7Yk0BQ6BTvThN4q50aghxLssiCnqFtjzAy4ECG2tjVu49g82Imse526TEtM2zQXJZHLfNqbQ7fF9g9WmdIQTqe7fk7wqYmmJBo75Md7IM7NmQ9oYUYFPkMSCkPaeRO/E6tL0uprQRialbi4ykBRboVukNugMdWpJ9sj0aU+PjgXYoU2sUnOa15E+42UGa07kQjGbVCF+CNgb9rDtV1oyNQ4XcZpeeiavbsKOqJChJCWGf85hD1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WKAIDnq3N0uMoQHN3bkFZ8PLtIwCoiijFK7+nz9McA=;
 b=htnc6gTiR89RKgQbmVr3uIELCrd+xSxx0h5q7Gw/pPwy2dF/iQ7YivkA0vtVU2cOt4zLs4r69ANbkwmn3zUAPDCtbX2YiE1gqQ49TFCIX4Vnc6KqcJmbmsIRe2JtzXlGryU+cPQg7G2qmrokx2Q8kMkn/jJ95SMzSzbt91tQ/VAZ7BoPOtaGAOfaBMabx8OXSi265BG/HR0tISB7y81xPJ2nvhCoeb/pDr30Y54vnNdlHBjSBTRODM0jQ3v77oASkV1pQtlBf/5aCfmvsty27tep49oFMMPH4hlxr0+YuGZ5SYOC4KODUL03WSsUR3MYbl6FGO5KznmvK3uzQjRmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WKAIDnq3N0uMoQHN3bkFZ8PLtIwCoiijFK7+nz9McA=;
 b=iFxfSeOoir6gx22CJBCuiZw92joyo6YAzhGPE2+GyNcy3fwVO9r0PburZECc2DpenB38iWmuRH0iAdM8rc2Hsx9IIv7lUbrsY+DUByd79wsPNS8WS4SVQDjDMhZtS9QoHAe1DDv7FYMchjsRF9+5qAVN2aO+pG6NmPrfn6IkP6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 10:25:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 10:25:45 +0000
Message-ID: <225fbca6-c98c-6c0d-a68a-b8162451ed47@oss.nxp.com>
Date:   Thu, 3 Nov 2022 18:25:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V2 09/15] arm64: dts: imx8mn-evk: set off-on-delay-us in
 regulator
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
 <20221024031351.4135651-10-peng.fan@oss.nxp.com>
 <20221028150226.gjixwznlygszbp7m@pengutronix.de>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20221028150226.gjixwznlygszbp7m@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 329ce5e4-8ec9-4001-f1c6-08dabd85c47f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/dLQjevnjKbppFfxFLNj3eAVl/GCpHxEazB4w9WgUHIWljLj5eiDEUlB9oOCi68XvbE4EuJjMR06BgDlGJhqpGKyr6deZ2dDijVgbp1bEmxGMVi6wCsHlUGMMvfCqbx++W8O0Nx0N6nZTO9WW7uh1Xwg92Qid0cOZ1bja2Kaa4IRwnMIhVXxNEo0coQM18HoXReQMvvV78qpVVPZBB1AUwxgCz3K30A7XQ49A5RQqBN4ROiV7bnK1tfNCsHAYN/5EoFYFk2IgLhP6kIDsHUpIMljfeUOL3zjf6erPDkywqNpRESdyxxLpWGfYJjGkVW7FiX/ZASwfuv2bgKNYu7ohg6SsGqD1HXUJaf/BsxLdXhv/r6eXi9ZgNvLN122xUa3Z92gqyh3FaiJCQrLHelXg/vB7zjRwXLhRAw0Qas3ajFVAYToYkttXyLdctwbOnlbDHhmuDuO37wJM86SmvTzWRR1iLEedAmtYlifANTcML8KzDr59C4WEHbuKDx4C1e0NgEL521x4yB7jBHy32qjByml2nHZUZ4Ww2jyBgz0O4lUAGHFPmP1IuWzogqiMwS/jtDeQRkZ4rIBbsXHsqdzrctgcYRJiOotceRJQ/PHwvxZ685rejVXGQZmWXqdDvwgVuK2a7qOqV2odsCwjZIgjsCd3/mWXiuTabL4sHuY+eB7exQVvc6oeUyrhQ+D1Rw6OweKaF3xAu2viIaayw/PQ3ReDtg+UQ19a5tG2qLqAAO0LU4YNRXTCsjFh5Nh1AGLw+5k6dcF5vH48vnMsr9VmFNzjC9pU6/ZMS6dIio0oH19bN0XdF97+zbAidmgJCueVkwmaDpMKS+9oIlnli+9m2e90yThknlPWrRFuMuaXxxuEPwY0QY/IMqesgV+VWu6/tqr7i5jJy9njK5J0//qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(41300700001)(316002)(5660300002)(2906002)(44832011)(4326008)(6916009)(66476007)(66946007)(6506007)(66556008)(8676002)(8936002)(7416002)(6486002)(478600001)(6666004)(52116002)(86362001)(31696002)(186003)(38100700002)(83380400001)(26005)(2616005)(53546011)(6512007)(38350700002)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUcveDR1bU1HQ1hXWXpXRzVEbWU5Rm9tM3p6QXRSeHk2cVMwSy9jS0RrYjZ2?=
 =?utf-8?B?dGpYNGNGOXRBU2RHMmM0d29aT05nRHpsbnRPcmVKTlpQWU1YNUdwRXAyNnhr?=
 =?utf-8?B?R0Z5a2xkV3NmUTh5eGJXR0ppRURheXNRbk9HMnkzTDdUaSt0STdkOE9KUmVM?=
 =?utf-8?B?dndSSG0zbWJlUDhqR2wvQVo4Tm1lYWRlWEpUblBLMEg0S2VOc1hQTjk3U2xj?=
 =?utf-8?B?dGR4NXJqKzU5MXRvQjVDWFlHV0lCT1dlREpKSm5oaWU4OGpKZTVpdXo3MzRq?=
 =?utf-8?B?Sk0zaEtCY3JLOGhGUXlGMWpiRXo2QjJXME5xQXFPZzM0bFBEZ0xIR3RBNm1h?=
 =?utf-8?B?SUVVend3OWFmdUZvUGJPdGNTeUJ1SWg2Z3hDekc0QUNwWEg0MTRFd2pwQXJW?=
 =?utf-8?B?UHk0b0I1aGJ6cGxQa2YvWXZITnpneFFpMEZxTThmMW9oNnNGS3dpZ2ZVcDYv?=
 =?utf-8?B?Y1NQSDRGem5OQjhMcE1XWUJWK05DMnQ2L0dvaHJ5QjluTFF3dzIva1A4WkNQ?=
 =?utf-8?B?OVFpZm44Y0tvNkVsZTFVN0lJQ1lBYXRSSlFiVDQ5VXMvVDVpWjR3a3B5RVZo?=
 =?utf-8?B?YnI0d0VIM1hIYUlZTHhzUzBYZFkrbFNxRDJvNHd0QzRLY1FXWitkeWd1SktT?=
 =?utf-8?B?cDNaQ1NDMFA2bjVlRDJmaU9NMEkwWXRMTlh1NkUrcG5FQ2pJdDdLL3dHMlU5?=
 =?utf-8?B?TFIvaDhQQ3VVeFpOejNZOGVrcjZTbmN6a0laQUJhQ1hlMjg0NzRGdHcxMUw3?=
 =?utf-8?B?YkZHN0hoK1lzUVcwUkVPaHZWTERCdlBMdEx2S0RUZWxuUWFhQ0EycEtzYjY3?=
 =?utf-8?B?L295aUFvRGJzY3hkcjEwaHM3WFNydmd3eHFlcHo5YVNJeUZhOU95U0dqMkdP?=
 =?utf-8?B?MHZnRGswb3lQZ0xCZ1pEMzdxRGhKWmUrY0FYa2NDQnhOMktQV09nZ1F4S0RS?=
 =?utf-8?B?ajRGOEVBQXNJOCtCanNsZTh6aGViait1WE5RYVpBcXdobit3Q2Z3T0JNRXRh?=
 =?utf-8?B?c2JsUjlJUXdXN3JXZHVhRENDemtKODBBU0I1NSthSVFGQVdmUmtZT2c0bm1r?=
 =?utf-8?B?eEIwNDlhWGp2YVlWdjdpZ2NEd1IxdDhhT2l0NGQ4VlNoNGpVemovMmI1dlFM?=
 =?utf-8?B?SHJsL09qTTJPZEI4R3F5a1lJT21nckdnSjRMYjYwNWFKbWxBN3VUNkhyR3hk?=
 =?utf-8?B?NWMvKzJnUmF3S2paUXBuL21KUVZ0WXo3SkROajZkcjRpS3NaTG1oYzVDZUVt?=
 =?utf-8?B?ZjFPeTZRSXVrQ1U3RHl5OE9lbjVDWTJjVDl2VlR3Q1dna3dGT1IybGZ2Q0R2?=
 =?utf-8?B?dDVZVUtWd2pXVncvQklQNnI3bERhZFl2eG9oRXJKdEFmeSs5eXArM2JaRkRP?=
 =?utf-8?B?WGNoVjZDTnJXNmtpcmlyc3pZUTVESGdpcXVpTnIwS3dab25EcmxpcHEwZGt1?=
 =?utf-8?B?TmNsTGoxZkxGa1BuMmpXTWhuTFZZVGhMRzBYaXdTejlWZnRPdFhlV2toSWh0?=
 =?utf-8?B?bmVsRlR1MVBpVFY3dnU1ZlM2V3RZZmx1L3FjT2xRQTR6NHpJNTZGcnMvRm10?=
 =?utf-8?B?NTVrNmo0ZGJvUmtTUFVieWhKTnU4Q1ZxWExxazJjTXBTV1ZZeHFBS3c3OVhF?=
 =?utf-8?B?T3NmSlB1MW04U09MdndsNVR2bEprcVBZa0svcWlyTGJsQ3BlWkpNcG02YVhG?=
 =?utf-8?B?SnV1UGk1SWlLdTVGeFo2V0s3MU01VU10aU5ESkdRL2hmY1Q5MFBOOU9vNDlH?=
 =?utf-8?B?ZzNjc3ZBS0VEQ2tEVnUxQVI3U1ViTzRxMDM4SlduL2h2VjZhYVpuTG1LclZG?=
 =?utf-8?B?d0RNelRNdEQySTdKY0p6T0lPRVUyN1Jua1BkdzRWWWsvWjkzUEtOS2JoSjRs?=
 =?utf-8?B?WXlBZ2xBc1NhMVljZ1M1a3BQV3o0WWVaaW1PNngvTmdiOU56VG1XRzRTMGxR?=
 =?utf-8?B?UVRsTUlWdkQxY1dzdi9YSC9FSmlRb21XcTJNRU9tdk11M04zSWtMalRKanFi?=
 =?utf-8?B?WHF5dlhvRStnNUgxSWo3blllREJBSWRZQ1VXMmpWb0NjU0RIQ1hhM0VKUHI2?=
 =?utf-8?B?ZFMzR2pQY3NRMWptMGF1YU44cjErM1dYWmgwTFYzeHZ2UVpNNlgxTnFaYUI1?=
 =?utf-8?Q?8582Yv1PaVlkRdax4FU17hq1Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329ce5e4-8ec9-4001-f1c6-08dabd85c47f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 10:25:45.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJPBvziTbCCNcJWnPF1/Am+ZdCCAifrGsWpvHq9pmcwx/vAsI/89hqz0lTKgKQvVSK8vT8F2AE1mO8/riX3FgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 11:02 PM, Marco Felsch wrote:
> On 22-10-24, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Some SD Card controller and power circuitry has increased capacitance,
>> so the usual toggling of regulator to power the card off and on
>> is insufficient.
>>
>> According to SD spec, for sd card power reset operation, the sd card
>> supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
>> next time power back the sd card supply voltage to 3.3v, sd card can't
>> support SD3.0 mode again.
>>
>> This patch add the off-on-delay-us, make sure the sd power reset behavior
>> is align with the specification. Without this patch, when do quick system
>> suspend/resume test, some sd card can't work at SD3.0 mode after system
>> resume back.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
>> index 261c36540079..2b4395854283 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
>> @@ -36,6 +36,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>>   		regulator-min-microvolt = <3300000>;
>>   		regulator-max-microvolt = <3300000>;
>>   		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> +		off-on-delay-us = <12000>;
> 
> All others are using 20000us, did you changed the HW?

This is i.MX8MN. This value should be safe I think,
since it goes through several NXP releases.

Thanks,
Peng.

> 
> Regards,
>    Marco
> 
>>   		enable-active-high;
>>   	};
>>   
>> -- 
>> 2.37.1
>>
>>
>>
