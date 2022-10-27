Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866060F011
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiJ0G0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJ0G0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:26:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70662B7F68;
        Wed, 26 Oct 2022 23:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVg6UCtvAXoGz+Am9gd336t7Vem/H2RvBsfp4cwCARtwxLk2kvUPTkgJAlHD2rgDO0g5biatfRO3pQmLNtku25aMFIn1Fh6MygDaxnlVmmHNE9Db0L6zqknVFjZJXPHadnkJJXL9YuEGsL+FWemKPDnS9U6yeONWL/nOFlsVPLQEUYpzuIi6ug94R9kbmtYYTig8tFabdN9NlrRrUtkrSo0c+UW0ulfrz5bqCwu04DP79kIOWsR8IeT+jDDEycBBDT8WrXgyZ460n6n15VtrNKXEZh0rUiv5ZITwYDzTE2RnSlfVY5mOC+cv53BaUeiwGf42Et8lnCdPasWfwB/MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHSb9ZplJr68hC51Mvhjrj0C8M0d/TlDyxFoeuEDvys=;
 b=dOhpgzyJYdRQ661t/oHd562mkNAEgtvLDC2YNVaXQpVJfrHplo8vHHNfHvo2QT8UF4+La8Sjc258q5TfaUo3y+haw5SWRbrQgnPEBdPAoYJgD6LK9TV08sw6FIqaW/xBE8FLw2DXNhDKSg6xO91/BSJliGYcsaLofYCNibbCNsqzEf4LPQ8EFow3EI9lrP7xXhIxFu3xc/Pw8Y7iciDWxKlMGht2hoto0/hxbpRjmCSF7z8R76Rd4+ZbWgja/PCPg4Lbf5OHlS3w1ykFvjs3g4z9weYMqi0Yfg5IaDwPj/iyicbo/RqwQWgrOQPSz0CpWJxK0g1ks7hWbDdTfEssgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHSb9ZplJr68hC51Mvhjrj0C8M0d/TlDyxFoeuEDvys=;
 b=i9kvzjomMTyNHFGYnz/vaRVtU9Tz40HE/HplvC/A3wu7sWqTBqbIN/iMpfMb/D+KhqA+/023VASRvIC8xOkFeEq9sGGrAVntGaPImQ4jBv84E3BSvibzZ/BbiJ352zInfJL9EVoiNPTdu+JFE3afivtHdsLkMtErQ8fk8UDin6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:25:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 06:25:55 +0000
Message-ID: <7a4b8730-5dbf-57d7-eb85-5102e719bedb@oss.nxp.com>
Date:   Thu, 27 Oct 2022 14:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: imx8mp: Add ids for the audio
 shared gate
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com,
        abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
References: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2e1f18-c9b4-4698-0184-08dab7e41a42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jibihw1UC1jhXd1j2fZu5D677AV37NuL3ROYLeJPHnLi0WLtaaj9NJqT29RXrEE+kQxf0Y8vca/yX9WIGLQ/zPWkJlY7lduLN6KEWftwOmtR5SI4JAzruByjIshqFBRICh2HvFbG6S93je8HQwiRBrpJCDc/5m0FEpl3tBJFcK/yEWY2hca8jZVkLXQ40rREaUdjefNnbpBSavpCrwawim97Gsi8B3FUHeckJY62jiH8Gji9RQat44rDvWCJC/KlnWjCGlVU2mqMS+K/8IUcDz3wY9uQOUSUCrOaCfaFZHbvMjO9gph2UZznLG2ExDL5uDBnmn7cS9jw/Dy0nHPG1ZVGlFhuaU6032RzdolLrSPDBafpSXW4Gm3hHYqK1zQO3jJZrd1MeOrBGR6J20gY0HwFEQgZsTEej8i9pV3Z91xf7Lk+WNmV+wp5h8PyZBeRnVbCuQSsmfLZT3512jmPbApQLANvLQWOgzoogcWVPHefdz9oNNdjFtEpH8RgptHf8GMJBsG6fum5C2NFfxSwpa8jt/05mzpl0Ok/TRd0ZwBg3NVdyDO50WLTNGR006RHL5Vh/G9pHf4F8sgar+eyzoLumKu4AXoWbgTzs2bXGuHJCQRF7hgXOP4PWNiFYyhny0uxRDxpgQ3jcR3aMqdu2CPsRANzGpOv9gx8fstXpeN3R+h9m3IP0jivAyL0/oSsBlGN3e5zaZLhEJtHaIcKj8y9DAbMhJtRXO2fUjsDkTBJ4LFAJQZ8YQUW6P03e406B6TKKlJAXZBrddknizrvoAr/0zls+gg28TTtp6TLyne0whQUq3xPxjOqjnMra9xoRUi1If5bhFr0MeicqWRLSqHaxxyZZLdLdNLBbJk51d48vAmdeICKxcE+uglcSM6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(7416002)(44832011)(41300700001)(66476007)(8676002)(66946007)(66556008)(5660300002)(478600001)(6486002)(921005)(316002)(8936002)(38350700002)(83380400001)(38100700002)(2906002)(6666004)(26005)(53546011)(31696002)(86362001)(6506007)(52116002)(6512007)(186003)(2616005)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBiL0xvaUsxTzUraE0xbXg1Uzg3bFlJK2JnZzh1Wk9tOURwVkVpd2E5cVFr?=
 =?utf-8?B?dmxLUFpyb0dZd0k2SlRiL0s1citaSVJUcjJOeGR6K2tpQVZVUjNlQVVXZEg1?=
 =?utf-8?B?UGFEMlhOSGdhS0Y3L0JZU2I5b0ZlSEFmV3Y3YVUrZDFGVW9ENHNFbGxDZXpt?=
 =?utf-8?B?UzlsUVd3Vm5QTUZ2ZkVRM0dySzNvSW9PdkM3TTMwWFVTOHVEblhuN21wUWtN?=
 =?utf-8?B?RWt1SDNmVjRaRWQwbG5wd3dzVm9HVkxRakpTSFdFRFdoc251Vk9QeUwzbncy?=
 =?utf-8?B?UEJVZU1aMDc0S1pLb1JubW5NSkhmcFRVYTRSM2gyQ2lyTEJyTHNzQm13Y3pL?=
 =?utf-8?B?ckVRYStzWi9EdHYxdGRhQ0g5MHlucHdmbFU0VW9zN1VWYVlUUWFvM2NKM2ZY?=
 =?utf-8?B?YkgvSWtJQTRDOEI3RWlQclB0NTc1Q2FoREZQL094aStIQ2dwU0xzbjVHVS81?=
 =?utf-8?B?eXFsUzFKUzdISHg2cEYzcC9HUUxvYmVBMDBoTlB2NVBoSjRWOTN6U1pnVU56?=
 =?utf-8?B?SnNMNFJqQ2daZVExREdXeEJuN251bmxLb2hBTmlhNEs0WW15dW93VnNSaDdk?=
 =?utf-8?B?RTY3N1NrKzBYMGhObmlSYWgzcXY2VEdsT21pQjNNWldQUDVYUmg2d2orUEpE?=
 =?utf-8?B?eVlzOTQyTEJ3ZW40aTBZNitlTC9Ic0hpUm1jMlZGaTAxeTU5Zmw2ZU5rcE1k?=
 =?utf-8?B?Z1NtT2dKcUV3RS84ZHVjUHZzUXV5RzJ2bi80M3pjTnIyT0UzNnl5TkNzK3lQ?=
 =?utf-8?B?Y2EwSldxT0IraVJJVXhaREovRTFQelQ2czRFU3Z6d3VzcVlaSk0rdkFRbnZq?=
 =?utf-8?B?Y0h2elBkOUlMbE5FOGJqK1hTVXQ5TkpxYUhQNlB0MUFDc05tZ1Iyd2NUQ2ph?=
 =?utf-8?B?b0JHRzh5cU9KWndtQk8wL2lTTGYrS3FFR2N6c2NKZzVLamZ3Uk5rM0d6L2V3?=
 =?utf-8?B?YStiY3dhVnNKOHVHMDczaS9EU2lReGJUWm82UVAyakoxOFRGVVU3OCtoRTlr?=
 =?utf-8?B?SWtHZFJmMDQyTDRabGJCckZ6aFkzb29sb0NOaUVFczFaR0s1ODJveG0wbWxT?=
 =?utf-8?B?T3kzbHNzOWxLa3NSYVlodFlyZ0hDeWtWWHNybHBLa3JJMzNvTktyQ0xDblA1?=
 =?utf-8?B?Yi8ycXJOaThRM0lYYWxzU1A4MkIyeVhoVXpIQ29iL3l2R1pSRU1xT3lLNTB3?=
 =?utf-8?B?ZjlYelgxSGZKb1ZKOEV5aFJlTmxmSkt1VlIwbHZXVXZ5TW0wOTJkSVROVFY5?=
 =?utf-8?B?YzJRODUxdko3N1g4d1o5STRwWWQvazVsbFk4ejlvKzIrNVVyaTNidDM2cXpp?=
 =?utf-8?B?dGF3TFdjTXpFL0xJMHBIclZRTlp1TGJmZk9QUm1pRkV2ZU5jS0Zja25oSDZl?=
 =?utf-8?B?MU1OZWFPTFcrKzU5NkNCSysyR0Z0VnY5VnZkSUJSK3k0M1dodXQxY08zcVBr?=
 =?utf-8?B?MW4rMzcyajc4dkVVY2VqY0EyWkhKd01qRGdIMjlET3RVZ0FPSzlGTzRvbndu?=
 =?utf-8?B?dXV2MTRNaTEvUWt0VTcvbVFsQ2xHWjBmWktFZ0lhZ282WEUwMU4zS1NlZG1S?=
 =?utf-8?B?SlVqdGlqZEdYZDVmbHc3Znp5L0huNm82WC9hcnNFL0JEcmhOanBFUUNTRVl6?=
 =?utf-8?B?MlliSUZXWWQ5NjdyWE5GZkMydStNbXdYc1BENUdIbU5zWkIrci84UTk1OHBh?=
 =?utf-8?B?NVlQeXF2WTdtNnFJT3Avc0lESUJpK0o2Z0duS2pEOEZYVG1CVW9vWDFjRmlY?=
 =?utf-8?B?WDloQURueTV3cmFpcU85bk5rcVlBbnREL0tpRGdrdFdaRXVIajFoemZZbTFu?=
 =?utf-8?B?bFpWSUVNMUhSSnUwN3hNUnhwaFRXT1VBWUZ2RUNnd0V6Sm1lVEVCRWdvdksz?=
 =?utf-8?B?ZTdTTDdJLzF4b0NJdGZSUC81Y3k4MHBkdXhaM3dkOG9yRHVnVUxuV0hHajlt?=
 =?utf-8?B?aDNQbStFUmlkYXBuaDNKc2lGQ0lTRjFZOS9OZ3IvcXhnaGhXM09wVHRranlY?=
 =?utf-8?B?cGtVNFBScktoQUJpdXUwY3ZQTnNxUmNGNHNwL3RVNHNRUlA3SzgwM0FFNG1Y?=
 =?utf-8?B?bS85bU5GM0hjdEttZ0FqRzMyekJKdFJyeDljbkRXWlFHNjFhUjB4VzdaUnh5?=
 =?utf-8?Q?eByySUaQWgGu9HiXflB9AgQwb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2e1f18-c9b4-4698-0184-08dab7e41a42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 06:25:55.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7/PnTbWnT16satCT+DL+GDEC4Hu5+Iz0rSZo1juqIsyxxCdGtw81VNvuD+twTL2/vi7AeeMgb6MS+Mdgmm4DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 9:34 AM, Shengjiu Wang wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> All these IDs are for one single HW gate (CCGR101) that is shared
> between these root clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - split dt-binding to separate patch
> 
>   include/dt-bindings/clock/imx8mp-clock.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
> index 9d5cc2ddde89..2f6fec299662 100644
> --- a/include/dt-bindings/clock/imx8mp-clock.h
> +++ b/include/dt-bindings/clock/imx8mp-clock.h
> @@ -324,8 +324,17 @@
>   #define IMX8MP_CLK_CLKOUT2_SEL			317
>   #define IMX8MP_CLK_CLKOUT2_DIV			318
>   #define IMX8MP_CLK_CLKOUT2			319
> +#define IMX8MP_CLK_AUDIO_AHB_ROOT		320
> +#define IMX8MP_CLK_AUDIO_AXI_ROOT		321
> +#define IMX8MP_CLK_SAI1_ROOT			322
> +#define IMX8MP_CLK_SAI2_ROOT			323
> +#define IMX8MP_CLK_SAI3_ROOT			324
> +#define IMX8MP_CLK_SAI5_ROOT			325
> +#define IMX8MP_CLK_SAI6_ROOT			326
> +#define IMX8MP_CLK_SAI7_ROOT			327
> +#define IMX8MP_CLK_PDM_ROOT			328
>   
> -#define IMX8MP_CLK_END				320
> +#define IMX8MP_CLK_END				329
>   
>   #define IMX8MP_CLK_AUDIOMIX_SAI1_IPG		0
>   #define IMX8MP_CLK_AUDIOMIX_SAI1_MCLK1		1

Reviewed-by: Peng Fan <peng.fan@nxp.com>
