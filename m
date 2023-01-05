Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A565F07A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjAEPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjAEPty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:49:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3575E0BA;
        Thu,  5 Jan 2023 07:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBAz+M5RA8O2tYS/SN4hBSQ5nlFJ/Y/WxsuaSKwLzvFLtCiJXL343E+5ULc8nTN08MdBA59p8pQGCGobzCkX9tWGv66T79jOSp69MHi1l+EwLeMSpWmyh8rp6O6KaGtLc9wmNngu+Szj7ckm+9ikHxn10Y4Ml81csjEgw6hpw6c0pdsBw5LZvUDRvLQfaikaIUP4V8rBS8cCoZGiPz3YB6mfYbMxgKOI5z39L6+wbRahckOBc7v41mquzmlvlfdV6xXqGZYgr9fuQASCcD6M7K0Nc4rgyxkl9b+9Qu5nd6zhJFNDyHDRJqYoiSf0a4061NtT+YuxKK0jwV9MJXgjmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtk5vQJ5Shf1v93Fe1E/5BtT161N/AybVB56KUE4oww=;
 b=QiM4HNze+gIi7i4f9+rsw7wzsis1a4UuUnZUEtOcBM39Mp/P8UXOtih+nLaKzMNipqG7q4GDQmC4A5ujFrSaSKZXv8g1cqXQ61WMtJe7jhzL0FolCBXzsh/54l9oO9ZTOzYr3u/itbciokNz8de2cWXd+/ckfHF89TZW8smq9nVsZ3r0enkxPHU+3MRPkUajTD5tlTP5845BUcVG8viXhecZZuR00YJZMwiEu5tVEBT4bBSlpnnhMk9eEWOC/fba1dHTP8rUcA2KdwTmgr+1hwtHF81KYC3eDANnxujoRjjdMDRlMwT60qEGs0HsLv634ncY+0GsvUG4IM8ctukAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtk5vQJ5Shf1v93Fe1E/5BtT161N/AybVB56KUE4oww=;
 b=TFXK5BrRH+2YVwBeKRK86eieVU7h+gwGL/0mBB8rlO31kBv9dMP++T/BDOgOIpbunoAstku+n77dHMFFAzSAACwWDdlizaB+W1SXYHHw3+RQLxSdlSWMXB+67i6g3G/hPlN9d7W+WsIPZ+v6I1iep+/XzrFn1REbMkWXMN9dNHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:49:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:49:45 +0000
Message-ID: <c89c0ad0-f7c2-fd56-d705-8aa9445af832@amd.com>
Date:   Thu, 5 Jan 2023 09:49:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 09/13] x86/resctrl: Add interface to read
 mbm_total_bytes_config
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-10-babu.moger@amd.com>
 <384d8a08-ec31-dceb-bb4c-f785a6418fbd@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <384d8a08-ec31-dceb-bb4c-f785a6418fbd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:4e::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: e84215cf-b8cb-43d9-5d35-08daef347775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+Ox4DhP0bie5sOpLPi/CLY7kMBBI6lGVa+t7hHnWUe1WSmUptrZBzc6vFxO+b7KMucXs6kxJNlwGM9C1fgxZ0V4cACXxUaYVWr7Pu+9Kbam/o3qG7/gtQM3aRQ2qTAZmErrxWH0q5ybeC6iE4AdX1AtCRvSW1/ApexqcyaAt7AuLG/UVofED8iYbYokqkkxXKI8nsz+xQDJOhcdyx1WtjGGirhSAlN8l1FxPrjT/A+0S5XhermSmbpy6FIX+TcRkfPveBZETepu7qKfNUcFYBD3NTu5dtBQRmhGtFPeHS9vE9ULeSLDyO0SDCYbpifQraF3cH4BK7q6I3YSkuWSYJJKZotnIf1J1DYdxgiFuLnAv9weh+mr+vFM6CLb7G73lhkR49Y/qvbZmVSxiorluhcA0ZogXrwS1TY3rW89WLuaXhwKSavO7u+HcW+40Qm6RIv5H+LaJyHBzXT/a3COiH3ygulAXWzFNyL0hGkXGnOK5a0p0XmjOw+yRq8tSbZRA6eydMXeLcCAirj0orzL4Vx28KJ99PgAtcYwy5yUe1H01leuxSsVK+Jx5zdGB0kAlHElkhTipkrwAnMKVESIi/HI/Zx9BaxsJkP9BAy07aBKeKvBecZVi/nUKJDJo/Z2iblwB+BbJmrmbuMAUFg+dJchbr/7C6ssBZPg9KVN2KM2Y3kV9YMFs3hjPJFriyDnjt6MUsPqrk5clxDmaVgV/hbd/1rmGXJjaf6mqa6MxOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(2616005)(66476007)(4326008)(66946007)(8676002)(36756003)(41300700001)(66556008)(316002)(31696002)(2906002)(86362001)(3450700001)(5660300002)(38100700002)(8936002)(6506007)(478600001)(53546011)(26005)(7406005)(6666004)(6512007)(186003)(6486002)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdGSVQ1Z2RiUUlMZDNFdzMzdUQ1UlVRc2p2OTF5cXhVNEpOTHNDeksxTFRt?=
 =?utf-8?B?YzgzN0hLdUYyc1ZRUXA0Y3A1T2hDeFBjRk1LSitOcVVKWEI5clUxVUI2OE5F?=
 =?utf-8?B?bG80MjRIT0FlT21sWjZqNzF3QXFvZXBuL1BjUnNHS3B1cW1aYzNCSlNyZHFD?=
 =?utf-8?B?MC83YzVLNFVDdzczQncrK0R5RGNNV3c4SE5YakZ1T0dKUjltajZ2cm04SWRK?=
 =?utf-8?B?Y2xPZkF0dUZiUk4yUDYvbjEzS3RScXUyTG5zOGRPa1g1cW1BUkZNUEFkWGFF?=
 =?utf-8?B?NGZrZGM1NWtSYW5jLzYrME5lVFFXcHJHWis5S09mSU9vWHRlNHhBOHlnQlZW?=
 =?utf-8?B?QWVsU1dSWXFlSWJtSDBtVEtsWXlRbXlTUFRpS2JBUzNKT0dzazdsTW1NZFYx?=
 =?utf-8?B?aGRnZkswR3JxaWsyRS94YUk0ME1CZlNzMVRjYzMwbVV0cUFJS09NQlA4ZjJ6?=
 =?utf-8?B?b3JaMzY1YkdFRE1MRGx6VVNQZEZqVDNLSkpEZmdVQVZXUURGaVp6SlBJYS9x?=
 =?utf-8?B?SFFjSE5uT1RUekJxWHZ6LytZMnRkSy9mcWEwSVQzQ2hxL3psNDVtbFhaaFo1?=
 =?utf-8?B?SzBqYldBUkEvaHpKTVZ3UHlUV1d6QnZIbm1sM29nZlVaMDExQk5pSU0yVXdV?=
 =?utf-8?B?akNmbE05aEFkbTY4N01iOGdOcDBzLzdwZnhFdXg5SmtHRk9ydGtmU2JXUnFH?=
 =?utf-8?B?OEU4MkI5ZmNtOUROMCt3cU1najl5V1QrTHArV3kvVFF4T3dDVjRWZUx3MXd2?=
 =?utf-8?B?YVBheWZMVTN2QzA4NDVUVTBMUVVUcGNZRDhnWHNaMGdRR1lpb24rYlhESTNi?=
 =?utf-8?B?VHZpajBmVVU1ZVBJYzk1Y1VTWEF4dVlKbW00MitrbnNHTlFUZ0tOODJMNG9u?=
 =?utf-8?B?TXd0NXdPcU5KQ2Vjd21jRUxsclorZzdZZVJ2NXNid0JTNVJRTzBtbE5RV3B1?=
 =?utf-8?B?a05VaDgrSnhPWDVCb3loalRSZFBpQlZiVDJQcVVnL2NBRFRpUk9WMTAvNDhq?=
 =?utf-8?B?WVVkN0VkSjF4Z29DbmFxMjRNR0poSjB4cXo2VXlPUUFpQzlzMXZkNXhDalhh?=
 =?utf-8?B?OEhtc2Q2aVBVa29CK1RKQnNGQitLbWcycFlXV1dPNHEzZEpOa3ZkWWxVT0Vq?=
 =?utf-8?B?K3IxN0dNVEphWktidWRuQmtJbGdNMG4yb2JJZ0ZBMjE0L3BBRkEzZkptcmpi?=
 =?utf-8?B?Wkx4YWFqM2lIaWZkVHBDL2NUdmVUaEFNYXRHTXNXVXNSME9ySmF1bVBxM3VF?=
 =?utf-8?B?SGFOUHNVWncyZzl3TGZtVjNZVU5ZVS9ocndETTJ2YnBkTERkK1U3VTduSGVH?=
 =?utf-8?B?SnpRYTUwSk1hSzFxMG5XYWtaRFk0VlAxcll5eTFzRmU1eUhjc1M1S2ZiSWQv?=
 =?utf-8?B?TDF5UENNSGtQMEpIL3hSL3hUVUJMQ1RJV2pKNGNjcDhBNUpWR1pMNFZiaTZK?=
 =?utf-8?B?RXNLVWkrbXBZZDJvcjE5UlN4NEZneTdlY25LNmhKQzNGazlPditrRUYrODhM?=
 =?utf-8?B?b0JIeDRvV2gzaXB4RzFDZVhkUk5mcnhlaHRUcEtqd1NjRlMvQXVURW1iTnRW?=
 =?utf-8?B?dHZtVThRa1BCVk45elFOUHVYV3FhcklnV3VBR2NFWGkveHZ5NjRuTkhjVnNM?=
 =?utf-8?B?UDMxOHkraDZyUlBzU3MzUE1PWlU2Szl6SmN0NzFBblBnWGRaTW9uMW1DU2to?=
 =?utf-8?B?OGxJejVEQThiZ3JXMS9zVjI1U3pkRkdBQ0RYTlRnUWQ0ek5DSitJbzAyS1pF?=
 =?utf-8?B?TmIrT053dE53YWZxUEV0MitFSE8rWjh2R2ZtNktzRjFMU0xLK0V0OFZZdXI5?=
 =?utf-8?B?OXJKYXVlRFVpbGFURkZ1NDlIelc0KzdKM2RSY1hhb1AvZTNMVXVVbmRyN2tZ?=
 =?utf-8?B?QzJMQUtua1J3MjRNUU5jWW4zT0ZKS0VjeGs5b1lGTHRta3Y0ZWg4U1lhVkFU?=
 =?utf-8?B?bVJhQitoZjBVR1E2MWRVMjRjMllJSHF1Mjl2bHFKZ3MxdFJVNmN4RGZyUHkr?=
 =?utf-8?B?UDU0TDFvREJHaml6dE8wZjlZMW1TVWExT2pHUG9Xem1ZNE02cEEvK1FvRGJW?=
 =?utf-8?B?Nzhsb0JYSTNrY2VDanZWbEU5aXZLNkdkckczb1BvVjZ1NlRWNXp1bm1vcTJW?=
 =?utf-8?Q?ToGc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84215cf-b8cb-43d9-5d35-08daef347775
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:49:45.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctJSM207K++bqgyepBrObT+HrPkVzcmEhCLT7Klw9MeIxRzdXqI83FDdVM7Wdy6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/4/23 18:29, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/22/2022 3:31 PM, Babu Moger wrote:
>> The event configuration can be viewed by the user by reading the
>> configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
>> The event configuration settings are domain specific and will affect all
>> the CPUs in the domain.
>>
>> Following are the types of events supported:
>> ====  ===========================================================
>> Bits   Description
>> ====  ===========================================================
>> 6      Dirty Victims from the QOS domain to all types of memory
>> 5      Reads to slow memory in the non-local NUMA domain
>> 4      Reads to slow memory in the local NUMA domain
>> 3      Non-temporal writes to non-local NUMA domain
>> 2      Non-temporal writes to local NUMA domain
>> 1      Reads to memory in the non-local NUMA domain
>> 0      Reads to memory in the local NUMA domain
>> ====  ===========================================================
>>
>> By default, the mbm_total_bytes_config is set to 0x7f to count all the
>> event types.
>>
>> For example:
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
>>
>>     In this case, the event mbm_total_bytes is configured with 0x7f on
>>     domains 0 to 3.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ...
>
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -30,6 +30,29 @@
>>   */
>>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>>  
>> +/* Reads to Local DRAM Memory */
>> +#define READS_TO_LOCAL_MEM		BIT(0)
>> +
>> +/* Reads to Remote DRAM Memory */
>> +#define READS_TO_REMOTE_MEM		BIT(1)
>> +
>> +/* Non-Temporal Writes to Local Memory */
>> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
>> +
>> +/* Non-Temporal Writes to Remote Memory */
>> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
>> +
>> +/* Reads to Local Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_LOCAL_S_MEM		BIT(4)
>> +
>> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
>> +#define READS_TO_REMOTE_S_MEM		BIT(5)
>> +
>> +/* Dirty Victims to All Types of Memory */
>> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
> Some stray white space above.
Sure.
>
>> +
>> +/* Max event bits supported */
>> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>>  
>>  struct rdt_fs_context {
>>  	struct kernfs_fs_context	kfc;
> Please remove stray white space. With that:
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks

Babu

>
> Reinette
>
>
-- 
Thanks
Babu Moger

