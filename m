Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FA64613E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLGSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:41:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570947328
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670438480; x=1701974480;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CPU9IOyKs7+xKsPYh82QXuD4mjYNdKJbUfTwF1/Ouio=;
  b=G5m73GROYT4EpsOYX+No5AFq2Q8XvWsWkcuTDwy/xhzxKnUbmkUoe86n
   UTjHOSbhr349fonr9BOA5LpmsTejvx1jkHMcImGTsNF5zU/xaP/qMH/pw
   uv9cFZ2s90maerNtIQWpEqft1hT/cEhCcKWG4+aqmHa3VGzw1g6WI19nc
   KxOgPYquFQJfDOvi9Lp1I/OOiZz7Gr29xofvKINf2YKVF30FBKvANpQvk
   YYrTFtKeS360I/72qg9RtHLYb2KFS+SoaeYlONfDxgb0Z45ojca47Wupz
   WsMk0NkHlC2XcAvh37wumxOurNUnXJCn7gu72oX/8DPYbbjUda9ywZp/g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315684902"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315684902"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 10:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="597063639"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="597063639"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2022 10:38:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 10:38:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 10:38:46 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 10:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO9Y7ZqmjigCzHb6j0wy+6df3Pr6J0gsqcliKGUND7k/H9rZxvS4WFRssmh4J/fdc0Uyjay7ZhdK+gQevKNaFF52tGNwa2eg0AblP4Uj23BC7QFOXv4e4inEslXcg1kNueFJE17ZT2OLh1/2Pa8lMR3NmggsXJIzf8Coqr9dm+/5+rtKvR4GtpdB5rMrRVVxItMr+0142OGxXp+Waot4tovKQxLtVjWuplnbeQ8hyH0HBqhalJDNTASxpxXuHtSMLIM8vjbvnl/SHU5rzLVfrTFB0JLELc1/bTF36h8IZYp9XYTNMzfvd/LS2YMgMGttNxIZ/Y8ilWuL8MvcNYcUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXv9CDcJdnvgiRxF+AeKMygV8A1nBglXQ0EIsOLJI4A=;
 b=bLCG6Z4zzBv6cKAmR/54mxw9AfDvGKTjOQMz1KF76m76+PLVjxXut4XUliZT3yZ3nPRRLKZ2p+nh8Jr4FuNQQuckp3tBap2BlAaZi96IXf7ZhmFWDGC/6KaIIcVJWjxe7KiUAeau7cIaeXvF6DAIZdpVTazrWveVL1KIjRDTnuF4Ju65cp9eYgxBoyeu5ceUk5BTAVM/ClXLI7uuKZp9/+XbwKudnNpVyvagiMRXpZc1Yy49TV7dGQJqLgKlxWsZNguohVQDQS8clhm/4Z65cLSDa5/PYFkA5w5Aeafec+5fANQOT4/VkFZBBa+ffRfw8PQBRA5D7e83MgzxICg2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:38:41 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:38:41 +0000
Message-ID: <e28c1f27-f320-511b-e5ea-c278a570d709@intel.com>
Date:   Wed, 7 Dec 2022 10:38:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with
 task_call_func()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <bp@alien8.de>, <derkling@google.com>,
        <eranian@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221129111055.953833-1-peternewman@google.com>
 <20221129111055.953833-2-peternewman@google.com>
 <a713ba13-634d-3061-933c-25a8d62eb0be@intel.com>
 <CALPaoCg6YROmpFa_RCYOCDzHBtR5tSCh2JwsOwPPpzBraOHK4Q@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCg6YROmpFa_RCYOCDzHBtR5tSCh2JwsOwPPpzBraOHK4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d88e46-7dc2-43ae-d15f-08dad8824309
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wxt6XmclsOacBKX0LfENl1pcA7VSMYnFHJfwLcipp9QYAajJKzn6+FyQsBhwo1Gyms72+dvga3uWvGzqcCmbvGjhqMuEd2xVS2hPAqGwz+sI3FKr0ezquNiJOt9HQlbAXoDlM5TxlnZf8GJwkH1Hc4vux/P5r34D/ej5zrNu5wUEoiy5zS1wOyNjJdtzhT8BVGltw3LU3ca4Kix0X0yCBni1nu7ULgo7FrbbAGuVLpUEdRkf5eGb7VPjR077D5otZtursxjc3CmqggANdGGYRqt+S89ywYYUuO6+cI1SgXCIKqPIeLiTJyBcmaLO59VHb52lbosUEPlqvOuCjr9LBKHE0q9pbRxUGyi0jxrj9aqAmzB3MYvVK826j2RIKq0Wf14oCKYVj+KfM4lGhTI2h0ROvsGX0/rnNOIG/fBFuFg7lj+BO3aRwveTGS2HEOOgxcrtVZ7GgPlksr85HjJPN1rhIH3gNUjbR9rvOWm5uNLGJY9YWsw3rKHSbc7XSMmT4iyyNgV1dG5MyvMK015j0uQdulxvBJCvkqK9TtLVr3No/JepJxb1WnPhlqV1e/yo+Skjj6iSucNaodpsXH9FU7AMryG3xtp8ar6Uixbc0n4iKBcVKehzKEtEsyFVPHdJ/JrLmln3jRx5YF0HXgS3RPgSpKROB6GCReBDr6zZn/fYDF5ri4v50KE0uZJNT9TlOorIqApuwod2VtzrKL/rdC78c7cUTIPnx2j+QUEoMaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(83380400001)(6486002)(8936002)(31696002)(86362001)(44832011)(82960400001)(2906002)(15650500001)(5660300002)(7416002)(41300700001)(4326008)(186003)(6666004)(53546011)(26005)(6506007)(478600001)(6512007)(2616005)(66946007)(8676002)(66556008)(6916009)(66476007)(316002)(38100700002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZubDJFTEJWeEwwTURQU2R2ZHA5RkUxREJ4YUVMdWtkanJHREMzK1F4Sm4z?=
 =?utf-8?B?TWp0Szg5bUpxc3d3Um5oRlV0V1dWTHFSelIwcEdPTWs3SisvcS8ybnNxck50?=
 =?utf-8?B?MEMxZXBqQ1RTV0pNYWk5T01NTDZmMkZzaEhqOHcvMXZULzlSRDd2YjlVNTkw?=
 =?utf-8?B?eFR3ZTZmM3RPMW95ODFqS3F3V1J3Vm9sZ2FkSFN6bDFrL1NIL1cwWnd6NVF2?=
 =?utf-8?B?RFg2TGJaV0hPMWZNQU9uQWNwZXFUakVQNm5kK0Vla2llMGNpSGgvclN1cHo3?=
 =?utf-8?B?WjZVRjhNRUVNc0RXaWVjSnVwY1Q1RHRBbFpmZWJMaS8zMlVUdm4yL3FYamJj?=
 =?utf-8?B?ZlJGNmFUclJFcW1XVzRjZnVQVUdjZmJoNWI3RDdXZlhZQ3NndXkyZEVneU5R?=
 =?utf-8?B?NXBGWnQydU9RY3g2dEVNdkFUMzRkUXhtT3h3UzdrUTdmK0JFWE5ZMGU0NDFQ?=
 =?utf-8?B?V3M1VUtXVG5ENUJtMlhCT1EwVFlzY3VEVmZkZXFzMFRCaTUxeHNoZ3ZLZFV0?=
 =?utf-8?B?WE5wQnRoZDVzTm1SclprQzBueUxNTFJ5Y2dPK2ZlTVFLRC9GdU9hWWt6bXVj?=
 =?utf-8?B?ZnVNc1pzRDZMMlJtcFJNSk02OXBzUzEySDJxaVJxUkg3a1dJaFoyTk9jNTV6?=
 =?utf-8?B?eE4ydXBWTmZ0amlpMldjNkZUS2hnYldOY2lmMDR5dk5QRGVpWGtROU5ma2Ir?=
 =?utf-8?B?Rk1Dc1FrT1AyUWkzcWtyRDU5YmpnektyeWNsTlhsQ2JhYnplemM1VldyaW1N?=
 =?utf-8?B?amNWV2RWTkREbzBGbWdLMUtiajZ3ZTBNK3FXSDJXYS9lOXFIWU9SQjVjak1o?=
 =?utf-8?B?STJxQWk3SkxrK2pDN3ZNT1ZzY2xDSUlBSkhOenBEbXdKZ0pmZWFXSjNxOWVQ?=
 =?utf-8?B?MGJkUnJZZ3NjaTcweEtRVzdNRlN4M3FEelZ1RnE0ZVZiUC9iVGM1MEpVMjZJ?=
 =?utf-8?B?ZnR5UlJ6ZlNrTlFSYzUvRU84ZG1mNXdPN0UrTHBLT0R3ZGszdFNTVXZwUjd1?=
 =?utf-8?B?QTdiU1ZvVURLTFJLNUdBRFRUYjRTUWZHd0NXZlg4MlZ1Q2pmVDg0YUJnS2g4?=
 =?utf-8?B?a1lHaDVla2tsZ3E4V0pEN0w2VTRNWXU3Z2VxbTA3VHJFckZEdkp4a0wyRUN5?=
 =?utf-8?B?WjY3NnRlckZEMksrL09PdDZmeEdPMFByK042MlVIWDB4U0xrN0wwcWV6cHFs?=
 =?utf-8?B?Y1BCSGs5Z0J3ak83Zko5Y0xjOTdpak5IaGdXZzJQdjRldkFud3NQQXp6MUdu?=
 =?utf-8?B?UUxPZVZqWkNVNm9YeHkzRjFtcWduTnNNMklrVGJDZHk3SmJlQWZpNVpmRVhW?=
 =?utf-8?B?MDNKN2tQQkNvb2JmSkEycktjN25oN3VTc3I0b1VZaVZZdkNtSlFQT21zQm93?=
 =?utf-8?B?VmIzWkYxdU9XWUJ4cmtPcVFPSkVDYS8yYlp1OGlNSDdZRDJVQzZzV2lRNk9t?=
 =?utf-8?B?dWhWdVQvdDd5TFRINlB4cENkbWhkYy9oejVFMTdKZis5TTcvb1o0N0Y0aEdV?=
 =?utf-8?B?OGVldXp3dDlmRjNrQVNqMHBmOEtFRkdRL2lqSUVZeGpmTjRTVGlJM1RSSE5r?=
 =?utf-8?B?SE9yZDRycGFBTTBNTnA1Vmd6SEUyMGIvR1pXaCtBK0ExeDRNdkRXRGtORUNL?=
 =?utf-8?B?M1lPdXVrQytWckJWOXB6bmpWcFFnREFuOXp3d1dycHV2WkFBdStHNVdKbktl?=
 =?utf-8?B?TzdqVXhLMU1McGx2OGhSTklzVzdwU0VUdldZN1ViWU1ZTGlXbXNBZThka3Jo?=
 =?utf-8?B?TlFBMVhyM2swNXUvLzdMdk9NNEZCb2RScDB3OTE0ZUp5dmNoaXZ1dk93ZzNM?=
 =?utf-8?B?bVdkTnFkQmVOWGJOek1ncDIxMlUyOEp1U2NNbkNaaW5jS2l2ZHJFZW4zV1ll?=
 =?utf-8?B?cWxTdjFWejU0WEtpcElDeWJwTlNZaU1PbHkrNm9DbkVpTDByNFlrRms5S2VV?=
 =?utf-8?B?aXhUejh1amZMSVA3a2VnSEVMaVJ5SEQ3RlNaaHVYTTZwSGl4V0tOK3hnMGtq?=
 =?utf-8?B?by9BNklZZFQvRG5HK0YwVmtnN0NsMjJWUkVBaFRxcGhmckdiN25nUzBKQkFJ?=
 =?utf-8?B?ODRJenhrUWxnZXI1bDlNdzk5aVI2QW04ZVhobkdMbmErSHNlVGt1YVNVYlNx?=
 =?utf-8?B?VVNIbStJeHo3WW5XQk4vUm16WjVDVXZTWklkdEN6am1MdGwyM2l2d1VvaUUy?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d88e46-7dc2-43ae-d15f-08dad8824309
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 18:38:41.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiMo1DapTp3oL89K5ykUT44fq7zLLAsV3dYNivXPkGUWPpkGh+zkuhh8lVv0JKkEVwpwPQDiiVJT6dyirvaxYtTvZMCD7d4y/ljhLVSwYPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
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

On 12/7/2022 2:58 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Tue, Dec 6, 2022 at 7:57 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 11/29/2022 3:10 AM, Peter Newman wrote:
>>> When the user moves a running task to a new rdtgroup using the tasks
>>> file interface, the resulting change in CLOSID/RMID must be immediately
>>> propagated to the PQR_ASSOC MSR on the task's CPU.
>>>
>>> It is possible for a task to wake up or migrate while it is being moved
>>> to a new group. If __rdtgroup_move_task() fails to observe that a task
>>> has begun running or misses that it migrated to a new CPU, the task will
>>> continue to use the old CLOSID or RMID until it switches in again.
>>>
>>> __rdtgroup_move_task() assumes that if the task migrates off of its CPU
>>> before it can IPI the task, then the task has already observed the
>>> updated CLOSID/RMID. Because this is done locklessly and an x86 CPU can
>>> delay stores until after loads, the following incorrect scenarios are
>>> possible:
>>>
>>>  1. __rdtgroup_move_task() stores the new closid and rmid in
>>>     the task structure after it loads task_curr() and task_cpu().
>>
>> Stating how this scenario encounters the problem would help
>> so perhaps something like (please feel free to change):
>> "If the task starts running between a reordered task_curr() check and
>> the CLOSID/RMID update then it will start running with the old CLOSID/RMID
>> until it is switched again because __rdtgroup_move_task() failed to determine
>> that it needs to be interrupted to obtain the new CLOSID/RMID."
> 
> That is largely what I was trying to state in paragraph 2 above, though
> at a higher level. I hoped the paragraph following it would do enough to
> connect the high-level description with the low-level problem scenarios.

There is no need to require the reader to connect various snippets to create
a problematic scenario themselves. The changelog should make the problem
obvious. I understand that it is what you wanted to say, that is why I moved
existing snippets to form a coherent problem scenario. It is ok if you do not
like the way I wrote it, it was only an example on how it can be done.

>>>  2. resctrl_sched_in() loads t->{closid,rmid} before the calling context
>>>     switch stores new task_curr() and task_cpu() values.
>>
>> This scenario is not clear to me. Could you please provide more detail about it?
>> I was trying to follow the context_switch() flow and resctrl_sched_in() is
>> one of the last things done (context_switch()->switch_to()->resctrl_sched_in()).
>> From what I can tell rq->curr, as used by task_curr() is set before
>> even context_switch() is called ... and since the next task is picked from
>> the CPU's runqueue (and set_task_cpu() sets the task's cpu when moved to
>> a runqueue) it seems to me that the value used by task_cpu() would also
>> be set early (before context_switch() is called). It is thus not clear to
>> me how the above reordering could occur so an example would help a lot.
> 
> Perhaps in both scenarios I didn't make it clear that reordering in the
> CPU can cause the incorrect behavior rather than the program order. In
> this explanation, items 1. and 2. are supposed to be completing the
> sentence ending with a ':' at the end of paragraph 3, so I thought that
> would keep focus on the CPU.

You did make it clear that the cause is reordering in the CPU. I am just
not able to see where the reordering is occurring in your scenario (2).

> I had assumed that the ordering requirements were well-understood, since
> they're stated in existing code comments a few times, and that making a
> case for how the expected ordering could be violated would be enough,
> but I'm happy to draw up a side-by-side example.

Please do. Could you start by highlighting which resctrl_sched_in()
you are referring to? I am trying to dissect (2) with the given information:
Through "the calling context switch" the scenario is written to create
understanding that it refers to:
context_switch()->switch_to()->resctrl_sched_in() - so the calling context
switch is the first in the above call path ... where does it (context_switch())
store the new task_curr() and task_cpu() values and how does that reorder with
resctrl_sched_in() further down in call path?

>>> Use task_call_func() in __rdtgroup_move_task() to serialize updates to
>>> the closid and rmid fields in the task_struct with context switch.
>>
>> Is there a reason why there is a switch between the all caps CLOSID/RMID
>> at the beginning to the no caps here?
> 
> It's because I referred to the task_struct fields explicitly here.

You can use task_struct::closid and task_struct::rmid to make this clear.

Reinette

