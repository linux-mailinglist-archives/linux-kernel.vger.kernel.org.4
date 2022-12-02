Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD576409D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiLBQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiLBQAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:00:09 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7274E51E0;
        Fri,  2 Dec 2022 07:59:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnuBHZmsggGbl5hD9jtkvgsAWkZgNZ7KXQ8jaBHY0zQmcAJq8gwS7CRbwAdatph8SG1mkZlJu1i8hc/Og0POIAC3a+5mvjZ6lQT1snsuxPGlB6dstXITwSAhVXCsJgK0AGd2wwURHLZVAxHrauhAOOhnKNAv2LFGQgEoadmaLlhvTHoZlqsgTqzbiIAvA03QV4d+u0efdVjF5uthTri6BExoSynCBfogK6OjNPaOFD/FWWLC/XParOq8yvJ+bMNnoqopNBH9r9Nw5kP2gQY+rTRt9ACowmIrw6nYO3AutO64os2uLk6Zg7P7sTbYDQcsb8FfAdeOL3WDqdlU8N2CMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIOxTUiu8VhIB6JYwukomFao/vnPf45jTunnUtEuDME=;
 b=lSidVXYswzHeOhMQEaErQk76w9IvdnKupgQDhnlGoQPQgkUad6pZhk4bszUfpZwqjmtCcKtE/hysJvh9gindkaGkX4mvmhI8UTGzSBBmtyvT/Rrpma03cjymnAKQTln8WPXgyUlGOB8/zZmFR+NNaGCaWyG2r41JR4gCccxlfYetqYTX4sHEDra2K4Sk2kGjcJCumHq2Iv/FoY+FPR6akmjVgDnQGuEBcYyLy064SeG+yzW/y9lwMUiLntPdplkBhivNAURuFwSmsWJwoZnLc7ASnj2a4kXgXRRB+RSoZOM/7GOUPABEdxCLj/1pelpKqQj1k55eQ7vEIiDm1gEcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIOxTUiu8VhIB6JYwukomFao/vnPf45jTunnUtEuDME=;
 b=Icxqts9FJcqBQ2JhBNV3v105y4Y2OxDDn0mU6/UvQJoCm34r6hg8SFB2TYvTP6UzVgk9SBfcyZcioB/l46SpAHUtBzTNmkk1zdVXueV6CYiZDD+uiofI83OmSvhnSz0cuxXoQ2GDZntsdeHQQLh9apMlXGY8idNYfLpyVFsUl8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 15:59:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 15:59:38 +0000
Message-ID: <46c446a1-5c47-1e80-a3d0-4c9849ac6c93@amd.com>
Date:   Fri, 2 Dec 2022 09:59:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 07/11] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-8-perry.yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221202074719.623673-8-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: f61e8925-3822-479e-a820-08dad47e36df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUd8Ym5wxwI4Twu6P7edBb3FLOKT7aJgorIngBCzKXT0FqDL70RK6jw0tVW9njWjwneXoom9ULDwj2uUsZzZjMMbnue24NuPtPSyKbV+jtHvhB0UmSa12YxVSWcNX0ukPEJ+ZsJ2zrFuYz9rwk0xGh+yNpEh5WunG6kK+Uq+6G6yjR5n3nt9aB0RdyQ3mIU6dJUdsRcVRQvG+hPoYhUSo4z5pWzaHDaIfd8neBOs6bAcuVW/5eFGcEm8+S2M27UWRJrcTs+LJQaDB3XSKVSSpgrYQXN92rDz3C70FBExs/zQP5gR2K8E5f7WsEl59lhjOYwsGpMTN/BAutptqEJ62FP2QYOG4QYw5P12WyVviLATyzHxQubq3veCEsQQruWwD9JBWySFl2+50IHT1EdoSWy2Hpu8O1JmJ1hJJkxwLtBYzWZScWVjtMctKyAKgGdOUL3KA8c8tcoyOTXb9YDD+ssPBios1sHeu04Ii8Eg4oriIvF9TyOuArzagUKMlK7CE1PsixfWWGX1UL1ZZ3EiDcpA5cM3DHb1ZvEfD5L2c9QVJIOqjaIe7XmRpVIk7BFN30kF4CCqegvW4XVZ+cF7gMgrT/teU60gwjVF0AOeX/yTxFn0HRRsM93jqdRazYEShEoxAk3Qgk1IDyT05PGC8Eb0MwdApCGXMAVps9VAnZZ9Op70ZZDZnHXjHI59RgENHILbMJ5TISM/kZxJ9O85hwBOHDTlzY+RxFljy1cOFPbxmDlW2yu1YN6Lml9gyFZDBXB6yu3vKa+wtC2xF50Uvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(83380400001)(86362001)(38100700002)(4326008)(2906002)(66556008)(41300700001)(31696002)(5660300002)(6486002)(186003)(6506007)(6512007)(8676002)(6666004)(53546011)(8936002)(26005)(66946007)(478600001)(31686004)(2616005)(316002)(36756003)(66476007)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZPdmppZDM2Mng1UTZ0SUR2dnJ5RCtkMlMxamZLdlJGZ1RlcDFtSngray9L?=
 =?utf-8?B?emFqdGlwZnM4TGxzTHRnc2c2RitSQysyNnc3TmRaYjZQYzh6YXVXUVA2Z29J?=
 =?utf-8?B?aEY1VC95V1JDS3ZaREdNVE82ZkJkRldrVk1EYUJ5emZmbldhbDZBR3lVNDdR?=
 =?utf-8?B?QW9sSWRxd2xYVDFBblNwWThlSzhHNVdvK1ZTWncwc2wvNEc2TWJCWDFyWTBp?=
 =?utf-8?B?TlNPWkFaQW5iZDZ6aWJYWHBpa1NpZW1KOFF2cmIwd1QwK0pFdTJZVDdQOUVT?=
 =?utf-8?B?RVNzamViMUxPUVlDbmxlMzgzaHdTQndRSTJpSEw4ZlR3dk5vQUcxMFpiVDhQ?=
 =?utf-8?B?TWwxK3lySytQUUh5UXNNY1FiTG14Q3NPUkpzYklHZGl4VEorc1RCQ0RlZW5X?=
 =?utf-8?B?YURGU0swMCtpZ2RZenBLUkMzcytiQldMUzJCbUlUY2dBRG1SODMwWXN1MStP?=
 =?utf-8?B?NmUzSEZiSFJBQXl2NHdSSFRvWkU0Y0F6SjdVb01Cc2FxQTh2OXVOUE4wRFhN?=
 =?utf-8?B?WFByWkNzenVvVXRrWWN4aFp4ekx0OUFTbkxpSnpWOU5PbXBqem9LbHlUOGEv?=
 =?utf-8?B?akwzcHh5clllL3o0anphWFRESzErYkR2SDM4ZTR6Z0FIQS8vYjBXYk8zZWdR?=
 =?utf-8?B?Qk80ekNOOVJZZStHdmIzbk9Qa2VMMldVdUx4ZTlUTGlzVjEvam5OMDc3TCty?=
 =?utf-8?B?KytjVFJYd3RBR2RMbEJ6OWREWWdqVTMyY2JxbHZSdEJVaEhVOFZGcllWNjVi?=
 =?utf-8?B?TEFhUnluTFpDb2sreEhxQytIM1JWZmhzYk9DWEdpa1A0aTZlclB0TFNnc0VK?=
 =?utf-8?B?WVRBZWpmYTVJNTNsdjdGdFpzNFRPenppR2hvdHV5U285MDVsandBTjNVdjRO?=
 =?utf-8?B?bDhFNWNiT0N1Tk9FVndxTVB5Yk1VTWE3N2lFcU51dktmUlhIRDAwNHFTZkwz?=
 =?utf-8?B?UEtOQzdpTS9TYitRZ2ZiQThkM1NJa1JmZk9JcnYrOE9BcnQwU0lZZ2FUeVRo?=
 =?utf-8?B?cHVycXdSRXE5MGFnKzVzTU4zWVFoWlVFMm80TlVjaGRjRGNmdTJZVlJWUzNv?=
 =?utf-8?B?ckwzYmxHLzMwZHZOSlRrOEIvTjdZeDlCVExqZDZTZVpKR2tqR25JUnhaTk00?=
 =?utf-8?B?Mm5kNVQ2ejBLRFFVWFhnZGl5R2taRkgvNm4rRTR4NDc0dit3bFBxMWRpamFz?=
 =?utf-8?B?VEd2WVBnTXRPUkN6VHpGNEhScDhsRWw4ZWtpU2xySlZmc253WnROcnZWcy9N?=
 =?utf-8?B?RXBZdWVvRWRiK284QzcxMlhEc2lmUThyLzVMVDZSL3NCRmlGcURGbHRGeXNL?=
 =?utf-8?B?dllpK3ZNbHFiNEYvUWlFRTBNb1FGNDg3TEpwTytDb3Nid2E0VVRMK0dBRzhT?=
 =?utf-8?B?SWxZNmlvSVY3ZWk5WkxuYjZGU0oxV0taWU4vK3poZzVkRUZMYUlXSGZXM09s?=
 =?utf-8?B?K2wzV0RpVUxQd3Q5a29ZZmhYT05tWUFpVkRxV0kxTUUrL2NNSTBtMmNuWkRM?=
 =?utf-8?B?WjQzdG42NjRYVUhSSG52cndYOUdQVjI4bDdpZ09tbU9mdE9LNlJ2SmZXSDR2?=
 =?utf-8?B?UXNsMGdCZWdPQVpIY1hUbDFmZzg5MTNnc29DUFlFOWE5dTV6clRvK0U0OEdm?=
 =?utf-8?B?NW5GMWZjclhOTlV1RDVxeEFqeUtFRlJVZ0FwdnVkNnlhY01GTUoyWEQ3SjJW?=
 =?utf-8?B?M3V1OXVvYVN3Wk9aOXFPRUVSMi9UOWppcFNwQ25NR0VYV1ZzYjFlM2kvcGpv?=
 =?utf-8?B?K0IvTzcyMnhmdGJmdXBCZ08zZFNQQXI4bXhDTkhkYVFVRDUxYkU0bWdiV2h5?=
 =?utf-8?B?NWpGUmNTVHRXZTNPdUZiNFREU1FyZGV2bEpLYnBhRFUxSXJobDNsT0wzZzh5?=
 =?utf-8?B?dU1KQnRtMFB2aDJKUjE1aTd5d2hzb0xXdzk4LzBXd3Z1Z1NtNGRtK3pUb1F6?=
 =?utf-8?B?L3M5OVlUV3l4N1FBbGpMRUlxSGdCSWhPaWNWa0I5SmJsaUdpbHhKdDRnTzFG?=
 =?utf-8?B?K2RWSENSTjB1bVowTm51SENiWW92UlcwblVUaCs3RmRDZUZtblc0aHlzWFRq?=
 =?utf-8?B?S3pxQi9nek4zV1lDZVpVOVk3SXpvbVdTNGc1ZWhIK2MzY0pnVy8yT09RcW41?=
 =?utf-8?Q?vtmwOlcqI1irbCNga0pAKP27W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61e8925-3822-479e-a820-08dad47e36df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:59:37.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzeYg5DuOhlPIJKjMjcpH198lfF6fB8vvhN9r+Cw8Ky9PwPJyqFtI5qGsEZibzR50yNp2Rl7AX6Vrzt+wh3iFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2022 01:47, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Add one sysfs entry to control the CPU cores frequency boost state
> The attribute file can allow user to set max performance boosted or
> keeping at normal perf level.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b3a82cee2e83..6936df6e8642 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -774,12 +774,46 @@ static ssize_t show_energy_performance_preference(
>   	return  sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
>   }
>   
> +static void amd_pstate_update_policies(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		cpufreq_update_policy(cpu);
> +}
> +
> +static ssize_t show_boost(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", cppc_boost);
> +}
> +
> +static ssize_t store_boost(struct kobject *a,
> +				       struct kobj_attribute *b,
> +				       const char *buf, size_t count)
> +{
> +	bool new_state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	cppc_boost = !!new_state;
> +	amd_pstate_update_policies();
> +	mutex_unlock(&amd_pstate_driver_lock);
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
>   cpufreq_freq_attr_ro(amd_pstate_highest_perf);
>   cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
> +define_one_global_rw(boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -797,6 +831,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   	NULL,
>   };
>   
> +static struct attribute *pstate_global_attributes[] = {
> +	&boost.attr,

Make sure you update the documentation for the new sysfs attribute.

> +	NULL
> +};
> +
> +static const struct attribute_group amd_pstate_global_attr_group = {
> +	.attrs = pstate_global_attributes,
> +};
> +
>   static inline void update_boost_state(void)
>   {
>   	u64 misc_en;
> @@ -1415,9 +1458,28 @@ static int __init amd_pstate_init(void)
>   
>   	ret = cpufreq_register_driver(default_pstate_driver);
>   	if (ret)
> -		pr_err("failed to register amd pstate driver with return %d\n",
> -		       ret);
> +		pr_err("failed to register driver with return %d\n", ret);
> +
> +	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
> +	if (!amd_pstate_kobj) {
> +		ret = -EINVAL;
> +		pr_err("global sysfs registration failed.\n");
> +		goto kobject_free;
> +	}
> +
> +	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
> +	if (ret) {
> +		pr_err("sysfs attribute export failed with error %d.\n", ret);
> +		goto global_attr_free;
> +	}
> +
> +	return ret;
>   
> +global_attr_free:
> +	kobject_put(amd_pstate_kobj);
> +kobject_free:
> +	kfree(cpudata);
> +	cpufreq_unregister_driver(default_pstate_driver);
>   	return ret;
>   }
>   device_initcall(amd_pstate_init);

