Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3875BB0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiIPP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPP6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:58:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E2B514E;
        Fri, 16 Sep 2022 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343898; x=1694879898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yqivP4w3Zoc56KlvA0QO/7RlBp2naUi73D5D7vf/mlU=;
  b=OOu+MEQiTFm8hiQhgDluvh5qofgtaLiQsIHfx9cGFIp3YT1VB49n3J+T
   N86HcJ5zBD6ayAxYfYaNlq0nHJLxjbG8ZTlsohSTarufRbH+iOXJJY71a
   FeOU7RI0g/B51UBzx24dO7NJ9X9izP0NUGfZltqVHskidgbnaksaC5acq
   K9JSDZSIDUu00HdnxvM5hTuvVSPys6Qz7Wow0ROHRZGpGce3niIt+g158
   iZOL/A/IcOIeSLDS2daMMJ57skw3mCPd4JsvAZKXuYqQ/eS7wu3sNUQ/0
   Vp+xg/64F+h7iXBra8ZzMF4UpIY3F5QmLBi3VkjrXhfpsvNviiRPtD8NO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="360759835"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="360759835"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="721467122"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2022 08:58:16 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:58:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:58:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEIT2KK2cgbeT4W23Bf3TJranp0DEaMOAOUDJ5oryo+NcOTbJQm296Mi9X4B7EF0JtWjybgtIb6lEnYlFs/I0gUry2CqbTzk0nl6Ika3qvRX+KSg9LRyhjCfZOSARVYMB3FoehyWRWy5BrWwq9F8YdJYZ40uxrbSvgr6TQRJpR4t4pzXtksvYfjxF+Tt/zvGZ3jJ2+BV1sGKXC2EOY/WDOj+qD2bZsGGPzgRv67lYDIKYuMpSS/ts38mvKSrkrx12y9lJwkcn/745bDGPWm6iHfdTtbG1xYeLjU8fhLZg19r+9zuIK8X0MSNEEyPJnSUjJ+4TEXl1ntIso97q86Bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t9KXs733rHspivMxeKl2zVKbbpQZHZp8bAwGCFARYU=;
 b=dAFgsiWay37iBy/MY3JQFAUT4LY2KMwDgJV6/qqsFfgI2xAKqoKeTdOQrMjCSLC2oRI3bILcR93iXWHUOmFkdn+/tnrJanE0IrPxgrr2lFwXtKysUUex5lNMpec1TW1eI5tJlnPJQeC8p34j0SynZwatxUkv2W1tq51zu7hr64i/qOZahGE8tMXwlQXbqa60ucbqKuYuvbu4rhme8c2zS2WGnHFlUZsYiT6ejT2bAsLY7O+8a9sQ7D9dhhpEBHh0VmcmxCcrq/bX65mTc9SVdq78+gKu1aICsdCjzsEfQuO7wM9AUeiaj6v+78yUh/sqM5y5N8XWp1/3qZo4lmDdMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 15:58:10 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:58:10 +0000
Message-ID: <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
Date:   Fri, 16 Sep 2022 08:58:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: f236d355-75ab-4bce-9c25-08da97fc40b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wD+pkMhdarICbeFXaPLgz0G6i4W2gyPBbLovE+zNiRp8d4PO0nZclFt5OXlxXKe5KcbgpPWGYMDK5hKm3CuQxvNuXbfXTXeOscZRoINlHjYx/J6MUgFTZvp+lkSfAf5wdpTADdnIUan25Nhv1HqbOO8yTMyuiCOvQXY2W5/JkdvHkeqdzKq526hSFE+NLh1tPQ7zsN3h5oBNkC8PTRE3NFpXNWxCPpHEOong9+DBvJIScHVg99x0f2OXsfbtzodRP6XwMnMvOQYkDEH1xu79z/aiDZ+ERCoiQ6gODLE5Q9DgyhNsz6pVgXCi/LqEqDmW8NzW/50+lrRgLL63w5k2kBOUJ4fEKLdq49je/kknCWJdv2eGHpU4/9umwgdpPLSEPX3Y/Xt+9MKS9gQvgpCvDGMFdpu1aDXQ/ATuxmvFuzI01IYcElFF6OnMrSL7wEWnaolhjwS8X0UwVKhDclXVe6z0x+dOSED4H8A6cbMbfSl+/ImFJLaoL/lsLZQffik370ORyfORW9NI/Lj5V41KBvP2VcWsv3KuPvucJy+2SLqGcxxP7D8Tqn+Lu094XH9C8cXE0Q7D1BKS0TKSctKd48bO+JwZSF3ic3+kKgZHsSO0usmeShfIAKK17l2MubMpYwpWrKSqkBw2QfS4Kblz22TEliIduqiVPAulcQvBiYMijz9L32ikqX5qtnEySF047jSobSp4phE8vUSQvw8e6hAvpgN/EMVbOldS87uQtDDsX7sJ2ehrR27zKZf9gr15pqcBBZaKDUOPIz5iOquexXDQJ7ikFJI6jiAqeZUfNWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(26005)(6512007)(41300700001)(6506007)(53546011)(6666004)(31686004)(36756003)(66476007)(66556008)(4326008)(66946007)(31696002)(83380400001)(86362001)(8676002)(82960400001)(8936002)(6486002)(186003)(478600001)(2616005)(38100700002)(44832011)(316002)(2906002)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldQMWlJOWswVStxT3o0R2xUeUFOUkFGbnAzWG9ULzJpNy9uYmkvbVJkaGJl?=
 =?utf-8?B?LzdHZWYzZWlxNnpYYndMYy9JcEhjS1FtNk5qWmVaaDQxV3RzejZja0poMkdL?=
 =?utf-8?B?UFdFYzF6MWhqTDBVZnQ0NjNWUm53OWJEZE5OUTk3SXFZRkdaK1hlc3gyVUxJ?=
 =?utf-8?B?UjRKbWxaSFQ4TEUzTTd0eDd0R3NNR1BxQlIxNEYreGVwNHNsS3NickhBcngz?=
 =?utf-8?B?Y0MvODBEMEdoaFJ4QmZFZXBuZHplLzhkQmVQanVneEJMclBRRmNNUE9CMHNS?=
 =?utf-8?B?ZWdLdGhMWHRBaHNjaVoxanRQQ3hwZXkrYnVnVWJOZkFRQTJ0dk05dzZVTGFq?=
 =?utf-8?B?cnFLQUpnYkE4ZG85L0xONzF3UVRzOFpDODBmdGhEZXFXVzNPR1RpNFQrL0tr?=
 =?utf-8?B?akJZbXh2VDZBWWpiak03UlZqOTQwYTU3S1lqMFJvWVRUclRBMlZnY2crZjlQ?=
 =?utf-8?B?SlFKSmxNUnB1WDVWNjVWWU5lVlVMUnJrcmRBeVdPcmtnVU5wcnJCL1JrYXor?=
 =?utf-8?B?UzJkaXh3L3FydGVDVWxDWDMzU0ZQejZ3d3dGN3NKSi90eDJVNGhUaEQ1Y2Zs?=
 =?utf-8?B?UXFWNlFmd2J2YXZ3WnMxbUd5a0RaaUJVdTZRTW80cHNFdENYZXE0MHhBMXBW?=
 =?utf-8?B?NUZ6L2RHSnZsU3NZNGQ4RUJ0dGpET1NnYnRHdG05aGlHM3dXQkpleXB6OElW?=
 =?utf-8?B?alk5RURTMzJKdHV1VGVoOGhIY1RUVy9HZllieEN4QWFGbmU2YmJiRkZnTXRo?=
 =?utf-8?B?Ti9nRjNYN2E0Uys4QmRoaThTV2hJS0twOXlpdVhwRWkvd0c2eFdBV0M0SDNu?=
 =?utf-8?B?Tkc3SlZFQ0VrZnRxSVJoUUpLKzdHMjUvVEltUEtQUUMwYWs5a2I2aHBJRnNx?=
 =?utf-8?B?RWpER2dYdnN4UlN4RE5GYWkxQVZwNis4NWh0K2c0OW5zelFKa0tuaWpMb1BL?=
 =?utf-8?B?dDFyNGRVRVR0Zm9FTW8wcm9TaXBQQU1pTXJ1UzhrS21DRXZPZWNDWDV3OUxm?=
 =?utf-8?B?YnZPd3FSa0tqelZiNWlvNkFBZXNoY3RhN0pVTm9sbitkZUlMOUxzdGJ5MUtk?=
 =?utf-8?B?YmFjZFhyVFFoNnZMYm5weWxLTmFtUkVZZmVCM2tvdXhsRGl4bzBsVGVyYWJr?=
 =?utf-8?B?TlQzekcvTyt6Mms5RENNc3hXaW1VV1A2bi9McHQyVU1nZGlVaXU2cC9oS3ZF?=
 =?utf-8?B?M1RGZ0Zteno2cDl1bGRWc2gyTHZHT0VITkp6STJ3eDcwVFN5SXg5ek9CRTI5?=
 =?utf-8?B?SGJYQ2Y2ZG5iU2lhR3J1V25VTFdycVVCNk5HUnM2T1llU0grWmJYaFlUU0lV?=
 =?utf-8?B?ODNxRFlDbWdDSXBtYUczMXBBQVp3VTU4VHRFdVE3N2ZUclRBQWNDREh2a09j?=
 =?utf-8?B?ZlhJcE00VTlaN1ZRd24vSU1vSGhkb3dTZmRYcDduc3pPTmdROWM0WVBtc0px?=
 =?utf-8?B?TDNscURnelhKS3FYTlAvUEp4RzY4WGtUVkZVRzJyU2YyWk9sRU9pRVVJN2Ja?=
 =?utf-8?B?aU5vY1pYeDJIOUw2MWpXTzhhR3B4aXhaenRnUUJ1WTVQbjJ5UlV6WkYxYjRt?=
 =?utf-8?B?N2YwbDgyb3h6K3RFUDREQUFqVXVEUUhEbTFPN0VqZzVmbkp5QXMvVTM2V2Fh?=
 =?utf-8?B?UHQrU1J4U2g5aW16UklzTTI4UmtVYlZCL0RvaFlIK3hsVUZCeExMMFY1cGE0?=
 =?utf-8?B?VEI3bDJPVGJCKzNCUXM4U3RUaDd2aWV1MHRRWWY2TXh1NzF6NzlZMHRXV1Nk?=
 =?utf-8?B?Qjl3R3k5N0hjcklaZjVVb0U2QmxWUldNT2ptT0NuaWl2VnF5bXR4QTdtbWdz?=
 =?utf-8?B?enlPeU9wZ2I4VDNXUjZ3VWYxVmtQMkpDWGhXMDVVUW0rR0tTODh0RTdtREtq?=
 =?utf-8?B?dUtlSkRCV0J1eTNTMzlRcmk5TkR0OEJ4Vm1VVHhLeHlxakpKdWhlYmFLSzlV?=
 =?utf-8?B?Q0FoS0ZXekU3NnUwWUJHOVhycTNUMlVucmxkWWx5RGgwOUJIWVg1ZmlsdzFp?=
 =?utf-8?B?aWsyVVR4TjM2eDhZK1V0L1dBTVk4bzRNMlRmVE9rcFlsUDBYM2lpSFluNW84?=
 =?utf-8?B?MXlmZEdRVit1em42SjFEMEc5QmFHRzdUWWp2T2YxRjBmM25UY3MzWHhoWndK?=
 =?utf-8?B?UkZXQ2RtMjlZeTJwR1FLb2JuU0N3a1IybGR5T1BwS0hmYjN6L3JDUENpQnZB?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f236d355-75ab-4bce-9c25-08da97fc40b7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:58:10.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f8+wNo8WqdtrVS1MaDmPqa52tHVrwqrjA/B0DIJrDjU3yTul+iOzeO15onj+Mnzd4o8h2Cvbh5xHk7nJvt2LUN+1BekOmbnQSBd8jz/zt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:01 AM, Babu Moger wrote:
> Add two new sysfs files to read/write the event configuration if
> the feature Bandwidth Monitoring Event Configuration (BMEC) is
> supported. The file mbm_local_config is for the configuration
> of the event mbm_local_bytes and the file mbm_total_config is
> for the configuration of mbm_total_bytes.
> 
> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
> 
> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
> 

This patch makes the mbm*config files per monitor group. Looking
ahead at later patches how the configuration is set it is not clear
to me that this is the right place for these configuration files.

Looking ahead to patch 10 there is neither rmid nor closid within
the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes
the bits indicating what access types needs to be counted. Also
in patch 10 I understand that the scope of this register is per L3 cache
domain.

Considering this, why is the sysfs file associated with each
monitor group?

For example, consider the following scenario:
# cd /sys/fs/resctrl
# mkdir g2
# mkdir mon_groups/m1
# mkdir mon_groups/m2
# find . | grep mbm_local_config
./mon_data/mon_L3_00/mbm_local_config
./mon_data/mon_L3_01/mbm_local_config
./g2/mon_data/mon_L3_00/mbm_local_config
./g2/mon_data/mon_L3_01/mbm_local_config
./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config


From what I understand, the following sysfs files are
associated with cache domain #0 and thus writing to any of these
files would change the same configuration:
./mon_data/mon_L3_00/mbm_local_config
./g2/mon_data/mon_L3_00/mbm_local_config
./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config

Could you please correct me where I am wrong?


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   40 ++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f55a693fa958..da11fdad204d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -254,6 +254,10 @@ static const struct kernfs_ops kf_mondata_ops = {
>  	.seq_show		= rdtgroup_mondata_show,
>  };
>  
> +static const struct kernfs_ops kf_mondata_config_ops = {
> +	.atomic_write_len       = PAGE_SIZE,
> +};
> +

Please use coding style (tabs vs spaces) that is consistent with area
you are contributing to.

>  static bool is_cpu_list(struct kernfs_open_file *of)
>  {
>  	struct rftype *rft = of->kn->priv;
> @@ -2478,24 +2482,40 @@ static struct file_system_type rdt_fs_type = {
>  	.kill_sb		= rdt_kill_sb,
>  };
>  
> -static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
> +static int mon_addfile(struct kernfs_node *parent_kn, struct mon_evt *mevt,
>  		       void *priv)
>  {
> -	struct kernfs_node *kn;
> +	struct kernfs_node *kn_evt, *kn_evt_config;
>  	int ret = 0;
>  
> -	kn = __kernfs_create_file(parent_kn, name, 0444,
> -				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> -				  &kf_mondata_ops, priv, NULL, NULL);
> -	if (IS_ERR(kn))
> -		return PTR_ERR(kn);
> +	kn_evt = __kernfs_create_file(parent_kn, mevt->name, 0444,
> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> +			&kf_mondata_ops, priv, NULL, NULL);

Please run your series through checkpatch (alignment issue above)

> +	if (IS_ERR(kn_evt))
> +		return PTR_ERR(kn_evt);
>  
> -	ret = rdtgroup_kn_set_ugid(kn);
> +	ret = rdtgroup_kn_set_ugid(kn_evt);
>  	if (ret) {
> -		kernfs_remove(kn);
> +		kernfs_remove(kn_evt);
>  		return ret;
>  	}
>  
> +	if (mevt->configurable) {
> +		kn_evt_config = __kernfs_create_file(parent_kn,
> +				mevt->config_name, 0644,
> +				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
> +				&kf_mondata_config_ops, priv, NULL, NULL);
> +		if (IS_ERR(kn_evt_config))
> +			return PTR_ERR(kn_evt_config);
> +

Since an error is returned here it seems that some cleanup (kn_evt) is missing?


> +		ret = rdtgroup_kn_set_ugid(kn_evt_config);
> +		if (ret) {
> +			kernfs_remove(kn_evt_config);
> +			kernfs_remove(kn_evt);
> +			return ret;
> +		}
> +	}
> +
>  	return ret;
>  }
>  

Reinette
