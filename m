Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA37C666719
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjAKXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjAKXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:22:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B873D1C3;
        Wed, 11 Jan 2023 15:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673479331; x=1705015331;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R5qoZAudTyrQ8qVRGIDrUmf0hcciagpKKnQ/kuCnzUU=;
  b=PEcfYF7i4kGmsrUnkPnwPcTTWBCSo6UZEmfLzul/404qS1YiBHZGuV0I
   OMXrxr6+JJv/2AQFfTYMWQyJawCTJMnWuE5spW+2CpNKfRun+F1u0r3VM
   TcIIFF4ajzeU36YwcPJ1zs3IyJJ/u46pgwgfxpJYq/oEPFLWUB+PJ5Zq0
   JNmEm4cIBMdyRxublTJ9bbcsH9DWzMx+T/cM2wTFmN/brywenaznZUVWq
   xh/k7RlktTpRuy8UCG9ceM6n1jCB8bRJy+iK/ya5buLh2IuFoIVJZFJhW
   4/iD/I5SMF7qf3J0iw0GavXLOHOCwEm7HacPTTiC5+ASfdGyZlOgc4Xoc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350789729"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="350789729"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 15:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799998365"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="799998365"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 15:21:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 15:21:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 15:21:50 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 15:21:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj4KGyDRBBoh63UUPGq5DJPzvlMcxcroxkO6clydxEvGc2pUUbBAsqp1RvUYf3evSSKbInPS/E9s3aKEmSviievdH65UalHyWSIwnoop2oEy7l04CIweP6gnmNaYAQvGEYxJBiARpLaPqzGaJvxIEh10YWobUjiDLNZU6JUQgFAwfu44cgZCDo5LTfx/YagNv7Qyg5iaxBegnAiyxSD/uFBx0UT3pagJjB6l/WKFOkrbQhjrcqDQ8u3s89aloItIKK5y8FdgjEuSH3YCNrThzae60j9lrOEjrUYdYekaXz1wRpn9PEBAVUidip8LFIYVptnfMItnFbo+AxM8XwC8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN1ogPmuXNlNOF+zk14jl2pwYVlRNlQycOjGSgjgwT0=;
 b=XYFsE61chD7YqpWK0DmtYIZpVW9JpIzXkN6y11FyfoEX586Herwp8ngyga/r3YBMDHKcZ3XGh82kudzFMmKlfZYOjGfVu1HodPhZQYTUM5cDdRCGNcv/T+AUUH4tYcNUr1e0CAYpu8ipLuSO0bJOJMWlFbLTGz0Amwp9S/o5LsiIjVYBkRzGyRRvY5qKVfhhWSnwJgePMT9KVibeBpnOW3VdjBo1moY5+xx15CnSpCXt9MErx4SdOskGUH0i5+mA2QgjivC6p6DifwkRtFXoTn854gx9LdsvdfO4nXDmue/wKRd2xr2yMtED1QsJ7jfYw8Di3ik1mZK74OWek/kpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 23:21:43 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 23:21:42 +0000
Date:   Wed, 11 Jan 2023 15:21:38 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Moger, Babu" <Babu.Moger@amd.com>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Message-ID: <Y79Egt98ZoWTr3Nl@a4bf019067fa.jf.intel.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com>
 <Y7yiwOerGiEKAF9i@araj-dh-work>
 <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <DS7PR11MB60772F09B9749307CFA0ED0DFCFF9@DS7PR11MB6077.namprd11.prod.outlook.com>
 <Y77ZAfhc48W41FGp@a4bf019067fa.jf.intel.com>
 <SJ1PR11MB6083AA5292C11145BEEBAF6FFCFC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083AA5292C11145BEEBAF6FFCFC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b5e784-7816-4f97-abaa-08daf42a9910
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3/LRZ2bppKNNqEhMF2oPG2dNl8r1EHfCpwub/c2ZW1S0KtQkg7enLC1CsToTrJQO8HdULmd+r5ObvRJlIBjg1+yr20opZXD27aALlezyKMllp4FmwTBUGSLY1+W5Xd/JbHEFC3VFNAmNHMpvrb55Q5Y6o5yR3fMuC9bbLwYZhns6KFK56zKXtibsPhTzp6O2/BYrEEcvmzwgffd4ZogwmHA2tB8i3RZrvTsr8ES4cMThEyt0/K6Ep4jAmauZ8BQhnqk3hF3RqnXGvPl5QXRHWbv9ffQWm6rfG81XjufCuvGONcKH/xSxWaZj5zIwHmX6c7W91QklfxuKbzoat3DXWLnk7EDo9hWcAQW6UBkh1YarvrRom+h5OZMxcd2ADZISxZWLzEraoHzRVtcKJJbSqtZLPwpIdWzqgWvIYhyCbBF7eyMQLEZ+GrsJ+EwY0tZiHitLrf9MDxl0AnU+Cs0EF7XdVqkAoGrWB/ibLFwSZTxNrcP/zBF4+0X2DJv4D7Ecq3EL+1+GeFgPC8rZYwzWlc6zph4Ux6rKeFIqSOA9xGdHvBvpjsXMmZNoLejwEbWD9HVNPLxhw79nvuwz4NekOFVBC7JQ721IK+AImecAHX87ZRX6pTepLu+u54eI9VsQS7MGlUIN0laow8akTnhbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(6506007)(82960400001)(6666004)(38100700002)(2906002)(7416002)(44832011)(7406005)(478600001)(6486002)(186003)(4744005)(6512007)(26005)(316002)(5660300002)(8936002)(83380400001)(6862004)(86362001)(66476007)(4326008)(8676002)(41300700001)(6636002)(54906003)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UjkS2VQ1jdwwDQGShu0I8FKiRHzb3+ITKInB2pm15H8lb5xuugqT/TLCtCBG?=
 =?us-ascii?Q?n3n9XA8nVsC2iqGKw1Rf8goEpiNT6JntwytBxuvJ6qDO8c3JxBA+kllBxzJx?=
 =?us-ascii?Q?d+isR/FhKLanLXbNqfflcuNbhM7Es4GGmK0rGLBTtg0o44G5guQ3nBkJowMQ?=
 =?us-ascii?Q?Ox9F2ujoPUvc0s9MOmPBiw1AsChpfUeu27xZJ3YgyLTZfqfXa2nAuDtmTtiZ?=
 =?us-ascii?Q?c54auPXemM2g4FHACqgPQvB9APbgZFvERpsu7VbF5rc/HeEMOFfX1TzHst1L?=
 =?us-ascii?Q?CoSqBZkdnqdexjM1sNOc7kDreXHk7uYtAPNSBJxKFpbZpSkMyMuxuD1JT3s7?=
 =?us-ascii?Q?v3C/pT5D77BxhtjkNy96KN687DgfXhN0fOqPaFt8OkJI0Cj3VTojCVfFBPxd?=
 =?us-ascii?Q?S4G3c6p541UUROrolZUcd5NLmUrvgEK1b+sR3gWPoVPzOr+MmtxhuWE/lq7q?=
 =?us-ascii?Q?cBYpBB4a9NDd80vlUzuV86rW1OK5/XackrNd9gji+9M7xEpAPEnjgNe9bMr7?=
 =?us-ascii?Q?KpHAzKS9wAtfKfJFOrL/Gf+87Bqheufb4KelMO7n7NqImkAqB1zzA8m9dls5?=
 =?us-ascii?Q?N/TRCpz2sJHs9CmdQ6OutKN0p/FZ5DV90r9kxpdI0za1U9mRTCx4XKs5P6Pd?=
 =?us-ascii?Q?yI7Gri4td4mDyUp7gkNwiTxcXNDPwq7z1OUMHYL8sz1YkNi+x7Hv3o8pVgo+?=
 =?us-ascii?Q?T8fv8WMUBijdOuLcJ7sJ0k/OB0Na3+/aizMEmTtkcRfKuk2TUf4wiV3KeRBB?=
 =?us-ascii?Q?g/EZQPTHNrxh9Tl81j+unSsWsNUao2zQlKQDcGbdW1jti0K0QhuY7u+bzroG?=
 =?us-ascii?Q?JMMAGUgLFEUcz9nIu5SZ/oU1bUteTlwzCZfzaH5ZqQVmV+DV0gGqqWxDIhou?=
 =?us-ascii?Q?toiJnSvoSLSqmry9Kpuz1p7qPgB/OnfCxf+zrCSgAqdjgQfsKaW2Dlzb0YQz?=
 =?us-ascii?Q?WdW6zwMIAhhMfGNtedOe6VyI8THXHZ7pgEIyXpwIO8ApsgvO9E+at15uc2AJ?=
 =?us-ascii?Q?iLffxvPx/vypoWCr8JeJJ0xE6VPC/RpWFXPlS+zr/Zmkp/ar7a68IJTSk9iH?=
 =?us-ascii?Q?0AHax/yFDbOPZO5pUpk4mAEiRujfnpCW42VUnn9NMnBpOp85AofAxGeKao6J?=
 =?us-ascii?Q?tRCbHMUfCLpPoBmYtvwHER2vg6dQ5OjgDvn3ThMaz0ssaFuybSKLb7vowP9L?=
 =?us-ascii?Q?TbDWreh+CjWIK3H1RvtYj/TwKuKxwJeoqSxfq8Zo9kfsOfi6mgKsCdMh4HbX?=
 =?us-ascii?Q?pROOngQCozv1zz16BQftjQq3lffeUGTctaKXIB+1UiGkXWeQfoBrT7Ebw2D1?=
 =?us-ascii?Q?r35hEw1AZBG6XJQkt1uuIIzzKFAGPnzAAE8Flr0EYRCLkBSgSqZQj0P1RzYh?=
 =?us-ascii?Q?Mhy/c17kWPdP1IYcOm6ydIgkj8n3QEh8TaEc2rHikwDzT5l1O8/SFGKg1/l6?=
 =?us-ascii?Q?2aNa8FxVyFcdw9cL62A5Cu2AryPXCYBSPY23GPmrud0WR0wq49VE8DoaxXFT?=
 =?us-ascii?Q?DFtW1E2cfEFDxCrx1zYKpIHEdVEixJhNMAK/BHTIN5DiJqpUE50kUndytjhv?=
 =?us-ascii?Q?nrC6sZ/jH5VXRoCfh3/IEHJC/erlxnAG8De13MnjP2DgzF8xh5OChyzs1kOa?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b5e784-7816-4f97-abaa-08daf42a9910
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 23:21:42.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFCSvaX1hHkiaXPh6hsPviTbaUJPjnT75Rghq0nuaqpXuvPnQXcMSVx9yXbrKv2GPSu9z8UFP2ogDtsSJqZI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:05:48AM -0800, Tony Luck wrote:
> > I wasn't sure if the few ms difference is going to make much material
> > difference for that process. IPI's does shake things up and introduces
> > other overheads not related to this process.
> 
> Is it just a few milli-seconds? What is the scheduler priority of the kernel
> thread you wake to perform this action? How does that compare to the
> priority of a RT thread?  I may be wrong here, but I think an RT thread can
> block a kernel thread from running indefinitely.

That's a good point. I don't have an idea about how the kernel thread
priority is compared to user space RT threads.

I assumed that since these threads have some work to be done from kernel,
user space shouldn't get higher priority than kernel tasks.

Uncharted territory for me ... Just a hunch :)

Maybe @peterz can screw my head in the right direction :-)
