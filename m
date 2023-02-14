Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC8696004
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBNJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjBNJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:57:40 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF825E22;
        Tue, 14 Feb 2023 01:57:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6uKifruEzLMPD3qwoxVgJvfdBO6syHh4FMDxSJCaaKPvs+w4OZy3GgFIOoj2kK8KjukGU6t10dTkiizw6zFpH+6Lt+L9uXNymZND7PJvp8uFl6heYg5/IIpNyIheOk3yKdm3VXWIm2tn8t1rGZqxXYImvzUGbqaf2OmZNmVI6+/RrPrvud5J1AYG41CAUFWd5/AdsZ6kNqiniqjI6em5TMjOR5Cz2jkRxu7ztXRCchygQQTK4XSMRft6KYijsb6R1uclgM1OjGgxZNOtW5GQnV52eYKms/3ilOWTQKELdQLbYjP1pV7iASBF+Dnp0dSUXrI3nQRj9Gciajmyx2q4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOcLj9Ms5Pf9C+vQCwgJZnA3joYYg90R3vd4FYNYrxc=;
 b=IJBysDfbCwmlyEniCmWmexf0dfy3s4pbgD77kyRXGPi5RYCS1zvySI4Tb1kwZRlhcwxt5/+nq2ffsD0V/xW7E60b/ibtuZO1sh/fvPYy/WT95449sKzz9hs3w3K05lQGuzb248etyanj6BqmTmHCfwcPoxL/IiOPtZKHPuJbYs3SLDSDvMNYfr8BTyPAGksfk8A0s/OqGoGLzHNGdYZKG/mTywFx7Ko1ByiLxF0zfBgUpPKCd2ho1dCcso19reoMcIpguqwTh8IAH/J0BMXv6rAO25dGB8IEOhjBIlslFM/pRkvpn8i9PYqlIwCJ10o3XDmeGVbuVfwMMLyE3pN1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOcLj9Ms5Pf9C+vQCwgJZnA3joYYg90R3vd4FYNYrxc=;
 b=ihH9BRotAd5CIB04ORmtEFDKJok1beUqHY7bVQ+Fs6kJMoXsIx5gXt7HrAbIKhDRm7LfiDuagfgvq4cK9bgqnXENEUxbqtXCrfvKlye2evoq6EXdS47AyjQB5Tk/wenTD7Y6cVjMevzV4Q0ij1JDfzC2XljD5BDMeR62xHrPy3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 14 Feb
 2023 09:57:11 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6086.022; Tue, 14 Feb 2023
 09:57:11 +0000
Message-ID: <a608cb04-66e8-85ca-6cb2-651116583479@nxp.com>
Date:   Tue, 14 Feb 2023 11:56:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com> <20230213175006.GA310433@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230213175006.GA310433@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::14) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PAXPR04MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b9679d-2cf5-43b2-eb1c-08db0e71d783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt+HpnU27TLjpxq7zISp0rcf/tly+oLLm91/3/y3l0Glem4rqM3k5LUM6HH9FblEXTOJKNZIdD3TzZ1RT2sUF1lncPSrjymv5XKRm2WPzUFNyJBMSyFgP8CAP+3P1o4jT/u9LihRzmP0VJHrDpxhKhxD3hK1s2MEiphCL2VnqlDr/2a2+NHpu902ut4w81abbwpNx1T4oNk45M1uS5Lk+3A4qRJ9zJB9csaIMv8VLLd+y+GKZh60+hkPgwyvmADJjnieLbicCignFGdC+UnH1Dj4ZK8FhHrKcU5BEhrAO1aSGaq+aZJT9voL5qPC5K2fmEmoCVzblor98E8eGtHodhCTqW5xDjHr4vPQDw63jhmGYnGIhXgYB8I/CX29DHN4oEdoeXnTSMDhCqKIjm43dpIBgEpmsrNfBvLXddSS9ghSErdHnMIpv49AG5nl84f9cz5Emx7YoRrSf8PkNIHD7xGo8NSdDCoRuMKUWOviZXx8gh+hCcCR/Y3o4nX+0c4Fsf8F5LnyWZh+AzWCjknAFLM/7BKFQh4Y+h3vby7xEXNAVUIHvnEWvq0TKDUs/Xa+HP7RezULMZ5ZoFut2OdtdmE0NeA0dGlHPWxDumO7q5Lszq9aDyYyIzunNEmlLoNjAiJkYlfpbTSEtSiDQkHCHpMkpFgPPXB6R+hzVl/mswGc+L1JK03eg6blNSpBu23oxe2FzSLXtFqe2rU7yPovAFS7aERyRlfp4cJRnM1SWrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(66476007)(66556008)(86362001)(186003)(66946007)(2906002)(6486002)(2616005)(36756003)(6512007)(41300700001)(6666004)(44832011)(316002)(54906003)(4326008)(478600001)(6916009)(8676002)(38100700002)(26005)(7416002)(83380400001)(53546011)(55236004)(31686004)(8936002)(5660300002)(31696002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3l6M2I4Y1JRZ1BDSzE4M255MVY1NHlFa0hqUnFWSmlxMC85N1Z1TGtMYjZE?=
 =?utf-8?B?eFcrTFViMzQxb1hGOGVjNmFiTUU3YURLSDdZV2RVMi85U21aWGZsNDhpUEk5?=
 =?utf-8?B?cnVFa1RoM2FTeW1mTDV3ZllUSkltYTZwR0hYTm5KdHgxUUY4MVI4dXhpWCs0?=
 =?utf-8?B?UVJlK01RV0VLejI1aWhROUhLTE9iNGczWXhyTVMrOUxpZmtJZ2FuM0VjOTJK?=
 =?utf-8?B?Nzk5L2cveVh1RkpwNXVqY1VoM2ROUEVld3dEdnZzVVFNRlJyZS9KcjQ4dC9Z?=
 =?utf-8?B?TDZjb1ZjbncwMHFHdTJSU1JEcEM3cjZVRG9tODgyMmNzeDArZDcwZzJhQ3U0?=
 =?utf-8?B?Q0c0ZXhhb2VmZStXa0o0VG01TFpPUHloWGZvYi9MZjJsVnhhaG5vUGZaUy9G?=
 =?utf-8?B?MFhwejFtVkc4ZWF4Y3NlczlSUWt0M0hSTWN4QjRMMXFqUW1GOFc1S2xFbUls?=
 =?utf-8?B?Wmg4bFJUMk5ScnlJY2U0TGUvbGhKTGpDS3dReVIyTkYweHd2dEtacjdVaERV?=
 =?utf-8?B?WGwyTG4veFlmQ1dSck00QTBFc0VzL0VUTUdIRU0zMWpmYnl4MVVNQzBuN0kw?=
 =?utf-8?B?SlRsVFR4aVRiM2lWMUxzZGFxaEF4TUpMTjVEc1lKUnlNdHY3Z2h2eUpHU2lT?=
 =?utf-8?B?b3BXaXA2RmFkd21IQXBVck1LM3U0MTlwSlNFMWtreTl0ZnkrcXNWZSs2bzM5?=
 =?utf-8?B?RE1ja2plYkdEL0dHd1hTK21ieVZsQWYwMGUxRElIdFhIUExZV2VjdXErbU1u?=
 =?utf-8?B?Y1RQZ1ZIbWtPSExub0pibWhiSDdvRHpCTGRGRkJqRzRwQmplV2VmWTFteUVl?=
 =?utf-8?B?WEZLYWY1cTF3MkJ5d29ISmdHc0FwSHhxYXBvWHJVZi9iLzVIZEZnUTg2Skpw?=
 =?utf-8?B?U0dSUVkyQnRVd1lOM0o3SDJzYXpoUDNwY0QvZE40ZGZ2RnJySEpUTk4wZStE?=
 =?utf-8?B?aDd6WkxjQmFMdm5NR1dmWmVSclpKa3pESGprQ0IyTzFyQXhXTHJYL09hOEZz?=
 =?utf-8?B?RVdVY0l4d0cxbkg2ZjBONTZxWUQycnlmQmd4WmRqL2prVlJ3MDdLT2VzY3h1?=
 =?utf-8?B?ZCtzMUhIREVHWThLazVOb0RNZ2p3S2pPSnJJdVNhaW80c2hJOHRaeE0veTFh?=
 =?utf-8?B?enc0QzZZekh0UTFxZmwrUEkzSTlnWEphcUZKOFl1L3hJd1JxUHdFTmdPRUNn?=
 =?utf-8?B?cndCbDFoaFZrMEVJVi9qWUpuWlZXWWt2Y3QrV2lkUW1oMTc2SFVocGNJN0Yx?=
 =?utf-8?B?YmpGWHJWRldRdmswZTFoYmFyMnhPR3VFWlJIeWRIeHIzbUMwVEJpbG5TWjkw?=
 =?utf-8?B?alJnUFJFcGxjT2tucWpxVitNWWJFQTY4dVFXRFZHc2ZYZ1pjN0lNbmhTUGFv?=
 =?utf-8?B?MG9vWklLam53aE9lZnZ5Y2NNeXVaZmFtSVIyV0lvUDg5b0ZUbnpCOXh0RGhL?=
 =?utf-8?B?Nis3SnFsc1p4S3pNTUZHYWQ2UEtiZnZjd2Zva2ROT2xobndCSEl4YVdnWmVh?=
 =?utf-8?B?bGxqbkV5dS9hT2sySjliQklLVmRIQmgxbjJqOWIrUmN2a2tZNGFtRldxUkNq?=
 =?utf-8?B?SWFBODBja0o1bkUwaDJNVlVlN09mbDVwUHRYSFIvR3J5U3FJQ2UrUnBLbGFY?=
 =?utf-8?B?WmEyUVU1OVd0TUNMb2xCc1ZpSnlVMitCNjRTei8yeWdGa2VUQnpxcVZ3YWY0?=
 =?utf-8?B?K096eFExNTFDMTFSU2ZnTmFSUklGV0t0anM5RVh6RG80Znd4WUZQZDBYMXBN?=
 =?utf-8?B?TVJUUWhPL05QNjdrc1VEVnJWWjVSVVgrclA1VWlQZW1ybGVUMm1Demgzd0I5?=
 =?utf-8?B?VzZOckJ1N1ZlNDJneXlGL1kxZ0NzWEwwaFQybXo1bFNLOWRuaWJQQUpFaUVK?=
 =?utf-8?B?MU84YkkxU3pTVmRDNll4cDRrL3hUUWFjaXNNT3kxQmw0WDZ3cGh0K2crRnZI?=
 =?utf-8?B?YVlYS2NScUhWa0gyZ0YrOWEwekgzTDVyVnlnczFOcjBaTzBQblVLdFV5cWN3?=
 =?utf-8?B?S0phOFZjSDVqSG9md3Jpbk5LdkJHdnNqbnBmNFljYklSMTZvR0FzcnVtVmJT?=
 =?utf-8?B?K1VjN3FRZFczVmF5eXVHbWttUjNwWTg4dlpTQitCUjRuNHlYdGFsYU1Sa1RP?=
 =?utf-8?B?MVZXWkFxdllEemlKWDhTZGx0VlFFc1BXNVduSFhBbXl0L0NNc3pKWVM0d2NV?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b9679d-2cf5-43b2-eb1c-08db0e71d783
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 09:57:11.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2jIV8hYVE2wMco6nczJ6b55/i4njFBU2jMyO8LrG46ZzsE3inFvuSgFlgr2ZnkOBtHuI1uUzod5cKW9xfkZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9089
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2023 7:50 PM, Mathieu Poirier wrote:
> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
>> On 2/12/2023 9:43 AM, Peng Fan wrote:
>>> Hi Iuliana,
>>>
>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
>>>> DDR
>>>>
>>>>
>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> V3:
>>>>>
>>>>>     Daniel, Iuliana
>>>>>
>>>>>       Please help review this patchset per Mathieu's comments.
>>>>>
>>>>>     Thanks,
>>>>>     Peng.
>>>>>
>>>>>     Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>>>>>     IMX_RPROC_ANY in patch 3 Per Mathieu
>>>>>     Update comment and commit log in patch 5, 6.
>>>>>
>>>>>     NXP SDK provides ".interrupts" section, but I am not sure how others
>>>>>     build the firmware. So I still keep patch 6 as v2, return bootaddr
>>>>>     if there is no ".interrupts" section.
>>>>>
>>>>> V2:
>>>>>     patch 4 is introduced for sparse check warning fix
>>>>>
>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
>>>>> could be in DDR, not just the default TCM.
>>>>>
>>>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
>>>>> initial value could be got from firmware first section ".interrupts".
>>>>> i.MX93 is a bit different, it just needs the address of .interrupts
>>>>> section. NXP SDK always has .interrupts section.
>>>>>
>>>>> So first we need find the .interrupts section from firmware, so patch
>>>>> 1 is to reuse the code of find_table to introduce a new API
>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>>>>>
>>>>> Patch 2 is introduce devtype for i.MX8M/93
>>>>>
>>>>> Although patch 3 is correct the mapping, but this area was never used
>>>>> by NXP SW team, we directly use the DDR region, not the alias region.
>>>>> Since this patchset is first to support firmware in DDR, mark this
>>>>> patch as a fix does not make much sense.
>>>>>
>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>>>> .interrupts section. Detailed information in each patch commit message.
>>>>>
>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>>>> If one can build their firmware as they want, then the .interrupt section can
>>>> also be called differently.
>>>> I don't think is a good idea to base all your implementation on this
>>>> assumption.
>>>>
>>>> It's clear there's a limitation when linking firmware in DDR, so this should be
>>>> well documented so one can compile their firmware and put the needed
>>>> section (interrupt as we call it in NXP SDK) always in TCML - independently
>>>> where the other section go.
>>> Ok, so .interrupt section should be a must in elf file if I understand correctly.
>>>
>>> I could add a check in V4 that if .interrupt section is not there, driver will report
>>> failure.
>>>
>>> How do you think?
>> Peng, I stand by my opinion that the limitation of linking firmware in DDR
>> should be documented in an Application Note, or maybe there are other
>> documents where how to use imx_rproc is explained.
>>
>> The implementation based on the .interrupt section is not robust.
>> Maybe a user linked his firmware correctly in TCML, but the section is not
>> called .interrupt so the firmware loading will work.
>>
>> So, instead of using the section name, you should use the address.
> Can you be more specific on the above?
Yes, I was thinking of the same thing you proposed below, to have a 
section in TCML.
>> First, check whether there is a section linked to TCML.
>> If there is none, check for section name - as you did.
>> If there is no section called .interrupt, give an error message.
> We have two ways of booting, one that puts the firmware image in the TCML and
> another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
> to include the address for the stack and PC value.
>
> I think the first thing to do is have two different firmware images, one for
> i.MX8M and another one for i.MX93.  That should greatly simplify things.
Yes, definitely, there should be firmware images for each platform.
>
> Second, there should always be a segment that adds the right information to the
> TMCL.  That segment doesn't need a name, it simply have to be part of the
> segments that are copied to memory (any kind of memory) so that function
> rproc_elf_load_segments() can do its job.
I totally agree!

> That pushes the complexity to the tool that generates the firmware image,
> exactly where it should be.
>
> This is how I think we should solve this problem based on the very limited
> information provided with this patchset.  Please let me know if I missed
> something and we'll go from there.
>
>> For all the above options please add comments in code, explaining each step.
>>
