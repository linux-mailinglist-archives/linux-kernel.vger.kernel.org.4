Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11B86C485D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCVK7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:59:11 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2123.outbound.protection.outlook.com [40.107.249.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BC311FC;
        Wed, 22 Mar 2023 03:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvrxiKkpzqLXIHchfmfF7cBJglxD/M0BdZ7Op+B+pXjqmgq0+uRnLtJ0cM6TQerIruTZ/V0GukI29QeJ+CTY0LthAq1CHcfbxOgNHcCLalGcaBXpXr622igcELmaWucCl9PXyJ9o/VVYhxYcIZc46cRx4nkERC5GHgRYm3XWlMYYIZOX1txCF07vThH6Sf7h145jiwmwP4PknsJw05L4sxAYoN8toV7KdKhL1baMkTvux6qqg8EV/DO3wmmJa6go8rb4WjV1IR9v0/etuGEv0Omd+00/D87Gi+HE6DrMJXF8Tkz96SISUF7NnRWmV6V22ljr7AT8d22nRsg8AZlfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja6LtUYEaSl1ULpbtxah+u0I1N76hD/sg2tWjpVRWbw=;
 b=K7FbDaPjMg7QWGIi4BCC50/xW58dImncQ5iMtIPlrjcZ60a49lKSi02xJI6rIw3gp//XcqrhCduuZG1W0g3j2oRvnOe1ivQH2ufwA5Lh6hfYWToeK0eLi9pZW34Mdl65G3cgJ07QyL2KPLQUm4LM6WHBWO4GKFyCZoYY+TCwwPSYURvrwFoh2CsatAC1lepSjTIgFQUYjlY2+2DDNf2Qs5Z+0oEqTdgOKRPj97p7I1P2hxgxPT1wjd4TgnHRQmV1ByAwxkVbj7IvN5o/uzOR2DvZReVI3x1OlHgJlGOefZr26Ge+bDnBBfkrpkrJJ9ErLb9ElLt2wIDd5i4/WwwgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja6LtUYEaSl1ULpbtxah+u0I1N76hD/sg2tWjpVRWbw=;
 b=BsQ7qYIxxLRQUnQNIGHVNSE2UReKk/2frNdDKYGfZ+zq5lsbBtthZ4gJ2Wvu/XLWFipu/xDlMshE+0krstDodf1FjAh/8PuAmX9lEdn3JxhNgVnRoDxuGDyIVsE+R59A6hjjBxdTl18RyXh1HQVAznxyl8qX5+KYqBcbjr9S6lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Wed, 22 Mar
 2023 10:59:06 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6222.010; Wed, 22 Mar 2023
 10:59:06 +0000
Message-ID: <021fd1cc-0ac6-c7fc-2523-48c1debf96ae@kontron.de>
Date:   Wed, 22 Mar 2023 11:59:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>
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
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230307202629.GA1693781@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3488:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e770c0-1044-4159-5858-08db2ac47472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCWqvk2JkbIr+RgVmACp7N2X/1z+X1Ddlp7SjBCvM3+bfGgEOACBSoqsqncMhbDtb+6z9d9i1hljIZUCX6DP1EnVYu4HGlel1Kd6uYBJUS2VVsVIwRpKxtB3ru69jC4792+r1oNyrz1p3lMMAtkTYUsfwTI9SZNPNetNKTF2OzP9zn+aEgjdm7CYw9lmVhEuexHaIg+LRbyRjfBtaZXKDxxH0EwhRm6jWhBhqEB4mp0WQ9kssyKdjRyvnuay87POW6cvlMgHRJi0X6O6JMDBstjdeLXx++/M7B+M32Z9ZPkemT7g7qs9VRoixsnZolHlCLyXYxRLqa+BLbIl2myDpW6fqcZHlZHv22S//bG5zNkHj94MtAyLibfoHsXbG2Grz2/6UDWOZdiqh8qy+U8fAQWiFAka+d+Db7N3DAq0Evl358WZE/hbKfYwrz4/DzX6zORKpSAHFN20TOY5ifCppxW+kdES63lggyHTqy9w88jqVhExEzG8mI+OAEuigF61AOBwoPij3VTrbwf+I511WIsBiaEPLt/XxxinNSYpFTUlSnVYgEGt/Og+SJiAcVzTG88gDPu4b27jFyKR504RgMQ4cA6uErGIXvZxogtVmDtNPPmKqe8HLZIX/i4qdqD2HvFwKPQOcl0Lv4ejY+zq5Jotyy/TihHQTKr5zlTml6yxBKjYQJvtaCAEWXK0WFVQL3Ea6iJBNq9ijcwcPYY+V5rJ0meQWIoJ+ijT5wjJnUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(2906002)(83380400001)(2616005)(86362001)(31696002)(38100700002)(8676002)(4326008)(5660300002)(41300700001)(66476007)(66556008)(66946007)(8936002)(44832011)(7416002)(53546011)(186003)(6506007)(6512007)(6666004)(478600001)(110136005)(316002)(36756003)(54906003)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVGQlVXMS9HYWt0STBGRkROdU1jalBiaHNPTklJaGpsUlFLeUlxY3dNL3Bk?=
 =?utf-8?B?aUhSSGlJL3R4L2JUZ0FJeWRDeWJCK2dsc0JURCtBVUtuUmkvSktoNDUvSzhn?=
 =?utf-8?B?WnFtZWgyQSs3RGh0WS9wZ09yQ3AzcWVjRmM2b0dyUEdtSjFHdEZHaElBUnpN?=
 =?utf-8?B?ZytDNzdFNGxYMWt4bFJqYUhLcVBXMjlXQjFtbGRkdXRhaWtxRE0ycndCUUMr?=
 =?utf-8?B?SENYYUIxekFYOE9sUDBvbDM2ektGWGR3dzN5UERxVTVUdzRZSFE4RlJnM1M4?=
 =?utf-8?B?Z1cvOUFMNnA2OHBIV2IwU2RZWVMvcHZCS3pLUHhjTEZFSUhwTGhqSkN3ZXNF?=
 =?utf-8?B?dXVGa0N5cm5uYUJmK2JBRE5SUmIyakpDMDNnRmtEbU1WTS9YbzVTT3U3Y1FC?=
 =?utf-8?B?TzlwNm8zQ0VGUGl3QTdPYWZQUFZSVjZhbHBUL2hUZ2dUM2JjTSs2R0tYanpQ?=
 =?utf-8?B?eG5DbVo5SUszdjh3M3NXNkJEbEY2Yjd5OUlkc2xiK2FQR29YK1k5VVJ0ZWVt?=
 =?utf-8?B?WnhGcU1oOWRBWCtZS0gzNjFMaHhONEZFTXo4RWp1MUV4a000K21oSk9lSzEz?=
 =?utf-8?B?VzJMRDF2TlhINDFZYkZORDZmWXgrQUtRWVR5OHJUbWtLcmNSOFFnK2lNWGhL?=
 =?utf-8?B?UG1ZSEJmV2d0dFZsalJyQzRrTWJSSDFEajBZK1ZWUkRUOXlWemVuQzNHanNh?=
 =?utf-8?B?R1dRWFRHMUhmK0xtaFZvSUZTdXpFMjE4NnpTd3lsVlFTam1NNnZ2WXBJQnAr?=
 =?utf-8?B?YmZlYUNTTEFDa1B4amh4WEpuMVErM0VHM0trVlJ5U0Q4T29rTE1SMmhkL3F1?=
 =?utf-8?B?RnpEQzNDeU9IRlZENFVPS0QveFMzemFwRVNSWW1Xb1BUQU0vNUNSTndIK01V?=
 =?utf-8?B?dmQ1V0lUNlc4WEZaKzBoRlBpWHNPUGc0L3J5TXBtNnJJYjVwYW1wMFhjajZM?=
 =?utf-8?B?TkpqZHVLb3RWZGkwbk1uSUdOSU9xa25HaENuSjcvTXkydUpvd3RCUEVoM05i?=
 =?utf-8?B?UGttU3dNMU9NNUdxUEY0K0JXQlZla1VUNktuU0h2Mnh3QVhSVjVhaHJlMVBx?=
 =?utf-8?B?WmRiNGF0c1Z2TW03THRsRGkyNXhJWUwxNWphMlNQOUowcGFVYklpTnZOeTJz?=
 =?utf-8?B?YkxJbDFVdWVBeUpScG94b2EyTkFORWRuOVVDYVNnZjY4bjNWRSs0OEQ1dk9V?=
 =?utf-8?B?NzAyVmN1RG5qNEJTMEpOZXNvNWkxdGxMTWprU0hLeUhCMTMxYTVWa2xVSkx3?=
 =?utf-8?B?c2lUUTI5WW14RDhZeGJjT3NqVDRTVzJtcHVaOGdBL0c2cUhrUFpFMis2RFBI?=
 =?utf-8?B?aEV1NkZPbkd4cGxUMUIyTVlSSnlGcitDRVJqNGRDeFdWSmlYcm9SSG5iUExy?=
 =?utf-8?B?WUxFaEU4MzJiQU9YYk50TWF5Z0oxRzF2eWd5TCsyMm80U3I1Ym1mZmpGQ2x2?=
 =?utf-8?B?ZEthN3JvUWVhWnpudXg1bEVzVFV6dEo0UDUvRFlqYkIrZTQ5WUVPcURBL1Zp?=
 =?utf-8?B?V29VUjBEOHg1alJmNHM4aUFpcHEzY2VpcEJENnVXdnVWVjVlQ2NFWi9ZRzNx?=
 =?utf-8?B?Ynd5MWZuVldSMnUxd1p6RHlicHl0OXRsSXptaTl5a3JBbE1OaTlkRzdIZ09F?=
 =?utf-8?B?ZEp0UDN6Tm0zc3pwYnYzUTJDeUUxdXJGRngxdld6V0FsRGoxd1AvUTFnSDMw?=
 =?utf-8?B?cEV5TjNUbHZwMTlkMWgyejkyMlVtVHdTU0dsTE1RUk40MmlqYWFSQzNWRGdu?=
 =?utf-8?B?MTZ1MDh1UEFIdGF3K2ZXek1zckpBdFdWY29jcXpsbEVLSzl1OHlJVnlTamE4?=
 =?utf-8?B?c3ZEaUpSV0tOeFRFUkp0SC9zVm9PeHNvc1huTVFpZGJIQ0hyQVJmMVY1MXdH?=
 =?utf-8?B?ZGRvdExYVkJuUTlBOFNZNGF1VXRkTzc5V21VcktvSmdBVmxYSUNyNDEvUWlx?=
 =?utf-8?B?bjMyaEhCS0dzZnBhbWFOMHdZK21kZk1ad04zeUk4Q01TcmEvQTVXVlNwUVBs?=
 =?utf-8?B?OW04dW5lUG83cEljaE56N0g2ekM2c1RMUXpFcmJxcmdZUzAzOUlaeklGaDg2?=
 =?utf-8?B?cXVRQXhhS2tpMnAvdE9DR3U2ellRK25pZVNYMGRENXF4bUFGOUxJTzlvNUcr?=
 =?utf-8?B?Y291MWc4WWF4TUorQXM0YWdmMzhjYXd2UGJZMFVsSS9ZV201UlBjbzNKT0Ux?=
 =?utf-8?Q?XG7x7hFxbvjmKVIkpFDPz6nFtwbdLBDk692T7WQmtSZ6?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e770c0-1044-4159-5858-08db2ac47472
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 10:59:06.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eplkQ6xvNp7DxHu+rRiimLKJ185FMQ/uplmd9NZv15ydblsjALV6dD+XpayXFs+BQUG8tNvnSWeGD2JfGXU2iKG0aChl1CMg2pqyzt0toE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3488
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.03.23 21:26, Mathieu Poirier wrote:
> On Sat, Mar 04, 2023 at 03:59:38PM +0800, Peng Fan wrote:
>>
>>
>> On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
>>> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
>>>> On 2/12/2023 9:43 AM, Peng Fan wrote:
>>>>> Hi Iuliana,
>>>>>
>>>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
>>>>>> DDR
>>>>>>
>>>>>>
>>>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> V3:
>>>>>>>
>>>>>>>     Daniel, Iuliana
>>>>>>>
>>>>>>>       Please help review this patchset per Mathieu's comments.
>>>>>>>
>>>>>>>     Thanks,
>>>>>>>     Peng.
>>>>>>>
>>>>>>>     Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>>>>>>>     IMX_RPROC_ANY in patch 3 Per Mathieu
>>>>>>>     Update comment and commit log in patch 5, 6.
>>>>>>>
>>>>>>>     NXP SDK provides ".interrupts" section, but I am not sure how others
>>>>>>>     build the firmware. So I still keep patch 6 as v2, return bootaddr
>>>>>>>     if there is no ".interrupts" section.
>>>>>>>
>>>>>>> V2:
>>>>>>>     patch 4 is introduced for sparse check warning fix
>>>>>>>
>>>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
>>>>>>> could be in DDR, not just the default TCM.
>>>>>>>
>>>>>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
>>>>>>> initial value could be got from firmware first section ".interrupts".
>>>>>>> i.MX93 is a bit different, it just needs the address of .interrupts
>>>>>>> section. NXP SDK always has .interrupts section.
>>>>>>>
>>>>>>> So first we need find the .interrupts section from firmware, so patch
>>>>>>> 1 is to reuse the code of find_table to introduce a new API
>>>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>>>>>>>
>>>>>>> Patch 2 is introduce devtype for i.MX8M/93
>>>>>>>
>>>>>>> Although patch 3 is correct the mapping, but this area was never used
>>>>>>> by NXP SW team, we directly use the DDR region, not the alias region.
>>>>>>> Since this patchset is first to support firmware in DDR, mark this
>>>>>>> patch as a fix does not make much sense.
>>>>>>>
>>>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>>>>>> .interrupts section. Detailed information in each patch commit message.
>>>>>>>
>>>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>>>>>> If one can build their firmware as they want, then the .interrupt section can
>>>>>> also be called differently.
>>>>>> I don't think is a good idea to base all your implementation on this
>>>>>> assumption.
>>>>>>
>>>>>> It's clear there's a limitation when linking firmware in DDR, so this should be
>>>>>> well documented so one can compile their firmware and put the needed
>>>>>> section (interrupt as we call it in NXP SDK) always in TCML - independently
>>>>>> where the other section go.
>>>>> Ok, so .interrupt section should be a must in elf file if I understand correctly.
>>>>>
>>>>> I could add a check in V4 that if .interrupt section is not there, driver will report
>>>>> failure.
>>>>>
>>>>> How do you think?
>>>>
>>>> Peng, I stand by my opinion that the limitation of linking firmware in DDR
>>>> should be documented in an Application Note, or maybe there are other
>>>> documents where how to use imx_rproc is explained.
>>>>
>>>> The implementation based on the .interrupt section is not robust.
>>>> Maybe a user linked his firmware correctly in TCML, but the section is not
>>>> called .interrupt so the firmware loading will work.
>>>>
>>>> So, instead of using the section name, you should use the address.
>>>
>>> Can you be more specific on the above?
>>>
>>>>
>>>> First, check whether there is a section linked to TCML.
>>>> If there is none, check for section name - as you did.
>>>> If there is no section called .interrupt, give an error message.
>>>
>>> We have two ways of booting, one that puts the firmware image in the TCML and
>>> another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
>>> to include the address for the stack and PC value.
>>>
>>> I think the first thing to do is have two different firmware images, one for
>>> i.MX8M and another one for i.MX93.  That should greatly simplify things.
>>
>> sorry, I not got your points. i.MX8M and i.MX93 are not sharing firmware
> 
> Perfect.
> 
>> images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
>> address of the .interrupt address which holds stack/pc value.
>> i.MX8M not has ROM, kick M33 firmware requires driver to copy
>> stack/pc into the TCML beginning address.
> 
> It's been more than a month since I have looked at this patchset so the details are
> vague in my memory.  That said, there should be one image for the TCML and
> another one for the RAM.  And the image that runs in RAM should have a program
> segment that write the correct information in the first 8 bytes.
> 
>>
>> Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
>> ".interrupt" to hold stack/pc initialization value in the beginning
>> 8 bytes of the section.
>>
> 
> And that is fine.  Simply release another version of the SDK that does the right
> thing.
> 
> I suggest to work with Daniel and Iuliana if some details are still unclear.
> Unlike me, they have access to the reference manual and the boot requirements.
> 
> 
>>>
>>> Second, there should always be a segment that adds the right information to the
>>> TMCL.  That segment doesn't need a name, it simply have to be part of the
>>> segments that are copied to memory (any kind of memory) so that function
>>> rproc_elf_load_segments() can do its job.
>>>
>>> That pushes the complexity to the tool that generates the firmware image,
>>> exactly where it should be.
>>
>> For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
>>>
>>> This is how I think we should solve this problem based on the very limited
>>> information provided with this patchset.  Please let me know if I missed
>>> something and we'll go from there.
>>
>> I am not sure how to proceed on supporting the current firmware. what should
>> I continue with current patchset?

I've successfully tested this on i.MX8MM with an elf file generated by
the NXP SDK.

I would really like to see this upstreamed. If this requires changes
that are not compatible with binaries compiled with the current SDK as
discussed above, that would be fine for me as long as the kernel is able
to detect the malformed binary and warns the user about it.

The user can then manually adjust the linker script, etc. in the SDK to
match the requirements of the kernel.

Thanks
Frieder
