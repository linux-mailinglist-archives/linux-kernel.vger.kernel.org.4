Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F684734A62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFSCx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSCx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:53:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0B1B5;
        Sun, 18 Jun 2023 19:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CikMt2jGcehSNZey4EPJilfd+qJpKOukOAxBPH7uGJNCeSJbpykq529xSejbHfF4oAAKWhof5ogwNGHKg8Tp9tsrKfSm32KvZWl4mNAmhldab43KJUUPN5Dc3MMigpOopfDnqV5lg3pL3JfJANxuiQBADHYlwHbVI7A9c+PT2uZs5e8J3DNG6squi6U8vaVaRiZY7iPSaGGOkQybki8gpx8VF1x/LGWnrTRNhyuMbnLfHKkSywPE/2wxBYjNaKfc3yqzVeXwVc4TBe3kZ6AlDl1YQ5DD426o5AFENpLPiIXO+JD8/OjZxy+2HgNhJzUQ0/jk5/gqG+o0OuyiOT8+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eB/4UjNHOl4HD50hd3BSfElAYbmR/7j624hhQFh6lHo=;
 b=VrmmUBDgMVfGOsZUZc/XhSS2h9rv2ZGRLfdR8hlz//I+O/DIVQjbK8ckyEAPuTD32c2BBF4y3nh8AasNyldR1wpyNnSQ5VjpcP5K4t0nBr+TqBaw6744erqPl2ao9W5rnBIZhcpunS9elcL0B9fHpg7VZKK3uYcHX4a7vv6rm22k9Hq4chhyd6tsPpx360szkDjUQ6wYPEJs2It7sxDUjrvAp3zaUydYMrHcQrlKm4z5z1O1T0ggdU7csK8/U1CUTPl3t7VhuBvp+tO0L9GsqDIioyRvdRgPmIr72F2QVFI1H5sgCrLuU3EY6SobnbtwSKR6+VMAwKM9/A7I3Upa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eB/4UjNHOl4HD50hd3BSfElAYbmR/7j624hhQFh6lHo=;
 b=moqX1CxQavy9ZHz5d4mFUS+JvEQCgKHNQyJy1iTQal5rBUuqvDvzdyxGXJzsW9r4iVXdQ8iEVXbPbVk5eu1KdaGRJPKUwjyMN0VNSGrr/aLJs+/sTYfsioBi1dFtL0qO95WdS+EO6NACgR2B9CJfrrZmJIY+255K2vaK27IN8Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 02:53:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 02:53:23 +0000
Message-ID: <6973890d-3366-0fdb-6306-77a763a979d5@amd.com>
Date:   Sun, 18 Jun 2023 21:53:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/4] cpufreq: intel_pstate: Use the
 acpi_pm_profile_server() symbol
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, viresh.kumar@linaro.org,
        Ray.Huang@amd.com, Deepak.Sharma@amd.com, Wyes.Karny@amd.com,
        gautham.shenoy@amd.com, Sunpeng.Li@amd.com, Xinmei.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230615063333.4030395-1-perry.yuan@amd.com>
 <CAJZ5v0hMEuiv71RoEfyBJ_Z83AvMWXfEvt9kBU2SmZyXvKSx4w@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0hMEuiv71RoEfyBJ_Z83AvMWXfEvt9kBU2SmZyXvKSx4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b015e3-9b0a-4bd6-6714-08db70705905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3MrQ8orTklj5wc56YV893PbS8N7pttKsyNpcvlGeAIlhne4hQ4rZxoHckY5FhgCk82fPwc4409tddjT0ikPH1z8q0jk9RFzEFPJr7ovzkEIsSFySnuUAcywQYE88DCyFVbW0R/34G9G3SFFsjOCgzars59vCnt00QIsShAeF7uIIzN883JTRv3A69Dda43Bqzn3Kwi+ElMfqRFh0dK2/967au/f8MT/ZummjCAyvx9pEH16qkCt+2XGUWfO6SE+nZtVKO8GvcW7LizI8BspidX7s8rU6VFSTg6TfGTv178WPvzNChVf1bWbpEcjc1Ihp+UsX9hHWRbkp1WaZdTJj50EkP3vxP/DmtrdTGZYftqBwr89+L9tIOknkCdgGhacj1FRNYvYYRYP4t4Z90NPnlfAfESMHarsAfrihJKTC7wvaZMsrVZjYDSgSP61WcUjaAw32e7ZmxPQXcNhllRNwrmJUqzVyovaeW+E1A9TtcXl343wKPbhkfd9SvxTPKMckBSOVwRuFxqhGSvKv4jSjrHRLAqd7ZE89bTAMzIlZEilNSRcGPpvOj6ozEY6p6f+yw5srE0IOWfcjVJsmyPcOL/kGG7JhEq1ZKQPFH8zoAfxuTs0gGXh9MUoT4mE/NS0pKC4w0hVH/wEJPeRB5C4uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(2906002)(41300700001)(44832011)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(6486002)(478600001)(83380400001)(186003)(6506007)(6512007)(53546011)(31686004)(2616005)(110136005)(316002)(38100700002)(4326008)(6636002)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZ1RDVFSk9DM1pEQXV1MnYzZk4xeGxnbFB6cWNzNndWdGwreGl3WjIzQWoz?=
 =?utf-8?B?UGJMNjBzdG5CcHRoOC9XcmdEdFN3bFQrLzlqR1lkQkZ1eWIycmlHT0svN0E2?=
 =?utf-8?B?U3Z1eGQrZEI4RlJZdXdndm5PZ3RRUzJUcFZLd0d2Q3JXOFdNaUI5UnZmcVpD?=
 =?utf-8?B?ZW8rNzJ1eitjdlBIYVJoWjQ5QkN0aDlkRzdhY0JWWkE1WEFXNS8ycmtBVHl1?=
 =?utf-8?B?OWpDOEZSa2k3MXFLUkRuNjRSZzdFLzVwd1MySGpzTHdvRzNLc0lUWC94Ymh5?=
 =?utf-8?B?U3piN092cVVkZStieUJZZnk4eFpvMDE3YXpiU0o4ZWNRdEE1dkNXdmxKazRL?=
 =?utf-8?B?VXRDWmo2b0Q5eEFJbjQzZCsvc0ZjZWxSV2QzNkF0NTIxMys3UnJtaGxHc2Nh?=
 =?utf-8?B?R2dOd0pveDd3S21Ea2VUaTYvbHZqZVBQM1RUVlB5WmR4eXV4NkxjNmRiSGJY?=
 =?utf-8?B?Z1dNaW1wcTZxcGdiU2JDYXNOVmpsTGtydHJwaG5mTHJmblRYd01Wb3RMOGwr?=
 =?utf-8?B?QXo4SWs5N1JLOXBWYjNaZWh2QjZuK29TMXNvRUEvNVBPOFhCbEphVGVhTGc0?=
 =?utf-8?B?bVREdmtXZUpRKzg1Y2ZBU29FeFc4OE1vNE1MMXNpK3RBM0dobnVYemNEK3px?=
 =?utf-8?B?cmFlUGRJUWhtNlI3aHNUNnZFQ2RzMXQzdjVRVldyb3lUM2h2d3lBdkNHeC9H?=
 =?utf-8?B?b1RLZEJydHZOU0NXaDZXbktiUUZDMUlqVUR0N3dBSngvWm9LczROa28zWlc5?=
 =?utf-8?B?ZDZYeWx1T3FEL1BxNzVBdlZZREVkYU1XZGFWaytmS0VteTBYaEVvNnREamo0?=
 =?utf-8?B?SUdzdVJGQURTK1NzeTNiV1E4ci80eHE2N2V0ZTYyZzBzVXNtTDB6SWdrODNk?=
 =?utf-8?B?NmRSOEhUcExSZWdXcWdKYTlmZm9KK1FpMXVIYWI4SGhvc2lmSjMzTFBXZUZX?=
 =?utf-8?B?WnhUMVdpeHBPUlJuUFVUSGlSQlc3MVJIUzA5YmNqWkU5SXlSd0ZwRDZpT3h0?=
 =?utf-8?B?WWE3T3M1UkJFZGRseS9nQzVBTkZQT1hkZDdVa083ZFljRmwrTmtGcFZGYmx6?=
 =?utf-8?B?cThxSS9aSTBVeVBIZi9mOUZhUnZqeFVyOXhYaVJlVU40RXhZQ1VVQWVrTTZv?=
 =?utf-8?B?YzVCR0Z0NSt1WnpYT1hPaVJvYktyQk9OYlg0OUYwSXJnMCt0N3NkdVoyUHcv?=
 =?utf-8?B?N0VEVm0yNlpBelE2bGJjVStRSVE0MElhRGtseS9qOVdxMXZsR21VNURZTHdX?=
 =?utf-8?B?MEVKaWQ4NHVYa0FnYUpMdko1MlJGV0Q0YnFnRm5hSVNUZS9MTnRmRWlKTWov?=
 =?utf-8?B?TVp5MzFKa043NWhMbjcwRFNHNFVRM3RqaXlFRzBWOTZmQWszZ3l2dVU3NVNL?=
 =?utf-8?B?bis1VEVMdHJFU1BBdWxxWkRMTkNwTE1IcWt6UjhSKzRPUWZzS3VaSWU3Y28z?=
 =?utf-8?B?c0FBMXYvTEV6UC9IQXVEOUtPSWRuMWRGWmFHZUR5enk2WnBSdDU0Y1hMOEd6?=
 =?utf-8?B?VjdoS2VwSi8vNlNlR2t5azV6RVlSYTlLM2k4U3NEdHZWVHFlVXo1WStqWTZi?=
 =?utf-8?B?VHl6S3VWVjY3M3FVMmV4UUFYU2YxbnNSMjNCSEM4ZzY1REFBNFZXUEJ2UjVv?=
 =?utf-8?B?czhsWDJ0OFNTazRXS0RXMkl5aSs4K2dKSkZxQXdIb003M1FMNDUzYVJoK05M?=
 =?utf-8?B?alc5UmFUSEpocVNHRnpFZEE2QkZwbE00MEZ6MFBpTU5ESnBtYjMxaExENXpa?=
 =?utf-8?B?RzZ5VEJpK3U0V2k2d0s0MDIzdjBSbHE5MVB2aXFDc0tRT1dCbnBzTmt6N3A2?=
 =?utf-8?B?cWo1WkYybUxidXhaTFJHdWlMRURXMVJ6Q1FtZTNRVlg1UUZyU3NCNXdFeG1Z?=
 =?utf-8?B?K3Y2SFVVd1paVHY1bXFDY1lnQTZuNHgvUFgrOS9XcGNMdE94d1pMeEY4bWhx?=
 =?utf-8?B?TmR5NWh1bnpiWWZwZ0xZaVJ4UitpWmd1MEFNRExRVEw2UjV5Zk5EVEI2Nisz?=
 =?utf-8?B?YW9RQStYaWk0cVhXcmxiNzdFZlBMbUM0NDUxaUduKzRqUFFUK1Z2Y3BSQTF4?=
 =?utf-8?B?QVR6cytPWFZGb3djWW5JQ2krS1RYaVRVVzBSS09obE5MaVpqYWo3anlKaHd3?=
 =?utf-8?B?QnFnMy9DQTRuck56U3lFRDFFM1hVRXlJbmYwVENZU2FRWTFzK2RrL1Y1WXAy?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b015e3-9b0a-4bd6-6714-08db70705905
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 02:53:23.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScmRagR17jJJyGXEhsseFfE0mGKG8W+tleky7sRjNYOSIQ8WLDSxP28tLau6S5h05zsBRauRKJsmq0pVeTFjcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 10:57, Rafael J. Wysocki wrote:
> On Thu, Jun 15, 2023 at 8:35 AM Perry Yuan <perry.yuan@amd.com> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Avoid duplication of functionality by using the generic symbol.
>> This does have a functional change that intel-pstate will now
>> match "SOHO server" as well.
> 
> And why do you think that it is a good idea to change this behavior?

The idea was to cover all possible server types. It seemed that it could 
be an oversight that it wasn't included initially.

Is that not the case and it is "intentionally" not including "SOHO server"?

> 
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> ---
>>   drivers/cpufreq/intel_pstate.c | 19 ++++---------------
>>   1 file changed, 4 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 2548ec92faa2..6401338971c7 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -313,18 +313,9 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
>>
>>   #ifdef CONFIG_ACPI
>>
>> -static bool intel_pstate_acpi_pm_profile_server(void)
>> -{
>> -       if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
>> -           acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER)
>> -               return true;
>> -
>> -       return false;
>> -}
>> -
>>   static bool intel_pstate_get_ppc_enable_status(void)
>>   {
>> -       if (intel_pstate_acpi_pm_profile_server())
>> +       if (acpi_pm_profile_server())
>>                  return true;
>>
>>          return acpi_ppc;
>> @@ -481,10 +472,6 @@ static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>>   {
>>   }
>>
>> -static inline bool intel_pstate_acpi_pm_profile_server(void)
>> -{
>> -       return false;
>> -}
>>   #endif /* CONFIG_ACPI */
>>
>>   #ifndef CONFIG_ACPI_CPPC_LIB
>> @@ -2407,8 +2394,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>>                  if (hwp_active) {
>>                          intel_pstate_hwp_enable(cpu);
>>
>> -                       if (intel_pstate_acpi_pm_profile_server())
>> +#ifdef CONFIG_ACPI
>> +                       if (acpi_pm_profile_server())
>>                                  hwp_boost = true;
>> +#endif
>>                  }
>>          } else if (hwp_active) {
>>                  /*
>> --
>> 2.34.1
>>

