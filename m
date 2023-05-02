Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9A6F3C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEBDJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjEBDJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:09:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA330FB;
        Mon,  1 May 2023 20:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJT2prOtp8vS/jeqVYkR0ejjGTYaegTY6eOU5Py6LmNyE8cL+prXhlXuWiV1iG8mkDdSgXnIp123OK7U5wEx/eM3nTgx4QC7Zys0QG7AU/UPQKpIi39k8lx4/1SCBAjT+L4TyQWxjRnsQ+FyM7z08l2kO6n0aQZg7zwhN27CBAnWcHn2BVE900HO4Ej24SZDl5C14ibyro58EQVvEn3GhpHIk8vzMNN4FFkIQr7gowbx3v3uN+drnbGKBilzhCv3gvS8MUIbxLujh0dXBWkKNcdbfYSSEFSw5BhzATOvHfXnJMe8nKO/NT02LX1uSMKl8G0Y7ms+7Le2sZtQXUAh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLax830yorPv8kIg/mLVby48g/vv71I7vxHSSXTIVEI=;
 b=IYKu/bcxcFgSx2Tzo/QDTQ2dM82eFUYZDsGd/SDaEs7A2GQTn42H/wmmjok+7XCGlLY2U67nBWzzUgVz09zvdv/ZWYmJ8OU5WUuAj2TkB73m3/6Kt5D+pWwLt2tAxFgU1C3gGM9Hi0yKdpev7/2xVNouIKQTcVQRrqKgoYuhpCJRZAlhtxF5w7gItuQlUMVGAE5TE6M5dFn1pVxVh790yhmoHg57syhRHhPpzV6HT7iQ0QnF+Se/dmdWE36TqlLeKjA4RS+e3NIqd2lAsoI528ddlNnKUqbPSDxYDQ8A7L14BErx9LLt3HB4aMHxG309gd6Qnoma1ohhv1vjCCLlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLax830yorPv8kIg/mLVby48g/vv71I7vxHSSXTIVEI=;
 b=PSy0Ckrq+T5x5ngM7HNbfDJB6vi2WjdU/+pfUS1LECcKn53PqK/GMV5Y1KKql8ZciiexNCghvckuvrmBnZuiV2wUcH01a1gvCsC6MGtqbW0djoPIuoHgoMlrV9NGIfCTb07qQ0TO88hB29/KXWdKD54BeSqZ0rKscPrKIRgd24k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 03:09:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 03:09:41 +0000
Message-ID: <90a2a0dd-62e1-93a2-6d8a-50c68823078b@amd.com>
Date:   Tue, 2 May 2023 08:38:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/3] perf test: Add selftest to test IBS invocation via
 core pmu events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
        acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
 <20230425142205.762-4-ravi.bangoria@amd.com>
 <CAP-5=fVnfNEKK_UPuRprSVuCgQG-X-hCM6Jq3AKRHYfBiqisKw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fVnfNEKK_UPuRprSVuCgQG-X-hCM6Jq3AKRHYfBiqisKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebf07e8-1790-4d51-e5a5-08db4abaabec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CldT8x2shCcenrOno0bvMrIZIQv4a3dMG87czp1PIG/S//EjcW05b0rNJfFxY8p1XJQKLZ24Db9tK6HBPcISTUT9Oe0p8StkX1OrLqJXr+/thVdeJuefn4bugGHjuxjrhycLYxYORo+twIPs4CK//0WlOcIJDcgnU4KgTZQ5KkVpEM/GRtZhjRU1BSQDzS8FjilOvP8DudFiL77hIzusQC9X+9TBqeSUsX3f0T9iR+9H3RMvFXy8mwn+/aUvG2tcu8a9H9e5LuFGYn1jgj1Txu+VAYrn2LoLzGWKPwiquZ3o1ntqGFWY6Hi+3wbblIBLcgI8TZBXDTnQEi3yus+loToPt8U8HfGoq8tQrsio6VF9aOMic3tf1gr+VCOVLLAI0pV00uool8XDKYgHef99kgPzVAuXphNEPoesa1InVOpToFryVo7Nzjdl55iX46oF9v2jZ7jObTErJ8PU4DpWOl0jns2e8QZyBzLt2FbG6CwXnsUMlrI8U1XmCNpVu1+T6IbQhzynzLqSQ6B847NTCRBnVK9TkqzAqMHthecNHjqr0r9Mp9P5KurSGekyhaV1z84/5mfCPLCU5YikWevJZQqYQ6vJz9dJPgv7W7Jjg1Zhil84qsKXQU2MvBEPx8Z8lYEc/XaPVI3wJgl00HEz6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(83380400001)(6486002)(4326008)(6916009)(478600001)(2616005)(186003)(6666004)(53546011)(6506007)(26005)(6512007)(2906002)(5660300002)(38100700002)(36756003)(316002)(66946007)(41300700001)(66476007)(8676002)(66556008)(8936002)(44832011)(86362001)(7416002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpPcDJ2Y2JiK3VSU2tSbGp1Z2Z5b2tabEJPR3ZpRks1Ly81RHpFSmU3ZEIr?=
 =?utf-8?B?Ui81STBKL3crRU9kN1g3V0dvMHN5WFZjSTdkbWlNVXpYcFgydExGVEF1SWVQ?=
 =?utf-8?B?YlgrQklQUTRvUlRueXdRYXVtLzNVcHRxbFpvNXBXMkhleHFmSkxxMXBvUEhJ?=
 =?utf-8?B?QVlqZHZVTlUxVWg1RjRZMFM0d0RoQVd5YTE1WnpnZjRNdzd6U21rdDVNR1hB?=
 =?utf-8?B?SHdVVW9LWHhGdkF0ZmUzUjNnNU9ZN0xFTllYR0N3bUZPSWM0YWlTMzdHc0JZ?=
 =?utf-8?B?MmlSQ1JvVlI4V2FXaTU2ZTlYemcxcXJSMFVPNEpEY0VKVHo5d3Z1YjdqTFhM?=
 =?utf-8?B?bklMS2VBSzFDNVNQZGQ1cWxhSGZZbnQwb0FBNVlEaExMQm5Nd1lNL3R4Tk5P?=
 =?utf-8?B?Wkp2NjJhai81L1JkdzBJSGFHVEdkU3RFbmltV1VMc0V5RUVkZ3J0SVJwZmZq?=
 =?utf-8?B?T3dJa2JWU1k4eVpWVFRZdCtPQzh6bFdYdGlKNjd6M1YydjRUbE5zQmMxekZW?=
 =?utf-8?B?Z25XOGxyZXpqRldyRGRNZU5EaGpTL3dpYno3UHhBOUZRcUVTRlRmKzVKK2Z3?=
 =?utf-8?B?aDI0UFpDaHdid3Z4RkkxWXhlYlVkL2RKemluWUtqSWxVSkw1czJPZGxzdTJn?=
 =?utf-8?B?TmtERmRXR0VndFdjNHFMamo0TzRoa3NrTWJqYm5ZOEhuWE8wZCtIaFdkSWxP?=
 =?utf-8?B?blRjMXdTaFNSWkRWMGgvQmtqeHVtMUdabUExS2VJc2U4aHRKNE9tMnhod2tE?=
 =?utf-8?B?a3VLTnpTTEJ1N0Rmdmt0QkkxeUI2VDk1bXhLTWR0eENyNmUrdFFndm8xVGdI?=
 =?utf-8?B?ZTRZTk5HUlhUejFmVTJNajhDMVFzZWg2WGRZSS8vNHY0M2svMHhmN1FWRENy?=
 =?utf-8?B?NERTT2N2TEpEQlJRT2lIcTF0dyszYUJVRzl4ME9EZWNmY2NTaFQ2NGF1T0FN?=
 =?utf-8?B?SC9qTWtISVk4bHdMWndlMzZHZEtLakRCMWNETFczWlpBMnM4YktBeEI0RXVX?=
 =?utf-8?B?clNRL1BqUDQyMHUzdWlpakFkcGhoYldoZThKVW9lRTBtVjd3cDZHVDZUYUt3?=
 =?utf-8?B?bXRwbDNxbjlZVHpseVJUYlQ1RWFoR2s1YzEyUW9oL29ycW0rckhBTmRIMTVo?=
 =?utf-8?B?UlROWnZZSjBWaHR4S3lhdVVVQzdPMGkvZ0ZkVDFoSXZobzQyRGFWN1JLTm43?=
 =?utf-8?B?NUk4eEtDVzVjUXZ1OHE5NHJ0VXIrL2hIbWdVakNYVXRvNU9LcmNuREdGcFlp?=
 =?utf-8?B?SnFWdjkvQ1BxSHZDOE8wbDZ6L1NHUVdubmJnSzVmcW1TbmpjQzhwZFgzSXJS?=
 =?utf-8?B?NWtXTXl5dk9vWHE3aFB5WEd5djNXeHFQZ0hLUlJBdFlJSEFITjBJWlljUFBK?=
 =?utf-8?B?dyt3NklJQ1pqREp3MUFvZDZxVTZhVklwUDZ1REs0aThMQ0h0VmFBYXY4Z1Nq?=
 =?utf-8?B?NjNrZWRET2Q4M0tkVjg3ZlBVVTltQmxYU01xTUFuNVoxNU4zcDF0NkRPRXdT?=
 =?utf-8?B?UUxBTFZueXIzV3FyQWtPcVhENUJNeVNNVTdHaVpQeVZHanVnbVJJZTN4Y3pn?=
 =?utf-8?B?SmVUdUlnZnE5TmZWdjlnSkZKSXF0bFc4Y3lwczBTby92TFJpTC9IWCtKd3Yv?=
 =?utf-8?B?aHpiT2d2blVTTlM1cktKQjlpb2xZanB4VVNpelNDQTVUOEhRYWt3U3VCRnhx?=
 =?utf-8?B?WXdna2N2TEtkOXU1bHJRalhIdXZCUXVrbFFNQmE4Rjc0Um5ubzAvOVdndEdt?=
 =?utf-8?B?b1ZDbDRWR1pEUHJUditIdlNYeWd4ZUxoQWpCR0hYa1BEM0c0cDBnb2tyaHJG?=
 =?utf-8?B?UG1WelE1WGE2NFRPQlA3bzJQNkFCT3h3NGQwUWRiaW5EZVVTOUF5b1dwUTU0?=
 =?utf-8?B?c2hVVmwzRVhDVXNyRDRZRTJrMWs0bDlvaGtyVVMxVWtIRVp4Q0MzWmpJKytW?=
 =?utf-8?B?QjZvVmFobVZ5NFRPTjVDTjBwcUF1VDNvSzFBeFBXSUxaSDZjck11V0g1MVZW?=
 =?utf-8?B?YXFTdDB1RzhkRVUvaGNYWHZGaFJEdW1LZkdTWWlpV0V0VVg0SUNxV0RFZTA2?=
 =?utf-8?B?RWFpdGlYVXEwMERLZzJRTzI4UXJnQjNobE9tVTBDek8reE4wQjRwbDg0eVI4?=
 =?utf-8?Q?QqkfDj6p4f5tyhMmPT5EcampK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebf07e8-1790-4d51-e5a5-08db4abaabec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 03:09:41.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvjcqXFgJGjqm27qVQMS4KqJpLQSmbRkqpo8LbiLcnrp2kU1L+9XwF97WlhWxiNXWj9LwDwYU3b1AHmNgIGeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Apr-23 2:39 AM, Ian Rogers wrote:
> On Tue, Apr 25, 2023 at 7:23 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
>> set to 1. Add a simple event open test for all these events.
>>
>> Without kernel fix:
>>   $ sudo ./perf test -vv 76
>>    76: AMD IBS via core pmu                                      :
>>   --- start ---
>>   test child forked, pid 6553
>>   Using CPUID AuthenticAMD-25-1-1
>>   type: 0x0, config: 0x0, fd: 3  -  Pass
>>   type: 0x0, config: 0x1, fd: -1  -  Pass
>>   type: 0x4, config: 0x76, fd: -1  -  Fail
>>   type: 0x4, config: 0xc1, fd: -1  -  Fail
>>   type: 0x4, config: 0x12, fd: -1  -  Pass
>>   test child finished with -1
>>   ---- end ----
>>   AMD IBS via core pmu: FAILED!
>>
>> With kernel fix:
>>   $ sudo ./perf test -vv 76
>>    76: AMD IBS via core pmu                                      :
>>   --- start ---
>>   test child forked, pid 7526
>>   Using CPUID AuthenticAMD-25-1-1
>>   type: 0x0, config: 0x0, fd: 3  -  Pass
>>   type: 0x0, config: 0x1, fd: -1  -  Pass
>>   type: 0x4, config: 0x76, fd: 3  -  Pass
>>   type: 0x4, config: 0xc1, fd: 3  -  Pass
>>   type: 0x4, config: 0x12, fd: -1  -  Pass
>>   test child finished with 0
>>   ---- end ----
>>   AMD IBS via core pmu: Ok
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Thanks Ravi, as the test is AMD specific I think it makes sense to place it in:
> tools/perf/arch/x86/tests
> and then to update the test list in:
> tools/perf/arch/x86/tests/arch-tests.c

Sure, will respin.

Thanks,
Ravi
