Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5165621C76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiKHSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKHSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:50:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA4229
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667933393; x=1699469393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S1406APsqesLYWylTHrBWZzUaInDq4ymz99wPm92FXw=;
  b=D1GQbDMwHsEv3RSt5gNd0OO+YWeBGaA1KAufCeecSho3SIcony5Zsy5r
   yN2FeQNI/Y7RuAS2BpdXSvAvVL8/bjx6FMDVa0AAfz4GPx2il0b+spqaG
   P5aJWrs4dzRUS18Z8W+zU/ucF45GaooBzG35Xzk1Z07zkF9go3aTGXmnp
   YLyd30794Cq70PCJXXAyubM7GsqAmK+rAFxQdpmTzUnw5GqzrcIJwMth+
   6P7mD/HMyHUqIqpQb/hHZj2wHNCfzLexb6WgqrOf+S9dkhnlMXa6bnNRx
   yUNyEu2mnXk8OrPH1tBeHU7sjDersBd8K0reD4m8ErHlLsVXASI1UVbyW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290495727"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="290495727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636441860"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="636441860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 08 Nov 2022 10:49:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:49:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 10:49:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 10:49:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhAQlhVTOrIA+mj+jTjExVA+FMXnzm2y0P1xVDyffazj1vhnk/orU7YZ3Nj+WeAqOHxHJe4X1nk+lFCQzDsF5sJ5LE2VVDa/shnIxCkh6KiIoq5+CT+MkjuLezLopV2y8LTbJjsgQ8K/7sIRBxTy7igcoFAMYMHiwx6RGnN1EKRSAys8cx0JcGLT/Pg0/VGZrju4qZ5NYhe07R5vc77TCGQX1EpbpoJPh53U7qYmAupmIdU3wtem+HcmDt1mwhEGsAzOZKsLLYlMNk3iLGldntGfsip0v74OrwmZJxNG8DxkTxq0WDGI5eOCbelaiyffHy9IF0EqPSc7PRzKBahS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y2zt3TXVAQX5G6UP3HoDLJW71+zFm+weyOcBK8l2Ik=;
 b=LZpgGtuxwH/G4BenNl90coNcqO7zwnjo+8NnVln9jfrIsHKoXVXfvYzj1B0YfF5bgB2y0A/N1UQlFeHfS6VuSDKiAb9N2Qk7ZGBminWTWhKwZkB/QC3iPfwsoTZmQ9vIpCHZQh2pOsKiDhJeB9Y94+xU+RmYT23ytm+l3XZNSHobB5U5M4J+HEuoTleMyLqXIlCK7nHiGDBJJrNi8xq+EVwr5ub+Tru3t3Z6c5UtZnO5K/5bke4kr83d07BPnxvQKFCM7V09nrVE+8HEnDbz/o4savk8lcF0Cgb6XHmwwPIeGp0LCP5wZX7RMZam7Md9NSSqK092OwIZDgjWKN2Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB6345.namprd11.prod.outlook.com (2603:10b6:208:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 18:49:45 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 18:49:45 +0000
Message-ID: <ab6504c7-419e-b274-1cc3-c40428907edd@intel.com>
Date:   Tue, 8 Nov 2022 10:49:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 0/1] x86/resctrl: fix task CLOSID update race
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, <jannh@google.com>,
        <eranian@google.com>, <kpsingh@google.com>, <derkling@google.com>,
        <james.morse@arm.com>
References: <20221103141641.3055981-1-peternewman@google.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221103141641.3055981-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5f5acd-8c3f-43af-768f-08dac1ba00c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7orCMtSgsx1CiY82dVsSzyaUtz5TWsOXsYVhtsF5IXam3KrcH9Y5HUTYWhG+ROCCGjxUGaaC0JR+MpnrBx2mPTxu0EFK9NnJ7Os1p/6gHlwrxVwwCI/6TN1l77OFpsMW2W6AzptGJ+iBTXKnhErFRrb8SnKVOWFGn2QV16RYpzyYopwvCI7AQ0Pm/rnLmbMsNlxJwMYbVr+G4tELzZ/Jwgs/N99pEpyz0FiCncin1QdH6R+ICwr58vw3MB17JRyPH07gAmD5McoU8ZMuHHSwNN8365zJTW7lzB5hWXO7ScefO3XVPOjLRB8sxLOrF/5fd1Q8KohyQOky6G9kO3ApO4cG1YP54Iq50FWp6C3BSJnmZN3H3X9lL+/ilfRr0Yk7aafhR4cufq70UD4sAsOc7pPUX0iFBnLCNIPcGo2+OHH9Ina9vQIoyu/Gt9+uO5yQxfG3XxJiZ4POjxWpblr9MDmMEUrOjpAJliRI2rlOpQoWw7F5w1cFgi3ehfhhJN3zXKh1ZDcW0tLkBKMiCrdK5/sAv/LoW4JIihsI+MsDVlOfR0RU+82V8Idbt1UChg0cVEPSOjTyKYhy2KVS8BKNHii+K/63FOCcCTBqD1+nvxVDkDW/aM1TxArChfj32qEkoNhjqvWoEUyOnT6wV7AEN5sYq+TS8oq9Cl+X7E5efLd/jqghWnB2XTmIQBmSdWyqwd4Db+rsmv0ESKuoAWx+jGs5NHHU+VYUU4g0kVbQMZRVn2AxZQ/lT7KWeYFUtNR4E5LiDzI7jG5QrQNl56US1V3HbfoZUeFboe4uhbRJAXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(31696002)(86362001)(8936002)(66476007)(66946007)(316002)(66556008)(6636002)(54906003)(110136005)(5660300002)(7416002)(41300700001)(2616005)(186003)(2906002)(15650500001)(6486002)(478600001)(44832011)(36756003)(38100700002)(6512007)(26005)(4326008)(31686004)(8676002)(53546011)(6506007)(83380400001)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pTZ0FqK0RqSG4wV29UeXdWcTFTb295Z0pBWVRaaCtQQTZqRWtKSjVFUXJU?=
 =?utf-8?B?MHA1REtMWGRpbTJuZ2xiN2QvWWV4WkdNTEJ3enBIbUNtSHZvdXZLYWs5dTBB?=
 =?utf-8?B?UzhDTDl2RTZkeHhnd0ExcVNHQ2d4T0hLNWFKMGlrRVd6bVJXL09pMUQ3MGNP?=
 =?utf-8?B?UEVBOENJNmtxbFVRZE82NzR2OGlCUDJkQXRGUEE3NkxSeFkvV2lWRXFQcnNw?=
 =?utf-8?B?RzFmU2NhM2s2Yi9PUTR0T0pleWNZMitxMHpxVlBUdGcweGwycm1mY1IxTkJD?=
 =?utf-8?B?UGc4NVhDT2dwOEdWNlVFU1lEaDFiVk02VU1YWjdpQUhVZStBTUhXdVZBSVhF?=
 =?utf-8?B?czhvaVpWTE5LSW91cWtkbXptRURmMFNDY05MWmtzWVFOMGI2ck16UFY3OGRL?=
 =?utf-8?B?UnM1QzRIbVViMTNVb2liQ3oreGpLditQOHljZ244YVZBdjZEaGRTbUhtZEQv?=
 =?utf-8?B?M0xCTHhsbmZBb1F5QmhaTzhhZ1hYeGJZMVk3dGZsdjlRWDBoRWRRejR0Lzhk?=
 =?utf-8?B?MWZGc2NsUmFjd083ak5zSi9JTjQ1bUE2VkJ1N1pkeDFCQkQyY2d3bFZDaFh3?=
 =?utf-8?B?RDNzSldrT0NJSWNKWm9BcHVzN3RESVBnRXdJZXR1cEM5SVNjTjBUbWthT3lz?=
 =?utf-8?B?ekE2WG52REFEVldZcnRFV1VUS1crVHlQc3IvNEZPblF2ZmcyVEhSSlVtWkU4?=
 =?utf-8?B?Mm5aOHJhaGNUNHFScDFycWczTXN2bHFkSUFZL283MEdPUjdHQW9NYm94ZWla?=
 =?utf-8?B?UDFLTHFRUFBXdzVCSER2OFpYOGtBRGFteGR4QncwQ0xhaEhIV2NjcUZNdU04?=
 =?utf-8?B?SmRlVVFlTjJLNzJGRVBCUEg1NUFIWlNTQitoMm1EeFcwQmVrWTlsaDIxNWJv?=
 =?utf-8?B?VXEwWGlIQ2R4TmtaNE1ONUU4SlFCT3FxOTNBMFZTUjU1MXU5dmhpcDBBUG9D?=
 =?utf-8?B?Z01ySHdrb2d3QWs1WnpoY3VDUTZtY3kyeDJZcWRsMWd1T3ltOEhoYk9LNnBx?=
 =?utf-8?B?N2FGRjdsYmx2dzFUZUNJSEZudUl5bzJ3Sm90UGg5OGJZOWFwUXJrL1orbGhR?=
 =?utf-8?B?cEQrRWdUZ21KSzcreGhVeWV1UGdBTUhFcXpNUXFEZWY0SVBhV2tSTzdnRFRt?=
 =?utf-8?B?c0FONlJnVStqR2ZTR0x1am8xeGJaYkJ3L3dBYXFqdHhjL3pRQ3NjYWJkNzFI?=
 =?utf-8?B?WEQ3aUFiZDVvVnZTVXhMQ2svWkRhZS93N242L2JDSkQzU0ZkMEoyenpEbmMw?=
 =?utf-8?B?M1dpTVdFZGVXUkpXemdwUVZybHBINU02WWoxQ1dzU3ErWVBZUldiRWVNWHA3?=
 =?utf-8?B?SWV0ME01NUpRRlVROEx4MWFLTlBFYnpvYVFPdlNxNHNVWjZKako3UDZSOUNr?=
 =?utf-8?B?a3FGemJJMU96ZmJXU211OHp2TGJUQW4yQVk2NjlDeExBWERuL0tZQlViZUFT?=
 =?utf-8?B?R202VGxVVVJTc3FSR3psOHFqVW5mTUc5c0hHYWNINnFEMEt6M2M5MHBHNTNE?=
 =?utf-8?B?S0NSUHg1QnUxU0tuTHV3NU9FaWRGOWpydk94NWdSbExHZDJjYXVFWVNwVy84?=
 =?utf-8?B?REtXRWcvSUZoVzZSL1RUNUV6eEVPSnR6TmFhaGlDZit2ZTA1US9qcWM0TDNt?=
 =?utf-8?B?MXhMSnMvVG9uWjVCN3I0Qnk2WHYrWHA0TXhtN0I3VXZwTGZlejUrZzRlL1g5?=
 =?utf-8?B?SWYzQlhJWXNJSGQyVHBudmlUdUIvc1JoZ0Q0czBUSmpMeE40aE82dzVBTUt3?=
 =?utf-8?B?ZEw4dG1kL3RsVitmM3dTMjlXVEZ4ZFFvU1BaczM1RlJXTFRqQ0pMOGFaK0VK?=
 =?utf-8?B?alFxZU4rdEo0RnNBL0M4Zm9QMEkxeGNiS1JRSjRTUERzK2FTTlZ4c214N1A2?=
 =?utf-8?B?REFaRzBWZ0laYXRNZVVCeDh5Qy95aEJRblFNSlFGMDJBU2t4M1VkUGtVMkp6?=
 =?utf-8?B?bWc0UGhpSU9nYzVYQkJVYVp4Ry8rcEE2ZFVXQ3dkYitNc3ZuZTEwbFJoTkFS?=
 =?utf-8?B?a2dCcE1YMTVLZTFNOTRndm5PaFF4VGZncXd4ZEl1MlFaMHQzdkFtRkJBYk01?=
 =?utf-8?B?TDJzTkpjaUh0NnpCdldmKzhtRXE5bmtWMVlUdU1oN3ZwVjlhNVczcUNzVSti?=
 =?utf-8?B?T0RzQVhIMmYzYnVYL3RQYUJrV2NOWlRPM0lmMXVGNkh1VU04cmFLMVA3T25o?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5f5acd-8c3f-43af-768f-08dac1ba00c9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 18:49:44.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpMJBR4pyyA7naPYcLFzDJOQZ43pUXr6PitOgsUECypoVreGJ17yIYK3X4FwAnzLqMm+HFem9kdDaRb7ZGMu0SyNgLghkAswTKms5lJMsO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/3/2022 7:16 AM, Peter Newman wrote:
> Below is my patch to address the IPI race we discussed in the container
> move RFD thread[1].

Thank you very much for taking this on.

> 
> The patch below uses the new task_call_func() interface to serialize
> updating closid and rmid with any context switch of the task. AFAICT,
> the implementation of this function acts like a mutex with context
> switch, but I'm not certain whether it is intended to be one. If this is
> not how task_call_func() is meant to be used, I will instead move the
> code performing the update under sched/ where it can be done holding the
> task_rq_lock() explicitly, as Reinette has suggested before[2].
> 
> From my own measurements, this change will double the time to complete a
> mass-move operation, such as rmdir on an rdtgroup with a large task
> list. But to the best of my knowedge, these large-scale reconfigurations
> of the control groups are infrequent, and the baseline I'm measuring
> against is racy anyways.
> 
> What's still unclear to me is, when processing a large task list, is
> obtaining the pi/rq locks for thousands of tasks (all while read-locking
> the tasklist_lock) better than just blindly notifying all CPUs? My guess
> is that the situation where notifying all CPUs would be better is
> uncommon for most users and probably more likely in Google's use case
> than most others, as we have a use case for moving large container jobs
> to a different MBA group.
> 

It was unclear to me also so I asked for advice and learned that, in
general, sending extra IPIs is not evil. I learned that there is precedent
for sending unnecessary IPIs, for example, in the TLB flushing code where
it is common to land in the TLB flush IPI hander and learn that the TLB
does not need to be flushed. Highlighting that the user initiated resctrl
flow in question is rare when compared to TLB flush.

From what I understand even going through the extra locking and resulting
delays to avoid unnecessary IPIs with usage of task_call_func() it is still
possible to send unnecessary IPIs because the information about where modified
tasks are running may be stale by the time the IPIs are sent. To me it seems that
the risk of stale information increases as the size of the moved task group
increases. The benefit of using task_call_func() when moving a group of
tasks is thus not clear to me.

I do not see it as an either/or though. I think that using task_call_func()
to serialize with context switching is a good idea when moving a single
task. Sending IPIs to all CPUs in this case seems overkill. On the other hand,
when moving a group of tasks I think that notifying all CPUs would be
simpler. The current code already ensures that it does not modify the
PQR register unnecessarily. I would really like to learn more about this
from the experts but at this point I am most comfortable with such a
solution and look forward to to learning from the experts when it is
presented to the x86 maintainers for inclusion.

Reinette
