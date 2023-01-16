Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76A66BDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjAPMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAPMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:37:32 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8EB1BAC7;
        Mon, 16 Jan 2023 04:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSqSuCyFjWaJCqZB4ZrkZq6YRV/EY8IBO63YiEeiAUV/OtuHBIi+EE1NIAQ7m7OGbM8XSD9eigsMuVC+S7jJaZdJ6kSTUPA5CdLJu9hcaPCkXSHn4HUWOE1ZfvxHixzvxGwgbc58o4S7sqzJWnYoOFZwUdPh32BGciSJPP2rst+WxDYzOCBFG71fqQPjiLD7t7CJRBpmboykLuRdjKswNvtikbCyfhH5F1ccIxSKNKFt+L/04PwhF0HIEHPJIDKR+iMN54PFYzg931pG9/89+8LFMtBNXQxXsXSr2JO7ouZB3T9VD3o9mbvBlw6sCuXb7DM7HVwto7yfyi6hixRHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF5ONRrDWMhuOdDf9goRLV60SA7+3clSZ1uG4XBdVZU=;
 b=WYTcdoCVMpKM1sVWiz9fHsHX4IoPXp93e9m9FQotRilwzhuGlvWGXRQhKyKIgmQZIG6nJ7c9622MFAX2LcANzP58mlT3ZYwi50xySRS91PCl9Vbj4UbI4K8YKo0iJt0A8y2KOFtD+xNy4eV9Q3ZmW4QXzzxBwDn0b2ntt0jjz2g74rFPia9m6MzWwTl04L7VDy2fU+eVG9Ng83Y6vcJQ94cbG34WCx6R5K2Em3ZN6tCA9Fk4LiiM2zUoaGDYvt1YlNRM/a9jEj+xDMsZGUBQ6kqenxov4lTPxKwuf35lBlxlcurYTYBk+I1Qt6SZzWwrxF/GxybFMDNnhhDWL5SgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF5ONRrDWMhuOdDf9goRLV60SA7+3clSZ1uG4XBdVZU=;
 b=PLoqLsNpfl9d+7xPJe0rLO7tAcdoGcRkYnSnhEusDxmdxJ7BMeq/ORjvIrTl3A+GpIR4QGm6cG3pbvfA0/Lc5IeH0BFlF8F0eqLOZ3kmQEWEt3mpgkZM/jAu3t9EZ5g/y2VCp/dgv/jLcPoWA/qX1wb2Ukny5zqkWANjZyyg0+qBO+YRHN9gtUUbDNcUQiFJ30MwugRhCIz5V6pqAJj9B5i3/IwVplK25Ikvr4L1QDYbnxIdR6nlkP5y6Ovjlu8Uv/OnLyZoFLUdam/mxCWuFiLjKlUDmJmKT1YQHE/GoZV/FQLydmjPXXNadQg/IAOK4CkEWft/fQahl1t6fAsHsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8078.eurprd04.prod.outlook.com (2603:10a6:102:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 12:37:28 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%4]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 12:37:28 +0000
Message-ID: <f6a8a8f1-0eec-2716-d4f1-9115c9d156b6@theobroma-systems.com>
Date:   Mon, 16 Jan 2023 13:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: (subset) [PATCH v3 0/9] fix reset line polarity for Goodix
 touchscreen controllers
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>, samuel@sholland.org,
        agx@sigxcpu.org, megous@megous.com, heiko@sntech.de,
        hdegoede@redhat.com, robh+dt@kernel.org, wens@csie.org,
        michael.riesch@wolfvision.net, lukma@denx.de, icenowy@aosc.io,
        kernel@pengutronix.de, david@protonic.nl, shawnguo@kernel.org,
        foss+kernel@0leil.net, linux-imx@nxp.com, festevam@gmail.com,
        pgwipeout@gmail.com, jagan@amarulasolutions.com, agross@kernel.org,
        hadess@hadess.net, dmitry.torokhov@gmail.com,
        jernej.skrabec@gmail.com, angelogioacchino.delregno@somainline.org,
        mamlinav@gmail.com, frieder.schrempf@kontron.de, angus@akkea.ca,
        Sascha Hauer <s.hauer@pengutronix.de>,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20221103-upstream-goodix-reset-v3-0-0975809eb183@theobroma-systems.com>
 <167336743963.2134489.16668389773212954467.b4-ty@kernel.org>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <167336743963.2134489.16668389773212954467.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: c42a43f9-0b9c-4b1b-185c-08daf7be6db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1bDejm1vqfTPou9LBurLw6RQy5bdMpspZCX78yN+ypWjdevkTnxBye2jF87yEtebSIIX+N0QiO7qtgCaf19CM4j3KMh4Hf5hPfT6ywfHjoG0hEIHLtyVD/QJbWsJYwS6Km38aPwS5kKpeWupYX4CeFiomihW5LRXlqHn9VwiTcVP0Drc86Dk5sZdOhr7pusQZmghfmidVm0vdAZeYcfpwN1h72gIEL+XD9nb/XTDKSt9ALa7YZ8j5+HQBTUkoXFGGDuM8A4GKQ/NM4ZENc3FjWF5KkiwysRSNpKyWRoMfDCoSyhCdg7jWV/19f5IGCYgmchmiibGorsJwfImBrei6mL2WiaCam+R8NVpOt0K1qDPCKaEbIUgQ9nwQ1zRWV90mWv95LdF4zoU0zcsqT/pyLx1FpCZVHp/wKdfzyz2BNXQ9VKG5Czh2z5DFDVQzxY8wdJiAJkzVMFbwNkLrVdDSxmFb5VSMRZSHL0qbf7QLiORK8bBhQWr1wRB0ge6Odja9gB5f9ZavY1seTlH7ttvWabrQv8z5zJpUMIVhqWpPXNSvFrTS8TwaEK1BEIK0iaKJFkpYhQVVQWhfWLMynqxeILh6GEkhHnCMSUzTTNpyrMbIDi0PMwG3EZWPB7vGgRzKLSVH07/NNnJ/WzP1HtUCNz3IcpC2a+Fr/k4olwSPEfhyuUOJZEUqTVpi3J96RcTvEqvAqHUhP/EOjfKh1ejpH/WuaNI1X+/cioN/XBhdsxUBEZk9Yc+c5KUjFBwl04
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(396003)(136003)(346002)(366004)(451199015)(186003)(921005)(2906002)(26005)(6486002)(6512007)(66476007)(66556008)(66946007)(4326008)(478600001)(8676002)(31696002)(83380400001)(41300700001)(86362001)(2616005)(110136005)(316002)(44832011)(36756003)(7416002)(8936002)(7406005)(38100700002)(5660300002)(53546011)(31686004)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZ4RXF3VTQzMzV1cTcvbkhmNGt2anpUdlgySitDdjV2dUpGWlg2c2R6YW9M?=
 =?utf-8?B?U2U0T09MS0dzd0ErSzU3K1NLSlFSa0RRZUl0YjZkeFdSV0J6OVlqQzdsY0tR?=
 =?utf-8?B?TS9nMTc1MFZWOThleitxVU44L0trYmZESGY4MFE4UjNsZVhXTldrREx3aSt6?=
 =?utf-8?B?YWZFU1ozaTBtdjI5T29vVVEvclhOZVlpMmNYcXoyNUxrSFVZSUpjbW0wRWps?=
 =?utf-8?B?SGJXMThwMHhuQmZCNEo0TTVkZkNsK21XNzNEcXRDWkxQbm96cWYvSkpET2Ez?=
 =?utf-8?B?L0tyUWZaUWVhK280bTRnNXlPWEl5U3Z4Um9tbExWOXdORGp5b3ZvZ05ldG4w?=
 =?utf-8?B?SjNobFFGaFcyRXlHMjh4Z1Y5bUlhWXJFM0FQSHdXWXpJaVNmVGQ3VVJ1NFkv?=
 =?utf-8?B?YUJhbHl6aGNEWUlDYXZTS25BYldxTUhLUE5iQjFDUEhKd2hQUGcxSy9iMHRk?=
 =?utf-8?B?bE1YTHpoTEY3U0R3c0krZkFkYWxseWtUd3VXQ2JFR3ZSSkhMdEtuU2xKczA0?=
 =?utf-8?B?QWRLU253N1h3VWFQbityZmV4Y1ZnODNKeHMvTDVZMFJZY0w1cm5lZWNQM2kv?=
 =?utf-8?B?d0VmT3ZuK3NNemV5aThETGJBc3VRZitUSjUzVVpsNktKblR3dm51N1E3SS9q?=
 =?utf-8?B?QlBGbkR4aE9PQ24xZTE1WG14N0hLdEcycnUvSTEyZnBNUmJZaEszNXVEWFpm?=
 =?utf-8?B?QUp6bWxEWW1CNzJ3QmdPM1FFV1IzbmxMTWhvU2xCTGNiOVQvSitxZGVTanJo?=
 =?utf-8?B?bTZuMjZrOFI5dzBqR1EwOHZtWEdSTzBUTWlOcDlxV2l0VTI4Y012cGNySjkz?=
 =?utf-8?B?cVUxZ3FRUms4YWs0TnB6d2duT05sbUpuMmpZZlJQbGlJb3FVNk14aVd4YVh5?=
 =?utf-8?B?dmVyYklSRk1VQlRkdWdXWHV0WWtxM3ppcThEMDlwRWZXSExraTlTWUg1YW9O?=
 =?utf-8?B?aFZEaTE1TVdBbDJCM0dYZnpKS3c4Y3hETkZJV1puazJackZVYkxFVEsyTDB4?=
 =?utf-8?B?dlBFNVp2WDZBTHpDWTYvb1pMczNjNFNobnVzb0JBb3NJam9BOWVFSVdOWW5s?=
 =?utf-8?B?cDVpQW9ONmducmtTNTRDRDhyc0w2bUZ0cWxOai9qZXNPTWVwS3BxbEFLdG1N?=
 =?utf-8?B?TkVmMmZUZ0NWQll4cUNRTjBsKzV4c3pSZmJFdXhXVFFhQTQrQTdaZXpiMUtD?=
 =?utf-8?B?bGc0ejRRdlRPUWtXTTB0LzVkNnF3UlpYMWo1VUMyNjNwTGdEYjZKNUxoeFBU?=
 =?utf-8?B?ZUlUZnJPTVpuVUlGSWQrWDhFYnBsRktjN0VwRlN3MUI2eSszZFNTZXNUbnND?=
 =?utf-8?B?OEM5dTAxb0RwZVlPTGVDV0oxd0dJVEZVWEwzZk9ES25RVFpmK0duL1VFSkRU?=
 =?utf-8?B?SkQ2V0NOMEVZbkZOdjFNUnZ3N2ErbFRTMVYwT3k4dnFLbFZLdmxHZFNYRk9m?=
 =?utf-8?B?NG9yLzhjMERYNlhXb2d5a21wTGZSVkQvU1VnMDduZFRpNnhBRGIwL3EwL3RV?=
 =?utf-8?B?dTJvRWQ5Q0xrbEZIZ2x3eHlwcTJrbXROeGkzU2ZYajhlUFR3L242cnY0dmlT?=
 =?utf-8?B?VmhzdEFIdGdJYktHLzVSUDk0RjFvTTF6NS9JYmV0Lzh5U0txOUJFMWhZOWdG?=
 =?utf-8?B?cWJXZ29DQU41b1dETWlJMjI3aCtid2hnMFhqMDNQMkZ4d0ZhMGxRbVNWYVpm?=
 =?utf-8?B?bVFnRk82S2Y1Z1plaWtHN3NBcUttV1c5Q1JtQkdTWTBjUnVrbVRKNTI2TU5a?=
 =?utf-8?B?NGRpMHZTbC81WlUwWU5IN0p5WlZDcXkxcXY0Y1RSQ2pIM2kvdk9Ed1NsdE9a?=
 =?utf-8?B?RE4yMDFEam9QR3NVL056R0xXUmgyOE1RNm1PSlVONHVRNk5WU3FoaGtZcUcz?=
 =?utf-8?B?NlV4bVNsQnZ6NHVROXJaMmxGekc1Q0RIalkzUkJoVFV4NnlOalZ5MUw1Y2lE?=
 =?utf-8?B?L0U1OHRYWStEWkxRN0p5L1VoZERHNGpFQStFUm5QQkpTdkZ4b084d1kwSHNE?=
 =?utf-8?B?S1VCZnNncEhJY05kcWEyUE5SZU5PTDlHQVNFM3UzK3NuRlRnOEw2bGhFTzVp?=
 =?utf-8?B?OCt5WFZYYUd5djM2b0ZTZzRVWnZwYVU4SHdDcjdnaG42Zk9IbHY2NFIySHo2?=
 =?utf-8?B?N3ppK0lLY2pzYm95aFo0ZFpWZ0UwUXVYTWw4UnB5ckRCZG5zakQ4LzlGNFZq?=
 =?utf-8?Q?Q5tJDvuegMaTvUDVf/ErCdw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a43f9-0b9c-4b1b-185c-08daf7be6db4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 12:37:28.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzuJoSa0Kz+aDIXD7G2o7qOGgI5b8HkPQVzUocAJ+16M1E62Uo4lUaJRVppJW4xKlY9YPgFs5+5dQ0AYWF4y9h9WxiRiU7qDGVIExHtir+5R4/JZ7VEpP/aYYTSVwNux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8078
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, all,

On 1/10/23 17:17, Bjorn Andersson wrote:
> On Mon, 5 Dec 2022 14:40:29 +0100, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> The Goodix touchscreen controller has a reset line active low. It happens to
>> also be used to configure its i2c address at runtime. If the reset line is
>> incorrectly asserted, the address will be wrongly configured. This cost me a few
>> hours, trying to figure out why the touchscreen wouldn't work.
>>
>> [...]
> 
> Applied, thanks!
> 
> [8/9] arm64: dts: qcom: msm8998-fxtec: fix touchscreen reset GPIO polarity
>        commit: 8a0721dae68fdb4534e220fc9faae7a0ef2f3785
> 

Thank you for the merge, however I think there could be some issue here.

This requires the patches 1, 2 and 3 all modifying the input driver in 
order to not introduce a regression.

I mistakenly removed the RFC tag and seemingly didn't make it clear 
enough that I had some question on how to properly merge this patch 
series, c.f. "Do we also make this patch series only one patchset since 
the DT patches depend
on the driver patch and vice-versa? In which tree would this go?" in the 
cover letter.

So please, how do we go on with the rest of the patch series? Should I 
submit a v4 which would be only one patch with DT and input changes all 
at once and Bjorn reverts the patch they had just merged?

@Dmitry, since you would have to merge at least patches 1 to 3 in your 
tree (I assume), would you be willing to take the DT patches at the same 
time through your tree too? Are the appropriate device DT maintainers OK 
with this?

Cheers,
Quentin
