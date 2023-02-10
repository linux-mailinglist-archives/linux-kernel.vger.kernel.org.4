Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE95692B00
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBJXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBJXVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:21:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EBB1814F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676071268; x=1707607268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytFm+NqFmZUWpSc5F8L+lXksv4lgNywwuuJVuf0PDkM=;
  b=hV1hAIEnvt1XLq7v3uoqi8nV0jlSegUL2tfKFdo4n1lFC/wKVAe9wJiw
   3m9lrUmN7idngxCCiYh6b9tKEBX0UAFT/hPHFFQK3rl6zxfSrPxtQFVDG
   neFFa5s+OfPchda3iWxcEqlM9ZJEcmEH4Gh1/1WZegBG/mGy5DxJJj6h/
   nSPBWjMIR5f8tmuTuhIpTPOx4CcME0XNjgLpZ4vMKoYvODAZOIOmLkSH1
   6ka0sbg2QdSBdsVarTeXy6gDy+mZwDiicseZeF2lUT+HdcAIZbiewnSNf
   X+btUnhbcGg7z/Ofq6/t9BjOa03VXbZ+UizZ7BqbBe3SeHCnRMOeQltdu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="332689972"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="332689972"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 15:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842176561"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="842176561"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2023 15:21:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 15:21:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 15:21:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8pgseV5fLgzhau9u3OOCKABEeYivcNpjeP+Ync4oXpqqdGUBcdomZAsDqvMb28CFl7DyJ2f7KmInDFm6sJyEDhn4+p+Zb5Q3LFezRgN+xXwDeRsKHfegnDg8iHzais9LRfUyIKn7S9dXCSVH8htjZa1oNeEF5obaWtutWoQe2mvkqmiVJHCigVeOZBFaWEzpRDnWezH+dZe5gEl3Uw+HnjgzE+ztuFF9+XyVQRcp+4SbS+9bbakyX3JaT0lJdmZmUtbeXQnC8QkoS/45PsbGpjP8UvlReDYNyQnA5sEEWjQEY4yr4meXTs13SmaK1UxoeFE6Nx8auCAoy1ZXX0DYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybcRy9MyeEEycRTbHfhAtU9OSSGW1TTzVHd5QebCAKM=;
 b=gc5Rz8S7vBBkZW/egb4I+Sfab6lNWBYMtpdB0rxGJEXLoXQIBS6VLFeLobxULcbjNLeC1atqGbs6249THG3rt6KWBYEmWav2PPq18Lhu/bH2jIRRMt6oTTY9QmTv4kKsMGFh4q5I++YY10Xu0EVybF4r7IpfDgDao9lSsZsJVD0J8mZwNhSaBdzm7GkLSahDUOGteDu47e3WHz30m6FL/GItJrBHAXiJ7Mcjyx0JDzFrWW1fY/XLhT1HXZ1FAVZzl/0ngfC92vF2GbXAherMXEC93nKrpFi/pqOBjYA6tD3bxYE5GfeAaum+pHoSgJkpjgh5AVwNFG+ambJ/3rI2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 23:21:04 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.021; Fri, 10 Feb
 2023 23:21:04 +0000
Message-ID: <03414cfb-1f82-0422-73e7-4e5b2479bc5e@intel.com>
Date:   Fri, 10 Feb 2023 15:21:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] x86/resctrl: Factor rdtgroup lock for multi-file
 ops
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tony.luck@intel.com>, <tglx@linutronix.de>,
        <x86@kernel.org>
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-2-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230125101334.1069060-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:74::44) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: fe73fba0-6e97-4a31-7d3b-08db0bbd7b05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eka+IzkfOZfuwE3J9+bvSYojB0yR+6QO5aaThW64R3j3MvrcVmRGTqZNHoZWB20X298GoAA4UuzqwlB5tQJ7o/P4LWxtd9MIuQeuan6OGFQY4T0RsL5HThHGDQFv0EODgp28dAfeuSn923Xj5+yaE96prp5fvp6a/mTlE5O9MjDrAupBX0VV/xZbod9V93w4EKhp82f0OMVsKuFKOhII++nx7Iw9ecDuk7AfgJ5jGiSavSoUdg3YSzTfUIaUqI/V8wbFhUf+vOAqEuqnrn1JxyOQ1O740STIKbe37WkA57c29RtMc4/UFTALxYBWZGvkFTJtd6I7DW24AtP2F8WhJ184/n+gn8Ge4G2A5HlFApsSkrB+zN7FSPk/I5tA89BdPolAdV59PQ33cD9rkRy2smlE/3Ylh0/klGnvucOodMqMoUyU7le4hndBac5rtvVkQRX02oIl3o5jyblbulAl+EJtOfP3Q4DYKV1eQQKAqIgkB5UWLoBdRBM2UxXrks4lACYt1vo85y599JMDJyL5qdNiHAs2IB6C99eC80VJBGtB3jJRPM4JJsBSUme3v6oQdf/hBEg3roGQhf0fhf5w+dqeQB7ay48+8Duj0S4oLlrYKBxvkhIVG4euNvFjS7ZfrpHuoEG8Ie3qnbcpe198A+8vSsE8oUVr2OJxIPn/tEHz1nrAIllv5M2ELOH0fOqRvsTAgBgqG4vCKBlBCbMQx6/Cnj+n6d9P7hXabH6f8bY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199018)(8676002)(66476007)(31686004)(66946007)(4326008)(66556008)(83380400001)(41300700001)(2616005)(38100700002)(82960400001)(86362001)(5660300002)(44832011)(6666004)(316002)(186003)(26005)(6512007)(2906002)(6506007)(8936002)(7416002)(36756003)(6486002)(31696002)(53546011)(478600001)(4744005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUlDVjRpWjQzL3ppK1JaWEllWTI4MTFGTE1ZazBVTENPZHZ3OVVtVUFZUDlG?=
 =?utf-8?B?TzRLWEE4OHhlL2xsMzdUeWJRNCtBVldTVDJMTnJUVE1QT3VYN1pPbmFGV2Zo?=
 =?utf-8?B?elBuR0lLQi9IbnpFbUNvSUFmNEFPRGtyNmdITnpFckl5emgrL1RTS0Y3U0hT?=
 =?utf-8?B?eFZnRThscWFjcTFiTWNTSzRSY2kyWWxreUduZExSVlY2SE15cEd0N01mVlhZ?=
 =?utf-8?B?QmxaVXN0My8weUJESUJaMnNubWRQZ0RidWtWWWdicVZYRmhQdUlEZ2dqS1I5?=
 =?utf-8?B?VVlXaXZOdCsyWVNGSHF3aVhiWTh1YnQwcDdHck9saENiVWhYcDdkY3pmamVY?=
 =?utf-8?B?RlFmUUlWTWtGZExLK3lFSGExNWxGODY0NExzVm5oWDZJVUVqbENmZmpLaXdX?=
 =?utf-8?B?YzV4Um9pa0llbXZobmwwYzZ2elphQVFpUDU5K2NRT3p5OFFqWnpsL0RTTVo5?=
 =?utf-8?B?N0V0V3cwVktZdGxNYzBFU001NHFqZ082Q3c1eEFrWTBOM0JDVS9weGtjOU5Y?=
 =?utf-8?B?aUV6TVhZNWl1bXBSWXlMNndUc1Y4ejZoUzV1L0JGOVFWN2tueC9tcmdFTGVP?=
 =?utf-8?B?clVienNtaWp3L1pXbXJtWDlzazVwZWltQ0Q2dnFaRUFmeWJITWpJUjZ2cERG?=
 =?utf-8?B?QlM5TE91TzZJYy9PQUl1Z0lnZUh4U0lIOHljUmo1NHk0enZJKzl2M29BUGhG?=
 =?utf-8?B?NldtdHNCTXcwQlh2RDVvWGVxc0RUZlBVOVpmNWZ2QWV4Q0NLaDQwT2hvOE9B?=
 =?utf-8?B?Q3pTQXNDMnE3aHEyVkhiN0lwbC9GRGsxamxJMlY1S3p1RXp4SlQyOUdPRStm?=
 =?utf-8?B?WnFkV1dEdUU1NjJJTC9JN0NONHFPVnJiQnFIQi8xaDZaNUFubC9MNkpRWkg2?=
 =?utf-8?B?M280a0pIRWlEemlrUFNHc3FVMURzVkFIUk53WDRvcXBBcjUwSUdPb055N2N1?=
 =?utf-8?B?Zk11VGxDdjBnQTNSS3l4UUt6OU14dWhzbXlZYit3NEFiTExYbGE2UEIvUGcw?=
 =?utf-8?B?YWtxcXJMRGdYbko2VEJWbHlPSlYxbDkxVWVGSXVBNkNidk11MkZLaU9JSTVm?=
 =?utf-8?B?dk54eXZxNXVPeXdCL1pLWS9zWTlyQzIrRDFsNTZtWGk0TGlZY2p4aEppaDA1?=
 =?utf-8?B?TkxoL3ZxSlFBMEV2S214NjVlbzM3SVZWMXk3UmtXYTVmd1BFeS95WEZjekhr?=
 =?utf-8?B?MXREUGZOQU5SWXZYVEVveHpJTXJzNlZuUDFUckZIUXg2ZWJzTUIzb1FGTld2?=
 =?utf-8?B?cGpLempHdFhmNTBQQXF3U0J2MGVaYnRuQzl5U3NNTm9IaG1SU3dYR0liZW55?=
 =?utf-8?B?VWRkU0lzNG9yUzJ4YzRDSGhrSEtkSkZneXlwYkI1WVR5K3ZobTN3Y1BidEg5?=
 =?utf-8?B?VXhMbmorZGRFRFNsWSsvRzBxU1lNeU8wb2xWa1R0VlQyUGdMVS9wTWVxVzBL?=
 =?utf-8?B?RnZzbVJLQXBhcjc5Rzk5OE9SRVFmS1RhSGw0N2RMWkl1b2VLRksyV2RkYzd3?=
 =?utf-8?B?bU43bWk1N250VG8yWkRVU2QybjhoU0xPSCtWT2M1L0gyci81WVpFQmJxR1pk?=
 =?utf-8?B?SHNIVFFZWTRmM2hIcjR1N29PU0xmUVBFblhDV01TSGNOY0tSRnRhR3pra3JZ?=
 =?utf-8?B?MlV0YU5TejJNTTJ5amdkcndIRStMdHltL2NHUXVCMmRzSnZxaUhObGJteW8r?=
 =?utf-8?B?dGNTbEErcmRBZktxY09LUFI0QlNBd24wTmc3UzBzYVdRdGtISG84dERXQ0Ji?=
 =?utf-8?B?eFlOWjF4Z2xXUU1BZy85ckc0bko1dUJpSGprSTJBYXlpSXpUR2ljZU82VXJF?=
 =?utf-8?B?amxrUmxtZGpuTXFFckdvbmpRTUk3ZmVtT0pxWGJlN2wrRVl1eS9YZGpTWkkr?=
 =?utf-8?B?RWhJa3BYUGQvd1FYV2F5WFZBczZJK21aNkpsWU40L1dab1BDQlAvUmZnMnN6?=
 =?utf-8?B?T2RycnozMUNDazNLd3MwdHZ4T24wWTdYYlE2SnRXVllWc2dIa0pqVGlhaFBW?=
 =?utf-8?B?WU1QKzhPMmZPbUdpM0w2TzB4VkFEVW0ycEs2cFVTRkVGTlBzam9vdVBJdzho?=
 =?utf-8?B?VDlHZm1ad2QxdTVIK3I3bjBuZ3FMK3c4OS9taC94Mkphbjd6dHdmbGtybUJT?=
 =?utf-8?B?TUN2MVJnTlhlNG9NUWUwckFTSkxPUld5aThNc1JsUy9JOG1aZHYzU0ZQMnQy?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe73fba0-6e97-4a31-7d3b-08db0bbd7b05
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 23:21:04.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K4vdd3kCOXNd21tP0t977N2IPXIgNxvz805OEWi/eKQ6LBcEz18tJxU/s7Hz51x0+p5sr+xLSJUXVxVGnZszNTpUzbMDGoU5ALHIFkw97o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 1/25/2023 2:13 AM, Peter Newman wrote:
> rdtgroup_kn_lock_live() can only release a kernfs lock for a single file

how about s/kernfs lock/kernfs reference/?

> before waiting on the rdtgroup_mutex, limiting its usefulness for
> operations on multiple files, such as rename.
> 
> Factor the work needed to respectively break and unbreak active
> protection on an individual file into rdtgroup_kn_{get,put}().
> 
> This should not result in any functional change.
> 

"should" has been a trigger word on occasion. You can just
write "No functional change." (also in second patch).

Reinette
