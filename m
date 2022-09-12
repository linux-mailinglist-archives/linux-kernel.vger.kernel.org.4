Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A75B5570
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiILHk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiILHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:40:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99113E8E;
        Mon, 12 Sep 2022 00:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4D61qq9Q4uO/YlMlW2feqrd3V8/ZHjnv12KJf0P9Q57/F60M49bvdTvVjKhP7c5q+h3RMEI7oZCRodIDwLvgkEt7/FNO7bgqjvlbnj59GI6E6I1VPdhbplYWs7wBQGc3zyKaIETntLMDLtX2XSICDMUQfUj3L3EyU+b/dE0yA+gXXE2p76uEsq36ZO9CP/z7YhPXS0JRf/C1Z5blLDcHP7xKOVHfnWHS6IBL2yUg2hEy6r9UfI9F4gPebp39jiBZpvESn6CDsEFBgvNlz/E/BI+6E+saPRDOhUc3cIAANBZ+KQX7JiVw1UmDvOs6C4u5nZR7oJ9WllMQykwhoO4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOtfK6ql3bAMFiV+jfJ8K1gy6ocXwHiC/YiNq2lUWWE=;
 b=V05OwGQHgJiQl3ftBiIf5j8mHFXnrtOZJAFDL8xLzgzyEdLAsWVmBxW6ROfcDZlg/8A1N4TyCkeG3g5D8Gtk9ImtKmICfCSY1QTSvhNGF1/10hONj5JgsYIzs/KbIehs3FEuzGeD01sIJfhRROjR1/D1diHTlkMQKlXEK0t5IgC6B08QX6qkpgSR/Bktwbdala9sqkPabiio7kohdzhqnT48wyXQOEtnQ8zMdmCZ2GVVDxvlhohBr1000cnLcTLxEzAIXPK4MAYFWP5K056GHUxsYtJn1U/O31n5YDL7+iULM7wqmOAe+WzzzeNLwEOs6k5IefQP+lmavwXD07wkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOtfK6ql3bAMFiV+jfJ8K1gy6ocXwHiC/YiNq2lUWWE=;
 b=DY49RfggT7Vp4JJGIarUrW4fUTKVY3WWupAstzlxl+51MkbVkV+vLDL5+cLDGNWlW0N8NVTkrMSbKwNBCVTLm8Efk4nXG97v6i6ynuOwWz5pmzP62hNS3pt/p/DEOnD2ztDKjb4LwqooZ91SeBzQBcU+HdAuYuYT75cqHUNrInk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 07:40:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:40:15 +0000
Message-ID: <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
Date:   Mon, 12 Sep 2022 15:40:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
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
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebfa735-7194-4f4e-b4c2-08da94920810
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC3yp0rfOvtAtU4bJZ21a0ZT/E0nUIOk3ANCw/jQ3BmI4gwHWj4ijaz/Zi/rhT03Uc5w/B8XKSrE2rSXXBxzBbsqwdAIek0Hm8XcFRA3K+z76pn4tK5S9r6oA+vdoJihxEwOvn0XyadDEGOp2JCVAGv6VfVGFrejwLYK/H1ama09VBZgiEajJwybwKiQ5cEvx3A+SaXmeeyOM+tvVDiE8HYiRY9wyBrb4JM545rZDj0uGlrVn/un4boO3Jv36lNx86xQuLZsB/AVzPWhn3cSdN0fJfxWdj8TXPK+0yMwd9DWY/4I0jE+T44AAfkIFLagHgEpC2Pk5KzZU3uZPpMCdq5zCNvt7bZjKMyWEjzyUjyfdFrrUc+y+93IJAX6Q2wwFvDMk0HrzCabzIE2yJBjbRQREpRwBb2VRNKz+p+JBxeL7kLsA8MvQZsX8ckx6kiMlgTQ2B3LPxvWGbeoYoSEBlMeLUQlRRa0ADSjUEnMs7yXZg3B71j2tR66/E5ElcyG5dL3lUEpLohFx7PSUdYPVeLvRgouLVFE87ZCLbFg0Y7+SELnKpmWFLrPdFnCcMbfbN08ImYjTkqHdDAgRckDGsyVnA5WBaCcRFTwANSnxvUVKlu4W0jn82RXnMKxQ6g6d5AzBdBs8JjckdskWJlxt31nSWbCEMnV7BLMKY+Lqm2z9mMlk1voRwM8xQcmmcaobC+L25yuTuvnYJVEPqxbDsZuePHoFCitMW8EqfTd9kahIoAVxJ7ZV7DdMfc22AENnevE1tRpNolAhAsYB3q/YMuxkYeFqBUm2PaDXhfo3UorDamRDMg1I2rO4nXwjSuCu4JVJ4fGbI3ETO9vX+3zCdx1a+jSPTstWaz4eOtACaBzNRaXPoiPwoBHsEljfGXp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(6512007)(26005)(52116002)(54906003)(45080400002)(110136005)(966005)(41300700001)(86362001)(31696002)(53546011)(6666004)(6506007)(6486002)(478600001)(2616005)(186003)(83380400001)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(66556008)(2906002)(31686004)(66476007)(8676002)(66946007)(4326008)(316002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzI2a3dKMVRPbjdHc2QzQWk1SFVMZzk2Z25HRFJSSDBOUjZncllIWUdJSm5I?=
 =?utf-8?B?T3NWYnRiMHZKTVJTQ0dkUnNSb0loS2F1OXlvQ0JKZzhob3RTck56dWp5d2Fs?=
 =?utf-8?B?MUtYQXBpMmZCcEZOZncyUG1vNWNoM05ndVROOEZSYkVuU3kzU3Z1T2gwcGRI?=
 =?utf-8?B?R01FTE5vcGwyK01PTFhCV2tKeXE5QUN5Mmpka3BaTXBFbG1Uc1BDNnl6T01R?=
 =?utf-8?B?OEJzOVVOUGt2MW1DQzNZRWl2Uml0cmlGc3hJRm5uM2lKZFFDa1JNVzZSSXNN?=
 =?utf-8?B?TExiNy9ZU0hGNHBnLzNZekFYeU9sMWxGb2pJRmdjbW12aEJXSExMRlpMZHYv?=
 =?utf-8?B?ZUZMQVlWSjlDdFVIdXk0N1BCbU5FTW1wOWpJR08rSWFGRGFsZFlEeWZpYTIr?=
 =?utf-8?B?b2lwZkRVenhpQ1YzSmVzdnpuS3R6Mkhud1I4UmNTcElRV3lvdWNkQ3pzTUs0?=
 =?utf-8?B?Rk9qU2R2cUpTdUdtc2dnWXowRlNqSnVPRDNKR25GVVRMWlNocnIvZEJVamMr?=
 =?utf-8?B?RzlUQW9PZm5lVHlqNXBMQnN1SVJ4THNtQ1JMM3pVdnBTN0FFeVJvS2tSKzcx?=
 =?utf-8?B?UGRUM1pzbEQva25FNVc0UW85YnZSZE9HazdqNmliT0c5QjgvMFhWNTM4b1Y4?=
 =?utf-8?B?WnRxamZBMVVyS2JhTFNJYmplZTFEZWd2Sk41NE5KUnIyVVdMbGpPNnloZWcv?=
 =?utf-8?B?R0Uwb0k3SUYydFg2a0grQnd0QmVpR2pUa3BNemhkSmovM2hpR0E5RzJYRXBP?=
 =?utf-8?B?UGpZYVFCZDNndWMyZFgrQUphSU4vWjdTL1FFTHdPYUtoSU5NUTZrajhHODk0?=
 =?utf-8?B?MkFlaUg0bkRucExKMlVYbGdaYWhKQlBMemhaL1I3VXVqSFZLcjZvODRFazJl?=
 =?utf-8?B?Qk1wRTcxNGNFUUxWUEJWUmMvdjFGUjJKOUFlLy8xeFEwNFhzajQ3VWdzd3hn?=
 =?utf-8?B?aUxWeS96TDFXenEwT0NiSHVZdGZndmVBZTFtQjgrVDFxTFRpNHBMZjhSVTlr?=
 =?utf-8?B?WGl5cXBUV3FxajVUSlJLc1pYelVmTFc5TWdyZnpJNVltZ05OSVUraWYvaGp4?=
 =?utf-8?B?SGY5cTZJVzhHVExNWUkwcVBVcHloNkkyakdSekdYQ3F2MlAzTklqeUFQSXg0?=
 =?utf-8?B?SWJGY2MybFprTW1RcUhCMVUxaFRBV24xVUZXOXVScUthNGZxeUg1ZDdGV3By?=
 =?utf-8?B?UEJYczhERDZ6cWVweHdvRU9sYVZOTk94b29uY01GRisyWE15OWRsSFJEeFNT?=
 =?utf-8?B?S21QSnRSM2xHbUsvN1ZmK3Z3cFpvSDJxQUNJY0ZqeGdRaVZMbXZ6cVRRT251?=
 =?utf-8?B?NHJKV2JTSXE1NDFlN1p5SlZveHlyNFFNQjkxU3BXajFFeDhVYzg2a2dZeUNl?=
 =?utf-8?B?Mm45ZWxKZkc0TWtqWm5LTm1QUmxjejNLeCtEZ0UxdFRzNlhjWDlRM05uZm5t?=
 =?utf-8?B?RzBsbWgwL1ZUTVNpTnpiNUpFQTdrcDJ2RlJZUzdlV2psZ2dFRFZldExtTVdS?=
 =?utf-8?B?YWNPYUJwa21YVDdPNHc5aG02Unhxb3ZCeElwTGN4OFJKQ0FvSnZyTDlFdTA5?=
 =?utf-8?B?dHZHQmlPRTg5MkxEUG5wUzJVR0MwamdhcWplSm9LMVBOZzVIcUNOREQrTkxp?=
 =?utf-8?B?SUJzMmpadmQ0cGJEanRka0lkV0RadFBSdWk4TklsV3Q3Nkk4eXdkMVFDVGNP?=
 =?utf-8?B?bXpWZHFzb0x5bks1T0RXQ3NPeWRTbjE5OTdjT3NWeGNOd0ZFMGd1R2tyYWdm?=
 =?utf-8?B?aDFWMWVTdVJVakgrdmVSR2tXWmVoa0x1TWdMbWV3K0s5ZFg4WStLazN0OStN?=
 =?utf-8?B?NUVIRkJjWTFrV1R5Y3F1Ymgrcm9hSzNQcXg5cHhVUS9tekFnbU5LZFVKY0NF?=
 =?utf-8?B?N1FnV1Y5alNsZ2Mwb3lrd3o2UjlXTEsyUzhVVE9KNGFpNVR2YzZmcllrNURh?=
 =?utf-8?B?NjlXbVFwWE50dEd6NkdHYnVQM2NLWWwrVlZ3Mzc4czBNVGU1eDdScGcxZG1u?=
 =?utf-8?B?ZUJ1SFhVYlpKZTkxNEhkcjNIK3RaaG53d3BkTzdQMSsxK0IxY0Q4WmtMU0NT?=
 =?utf-8?B?MnNKZFQ1Wi9ueTB4a1czeG1MeG8weHg5d2RKcXlPdGRqOWV6ZkhVdXNjK3Za?=
 =?utf-8?Q?mydQIMGxJkZWsN5/X9UbnIk1P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebfa735-7194-4f4e-b4c2-08da94920810
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 07:40:15.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNyLbuzbwZVkGegcC69RAcDFyjsQaVbIKfJwSy3jEKQr8/jLcJtNsB0HJG68fPCi1xKsGB/TKJnBH8OSymYVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/2022 1:06 PM, Matti Vaittinen wrote:
> Hi dee Ho peeps,
> 
> On 9/9/22 05:35, Marek Vasut wrote:
>> On 9/9/22 04:06, Peng Fan wrote:
>>>> Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT 
>>>> failure
>>>>
>>>> On 9/8/22 21:25, Tim Harvey wrote:
>>>>> On Thu, Sep 8, 2022 at 9:55 AM Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>> On 9/8/22 18:00, Tim Harvey wrote:
>>>>>>> On Thu, Sep 1, 2022 at 9:14 PM Matti Vaittinen
>>>> <mazziesaccount@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi Tim,
>>>>>>>>
>>>>>>>> On 9/2/22 01:23, Tim Harvey wrote:
>>>>>>>>> Greetings,
>>>>>>>>>
>>>>>>>>> I've found that the bd71847 clk driver
>>>> (CONFIG_COMMON_CLK_BD718XX
>>>>>>>>> drivers/clk/clk-bd718x7.c) disables clk-32k-out (the BD71847
>>>>>>>>> C32K_OUT
>>>>>>>>> pin) which is connected IMX8MM RTC_XTALI which ends up disabling
>>>>>>>>> the IMX RTC as well as the IMX WDOG functionality.
>>>>>>>>
>>>>>>>> //snip
>>>>>>>>
>>>>>>>>> This happens via clk_unprepare_unused() as nothing is flagging the
>>>>>>>>> clk-32k-out as being used. What should be added to the device-tree
>>>>>>>>> to signify that this clk is indeed necessary and should not be 
>>>>>>>>> disabled?
>>>>>>>>
>>>>>>>> I have seen following proposal from Marek Vasut:
>>>>>>>>
>>>>>>>>
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>>>>>> ore.kernel.org%2Fall%2F20220517235919.200375-1-
>>>> marex%40denx.de%2FT%
>>>>>>>>
>>>> 2F%23m52d6d0831bf43d5f293e35cb27f3021f278d0564&amp;data=05%7C0
>>>> 1%7Cp
>>>>>>>>
>>>> eng.fan%40nxp.com%7C07d48edcc47c4694e08208da91da2bf4%7C686ea1d
>>>> 3bc2b
>>>>>>>>
>>>> 4c6fa92cd99c5c301635%7C0%7C0%7C637982664162868785%7CUnknown%
>>>> 7CTWFpb
>>>>>>>>
>>>> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
>>>> 6
>>>>>>>>
>>>> Mn0%3D%7C3000%7C%7C%7C&amp;sdata=uF26u9g4onuqCWzPRAvD%2F%
>>>> 2FLByaEhh5
>>>>>>>> Dtah9K8CcAOAM%3D&amp;reserved=0
>>>>>>>>
>>>>>>>> I am not sure if the discussion is completed though. I guess it was
>>>>>>>> agreed this was needed/usefull and maybe the remaining thing to
>>>>>>>> decide was just the property naming.
>>>>>>>>
>>>>>>>> Best Regards
>>>>>>>>            -- Matti
>>>>>>>>
>>>>>>>
>>>>>>> Thanks Matti,
>>>>>>>
>>>>>>> Marek - has there been any progress on determining how best to keep
>>>>>>> certain clocks from being disabled?
>>>>>>
>>>>>> No. You can read the discussion above.
>>>>>
>>>>> Marek,
>>>>>
>>>>> I wasn't on the linux-clk list at that time so can't respond to the
>>>>> thread but the discussion seems to have died out a couple of months
>>>>> ago with no agreement between you or Stephen on how to deal with it.
>>>>>
>>>>> So where do we take this from here? It looks like there are about 18
>>>>> boards with dt's using "rohm,bd718*" which would all have non working
>>>>> RTC/WDOG with CONFIG_COMMON_CLK_BD718XX enabled (which it is in
>>>>> arch/arm64/configs/defconfig) right?
> 
> Yeah. The ROHM BD71837 and BD71847 (and BD71850 - which is one of the 
> variants) are used quite a lot. I am pretty sure not fixing this in 
> upstream is increasing downstream solutions. I don't think that should 
> be preferred.
> 
>>>
>>> Is there any requirement that the bd718xx clk needs to be runtime 
>>> on/off?
>>
>> Yes, the 32kHz clock on BD71xxx should behave like any other clock, 
>> unless specified otherwise, see below.
>>
>>> I suppose the clk should always be never be off, if yes, why not have 
>>> something:
>>
>> What is needed in this specific case of BD718xx is I think clock 
>> consumer on the MX8M clock driver side which would claim the 32kHz 
>> input from the PMIC and up the clock enable count to keep the 32 kHz 
>> clock always on.
> 
> This sounds like a solution that would describe the actual HW setup. I 
> don't know the CCF of the i.MX8 well enough to tell whether this can 
> ensure the clk is not disabled before the consumer is found or when the 
> consumer is going down though. Simplest thing to me would really be to 
> just mark the clk as "do-not-touch" one on the boards where it must not 
> be touched.
> 
>   The PMIC is most likely supplying 32 kHz clock to the MX8M,
>> which if the 32 kHz clock are turned off would hang (I observed that 
>> before too).
>>
>> What I tried to address in this thread is a generic problem which 
>> commonly appears on various embedded systems, except every time anyone 
>> tried to solve it in a generic manner, it was rejected or they gave up.
> 
> I agree with Marek - generic solution would be nice. I don't think this 
> is something specific to this PMIC.
> 
>> The problem is this -- you have an arbitrary clock, and you need to 
>> keep it running always otherwise the system fails, and you do not have 
>> a clock consumer in the DT for whatever reason e.g. because the SoC is 
>> only used as a clock source for some unrelated clock net. There must 
>> be a way to mark the clock as "never disable these", i.e. 
>> critical-clock. (I feel like I keep repeating this over and over in 
>> this thread, so please read the whole thread backlog)
> 
> Thanks for the explanation and effor you did Marek.
> 
> My take on this is that from a (generic) component vendor perspective it 
> is a bad idea to hard-code the clock status (enable/disable) in the PMIC 
> driver. A vendor wants to provide a driver which allows use of the 
> component in wide variety of systems/boards. When the PMIC contains a 
> clock gate, the PMIC driver should provide the means of controlling it. 
> Some setups may want it enabled, other disabled and some want runtime 
> control. This "use-policy" must not be hard coded in the driver - it 
> needs to come from HW description which explains how the clk line is 
> wired and potentially also from the consumer drivers. This enables the 
> same PMIC driver to support all different setups with their own needs, 
> right?
> 
> I am not sure if some non email discussions have been ongoing around 
> this topic but just by reading the emails it seemed to me that Marek's 
> suggestion was acked by the DT folks - and I don't think that Stephen 
> was (at the end of the day) against that either(?). Maybe I missed 
> something.

After a thought, maybe an easier way is to add a optional property
xxx,32k-always-on to the pmic node/driver.

Regards,
Peng.

> 
> Yours
>      -- Matti
> 
