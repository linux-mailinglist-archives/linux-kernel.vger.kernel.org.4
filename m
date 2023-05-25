Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F0710545
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbjEYFXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbjEYFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:22:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A02705;
        Wed, 24 May 2023 22:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9SlmhH99XvInGubPLwa4aad1KwxuIYOLUyYwcA2jRA+9viG2KSaA51ajHNQUSqTUY3+i4DGcW+9asNoOkTqdFhylSl8lLNNEF1K0b9eu7SFclMF9zpuY93fqmr/JcG0yaiODHh+4C7qcKyP9SUQicjhCYQbfkIC/ghk39v28tj17uQASjdeI3k1tuzuERA+L3X1/Bqi7cGQSzbTWyudb3fqzjwleYGlrkPW1TFsKImkF4Ph3BmA776BiYYYmTgNH8z3Na0WPbnSErY7MBEd8UryMfCtoyRfSXy/lXcyxbRCpuKzqkBoq80RSketza1f8tIjGIaEwoklZFn1rJpRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrsGBhuHJGA2dLXysUO3284BM2XpPVyX1srwM1xo++Y=;
 b=jZXPwAzZFHYIuwhxpcx97KDNniWHE9k+MAh9ByWA5ISmkDlW7urIrynk7BMmiGorYua3JOxVUGYiWojBJbD7fHBsfat2J8Nm5QnYCBRc7sa4RwPld61i/rJvsrwF+rAGtIHsuEqYLMsBFYO5qkvVvSdkwBYojtX1RlBEaxuaMqySGNQbt37kyXcqhQCTCdCzvbc794L6S1mfNiSf5XA2hIzZ+aZOv1illCGJVZaQQGfKi70gucP+bb9jo2Pcr7VrMmUqohjFHFr9CIPF5OGBB7LRMlw1FiUtBJYPqpvDeUA8RGRoQA7QmozDBUwL4hkP+2MzA/7GqYrl1tzqRSaRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrsGBhuHJGA2dLXysUO3284BM2XpPVyX1srwM1xo++Y=;
 b=Xuvk6GmQS8Q5b0kAgBZN5/r/axNVFJYvdoTNiYo/Ox9eNR+wJTQgFByb/iN3swt+DLtw7BKqFv9gcwwPGvA+eaq+WPN0kM4CutSC2sZZ+5Eg4X/MQqf4A/OKYDWJr6QQdq5G00fKELA5XlZMZzZNXSNcDmlQ3ckgHYhT8UzHsnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Thu, 25 May
 2023 05:17:21 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 05:17:21 +0000
Message-ID: <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
Date:   Thu, 25 May 2023 10:46:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
        acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, oliver.upton@linux.dev,
        kvmarm@lists.linux.dev, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230524214133.GA2359762@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: e00d1c7e-ac10-47f5-bd7c-08db5cdf510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLIQLIAZQP7es2gekCHemI9BeO+Z9jakybIva7dzkcjkXvbrYoVaUH/w9bEQmifxiR0HnQ4Eq8u4BHZ4dcYN6/8JgqNdmu6RxKEQIwiBaZQMbuZAtLwuO7Zdrbhqh+Op9oe2shXjPd2BV1ae6r+zeW6a++f3J/C6I6IfT12NF03uiFhzX64nhAQr8Y9k6xDTG/+Bqgg+zYC3SLGjhUpu8yWQA5iE9VxE5zwuCaqvHG8DnTwLuUcQClPPgVvJmMslLlBSuPMkdCBt31iRu8LGM05lq8yav6lCLE9yZp9Yxg6LCWxQdttz94Jp83ssprZCiWIz4GZmsS4G8nD6r8ggsjr4DRbgNF98prZCJYLhkIRWLgj66yB1JIN0CCaMhGkLbja1ysp3wrfYFtOhsDGvu369628EiI/x1LKc1fe9KwavI2PjiPHYZTOgcKTnpoJYlvHa8aF+QCXQUe5PSt7T/Ov2A0Y+HMgqP8gdC0mQ3OhiGJYQAfh6Bzg0aQfZ+3EX1JafbdHfK0oOqULWwka1+UIII9G1Umpu00yctktAWZJXizg0+vKVmvrNODYUdvDZeZsRGe9HdfNmxBtdXNSBrc0hH5I5fDpk/3oL4CEhyFu5vyI+l7849zlyLJbJ+P1QWEGZgJlShgOlEnd/WB48tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(84040400005)(451199021)(316002)(31686004)(38100700002)(66556008)(6916009)(66476007)(4326008)(66946007)(41300700001)(6666004)(478600001)(6486002)(86362001)(5660300002)(8676002)(8936002)(31696002)(186003)(7416002)(53546011)(6512007)(6506007)(26005)(2906002)(44832011)(83380400001)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXN1d2thRmNIWlRLYzRjMjB3YWZuU3ZDRHg2R2p2Wm1ELytyWTZLb0dsTlFD?=
 =?utf-8?B?clB5aGRvR0xJR0pOMVJZMUZnNTJIOUFvMFBKOWp5MFpSdXRLTzF4UkpGRmkv?=
 =?utf-8?B?SnVMekQyYXZpN1RURWkwVUxEV0VlNDlCcDE2M3hMK2hrSjFuN0hkOEk5L1Ew?=
 =?utf-8?B?TzgvVzJ3N2JtL2hsemJuYVM3NkVpcDBTSk9QZTNoVk5FeTlQbnptOE9US2x0?=
 =?utf-8?B?QmQ5bTFkcTFuSTljN2RkUW9qOUJJZ0RzVXd2VHhsV0MzQTV4NEs2SDJSaEho?=
 =?utf-8?B?dFNYZkFnWTJDUmJmYXR6UW5TZ1VTRnQ1KysrV21xNVJoOFBoNnhtaGs3bEZS?=
 =?utf-8?B?cG5UZWtvUGJUR2tSdDB3YWNjMmVtRFdPeWRRbG02Q1pCRUxYR3dKL1pQejJJ?=
 =?utf-8?B?Zk5NMzIwZnUzS0RjdS9adDJrZHQ0cmJFZ3FrVVA4OEZ0TzF3R1ZZSmMzS3R2?=
 =?utf-8?B?OU1lbFBLUm8wcENsMmhnTjI2SE4xUTlmdzUrT3pYdkRDMkJKUlpyRFErRU4r?=
 =?utf-8?B?ZmJxVlFUWUROVVNjdzQ4Z3YrUHorai9CTW1rWExKOWFBVlUrOGRXZ3dBMTJq?=
 =?utf-8?B?RDQ5NS84S3NoSkx5L0hJMC9pbFp4Y3hTWnd4R2xEUEhobDZaZGcrNVF6SWdr?=
 =?utf-8?B?YmZjcWNZbDNmc0QvNFIrSXhiV0lMZ3VoQWZQd3ZzSFdnYmw5RXBHWGxNUTRJ?=
 =?utf-8?B?QTkzNkpvRWRYdzc5eUZBb053ODJjTWVXR01RVDR4MzVhYjFKclJpSGdVL2Vh?=
 =?utf-8?B?Y2IweHpNTlZQeVg3YVBJTm9zZmxrc2MvVW5BQW11V2Z2bDgzcHZrS1VFMHlY?=
 =?utf-8?B?cDFsaEdrNWdBN1VNVnRSQUpJM1NEN1VFVnpvZlV1cFd4K2xUQ2NGS2R5aTlF?=
 =?utf-8?B?N29rbDRWdnJ4Y0QzWk9WNGZrRXJvN1dlN2N2aDA3dWx6akJhb25lMjc4NTNE?=
 =?utf-8?B?K3dsSkovZ1dna2VTVUxEdXRoNkwvby9JSGZjQ25LQmlhcTB4YzFQbGhEbEo2?=
 =?utf-8?B?Mkd4U21TbVU1TVUvUVlYdmM0K1Q0bDNFWlpVYVZ5ZnlQWm9YaFB1amxuUkMz?=
 =?utf-8?B?QnM2K2k1bmtXZFRrVlFuQlg0b25VTkk5WXFuWVN0bUdoemtGa2VYREFTVm5q?=
 =?utf-8?B?bHJJaWM0ZTZKaC80TjNWOVYzTk1VSGtqODV3M2s2WTZWOFNYT25oNU1EcE4r?=
 =?utf-8?B?MGVyYlZ3UVU1d0dUVWxmUEJGajlLTzM4VTdaOHBiclhyQ2ZscHg1UHBadDNn?=
 =?utf-8?B?ZEhNOVhYM3JuZmlPMkNUU1NuYVBKdTBPQ2phUFRnMnExK01oVytsVHN0T2Nz?=
 =?utf-8?B?V2FXaGVYMkpsZ3czUlB5YWlpcmtpZFdJQWFSekxCZFVtVU1CYklMVnpCSTdJ?=
 =?utf-8?B?blJpbU1QRlhCbVFIUHRWK2tLQk9vTXhlVFg3dnZyM2dDOWZyZWcyNm16SW5h?=
 =?utf-8?B?V0FFWjR5bFIvMjYxUjJMOGZIRWV5TTNqRnlZeXBDUXNSRmhxN2RJazlWekMw?=
 =?utf-8?B?MjU5WEhBcmxmWFhLRmk5RHh1NVBpK0FYZzdRL2hCejIycGlmbmV2MzZDN1k4?=
 =?utf-8?B?ZndTMWNiUTNhR0w3S0xZOU5NOUV4NW9KaGtOMEFER2RYZGd3NjU5KzVLKy95?=
 =?utf-8?B?S0Y1UjFGakwxU1R5OG1JcExZdkVJT3YxeVZQM29RR1dvQ2w3TUorNkR5cDBL?=
 =?utf-8?B?VmVRUzVMeUlaNTRldDNyc3JJdzVhR3hQNHNmM1hpUDR2d0FIMFdxV2JQZUR0?=
 =?utf-8?B?Y1k5Qy9udDlSVDdHNFRqc3RaVGhrV01zUkMzRUNBVkR4Q1V1aXRMVmM3N2hr?=
 =?utf-8?B?U0hnR2J1NzhncW4xL09hYVFMSDZ4YXhJWW44NFNWZlNMSE9GNTBKb0pUeXFy?=
 =?utf-8?B?WkpBUVJLRWU5TG5XUmcvWDhScXZTRHBWcmxvRmVkOWlxWWpiUHd1cHMxVktG?=
 =?utf-8?B?RzM1aUFuRGt3a2grQ1BnZEp1N1VTUHNNNkZITlJGY1BWbHpyU0MraHBtMHlN?=
 =?utf-8?B?amNDSUVqTzRkNTEzdmtaTTg5UmVXSDdXcUZlYkEzejc0R1QybStXZnRld1o2?=
 =?utf-8?B?Sm9UMDQrdnNBSTRUbE1hYmtCWHdST2VhbFprVndwSTd0d0dVczJUTVFUYUdx?=
 =?utf-8?Q?l91LcKrGSAFAgyJFeIxObilBb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d1c7e-ac10-47f5-bd7c-08db5cdf510a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:17:21.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+R5Zw9rZqQ1TTt8kh5v1cYp110+zGR71xh5BEhIuztJU6DrTTm00KUJzjRnuFqz6Bx5J2WMx7BJRDp7ky+1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 25-May-23 3:11 AM, Nathan Chancellor wrote:
> Hi Ravi,
> 
> + arm64 KVM folks
> 
> On Thu, May 04, 2023 at 04:30:02PM +0530, Ravi Bangoria wrote:
>> Searching for the right pmu by iterating over all pmus is no longer
>> required since all pmus now *must* be present in the 'pmu_idr' list.
>> So, remove linear searching code.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  kernel/events/core.c | 37 +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 0695bb9fbbb6..eba2b8595115 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11630,38 +11630,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
>>  	}
>>  
>>  again:
>> +	ret = -ENOENT;
>>  	rcu_read_lock();
>>  	pmu = idr_find(&pmu_idr, type);
>>  	rcu_read_unlock();
>> -	if (pmu) {
>> -		if (event->attr.type != type && type != PERF_TYPE_RAW &&
>> -		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
>> -			goto fail;
>> -
>> -		ret = perf_try_init_event(pmu, event);
>> -		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>> -			type = event->attr.type;
>> -			goto again;
>> -		}
>> +	if (!pmu)
>> +		goto fail;
>>  
>> -		if (ret)
>> -			pmu = ERR_PTR(ret);
>> +	if (event->attr.type != type && type != PERF_TYPE_RAW &&
>> +	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
>> +		goto fail;
>>  
>> -		goto unlock;
>> +	ret = perf_try_init_event(pmu, event);
>> +	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
>> +		type = event->attr.type;
>> +		goto again;
>>  	}
>>  
>> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>> -		ret = perf_try_init_event(pmu, event);
>> -		if (!ret)
>> -			goto unlock;
>> -
>> -		if (ret != -ENOENT) {
>> -			pmu = ERR_PTR(ret);
>> -			goto unlock;
>> -		}
>> -	}
>>  fail:
>> -	pmu = ERR_PTR(-ENOENT);
>> +	if (ret)
>> +		pmu = ERR_PTR(ret);
>> +
>>  unlock:
>>  	srcu_read_unlock(&pmus_srcu, idx);
>>  
>> -- 
>> 2.40.0
>>
> 
> My apologies if this has already been reported or fixed already, I did a
> search of lore.kernel.org and did not find anything. This patch as
> commit 9551fbb64d09 ("perf/core: Remove pmu linear searching code") in
> -next breaks starting QEMU with KVM enabled on two of my arm64 machines:
> 
> $ qemu-system-aarch64 \
>     -display none \
>     -nodefaults \
>     -machine virt,gic-version=max \
>     -append 'console=ttyAMA0 earlycon' \
>     -kernel arch/arm64/boot/Image.gz \
>     -initrd rootfs.cpio \
>     -cpu host \
>     -enable-kvm \
>     -m 512m \
>     -smp 8 \
>     -serial mon:stdio
> qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: No such device
> qemu-system-aarch64: failed to set irq for PMU
> 
> In the kernel log, I see
> 
> [   42.944952] kvm: pmu event creation failed -2
> 
> I am not sure if this issue is unexpected as a result of this change or
> if there is something that needs to change on the arm64 KVM side (it
> appears the kernel message comes from arch/arm64/kvm/pmu-emul.c).

Thanks for reporting it.

Based on these detail, I feel the pmu registration failed in the host,
most probably because pmu driver did not pass pmu name while calling
perf_pmu_register(). Consequently kvm also failed while trying to use
it for guest. Can you please check host kernel logs.

I'm sorry but I neither have Arm board to try myself not I'm familiar
with the Arm architecture. So I'll need your help to diagnose it.

Ravi
