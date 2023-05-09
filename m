Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDD6FC9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjEIPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjEIPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:10:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9B40C4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYPfJ/16HHVinfpXH1jBk1biAji7kEyJbLaoM9jpqR04dIVcbMRmsaEBG3crjsmSyxaxWvykYaR2aSbgRY5v0FyIE4CQOKJfomumJlC/U0Wy2WHDblVGjUiKVlMDJ4yUjzVITwHgqhJ0wFqAGegA8tm+QrvpV6TV6839uSgeuYRyr0EQ5v+/o18HdaWvICZKWHbPWECs0FyNB+26PegCvYEWGSUPAl9IFSy0BhghWUBpCUBgwO4XY8JKeMGwij7q3hTc/nQvp7GzxNeJtmNznS2f/kG3aeo4HSga0pjxLPPloYb8oWaBjKswDul/QwBllFVVOyOZloMAc5k3/brngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TndFIRyiS7QOGF2lrlLJ7MRahNUrwpANd9lYjBYoWMg=;
 b=nnJ4Zy3erx4vQ+bf90Kz/Qf6+85xMstk+vdGhr+3wytKSGi5BfGbp+pbeTLAcQ2eTEtFOGtDSBmSU92BGHICN49y/Pct+Fxad/6XGoxLBJSrICA17ZTtNHbhNOqBjx+7x5bZoCGVGxBrrRo9ke0nfMprV8mh79etQbCG1EwtUVlN/7tyQabMn9Sp2KXEgGoNiOh/AmEM040v6lFoqFuMbm7JKinr0f/XiYzoWu0IKK4vdWBGrVKhcoOKt4A7+lzNKScH1UB2gSjnV+T/kZbbOlEXOl5IObx1Zyk7ukvG5++fWpn+iS/yxqDvB8wPz+K4dFfjGJrXOoib3O8FgFlLrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TndFIRyiS7QOGF2lrlLJ7MRahNUrwpANd9lYjBYoWMg=;
 b=2/opn45QjDnXPRbLIRW5YpZ43JFe+EIMCdIIXzG/YNdBmV07HWWprPfp5Kj/z9awmVY0C1K7iOkoryUJgjBEzEkZYCTdp3U8dPntkR1xIdGyHdmFS7orvQinis5hz9u2RPhRkktuUx8VVRRYhYY9fC+fGzxN17ggeU1rbLtmZ/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 15:10:13 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::1cb9:7a04:7cac:44b5]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::1cb9:7a04:7cac:44b5%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 15:10:12 +0000
Message-ID: <d4279615-4122-d7a1-5397-c570e2f09fa8@amd.com>
Date:   Tue, 9 May 2023 20:40:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/2] drivers: base: cacheinfo: Fix shared_cpu_list
 inconsistency in event of CPU hotplug
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        yongxuan.wang@sifive.com, pierre.gondois@arm.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com,
        palmer@rivosinc.com, puwen@hygon.cn
References: <20230508084115.1157-1-kprateek.nayak@amd.com>
 <20230509150151.kscbev7qrycz5cqy@bogus>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230509150151.kscbev7qrycz5cqy@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c673b9-bc10-43f3-4ffe-08db509f7c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyYD35PNiu8u5F6XtZyvIKcMnAwMYXVF9A5mawx+yr0sZcgMNfGQC6iXZxH/qyI4tLJE+6yqH8z6tNxOsUulCVc9Yz91Wv1GjeJGHhFEdoolb6W+1oViQbnKUJIQpwz/C93B7e3TTJNoDZUambeJ5A6U34I0UGo8wXXpEJpfQMZnpoScOdCA9gBN93UXkUncBpnk51oPO3i/xj/nxbTjezVsF8ZdY940SFqnucESCTLCREb6avTNm15gOaeM//FNJ+58jpOl5jx5+rjNXxkQeK95qoAezGLB3E2ybZ1nNpWNS6XD84u/t5xmovIB1TUobzWIc8T955GkLuqdMH3iQljhuXTNyfv1PbM5a1vpi9tXBB3svcIBEjgxeNQZH2CdNfVB5foUaKjrWDCSl5/FC/qeEXcbfSccng811+8wLJUBuXEGEfwjcHMPHlta8rhPq1soy1CyunuoARZN+FS1tL9LGlO4xTrBdTLyYpWKbxwqjAHHiZzwQ9WBfktiQ3EFwmmeXdsDSF+uXCfk6XryGTwbcGmlVOESref8k21RbjL1CCUG3o1qLuPcGp88TUHZtHqnrKVqfl/lN6kOEeAX6z6sG4dAPlm8Szd4aJAvaUQjjU3eA8e9Buw28w/mIRYNq33uo7/6v8xVs3jfHHsvhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(5660300002)(8676002)(86362001)(7416002)(8936002)(31696002)(31686004)(316002)(4326008)(2906002)(38100700002)(478600001)(41300700001)(6486002)(6666004)(2616005)(66946007)(66476007)(66556008)(107886003)(36756003)(186003)(6512007)(26005)(6506007)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpDOXRlQmFmYnhlbjdFSGNEZlhqSDNWMFdOK0lJclhuQy9TdlZUUjJLdUs1?=
 =?utf-8?B?MkdsMEp1a1U1Rms2SDhpd0p2MTg0VG1sdWUzZjJYVHlnM3dGakF2MmlITHFQ?=
 =?utf-8?B?UURUZ05ZczMvQ29jUFlnc2ZibEVrYmFHOWhsSXQyKzM5bUplM3d1QitqSXpU?=
 =?utf-8?B?SkhKT3Zid1ZZY2dSenhhelF6UkxRVE9ncWlZNjNYcllvdUc2U2VQWW9Vb1o3?=
 =?utf-8?B?VGtBUkFnVSszeERQMFZ0VGl1d2ZhKzVQSEtiNVpnUUM0SVUvVldtcHRMS2xz?=
 =?utf-8?B?SzgzaWRPWEdTcUM4eDVET3lCSmhoQ1dpd3o5WngzTUFwdjJXRVp6cllTdk0z?=
 =?utf-8?B?eWdDM3RjY3JVZ0h4eFNmY3ZVZ3JteG1EdHZ3REJRZGZxclRYUzRnd0d6TXFa?=
 =?utf-8?B?RHpZQnJWeG1lajVtbXp0Y3QwOGNVM3dqWU5DN1JIWEt1U1ZYcmR1QUM5Z3ho?=
 =?utf-8?B?L0NVcThYRFd5Q0dDWndhbG1LQmpXM2svNUZaUFA4RXhMbTJVTkxVcnVKZjRO?=
 =?utf-8?B?Y3VmeUxFUnhRLzRXQ0RjTWZRU0FCN01WVFAwNnVNNElMVGhoQlllOGZMNnVS?=
 =?utf-8?B?a2l4VzlpZ1VLZjlJMFVuR0RrWFJFR3gwY3JNNXRFcEswcTFYOGpOVm9aMHlI?=
 =?utf-8?B?ZHRKTytiWVpSM3c0a25oTGRtS2FPQWtWVytSWnVBaW5LbitjcTJ5Ym5OeTNR?=
 =?utf-8?B?VC9FTUFjSU9PVXlwSW1PQ3dVNlJpYWVtNjBGRnRFUUtQRVFLQTFscy9ZVnVT?=
 =?utf-8?B?R0FBMU1aVyt1K3YzKzdXUzQvSzNwOWhsTHZET1NBZUtrZ2FyUDJBbjY1azJI?=
 =?utf-8?B?STA1ZHBjQUIyNVdJWk5uekFPREMxTmJTeENrbnN3RUNlRGdWcThzaHdEb2RO?=
 =?utf-8?B?MkJBN2I5QlFOYUhRRG9lbFI0cDVGSFdac3pRbk1FNzUrSm9IanFNUlUyS0cz?=
 =?utf-8?B?VGVFYjdHbENJSFA2dXFLaFk2ZHBHWjBSNkpUTE9qUWowbXNVU25tWFlSQkpm?=
 =?utf-8?B?cTBMR0JLUkVnSmF0RDcrMmg4WlZBVm82Q1ZHdC9zVzZZQXludWRrSFJVN1Ez?=
 =?utf-8?B?WEtOV3FkV0cvNHZXTGhYdzdmZlREbG9wRzBnazNuL0k4cm9ka3hnQnI4Zko1?=
 =?utf-8?B?ZHhBd0MzRzJmNWNUMGNJSEtVM21hNzYzMGgyQkZhajJydlh3NklxeTExV251?=
 =?utf-8?B?Y3BRemhvNHdhMTZnQU1xUEpwRUtYTU9CcjFBbG1oN0tmcEJQTmVCRjJVVmRr?=
 =?utf-8?B?dlVyL0xhNjREU1JPM3BYdGYxUFU2ejNVSDFWWWs0KzlpZWRyV1NnRHluSFl5?=
 =?utf-8?B?OG1FalJ4YW9lUzlyaXJJS2Nzb2J6SDUyYUlIQ2hReTRDWXpUMUNtbFBZcnlC?=
 =?utf-8?B?Y1ovcHk3U0xDS2tYL0lCOHh2ZnJRVnRXa2V4SGFMcDYrS0RKblV4QVdFcVl4?=
 =?utf-8?B?UEtlN3l2SHVjL05KaDA0c0xLM3NLamJ3c0s2VjBUSWZmekQ3L1lYY1djaXhN?=
 =?utf-8?B?eTAzd3RxeXRZdm9Pb1k2NndHK2VNWG5kRGJTRTBNZEZUWDBCRlY0TVd4T29j?=
 =?utf-8?B?VlZRaitXMDJOcGVYbzkybmdTUXpSMVpEQnJuWENIL0dZMFFnR08rSlNCaHE4?=
 =?utf-8?B?Q2VuMFRCWGdIZEMvam1aTGxmSkx5bzFxMVdjZmEvejNHemRCUzdwNlpDN3hx?=
 =?utf-8?B?enVmeGZuenNVR3dhaTc1c290aEVBRE9aYjJmRnhMejY1aDdhbXZUMTdtVnlV?=
 =?utf-8?B?YlhncmU3OC9xbjAybFlFdVhNZXRMNlJQbVdvNU5EQkIyNklGTElWQ3g5YjBF?=
 =?utf-8?B?dXlLRVpPb3RnM3llZEYzK29kTUZUTW5VTGQ0Z0JCdXo2cXQ4OGpCbytXWHBo?=
 =?utf-8?B?aXVUUDRaU2p1YnZGSUd2Q0VncWV1N3ZyVTNiQkR6eFJGdjR5aDY4OVBXcTBm?=
 =?utf-8?B?TFpUdXhYTC9YOC9uYTR3VWxOZ1BIS3J1MFAxYlJkTmtJdGI2MzdzbDZIcWdY?=
 =?utf-8?B?RWhKMlRQS0dpdXFlU2hCdXJYNzdIV0xlQWo1SEladDFDRTQySEd4R2RwVEV4?=
 =?utf-8?B?elZpQlNXSEx6bnpQc3NkYnJmdDkrTm1JNW9mMnhlU2x2T0pqckNzNUZqeVJO?=
 =?utf-8?Q?Nk3MGK5GEypDI5n0I+t0azt6N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c673b9-bc10-43f3-4ffe-08db509f7c92
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 15:10:12.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw3Z7Jzjr0hPzjD5A/uqszoue60Sh1K+ZhFE/1SP9lo14hrK7jdM/Gz3WgsDI911+nk6csBSbxBqpJG7Qj8C8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

On 5/9/2023 8:31 PM, Sudeep Holla wrote:
> On Mon, May 08, 2023 at 02:11:13PM +0530, K Prateek Nayak wrote:
>> Since v6.3-rc1, the shared_cpu_list in per-cpu cacheinfo breaks in case
>> of hotplug activity on x86. This can be tracked back to two commits:
>>
>> o commit 198102c9103f ("cacheinfo: Fix shared_cpu_map to handle shared
>>   caches at different levels") that matches cache instance IDs without
>>   considering if the instance IDs belong to same cache level or not.
>>
>> o commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
>>   sysfs") which skips calling populate_cache_leaves() if
>>   last_level_cache_is_valid(cpu) returns true. populate_cache_leaves()
>>   on x86 would have populated the shared_cpu_map when CPU comes online,
>>   which is now skipped, and the alternate path has an early bailout
>>   before setting the CPU in the shared_cpu_map is even attempted.
>>
>>   On x86, populate_cache_leaves() also sets the
>>   cpu_cacheinfo->cpu_map_populated flag when the cacheinfo is first
>>   populated, the cache_shared_cpu_map_setup() in the driver is bypassed
>>   when a thread comes back online during the hotplug activity. This leads
>>   to the shared_cpu_list displaying abnormal values for the CPU that was
>>   offlined and then onlined since the shared_cpu_maps are never
>>   revaluated.
>>
>> Following is the output from a dual socket 3rd Generation AMD EPYC
>> processor (2 x 64C/128T) for cachinfo when offlining and then onlining
>> CPU8:
>>
>> o v6.3-rc5 with no changes:
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>>     136
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>>     9-15,136-143
>>
>> o v6.3-rc5 with commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
>>   through sysfs") reverted (Behavior consistent with v6.2):
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>>     8,136
>>
>>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>>     8-15,136-143
>>
>> This is not only limited to AMD processors but affects Intel processors
>> too. Following is the output from same experiment on a dual socket Intel
>> Ice Lake server (2 x 32C/64T) running kernel v6.3-rc5:
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,
>>     26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,
>>     88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
>>
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8
>>
>>   # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
>>     72
>>
>>   # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
>>     0,2,4,6,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,
>>     66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,
>>     120,122,124,126
>>
>> This patch addresses two issues associated with building
>> shared_cpu_list:
>>
>> o Patch 1 fixes an ID matching issue that can lead to cacheinfo
>>   associating CPUs from different cache levels in case IDs are not
>>   unique across all the different cache levels. 
>>
>> o Patch 2 clears the cpu_cacheinfo->cpu_map_populated flag when CPU goes
>>   offline and is removed from the shared_cpu_map.
>>
>> Following are the results after applying the series on v6.3-rc5 on
>> respective x86 platforms:
>>
>> o 3rd Generation AMD EPYC Processor (2 x 64C/128T)
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>   
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>   
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143
>>   
>>   # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
>>     8,136
>>   
>>   # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
>>     8-15,136-143
>>
>> o Intel Ice Lake Xeon (2 x 32C/128T)
>>
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
>>     28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
>>     92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
>>   
>>   # echo 0 > /sys/devices/system/cpu/cpu8/online
>>   # echo 1 > /sys/devices/system/cpu/cpu8/online
>>   
>>   # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
>>     /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,72
>>     /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 0,2,4,6,8,10,12,14,16,18,20,22,24,26,
>>     28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,
>>     92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126
>>   
>>   # cat /sys/devices/system/cpu/cpu72/cache/index0/shared_cpu_list
>>     8,72
>>   
>>   # cat /sys/devices/system/cpu/cpu72/cache/index3/shared_cpu_list
>>     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,
>>     68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,114,116,118,120,122,
>>     124,126
>>
>> Running "grep -r 'cpu_map_populated' arch/" shows MIPS and loongarch too
>> set the cpu_cacheinfo->cpu_map_populated who might also be affected by
>> the changes in commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported
>> through sysfs") and this series. Changes from Patch 1 might also affect
>> RISC-V since Yong-Xuan Wang <yongxuan.wang@sifive.com> from SiFive last
>> made changes to cache_shared_cpu_map_setup() and
>> cache_shared_cpu_map_remove() in commit 198102c9103f ("cacheinfo: Fix
>> shared_cpu_map to handle shared caches at different levels").
> 
> I think they may be affected as well, it is just that it is not caught
> in the testing.

Yes, you are right, since those platforms support CPU hotplug as well.

> 
> Thanks for the detailed explanation and output logs. Not sure how much
> time it took you to write but saved lot of time by making it so simple
> to understand the exact issue. The changes look good.

Glad to know it helped during the review!

> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thank you for reviewing the changes :)

> 
> Hi Greg,
> 
> Can you please pick up these fixes in your next cycle of fixes for v6.4 ?
> 
--
Thanks and Regards,
Prateek
