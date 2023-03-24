Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB46C7C71
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjCXKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:20:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC601C7FB;
        Fri, 24 Mar 2023 03:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk7JfLqXnl9oNeX2CLlwdtL2VTFdBsH2OEN0EsGVtw7lVzjKD9fHatPtQ/LKPM7/EoBp1/ns9CAlKIAntgwSmoshfgYACyNfTqKElIpcAMOFJCUA+YASrmWo8CEqBLusQoD71DrWNxKwL1adBkGoM5FG9ew3zgZyqhdi5vtXJkHP/9ahxpyU+qI0X6/rrN+ySKzu0vnLdeEDci5/9bnCVB9gWKnaX8f7tA5lsIWyGy03AcbHuG+vLPd65Gx73hOn2pT6WXMMyIn110gi9lXqrV0c6WDiJ8RfF8WTO2pZXMEHGi+oisWx7UpXJ8qfHkrNsjO9vgFG88O5b3aOGzY5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQQpd6IMYGjhfuUwAtRUBXscNMw8v3scSFfnIS9mZQg=;
 b=Dt+vJ10IPcVrGQwHf/KjsHDdkwxjGu9/eLI/fo3iuGeGuRdogLV9XTMYG2zo0D8TyIYHx1pp30/SC11ahQmaC4u/JAFE93QKqAbzQdcacNYOifQZUYan7Qr+jqQsalwMV0pgjXJZgjUoitW42lsQapUMDI4nXse+iYRtps3nsKp5qGtl0pfEm9SEADa6A+/RJK9DxddZmumTzwXEzQzh3dEuhi+TFX/hZ+eIro9XU4aMNcwAKjvhlI5SSp00MLL01c1z2lGWlUJrDJKZAEKM8DXo+o1S+mwlQCTF1kR/PMspG8ARhH3jGSNfWf+ykPpP4VhpPt0D6d8/yA7Zih51oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQQpd6IMYGjhfuUwAtRUBXscNMw8v3scSFfnIS9mZQg=;
 b=OVcB2VkEyzRbhEB5UTBycsHegrvuBOpHjPgF89NkwAqNoOTe0zTy+7qlV78Kkvte++ULe3/XiDQ3WG2nvnPO8O4a3Nu2zxLnZ3wu56ouKUfxS1bHMq8Qizcy/3KIQNwMq0ZKwSmBtbt4OZRwvjJO1HSM1cpkODADWXQDpDzJdp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9680.eurprd04.prod.outlook.com (2603:10a6:102:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 10:20:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 10:20:28 +0000
Message-ID: <8736e543-3e8c-25b3-0107-ce59296227c9@oss.nxp.com>
Date:   Fri, 24 Mar 2023 18:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Content-Language: en-US
To:     Frieder Schrempf <frieder.schrempf@kontron.de>,
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
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <021fd1cc-0ac6-c7fc-2523-48c1debf96ae@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4e7a81-5d20-4315-e558-08db2c5163d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIE90xemLlT+dlIqRN8GjlQ2qfhtKfLBMFAENo+HvKbW3eYk7pIIV2TUTwxJlOvb5iIsxigBeG3iReEnJu+VBB8aI5oEWNgvxHdwOtIXgsnRNWMgDQTJx06UPo2iAsVuIo5yEkCs7rvFnXeczVWXjNF8sdjhBEFX6x43HWW68Ja5X189TynjJ968SsTbfaHQALIVSMAXenPjBrVuP+VcqrSV2Iig+daNfN58nLinRmsTGEezBbD2stGZH5YsKt0YFSAkmItiv8Y1mEfmx/hymhisJQqZQvSHt0nR1Y8/hYk/JAProUh6+7IhHMGt5RGYKmPYtWCVt3Y4VStp/21ufc2FxJj6Mkoi2coLDAr8fP6b96XZ1FTv2RvwLvnPL5fJ2rrr2ld0oFuMoEmRXqFIgpY2SlwobZZSkdSG139RoRNkSZ38BXgiNg1w8Gi7dpTTQD2X00DnAiKs9moWzZGtGRwF0CjGuH3aYB9qlxnINUVYlrNKeZ7Lb6DJBLub12yxpUpwdhawrCE9y4tFe4CTC7XSOQeZofmpywt2DAWy2R/CmBhOEYzQ2m4NJXWw1O+ZESCoRxQgaSRJwSIkbz1xdJ/9kXtweeGW6PdBpbs4A6Jylej2EXOtrYgSxTJNHWEqBAbv2hpYhvMXLitKjGD1letLtqhFrwdXnNUgr4jRuJ5J2P+p1CCGhlSYMW8X1pr9nB59sasTyevOlcB8UReulfB2ERxo+3/PUA1rdRUp2xTtLy8iyS1tv26ElY6UMmmdi7yFtPFAzhyXYkMeEnkN/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199018)(31686004)(66556008)(66476007)(4326008)(66946007)(8676002)(41300700001)(8936002)(53546011)(38350700002)(6512007)(6506007)(186003)(83380400001)(38100700002)(31696002)(86362001)(2616005)(26005)(6666004)(110136005)(54906003)(52116002)(478600001)(6486002)(316002)(2906002)(5660300002)(44832011)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ZWSDZoTzYrbFRuSTNFdGhoQ211ZzhvYXlkSjFqdDJaTmU5eE5MV2J0d1ds?=
 =?utf-8?B?SWRWb0IrVTdJUHpnQ2dvQ3B0U2lsNkV5ZG90Y0dDVlNxUytYYWpmUG14V0Jj?=
 =?utf-8?B?YWZ4NlV5VTZRVmJJVGJWN0hEM3hrL0FCSElrK1NvM3o4OVBpQmdoWnRpN3Bi?=
 =?utf-8?B?Nys1eFl6L3Jnd1dCMkVXWEV2TWJVTHU0NXZ2ZlNha3kvcnFsemxCVU1BdUFy?=
 =?utf-8?B?SHJ4N01RVDBlZ0htMzF4MVdqbVRneTZuM3JZNmN4ZWRZS3F3WmtWcHQ2aHVV?=
 =?utf-8?B?SHdZelY1VVFPQ1l4dTB5UDh3VmFtV2JuNk1yc0pPZDdhTzhWcjkxdGNoRTF5?=
 =?utf-8?B?djZkdWt0T0lsNzJmYmlkWEU5OUVDdTJvY1FDS2xwZzk5ZFpvQTZMcE41RVk1?=
 =?utf-8?B?U2FnNWhmbnM5TVVDbFhzVldLUnRycnlDT2IrR1B2Zy9Qc2FFQjNvcCtoZ0Zn?=
 =?utf-8?B?VXJwNHd1NGMvWWZndGJ4V0krdWY4Z0UzQklxS2FqQm9QczQrNzl4YXhUV0RR?=
 =?utf-8?B?ak1SVkk1eG5OM3dxL0VaVnBxWGlGR3hzL0hOdzFnYm5RK0VKYjRDcERIM29Z?=
 =?utf-8?B?Q3F4VmV1cm51RGxFL2FmelQ5YldEQVU5M25ET2l0anlKV1NlWStCSDBhVmo3?=
 =?utf-8?B?bDAvdTZ6VlpOcytNenprV3MvV08yWUR1UWlkT2grMk0zL01nMmo2aHBCWkxK?=
 =?utf-8?B?bTMweU5UaTVPSy8wUDF3MmJrMEpkN0FwdTB5bzh1WUdpT2pZTGhJNFBrTWNx?=
 =?utf-8?B?WkwwdzQzVkFCMVhBeVFwOFhidVV3UXVmdmQ0Y2trd2hTbUh0bklIWjM2U0hB?=
 =?utf-8?B?MnQ3QWdYSmdIandHR0JzUXJUNW5abmJyV2RjV3BvVXlpUmV5T1BqV2JVbG8v?=
 =?utf-8?B?Rkd1ODlna3BWTmdtdTNuYUI2MDhKdDlBYXlVN2hqWmNKcFY3bVhEV01BRklE?=
 =?utf-8?B?YWo3aldwdlRyNER0RmgrWlFvcENXUnA1SmNQN0dUZmZDdVhWL2RJdWU5OFZK?=
 =?utf-8?B?YjJ6cW1CVVBuenYwQktiRmUyQkVzcEVNRS9YSSs3ZEZHdGMyMlpnTzJDRmEr?=
 =?utf-8?B?bXcyYzR6UmptdDdqMk5MeTlKaXhZVFBLb0lHakN0VUlOOEZlQ2NXSDNzLzg1?=
 =?utf-8?B?aU12aEM5Z0JtQ0dpb2hIbWp3T2RWdlJMOUloTFgwblFMSGxjVTU4RG9PRVJD?=
 =?utf-8?B?c3VrNWwySkM1Sk5yeDdDRzFkVUVDNnFyQ0MzQW92V01hTmNNM2xaUE1vWmFC?=
 =?utf-8?B?bnF3TVR1dThSK1dzSGJpSUZzMHVKb2FML1FiZ1JOeWhGeUdBUjFwN2o4Y3V1?=
 =?utf-8?B?eWtNRDZWNCsvcG5MN25SbTdra1gwL1hrd2Jwb0RwRmxna3FncUZRKzl1RXdZ?=
 =?utf-8?B?bittcEd5WHNQS29Dd3hLNktJdnlWSmF4dVNGa3owOUkyTEhNNGhUUURLMS94?=
 =?utf-8?B?RDdhYS92dzBhTTg5N2lGazNWdUJMS3I0MmRWcTFTNi9SbmtUT0MvSGF2YnV6?=
 =?utf-8?B?YjE2ejlqRWpud09CODN4L2p4K1p0bzJLa1NTZDlQOGNMdmN6S0xCeStaYkRy?=
 =?utf-8?B?akJTTE1FNUNnNEpSc1NXTXNnRVZzd09OdlN4WnQreWxUaW42YWg3TWRxcDhU?=
 =?utf-8?B?OWxIblNoQ2FtZDBlUjlpUkpyQzMwUUJ1UnNKRTlFYVoyMlA3SWVBZW5qZ2FE?=
 =?utf-8?B?UURoMGFFOXVhVEVYYjVsdFRwNXAyVnYvbjdhZGg3NFM1d0FuMTZ3MnAxaG13?=
 =?utf-8?B?YitKK0Y5TDZRaFNlQUZQRU1vWWZDTG4wTko4MUdrdTlVaitkdExqOVlVN21Z?=
 =?utf-8?B?Nko5RnBUdklibnpzS2pNbUJ0VDZBVkc0ekZvYVRYMjFjdHdoY1hOVkxCbDVI?=
 =?utf-8?B?TG1EeXBWdWV6T3Jqamd3VFc3YjhqRnB6Qnp2WnJxUlIrR0hEMFUweVZmN0pQ?=
 =?utf-8?B?M3lCVUdFQzJqTGlQMW9tSFJFQ2htY0RyS05CaUY5QXgxWTdxWEhHSHRIaDcz?=
 =?utf-8?B?bmJmVzNSWUxLZ1k1M3hqamwvQjB3bTdNc2JrMUtkaklqcEhBZml5SUYra1BP?=
 =?utf-8?B?SGZTTzBaM0QvY3Zzc2dqTWtZVjM2cHFaS2RJSnF5Ri9sbExGT0Z4YlZyNHlQ?=
 =?utf-8?Q?yd7WHFUqgTaVJDkvhb//mFks4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e7a81-5d20-4315-e558-08db2c5163d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 10:20:28.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQjasC3w3U3l4J2Y/CQo75xF3UpnXTr5CaqsnRt02n4RMOpko2fifpYXjrgEfk5DEX+k+ytm0VvDdwVaSanMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9680
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On 3/22/2023 6:59 PM, Frieder Schrempf wrote:
> Hi,
> 
> On 07.03.23 21:26, Mathieu Poirier wrote:
>> On Sat, Mar 04, 2023 at 03:59:38PM +0800, Peng Fan wrote:
>>>
>>>
>>> On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
>>>> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
>>>>> On 2/12/2023 9:43 AM, Peng Fan wrote:
>>>>>> Hi Iuliana,
>>>>>>
>>>>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
>>>>>>> DDR
>>>>>>>
>>>>>>>
>>>>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>
>>>>>>>> V3:
>>>>>>>>
>>>>>>>>      Daniel, Iuliana
>>>>>>>>
>>>>>>>>        Please help review this patchset per Mathieu's comments.
>>>>>>>>
>>>>>>>>      Thanks,
>>>>>>>>      Peng.
>>>>>>>>
>>>>>>>>      Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>>>>>>>>      IMX_RPROC_ANY in patch 3 Per Mathieu
>>>>>>>>      Update comment and commit log in patch 5, 6.
>>>>>>>>
>>>>>>>>      NXP SDK provides ".interrupts" section, but I am not sure how others
>>>>>>>>      build the firmware. So I still keep patch 6 as v2, return bootaddr
>>>>>>>>      if there is no ".interrupts" section.
>>>>>>>>
>>>>>>>> V2:
>>>>>>>>      patch 4 is introduced for sparse check warning fix
>>>>>>>>
>>>>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
>>>>>>>> could be in DDR, not just the default TCM.
>>>>>>>>
>>>>>>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
>>>>>>>> initial value could be got from firmware first section ".interrupts".
>>>>>>>> i.MX93 is a bit different, it just needs the address of .interrupts
>>>>>>>> section. NXP SDK always has .interrupts section.
>>>>>>>>
>>>>>>>> So first we need find the .interrupts section from firmware, so patch
>>>>>>>> 1 is to reuse the code of find_table to introduce a new API
>>>>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>>>>>>>>
>>>>>>>> Patch 2 is introduce devtype for i.MX8M/93
>>>>>>>>
>>>>>>>> Although patch 3 is correct the mapping, but this area was never used
>>>>>>>> by NXP SW team, we directly use the DDR region, not the alias region.
>>>>>>>> Since this patchset is first to support firmware in DDR, mark this
>>>>>>>> patch as a fix does not make much sense.
>>>>>>>>
>>>>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>>>>>>> .interrupts section. Detailed information in each patch commit message.
>>>>>>>>
>>>>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>>>>>>> If one can build their firmware as they want, then the .interrupt section can
>>>>>>> also be called differently.
>>>>>>> I don't think is a good idea to base all your implementation on this
>>>>>>> assumption.
>>>>>>>
>>>>>>> It's clear there's a limitation when linking firmware in DDR, so this should be
>>>>>>> well documented so one can compile their firmware and put the needed
>>>>>>> section (interrupt as we call it in NXP SDK) always in TCML - independently
>>>>>>> where the other section go.
>>>>>> Ok, so .interrupt section should be a must in elf file if I understand correctly.
>>>>>>
>>>>>> I could add a check in V4 that if .interrupt section is not there, driver will report
>>>>>> failure.
>>>>>>
>>>>>> How do you think?
>>>>>
>>>>> Peng, I stand by my opinion that the limitation of linking firmware in DDR
>>>>> should be documented in an Application Note, or maybe there are other
>>>>> documents where how to use imx_rproc is explained.
>>>>>
>>>>> The implementation based on the .interrupt section is not robust.
>>>>> Maybe a user linked his firmware correctly in TCML, but the section is not
>>>>> called .interrupt so the firmware loading will work.
>>>>>
>>>>> So, instead of using the section name, you should use the address.
>>>>
>>>> Can you be more specific on the above?
>>>>
>>>>>
>>>>> First, check whether there is a section linked to TCML.
>>>>> If there is none, check for section name - as you did.
>>>>> If there is no section called .interrupt, give an error message.
>>>>
>>>> We have two ways of booting, one that puts the firmware image in the TCML and
>>>> another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
>>>> to include the address for the stack and PC value.
>>>>
>>>> I think the first thing to do is have two different firmware images, one for
>>>> i.MX8M and another one for i.MX93.  That should greatly simplify things.
>>>
>>> sorry, I not got your points. i.MX8M and i.MX93 are not sharing firmware
>>
>> Perfect.
>>
>>> images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
>>> address of the .interrupt address which holds stack/pc value.
>>> i.MX8M not has ROM, kick M33 firmware requires driver to copy
>>> stack/pc into the TCML beginning address.
>>
>> It's been more than a month since I have looked at this patchset so the details are
>> vague in my memory.  That said, there should be one image for the TCML and
>> another one for the RAM.  And the image that runs in RAM should have a program
>> segment that write the correct information in the first 8 bytes.
>>
>>>
>>> Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
>>> ".interrupt" to hold stack/pc initialization value in the beginning
>>> 8 bytes of the section.
>>>
>>
>> And that is fine.  Simply release another version of the SDK that does the right
>> thing.
>>
>> I suggest to work with Daniel and Iuliana if some details are still unclear.
>> Unlike me, they have access to the reference manual and the boot requirements.
>>
>>
>>>>
>>>> Second, there should always be a segment that adds the right information to the
>>>> TMCL.  That segment doesn't need a name, it simply have to be part of the
>>>> segments that are copied to memory (any kind of memory) so that function
>>>> rproc_elf_load_segments() can do its job.
>>>>
>>>> That pushes the complexity to the tool that generates the firmware image,
>>>> exactly where it should be.
>>>
>>> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
>>>>
>>>> This is how I think we should solve this problem based on the very limited
>>>> information provided with this patchset.  Please let me know if I missed
>>>> something and we'll go from there.
>>>
>>> I am not sure how to proceed on supporting the current firmware. what should
>>> I continue with current patchset?
> 
> I've successfully tested this on i.MX8MM with an elf file generated by
> the NXP SDK.
> 
> I would really like to see this upstreamed. If this requires changes
> that are not compatible with binaries compiled with the current SDK as
> discussed above, that would be fine for me as long as the kernel is able
> to detect the malformed binary and warns the user about it.
> 
> The user can then manually adjust the linker script, etc. in the SDK to
> match the requirements of the kernel.

If you have adjust linker script, you will not need this patch to load
m4 image to DDR for i.MX8MM. Just put the pc/stack in a seperate section
in your linker file, and the address is TCML start address, I think
it would be ok.

This patchset is just for images not has dedicated section saying
NXP ones has pc/stack in the beginning of .interrupts section.

Thanks,
Peng.

> 
> Thanks
> Frieder
