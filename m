Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03216CA8A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjC0PKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjC0PJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:09:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2090.outbound.protection.outlook.com [40.107.7.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047642D60;
        Mon, 27 Mar 2023 08:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvPuNKKIKC5iZQbNTxCHmcT5sTBlYqvko2wC0t1AsVgGeMvGyNOl7jFfqANKULNqTZ0Zf5ixqcA6Yrre1p1YsgY2vvdMu14FBfIcSQCLcxgVF50V2NITDHhM6eHsqy6cXBl1a1hlOLcOpgi07VE2F4eCfvgIkvZF62Axh81R3PbvMFSs8fls/3+8h8DqPVeElGTzVOd+apx9k1vkolmSNPBW4MgAunXmV8cPCSo2MSTfva/5I51eq4oHQMrIFByLf3w5v9avPAAvqWKhQEUjmoWAw6cZnpKKeXeTZYXBiOfDNiNL1kP1jASdDHFCqA11A2as2m7CFIhtyyxtKcsI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uei1fjG6m2iMgGqH32vM9Lc1PqvOh0NxpkYk1spxf9w=;
 b=BMV2wL198TVo21kbAO+ANmt7+nmIZyxivN57/vesCvWugVY7U/8xyj+QTKUVwlRrO5ZVmXgrpnXrkzOM6SvbjzO/s6UutcYUMVkNDHRGXMRkRr/ZTenVWYIGJHJAxLPfbD/Y5olHbtZyDghsvFOEf2xRDa8k/ADOvSbpjQQHUPFLPSKPyYcvMT7r2fVn5v7fyy2Vu3aPBTmj0StCglSbGi4LQo8Xr9xjdCMqwNl6JzNZPuQbCuwc+vcr/eUZY6ulIOjxuHzh4Al+FmpN1UVeG5g3r8gAPMcBmNqQh1u/2MBJj4yCWRu+NNQgMyllQ1V6vOvYV8Jp6V7DJr+sRAbaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uei1fjG6m2iMgGqH32vM9Lc1PqvOh0NxpkYk1spxf9w=;
 b=iZkuaOS4yWm71LtqTG4Lj3cwPwqK/PWWvo/jNtqqJjZLDwzsT3HOaV6W1g0KOt+ZU2QGskjnxDj5SI+LBBJMjvVNOF0mIgdqyDvxJAdnvzYXIPKtXI/2p6qQF+OyiLITene0fIHHjojAlPK87fyh7Qjomz/yT8js1eWNiY8FRVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS1PR10MB5506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.15; Mon, 27 Mar
 2023 15:09:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7ec3:9d2c:15ac:e1af]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7ec3:9d2c:15ac:e1af%3]) with mapi id 15.20.6254.016; Mon, 27 Mar 2023
 15:09:46 +0000
Message-ID: <38476dd0-07a6-310f-1fba-2b3021a5b007@kontron.de>
Date:   Mon, 27 Mar 2023 17:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Content-Language: en-US, de-DE
To:     Peng Fan <peng.fan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
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
 <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
 <20230307202629.GA1693781@p14s>
 <021fd1cc-0ac6-c7fc-2523-48c1debf96ae@kontron.de>
 <8736e543-3e8c-25b3-0107-ce59296227c9@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <8736e543-3e8c-25b3-0107-ce59296227c9@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS1PR10MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d12a84c-b7c3-4ffa-d499-08db2ed54d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkpJaEBouHvBvujanLvITDLy0qYM/Q8WNGyLnKqWvn79KehQIxvnz2lYMa522rfGFcB3aemtk5h2hyHtC4km0rQnZNm8xnJBVCHEc/pO7cgxWjazhgYs61MbiowM1EtXJoyFbOTjcfIunnZ8wPLSwsC3IQSuMZdoqvHqAvhmCO2J1vLDrH7PJ+yVMz6MAfHgGeWhH6XFPIC0EYTSlQfH3/nvJTcJGCJskYE0SFho8LhzrIec7wUqsrWQPs8nfIVcrx/XVfBzzk1I/yyqlNhwgo/ZiM+T1b8q+bshwWnZyJn1bAMApYA8MOMjFoN3/mw5at4Y2bnILUuleXJwJjHfsHXu1csQRMTJfMOQCRNIW03gA2fQwXWj/bLHsWcV2LQYri59kmz3M9d5LAogTw0ZV1wmB4/bvCrCtb/LwCCM6jo1vlrVQnL0kn7FZmQb4uXlH5yigxt3/oSAdDeRvK+XE0z09eP2Vq2xlN1QZO1a7BCXeXKCtU5tIpfiIQkF9tByqWorYzrXH0q6woSOfIIIZf0wNjRlgCskRIeJpDWMM5kou5KHa+PRIuujFSDUAv7Dt2HV4QCol+Nt+BnaDcjQEcQj92nwLzFpx8lw+dYV/xiEnJepquPrz9gzyLpsm+CZd/04gL525LCVEZ+UMbn/SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(6512007)(31696002)(41300700001)(478600001)(26005)(53546011)(6506007)(186003)(86362001)(8936002)(36756003)(31686004)(2616005)(5660300002)(4326008)(7416002)(6486002)(66556008)(66476007)(38100700002)(66946007)(8676002)(83380400001)(44832011)(316002)(54906003)(110136005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTF4VTg1bW10SnBvaFdwRmt5bzVxZjJHS1p5TUxseWxLeUE2eTdiYkdYelE0?=
 =?utf-8?B?dDZHY3VYWWJuZ0ZuKzA3TDM2eXVIK2lFVXIzaUx6UitxVE1DS21QY2I0T2l1?=
 =?utf-8?B?R3lLVjhtOXYvUjAycGFCbzBhclpKaFVnOVdYa3Y1RFVqMFhwQUxKRlQ4aEpy?=
 =?utf-8?B?bEhZekhZM1NVQW8rT3pZemppTkoxMXhYaFVnOXoyNFJzTzBJcTNrUmczQjM1?=
 =?utf-8?B?enJCeHB1OEpsMWFmQUVBMlo0ZzdMZ0w0aTZjdHlXcXlZdFU3V2lPajBoZHAv?=
 =?utf-8?B?MWVRL0NWQlR0UmRhbWd2ZGhreWdPK2ZLdjJTU1pIdE1mUi9RUU5XVFNHZEU0?=
 =?utf-8?B?M1BHVEZsTDl4NUdQd1pnV1I5ZFFsM1ljK2xNQjNlNkRLRnpPeEFKRGFCaXd3?=
 =?utf-8?B?YXNuQ3JuazROZkxUM2lOZnc2cFoycVl0eSttN0ZVaEdQdlFXQ2dKaURhMGNp?=
 =?utf-8?B?dnNCSEwxSmFIRHdJS1BTQmFIQ1h4Y2ZQOVdwQWQ1dUtNbXk1eTIyMlR0NGV3?=
 =?utf-8?B?bzhuZ3U1UlpuSjVwQlhKdHNSbU9KTmNRNmhWS2JZbVVNblV3TnI0SVVqdEZC?=
 =?utf-8?B?R2ZsM1k2NS8wRW5NSmZPVldTdkhOVEZQVzhwNDVRV0RiQXZHZnpHQWc4WjN0?=
 =?utf-8?B?dlA5Z2VtZExyOEZ0S0xSY1RJSzJnMUFFNUVZSTVMVjRBZm5uYWJ6Zy83dFdl?=
 =?utf-8?B?VEpPVmRiR0c0M1p4Y2dOVGN4TUNhSUdPOXh2cUJINmU4NzJQZ0ZxbXhmam0w?=
 =?utf-8?B?ME9zZGIwV21YU3lWZkZiMkkzWE5vUFVMQTluTkdWdmlZUXYvOGZWdVZqTVhC?=
 =?utf-8?B?TXlrc0hOTWdJZWdkN2dMcE9lb1gyeWpBdGxvNHdxRXFFOGlUWHlINHBMMHlS?=
 =?utf-8?B?b09KU0ZJQ3dPcURKSDhsYmJtR0tHTjF6QzgwR2pSeFU1ZzUxMno1aUNPYnFN?=
 =?utf-8?B?L2s2SkxtdGllWEowK29xRUFDL2NEYTYzZCt2VXFqa3V2ZGxJQlV4eElUbkVL?=
 =?utf-8?B?aHdDMytGS2lzcEZ1TTduQk9jaGlKZmJwWWhjYTJPbGJyMmhQaEUxZkd2MzF2?=
 =?utf-8?B?cVZibERjNFVYUUkwNzNzT3dtcmtHazdoWjFDakFrU01CZ3BJS0crN3dzVEov?=
 =?utf-8?B?WDNBbGpid0F2aGFaY1ExYWRtWitxZVZpWERyNTJqWmp1Q0VLWlVCaVhjM05Z?=
 =?utf-8?B?SS9TZWtkT3NpbDBkaUFLT2dnSTBmL3FEZVg4RWkvb3MzMURlVmFPY2RjY24v?=
 =?utf-8?B?SGt1N01mUzVJbTBUcnlRRDJveDltUzBoZ0hFbFRZcUo0MFgwblI0YURoLzg5?=
 =?utf-8?B?S2pNdWs5QkdyRHUvTW53cU9ZemVtcC9JVGErdnJ3Uk9ZWjVQSi8rZ0JEb2N4?=
 =?utf-8?B?MGt3RHdqc1BoZmdKWGJhK05obnhmdzZZTlVuMXdDL1piR014WlhOTE90anBv?=
 =?utf-8?B?V0MrclhsQjhwNW42WXJtUGVJalJDWFBxeHcxL2h0dVNFNEZBUzVtYmtDKzdQ?=
 =?utf-8?B?cC9uZHgzQ1M2YVhyOTlTQ2E0MTNLV2I2TXZYbWRBTmRCYUxoRndGWEU5M0p6?=
 =?utf-8?B?WlY1czBLTHM5blpPZG9OZGNUZTZ6eFE2ZFdDenhZcXRIVENhbU16c2xmM3I0?=
 =?utf-8?B?Y3QrZ3poZVdiZ2pyNzZOZFphUGkxL29OVmI2OTBLS0RtV2E0WVlCeDVOSzdJ?=
 =?utf-8?B?aUZkRmloWHhmZU5SYk5SLzJGdElBVTZna200ellZSFhwenRvb2R0YWVvZU44?=
 =?utf-8?B?N3RNNEgyZzlZU2xuOWFpektQZDEzMEd6ekxrN00ycGxmL2I2VnJBdlYzUlI1?=
 =?utf-8?B?R2J0QTd1R0ZHWUdwQlQrQXZCUUdkRHlGdnNHOGpyL3lzT09ncmtkc0RwVmJO?=
 =?utf-8?B?b2pxYVBuUHc1NHpoeDNKS0RqWk1CanIwWStieDkwdWZVRis4d3R5K2NrTko4?=
 =?utf-8?B?WnlLYU8vR3BQcWRCOFlIR0hweSs0L1dOc1RKN2tWVU1xWHYyVUhPU2NVc1B2?=
 =?utf-8?B?bVpSQTN3TVBoTVF6MSsyZHp3YTg1Y2JKNGpoa3Y1ZVJ0TER1VElIdGI1UG5Y?=
 =?utf-8?B?dlozRzB2cVE5KzYzditKVmR0eHZPQmFiOStKSFRyVUFRczViNTZHY0dqRThB?=
 =?utf-8?B?YXJnZWJaT2lLbVVKSDRsU2NlK0pRemZ6cGpXaitvR0tvTkxrYkQxK0Nhd01k?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d12a84c-b7c3-4ffa-d499-08db2ed54d73
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 15:09:46.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8w0FlC9hB8XL9aHlZARRe6NQrK9X41dj/CdJuCtGM5vYILVZStTqELoBqYt7gbRZYsN3IGCtuYLYP0iqcN4DYayg5/JPNnfnC4vl2sUH50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5506
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 24.03.23 11:20, Peng Fan wrote:
> Hi Frieder,
> 
> On 3/22/2023 6:59 PM, Frieder Schrempf wrote:
>> Hi,
>>
>> On 07.03.23 21:26, Mathieu Poirier wrote:
>>> On Sat, Mar 04, 2023 at 03:59:38PM +0800, Peng Fan wrote:
>>>>
>>>>
>>>> On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
>>>>> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
>>>>>> On 2/12/2023 9:43 AM, Peng Fan wrote:
>>>>>>> Hi Iuliana,
>>>>>>>
>>>>>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support
>>>>>>>> firmware in
>>>>>>>> DDR
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>>
>>>>>>>>> V3:
>>>>>>>>>
>>>>>>>>>      Daniel, Iuliana
>>>>>>>>>
>>>>>>>>>        Please help review this patchset per Mathieu's comments.
>>>>>>>>>
>>>>>>>>>      Thanks,
>>>>>>>>>      Peng.
>>>>>>>>>
>>>>>>>>>      Move patch 3 in v2 to 1st patch in v3 and add Fixes tag
>>>>>>>>> Per Daniel
>>>>>>>>>      IMX_RPROC_ANY in patch 3 Per Mathieu
>>>>>>>>>      Update comment and commit log in patch 5, 6.
>>>>>>>>>
>>>>>>>>>      NXP SDK provides ".interrupts" section, but I am not sure
>>>>>>>>> how others
>>>>>>>>>      build the firmware. So I still keep patch 6 as v2, return
>>>>>>>>> bootaddr
>>>>>>>>>      if there is no ".interrupts" section.
>>>>>>>>>
>>>>>>>>> V2:
>>>>>>>>>      patch 4 is introduced for sparse check warning fix
>>>>>>>>>
>>>>>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core
>>>>>>>>> firmware
>>>>>>>>> could be in DDR, not just the default TCM.
>>>>>>>>>
>>>>>>>>> i.MX8M needs stack/pc value be stored in TCML entry
>>>>>>>>> address[0,4], the
>>>>>>>>> initial value could be got from firmware first section
>>>>>>>>> ".interrupts".
>>>>>>>>> i.MX93 is a bit different, it just needs the address of
>>>>>>>>> .interrupts
>>>>>>>>> section. NXP SDK always has .interrupts section.
>>>>>>>>>
>>>>>>>>> So first we need find the .interrupts section from firmware, so
>>>>>>>>> patch
>>>>>>>>> 1 is to reuse the code of find_table to introduce a new API
>>>>>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX
>>>>>>>>> driver.
>>>>>>>>>
>>>>>>>>> Patch 2 is introduce devtype for i.MX8M/93
>>>>>>>>>
>>>>>>>>> Although patch 3 is correct the mapping, but this area was
>>>>>>>>> never used
>>>>>>>>> by NXP SW team, we directly use the DDR region, not the alias
>>>>>>>>> region.
>>>>>>>>> Since this patchset is first to support firmware in DDR, mark this
>>>>>>>>> patch as a fix does not make much sense.
>>>>>>>>>
>>>>>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>>>>>>>> .interrupts section. Detailed information in each patch commit
>>>>>>>>> message.
>>>>>>>>>
>>>>>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>>>>>>>> If one can build their firmware as they want, then the
>>>>>>>> .interrupt section can
>>>>>>>> also be called differently.
>>>>>>>> I don't think is a good idea to base all your implementation on
>>>>>>>> this
>>>>>>>> assumption.
>>>>>>>>
>>>>>>>> It's clear there's a limitation when linking firmware in DDR, so
>>>>>>>> this should be
>>>>>>>> well documented so one can compile their firmware and put the
>>>>>>>> needed
>>>>>>>> section (interrupt as we call it in NXP SDK) always in TCML -
>>>>>>>> independently
>>>>>>>> where the other section go.
>>>>>>> Ok, so .interrupt section should be a must in elf file if I
>>>>>>> understand correctly.
>>>>>>>
>>>>>>> I could add a check in V4 that if .interrupt section is not
>>>>>>> there, driver will report
>>>>>>> failure.
>>>>>>>
>>>>>>> How do you think?
>>>>>>
>>>>>> Peng, I stand by my opinion that the limitation of linking
>>>>>> firmware in DDR
>>>>>> should be documented in an Application Note, or maybe there are other
>>>>>> documents where how to use imx_rproc is explained.
>>>>>>
>>>>>> The implementation based on the .interrupt section is not robust.
>>>>>> Maybe a user linked his firmware correctly in TCML, but the
>>>>>> section is not
>>>>>> called .interrupt so the firmware loading will work.
>>>>>>
>>>>>> So, instead of using the section name, you should use the address.
>>>>>
>>>>> Can you be more specific on the above?
>>>>>
>>>>>>
>>>>>> First, check whether there is a section linked to TCML.
>>>>>> If there is none, check for section name - as you did.
>>>>>> If there is no section called .interrupt, give an error message.
>>>>>
>>>>> We have two ways of booting, one that puts the firmware image in
>>>>> the TCML and
>>>>> another in RAM.  Based on the processor type, the first 8 bytes of
>>>>> the TCML need
>>>>> to include the address for the stack and PC value.
>>>>>
>>>>> I think the first thing to do is have two different firmware
>>>>> images, one for
>>>>> i.MX8M and another one for i.MX93.  That should greatly simplify
>>>>> things.
>>>>
>>>> sorry, I not got your points. i.MX8M and i.MX93 are not sharing
>>>> firmware
>>>
>>> Perfect.
>>>
>>>> images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
>>>> address of the .interrupt address which holds stack/pc value.
>>>> i.MX8M not has ROM, kick M33 firmware requires driver to copy
>>>> stack/pc into the TCML beginning address.
>>>
>>> It's been more than a month since I have looked at this patchset so
>>> the details are
>>> vague in my memory.  That said, there should be one image for the
>>> TCML and
>>> another one for the RAM.  And the image that runs in RAM should have
>>> a program
>>> segment that write the correct information in the first 8 bytes.
>>>
>>>>
>>>> Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
>>>> ".interrupt" to hold stack/pc initialization value in the beginning
>>>> 8 bytes of the section.
>>>>
>>>
>>> And that is fine.  Simply release another version of the SDK that
>>> does the right
>>> thing.
>>>
>>> I suggest to work with Daniel and Iuliana if some details are still
>>> unclear.
>>> Unlike me, they have access to the reference manual and the boot
>>> requirements.
>>>
>>>
>>>>>
>>>>> Second, there should always be a segment that adds the right
>>>>> information to the
>>>>> TMCL.  That segment doesn't need a name, it simply have to be part
>>>>> of the
>>>>> segments that are copied to memory (any kind of memory) so that
>>>>> function
>>>>> rproc_elf_load_segments() can do its job.
>>>>>
>>>>> That pushes the complexity to the tool that generates the firmware
>>>>> image,
>>>>> exactly where it should be.
>>>>
>>>> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing
>>>> stack/pc.
>>>>>
>>>>> This is how I think we should solve this problem based on the very
>>>>> limited
>>>>> information provided with this patchset.  Please let me know if I
>>>>> missed
>>>>> something and we'll go from there.
>>>>
>>>> I am not sure how to proceed on supporting the current firmware.
>>>> what should
>>>> I continue with current patchset?
>>
>> I've successfully tested this on i.MX8MM with an elf file generated by
>> the NXP SDK.
>>
>> I would really like to see this upstreamed. If this requires changes
>> that are not compatible with binaries compiled with the current SDK as
>> discussed above, that would be fine for me as long as the kernel is able
>> to detect the malformed binary and warns the user about it.
>>
>> The user can then manually adjust the linker script, etc. in the SDK to
>> match the requirements of the kernel.
> 
> If you have adjust linker script, you will not need this patch to load
> m4 image to DDR for i.MX8MM. Just put the pc/stack in a seperate section
> in your linker file, and the address is TCML start address, I think
> it would be ok.
> 
> This patchset is just for images not has dedicated section saying
> NXP ones has pc/stack in the beginning of .interrupts section.

Ok, thanks for the explanation. Good to know. I thought there were other
changes included in this patchset that are required.

Thanks
Frieder
