Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29AE5E7DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiIWO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiIWO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:59:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73980A45C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663945179; x=1695481179;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nFfBBvwXH1jpurE6bXzx9lkc8IsVXI93vua0Cb6SHAQ=;
  b=B7f+5mD5qlcnhkyC8S3n9XZyLlJ2mrbNfer0oFA0rKHQNhlocx64MiXw
   b4uUzrY9nF2AEKkgoPRGrffkU7pV7UdRrjoyARVq0pq9W09tyrCYydzOq
   2ZtGO0jVaoaFJSXvu5MX27V77ftu9NU14sOrFp59onBea/UoUNQgRp0vb
   Coxd2yr5mBL8oc7Um6eI68aNUGmpr+UZ1ZWn9MrOPyeZ28KY8GtTPyGdm
   4DJxPIwSVdpV0JyyPYSgZwx7o7MFVaQgh56cGg/AXlTyotRSzgQLuvF7t
   XN3CzgIDI/cfj1RjKhVIo8225w3twqqpLfzMMC2TvpowTlM2pxfwrU/wb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="386897052"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="386897052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762639044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2022 07:59:38 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 07:59:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 07:59:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 07:59:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btb4MKVcJ+w+G1lZPvjnxCRDaFH6aq/oCfr0RpL0j38hrcyQvhB/g8AFSkvE6feQDrbAnbtCn5GWOe6s0kgLTT43j/q5WgT8qnS/L80Ntpfl8ZShWJPUC1VAYbOzZg4LzFADJYBApjF/pqr0jlnCTghxBo/sEfEKCMNJmsNLR0nanZkdvXK63sNHrF4/suAyM/XJq1BfkodAe5Inz2kkR2Bii2qKtbGMMT14uJSdXAF37LHyk22f4bA4URFBljdmW2TUPIWNCeJfoECqDstMsWhLfPtzSVeUP/DrhIzHJ2GIVCufTQ9TqyuZmICQE7P7yl5+2a5kdOhrT5bz6fY1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8lsOI/Phm6NT646GDd77hZyu6urRzI9kkxHMqd1RiQ=;
 b=YeUJSffkTvRJGIqOU8gNWYv5qabRJMpmeEcJSQtBmiYUx8UEpOVSYUKKZOh3zB6gN2hPKD4cQdGY/AJ7vptIcA3zIzyTHpBMea3kdMOkk+lQFLeFL9A7/ZAoQ1fGdJRFkQK5EU0ACDABLI8ldAl5q8ZseFUqEn+o/pl+7XYNv7MKr0uZ7zdDDffGuI4I8vTpJNc3YRMMOd7M1YLbCz4Iz0Srfeq9avzAz5N/0Plr1bNzzJqHkePsIkQAswFrAqFTlG7HDFfNE0zkyiv26mpz/3pQjP1l3cKOdWgm/pZ36yhfkSv22uWAoGfOZSRa9XyGtQG4p16HYDpScA5ombq4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:59:32 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 14:59:32 +0000
Date:   Fri, 23 Sep 2022 07:59:28 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yy3J0PgIBfy2yVum@araj-MOBL2.amr.corp.intel.com>
References: <562dec4d-a39f-b517-58a3-45f691a2d10a@intel.com>
 <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
 <Yy3F3+PA47mzX/2o@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yy3F3+PA47mzX/2o@nvidia.com>
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW4PR11MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f79860-2d01-4708-32b8-08da9d7438b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hvz+SSd+FD0qkNuKWtbOdxVmvXk8PaTl8PUlv2qiwrRj6tSSecpHUDXINZIEQ4ENQlSGxtmDJ3RVxowNm5kurIJFc2rMZcE+3UrJ2ayPiy2vri/2okVsPoKJ9PKKQW4e7JqvioKnzY5LghMsNCKNyvESwArta/1+2QPd2WyGLnguaziGO1G4DkvNKw/gTWgKUaHvXDaBeqeUno05ocNGERv2LTptasK4fwGPz5dEghae6ZFAAw/rtbat7uackAIR5go4kFHzCzSodJRnLFJaaDeW86LHlCua9nAjk1nwCfozUwqgXR3l/NtLQP6XPWLixaFPpIwPU1sFdlHIQuSKe5j8rG1fHg+ueF1/Y38FPIPGOdQTGFR9/YCDSWA80FnJtNdwrJIrrKnQaS25aFQsh6vEP5MPj6SfT7YvXSFGVhWUX4SrgXwZh/JNFSeGwCHKmgP51LafEdhfEMlOzHaBXkrhXxvI8Up3h9hYodMuyir95BZfDAY/DItF7tF1KSEsv91p1x6nmAeKmyoy48mutPUuEQZyqKF3S+G6IXl34mqQgjPNnRmspuaobMjUovQ2ZclAj0wAdV6VC3b/WWWxc6irsBRAvydFfIskaAnNe7jNtn82kkw2EdO2k6y5JR0jwPMli1ptNXSUVwokqC6qw96FH1I5r7aBx21Hwit4iUj7rB2IVv6+LSYD0fCTHH006r21oqCMKZFrUVOx6D1F6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(6486002)(53546011)(2906002)(7416002)(186003)(316002)(86362001)(83380400001)(6506007)(478600001)(82960400001)(6512007)(66476007)(66556008)(66946007)(8676002)(4326008)(41300700001)(26005)(38100700002)(8936002)(6916009)(54906003)(5660300002)(6666004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2/jtxe/Pj0QwRpTNk8LKKUKmIxaeAs15dhR6uY1u2PvMnBX9tBJCBWSVCvZ?=
 =?us-ascii?Q?HkZRdosBrPIS6LBbQnQTUZARgXNDFtvD0+RQoQF/YWL4YWbnXYVwhOjLHR7D?=
 =?us-ascii?Q?UkLOlR99Qil7kGOv8xQFc7qt++uNacMTCUMbqxy/1ev5gJaU5N93UHgx3i1O?=
 =?us-ascii?Q?Lf1K3F+RxIx6WDqIaqNR9o0LYkhO9s6M+EaU4blipDLn2zbGaoLY8EzkveiH?=
 =?us-ascii?Q?Cx+l1pWnaZluhycgBZdFYvCV4Lniv19wBALx/Fipx6Qg6LvDoUzYPwr9/VGL?=
 =?us-ascii?Q?Cl5iuBc5yIB7SGyazsISLfePI1ga1+8//hf92yMS1+vyvJEEBh4dJZQh4WhH?=
 =?us-ascii?Q?vspUT8q3Mf/vrK6njAJuMc7GKtec1vYHRjWpFO+2+vRz62cr9ejl6TriRcfk?=
 =?us-ascii?Q?2vonzcFhSr5uLNcvqTbZBd1HzF+WzSbn3LLCSQ7Y4nGHpzq8C3URuT/YyCnX?=
 =?us-ascii?Q?Nmobm7Ou+XqKM6oTlxgFQ8Ml3wOLVWjtTfRuf0mBIcM7aCyNoeLiJB7E+5C6?=
 =?us-ascii?Q?T8aEb5m4rkCnvwitMd5JL9DyqJA1BjSvsKYEXkv7feC17I9WzKBNX3Zvnu2l?=
 =?us-ascii?Q?NTNUQQ+eBm3cMdQr11J0zvHzOs4gbShv3g161o5P2c8ARXkTnJDjUbz9xBsD?=
 =?us-ascii?Q?hKy60R0sOqHyHQ+oDczx4cHTTzUGu0I7cMEkAEBPSAm/rRABR9CziSRCVdUu?=
 =?us-ascii?Q?DgIic482fd64ppfDb10O5oWxf5DUk8F6TcNIHt+4kQH07QQrjrQ000e4+Lhf?=
 =?us-ascii?Q?lBNpCOOxUk2ZNhSiWtso2TtGjdSYAKAa0YCcvh66/Q+0juP9fhiskeXDLdDx?=
 =?us-ascii?Q?Zh93c5tGwxQMRZt8KNa7DlsDloIwFSYYTsXOCm/ZOdYpaDMP8As95fdepxnC?=
 =?us-ascii?Q?zmp4U2vBUN6bH2wqmneNCKpk8HNsRz2XpkOZZ6cbion6W/od8+Wu6/p8FNTS?=
 =?us-ascii?Q?c5xvnj5plASvPkYUqYcdoNWJOo+k246cBMS2n8+rkdH0548nsOtUXJAJyuNa?=
 =?us-ascii?Q?x7RBiJWRqY0nelt9C2fpwh1wcp6Bc6a/7G80EYyFlrIDBn3gVVD+ra1S9w5L?=
 =?us-ascii?Q?66p3p+do+6nAelqvXBHK2PnQYIxWUdmJtB7sN/INWInzHa3oInkh+6zmiHYB?=
 =?us-ascii?Q?v3C36DqtMPIViAhdZZOe7p8tCQPT8xgOmBltLZ98Wyjs9LFsLRSIy1LDwDN2?=
 =?us-ascii?Q?kanwaZJg6Tq4ONZpkmqUXyjquHF0bpqf9fSQmW0ZYSlR/BPuwSVunr9eFykG?=
 =?us-ascii?Q?DsuXrlvQrJqvR+1ODcZWnid4wiKxD+0CvoDTXJPJ/wwxRikG32V2kBD91jAb?=
 =?us-ascii?Q?Uk7kB80bfmqibfuNC4fimTxhKL1bv3vy52g0Az2lipA8oZc9OEsiFFcMl67P?=
 =?us-ascii?Q?H7U5rY1VkKnDnRBT6Rjjo7Kr4ABWjAKZqJmOBCheEsBvpoFoREsFe2kfbDnL?=
 =?us-ascii?Q?To024K+DxAEPN1HPjt4F8KOAGwmmfsLZi27H+FJzC5pJClfov7N5IcFyK8Z5?=
 =?us-ascii?Q?RHb+GEhRZZi0jG+cDC8b0+Ed1rTpvZ07YNbtND9fEX/j3v1PJKvGC1Fb5Lin?=
 =?us-ascii?Q?UU2hJJUv611yCcOhN6yQ7g+01vseO/J97d2faBF6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f79860-2d01-4708-32b8-08da9d7438b1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:59:32.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c/uwA9EQwyam69EaQ+RHcXS7WUm/qWmJmFgTfnIgLt7tMg6dxaP/0LSrz+EplFsTSCp/JDkzkqhAkzbn7htmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:42:39AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 07:18:42AM -0700, Dave Hansen wrote:
> > On 9/23/22 04:46, Jason Gunthorpe wrote:
> > > On Fri, Sep 23, 2022 at 12:38:26PM +0300, Kirill A. Shutemov wrote:
> > >>> So I would assume an untagged pointer should just be fine for the IOMMU
> > >>> to walk. IOMMU currently wants canonical addresses for VA.
> > >> Right. But it means that LAM compatibility can be block on two layers:
> > >> IOMMU and device. IOMMU is not the only HW entity that has to be aware of
> > >> tagged pointers.
> > > Why does a device need to care about this? What do you imagine a
> > > device doing with it?
> > > 
> > > The userspace should program the device with the tagged address, the
> > > device should present the tagged address on the bus, the IOMMU should
> > > translate the tagged address the same as the CPU by ignoring the upper
> > > bits.
> > 
> > Is this how *every* access works?  Every single device access to the
> > address space goes through the IOMMU?
> > 
> > I thought devices also cached address translation responses from the
> > IOMMU and stashed them in their own device-local TLB.  
> 
> Ah, you are worried about invalidation.
> 
> There is an optional PCI feature called ATS that is this caching, and
> it is mandatory if the IOMMU will use the CPU page table.
> 
> In ATS the invalidation is triggered by the iommu driver in a device
> agnostic way.
> 
> The PCI spec has no provision to invalidate with a mask, only linear
> chunks of address space can be invalidated.

This part is currently being worked on in the PCI SIG. Once we have
something like this we can teach which portion of the VA to mask.
Ofcourse this will take a while before PCI sig standardizes it and we
will start seeing devices that support them.

BTW, this is a problem for all vendors that support SVM and
LAM/MTT. I see ARM in the SMMU 3.1 doc states it doesn't support MTT 
at the moment, just like the Intel IOMMU. 

I hope the API we develop must work across all vendors.

