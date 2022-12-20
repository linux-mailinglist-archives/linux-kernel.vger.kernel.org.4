Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFD6522AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiLTOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiLTOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:33:27 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A41C41D;
        Tue, 20 Dec 2022 06:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR/teR2mI3llHzUm4Lk1BnWph4ZOImUr0+RldUbR3VamHweUW7M79+LRO3FND9f49NylCfhgmjtvJG5AuldfJ5IWw+hd9bMZDj2BOIoxyR6qTFtnj0aSLgrfrU2k04Qa+RnzGCk4TRUZH65NBzqsSjIHogtnCTJpiPnRk0zcQ1jxVmIF33N+FNIJWDwGcDdrKnGXnKrGdI/ew8On1BkN0Y7KFEj91LF3fG+79Jcp5+1fTj9c7UHUHjeXBB29dAe4rd7mEot28MFsbek+6gU+WV+WYyfPWedyWcAVkwFwfxDwEbBHoUJ6EB82g3n5pjPDAG0yGUIaWUeujzOtlVlh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTaU9mKpIuFE92AWvBmCZQp5SdapksewvWcPrNjPEfc=;
 b=JGVSJDYyMH29yZLRuw932KdPekMX8gy9YMq6DLZ0DuRwA3mpKoODKZYu3SvM/lUi61AnnG96pQdIt/IjnsBxzhHzQFkVh0+3/Cpjq/t8Znhvj7BsdVm731IkrNTZ8En4QajRsBTROuRS/RX2acP5Y33epxrd+E8OjTSRX6uBJ8sLsV3sWsFZUSoAPilFvu7UoX7JkFcNzqBCICcVQ3z5dZXQRTyvlQoFf7BbzirQFrc8l96+dYYkGCd6ANTVKSJgVPAyIvcsY/4il89GmZoNNMyAj10nLa5x1KbOzKjCz37nsSHOno9vF4ARnXhzASx8Q493Z8Mkt49jS0Vuu1wdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTaU9mKpIuFE92AWvBmCZQp5SdapksewvWcPrNjPEfc=;
 b=FbtFu8YWJ2PqEa4bQJAfrzKpW1aA/0Re82cOHhLcJaj9el4y96ErxqnMurWU6iKpryCsZbCeFxcBjnFl0uebSjLv8SJDA2nmd6PEkAUMWH1+HHfoREqUpxCW1d75bPK96J8Lc7DuEEOBqn9p9sJ/j/8RKsU6kAPm1O8gEV0Kmh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 20 Dec
 2022 14:33:18 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 14:33:18 +0000
Message-ID: <0fc29cde-69b1-867c-0e4b-0682af9f8aff@nxp.com>
Date:   Tue, 20 Dec 2022 20:03:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com> <Y0A+Y3uNzpzGx0Ey@kroah.com>
 <dfe167cf-5d4e-6fc7-c954-25f719b1e843@nxp.com> <Y4cE8MvAS8bpcQmW@kroah.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <Y4cE8MvAS8bpcQmW@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To AM6PR04MB6407.eurprd04.prod.outlook.com
 (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|GV1PR04MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b66ed9-20d9-4e5c-9f98-08dae29722f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpoutpvD9I0e+u3/Q68LgrVdTqz3+FNBKJF8DEkq07/S5hM+LPq+lmxoVTOmrF9R/bQpYagdqwXNJAk5gR9jF/r0GRdc+mUrDCDRT4rxjlWUDt+uVfnYwEwzDLC0k3n4myoz4T7e4TbLocp0yW60i7HNTz68161AHlX0oqmqgLA3zG6LpF1X4/M9Fy52erVNu8XypNClvlTkwX8BVIixXu1thMFpuYzJIYX8Y9YkZ0ucmI0FHBic2R7xZ0TTLbz8j07Uk5zfnkVePDBPja75a1hS3zbG214uFA/AtxWkWuAsFCz4CvU7w8puvCeM8uy1XAEZ3gyL7PF0l5A5hsqBT1yKofiG9/yC7EUiW0m+NJVdFZVJpggCpHnrRjpHenSV0Cn1sHuLN06L7Vc5GfF2RaMEUDpJTib2dVSJJpzyAfUfdgveLdzuaH9gXlED6beswqZRXdOZ7YYn3XmXEV5pjnacFnQLiDN8aGy9bFD71PlPhVvTwLFf5feNSOFmGUM+BhMcatWnAvJljh8HPkkkUoa0cnZb6E31HD5az4dppO/RdZDGmLF61D/9mT1YI3rX5p6tVqecoRpYlLkDInw8c35Guf0GPqtJJob5ciCVqNoYuqCnt/mo7sUXIQJ5bH2oUr1oR4h9n9s9s2++ZhRXtoc03JNKqaCRVmdpzb23i0t4ugukcD5Y877jOEm31rAKCe3y6T4XqlBoo/7uda3l9X2Rn6NCN8jBQYNqD2im64ie/TvQvtmpm3l6kRdOzy2AtzIqi7gVMGWcQ+7fAvx3IZ81wJ52FiPNk6YS4wGUhPb6T03a3IKVorhblILkk9NNgDKpLUReUAc0YRlDmhj87N93ZQrWGvdCL4Fl7KzZGzIzX2D/g36v+43nUQu4y9Xl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(31686004)(36756003)(966005)(316002)(83380400001)(66476007)(66946007)(38100700002)(66556008)(2906002)(5660300002)(44832011)(31696002)(7416002)(86362001)(38350700002)(186003)(8676002)(8936002)(45080400002)(478600001)(6916009)(2616005)(6486002)(4326008)(55236004)(6666004)(54906003)(41300700001)(52116002)(6506007)(53546011)(26005)(6512007)(32563001)(45980500001)(43740500002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUw5cGduQ0hVL1QyLzJwYitmSTBZT2hSd3FaaUNvbisyV2FWQk1yMy9aSExk?=
 =?utf-8?B?cWxiUEhQNEo1RHYxaVpNVVZXRXBrQXdmM0dIaUlUSlMvTEdzeXB1YjhQNFNC?=
 =?utf-8?B?Q3hqdnB1V2U3Tlp6bmxxQVNiV2NHRW00eWNWRlAwK2xGcStidTFoN0Y5TElw?=
 =?utf-8?B?d0UvRDhDMFBFaGR3WE4vOHpzRFk2TGxVNWd3aTk3WkN1SmdXTG1OWm5UWHVn?=
 =?utf-8?B?cTlGdEZtV2NBK2E0UVBwRnc5YThQUVNnb3pOQjdwUitDVksyZGRIZzlMaUps?=
 =?utf-8?B?TCtWRENnOTJhSEF2ODYvVklhTmRuTjFFTVQyc21NYk1ZeWJjL1lWQllneUxN?=
 =?utf-8?B?WjNCS0kwTjZ4QXdOUTk1QTJ2cEs0QnFDZmExaU5jc3pZZkhKZHZPRWdWWjhG?=
 =?utf-8?B?b3BBcitmdnplWGpKbG1QQkpWMzNKL1Izdy9JSTFveTBkNW00QlZtdjdEbW1N?=
 =?utf-8?B?bDVwRGpSbktOQm5DYnkvNHNpOHhHVHY4cGNtNVo1Z1ZocnlUWkdvUkZ6Z1NM?=
 =?utf-8?B?U0t3eUMvMlhlVzM4VzRhWGxTZjR3Mk5SZlQzeUc1TWdtS0pVTDZkYkRHbUUv?=
 =?utf-8?B?a3REMXE1N1J4QVJFVWtxZFlacE11aEM3S1k3YkFaZGZnd3F5ZVRsSDRjeWpG?=
 =?utf-8?B?NVZlWEEzUHcyMU1ndDNjSitsVjNiZWxVYUVrdkczSzJ6OWN1Lzh0UUhHOUlG?=
 =?utf-8?B?SmxJYmswNUFuZCtYNUN3QlNWUkVFN1k3czFvR3l4dW1vb0t2TGFoZzh2MWl6?=
 =?utf-8?B?cDMzVUZZTURlakVOMlVVOGdyK3dHS29OblMrL3U5UGw3MUtrcWpxUE5IUjhY?=
 =?utf-8?B?UDJOR0dLWUthcWUwc0RkZnNvaFY1bHhRWGUweVhWdjlOV3JPV205NzVKbXJv?=
 =?utf-8?B?NXZFVUhxcnZzbDR2NmFXWHQ5d1h2STJsak43VFcrRkZBOUx2YlJlYVdSc1lL?=
 =?utf-8?B?a0VwMk9sWHBHZkZHMjYrOC9URHpxeEVSZXpXbXFoUk8wSkZNRUpLSFNKd0F5?=
 =?utf-8?B?MmtvN1B6Mkp3M3FXZDlSYjlQWkFnUXVhdHJ2LzRnVTY1cUZaZkhncFdtQnNy?=
 =?utf-8?B?ZmhEa1hScWMxUnBJSTByM3AzV2hZWklGZmhBclo5ak56U1BvYS9LTjVWdFR1?=
 =?utf-8?B?ME51WFoyY1hRQzJZUjRpbzJleUV5RHJJNWNRMTEreWVUZndNOGNicnhINlMz?=
 =?utf-8?B?WmgyaEtiOGtObDdmSlQ1R1RaaWZKbjVSaU1TY1NsNzdkTzFFOUJpMlQydDhl?=
 =?utf-8?B?bUFQdDhQWEl2b05ZSngwdjdCL2p1YW16T0xEVTB5QldkMGYzL1hwdEV6WU1H?=
 =?utf-8?B?dUV5ZmJQdDZQYXVFUVdNcUd2OWU4NkdJcW5kMVFWQk12TjExcnJhNFNySE5t?=
 =?utf-8?B?K3N2bFdxcmliY0dlRXZBdDBMdkRLeTJmalI5cm05MGYzTnIwbFN4VU9sNFRX?=
 =?utf-8?B?clc4K3lXR0FHWGxyek1KOFN4YlVCVEd3UllPYkxuYWM3NWp0dGo0SWErT2RH?=
 =?utf-8?B?WitIMFRtMTVjSm9SZGM3d2lqRDZNa01hQ1hjWUs3ckR2aXZhR290bURSMldZ?=
 =?utf-8?B?alFWOWpLRzl3NDdTaWlZRUdLelkxdUJiQVM2QmxJK0s3QVQremdTOUN6QUJj?=
 =?utf-8?B?dlBsc2k3aXNqMWhGY2kySUJkS2xKRldMREhUcm0vVHk4YlZIM2Y1N3ZjMnFl?=
 =?utf-8?B?UkYrQnNpRDZiNUljNWREZ2V0RFZZd2hSZlpDNUczelA5NStBZm5Pc2VUaUto?=
 =?utf-8?B?aURDbVhkcjFqQW9JVnBJVFk3MDdwUGFsRzJybmxrZmVvWlMvc3pZaVVPa3M4?=
 =?utf-8?B?VUMwNldVaTU2T0ZSWk53aW1obForRzM3YVo5SkZxUE1NUGlrY0MxUUszZ3FL?=
 =?utf-8?B?dXpSMi9MTHRuSUcvT0Z1cy9ndWRuTnNtM3QzZVo0Nk1ZcFVmNEkyeG91RGpT?=
 =?utf-8?B?Q05Ob1J5VGRUelNnYW9ham9wbFZjMTBiL3RzUHlZc1VVcld1V2xZdWdxaU0x?=
 =?utf-8?B?cHowdWpHWUU1Sm94d2c3TWtiNzJjTkIvN2pqamNXZkt1WjVJWko4ck9Jdkly?=
 =?utf-8?B?aUJEdUdob1RYVGEyb2dUTHNhWEhnOGJKbmZsMG9WRTJiR0o4VW5HRkUrcVdD?=
 =?utf-8?B?N0QrM1d5cm1oSkdTd0s5cnVaOTVpT04xTmNaZGpUYTdXd085MjUrZFRQd1Vx?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b66ed9-20d9-4e5c-9f98-08dae29722f4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 14:33:18.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k+hNCOHswtYxAJxJe0WfZ6L7/ac7Tc/OECwpVYP+frrLH1KuxGTL1B59OA9pl3F/XdFy2+CZCr45WbaY0Ewd+lERXsH3/YVVCaSSI2RMmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/2022 12:53 PM, Greg Kroah-Hartman wrote:
> Caution: EXT Email
>
> On Wed, Nov 30, 2022 at 09:39:59AM +0530, Manjunatha Venkatesh wrote:
>> On 10/7/2022 8:27 PM, Greg Kroah-Hartman wrote:
>>> Caution: EXT Email
>>>
>>> On Fri, Oct 07, 2022 at 07:34:25PM +0530, Manjunatha Venkatesh wrote:
>>>> On 9/14/2022 8:39 PM, Arnd Bergmann wrote:
>>>>> Caution: EXT Email
>>>>>
>>>>> On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
>>>>>
>>>>>> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
>>>>>> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
>>>>>> Firmware Download on every device boot. More details on the SR1XX Family
>>>>>> can be found athttps://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.nxp.com%2Fproducts%2F%3AUWB-TRIMENSION&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C46c5718c03ee429cf57208dad2a3cad7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638053898170779252%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=S2BswHaF22edAfiZXEKUwGfUTNi1nuQzQSdGDb26peI%3D&amp;reserved=0
>>>>>>
>>>>>> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
>>>>>> Interface (UCI).  The corresponding details are available in the FiRa
>>>>>> Consortium Website (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.firaconsortium.org%2F&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C46c5718c03ee429cf57208dad2a3cad7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638053898170779252%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0fFcimUd6gOxTV0EKS%2BfxRZfrMDg0fytq1eSDmkMZ9E%3D&amp;reserved=0).
>>>>> I know nothing about UWB, so I have no idea if the user interface
>>>>> you propose here makes sense. My guess is that there is a good chance
>>>>> that there are other implementations of UWB that would not work
>>>>> with this specific driver interface, so you probably need a
>>>>> slightly higher-level abstraction.
>>>>>
>>>>> We had an older subsystem that was called UWB and that got removed
>>>>> a while ago:
>>>>>
>>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2Fdrivers%2Fstaging%2Fuwb%3Fid%3Dcaa6772db4c1deb5d9add48e95d6eab50699ee5e&amp;data=05%7C01%7Cmanjunatha.venkatesh%40nxp.com%7C46c5718c03ee429cf57208dad2a3cad7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638053898170779252%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=XXYgofE9LlBCPGW1aKxKUOBEIGF0aQv%2Bh6x6iNATkLQ%3D&amp;reserved=0
>>>>>
>>>>> Is that the same UWB or something completely different?
>>>> Basically, it is SPI device driver which supports UCI(Ultra-wide band
>>>> Command Interface) packet structure. It is not same as in mentioned link.
>>> Why isn't this just a normal SPI driver and you do the "UCI" commands
>>> from userspace through the device node there?
>>>
>>> I know I asked this before, but I can't remember the answer, sorry, so
>>> please include that in the changelog information when you resubmit.
>>>
>>> thanks,
>>>
>>> greg k-h
>> The IO Handshake needed with SR1XX Family of SOCs cannot use the RAW SPI
>> Module's APIs and hence custom APIs are added for communication with the
>> UWBS,
> I do not understand, what "IO handshake"?  What is missing from the
> userspace spi api that is needed here?
>
>> With this will get required throughput for UWBS use cases to avoid multiple
>> round trip between user  and kernel mode.
> Based on the speed of the SPI bus, this should not be an issue at all.
> If it is, please provide us real performance numbers showing the
> problem, as there are ways of speeding that up.

Not only throughput and also this driver customized ioctls to be controlled

from the user space for different scenarios.

Current driver have UCI (UWB Command Interface) specific header parsing 
logic.

There is a specific GPIOs hand shake mechanism required between Host 
Driver and UWBS

at driver level which is tightly coupled with our UWBS chip.

Basically UWBS expecting acknowledgement from Host driver after first 
interrupt request

triggered then Host driver acknowledge to UWBS through dedicated GPIOs.

After this one more interrupt request will be triggered from UWBS for 
read operation.

> thanks,
>
> greg k-h
