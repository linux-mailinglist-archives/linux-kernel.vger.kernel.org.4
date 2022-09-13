Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15E35B659C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIMCa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIMCa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:30:56 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20086.outbound.protection.outlook.com [40.107.2.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE0A52E46;
        Mon, 12 Sep 2022 19:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNY8agXDmew23k8X5CWL19u1SyRQVLZLnslwMgFsLyI5maeW2q3lM4n9H/INR/CD+TbMco8e0EseVxnJ0xHRd7LUJ4rtgw2soZs+koF6yiHRwxQuZ0gYsg/we9XUpYQllDSmohdA4IVV++elpQYQARkqqpGBm4FwH+j9R+pQJ7b7a/OHPJxql3izUR+6qsOwrgMcOgVphTWEm5Oztp44jKxActAsKgaFS3rgVswjqLNJzzr7nDa17YSiZuVpGBf6p1S2qovl4XQGXu4RRS27Tjr2Sact4O88B2URUlMukJQiGbqCq0CLtWKphCTKzrg1o7lEEKiK9YgMxN0L2AYvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTTSNW5v1G406O/iDMXeCOl0zgtHgIHpUa7CcfQNRzI=;
 b=Q5T9PNk5hrJIIooAn9mqxgU5vhSBQl7Tue046IXUPfo1PQv2mJCL3nQbZ9uzCnNiek2yemsFSiraWKAv2+WXPMTEtnne+gHMYCIiFakRL/gFRNrAolFIyzGmIV0E7SxUzVorsOYY7tcPEEmL+clg3HTO8gSkLXKNHJ7vki+iY5UEpnJzKdYXGqenCe6oGM93nCr11pXfSsaY2GIbpPVSXp6DcEJcoF4lSI0VtveMeux8h1HWzTgY7hpqMdP9zO+UrAAtt5KAEVXNNWZ0GhUxcY/8W4v+6B4M/nDe/k3h/ALYyYDLrn1P59odVBgAtSp4sbdvkOloUIMs5bmNppXRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTTSNW5v1G406O/iDMXeCOl0zgtHgIHpUa7CcfQNRzI=;
 b=aEXun6Y55i9D0hFd2OMnnzI+CUcXSo4Vn1ZihnRYF8duspiEtvVY8AU++BnH6q9N+iiWYaFdR2idMz0z0LcqUwA05GiojhZwRWq55q2q4XELkgNjQGyOqcOOfO4OmzB4YCUnQFTrhpYDzwyb8EsAT9FljPZT2t12ka7KcqNSJxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7781.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 02:30:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 02:30:51 +0000
Message-ID: <4a383f98-df67-27ce-c85b-23df28b5909e@oss.nxp.com>
Date:   Tue, 13 Sep 2022 10:30:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
 <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
 <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
 <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: e34ca0dd-ed76-4909-e650-08da952ff981
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55AYHjAws3sgfDjGGVzYIj6O/VZP0fiMemFR5F9kWd1TRN6eNA9PGeWYApwuFba719KvfXQAe4tqUTSkV5sncccZtFZ/9uo+AOETgc1kap6QhNP4sBmJf0JEPl+T8azuoFAa9d910NW6yxkm3NIISlkdFA5RV9jppFMW+PK7zFRbexi4C124Jl1FqFX9fTmvI3BlRKQhp7htsMw8jL7OVT5b+psIP/komZtua8EU+OLXt0sM92Q1mZHJ86oaD2Du4YwZ8DBRHfxVBAttqjTrUi8r7swKP3wiIOX9Pb9GyQbp6Cbg8NrXje42jcc6HxEpadRbVyNGN9Ybky3jdt3g5s4Xap5opl9qkfProf5nuU27QHrHAW+Tn1qDiUts3mHhWeKYpqWKm9j2nJxWdcBRAtqQILbIPmyLMbIYAO8CAMzRmB/+BYLdRgIe3Cte4gzoKk2HVcpS+iUChBbLN8UlGmdS/PgKHZ771r8l/c/bzdb6qg1gaCPV/sUHErF3V2MDXJjsuiqaNPNQlTVydHS6kUGK31Nbmo/p9kM+lKq0j2c81KMH4H3UbPIpEpOsaP9UrthGI2y6UG+C6fAN4mATt34E0+BIdIC+ZvlmCkWOk811syrH//ozcMrHcfngye4+PB60ki7aNNSMHVbOHfC9OQKD1EEm6iAMRBqcNi7a0jc9qfzqSbauRdcB2oZFgqnkxzDXMu+jNLK5nyv6eNmgc4ZK6sZmcgippdYNNifrtzadWRYNekjbVZBHitUH9nFAY65Tad3zfu1IjtEtEt/SFvmrBygOE97PUYnWG8OxnWDAa5Bt7Zs9tXTq2PxFTUr6VCK8g3eCuavRahWShAKw0cfiW74/o6rPp4iAzTn1XUUtEiSQV2tU2nbtMhQCiH1X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(4326008)(66476007)(6916009)(66556008)(38100700002)(86362001)(8676002)(31696002)(2616005)(53546011)(6512007)(316002)(2906002)(478600001)(6506007)(966005)(6666004)(45080400002)(54906003)(41300700001)(8936002)(66946007)(5660300002)(44832011)(83380400001)(52116002)(31686004)(6486002)(186003)(26005)(38350700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNGZmY2d3JCalg5ZHFZU3dYSG9tcnRMS0FYbTR6MzBvdmQyb3h5bWxlNldq?=
 =?utf-8?B?V0tjMjB4WFdDcUN6MWQ3SmVZM2diUU9LbTR0ME50WnZtMCtKdmhPY0ZGMGIx?=
 =?utf-8?B?eE43L3pic3pucTBCc08yQnM3L1NET2tVSDBUeHJ5OWRUeEl1eGpFSytPKzB3?=
 =?utf-8?B?SFREMUFlelBpa2N0OWdrcjJvbGZOS29hRExjckxIQUh2Q3lRRmVWd2lSdzVO?=
 =?utf-8?B?OVpuUTRkMVdNdW95R2pYNnNMek1RQ2xxTTV0STN4Szk0a00vbFZDdVZGTUI3?=
 =?utf-8?B?YW1FZ0VkdDRkZ3ZlbTBEUkRWcUV2ck9rcUwwUFEwWTJwOVVnUTlOSzNqZUto?=
 =?utf-8?B?NE1GN0hCdDBsREZnUFBYQnhReFVoT1FyZVY0b2VWQ2RyUVp0NDMxbit0ZGtm?=
 =?utf-8?B?Q0xBb1A4OEtoajlQcVRSdDVVQmowZ2h2YWhPL051dGpjMWpiU2VIMTdzTGNG?=
 =?utf-8?B?VE5mZ3loVXcxaS9iOFp2SEFqV3BDb2Z4d3hKcDZJb0k5SlRsZVNDaUgwaThx?=
 =?utf-8?B?TUZlUzJSb2xUNlBsR1RHQXpSaFVkWVRHR1NxYUF2UVRNUU5lMFdoYXBVVXJ3?=
 =?utf-8?B?cVhDczV3M1dkNGV6QlRTSkZzSVFsZ3BVb05ObkNVeFhRdmwyRCtwaGJrYlVv?=
 =?utf-8?B?NXlkbmMwamJqZXpqTnQ1QWlqNk9NczBSTWxFRjYrK08xR0I1a3ZER2ErZTEr?=
 =?utf-8?B?WnJNVzA2bWp3Y2ExQmtZTU5aNnAraUI4Ums4YTNQcXViRWtheVVrT3RRRG4w?=
 =?utf-8?B?QXlkbW5FNE1PbVo3RG1ZejFpRnJHa1EzNllOM2REeGhuekxnTXR3dElQeW9D?=
 =?utf-8?B?bUk2WmJrS2RBKy9kODF3NUhKd01LaUdBNzVFdnB0NXBnVlF6YkJ5STlVeWox?=
 =?utf-8?B?dStnM1NzMUplazVGNHdid1RpMlVtWGxNeUhBUzZzVmF4aC91R2JDbHd2NmMx?=
 =?utf-8?B?Unoxdmh2cHZCVDQzZ0dKTlZ1N3VMQ2VtUHU5aWdwVWZEWklaaGsxSVdHMWNT?=
 =?utf-8?B?MEdjczBFT0J3WHU5cmxoQUdlTm9zcXRRS0dLMEhiTUxqYkY2Tk92YlcwejBS?=
 =?utf-8?B?aVZleDk3K2wvV2dzTVk1QnJtRnBuYk1KYU1qN0xyVkhOekIvYXlEblhkbEVM?=
 =?utf-8?B?MlFicXFkaitMOU9GOEt4RVhGV0FidjB3M0F0MWZ4ZlozWHpWbzkzQm96cXFM?=
 =?utf-8?B?K3BNNVNHSXdTZkpHazNaakhDRFZad3Ava01GM3FRTEhXOHc3bER5STA5OXRM?=
 =?utf-8?B?cHhiVFU3OStsWlAwOVVTbmJRUHhoTEMvdzR1ay9qQXY1eG5ZRmJYNjNPb2JS?=
 =?utf-8?B?eTN6UkQ4bkgvUVNGeXUzaVlzNmtLQUM2TkVvQTlkNms0amQzOGtNRlFhSDR2?=
 =?utf-8?B?cFB4S0s2UVZMdlpJZTd4dUQrd1dWWlcyeXdQeklIalBNODJCMjl6NlhKcFk3?=
 =?utf-8?B?UnlONkQ0VVU3aU5HMjV3YWE1UmFDS1grdnF2T0lkQnBYY0FlMldoYm16dkRY?=
 =?utf-8?B?MnYySUttWmdybDg1MDRobFArVU5JK3JkNndOU0dPNFJTbS9zQmVKdUFKekdT?=
 =?utf-8?B?YVhTM1BUeHkyb2t3cWsweFBkeTZzeWczWlF1YjJlUnZxRGlEWEJTTE5oVTlQ?=
 =?utf-8?B?azA1NDJlWDR6Q291bnc4RkN5UWRFcXQvUjMyMlU5M2FISFl5djFCY1FCN2Ey?=
 =?utf-8?B?eTJFSXdUa2w4SWJqdGc2bkJtSW5SUnRmUXlwNURLeXAvL1VJT3pxc0ZIWWxE?=
 =?utf-8?B?bXlpbzNCd1g0OTIyZEg5dHdlUlVSUXdaTWJ5KzNhYkduSHpISG9nekExd2Za?=
 =?utf-8?B?MG83STl1ZEtRM2hDdEpJTml1cHdoV2NRRVNMcGtHMjNtVVlORFRSRTg4OWZK?=
 =?utf-8?B?Q0tmeU9IZXZGWitrNXVFTHBta1U1YVFwUUJ5QjVFVW9Jb1RuVE5CMDBPMWo3?=
 =?utf-8?B?VkpaRFhwb2V2RjVuOWxmcWY2TXg5ZVVxWEZIZDlybHNQRHhMOHJDVjVwWG5N?=
 =?utf-8?B?TWl5VFhPS0VXSU04YWg3S3dsREV2YkZ3TkR5NHpVS2ZIZ24wd1BqQ2pvVi8y?=
 =?utf-8?B?MXkrZ29Sb0tyUFovaThQMGNGOTZjd0MrUFRrYWtKYXgyV0tJYTlDeXI5dXdq?=
 =?utf-8?Q?f3JoRwXrJ5NNCkoyDv7++VbJ5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34ca0dd-ed76-4909-e650-08da952ff981
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 02:30:51.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WkvY4qvaBZQsjTO0Dx2pqq3faBvoCwBJtHlVwYyfe6PrmWr0l8VqeHdpUnvyPMgxWBVKQrJUu24IL+OOEgTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7781
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2022 1:15 AM, Tim Harvey wrote:
> On Mon, Sep 12, 2022 at 12:40 AM Peng Fan <peng.fan@oss.nxp.com> wrote:
>>
>>
>>
>> On 9/9/2022 1:06 PM, Matti Vaittinen wrote:
>>> Hi dee Ho peeps,
>>>
>>> On 9/9/22 05:35, Marek Vasut wrote:
>>>> On 9/9/22 04:06, Peng Fan wrote:
>>>>>> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT
>>>>>> failure
>>>>>>
>>>>>> On 9/8/22 21:25, Tim Harvey wrote:
>>>>>>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
>>>>>>>>
>>>>>>>> On 9/8/22 18:00, Tim Harvey wrote:
>>>>>>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
>>>>>> <mazziesaccount@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Tim,
>>>>>>>>>>
>>>>>>>>>> On 9/2/22 01:23, Tim Harvey wrote:
>>>>>>>>>>> Greetings,
>>>>>>>>>>>
>>>>>>>>>>> I've found that the bd71847 clk driver
>>>>>> (CONFIG_COMMON_CLK_BD718XX
>>>>>>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
>>>>>>>>>>> C32K_OUT
>>>>>>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
>>>>>>>>>>> the IMX RTC as well as the IMX WDOG functionality.
>>>>>>>>>>
>>>>>>>>>> //snip
>>>>>>>>>>
>>>>>>>>>>> This happens via clk_unprepare_unused() as nothing is flagging the
>>>>>>>>>>> clk-32k-out as being used. What should be added to the device-tree
>>>>>>>>>>> to signify that this clk is indeed necessary and should not be
>>>>>>>>>>> disabled?
>>>>>>>>>>
>>>>>>>>>> I have seen following proposal from Marek Vasut:
>>>>>>>>>>
>>>>>>>>>>
>>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>>>>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
>>>>>> marex%40denx.de%2FT%
>>>>>>>>>>
>>>>>> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=05%7C0
>>>>>> 1%7Cp
>>>>>>>>>>
>>>>>> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
>>>>>> 3bc2b
>>>>>>>>>>
>>>>>> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
>>>>>> 7CTWFpb
>>>>>>>>>>
>>>>>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>>>>>> 6
>>>>>>>>>>
>>>>>> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uF26u9g4onuqCWzPRAvD%2F%
>>>>>> 2FLByaEhh5
>>>>>>>>>> Dtah9K8CcAOAM%3D&amp;reserved=0
>>>>>>>>>>
>>>>>>>>>> I am not sure if the discussion is completed though. I guess it was
>>>>>>>>>> agreed this was needed/usefull and maybe the remaining thing to
>>>>>>>>>> decide was just the property naming.
>>>>>>>>>>
>>>>>>>>>> Best Regards
>>>>>>>>>>             -- Matti
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks Matti,
>>>>>>>>>
>>>>>>>>> Marek - has there been any progress on determining how best to keep
>>>>>>>>> certain clocks from being disabled?
>>>>>>>>
>>>>>>>> No. You can read the discussion above.
>>>>>>>
>>>>>>> Marek,
>>>>>>>
>>>>>>> I wasn't on the linux-clk list at that time so can't respond to the
>>>>>>> thread but the discussion seems to have died out a couple of months
>>>>>>> ago with no agreement between you or Stephen on how to deal with it.
>>>>>>>
>>>>>>> So where do we take this from here? It looks like there are about 18
>>>>>>> boards with dt's using "rohm,bd718*" which would all have non working
>>>>>>> RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
>>>>>>> arch/arm64/configs/defconfig) right?
>>>
>>> Yeah. The ROHM BD71837 and BD71847 (and BD71850 - which is one of the
>>> variants) are used quite a lot. I am pretty sure not fixing this in
>>> upstream is increasing downstream solutions. I don't think that should
>>> be preferred.
>>>
>>>>>
>>>>> Is there any requirement that the bd718xx clk needs to be runtime
>>>>> on/off?
>>>>
>>>> Yes, the 32kHz clock on BD71xxx should behave like any other clock,
>>>> unless specified otherwise, see below.
>>>>
>>>>> I suppose the clk should always be never be off, if yes, why not have
>>>>> something:
>>>>
>>>> What is needed in this specific case of BD718xx is I think clock
>>>> consumer on the MX8M clock driver side which would claim the 32kHz
>>>> input from the PMIC and up the clock enable count to keep the 32 kHz
>>>> clock always on.
>>>
>>> This sounds like a solution that would describe the actual HW setup. I
>>> don't know the CCF of the i.MX8 well enough to tell whether this can
>>> ensure the clk is not disabled before the consumer is found or when the
>>> consumer is going down though. Simplest thing to me would really be to
>>> just mark the clk as "do-not-touch" one on the boards where it must not
>>> be touched.
>>>
>>>    The PMIC is most likely supplying 32 kHz clock to the MX8M,
>>>> which if the 32 kHz clock are turned off would hang (I observed that
>>>> before too).
>>>>
>>>> What I tried to address in this thread is a generic problem which
>>>> commonly appears on various embedded systems, except every time anyone
>>>> tried to solve it in a generic manner, it was rejected or they gave up.
>>>
>>> I agree with Marek - generic solution would be nice. I don't think this
>>> is something specific to this PMIC.
>>>
>>>> The problem is this -- you have an arbitrary clock, and you need to
>>>> keep it running always otherwise the system fails, and you do not have
>>>> a clock consumer in the DT for whatever reason e.g. because the SoC is
>>>> only used as a clock source for some unrelated clock net. There must
>>>> be a way to mark the clock as "never disable these", i.e.
>>>> critical-clock. (I feel like I keep repeating this over and over in
>>>> this thread, so please read the whole thread backlog)
>>>
>>> Thanks for the explanation and effor you did Marek.
>>>
>>> My take on this is that from a (generic) component vendor perspective it
>>> is a bad idea to hard-code the clock status (enable/disable) in the PMIC
>>> driver. A vendor wants to provide a driver which allows use of the
>>> component in wide variety of systems/boards. When the PMIC contains a
>>> clock gate, the PMIC driver should provide the means of controlling it.
>>> Some setups may want it enabled, other disabled and some want runtime
>>> control. This "use-policy" must not be hard coded in the driver - it
>>> needs to come from HW description which explains how the clk line is
>>> wired and potentially also from the consumer drivers. This enables the
>>> same PMIC driver to support all different setups with their own needs,
>>> right?
>>>
>>> I am not sure if some non email discussions have been ongoing around
>>> this topic but just by reading the emails it seemed to me that Marek's
>>> suggestion was acked by the DT folks - and I don't think that Stephen
>>> was (at the end of the day) against that either(?). Maybe I missed
>>> something.
>>
>> After a thought, maybe an easier way is to add a optional property
>> xxx,32k-always-on to the pmic node/driver.
>>
>> Regards,
>> Peng.
> 
> Is there simply a way to add the clk to the snvs_rtc and the wdog dt
> nodes so they have a use count and don't get disabled?

I just see snvs_rtc requires osc 32k, but I not see wdog requires 32KHz.

"
The 32KHz XTAL module uses a different IP and it is used as the clock 
source for the
RTC, located in the SNVS.
"

Regards,
Peng.

> 
> Best Regards,
> 
> Tim
