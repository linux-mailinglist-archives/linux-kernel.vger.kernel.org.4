Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275E2644C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLFS5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLFS5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:57:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D603F05F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 10:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670353038; x=1701889038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4m7NwnsdOVQpv7ky+p3qfbwh8lvKptO+5RVqorAsIck=;
  b=gQ7Sh/lnWc/YhJiJPPiiFBptAzn9DeABc2/PlPih9mvXAdyAd7+gZL0Z
   kkgnzJ67NpqUZ3OFG38MyhSzBq2tg4Hkk9MB0L5hnY5bq/g0cBS5WqWXb
   AAticW2Cb1gXefBh7gN1jRuDRA990xuSAMgTOCd8IHl1jMrOKwhfcWZsK
   McHhk2jENq2RN+sDcZLaKMSTl+OU5vGYvlkMcKLbaQOIo6JNhcPMFxWL3
   vMj0EyspsILFmxA6Jy/++lCXlF8kUfHHYy18vlmfSXOLM0e5ZdCFiWH+u
   8R6Ruy2CcqLrX3NNchJZxeKTlWbPaZdEF8kxLrQjgbimEp59/+FmN9S9z
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="378866791"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="378866791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 10:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="975179266"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="975179266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2022 10:57:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 6 Dec 2022 10:57:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 6 Dec 2022 10:57:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 6 Dec 2022 10:57:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9MxjlDB6MZRowuxRKPB106Rq6JytjNTGAaxbelmSqOqPncN74ApuqRmdOwM/ye+MctccBhPVtPq5o5r6JRJdrkNSc3+sx5WcErfGyxJNdEaRLr/HgAvSK8lNagN33jPKicMT8Q2vlRIYa1p1KsIhqolQsekfLUp9meJYhL3Q6o2b68o2+iiylW/1iq/y7DUhQRbpWOy3lVQaW3CxQs7DbkwZ0MZofeGHl6Q5QGA7sGemcqp6cLd5BdjGxqPWOXc/kJWD/kuFXX0mrz/+3bNHuEvu43JD9vm3TMz7Dtl/yYVyRMazGI6C04VFaTujqMUBFdpC6tlPUR/atc4VuYbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpMQmv5pBSGGOWDPA4g//6LG5V74py4upj1RZ3LLOQk=;
 b=SEa7jnm6TeTkSqAn96a5BB17benFC77twsoOF3J1nzqnXQvM+G9R7Hz0VAFzp0Hv2f6+4SqT8KmAkOC5RA4n8xwfKx5UQAYZLBLot5KX3RNd4rDz1EF/n5ZJfL941+x1dKoU6uNv/nVB56HWZtFNwejYb6WI7jsZtCcaN/ACPDlRq94+SqADXbi8WpfqdmGo6AWE2+yVD5mpU/rW/193iSa/6HiG2QNeOfh//HZYU7HBonLd2/U7B7MAHQQG3Za5OkeAon4sUu/OGTMHiWzdvj6GOz5rbaSJEIX4tdsEk1Gh+ySAlaGWWaVgVDYOOugRadJL00da3Q2+n19FCrqNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 18:57:08 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 18:57:08 +0000
Message-ID: <60e7ba72-edff-9bf7-0541-403f25b5bc51@intel.com>
Date:   Tue, 6 Dec 2022 10:57:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/2] x86/resctrl: IPI all online CPUs for group updates
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <bp@alien8.de>, <derkling@google.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>, <jannh@google.com>,
        <kpsingh@google.com>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>
References: <20221129111055.953833-1-peternewman@google.com>
 <20221129111055.953833-3-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221129111055.953833-3-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e853a2-d5b8-4af2-5e28-08dad7bbacab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deEB5NbkFfmZF90AJd+lPsNXEJU1dSEEuy3ZWxkmmr4UoZMdtI8nSLU0/WAo43TBcigo3/meC62+G5hG2r25/j7BUGdbVXGfclBTNfnajucFD3Q9wtvp0aMJDeILakQYwmRi4WmgrVqMml9XQ56gD7K7ISC/lHe73RprBtPmI2RpX3yaUSijfumHtWHeVlX6Zz+LvLUGgL0SdGrAmi5puDY1ISog3sgx5LtrirMsjyJoVDPGpt1revwLdljm2DHr142Zv4xCO8msg0b0RHivG6g4/FcMHvbW8g086WIMaTMZuhmdNIPQBq+BzRNZIo4PWG216nszoqMjpGBO8QYv1HoYp1NKI/Kkp8//kjW2F+6OgrGyAICXi4xsl1B+08m4PvQCpPmB8lM07fea1tbSfMd3BYni/dQ5gMBym4dwYHB6LGOzu4QGy8ZUK2ctW6GrHZaCgNXZn0+p24Krs9H7hYsWiqKJSm+PkSQP9zwBzTSfPyGy2vWBWax5JOebmdByyXbN8GeOd5pRIVpT+jQ+VzfidC8tJ8ip2x4PH0IRBDfFCpOZYgHnCfSn8G1wRfmWtW2tXEnO97dwGji4E1UU41zUHafvjk64Pqu9wUWRpJEkMJ84C3zJp1NMhrDO5+CN28nIc6ep+lMxna0ylmFlUSU5NHZWJqe8qcBUhSoJCSBj2RympoZAb8iuFQqZkgMzqmEpi+Footc5KqmMVHH5m18Ae97iBhdmN0YubxyFReo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(2906002)(44832011)(6486002)(15650500001)(82960400001)(478600001)(41300700001)(4326008)(8676002)(66556008)(86362001)(31696002)(7416002)(5660300002)(8936002)(66946007)(66476007)(31686004)(36756003)(6512007)(26005)(186003)(2616005)(6636002)(38100700002)(6666004)(83380400001)(316002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhPNWZxK0w4RW45L3ZTTVZUTVJlS3VIZ0NDZmltTzBlUE9yNE85MFJ6YWxO?=
 =?utf-8?B?bHdGVHpDWmZBMEFIRmd2NTZKUWNraXg4blhXSEk3Wm1xdHV5d0J1bUlvcXcy?=
 =?utf-8?B?RjBiODZNSmsyZi9MbmZobTBia2ZmMXo0MldCeXIxblVUcktvNjB6VDRTWFla?=
 =?utf-8?B?dVdKWXlDNWxNeCt2b3d2OGdBTjZDVU5QcTZOTGZlUVYzNkpsSzVkeHR5eGlG?=
 =?utf-8?B?eE4rSVN1bGRSejFadENDdXJjKytza3hKM1pSOVdXMGNpSzJoSXZNVkVZdjMz?=
 =?utf-8?B?RklMb3VFeHYyUG9Rb2lFWUt3TGFEVmlhTDRuWnhoU0JFaDc0UjlwV2N1WGUv?=
 =?utf-8?B?WXkyMFB0b25JenFkZU1DTW5MNEZSVzBUUGtZZ0dGSm8rVlF6M01GVVUvd2hT?=
 =?utf-8?B?MS9SbEdLWXlSaXB3WFpGM05sK3ZpeDkvT2xsUnE2UWliRTBwN0NkbHFRRFJs?=
 =?utf-8?B?L2ZjUlJ2MEE0enNPSGFxUFlMYkYwSENDTXlCeU93cjNQOHRySjRsSkdKTHBD?=
 =?utf-8?B?VmZWMWtXKzFFdThna01hZGt5NWp0aU9tU0NRY216elpwelh0ekl1QTVLYVBW?=
 =?utf-8?B?SktpU2VGeXNYZ1NjT0Uvb3BBeTgzNmN6Lyt4cU4xTC9Nam8zR2tJaDlGVnNv?=
 =?utf-8?B?eDZsYXBaaGQrSmJ3a29lRnBCaDA2Q1FDYWNaT2lBTTkvdExqR3ZYNDRTRFBQ?=
 =?utf-8?B?VFpjdzJldkZsWWJpclRBWVBrRlZMZmRublVYekdScGpRRjV3NmRkVnRaU0FU?=
 =?utf-8?B?VjhuSUlGTHJpVlJkMGtnajJaemkrdjhVandUcUNvaWxVandSYUs5b3BHR05k?=
 =?utf-8?B?c3Nyb1RJWE1nTUw4akpBTXlEaXpneHY1NW11ejFXZ3pMVUpOeE1PK1BNeU5r?=
 =?utf-8?B?eFVHUExJWHVQcDl3bzIvejdHN21RTDE0eXdhVnJRdHpsZjU2UUtqczIzclFF?=
 =?utf-8?B?TlY5NWRTTWF1a1h0T2oxT1hYaTFvUmUxUEFrb2FkaGlnOG9QR3BnY1JsRGFi?=
 =?utf-8?B?U3RpdElkUm5KTzRCaEJCSlpNWDZMQ21KMmE3S20rRmhuM1JXZFdrSzlwMGVv?=
 =?utf-8?B?dC9OaDVJOFhDbkgwOTMrSVJTcEk4d2tQWFlMOTNweFFKSHNtWm9MVmZpeGYw?=
 =?utf-8?B?bnAxd2RoL1hYWGovUU5KaGw4K3NvaFFtMHg5YVFQN1I5YXlVQm1paVRUT3Rh?=
 =?utf-8?B?cmFLUkVEaFVsRXoycWtQL2FQcU1XMzJ6V1ZHSTlaa09naXBUWUNRR0VjTnNR?=
 =?utf-8?B?V3VPa1pTM05nak9yUkcwRzE1bGJUZ04yc3JMelRhQjRLV1M4aTBOUUZXS0ht?=
 =?utf-8?B?RUM0RkU3RzBvajlteXZZSWx1Q201by9PcmZWQml6Qmg3M1VTL0cveCsrb2lO?=
 =?utf-8?B?TmhDQWVYem9DTFlncUdrL29RWUwxc3NUYnIwVjQ3bHhybGYxMXhhVXZwYTUy?=
 =?utf-8?B?b2pZcytYQmpZV1NtdExsRjhCZ0JrSEIxRmU0cElDdkg2d3J3OStQdFVZY0h4?=
 =?utf-8?B?SmxCZzdkODFNZjdsZDBBY0lZMXBFUjA1Rys3U1dlUVloNlUrZHZla1I5MnFr?=
 =?utf-8?B?emNsZmFlK0o4Znd0MENBckhWSlVadG0xRC9qb3Fld2VCR0llNUtYdUJoMTJi?=
 =?utf-8?B?M0NGcVdjRzFRYzJMWCtSWjM3VGFteEN1ZFBObHpnYlorUW9aMWhkeFdRYXJz?=
 =?utf-8?B?cExDOExEdUl3OXFOUmZsRGRZSkNYQTRSZS9NWlNJTGZFOVc2T0hxTEpMTGlo?=
 =?utf-8?B?Q0dVaVQ2QzlMSHUzRHJqWkRJckRDK0wvVVZnZXBiRm9wMDVYenlldUJJWHl5?=
 =?utf-8?B?UDVqMDk4eFFVRkNEQ29ONGgvZmNNVzVtczIwU0RyR3lGNkNyQURHeFpycURM?=
 =?utf-8?B?NHBSZFdDNEg3L2NWRWQ2Q0hCc0t5K0tuQ0FWWUhpbzVJY21uOFpXUVNTbS83?=
 =?utf-8?B?eldwcDIxS2IveU1uR0hJQjB5Mi9KdGVKRUtBOEZjeWlQR1N6ODhQL2JoeHg0?=
 =?utf-8?B?VDM0Kzh6OWI0SGhHYzFLVTdoSFR3ZXgyTDZ4SUdZVE40eEpjSUw4UEVTV01B?=
 =?utf-8?B?aXBjLzVHaFVRZzBqclZzeWdvNStQazlwUDlGaDgzM3E1WGFXMElCMkJENndq?=
 =?utf-8?B?Zm5IMmgwS2dvcytid0NlV3FPTG43V1p0emJWY2VoSHdjZXhLVk5hdzZZMXEz?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e853a2-d5b8-4af2-5e28-08dad7bbacab
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 18:57:08.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgpPqjXYnwcrAf1fcBWCMDogUkMPyJFOXHTscmDk7I9uOlyjcxDom3NOP+cYCFSGiDJejV69a0HgAXvhsPe+nVwoyFF7RkSkcTp4vi0nvfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 11/29/2022 3:10 AM, Peter Newman wrote:
> Removing a CTRL_MON or MON group directory moves all tasks to the parent
> group. The rmdir implementation therefore interrupts any running
> tasks which were in the deleted group to update their CLOSID/RMID to
> those of the parent.
> 
> The rmdir operation iterates over all tasks in the deleted group while
> read-locking the tasklist_lock to ensure that no newly-created child
> tasks remain in the deleted group.

The above describes the current behavior. This is great context. What
follows in the changelog is a description of different fixes. This is
unexpected because there is no description of a problem with the current
behavior.

Could you please describe the problem with the current implementation? Next
you could state the two possible solutions and then I think the reader would
be ready to parse what is written below.


> Calling task_call_func() to perform
> the updates on every task in the deleted group, similar to the recent
> fix in __rdtgroup_move_task(), would result in a much longer
> tasklist_lock critical section.


I so still think it would help to state that this additional locking
does not help to provide precise CPU mask. Especially since
the next paragraph may be interpreted that a precise CPU mask
is lost by giving up the additional locking.

> To avoid this, stop attempting to construct a precise mask of CPUs
> hosting the moved tasks in rdt_move_group_tasks(). Its callers instead
> perform the PQR_ASSOC MSR update on all online CPUs to ensure all
> affected tasks are notified.
> 
> To measure the impact of the rdt_move_group_tasks() implementation
> options, the following command was run in an rdtgroup to produce a
> 1600-task workload:
> 
>  # mkdir /sys/fs/resctrl/test
>  # echo $$ > /sys/fs/resctrl/test/tasks
>  # perf bench sched messaging -g 40 -l 100000
> 
> Results collected using:
> 
>  # perf stat rmdir /sys/fs/resctrl/test
> 
> CPU: Intel(R) Xeon(R) Platinum P-8136 CPU @ 2.00GHz (112 threads)
> 
> Calling task_call_func() on all tasks in the deleted group increased
> task-clock time from 1.54 to 2.35 ms, while the IPI broadcast reduced
> the time to 1.31 ms.

Thank you very much for doing this testing.

> 
> Restructuring resctrl groups is assumed to be a rare act of system-level
> reconfiguration by the user, so the impact of additional IPIs resulting
> from this change to a CPU-isolated workload is not a concern.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 +++++++-------------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 59b7ffcd53bb..4a3c0b315484 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2401,12 +2401,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   * Move tasks from one to the other group. If @from is NULL, then all tasks
>   * in the systems are moved unconditionally (used for teardown).
>   *
> - * If @mask is not NULL the cpus on which moved tasks are running are set
> - * in that mask so the update smp function call is restricted to affected
> - * cpus.
> + * Following this operation, the caller should update PQR_ASSOC MSR and per-CPU
> + * storage on all online CPUs.
>   */
> -static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
> -				 struct cpumask *mask)
> +static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to)
>  {
>  	struct task_struct *p, *t;
>  
> @@ -2416,16 +2414,6 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
>  		    is_rmid_match(t, from)) {
>  			WRITE_ONCE(t->closid, to->closid);
>  			WRITE_ONCE(t->rmid, to->mon.rmid);
> -
> -			/*
> -			 * If the task is on a CPU, set the CPU in the mask.
> -			 * The detection is inaccurate as tasks might move or
> -			 * schedule before the smp function call takes place.
> -			 * In such a case the function call is pointless, but
> -			 * there is no other side effect.
> -			 */
> -			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
> -				cpumask_set_cpu(task_cpu(t), mask);
>  		}
>  	}
>  	read_unlock(&tasklist_lock);
> @@ -2456,7 +2444,7 @@ static void rmdir_all_sub(void)
>  	struct rdtgroup *rdtgrp, *tmp;
>  
>  	/* Move all tasks to the default resource group */
> -	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
> +	rdt_move_group_tasks(NULL, &rdtgroup_default);
>  
>  	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
>  		/* Free any child rmids */
> @@ -3115,23 +3103,19 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>  	return -EPERM;
>  }
>  
> -static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp)
>  {
>  	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
>  	int cpu;
>  
>  	/* Give any tasks back to the parent group */
> -	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, prdtgrp);
>  
>  	/* Update per cpu rmid of the moved CPUs first */
>  	for_each_cpu(cpu, &rdtgrp->cpu_mask)
>  		per_cpu(pqr_state.default_rmid, cpu) = prdtgrp->mon.rmid;
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> +
> +	update_closid_rmid(cpu_online_mask, NULL);
>  
>  	rdtgrp->flags = RDT_DELETED;
>  	free_rmid(rdtgrp->mon.rmid);
> @@ -3156,12 +3140,12 @@ static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
>  	return 0;
>  }
>  
> -static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
> +static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp)
>  {
>  	int cpu;
>  
>  	/* Give any tasks back to the default group */
> -	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
> +	rdt_move_group_tasks(rdtgrp, &rdtgroup_default);
>  
>  	/* Give any CPUs back to the default group */
>  	cpumask_or(&rdtgroup_default.cpu_mask,
> @@ -3173,12 +3157,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
>  		per_cpu(pqr_state.default_rmid, cpu) = rdtgroup_default.mon.rmid;
>  	}
>  
> -	/*
> -	 * Update the MSR on moved CPUs and CPUs which have moved
> -	 * task running on them.
> -	 */
> -	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
> -	update_closid_rmid(tmpmask, NULL);
> +	update_closid_rmid(cpu_online_mask, NULL);
>  
>  	closid_free(rdtgrp->closid);
>  	free_rmid(rdtgrp->mon.rmid);
> @@ -3197,12 +3176,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  {
>  	struct kernfs_node *parent_kn = kn->parent;
>  	struct rdtgroup *rdtgrp;
> -	cpumask_var_t tmpmask;
>  	int ret = 0;
>  
> -	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> -		return -ENOMEM;
> -
>  	rdtgrp = rdtgroup_kn_lock_live(kn);
>  	if (!rdtgrp) {
>  		ret = -EPERM;
> @@ -3222,18 +3197,17 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>  		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
>  			ret = rdtgroup_ctrl_remove(rdtgrp);
>  		} else {
> -			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
> +			ret = rdtgroup_rmdir_ctrl(rdtgrp);
>  		}
>  	} else if (rdtgrp->type == RDTMON_GROUP &&
>  		 is_mon_groups(parent_kn, kn->name)) {
> -		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
> +		ret = rdtgroup_rmdir_mon(rdtgrp);
>  	} else {
>  		ret = -EPERM;
>  	}
>  
>  out:
>  	rdtgroup_kn_unlock(kn);
> -	free_cpumask_var(tmpmask);
>  	return ret;
>  }
>  

The change looks good to me.

Reinette
