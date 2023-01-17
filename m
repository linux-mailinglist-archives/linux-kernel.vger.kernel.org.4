Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A566D732
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjAQHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjAQHrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:47:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B232244BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673941643; x=1705477643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFNjn0V6NQlopCaF8xibTUZCm3t0/YFIlHOG+78/CxI=;
  b=jGsdTEskHKT5tEMvc2YHKs5aAQgjfxciISAO2Hk6t11Ef4RkIsXSB+OJ
   bhEo3Wr5Rokusj4+iqo3Snnn5aAg+rclSlHq6whmhyketLzxqrVtsciee
   ZOALL5XQjAMNvgRnU0TjaKbCb28aGj0vSG/TQQGramR7yfLNci/Q//hJs
   qwSI+ZFOU3o5iRHgJgyfGcVc2a3MSuL3UqWIeUlUxmpwtyAwT/Y6ScKSZ
   7QE64aHh8YwR3D045rRveu5g+yu2QfueaV9WWZvNI7VlUsXdYZYInjX/j
   MLROJArzB+hAH83yj3AYSPHDR62MSdAeVvfEziRJaBHQUg/yi41oVXHTy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="305007101"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="305007101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689708383"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="689708383"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2023 23:47:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 23:47:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 23:47:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 16 Jan 2023 23:47:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMoMs2iFzSI4b051eivlyutBoIsK/2ASoQkcbArbHYFVMGtaHtHBTe0UwGKiY1XauNNK7OGyzt9ZZe0h+dtOccNbFQIDnkJTEQJWYYkPGuTi9Zf5D0uF2MvUOTH1Cz3T+XEnZg1MJUk0XWK8U3S9yEnYLqD225NQx2woFY7IGYae9MLjcTPRF8Uj8XK/0kR0rtdPqLcfpf8xHbPcBIJYWgegDV7Z/vgjlrAYhcbDsj69SFCD2nEVmnC/HXTr0F0AzlwjMk1skib4Xnqbo95ndy8qDfEubAweICUVoWZp9d1RWhvS1K0uT3WYOLymhKlFcTsK7DnaodD+a18OmSPHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zb5zDv15o4VDYgDHfoHxHFBsirNOYiUQ1k5d1QjHbQ=;
 b=ecnVV+CWAnG9zuOEsOl8YqFaHffpn1CAgm33vs01Vvg7D7ThcwvGqOUUdgSOFgGKlLVTAlb8s1J4C9shVmxywN5bmRa4FyhyLiluUX3eVQj5HhHfSd3OiB/rWtLVJ6wC+dNiXUuDUiaccZiycLHu/+IEO30zd+Qc1+PMPsWOEHzkJpVYp6KmcxDV6V6QT4vYG/1/9syMfU1ZgUu8Fo++ednoymliVERePI8IxTD5ANt9IAAYXogz1td2GYdz/Wsi8ZNJ8C6ysiF86TZVifaUTjSQmzE2oWt6QIZLmYlPEWpNex+2k0avBYl73maPk+woxSk1VLGi4Tefh2jlkHVWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 07:47:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:47:16 +0000
Message-ID: <94f49d5f-9e57-68c0-8c86-36a790c7c729@intel.com>
Date:   Tue, 17 Jan 2023 15:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Matthew Wilcox" <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c2a3cf-a802-4fd5-016e-08daf85f0d66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYh8Kb3d/yHkZYLYtaig/+PP/zQZa1GX8fx7pPf7LBExIYzUTB35lfQ1cnX8Jm7xIR4sEv2IL+cltavPhHrHK26/l0nWIHH0RUeOB7uZho1Q6YfsBoxpig9sD3qfsRDeswYS5FT4tTSptATgcD7ozJ8eHqT1eZlVHChlCykfCIJnEqKHHWG+4RAvuiL2Oh2To2PHJTRWlz5QiRICGXomTZIZplSbPwHsfWQcSxPtFYQYJ/aCpUCeirphbyRqDxFKAMejDFfdstxOjcWWCvGRD/RhLV0tNTkcuV/5mH3XiBtHHYxtNYSU7smb3EoIkfc5RRyzeZ4tAfoKYAz3pHlot8XV9ucKj0VqXCjW+YLLd+FlJNcKl2kZgJodBWSXJ2qEKhoGTz+Xz1FUIFoUG9RLu6gWy9vDbVhmHW5M1IhM2SymTnBrv5OjztLgt4pk/SWrKqvaVyZOLB5BAIhsNMZyHveXQ7MsfUJeGCZchUyTuF41BmUhvIXPTLA4T9ImjPJ4K77fhlPcsSI8G2eXzLlJmkSyEaNmZlDDk5e8Q7lOGp5oBr7+gt3vsozVog6e+zYJj2I4kTZIUJyAZZPHjobFubR5y8Q+oFfd7DSCViLVREnEH5no3kMpoR6TjpXcZWO+uYH1fxb3V+yLex5IJP/fP/Z3IBWoC78YGUX/iTK03GDjG/AxOsDDLrbkyy+eY86HMMSe8qXTOX7xu16VUv/BADYJWckVx7GmExqGJOju8iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(83380400001)(31686004)(54906003)(110136005)(6486002)(6512007)(36756003)(478600001)(31696002)(186003)(38100700002)(2616005)(86362001)(82960400001)(2906002)(41300700001)(4744005)(53546011)(107886003)(26005)(6506007)(6666004)(66556008)(4326008)(8676002)(66946007)(66476007)(7416002)(8936002)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkdOUEptWUt2dWtLVXBVZlgvNG4wR09jakVIdFBMUjNCMGREK3RnOFVPdHpQ?=
 =?utf-8?B?d0ZmUEsyQUo3WmNPY2NBc2MyNHBtL1psd1IxQ3pDb1JudnQ4NEg4SjJzeGZ2?=
 =?utf-8?B?WkNFRHozQ3dUR3lZeFduQmtBSThVcW96cFZhbllCMkhnTGgrdmk2QTdQYnoy?=
 =?utf-8?B?UHNRRnQrYUpvN1F2L3dLREFpUUJwd0ZTc0JHTWJPdmQyZ29tbE55VjkvRE9H?=
 =?utf-8?B?bG5vWUFHNXVqbUpuQWJWcGZMTnNNcUNzMVZIVGR1dlRpbyt5Wjc3Ry9mUmlz?=
 =?utf-8?B?RXYwVEkyb2FlakxCcVRmU3VMM2JaeDI3LytYTXFKR1FzOHNGSG5iUi9lTEdB?=
 =?utf-8?B?TzVCNmw1dWJ3R0lxSUgrdU5qOTFZYUNIT0ZOR2RzSm55ZzUrYjdXR2lFV1J1?=
 =?utf-8?B?c1pxei9OWmJjYXMzN0M1MTFvZDNPU20rbHcrb1piWjYxUzA4VTMwbElQVGtu?=
 =?utf-8?B?ZjZwNE5iN2U0WHQ5VFgwYXpmUFJ4em1jbTY3cmJqbVpUN2IyNUVCMTFvU0xW?=
 =?utf-8?B?czFVdWU4TG9sN3A4ZXhQQ1p6SWw1TGZ6Z3F4WVBkTEEwZWxPbVlWTXphREY0?=
 =?utf-8?B?K2p3NkF1KzVmZ3EzVi9JVmxNY1k1QTFFV3gyeE5Zc3Q1VVh0MlpOb3AxSksz?=
 =?utf-8?B?T3FwSWhBY1JYRU5rTzRSMmVNazYxRi9NMXJ0UlAveEhrNDhGRDNiaS9JR2Qr?=
 =?utf-8?B?ZWtXekVrRU5DMFB5RTQ4MWgyL0ZJQmhxOGxFMkZXY3NyZ1o4R0ExZVlINDlt?=
 =?utf-8?B?U29hS2owanF5WmlIWGlFU3h3ajh5UXVtK3oza2g5ZHJkZjN5ODhEbDZuRXJL?=
 =?utf-8?B?d0tIK1gvYkh4WVB2Y3VrMVJuVUJiTnhwVEtGYXhxcXYrbUxhT2NiZzI4bXpL?=
 =?utf-8?B?ZUpyRmd1SUljVmU0Y3E5WjFqSUYwZGRvUGdsSjNMUm4xR2ZpYUM0TUFCTkYw?=
 =?utf-8?B?VEVQampnckRIcjlpY0Y3a0dBak8zem1vYUNkc3A0VGNidEY5ei9UMWtBTDB2?=
 =?utf-8?B?Vy9NSzBkNEVXdjU5elBOaGc1VWh2dktITlIwVWFoek9jc2FxRUxNS0hQRmN2?=
 =?utf-8?B?OVh3cGN4Z2t3SHJyTEhrZjZIVnhLcHBOUFEwTVduN1lLZStHZ2ZyTHU1OUR3?=
 =?utf-8?B?dW5SSzkyLys5ZVJ3aFBlQlI5d3dHVmt0ZG9IMVNMdDA4YWNIUlNtU3hLTHZq?=
 =?utf-8?B?VnFNdXdyRGxwdDg0SDNKWDZIZGVYamFsanlreHlpbGtqSk1kM2RTMVBsNWFL?=
 =?utf-8?B?eEFncHd4RksxenpTTUx1WC9XNzQvbTZEcTROY3p3ajcxM1hhSU5EMU13YVZs?=
 =?utf-8?B?ZWE1T1UweVdhdy9aYXpOVEJaUGpBa1F0MCtyQXJXREJrN1ZmNE4wWXBqdk1N?=
 =?utf-8?B?amRLdFIzclQvTlFFZFhFeWZmWk5rdkVGRWFMYWo4d0UvM2hQU2ZZamNGL0Q4?=
 =?utf-8?B?UTdlZXpPKy9vajZIOUlEUHpYcTByVXJBQ2d3aW1HRGZvVm9lak1OdS9NNFBG?=
 =?utf-8?B?RTNGRkU2YzVTRnlpd2JNdjJMTEp1YUZQdEY3NDJsNUk3YzJ3V25wYVAzZ1RW?=
 =?utf-8?B?MDdLM2Qzc2wwazhnN3dOaHZxdTh2eXBqdDBmdDdjblgrTXh4M2lqR0ZsQzNG?=
 =?utf-8?B?WmNRSTFVQ1A2MEpzK1JKV0c1UVBxUmVUR0xsVWtiT0FNelFsSUlUUDl1R2FU?=
 =?utf-8?B?dHcyQ1ZSa3BITGxGZW13Q0RVbmMvK0JGUHBiQXVZeFljTXpaVkxCbTNiZHNZ?=
 =?utf-8?B?RUxkRzJRczdFNG1DWEtlODFBaGVxTDBGNDRQZmk2K1o0NzRoZG1sREx1WmZX?=
 =?utf-8?B?Wnl2eHZlZTdtQTVKNllZa0JDS1NpQXlIdVB3ZEs0cDFPODhnemNJRm5yQUZx?=
 =?utf-8?B?ZkRhK1ZMWjJvNkJna09scFZuTm1ZcE1JUFFkNHZrK3VjdDZUcTV5aStTdS9l?=
 =?utf-8?B?YmpOM2hlbHU3Ny8rWlZTdXVJMmRjSUxuUFNNQm8rV3pEdEtMdjVJZmtqcFN0?=
 =?utf-8?B?TVRqZ3dTdzkvTHlNcWE1V3BlSkp0L29QU1RMVXZqY2pNLyt4NlBsS0o4ckRq?=
 =?utf-8?B?RlNGNmQvOTZGWG1ESklxTHcwM1M3b1kxQkRDWVRMQjV2V0pBeGpvVDlVM2x1?=
 =?utf-8?Q?jS7nhNJQGu+HTZldwlhQs8lWp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c2a3cf-a802-4fd5-016e-08daf85f0d66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 07:47:15.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJXIEelmeInFRgOEEpYFKBBosSsW4JP+Z0KzBbVwdJATEW51mCLHv8URoUE/0O+HNBnkAo0y/8TGcXDHz+Rlww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2023 3:39 PM, Vlastimil Babka wrote:
> So either the assumption of refcount being already 0 is wrong (shouldn't be,
> AFAIK?), or this atomic operation effectively prevents some very subtle race
> (although IIRC atomic_set() has no barrier semantics defined, it could still
> affect a specific CPU?
Is there difference of atomic_set() for 32bit and 64bit? This issue is only
triggered on 32bit configuration.

> 
> I guess we could
> - try to restore that set_page_count(p, 0); on current kernel to see if it
> kills the bug
I tried this. But didn't try too hard. 20 times reboot didn't trigger the issue
with this line added to commit 0af8489b02.

Without this line, hit the issue 4 times in 10 times reboot testing.


Regards
Yin, Fengwei
