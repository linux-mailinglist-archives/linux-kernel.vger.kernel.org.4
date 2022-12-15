Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A170C64E116
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLOSj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiLOSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:39:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B7C4C;
        Thu, 15 Dec 2022 10:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671129536; x=1702665536;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rl6zmOdIMCJiG0fh+6dP59e74oUe5BMzsDxeDw672nw=;
  b=R0mDyGo9TaJx1WNGA75xL2BRdRlbT7mDuQOxN7WBtpIv6EmzyhuZBrxn
   rfeDxNEyQCkxgwadXkhmA3L2h4vwbmhWBGsDjEd/EeK047jrMwCtr5cBo
   t8lz5HJciaq48ZyEId5YvXCB7chsLVgjcTIQoygdSgLrUJ+BFFV6Ov6Bt
   QppI6nHoNi0EYbbj9jfp76ke1vLSvJCVdyOoCoq00YdCCRMcKK8MFyAId
   viQHwFMRsCpqfBs9SExeQJ0iUTu2dAMUbistu1o/Z5nPwN5fnJ1L/aqgg
   ij6e4gGKYIFCLabHGWuPwGMqsH/q0bfzsZphU7EwxgIbPHLcWn7DY7VvG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="317468132"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="317468132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:38:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="713009225"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="713009225"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2022 10:38:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 10:38:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 10:38:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 10:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzQt6aP/62nxeKx//t6W8nYvx+x62eTo+g9Z+6QQaXVG7WxbcOqAEnuY1GeMqUEN7wZEe4AyOf18v6fTMJicdTuQWha7G1qA3mj4t63Clem5+m2h5obQ+ES/gVGjBEbjAPyyNeNhdJkqZJnXyFSqor1ujKweJSVTjfw+ZAcgc6Jx0rVAsUa3nbQDpa/BDYwGL0pEf0tgqXuogBmeKLj16VM/4+1aHCT2+49ySphypLoelK55EznSYsvNNpfXOoYratuhKV6kILcJPAYY1PkV2LONv6Jdhj764kVGG/j/KgOzn+KrNGuIBvIJbfX9UVsaBPZ8gkF763Q2ZlOzgYmJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl6zmOdIMCJiG0fh+6dP59e74oUe5BMzsDxeDw672nw=;
 b=lA9dnxtNDwe3ZodeWpkONoiXF6ZxbddaLqY4R4YpupjMClNd/LIRbAndvZaOrcH1nA/y2dOY9smlTtTW/wUzfCLxL+R34/lJFHBUwEDd1YsHw8oGpUkoYNMJ2rzWymWnfPCVMpQPB3lXZWI+Uudj9Vvz5v6XZQpQbq+8vtEUdzw8cSP5B5NI9W67NssFtC5aWEatylL/11wPzFivYuefmKtKMJJa7aZZxYRwhbd0BiJAbPydj/xCotTju798cagPWA/tlj9A9VOJcIfm+WHfnS7/lbTw3uNzHV+NrKj4lUQzvohn9em/vW7G2hnZnP9Qt63vvTCP2TFOQC6kNx5HtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 18:38:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 18:38:49 +0000
Message-ID: <2174535b-1f95-d286-2884-cfa7d0a8491f@intel.com>
Date:   Thu, 15 Dec 2022 10:38:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 00/13] Support for AMD QoS new features
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2969eb02-c9a5-4b43-bb84-08dadecb9af1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jO6YHIzh4rv92wYOXPYd8JhL6/Ys977qa50spzVWvQWkWri2RIcBQRDdjisFmWTTOLHpI4CQKo394aQ5FAyDGaFVmeYlHaf0U4tPUeDmVyf9obMhsM4J8k1bImMYKkIbYrYR5AFVOumU5yP5Jwtkd4R2QMGdv6W64go4YUo2VXQdF6Tv310r2bPWOFTPUUWVNDpUai/xafWDDQb6YnjoPGC3ABztw2pi97V5iWiuc6ZsWz3xJilaje1lqDn7VxtgcsCBUCD4hTmNEOCeCePjfahbZDqgz28hMvsTlbSgRjgNbdtKLsowRzdLneW2u2RH84Q/eMMnS7qQg4fyYjdOUjFMIuQ+NxGPD/N+1+idKKUxM6ggUM7kLUQXhQQLI4Gemsa+cD7W+oOQ1lMJAuBd7G33XSbHYLK8+36fm/eHdrNq5XnexgY5Gw2iwVQmoUa6nVV118Sh23z/uejnzdZPx3nQyZZK4SAq1dv88u6nE8sudZbK3THvLMs241CCDwOt3tOtF6Ko+aLedFBva5rkdsUw8B0AcmNO5K4va1IwIPz1RcKDosaA8RuZwOiaObpuPe3aNN4hWzB97TCyQ53MzuTJ4DoiQMLu456Vn9PmOvdR6cyEhNnPSpqK/PSpY5sKcStiSu1k2IR5AhM3gBmj6cZfOqkShtp86PL0q9eoPvgwPopBDetuDU5wkUe0JL9BJSY1UQGVBnDl86DKHLxxX9MKvCzkU27AfMfD1MCJYGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(478600001)(31696002)(82960400001)(8936002)(41300700001)(38100700002)(6486002)(7406005)(86362001)(6666004)(316002)(4326008)(7416002)(66556008)(186003)(2906002)(6506007)(66476007)(6512007)(26005)(8676002)(2616005)(44832011)(5660300002)(31686004)(66946007)(36756003)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlYMXdTWWlHY3prcER2RHdqbnZJYTVNU0hqYTg1WDF2L1g2aXU2alZ4TkxC?=
 =?utf-8?B?SmUwTUZZSCt0OFd5UjFCdkRUOUo3dlpCdkhUQmJ0YmJoZjM3bnYzaGVwTnpt?=
 =?utf-8?B?Tmp2Sm1ydVpEVGFJK3hXUGZCUmFVWGZRN09yMU1lNmZ4R3NGRHRiSElLVFBt?=
 =?utf-8?B?QTJ6Sm16dGNLWFdpSDBzOEJRYk9jUzZCSm5VODVkS0ZJSUJVaXlqeFhwS29T?=
 =?utf-8?B?YW5qL1AwT0Nwa04zajdQL1V1NVFOVmZ6aW9iSGdhdUpaMVA4UExTN2hOd0dJ?=
 =?utf-8?B?TnRCRDZaL0R1emR6UmFsbWhrMERjRUR1alB3NmdJZk9pSFdhNmFVcDA2dndH?=
 =?utf-8?B?Rjl5SDVqcS9lVDkxOWJaTEpHandLRndwNC93eHNnd1I4Y1ptd0pzZmhrRTAw?=
 =?utf-8?B?dEFUZ3Y3eWpBUlM0dDMxYnZWazBROElxN2hnNW5ueDMxK3FDSms2WjZRN0pZ?=
 =?utf-8?B?ZUl6a1hvSjQ5c2pod2lGRWpvNE9ORE11NFcrMVhwanhwT0M2TEdKb01BQ1lS?=
 =?utf-8?B?ZDYzaDYxSytyL2dSUDE4cjNQQUxhZUJpc2ZCNzJMaUxFWjUvdkIyVkEyNm91?=
 =?utf-8?B?OURWWlB2NnBkcmM1V2lxV1FWRjAwZUlOY3B0RjdjeHhFVFo3dGorWmovYStz?=
 =?utf-8?B?MzJ3V3lXSkZ3ZUFPWDlFZ1JTY1BtSElTdDVkS2RwOFZSVmxpbHlwQm1TTXRm?=
 =?utf-8?B?NklVN0ppSkNPWk1QeTlvRE13M3J2MlFJQndLVHdQSDJSU1Z4Qnhmb1ZYTjA4?=
 =?utf-8?B?cXE3UVJpZ1ltQk1yNlJPK1B6eVZkZDVYYjlhNXBZYktIb0dtcXpLc0d6b1dI?=
 =?utf-8?B?Y3BpVmJYTFdWeUhCcEJhd1R6Ym9DWENXeEV4TjgybjR0QmUzVmVhSHI0VWdS?=
 =?utf-8?B?U0h2eFBldUordHlPczdYZWdyKzNqb1RZNXh3ZythR0RES0l3MzBUMkxhODRJ?=
 =?utf-8?B?VmQwYmdFbzQ5NHhTZXo0LzBNVUtLeDBUZi9iTkptTFhDNVdBSDdaM0ZCVGE1?=
 =?utf-8?B?MnY3aFhNYkpGSCt5NVg5dndXeDQrTktNSGN2UjNpNVU2LzNxSE5kU1NHQTJV?=
 =?utf-8?B?ci9LT0hkajNjeUE2bGJUS0pvOFh2dS9ycWswZnhTWVNiMGxVUkswdEFXWmFT?=
 =?utf-8?B?UVdFVlBkcGJ5VzcwUkxQbnF3VU1pMWx4dVZ6TlZnZkxjbmhXZDVaV3ptVVZE?=
 =?utf-8?B?REFWTFRKS1VuT1pRcHhxSk96dHJaKy9yQytuKzJMKzlzdWtRbm5CeDZ0N1VE?=
 =?utf-8?B?NmJLem51YS81ZVljZVBTYldZMzNKUHhVaEtVZDQycERPWW9xVWJkMXA4cDVo?=
 =?utf-8?B?NDd3QzArUUEwOTBXUy9JenkvL1lRWVJBd3ZTTXNGSVRnMlI2NTJMK1NSczcz?=
 =?utf-8?B?WmkvMjlpaXV2djV4bWFYOXlBZngvNkI3aEhIaGdtVkdmYlhvQU5Ea0lIN2tG?=
 =?utf-8?B?cnZtZzRYSjBVb3hYRVppTWZlY2FSVS84WXlVNU9nRitBVkJOaWpOWjdJRG56?=
 =?utf-8?B?eVNDckhwenNlQTZkb2RtSFl6T1llOFdyQTNXcnRXVmZkaTlzY20zbkdlVUpW?=
 =?utf-8?B?Um8vRFB0L3ZKcVdxVVR2QlJuWmgwOTNTQzBXUElsc2E1TGJGdnBwelc3Rktl?=
 =?utf-8?B?dWNaQUVZeFl0aWZyRG5rbGlxc1M2T1JGWjdLOHlPSFdsN0hSY3pxTE5nQW55?=
 =?utf-8?B?enM0ZS9Ua1pVMnA0cGZyUVhUcXh4enl5ZWdETFlFQVd0VkJJZ3pLck1nNEtX?=
 =?utf-8?B?RUdyVms4UVV3QzhzTCtMRmxTRi9nejRFZG5YRGl3RXlvMzBNTjQ4V04reXli?=
 =?utf-8?B?Vm5FckdkWDhGVXlNN1VuYVg1cHY1NHR6WXZFOWVjK2M2Q25xeXFRSnNZV29L?=
 =?utf-8?B?VUNLeDhkVEF5V2kxTXBZZHlDQ1dnZStoZ1ZnbnBKb2hvbzdFZFlxTjBiWmZL?=
 =?utf-8?B?M1NmM2NocG9PS2RwdXJzcnRZaHNVeVZ5UG5takpONElSdDZGZUJobTM5ekJo?=
 =?utf-8?B?YXFnUmxPOEJRWWNGTEJRQWhNUFE4VG1BV0xjbVNBRW5HVE9Xc2ZWTGtGTVpT?=
 =?utf-8?B?Z3pnbVIxUmFKWllrUVhXa3FYSG5CcnlSaE9pZmJ6MUo0SnRyWlFDZzg5Y25q?=
 =?utf-8?B?RUpBV25EbHI1dEJuMTRCNEFqNmlpZmpCQmtLWS9aU0d4bHZVMHpKUzlqaGhY?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2969eb02-c9a5-4b43-bb84-08dadecb9af1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 18:38:48.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYf6nf0EzM7CLXBr+jkZZlYwY1fcSw7YmpyEAfYpjGAHvTv1nrv3VRsPtUJToRLZZIyKTGbhEQW933tlpgAk113ltjYaPnlJU+YIpPD31ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Please also use the x86/resctrl prefix in the cover letter's subject.

Reinette
