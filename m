Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A73717FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjEaMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjEaMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:15:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C575126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS/Y0ma5V5UD0RN5e9XkZDrb0lsUQx4KssNXrJaOf4HlUpCA40RrnG7Mpxw8socJG4485KrW+GvXu/G3JSmNinQobkdD1Bu7NR4kHaIAIOQ3j2Nv9pGqswlAdnHUcRRnvDHogBEL6gBlM0R036x5BTJOuyCLhaQWoqrja8oFkOrJGdf8yYqdcivvh9wZP3dolFo3gdeTEWjVXn0gc1ULSQPjCN4zY6OOgLJpiCB3chL/3MT49u4nH8yC6km1xL3ypupcitM4ft6csMsimkqxy09HAHd73nk/b/qoHBYgPKapxmjD4LFKB3bCG9Jc/ctdS4DlsO0MeG7X1VbMAVvGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdcWK2gIGHowRPbENfq9a+b5NF02SrL9rse0Y+6sid8=;
 b=V1pIEjzpMbrgKS/vAFnmg6DIP4ZxhQUPASMoVfPFbd6rE9/1qqJ1vwge4jE9jbicd07Qx6R9HxzQO/0pL30nHVadnpSM6pNX+uTO1E4exY0W0dlukiHnV10y8odKWW5SWZd3GzIdoA1TGkgeJoli7/THtUr4iiOzmLVShVUKhTh1LIVupSG0DLd+LULpE6ZM7DpS0OBRGwO4gmy2NIqvuWWO9m1p4YOry1v44TbNRAsHm/EcgVb9Cu7MuXLF72aFiu7BAFMQO/2hzo7MOGkjLtpdlZtamohmkVr/Vzydj6TpBKtFgHKI4OEEXPekXwjkLcHJ9Mv50/88W5jbZIAtpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdcWK2gIGHowRPbENfq9a+b5NF02SrL9rse0Y+6sid8=;
 b=QhwFRBflhsl+zaLdRqaEqqAQkHHf+N3CruZjioV/SJ/kfSNi7cau/gCg/ncPzIfsGNN2gPcTXbexWu+HW3xd5xB7aKBP7EU6JBMHr7Y17EFQNM4Cso1NyzPk6wseKyNf21A1PC0GarRUSgFpwaiigd9pGufkj2AW++DKH2hJepM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 12:15:10 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 12:15:10 +0000
Message-ID: <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
Date:   Wed, 31 May 2023 17:44:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Content-Language: en-US
To:     Sandeep Dhavale <dhavale@google.com>, Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, kernel-team@android.com
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0227.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 50951797-d7e7-43eb-089c-08db61d0ad47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wp/IE4YkCvsQvsPUybqq+TGknbl0L/rYluyoH3XZXig+iVSLWHReL2+Wy+9tZmEl9fABF1/vBLKXoxlq/n8b2tHZB0dQkEjeODfpmbUo3/0DtRWIpGfneUmsYVsNU1TJ6sIO04RlUnRqrbEa8a0SMkd4hDXfBaJhVb9iow5J3hTH/Xw1ZOHg6b4DQ8AO40Eu8va5Ufi6qWwP9wFtKOgO2/RCZoFzF7YqIPHeHtvRVamBkaru+vJAUSMb1jYpiEUkVAlrISHz4xa0ttFn4NHEwbGwMLR5Qi4ckGGsOlwmYTZcglH5LD+CBX2gZXSGsriIebqkccim7xRlL+B5UbVcbi6DTxofCar5U2kyWiEVtij7BqjxP8pt8Xtk8Vd1Hdt8zWHoJG+6HwGI9SnpnBrsQqMDC7CfKCy5mPDIuHZ9IiXJH1Cemh9WGj66+Sf/nITIXEEf1hhUaUKINsMUNrVIFTb3b9B31Cvaap7nTQjVR/FhuaL9kATwHc21p1LdoMIdfR7W82OThbWXPCW/EwKPq2CWcbyUHhezD+TobPpYjjAAqSbWDWPczbWDx719HcztMC4CQk6oV0rNc7P+pXNlGP/mtWR8wb5nnGBbp/4lPTYtyEVcnKlwbKXm7fW1SdoIE5o6Myog9Ehz2U6l7h5nrlIL4f82UOg1UQmdA2Lstg/NKMZ3mJmr9XFxLN324SEE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(66556008)(66946007)(66476007)(4326008)(316002)(38100700002)(186003)(2616005)(31696002)(966005)(6512007)(6506007)(86362001)(53546011)(83380400001)(26005)(478600001)(36756003)(110136005)(45080400002)(6666004)(6486002)(31686004)(7416002)(30864003)(2906002)(8936002)(8676002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5OSmxaTEp6dFMxNGZnWHEwb0VxRXVnV0NBaXZDN0NyN0QzT29QTkk2akxC?=
 =?utf-8?B?RzNhaUZZb0M4R2hjUmtRS3c3Q241Y3YrNUpMR0twSnhZYmdLYklrcDNjNk9O?=
 =?utf-8?B?UkYwUHBJckxwRWU5YzNQamhFSUlDc1lzQ2dRTm9BZjErdnlGRmpRa0RpdnYr?=
 =?utf-8?B?UmVnRWk2SkhFV29ZN2o5TXhSeWxFYXFSRGNrWjhSWlZrYUwzVmJGT3prVXhn?=
 =?utf-8?B?STE4MGR4bUNNZTErSW1hT1l3eFZwOWRzYzh1Y0NoSG9QcWhiSGFOQ0xNL1ov?=
 =?utf-8?B?OFB3QmtJaVB3VTk5ZVU2MCtTZHFnUHZ5c0ZhU1ZteFNuYURNKzBxOFNuUUhu?=
 =?utf-8?B?NTN1QW8zQXFWWEhzRFpRaXV0Y3lFc0V2QnFHVkVsWnZWQzZDbHh5eWExdE9U?=
 =?utf-8?B?MnlIVXZOQUJBZ2MzVGtGL1VBSnZ4WlNQZENnelRhZGFjbFZGSDdDcTVJTGRF?=
 =?utf-8?B?T01Mb1EwSlRUUzdFVVZ5Y2JocFMvK3J2QWxMVlFKTXFXTlE0Myt4MzM0TjJY?=
 =?utf-8?B?WE5NWmQ1dHorM1YySk5wRk5KdUpTU0x0aGVBWE0ySDNkV2NjNUJZQ3prT3Js?=
 =?utf-8?B?clhLbnc1cVlpWWJyQkcyVE5WY1hkSk94TzRud0tlVkpIZ3E5SUVZOFBBYVFE?=
 =?utf-8?B?OXJTdkV4R3dnbXdwUDIwTnRNM0gxNENXQzZVMzJhOWFHbXROaVFwU0ZscHhD?=
 =?utf-8?B?MlJaanhCVUpFbXNlUVh5emxsRThIR3MrT2tzYUNkNzkwL3lBbXJVV3d6cCtL?=
 =?utf-8?B?V3NBWDh4UGZrRWdCbGUvQkVCWnZheEhNdXFuVFJsTVU2aDUxL0UySXl3ck5P?=
 =?utf-8?B?bEJKR1ZCdXl5R3gzcy94NVkyRUNKTnRKa3RJd2FxM2ZuOU1jSVV1VnpXaXZa?=
 =?utf-8?B?YXgyREZCSjNONC95TTUxaU40REpSayt5eWtCM2hVc3M0cVRZa3Rhb3ZnREcx?=
 =?utf-8?B?Ly84Z0NDZFJDb1o1Z3o3VjJFMTJ2RWxxYkQxejRKVHJRZWtMSEFRQVR4MnBY?=
 =?utf-8?B?M3lNQ2d6ejV6RGRWSlFuaFF6QTY4ZFBrVVZrYzhjODMyejc0czRWM3FTNE1E?=
 =?utf-8?B?UHc0VXJVTDJQOVhXV0tqaWxudUt3bVNuS2lRNThkdFRwV0M0M2gybjBxdmJ6?=
 =?utf-8?B?eU5QeWtnTzNoTThIeW5MMlhWNTNsQzVWeUNqemhsUUYwSEhwTTRoWE5zRndH?=
 =?utf-8?B?N25sLzFCQS9ybkFGektBYUQ5emxxc3BvNEVocDVXVmlFVnF3elNZVFZOT1Ir?=
 =?utf-8?B?dWFabkhkaWRQU3NwaWxhVjBYRGk2aWxlZ0poYTlkUjFiVFRqTVV6ZU5iRlJp?=
 =?utf-8?B?SXVhZER6SmI5THJHbGVOQnpJbWwwVlFHbFhqZDJ2bitncE83a0JqNXY5MGhT?=
 =?utf-8?B?ek1laUhGNHVqbzRvbGd3ekU0MFVEZUlLNzJYREFZU3NmMmlVNVYzL1FrZlJM?=
 =?utf-8?B?OU0vZFcxUzdtL0pYY3J5QjlpaGluS1lNMUxtMzZQSE5VMkt0aE5JNWlqckkz?=
 =?utf-8?B?TGpYVW42NUtQbzhzcWdYQ01WRC9UcjNZVzRSS1hJczFucHJHVVJKNTFveXB6?=
 =?utf-8?B?Wk5yQXdYZ2E2T3d5dllDUytrSWxnd0ZiZjJPbGxIS3BWQ0VnZ1NOOW4vWG5Y?=
 =?utf-8?B?dkJaY1JUNlptV3NTaGJDbDZaVTNRK0R1SnQ3NTI4MkVYVnBGb0RXdFp6MlRS?=
 =?utf-8?B?K3VXaEttODNCc1o0aTRMWmZEQWxCOWJwbzE0R3QvNjROOXhDcFZMeS9NeFUw?=
 =?utf-8?B?eHkzSTBwNFRyRk0vVGNOUkhTRzBYVEN0ZWpXWDBVaXRCTk03VnliWlU2UUx1?=
 =?utf-8?B?TjFsaXBMWHdQWGRHL0dIZDBDQUFsclAxd2hLdmg5bTZUcy83dUF3V2NrejE2?=
 =?utf-8?B?S2NtaXZnZGFZMDlRYThJd2d3MHk4Z2Jzb1U0K1JwRVd3b2NzWXgwREJ5cVhk?=
 =?utf-8?B?bzZiK2dEK0k0UHk4dnYzTkRZeHVzdUxhOXp6QmdLcW9NVlczVFREUjJPYWxX?=
 =?utf-8?B?dVhrQmFFNk92eFFLRTBkeklobXlYMDlmVm45UGlieXVpeUE2eVNjZU15TXFD?=
 =?utf-8?B?QUtWSHJYQnhTZnR0UEVvNU5zaVJJaHJrQUV1ZVpzbHh2Nm13Q1hGU0t5RS80?=
 =?utf-8?Q?yh9SeVe9yl+dWlMMAoRljZtv0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50951797-d7e7-43eb-089c-08db61d0ad47
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 12:15:10.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT+7BlQjoWqk69uyf5gIXupWwOY7H6j/+U3hTg9PX9ShnsU3889QCutX5hWjppdo/lmZr8pCpNDPurOVcqSYSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sandeep,

I too am seeing similar crash with the same call stack, albeit a
different error, a little while after the kernel boots. I'll inline
the details below.

On 5/31/2023 2:48 AM, Sandeep Dhavale wrote:
> Hi Tejun,
> 
>> @@ -6234,6 +6256,7 @@ static inline void wq_watchdog_init(void) { }
>>   */
>>  void __init workqueue_init_early(void)
>>  {
>> +       struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
>>         int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
>>         int i, cpu;
>>
>> @@ -6248,6 +6271,22 @@ void __init workqueue_init_early(void)
>>         wq_update_pod_attrs_buf = alloc_workqueue_attrs();
>>         BUG_ON(!wq_update_pod_attrs_buf);
>>
>> +       /* initialize WQ_AFFN_SYSTEM pods */
>> +       pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
>> +       pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);
>> +       pt->cpu_pod = kcalloc(nr_cpu_ids, sizeof(pt->cpu_pod[0]), GFP_KERNEL);
>> +       BUG_ON(!pt->pod_cpus || !pt->pod_node || !pt->cpu_pod);
>> +
>> +       BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[0], GFP_KERNEL, NUMA_NO_NODE));
>> +
>> +       wq_update_pod_attrs_buf = alloc_workqueue_attrs();
>> +       BUG_ON(!wq_update_pod_attrs_buf);
>> +
> 
> Looks like allocation for wq_update_pod_attrs_buf is already being
> done in the preceding code block.
> 
> I am trying to evaluate this series to see if it helps with the
> scheduling delays we have seen in EROFS.
> In addition to the panic and fix reported by Prateek [0], I am having
> stability issues only with the series applied.
> I am testing with Pixel 6 and android-mainline kernel [1]
> 
> The panic seems to be in the context of kworker for events_unbound wq.
> The only significant change directly to events_unbound wq was in patch [2]
> 
> @@ -6399,7 +6335,7 @@ void __init workqueue_init_early(void)
>   system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
>   system_long_wq = alloc_workqueue("events_long", 0, 0);
>   system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
> -    WQ_UNBOUND_MAX_ACTIVE);
> +    WQ_MAX_ACTIVE);
>   system_freezable_wq = alloc_workqueue("events_freezable",
>        WQ_FREEZABLE, 0);
>   system_power_efficient_wq = alloc_workqueue("events_power_efficient",
> 
> Panic log:
> [  316.386684][  T115] Unable to handle kernel paging request at
> virtual address ffffffd2745a0160
> [  316.386936][  T115] Mem abort info:
> [  316.387027][  T115]   ESR = 0x0000000096000007
> [  316.387137][  T115]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  316.387284][  T115]   SET = 0, FnV = 0
> [  316.387378][  T115]   EA = 0, S1PTW = 0
> [  316.387475][  T115]   FSC = 0x07: level 3 translation fault
> [  316.387606][  T115] Data abort info:
> [  316.387694][  T115]   ISV = 0, ISS = 0x00000007
> [  316.387804][  T115]   CM = 0, WnR = 0
> [  316.387897][  T115] swapper pgtable: 4k pages, 39-bit VAs,
> pgdp=0000000081dec000
> [  316.388071][  T115] [ffffffd2745a0160] pgd=10000009d83ff003,
> p4d=10000009d83ff003, pud=10000009d83ff003, pmd=10000009d83fb003,
> pte=0000000000000000
> [  316.388491][  T115] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
> [  316.388765][  T115] debug-snapshot dss: core register saved(CPU:2)
> [  316.388993][  T115] debug-snapshot dss: ECC error check erridr_el1.num = 0x2
> [  316.389260][  T115] debug-snapshot dss: ERRSELR_EL1.SEL = 0, NOT
> Error, ERXSTATUS_EL1 = 0x0
> [  316.389578][  T115] debug-snapshot dss: ERRSELR_EL1.SEL = 1, NOT
> Error, ERXSTATUS_EL1 = 0x0
> [  316.389898][  T115] debug-snapshot dss: context saved(CPU:2)
> [  316.390112][  T115] item - log_kevents is disabled
> [  316.390300][  T115] Modules linked in: sec_touch(OE) ftm5(OE)
> bcmdhd4389(OE) goog_touch_interface(OE) snd_soc_cs40l2x(OE)
> haptics_cs40l2x(OE) google_dock(OE) lwis(OE) panel_boe_nt37290(OE)
> panel_samsung_s6e3hc4(OE) panel_samsung_s6e3hc3_c10(OE)
> panel_samsung_s6e3fc3_p10(OE) stmvl53l1(OE) slg51000_core(OE)
> slg51000_regulator(OE) pinctrl_slg51000(OE) nfc mac802154
> ieee802154_socket ieee802154_6lowpan ieee802154 nhc_udp nhc_routing
> nhc_mobility nhc_ipv6 nhc_hop nhc_fragment nhc_dest 6lowpan diag tipc
> mac80211 l2tp_ppp l2tp_core hidp rfcomm can_gw can_bcm can_raw can
> cfg80211 8021q btsdio hci_uart btqca btbcm bluetooth ftdi_sio
> usbserial cdc_acm r8153_ecm aqc111 cdc_ncm cdc_eem cdc_ether
> ax88179_178a asix usbnet r8152 rtl8150 pptp pppox ppp_mppe ppp_deflate
> bsd_comp ppp_generic slhc slcan vcan can_dev mii libarc4 bigocean(OE)
> st33spi(OE) st54spi(OE) st21nfc(OE) nitrous(OE) rfkill
> exynos_reboot(OE) heatmap(OE) touch_bus_negotiator(OE)
> touch_offload(OE) aoc_alsa_dev(OE) aoc_alsa_dev_util(OE)
> aoc_uwb_platform_drv(OE)
> [  316.390708][  T115]  aoc_uwb_service_dev(OE) aoc_channel_dev(OE)
> aoc_control_dev(OE) aoc_char_dev(OE) aoc_core(OE) mailbox_wc(OE)
> audiometrics(OE) snd_soc_cs35l41_i2c(OE) snd_soc_cs35l41_spi(OE)
> snd_soc_cs35l41(OE) snd_soc_wm_adsp(OE) max20339(OE) pca9468(OE)
> p9221(OE) max77759_charger(OE) max77729_charger(OE) max77729_uic(OE)
> max77729_pmic(OE) max1720x_battery(OE) overheat_mitigation(OE)
> google_cpm(OE) google_dual_batt_gauge(OE) google_charger(OE)
> google_battery(OE) google_bms(OE) abrolhos(OE) mali_kbase(OE)
> mali_pixel(OE) panel_samsung_s6e3hc3(OE) panel_samsung_sofef01(OE)
> panel_samsung_s6e3fc3(OE) panel_samsung_s6e3hc2(OE)
> panel_samsung_emul(OE) panel_samsung_drv(OE) exynos_drm(OE)
> arm_memlat_mon(OE) governor_memlat(OE) memlat_devfreq(OE)
> exynos_acme(OE) s3c2410_wdt(OE) trusty_virtio(OE) trusty_test(OE)
> trusty_log(OE) trusty_irq(OE) gs101_spmic_thermal(OE) gpu_cooling(OE)
> debug_reboot(OE) smfc(OE) exynos_mfc(OE) i2c_exynos5(OE)
> rtc_s2mpg10(OE) keycombo(OE) goodixfp(OE) usbc_cooling_dev(OE)
> tcpci_max77759(OE)
> [  316.393987][  T115]  max77759_contaminant(OE) bc_max77759(OE)
> max77759_helper(OE) tcpci_fusb307(OE) slg46826(OE) usb_psy(OE)
> usb_f_dm1(OE) usb_f_dm(OE) xhci_exynos(OE) ufs_exynos_gs(OE)
> s2mpg1x_gpio(OE) bcm47765(OE) sscoredump(OE) sbb_mux(OE) gsc_spi(OE)
> g2d(OE) samsung_iommu(OE) samsung_iommu_group(OE) exyswd_rng(OE)
> exynos_tty(OE) max77826_gs_regulator(OE) boot_control_sysfs(OE)
> exynos_seclog(OE) dbgcore_dump(OE) pixel_stat_mm(OE)
> pixel_stat_sysfs(OE) sysrq_hook(OE) hardlockup_debug(OE) eh(OE)
> cp_thermal_zone(OE) cpif(OE) bts(OE) exynos_dit(OE) cpif_page(OE)
> boot_device_spi(OE) bcm_dbg(OE) exynos_bcm_dbg_dump(OE) gsa_gsc(OE)
> slc_acpm(OE) slc_pmon(OE) slc_dummy(OE) acpm_mbox_test(OE)
> exynos_devfreq(OE) exynos_dm(OE) slc_pt(OE) power_stats(OE)
> exynos_pd_dbg(OE) pixel_em(OE) gs_thermal(OE) google_bcl(OE)
> i2c_acpm(OE) s2mpg11_regulator(OE) s2mpg10_regulator(OE) odpm(OE)
> s2mpg10_powermeter(OE) s2mpg10_mfd(OE) s2mpg11_powermeter(OE)
> pmic_class(OE) s2mpg11_mfd(OE) exynos_cpuhp(OE) pixel_boot_metrics(OE)
> exynos_adv_tracer_s2d(OE)
> [  316.397483][  T115]  keydebug(OE) exynos_coresight_etm(OE)
> exynos_ecc_handler(OE) exynos_coresight(OE) exynos_debug_test(OE)
> pixel_debug_test(OE) ehld(OE) sjtag_driver(OE) exynos_adv_tracer(OE)
> gsa(OE) trusty_ipc(OE) samsung_dma_heap(OE) trusty_core(OE)
> samsung_secure_iova(OE) deferred_free_helper(OE) page_pool(OE)
> hardlockup_watchdog(OE) debug_snapshot_debug_kinfo(OE)
> debug_snapshot_qd(OE) debug_snapshot_sfrdump(OE) exynos_pd(OE)
> dwc3_exynos_usb(OE) gvotable(OE) clk_exynos_gs(OE) pcie_exynos_gs(OE)
> exynos_pm(OE) acpm_flexpmu_dbg(OE) pcie_exynos_gs101_rc_cal(OE)
> shm_ipc(OE) spi_s3c64xx(OE) samsung_dma(OE) pl330(OE) s2mpu(OE)
> logbuffer(OE) itmon(OE) exynos_cpupm(OE) exynos_mct(OE) cmupmucal(OE)
> exynos_pm_qos(OE) gs_acpm(OE) kernel_top(OE) dss(OE)
> pixel_suspend_diag(OE) systrace(OE) ect_parser(OE) gs_chipid(OE)
> pinctrl_exynos_gs(OE) phy_exynos_mipi(OE) phy_exynos_mipi_dsim(OE)
> exynos_pmu_if(OE) phy_exynos_usbdrd_super(OE) exynos_pd_el3(OE)
> arm_dsu_pmu(E) softdog(E) pps_gpio(E) i2c_dev(E) spidev(E) sg(E)
> at24(E) zram zsmalloc
> [  316.404101][  T115] CPU: 2 PID: 115 Comm: kworker/u24:2 Tainted: G
>       W  OE      6.3.0-mainline-maybe-dirty #1
> [  316.404491][  T115] Hardware name: Oriole DVT (DT)
> [  316.404678][  T115] Workqueue: events_unbound idle_cull_fn
> [  316.404882][  T115] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT
> -SSBS BTYPE=--)
> [  316.405176][  T115] pc : available_idle_cpu+0x20/0x60
> [  316.405368][  T115] lr : select_task_rq_fair+0x1d0/0x17d8
> [  316.405574][  T115] sp : ffffffc008dfbb40
> [  316.405728][  T115] x29: ffffffc008dfbc10 x28: 0000000000000000
> x27: 0000000000000008
> [  316.406028][  T115] x26: 0000000000000000 x25: 0000000000000001
> x24: 0000000000000008
> [  316.406323][  T115] x23: 0000000000000000 x22: 0000000000000400
> x21: 0000000000000000
> [  316.406623][  T115] x20: 0000000000000008 x19: ffffff8800812380
> x18: ffffffc008cdf040
> [  316.406925][  T115] x17: 00000000aa3494c0 x16: 00000000aa3494c0
> x15: 0000000000019ed5
> [  316.407221][  T115] x14: 0000000000000001 x13: 000000000001a2d5
> x12: 0000000000000010
> [  316.407521][  T115] x11: 0000000000000400 x10: de8448a6b7c5d500 x9
> : ffffffd27459f6c0
> [  316.407822][  T115] x8 : ffffffd27459f6c0 x7 : 0000000000008080 x6
> : 0000000000000000
> [  316.408118][  T115] x5 : ffffff894f35c590 x4 : 0000646e756f626e x3
> : 0000000000000008
> [  316.408418][  T115] x2 : 0000000000000001 x1 : ffffff8800812380 x0
> : 0000000000000008
> [  316.408724][  T115] Call trace:
> [  316.408842][  T115]  available_idle_cpu+0x20/0x60
> [  316.409020][  T115]  try_to_wake_up+0x4ec/0x85c
> [  316.409190][  T115]  wake_up_process+0x18/0x28
> [  316.409359][  T115]  wake_dying_workers+0x5c/0xe8
> [  316.409539][  T115]  idle_cull_fn+0xdc/0x11c
> [  316.409705][  T115]  process_scheduled_works+0x208/0x45c
> [  316.409905][  T115]  worker_thread+0x22c/0x31c
> [  316.410074][  T115]  kthread+0x114/0x1c0
> [  316.410229][  T115]  ret_from_fork+0x10/0x20
> [  316.410399][  T115] Code: b00105c9 911b0129 f8605908 8b090108 (f9455109)
> [  316.410651][  T115] ---[ end trace 0000000000000000 ]---
> [  316.410853][  T115] Kernel panic - not syncing: Oops: Fatal exception
> [  316.411097][  T115] SMP: stopping secondary CPUs
> 
> Do you think the change in patch [2] could be related?

I have hit the following error but at the exact same RIP

1) General Protection Fault

    [  320.476222] general protection fault, probably for non-canonical address 0xfbcb2fe8ef894d01: 0000 [#1] PREEMPT SMP NOPTI
    [  320.487110] CPU: 16 PID: 1553 Comm: kworker/u512:1 Not tainted 6.4.0-rc1-tj-wq-please-boot+ #457
    [  320.495289] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [  320.502855] Workqueue: events_unbound idle_cull_fn
    [  320.507663] RIP: 0010:select_task_rq_fair+0x9bd/0x2570
    [  320.512812] Code: ff 0f 1f 44 00 00 49 c7 c6 28 15 02 00 48 81 bd 60 ff ff ff ff 1f 00 00 0f 87 dc 17 00 00 4d 01 f5 49 8b 45 00 48 85 c0 74 0b <8b> 40 08 85 c0 0f 85 36 11 00 00 8b 75 98 8b 7d a8 e8 7d 01 ff ff
    [  320.531559] RSP: 0018:ffffb7ba505c3c58 EFLAGS: 00010086
    [  320.536784] RAX: fbcb2fe8ef894cf9 RBX: ffffffffa5454538 RCX: 0000000000000010
    [  320.543916] RDX: 542058454d4f4400 RSI: 0000000000000100 RDI: 0000000000000080
    [  320.551050] RBP: ffffb7ba505c3db8 R08: 0000000000000000 R09: 0000000000000012
    [  320.558182] R10: ffff9db1c0159620 R11: ffffffffffffffff R12: ffff9df03d633840
    [  320.565315] R13: ffffffffa5454528 R14: 0000000000021528 R15: ffff9db1cb1b8000
    [  320.572447] FS:  0000000000000000(0000) GS:ffff9df03d600000(0000) knlGS:0000000000000000
    [  320.580535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  320.586280] CR2: 000055c6dc75d008 CR3: 000000807d43c004 CR4: 0000000000770ee0
    [  320.593414] PKRU: 55555554
    [  320.596126] Call Trace:
    [  320.598581]  <TASK>
    [  320.600687]  ? raw_spin_rq_unlock+0x14/0x40
    [  320.604877]  ? affine_move_task+0x29c/0x580
    [  320.609065]  ? update_load_avg+0x82/0x790
    [  320.613079]  ? __set_cpus_allowed_ptr_locked+0x146/0x1c0
    [  320.618390]  try_to_wake_up+0x121/0x690
    [  320.622230]  wake_up_process+0x19/0x20
    [  320.625983]  idle_cull_fn+0x9d/0x130
    [  320.629560]  process_one_work+0x190/0x360
    [  320.633576]  worker_thread+0x2c7/0x440
    [  320.637326]  ? __pfx_worker_thread+0x10/0x10
    [  320.641600]  kthread+0xfb/0x130
    [  320.644755]  ? __pfx_kthread+0x10/0x10
    [  320.648507]  ret_from_fork+0x2c/0x50
    [  320.652097]  </TASK>
    [  320.654288] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge
    stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc ipmi_ssif nls_iso8859_1 intel_rapl_msr intel_rapl_common amd64_edac kvm_amd kvm rapl dell_smbios dcdbas dell_wmi_descriptor wmi_bmof ccp ptdma
    k10temp acpi_ipmi ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4
    btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 crct10dif_pclmul crc32_pclmul i2c_algo_bit ghash_clmulni_intel
    drm_shmem_helper sha512_ssse3 drm_kms_helper syscopyarea sysfillrect aesni_intel sysimgblt crypto_simd cryptd tg3 xhci_pci drm
    [  320.654405]  xhci_pci_renesas megaraid_sas wmi
    [  320.748401] ---[ end trace 0000000000000000 ]---

2) NULL Pointer Dereferencing

    [  320.700972] BUG: kernel NULL pointer dereference, address: 0000000000000007
    [  320.707942] #PF: supervisor read access in kernel mode
    [  320.713079] #PF: error_code(0x0000) - not-present page
    [  320.718220] PGD 0 P4D 0
    [  320.720758] Oops: 0000 [#1] PREEMPT SMP NOPTI
    [  320.725118] CPU: 200 PID: 3718 Comm: kworker/u522:2 Not tainted 6.4.0-rc1-tj-wq-test+ #470
    [  320.733376] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
    [  320.740942] Workqueue: events_unbound idle_cull_fn
    [  320.745744] RIP: 0010:select_task_rq_fair+0x9bd/0x2570
    [  320.750883] Code: ff 0f 1f 44 00 00 49 c7 c6 28 15 02 00 48 81 bd 60 ff ff ff ff 1f 00 00 0f 87 dc 17 00 00 4d 01 f5 49 8b 45 00 48 85 c0 74 0b <8b> 40 08 85 c0 0f 85 36 11 00 00 8b 75 98 8b 7d a8 e8 7d 01 ff ff
    [  320.769628] RSP: 0018:ffff9d9bd663fc58 EFLAGS: 00010086
    [  320.774856] RAX: ffffffffffffffff RBX: ffffffffafc54538 RCX: 00000000000000c8
    [  320.781989] RDX: cccccccccccccccc RSI: 0000000000000100 RDI: 0000000000000000
    [  320.789122] RBP: ffff9d9bd663fdb8 R08: 0000000000000000 R09: 0000000000000001
    [  320.796254] R10: ffff8f73801599c0 R11: ffffffffffffffff R12: ffff8ff1f3e33840
    [  320.803388] R13: ffffffffafc54528 R14: 0000000000021528 R15: ffff8fb306fe4d40
    [  320.810519] FS:  0000000000000000(0000) GS:ffff8ff1f3e00000(0000) knlGS:0000000000000000
    [  320.818606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  320.824353] CR2: 0000000000000007 CR3: 000000807d43c003 CR4: 0000000000770ee0
    [  320.831484] PKRU: 55555554
    [  320.834197] Call Trace:
    [  320.836651]  <TASK>
    [  320.838760]  ? raw_spin_rq_unlock+0x14/0x40
    [  320.842944]  ? affine_move_task+0x29c/0x580
    [  320.847129]  ? update_load_avg+0x82/0x790
    [  320.851144]  ? __set_cpus_allowed_ptr_locked+0x146/0x1c0
    [  320.856453]  try_to_wake_up+0x121/0x690
    [  320.860295]  wake_up_process+0x19/0x20
    [  320.864046]  idle_cull_fn+0x9d/0x130
    [  320.867625]  process_one_work+0x190/0x360
    [  320.871638]  ? __pfx_worker_thread+0x10/0x10
    [  320.875912]  worker_thread+0x2c7/0x440
    [  320.879665]  ? __pfx_worker_thread+0x10/0x10
    [  320.883935]  kthread+0xfb/0x130
    [  320.887083]  ? __pfx_kthread+0x10/0x10
    [  320.890837]  ret_from_fork+0x2c/0x50
    [  320.894414]  </TASK>
    [  320.896608] Modules linked in: xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bpfilter br_netfilter bridge
    stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio overlay binfmt_misc ipmi_ssif nls_iso8859_1 intel_rapl_msr intel_rapl_common amd64_edac kvm_amd kvm rapl dell_smbios dcdbas dell_wmi_descriptor wmi_bmof ccp ptdma
    k10temp acpi_ipmi ipmi_si acpi_power_meter mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables
    autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mgag200 i2c_algo_bit drm_shmem_helper drm_kms_helper syscopyarea
    crct10dif_pclmul crc32_pclmul sysfillrect ghash_clmulni_intel sha512_ssse3 sysimgblt aesni_intel crypto_simd cryptd tg3 drm xhci_pci
    [  320.896686]  xhci_pci_renesas megaraid_sas wmi
    [  320.990684] CR2: 0000000000000007
    [  320.994006] ---[ end trace 0000000000000000 ]---

The RIP points to dereferencing sd_llc_shared->has_idle_cores

    $ scripts/faddr2line vmlinux select_task_rq_fair+0x9bd
    select_task_rq_fair+0x9bd/0x2570:
    test_idle_cores at kernel/sched/fair.c:6830
    (inlined by) select_idle_sibling at kernel/sched/fair.c:7189
    (inlined by) select_task_rq_fair at kernel/sched/fair.c:7710

My kernel is somewhat stable (I have not seen a panic for ~45min but I
was not stress testing the system either during that time) with the
following changes:

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b2e914655f05..a279cc9c2248 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2247,7 +2247,7 @@ static void unbind_worker(struct worker *worker)
        if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
                WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
        else
-               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+               WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
 }

 static void wake_dying_workers(struct list_head *cull_list)
--

However, the bits above were not directly changed by this patch and have
been in workqueue.c since commit 46a4d679ef88 ("workqueue: Avoid a false
warning in unbind_workers()"). I can only suspect something else changed
that has uncovered another issue in my case. You can give it a try and
see if it helps your case too.

I'll wait for Tejun's response however, since I have no explanation as to
why the above workaround improves the system stability in my case :)

> 
> Thanks,
> Sandeep.
> 
> [0] https://lore.kernel.org/all/30625cdd-4d61-594b-8db9-6816b017dde3@amd.com/
> [1] https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline
> [2] https://lore.kernel.org/all/20230519001709.2563-10-tj@kernel.org/

--
Thanks and Regards,
Prateek
