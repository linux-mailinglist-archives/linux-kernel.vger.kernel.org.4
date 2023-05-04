Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A46F7309
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEDTKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjEDTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:09:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744229EF7;
        Thu,  4 May 2023 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227313; x=1714763313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=916AoznbNqbR3px1QZPFh5mQaPniqYvgQLqivdnk4qs=;
  b=Y5CqWiv4T1QYktNEv2rlsIUfAzfbuZf0+mosRkLqp4VgB1P1TNMWkh7E
   bPJgPL37TYvHo1uB/+E+TdTWsevs555a1BI1zkcxiUlqOW99aSg7sFrDk
   k0JvCs+AQhj0yk3LcEZL35GweSaKV5NafkzrQTLQuTxFBb9O5fd1e9Wf2
   jGrk0Ig8vncmeziuRp/3EH1Jv0UF8UEwL0q9n3wbpyDJntOPluh/eyz28
   8VdWPGsyaQ1x+2Y08qzUtJosSH7A4X1hAioteWWtIrpcEf6AhRsXcgLd5
   RZeNZFLFcVD+vjp6xFZDGZeqjocLBTTdovdORjdoV+oUsp8CQ/4UjBpN/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351155739"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="351155739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 12:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841306999"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841306999"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2023 12:03:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:03:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 12:03:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 12:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6SkC7j5x69bT5Wnlp71Y+pFSoFCCnTYgAnRjhO720kxaw3vLoMP6RkH9WI+FquVHGfY7uslVwbZqNzPTNWwCV9WhL/8XjSxGM8buuupgiYZdfGy1DEZ9CN7pGcrHMty65aXcdg+U8S8WF4MYxHJyWgbopzLiBBaZOHjG07b950F912aHW+JPmgaIGPtaHUPbh3ZXGKXTmtGnJgXfN5FhKsR/35hi9ohOZLfehyB8c2yTeuTWXC+VZW1BS0s1fsSj6UnZuRA/6dRqZ3IslGNlM+b/xPySqc2rfhGcTEAV8H3zpdTd0T+j/1WVb2z3j3UrOROpJB8MYCtHOgCwfcfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOgnCm8QGDykO3G4Yeit4u7Pw+VdijkKJkVaHmQWguo=;
 b=mM6xEe5mwBCK/9awZWJf/+hAUzh0sC4PAz0tQCOgbizNiGKGAEdaLLZWcJpW7BfbyGmNuWxsSEtPVekv03xXJc9veAbcaN6rbL+adPqzIlVhzbZYH59C2GIaZdnFhCe+ONb+WR0Jl2tsv9G1koH2YFoBn86Os8lElT/dFNitaJrfyu+/oKqppNVYvl3rPrcxPAMQJg4OxK+0RIfaKQySWYhNIQs8QDf3HwWHCS8QBxvZM5Ynmm93wj6zilkpJR3qXOUFymYc5stuYw9iKrKytOwSPOnlM1AOOJUaJHH1pnto2rWdLSXGC5u5gySznhpHHSOshUzGqI1nzF1qgHWh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Thu, 4 May
 2023 19:02:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 19:02:40 +0000
Message-ID: <584e5928-058b-b9ae-f548-ca224323af81@intel.com>
Date:   Thu, 4 May 2023 12:02:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 5/7] x86/resctrl: Introduce "-o debug" mount option
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177448739.1758847.17451432454091802068.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177448739.1758847.17451432454091802068.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: af93c561-6533-40f3-224f-08db4cd2223b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbkzZIROQyrBJ4LNRn7oYrykHerZhmb0zGNGFgaKp/xL57XtH4wen8+S0VpVymEl0Ah4ZYZZTGqR7RwLz61Wox9HM2KG3IUxWdWkA5i7eU+8+KtkA9gp6SjZ91RsVPL59QR+V6af4zwMTpjxEY4dACMxScoDv5ztHzPAhaUjq2qy9cr8yGW1fGCs4C3Ndey+eK1rB5LfAGl3xnQB9xweNBfpzSQIHQTTQxo7lU/Q4wxY0Eyd/8vKU16DZYCMyhUO8xWA9gwI5uDbBvRyOYmK5/Xs59HUKDQjh54rV6Yx3i/eab8ft5lvDf9GpYFWc4JviSHvlexQJBxWSFPrnnxwc49wEo0+iEfZP0fJ27rjDZ3nxvBt/UcdZ3LYDoZ+PmspYpXystOtkQeqZRd1M5d0OzMJfETOWxNphgcndGsXZLROE9y4wuPjcJJDDj8ebVmr7v1QhVW1nb1myC+NIQH+pdaP550CRLX+d81P0ZjIC0tz0FSje+NV5IiOUZmsERR7WS3bP1Log7dUfXzd2jliNNn8qeUP12ik40MMeCG0fZ8BEih01GbppYnunvTlMrMTiFpiSJAtLz/v923B3s4ensX0HthCk6EJ3fdv2keltADuLPKlrdNsfZ6ICR8tVGf94NKubTj6RWcp4Dsm0hbYxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(6666004)(36756003)(31686004)(41300700001)(44832011)(6506007)(186003)(6512007)(316002)(66476007)(66556008)(5660300002)(4326008)(7416002)(8676002)(7406005)(8936002)(478600001)(66946007)(2906002)(86362001)(4744005)(31696002)(26005)(82960400001)(38100700002)(6486002)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0V5dkJydWpabG0yQVNCQW10ajMwYUs3dXBjZ3RXMERWZnhEWERlSDhlQysv?=
 =?utf-8?B?TlZxdzAzZFI1aGtZOG0wOHc0OVJEcVNhVjhhUXhVV3luSERBZEttQnBLUU1z?=
 =?utf-8?B?Tm50aVlFMXV6cXBTRk1tbXFRSkZ0b0ZhV1o1bWZORHpHaVUwVmJyWW52Rld2?=
 =?utf-8?B?aUh5M3BZZGZtY2I5YlJoSzd6MTRCM0RrKy9vc3Jna1E4b00xWTBOMVlJN0hQ?=
 =?utf-8?B?dlVoNGpFQVBNZjhvT2VGRXpWdkdoSklwZWQvY1ZZbkhaSTJ5R0VlQ1VvR2xt?=
 =?utf-8?B?KzV5NlcrTDNxMTU3T1luR0oyRUg0QUZUcmpaNXpHMjh2TVRpcVI5N0VJTGVh?=
 =?utf-8?B?bGY0ZjhNQWZQRUtQblBkRkpWbHI5M0l0ZDRqUnAyckhSN0I3WTJpaEpPbXRp?=
 =?utf-8?B?ajBFcFBqNjJNdEg4VVAwNUdLdWlpT214TzBydzBndGFjR2hobEFqZ2VUamNu?=
 =?utf-8?B?MTdZZ2VSUVlhakJoc3hPM2NVbHhGenhHMU1SeGw1V0FTZE04YTV2T0ZNYjBt?=
 =?utf-8?B?Y29tYzdzY3lxdXRYM3lpNER3TDhaSFdvNXJvdXplMUJ3akwxUmVUdUFYYng4?=
 =?utf-8?B?cDU2Z3o0SVMweERHVUcwSzhJMGQ3YXNBMzAwekhiQ1A2UGlpS0FvNExQeS85?=
 =?utf-8?B?ZDZsVWtRVTlETldZd3EyUk53K3lIVmNQL2ROVEVUQmdtcXBKeko1WlNSemNZ?=
 =?utf-8?B?OTl3U3FHMXZnRWNSQzU2T01yd0N0NEo2ZGQyZU9SbUxqZStSNmNpdEVyckE0?=
 =?utf-8?B?Nk0vLzFMVFN1bTY1ZDNBMitwdWRoVSs2R0pRTWNjelpuM3QyUXhFZXlVSEh4?=
 =?utf-8?B?TjNRZEgzNWpMd2pocllubzIxT2dLVjVUNTVvbkkyN056UUE0akNqU1RBZDVx?=
 =?utf-8?B?S3JtSjlHeTg3OUgyNElmQlltOFdJV3VFQ2JUQ0FRWStWVzZhZEdUNGNmVXNv?=
 =?utf-8?B?b1hpbDJEaS9va2FCSU9RVTI5dytsdjBqOGk5SHVrL3IveXVtTGJjQ2pYVDVk?=
 =?utf-8?B?bW9DVlBGVVk0a1FKZzFkeXYwaWEzUXJhZUIvNXluZWpwWTE4RVRnT1BtSWtr?=
 =?utf-8?B?ajhrV3BOV2JETTNPbEFRMllyNDc3cHc1cmliYzZmNi93S2tDc3JCTlZNSkRs?=
 =?utf-8?B?eW5hK29iazNpbEpDM1c0SDYvUEJCYTFMUCsxeE8vQUNQOUdFUW9xQWhGR24w?=
 =?utf-8?B?VEh2eXEwY1lIZGswOFJDZ28rSUh1WWlPWHJTbHZNY3E4aHVqR2pMbGY0NE4z?=
 =?utf-8?B?Z3dTY0Q1aEZBOWQ4STByQnJmVTNlellGeEVpYWpZL1VjTk1IQlRrS21qNFp5?=
 =?utf-8?B?anJhN1VIa1k3ZVBCRlBsMXV0dCsrdmtERG5zTGtXSk9nQVNJdzVCaUh4Zjl3?=
 =?utf-8?B?VnB1SmlPbXMyR0N3eXR1WjRqUEUxUm9iR2RCa1MwNXQ0bFphRDlweksxK29C?=
 =?utf-8?B?Ti9jUmdvci8yTk9wdGNqUysvaU1oYmdIbi9WaENnZGk2QlFVT0kwTHJ1bHY0?=
 =?utf-8?B?bFVLZ29LUUwvYUh0SXJtVDQvUXhTR2d1WDllK3VsYVlRb2tZY3JIYjB3d2lW?=
 =?utf-8?B?ck5zZHFqNnZhZ1ZiQi9ZTnlPSUtENnM1SzlXNjZUVklUbDNmSFJHc1ZOeGt2?=
 =?utf-8?B?ZWdUSXBLZ0VQeHhMNVN3MGdRRFlXKzFyaVRqaitMcHJaYkcwYktlMXlyNVIr?=
 =?utf-8?B?RlV1ejY2c0tKZzF3bkhoY1BWQmlaZC9CYi85NzZNNmduUlkwc2ovc3RNM1hq?=
 =?utf-8?B?V2draUJ1dG9GL0RpSUlTRUZGbThsSXR0d1NzU1lxR3VVVUxjSUJKU1FrVUxa?=
 =?utf-8?B?ODByUGh6dVZDU2dZUVBRWkpMTlhMZHhYMjBFMXpuNXUzNmp1aE9HaHpjcldx?=
 =?utf-8?B?RGNwa0tSZDU5UWpndGNkMTFqN05Pa3hFS0UzSnViTmkyR2gvK2NhUHhyL2RC?=
 =?utf-8?B?ZjlNWHBHV3h0ckduZGplZ1kxUDJWZnh2cVNYU2Y2bkkzMzQrUFZOSVQ2MW9X?=
 =?utf-8?B?SjZhSzVjcHNTMmZVdXM0cXNvOE56TnhONDdZNzQybkMrN01Fd0pOT0l0Rjhy?=
 =?utf-8?B?NTZ3cUROWGFaYVZEL0hzdjFPWDB5WDBwSWtWRUtvUjBHU045SFNOUUhFa1Vh?=
 =?utf-8?B?M1ZuU3hMMVBUUExaVlQ3Mm1HQUtZMlRPR0RsQWNmZm5pVlREM2lweE8yYytY?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af93c561-6533-40f3-224f-08db4cd2223b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 19:02:40.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qja59/z1j1Z4OXEK5XabwW5TNEhRbOHHMNGwlB5xjpgSHEw8SFl/b3tSqlOI+QIwmjuEQCi0X3Gq6dkKEbDZe59Pjl4GOjHXnbmCKoLfKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> Add "-o debug" option to mount resctrl filesystem in debug mode.
> Debug option adds the files for debug purposes.
> 

Could this changelog please be expanded to explain what "debug mode"
is, why is it necessary, and what will it be used for?

The changelog mentions "adds the files for debug purposes" but does
not explain what is meant by "the files" nor what these
files may look like or what "debug purposes" may be.

Reinette
