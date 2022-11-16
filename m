Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E621962B171
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKPClH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiKPClE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:41:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDFFBC3E;
        Tue, 15 Nov 2022 18:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4lFkYihUzNUH5wqIEXWOIc3/a3eUFRXfTEDWQwR0G3TXpcOwx8kHrPpOZD8ujZ5vxyikikkKW+C6VdjN4PomYaXs1OC7Ftq3BFI8OzWz1fb8uBcweBcOp0ZwNKu67nEexPHItxrH9REerOpiRqveWgviQI6KzGIyz45VkOl0Ek9HSRp/b00b0bAUGJoLKyueiKuUE1JTGDLXJo0iOykEGcrl51nFZlzE15RsCrEzjjU+8ZimWf/N+taDE93VurFlstEB6y6AnOoDYW+11cEahhqK9oHKGM5TEoNFz/jYGr2TOqTulphWrExLfFAurOErrrUU0sE4DNRP41kYXZjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq1O3oY8C4irWq4Hh/vHNJbfShnWhGVeCfai88CZyn4=;
 b=RXTek2KMkFrnwIi39spu8V4J8BNuW9v38h0cjovY3DS4q8vjCS47dDm2zBD4cL+OiKpVckj+bPL4RQ1gODPDsBeEatEiPOYTpI9OuPXViBKO9r4/aKIORhprljhGWm4zsHhWbmbBksbScHl8uoqY4LKhWPTsd8vgmNbE2pxdXHQzBZyInTG/KQyjHt2sGO+AaviyHcPYNkoNmAxeP8JwiSokDG+vhS8fXDMVu0Zaw5N1Zg0C0wwjzQJv7NhgJ6+w4nYGxrNSlXMlqdRPr6SAzpm8v0X1/mHtQnOwWlsm35vdkfXdOcmz25xemDHl9xsDGp1VJEBImh5WHxYYqEKc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq1O3oY8C4irWq4Hh/vHNJbfShnWhGVeCfai88CZyn4=;
 b=WuIwQU4RmRBfNyp7FPTycHfbwgUhaQJATR/nNabGIeLqHAH2DUWEH5datdKXuUG5blQ8/ctM6V0d3pT+5Z7lrVJgMTIfPzpr2vAjjvu6pTD8vtAaJnYgmZchkUSJKWBDwJVNdFItrIqufgUEsY83e716MOlrAWTHGLvURgvGQaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 02:41:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 02:41:01 +0000
Message-ID: <8ab6048e-26fe-5cc1-9116-c25fdc742a65@amd.com>
Date:   Tue, 15 Nov 2022 20:40:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC v3 1/4] PM: Add a sysfs file to represent the total sleep
 duration
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20221115200156.12218-1-mario.limonciello@amd.com>
 <20221115200156.12218-2-mario.limonciello@amd.com>
 <CANDhNCqPWV_dC_wo-CCqBuO0J=5TcRAh5AX335PLft2+w19_tQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CANDhNCqPWV_dC_wo-CCqBuO0J=5TcRAh5AX335PLft2+w19_tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: db093469-46e1-456f-3c91-08dac77bffb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZxmXj6xGSB0ykEc99EB0JRTaUZ/My87xk5ZA1hbJk+VmwjQDEvt9QaDr19qBgvqNScm2FSWVtWXRxeI1dc6hpS3kfc1GK/aOhMTTyBf31g8d3HUgsWAqFA1w176wG0xHKYpgl7cfCtI3WxpmI8xa3+9F8tBzzUbjXAhhWKkQ8rR6H1bNMS3pkbMOanCll11R6JfPcfQWnpw8czcm/z/fnoPjZVQww89wy0EZNIvMCXFsIVXjrZbx2I7JMEh1wqwLVDZOK9Xf2OiUIyBu9OTnTa1C9se7m2UM3EORfuTEaESj957VKke7l60sHKC9ddjtJ6RO0QTiUpXA2dkBl92DnOOCnLx7f81XY0Ire9bH1WhpOfUMSn2rZIFuqPqCgm8q5N6AXjvGLbxyOmbTZgHChEc9aj8wWVZXxrH91yYVCRI4Ut8zdrtTPs8t6SLBI7j4VwermNK/XNl/vOUkgZDMOWleZAuGU51tsUAvV2o/HH+DqWH2H92DB7ddWcyAXY4FSU5bf0hyo/hQO0ZBp2dhuxq/fADstvGf6f41Zn+V7S8FheuNo7FOlMsr3EYTrSMXrn40JwT9+quJeJy0H6qzt4CDUcxh5DV8iNgGITls+3/sqZPXTOczuamV29GCzuyce0HnOQs3QYYPgmn0FuUYuFOWKywnsJyxWrgAM/ouZlEcKOh+fyyyOf3lMqDiDlJ/39601I1tNk4JPIj2BOkeYiwALJjSEbyBDLRcsSWNkz080rxNdO7AGJUTs2BAcULFIvii4HtEphgJgX6c01vmqFjP9M20nho9+IKMF+6Zlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199015)(316002)(6512007)(53546011)(186003)(6916009)(26005)(66476007)(8936002)(41300700001)(66556008)(66946007)(8676002)(36756003)(2616005)(4326008)(54906003)(6506007)(83380400001)(2906002)(31696002)(86362001)(38100700002)(5660300002)(7416002)(6486002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBVVFZRMDNvQlJHVXpWajU5RkJjdjNiSml1cGo0Uy9GRHRXMmhlV2taTG9K?=
 =?utf-8?B?N1VLNjYrY3d2YjNKSmFwYmlqWUZ4VGZpVW1RR1NLS3pQUTRKRktOT0RhOFJF?=
 =?utf-8?B?TzZZQ2xicnVyY3FJYU44WVl5eDA4OGxqMHJiNStVNWdaUXVkVWxPdEV0R3pN?=
 =?utf-8?B?RWFyOS9wckhNeHoxMFp0a04zT3lIWTdMcVp4dFJPN2tzYU51dVRDSlZCcGVv?=
 =?utf-8?B?TGVBQS9pQlpwRFdRL01rTGV0VG9GdnoxTjNicVpSK3JBaStjUWM1MDRKek9P?=
 =?utf-8?B?WWF3S2RKQkFGSGhDcmllRnNzSG1EVGNuMjJUaXpPVWhoRVFzQm1uTm00bFFK?=
 =?utf-8?B?Z1Ntb1Q0ZEdFdmRBSG9lYUtFVkNDNjk5YkVIS0o1VGlJcEYxcGpwSnVhSUtO?=
 =?utf-8?B?MEhIcHVYZVRhUDBMMnhTNHl3c0lFdmJPa0ZocWRXZVlNMjlNcDAzdnZVdFMv?=
 =?utf-8?B?RFIycXhZOVBMbzl3Z29jUjFqcFJxbDNqM0JhRFZCeERWZDZleGpHL2ljeFJN?=
 =?utf-8?B?NmVBa0hkSXRIQ3JBRlMyTnYvejFJZklzdFNOamxtRUYrWU50NXNOMW9rM2hD?=
 =?utf-8?B?dVhyVzlKdkRQWUtMM1IvTmxmcFFOajViRlBDVE95R2IwV3BmS3N5QjcyY3U5?=
 =?utf-8?B?L2VPYUtVcEVHRmt0b04rK2pvTjJTRFlJOVd4dXF3M0ZIOUc3Rkp0dWppK1Zo?=
 =?utf-8?B?SDFRbC8yV2ZXeFdTMitvbjhFZEE3V3B0MnJua0cxMmlRdWQvQlZJYngwUGF0?=
 =?utf-8?B?N0JzNEJTRG9Cei9tTWtCdFNOUnE2WG9BU3lia2h3ZHEwcVc2UTFJbEhZUUFx?=
 =?utf-8?B?VXNKWGtGY3NDSmMxS2hmMVM0dkpGSTZZdjRLSXBhTXE0by9tYlZPWFRTbzh1?=
 =?utf-8?B?Tm45WEtEL21SM2Rua2tZTnhRVitvVjlweEFaZW1uWWxtUWt2U0JvOW5FUG9H?=
 =?utf-8?B?YzFybm5kVGsrUm1qckF1Q21kNnFBOVROT2FhdEczMnpsT3VRQ0hiRTkzRm9N?=
 =?utf-8?B?S1FxZ2JlMUtFb245a3BTK3ZYRGd6cGpyRlVTSklrVmNybVpETHlrdGpOdllm?=
 =?utf-8?B?OEJaaTVuTDJSSFFMdkthbUdxejBzMGVIdVpjaXN1YUQrV1pSRVJrcm5UcDFP?=
 =?utf-8?B?R1A3ckd3TnlKZEJrNVlBN3c4TXlnOXNKYm1lKzRhTTdyYWVjZDVnbmNrWURt?=
 =?utf-8?B?RHlPVXpWWUNiQk5RTnZGaGlTbDVvWjUwWGNlcHVNWXgzWmNjaFNLemVrN2l4?=
 =?utf-8?B?U0k1clp4K0hpVFhQdldRdHNkZmo2b2Q1SXBkbjNUakZlR01wTHpleFUwTC9N?=
 =?utf-8?B?cHk2RDVOZ0JZc2dudFIzOVRNN1ZWK1ZxVnRXcWU5MytsM3czc0VvT2FUemtv?=
 =?utf-8?B?aG9iUGV6TUVrWHMyNUZ2QjJnMWpPbTdXcGU4RlBOc2k0bmlpUzRZMzdCNDJM?=
 =?utf-8?B?SmtOUjdRSlVDY1M0YndzWWU1c0JrcDZoTnRDNS9CUzhyWVA4SkpvZFVVZExa?=
 =?utf-8?B?YjVhK3E5c0hqc1IxZWhZREQyU1pUWWpzdFZMM3VsSFRlOGs2NzE3bHUvY1hi?=
 =?utf-8?B?M3NUY2lJUHJKRktQd3I4UlVHaTV4cXltbkMvRndMdE9MUWMxQkRRa0ZpMG5D?=
 =?utf-8?B?T1VnWkJINWdRakV6VFJZeG05Mi9RY0lRSERrNFB2UHJwVWpMeXhLTVV5SUhY?=
 =?utf-8?B?NVNtcHVVSkFYeVJFZGVpZ1gzYTNrYlJ3NmhuS3cvL2s2aEs5UlV4RzBQei9U?=
 =?utf-8?B?WTd6bDZLRUlRaWlpUXdSVEcrVlpacituMDFUaGFibDB5Q1FZWGN1Nm0yL1Nr?=
 =?utf-8?B?cFZNWld6ODBEQkQzWWdkWG5rQURTU2RTakoxL1JYMWoraFhxNGxtaXhGREY4?=
 =?utf-8?B?NW84U3l4dy9tOUh4NW1YRjhGbmdweUI0NmR5YWxralVFbHFCRHM1SktuSHJh?=
 =?utf-8?B?U0V6M2l3RU5NV2NsR3RyOVBFc012L09jcVlBbFQ0RW5DQ1BOOXpKVmlCbC9m?=
 =?utf-8?B?QmlUZ3ZrbUFLZnVuL1MwTlVaQldzRTA5cmV3dkZBYmNjNFdkMndZSDVwcU9w?=
 =?utf-8?B?SnFrSVJLbHZHbU9qbjFCQXg5KzVnYXdIRk83ODBGbDVWcWYxN2hMS2hoNlRR?=
 =?utf-8?Q?4KOUnNxHvrcWKRB9OLmhFWSYc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db093469-46e1-456f-3c91-08dac77bffb1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 02:41:01.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4EiB6ya1A034jq3G2FIRaqiMq7EGFyP69LL2Sew1754oDNJMQaAhXt4ZkPsXNCq5Xf+bUpIxee+003sdixbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2022 14:44, John Stultz wrote:
> On Tue, Nov 15, 2022 at 12:02 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> For userspace to be able to analyze how much of a suspend cycle was spent
>> in the hardware sleep states userspace software has to use kernel trace
>> points paired with the file `low_power_idle_system_residency_us` on
>> supported systems.
>>
>> To make this information more discoverable, introduce a new sysfs file
>> to represent the duration spent in a sleep state.
>> This file will be present and updated during resume for all suspend
>> types.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> RFC v2->v3
>>   * Drop one of the sysfs files
>>   * Use sysfs_emit instead
>>   * Fix symbol name (s/type/time/)
>>   * Drop is_visible
>>   * Use timespec64 type for suspend stats
>>   * Update documentation
>>   * Update sysfs file name
>> ---
>>   Documentation/ABI/testing/sysfs-power |  8 ++++++++
>>   include/linux/suspend.h               |  2 ++
>>   kernel/power/main.c                   | 15 +++++++++++++++
>>   kernel/power/suspend.c                |  2 ++
>>   kernel/time/timekeeping.c             |  2 ++
>>   5 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
>> index f99d433ff311..3abe20c47e08 100644
>> --- a/Documentation/ABI/testing/sysfs-power
>> +++ b/Documentation/ABI/testing/sysfs-power
>> @@ -413,6 +413,14 @@ Description:
>>                  The /sys/power/suspend_stats/last_failed_step file contains
>>                  the last failed step in the suspend/resume path.
>>
>> +What:          /sys/power/suspend_stats/last_total
>> +Date:          December 2022
>> +Contact:       Mario Limonciello <mario.limonciello@amd.com>
>> +Description:
>> +               The /sys/power/suspend_stats/last_total file contains
>> +               the total duration of the sleep cycle.
>> +               This is measured in microseconds.
>> +
> 
> Nit/bikeshed: "last_total" seems less straightforward then it should
> be? Maybe "total_suspend_time" instead?

I initially thought the same thing but I feel like you can make the same 
argument about "success" or other files in the "suspend_stats" directory.

> 
>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>> index 31ec4a9b9d70..f33012860699 100644
>> --- a/kernel/power/main.c
>> +++ b/kernel/power/main.c
>> @@ -6,6 +6,7 @@
>>    * Copyright (c) 2003 Open Source Development Lab
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/export.h>
>>   #include <linux/kobject.h>
>>   #include <linux/string.h>
>> @@ -54,6 +55,11 @@ void unlock_system_sleep(unsigned int flags)
>>   }
>>   EXPORT_SYMBOL_GPL(unlock_system_sleep);
>>
>> +void pm_account_suspend_time(const struct timespec64 t)
>> +{
>> +       suspend_stats.last_total = timespec64_add(suspend_stats.last_total, t);
>> +}
>> +
>>   void ksys_sync_helper(void)
>>   {
>>          ktime_t start;
>> @@ -377,6 +383,14 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
>>   }
>>   static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>>
>> +static ssize_t last_total_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%llu\n",
>> +                         timespec64_to_ns(&suspend_stats.last_total) / NSEC_PER_USEC);
>> +}
>> +static struct kobj_attribute last_total = __ATTR_RO(last_total);
>> +
>>   static struct attribute *suspend_attrs[] = {
>>          &success.attr,
>>          &fail.attr,
>> @@ -391,6 +405,7 @@ static struct attribute *suspend_attrs[] = {
>>          &last_failed_dev.attr,
>>          &last_failed_errno.attr,
>>          &last_failed_step.attr,
>> +       &last_total.attr,
>>          NULL,
>>   };
> 
> While not identical, this has some overlap with the logic in
> kernel/time/timekeeping_debug.c
> I wonder if it would make sense to consolidate some of this accounting?

Sure.  If the consensus is to stick to this approach of exporting the 
total time I'll look into that.

> 
> thanks
> -john

