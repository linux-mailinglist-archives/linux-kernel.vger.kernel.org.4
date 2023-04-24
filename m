Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6646EC388
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDXCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXCMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:12:51 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4A9E60;
        Sun, 23 Apr 2023 19:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL5lqzXGfa3iQR+dLUHASw3GX2ZUMdRbxgloMvkZGo4ja3KDiWX4J6LGaBe7SQezsMwvG41L33rc0FmWpPQs3CSsBQ3mJF/BG8xA+hc+nMhmJiw4QnmMvvamMNBO32RSceUk5s23vAwbUNnBwos83eB14UOBI1WIgPd/DW8gOITX1K0Lt+ZCZed2VGkJp8GcRD8jEcCg9KhByZeGefXEBDvu70ptj/nM3DSUVm2Dn0VhKqOVzMcOiRfhioTDemTwLL64YARQMvEPmvQn1/Vk9YMLQ1pSmkOO0nikoKxRn0Yqb/vhCMfqXm1XnPqWRls04QwCZefxqGfyHbnSF6Nq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc0/i9f6rkR0tWcwzjBkiBDH/N7i1HyZzd053FWysAU=;
 b=LkfO+iBLvoObWdUWTulnC4oqc+8potMhNgO7zvdxXUf1VL3TjW6Ft0bCv0AFUMnAGkWCa0Y9OTub0ZfMPii4PJpejePFwKBFP0sSHQDZOscTvoy7MPz1cT0nEEcVmy47+XIPBgrHlg6HdiFyWMFw4T7ik7y+IBgUAwTc9xVO3aduNvuKbzpHYgxbCJOCMH5Sbusr3J+xOYtdkxzvN6LX5al84GAagba67l4+bj8ViL19eT7pYzhYYy2pk+l5iLTheCpKdWuUHWtXAIqnN7ZFCW8aD7Qd6B5W3I40OY5NvJpVTuhvtCrCbDSJ3Hm+KyVVibVqUJ8FU/w+UeP29Sa6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc0/i9f6rkR0tWcwzjBkiBDH/N7i1HyZzd053FWysAU=;
 b=aaW/31nakN89JNMVfocmDdzI0Lomsv31dc5CL5nxsorelfUw5m975J3Mm5/4wyBVcXn7c8UXvEpWRY1BuKX+zCCo9zvyWGpgJbVBtLd4g9pXxBUjPxtAM5xZA6Gnrw6Y+e82rUac/AbQbxSTDg/cFS1XVPpAKeAtzAQqnCUQvGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9123.eurprd04.prod.outlook.com (2603:10a6:102:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 02:12:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6319.032; Mon, 24 Apr 2023
 02:12:45 +0000
Message-ID: <4a2c9395-498e-fe3a-10dd-f2525885db48@oss.nxp.com>
Date:   Mon, 24 Apr 2023 10:12:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
 <ZEJXpCdf9pWgoXL6@e120937-lin>
 <3041c92c-385a-00cd-87cd-d8b906dcd84c@epam.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <3041c92c-385a-00cd-87cd-d8b906dcd84c@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b56a93-6cb8-4401-55f5-08db44696489
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjB/iIXySITn82sev5Af7EZtGUAFezGXuJ0FLH2INSH3bf2FBfgbkNK3qUE/I2fAYP5tFJ1DybG7EusTXw0+opka9iGJ5BCr+W2Cfm2cdzxyWf5J3/W0183C1O8kULB7jPimOznlTEBHfywyvvCfwM/PYZGyhqFAaDTlm4JovOA8drU/JaDyCzm64y6Lk5HqpakJiyZl2XH4WqSfpC/riREsCIsuDnnWZu1ptlE70DTDUt4N7BiArBGFD5AJE/713bSxVz7U0zMim8iiFmfYzZsNPYUowCHI1HGSeWQ1/sqMCCbfsVo/0epm6AW6tOeKbb+uzHt3cYzlKLZyGE2vpKfpiTlHMsne5fAzebgdbt1pLBIUtQ2/pTcPACUvN/TITrXPfmBWHmVqHsiY9Gg93eagY1C+3yScc/fiW9y97za1RaB2aTBZlx5XNn1cHFF0AVFreu67bJhai/00Hdl44/6D3n6NsqrFnXqTiTIFnKi1tRmnFsmaw7poVkRTBryLuSM7u/0VSNzOG0htVqqv+XYynDE0TFP8V8BnEhDkzZYZk9/I3nawTeLXIOPjMS4oK3NaXausT+hmzbviixN9eTe4q6Aoz/5sG2MHyq6LYBOOnFvPVbSKQxkP/2DzQMg054BHaHgqUdI1fw4krBJA/zlKpr+mapBUG62CAMeUoeJ2JeACYOravCP+Oay6P72N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(44832011)(7416002)(8676002)(8936002)(5660300002)(41300700001)(31696002)(86362001)(6512007)(26005)(186003)(53546011)(38100700002)(478600001)(6486002)(6666004)(966005)(83380400001)(31686004)(2616005)(6506007)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVROUpIUWp6WkRHK1RVck5JSklZaDJIcjhNQ3g1aFVaMHk2OWtQU0tZZnpL?=
 =?utf-8?B?Q2gwY2lQMGJkakZOd1hnaXZyQ1FGVXRKQnRsbFZFQVN2OXAzWGo0QUZJNXd0?=
 =?utf-8?B?WVdsT2RaU1ZHR0U4d2RDTWJOeFIyWk8rNTRzSTA0TVRPVTRhU1AvRzdVKzRU?=
 =?utf-8?B?Tk8vVGJsM0VTRFJnZElQUG0yMjE0SEMwV0hBdTlTZGkzVFZGZXloMVVBQXQ3?=
 =?utf-8?B?cDhFbkJheHZuL3U0VEYvdFR5TjEvNE1SQnZ0SkVVOEYzMUF3WHdRVVJTOC9v?=
 =?utf-8?B?UVk0REVRUnRNWWxNZ3pvTWVkTnJkSUJzRVBSaWNxMUttNHJ3Q01FRDZFQ1lp?=
 =?utf-8?B?WUVaeWZCc0dNUVhZNk5vZS9TRDlQV05CRXE3VWdabFZqWkFUa2FvNElYc1Ft?=
 =?utf-8?B?ZXErRThQQVprS1UrNFJLTnVpZGVnMVlpdTg2Uk85NDF2bzU2dEZRTjY4eS92?=
 =?utf-8?B?b2dGclMwNXR2a3h1M1IvZXF4SlFoaVZDaGtjZFh3eVJ6Ym1ScjZBSmJmTUdx?=
 =?utf-8?B?RFFrRUNjWkNrSTZCamV5azZRc01qMDRJOU9ORFJQVnFkcDFHOFlBSSsyWnNJ?=
 =?utf-8?B?V2pCR05xdmhZdWo1WlptQUJjVTJ3ekZKL0lFSUFLZDJ2SXhTTE1FdjNWVCtD?=
 =?utf-8?B?VzlQSlI4NU54Skh4UC92QlFKUkhsUE96OHN2Z3BpendsYmtTcWIydjB2MzhZ?=
 =?utf-8?B?TEk4a1JURERUaHIzY1hEREhlaXIyRlYvYTQxeG9LNGwvOHQzQzFqQ2VxeFQ4?=
 =?utf-8?B?MGFoWXh2MitqQ3N3cVQ4Qk9NN2ZKU0Rla3RRc0Q1dUs0cU9HT2VjcERFT0FC?=
 =?utf-8?B?MVhJeWRIekRjb3RpSklicFBiUHhmSXpqWGRDdXdmSFRmRWpFbTIrL1FGSGJE?=
 =?utf-8?B?T1NDM2FacGgzeHg1QWFkYmp2cU5wYUZCUnRPbmVRVUYzcnp6VUtZZElZZ0hD?=
 =?utf-8?B?b0pneFVkNWlvSHZYSkJXL01HNEEzdG9ZVjlhVFdTOG5OQzdvMGp0c3VNcWJq?=
 =?utf-8?B?TSs5YjRhQ1IyK2YrSkVXNlFROXhPR2xzQktMeldrbmRFMFhVTm8veHJwZ2E1?=
 =?utf-8?B?ejB2ZnI1U25rZUwzcTBBZEVkV0Q4YUZORGVUOVVzMEkyZVZCU04vcGV6R09n?=
 =?utf-8?B?VExxQVBtN0YwTkZmNFhUNklTdHpxTmhEeFFqQzFPY2Q0bTBzMnNRSHJuTElm?=
 =?utf-8?B?M2Y0Ym1kTEprZ3p0OVRWcnFFQksyWEs2Rk9DdmkvdDFLY2JaSlkrcW9JMTNh?=
 =?utf-8?B?dnZPL0hzZGNxMytOa2RQcjYyUmJZbmlUSnpmQUpjL3lOMGEwZDhyb0IweHZD?=
 =?utf-8?B?UDN6cENCckpjT2dGRnh2WWEvMmZwekNtekVQWmx6a3I4SHZqZ0ljVGpzMGJH?=
 =?utf-8?B?UFBhaDFqWks3bFhGQ2FOOHF6alhxcFRjYkR6VklTeFJxOVgvTnpKVUMybTJO?=
 =?utf-8?B?ZUFjMGNSTGZtN1hNYWswbk8yVUoyczNXRVUyNzAvaHpmU2s0MC8rQS9OUUQw?=
 =?utf-8?B?dDRmR2hmTlFHSzRjeVoweE1yemRwWmI5QUJOYk9iUjZ3UTFaNGVHWU9QS0xC?=
 =?utf-8?B?ekwvWk55T0RrRW0zbUpyMGxwcVpBZXVWdXdwb01MZm02VzRFcCs3d2JPbUxa?=
 =?utf-8?B?MEd6RSt2eENTdmJzRmVCUUxWRlR3OG1wUHRCQnBQL3hDSFBmVW5KTlZEQk1h?=
 =?utf-8?B?VUY2d2gvVEZia0VOc2x0ZG9vQkFyMzA0L1FYaTR3TEs3aGtNQS84WWtCYVhK?=
 =?utf-8?B?TUlGUHh5b3VEK0hmenRMRHFBeU5VS1NvWFhIaGxMaStnV3ZBMWRJdlhmQmVJ?=
 =?utf-8?B?WkVINVpGNDBwVnN6Zmhvb2YvMFEyNWdaRzhRZytuMVNrWGpwWVFQTlBlWEwx?=
 =?utf-8?B?b1hobS9PWUEzTTlTaGNoNkh4NHd1M3I0R2lVcGgxUXQzOGNvK0FJU2doUW51?=
 =?utf-8?B?Y0ZNMi9VUitCaEdkcEV6cit5cVVXME91UUNPQ3FzeGxsZDBQVm0xRElHalVR?=
 =?utf-8?B?NW4wZ1FLekxNcThoQTVuK2gydVgva21qUEpxZTZsWmljSU9ZNEhKaGVOWkd2?=
 =?utf-8?B?YThTRUpRSS9pZGhuZ3BJRkZBd2k1TlFHQ29VMVc3NHBTblFPUGtoUUN5TzQ0?=
 =?utf-8?Q?rtSnaEWB2rT4zi6m9RD3mJBG1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b56a93-6cb8-4401-55f5-08db44696489
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 02:12:45.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx7yyruSQOvUoqBUhc9rHNfPoWjvD80HIR3XYn83D9Wz4Mto4Er6X8AOcQk3DgbQQUrbTIJHrW4TdkiIhvr/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9123
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 5:48 PM, Oleksii Moisieiev wrote:
> Hi Cristian,
> 
> On 21.04.23 12:30, Cristian Marussi wrote:
>> On Fri, Apr 21, 2023 at 08:40:47AM +0000, Oleksii Moisieiev wrote:
>>> Hi Peng Fan,
>>>
>>> On 17.04.23 05:55, Peng Fan wrote:
>>>>
>>>> On 4/13/2023 6:04 AM, Cristian Marussi wrote:
>>>>> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
>>>>>> Implementation of the SCMI client driver, which implements
>>>>>> PINCTRL_PROTOCOL. This protocol has ID 19 and is described
>>>>>> in the latest DEN0056 document.
>>>>> Hi,
>>>>>
>>>>>> This protocol is part of the feature that was designed to
>>>>>> separate the pinctrl subsystem from the SCP firmware.
>>>>>> The idea is to separate communication of the pin control
>>>>>> subsystem with the hardware to SCP firmware
>>>>>> (or a similar system, such as ATF), which provides an interface
>>>>>> to give the OS ability to control the hardware through SCMI protocol.
>>>>>> This is a generic driver that implements SCMI protocol,
>>>>>> independent of the platform type.
>>>>>>
>>>>>> DEN0056 document:
>>>>>> https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!y2hR3PEGGxiPjVeXBcgGyV03DPDhzgUKR0uHvsTpiafKgBar8Egc6oOOs-IkFIquhSf-qBzltqEMyzRZHq8eC4g$
>>>>>> [developer[.]arm[.]com]
>>>>>>
>>>>> No need to specify all of this in the commit message, just a note that
>>>>> you are adding a new SCMIv3.2 Pincontrol protocol, highlighting anything
>>>>> that has been left out in this patch (if any) will be enough.
>>>> Is it possible to extend the spec to support multilple uint32_t for PIN
>>>> CONFIG SET?
>>>>
>>>> With only one uint32_t could not satisfy i.MX requirement.
>>>>
>>>> Thanks,
>>>> Peng.
>>>>
>>> IIUC you are expecting to have an ability to set some kind of array of
>>> uint32_t config values to some specific ConfigType?
>>>
>>> I'm not sure if it's supported by pintctrl subsystem right now. I was
>>> unable to find an example in the existing device-tree pinctrl bindings.
>>> This makes me think that this kind of binding is OEM specific.
>>>
>>> Maybe it can be implemented by adding new IDs to OEM specific range
>>> (192-255) which is reserved for OEM specific units (See Table 23 of
>>> DEN0056E).
>>>
>> If I understood correctly the aim of Peng multi-valued request, I think
>> that even if Linux does not support using this kind of multiple valued
>> requests (as of now), if it is useful or required by some of the possibly
>> supported hardware, it should be described and allowed by the specification
>> and supported by the core SCMI protocol support at least, while the pinctrl
>> SCMI driver can ignore this and keep using a one-sized array protocol_ops
>> call internally (since it cannot do any different anyway as of now)
>>
>> IOW I dont think we should model too strictly the SCMI spec against only
>> what the Linux pinctrl subsystem support today, since Linux it is just
>> really only one of the possible SCMI agents and Linux implementation itself
>> can possibly change: it is better to model the spec on the HW requirements
>> or the possible usage patterns across all the possibly participating agents.
>>
>> As an example, for similar reasons, when the SCMI Voltage protocol was added
>> to the spec, at the very last minute, a change was made to the spec to allow
>> for negative voltages, even though the Linux regulator subsystem was not
>> and still is not supporting at all negative voltages as of now; so basically
>> the SCMI voltage protocol API now exposes a per-domain flag (negative_volts_allowed),
>> that allows any kind of voltage domain to be enumerated and handled at the SCMI
>> spec and core layer but that also allows any SCMI driver user, like the SCMI
>> Regulator driver, to decide on his own if negative voltages domains can be
>> supported: indeed the scmi-regulator driver just skips the initialization of
>> any voltage domain that is found to be describing negative voltages.
>>
>> Here is a bit different, it is more of an optimization in the call path
>> than an HW difference, but I would follow the same approach: with the
>> SCMI spec and the core SCMI stack (the protocol) that supports a multi-uint32
>> call as a general case, if useful for some scenarios, and instead the SCMI
>> pinctrl driver that just ignores this possibility and keep using a single-value
>> array anyway....then, it will be up to the guys leveraging this multi-valued
>> call to come up with a way to use it on their systems, possibly maybe contributing
>> back to upstream any needed modification if general enough
>> (not sure about the details of how this multi-vals operation should be...we'll have
>> to discuss that about the spec all together I think.)
>>
>> In any case, I would definitely NOT relegate such possibility to vendor space,
>> since it is something generic and, especially being just (as it seems to me) an
>> optimization on the call path at the end, it will just lead to uneeded duplication
>> of functionalities in the vendor implementation of stuff that it is already
>> very slightly differently supported by the standard.
>>
>> ...just my opinion anyway, I'll happily let other guys in this thread discuss and
>> decide about this :P
>>
>> Thanks,
>> Cristian
> 
> That sounds reasonable for me, although I can't imagine the use case of
> multi-valued config values (most likely this is the problem of my
> imagination). So I'd appreciate if Peng Fan could provide us with some
> examples.
> 
>   From my standpoint - ConfigTypes are meant to be simple value because
> they are mostly related to the electronic properties. But I agree that
> protocol should be platform-agnostic.
> 
> It will be great if Peng Fan could provide some examples, so we can
> think about the best solution.

Just replied here:
https://lore.kernel.org/all/b9eca9a4-f4b6-b98c-2861-eb14380d2d5f@oss.nxp.com/

Thanks,
Peng.

> 
> Best regards,
> 
> Oleksii
