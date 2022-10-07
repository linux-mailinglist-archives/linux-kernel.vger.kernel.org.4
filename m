Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8505F7373
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJGD4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGD4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:56:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7FEC2C80;
        Thu,  6 Oct 2022 20:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgbRFlzC8WosCLs2SO/ayKpQXhSY9drjzUewdhGCOU6NuiHbliWwHutStod/lf8r7W02PqZ7yOZ3xeYTyohrXA1+HrniUyWLvcGTvZzSqCWAJiDIo/b1uhGkmoywtMQF7I6jrrDPMe0JCyvL4ge7lrqwU4B/EwS9UC9O758jHPvQxJgERaIF8ROz/Gkhg6G3Riyl5NjHmwKYfD1DcN0H66VMUQovbwTBdQ7Mk/lZmTxxf0E8R1i3v4xYvWIY9cIDBYQ8nrfDa2eicfezw8uZbgmDS6u1727zcEem/0s0BLMl2neYYnB2Kae+DoI1daBep9fBW2IUkYog8uJMkKCJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y234KU8weIKY5+At88pURJ+mYxYho9fIjTX12q/1PtE=;
 b=Lh+9xcTDKmJ1ztR36lAR/cEOUr2qHEUAC/foQ2lfxf81IyjADihiASiMITB6bY0N3b++X7Q+Pqrl7h2W27fj71as+44DGB0dT8MqJ30PAC0xKa0IcXhcE+HkIY2iTo8Wa2BHmmvF1p3duPdG1pJ98aeCiKaT109C9DsjdgBepuDjaX6uH/H7+Uxd6G1vpAjILvYM4oBFnBBKTMJShIu7bJHW6GVqtk3gmG1tDP2klRljnQ7MLIuejmd8W9veMzKjqjKYkIroGut6pzu5kkN3mjnQXnN0jRrtsupDeLr3HkAs4U6jtdmdfutSwLutLfHkZn02ptA780CWW2TrECAmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y234KU8weIKY5+At88pURJ+mYxYho9fIjTX12q/1PtE=;
 b=P12gv1XLVLMqaEGYV6Ccywei/g/E4NEIavDdHQ83re9tB1MVh1ghWMdogvgBZRNagyJuQ7f6f81oManPVUnY+YsX2IBIlUKTkxGuT+1N/xnZ5D8HZdUfnVmp4O1Rx1ZghkqC08J/eSy0KwTTjBt/LDuFdd7TyvtHuCJTOzlxvz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 03:56:43 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc%6]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 03:56:42 +0000
Message-ID: <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com>
Date:   Fri, 7 Oct 2022 09:26:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
 <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
 <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0f6c37-6ebb-4541-d2c8-08daa817f208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rK5yXFL+klSwBYrqnK5ZZUwvt64z8sGOTuMUM3ypRAAdFjInwpHulcbNA6lH0CGoImkx1ZdBseGo94LNYJxoTpJ08wxRged1m5qbBxyf3ziY6CfEntDH3C9ytZJIVNNHG2bEXljxTUP9Z1khFFKZGZBY7JfgzZTUIE0jGUibheTFVLcFH6N6YBBpe88MmQGsXPBTlKjkJ7MnRrHbR1uz4ZCKHI9XZVYQd1T4o7TDPDZA4bQrvstmEKyZEVDF/Z5stXKRR/Y5ROY8AcV49b8uzTmPmxk8J7w60zJb5gyPOSNdVhGrAvF/DdD8N4IzSmPBViTnjADeXkB/zz8w5hHRLETsaCB8n7ZLDEwxP7ItmAUvQ6ic/8P6kMv+dN9fGtgatpUTPUt99qO7uXERslnshRVHiigo6ZMy225vlcicNAeDMna6s9GW22mz+mtVHXokUq1koFiP9JwhxA6ioNXrTYyLU/2Vg/R4rXtKw5f2znkXssmLUWv93PP4nqc0+7WIMAQdg2J1dkpJ7rT0pzy5YsSBsiY23Kqbq9lwU0FkbRdymqnJ7srT11cfeMGDNjw0W2PuBYA8/i+Wrgia+NLDRM83m1lrai1KpKgz97L9yv5ptX1Ya+p7mcjVXdu8/th3P9+h7j+94D2sDYPpzyQtL0QAKNJ4d638gg8WBlEK1D2dyOs4NOKf2mrLwpbYC0Q+00CwytjA9mWrJA12JbqKzY022996TEy1oyDdszqu+u1oReEOLptlwNKk610FBVGOpz076hmPsIpJJiROAF24AafVEdaedrjRK8neyadol3O+4LcJnOiH0N5OTfZjlyHxlBH7qohPyElpbeOqYqYL8cNvgl+LpQHt3RtFJeVtTms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(6666004)(36756003)(5660300002)(41300700001)(38100700002)(7416002)(44832011)(8936002)(8676002)(66946007)(6512007)(316002)(4326008)(26005)(66476007)(66556008)(6506007)(86362001)(2906002)(186003)(31696002)(2616005)(966005)(110136005)(83380400001)(6486002)(31686004)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzFrWCtZMXE5ZW5oamVabXlPbzNBWjVBY3dwMWdzdmltQTJGV2VOOW9OeFdt?=
 =?utf-8?B?R0dCajZLZFZBODZzL3JpemJTRjJpOXRhQ1RGZWhjdThHNXpTY2w4WVhZRW1N?=
 =?utf-8?B?OTYyQWVkam9pd0pLaFlvZkpFZ3hVbThyUHhQZTFDbEtLY1lvYVVDYzMrRGZx?=
 =?utf-8?B?WU9RVHg4SDhYSXpxaVBSRUlHbVFXS0ZqM1l0cDJQY1RtMFNIZVdiK1RHMkFt?=
 =?utf-8?B?UlQ4QkJBdmxHVjBQTTlKYU5rMlMxVWJ2U3I3OTY0NnMyNjBLd0oxNTdTODZL?=
 =?utf-8?B?eHNrYkdkTmtOclA0bWZUVmRZVDZvSTlKc2dvbWZMbjZ6Vmk2SGZBN1JBU3FR?=
 =?utf-8?B?UmxlMEo2RUVCRGwvZ2dTeGpuY3YwM1lFT0JkVGxRZ1lib3k3NVRkeVZ0allP?=
 =?utf-8?B?d1cxRlVPV2F1ZnZacjhzd3dQNTJiMmVmVStyOUJFcmJvVGlhd0E1SjdvZTk3?=
 =?utf-8?B?bVhRMFJndkt2dkF6UjZZWG5sbW51NWdsNGZVYUcvMkFyTDYrRXdQLzh3Wjc2?=
 =?utf-8?B?RHo2cmFiZktNUWtodW9uT2Z4R3A5dlRBSkVtUTV2dVQ1REVUSERXYlZpcG03?=
 =?utf-8?B?cWlwUnhjYW9jeVJLV3RSZHpDWUIzQ2ZrcFRlWVpub3c4U1ZhbitYekFUdHhJ?=
 =?utf-8?B?dDZFUEU0R1ZVYjdtZzBKd3BTbjlsS0ZBTm1LazFKT2JCbkdGTGU4MSs5Qi83?=
 =?utf-8?B?MDFCNWh3WjBLTUh2MFlRSmlJalVmaTB6TFFuRWwxdDRUZFB2cnVQRWw3Ny8w?=
 =?utf-8?B?UGd1dTFxcno3UWZ6ZU0wSXc1QmNIdk5YVUpUbGJNTSs1YTd5R3o0QlZheHhB?=
 =?utf-8?B?TkJxbkVWTHY2cGQvZ1VKNjJwVk5rVW9GNUs5VWJZM0FWT1oyVmRrb1pQNmlV?=
 =?utf-8?B?VGZCUERBZkVvMk5LMmpTOW1xSGpYVFRzK2tEYmk0YWlOOEREb1cyYjQvSGc2?=
 =?utf-8?B?ZFBOY2hSUnBBdmlEZkVkbGt1cVZWdlNib1FhbElsYk1JdUNIdTE3bWVZR0FE?=
 =?utf-8?B?cTRKRjIrSVJKTDc4STNGcjMxTWhQd2trV0xlWmN5OEQyMFNWK05NaC9LNzJm?=
 =?utf-8?B?MnZrSnAzNDdiamlSUi85cDRsejFpRnJodCtpT21YaTRrb01WUHdGVko0VTU3?=
 =?utf-8?B?WXlqWjhBMS9pYnFLS05kSmE5VHVxamgrbC9Fb1VpQ0RYWWFnS01XQXhEZlNl?=
 =?utf-8?B?MTFidEhTRk9oNVlHUDJxNHl6bGxiaWErcUMyV21LS2pvd3g3OUMrdERoaTFR?=
 =?utf-8?B?Y3R6N2dYV2UvN0tXZWRGM05OQU1oZ3VOQjNFNjQ2OTJnaC93akNyU3hxWkhR?=
 =?utf-8?B?T3FVZWNVcE5OSDFVYzhRdzRNZXd6ZTRVYTlWYWJsSTFpdHlmeVJxdko1Y0xl?=
 =?utf-8?B?RDJHS2JBcjdoMVhaSVc3cXNhL1g1clp1akpQWEloZFVwQUsvMzBrZ0hkbkF0?=
 =?utf-8?B?eDRkWnRLR3VqWDBkRXZoZTJXV2ZvYjd3Z1hDNktrQzdiNDBVdjNvZUJyb2Zt?=
 =?utf-8?B?ZFRWa1BkTVhNS0Q5aU5vdTN5NjhQZHFOeGkrWXFoNFRaenh6V21zbVFlcVgr?=
 =?utf-8?B?NTlBMnJHSElGYVZUenVLRUZObS83MWRES3drd1h2OThhYkZFdUZrNkUwaG9a?=
 =?utf-8?B?N05DMHRkd0xoOUJqRGduQ2lxQVh3VW10c0w4d2lDVjZNSkowdXowd2gwUUZJ?=
 =?utf-8?B?Zk5La0wrTklzeWtBczIyVE5hN21ZdUp1THo1b1M2R3RTdVdEMlQrb1VhaVo4?=
 =?utf-8?B?ZWVZMlZndC9yTklYY0dCM2JiUmtZVGJIUjk5emNTclZLeWlwSnlET3VmR3Bj?=
 =?utf-8?B?d3RJSnVKOHJRTFNCa2NNMS9vcDh1cnZwU0orVU5oRks0QmMyb0s3VDhuTk5Y?=
 =?utf-8?B?dW55M0NDcHJrNlJCYU9OSWwrL1ZKT2JDeURJRDNYbmpFSjhwWStnU1BPRFNF?=
 =?utf-8?B?anZmYzVvbjJ3VCt1anBpVi9kVVhybElSdGJPMWtiSkVUTGo3bTZzc0JpSFZo?=
 =?utf-8?B?U1RkL2FtY0c0cVNUaWUwV3g2SlJWdmJOeU13ZFhBVEozWmF0R0JYZC8yWEJT?=
 =?utf-8?B?Z2ZQemV2ejRpenNVMzAvWWpZZjJOc0ZibkxwSjJXeTk5dms3ckIxSlNGWnRX?=
 =?utf-8?Q?7vDjA3agIogfZ7ccHQhVKx6aR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f6c37-6ebb-4541-d2c8-08daa817f208
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 03:56:42.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvS85lNvijExptjRC2TYTUO+VvaNHiGNSOeXMgfBH8FWTTKgZK1NKsjongpH5aXX+bnhHi9Z1YNC370ZVodx3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc: PeterZ

>>>>> +Ravi who may be able to say if there are any issues with the precise
>>>>> sampling on AMD.
>>>>
>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
>>>> since it has no task context.  Ravi is working on it..
>>>
>>> Right.
>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
>>
>> Cool, thanks for working on this Ravi.
>>
>> I'm not sure yet whether I may replace the kernel on my corporate
>> provided workstation, so I'm not sure yet I can help test that patch.
>>
>> Can you confirm that
>> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
>>
>> works with just that patch applied? Or is there more work required?
>> What is the status of that patch?
>>
>> For context, we had difficulty upstreaming support for instrumentation
>> based profile guided optimizations in the Linux kernel.
>> https://lore.kernel.org/lkml/CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com/
>> We'd like to be able to use either instrumentation or sampling to
>> optimize our builds.  The major barrier to sample based approaches are
>> architecture / micro architecture issues with sample based profile
>> data collection, and bitrot of data processing utilities.
>> https://github.com/google/autofdo/issues/144
> 
> On existing AMD Zen2, Zen3 the following cmdline:
> $ perf record -e cycles:pp --freq=128 --call-graph lbr -- <command to profile>
> 
> does not work. I see two reasons:
> 
> 1. cycles:pp is likely converted into IBS op in cycle mode.
>     Current kernels do not support IBS in per-thread mode.
>     This is purely a kernel limitation

Right, it's purely a kernel limitation. And below simple patch on top
of event-context rewrite patch[1] should be sufficient to make cycles:pp
working in per-process mode on AMD Zen.

---
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c251bc44c088..de01b5d27e40 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch = {
 
 static struct perf_ibs perf_ibs_op = {
 	.pmu = {
-		.task_ctx_nr	= perf_invalid_context,
+		.task_ctx_nr	= perf_hw_context,
 
 		.event_init	= perf_ibs_init,
 		.add		= perf_ibs_add,
---

[1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com
