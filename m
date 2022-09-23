Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49E5E7ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiIWPpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiIWPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:44:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512BE2BDC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663947878; x=1695483878;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n65N/DAGg8Ki6gB/AEJ5wdn1SHEzLgIaT5Nb8+6cP0k=;
  b=KEkO9+l0aMCMfbgDDMow0aBTudbLqnToJDpR2qK0ixnwyux7+t6d9dT4
   nEVh+/3NAMeIIvMFJqRJ0+NC3OtAd6jIrhwdROI9ojprF0ytDn0e8VOXL
   4NMi3pf+OgeLvHh5qpkvflFfGbSNcL2fCQRYlTEyPBV2lP2NoG7DuvSOB
   vlMeDRG3Kqu2kOozuMijyE6cIs6OUWYPXSXkEtmBQifX5w0lt+riT77Db
   U5KW7dTx4uJnxeMXw5jCap0Nuj9Z0RlCiPj7XjAoTB942D4DuhjtK4QJB
   57kn4hWh9oQarQ8h8c1NMQinYF5XuoZN92r4dUwusLqyEqbzzxGdc6+ca
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300601050"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300601050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="865332112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2022 08:44:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 08:44:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 08:44:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 08:44:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC2Jn28um7kc9hA9Q9WKKZNK7oTIXLlo20Qgg8AbjFwg233dMna5hFiA9TJSvYfeO04Mp7RStD1Lv8fe23VpbEn9rq2XxSWgruZ7VyXE5uzM510/eUOAbVQFxMlyFjEfs8DqPEGQ0tWPmuVgeFWzpKAOZK3XbFLvvcWeOGy2SGfHCxhwa1ZXYicxy8GtWvnFmU/HJTZwudxWewxFJOxadwtFAJ18aD4h+vhfOD2WIyBCHQs1ZxoNkNPuCVxYN0JYhBCt90c6x5m0N3uo0ZHHrUvUI70vHmGfN+3PRT8FXP8mVHPEpBPIhP2nms09fGazFB/lgVWMb5UoWuZ/vdVYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHgYHiWrGlhoOfM6rOZIYgqzxrzkGNJHIfZoLUHXg+4=;
 b=Mx1ALhhQHKCn1pv4edMWnkpr+mNxxVofwq3zDG/RpsW2559K3RgkrV6036WzoPY7Yyf9FwP6cJSa6EzRYUuR+fzV7xUgKuCMvKPAEfoV0eo4qI7aEJXpOYvfqtnV479+yKEMLm4qVhMtUgdtlvZXqjVKgoM6V1SshlGXAQrtxwBKy+MQY8sOqEO0Ehbq3PIkTGQKRSk5qoAT5DzjE3RUO4vYxIz7d+HFJj+f+RrY1VS+R/EnbrHr1/FWmwDoCMBeaGWhJCgTtUCvtIq9uKCYwZMskzfSMhUyclL2I7XX+3VBJ2fP+pAoClf5sV5mvWGloSs4PjnovTiA5sqCdz7jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5995.namprd11.prod.outlook.com (2603:10b6:8:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 15:44:28 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::14b4:ce76:67fe:1dac%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:44:28 +0000
Date:   Fri, 23 Sep 2022 08:44:25 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <Yy3UWTLdIldKIfgu@araj-MOBL2.amr.corp.intel.com>
References: <YytFGqv5V4T8lbM8@araj-MOBL2.amr.corp.intel.com>
 <f1aac14e-380c-f76f-84bb-fdff56207d2f@intel.com>
 <YytT1hfRZdb9GYQK@nvidia.com>
 <20220923004239.ma2gfrmoezsff4ro@box.shutemov.name>
 <Yy1D0dLdqTr7ya71@a4bf019067fa.jf.intel.com>
 <20220923093826.kjad4qe3clwybeh6@box.shutemov.name>
 <Yy2cfppqkf85hPT7@nvidia.com>
 <fd1f54b5-010d-da65-3989-d8cf727261c7@intel.com>
 <Yy3QpOnsNJQ6MykN@araj-MOBL2.amr.corp.intel.com>
 <c3fb5e4f-a906-bdee-7b34-533f36ba59f7@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3fb5e4f-a906-bdee-7b34-533f36ba59f7@intel.com>
X-ClientProxiedBy: BY5PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:180::39) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be27f4c-633a-4213-c174-08da9d7a7ff9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhu66DMKvtx99p3V6TDRml2mC8LzNiaXjdFu8YeqWO2i/rk4qt0uk1HoS2FF90W7bXqQD4YBgMhtV+obCRU2RhL4wjmyn2ELvax/6wpjgX7xVf3Q4mmidjnFjgrAlS5RGiUBfHFot994ncriOiIF2swgDJvzOJlGaFaJ8ZWF07l38SAe7s/Ijv0txqCNk0FXElVoXl9HETDBsPvEoqYar2ssFUpNVoMTRwyLyezDmiwDwZfWYH67bLaczW5+CuEIqOGmIykB+WV/VCoxqD8WLf0kbp4XHb2rQXZslpdr69Arv8U7n5rGAM8cc1VTzIXM8IGbdPR8+WATLoTl2wDX0LFzx/h9io8eVLkboogrWOxoUKO3VNTdy3s6MB1faXYcxzlg9aTnhiU1xBjxn+hhrvMF5OwOywEnVpJCyqZlW2jfhFsYjaz9VJgWkzCK+ch+ykfHkiaSg6RTrs8gZgjUegpQr1tj7Eyj45w1IKBQpYNlYquRUCxm61S5aDk3X9uxc8KDT9tYQrjsww5Nl1a1mNijh5YkCU5Fy4TW9PSrm4AKIgnlHDIreggX2a11fzVwcReVoX8cy5ii3LDgfOlwXxch9HESjf7Kc2jDuh/5baFQ4jQe3szOpQqfQTFTpXjugmigmcrSGUtxfqJ9M9sKxhwQ4fI1wVwt6vP4z+E3OpywQzPvQpQLXrs283weD2hctptgp2KujYga79q8k3ekVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(83380400001)(66946007)(38100700002)(26005)(2906002)(86362001)(82960400001)(4326008)(66476007)(478600001)(6666004)(66556008)(41300700001)(186003)(6862004)(7416002)(8676002)(44832011)(5660300002)(8936002)(6512007)(6506007)(6486002)(54906003)(316002)(6636002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSOlXrVkBNe87q9QozdR+NeW8OQ4aGtLTskeVsQrgQQOy1P6VZHsFHq1Vq4C?=
 =?us-ascii?Q?NdF2f0MGpqoJC1Bt/pAbRJUiFT6bDLB6JZPng+HJupUwQVZNoIGFV6I53BLU?=
 =?us-ascii?Q?r+XmWag3YC7SUx7VcCol25WW0Rqx+fYlsebf9tMYS1dlj+HJi8juwiUoZOj+?=
 =?us-ascii?Q?BPBeWXYp7n2pzjO3y4clNaBMtjdR6ncecczk3A5eY034/Axu5Cl/6muLLqEU?=
 =?us-ascii?Q?pjvR1uxBdy88cnT76pHETxZk9qjTXwJm8++WA6vIlRwMXg/LLPyV/NNiy8WA?=
 =?us-ascii?Q?lgfuH4u494XjfUG3nFingLHE568AejD58E08tKjkJHCKFCWCJMl6/E6lIr+E?=
 =?us-ascii?Q?2ULmduZev089lbdF8nl6fMWe79dJKJlWQBTGvN5O05BFil6NFSZH3ygCtwlx?=
 =?us-ascii?Q?l7fcoJFUWGnomsOZphV/XdtObpeO3wDxZgybKT8Ul+Ilnq6L2LMYaQasQvs+?=
 =?us-ascii?Q?zRoLTLNKmlA7KHr5G4KBRcw+q4iGEAWhyzBdH0jFiP+gACFVpQqPU/6X36xg?=
 =?us-ascii?Q?yJLhAALN6Phc/l0/5BRegwuwlLJkHLlbwJng0hTCtFF5DuHOF8j2TgJI5Fsn?=
 =?us-ascii?Q?Zs5wp5ll08/2pnq7K8vwg4y1CK7ba3Srd6jbg43YVJ5d7F8L5MH9xyafw8X/?=
 =?us-ascii?Q?NLvhszwLz9pJCML64Wpe896KG5ERW3CfqyhE9Rn5rcl90PpKsY8opCXv4HIV?=
 =?us-ascii?Q?+9yJNHOumU2tCKTFU2IaXC2OSo7JkfMpkd9ZKnN1LoQlAojW0YOlq7drJ97Y?=
 =?us-ascii?Q?36ygnMWYkVEobenusUkv1/lWQuYkyUuIruV9Xo6kj9GP4eGQp/UtTVYf4mGX?=
 =?us-ascii?Q?4SkVwgcfx3wCFUQ/CUPfHu/gHl5lAj0EkBQrHBLfOeapHMwWrFSDoTM+gLrh?=
 =?us-ascii?Q?0uT0zuzvNEHbL3Ye2YnToQ2n3pkKvndc4Cahpw7//SrrAkTKQW1uVi36kkhE?=
 =?us-ascii?Q?oHoSa5a6JV8JV4ERSsSI0dByzNZuwpbl7UkqnCcUFJn34DFRV6YtkxGfslPs?=
 =?us-ascii?Q?hdk9DURISpAO+WChXWUhRw2urHZJdxa/223FZb7cacubsoyccHsV/jfL44sc?=
 =?us-ascii?Q?465ACQouU0GsdMqrpu6j3p/z1V28izFtXgI9MtKvcxPPsOZIBINoaJ4PykPL?=
 =?us-ascii?Q?fTBvVI6QdgxiMN4/CjtrzrbMFa5+BrfGB40ouugA1dSMTACWFievo38zP3jL?=
 =?us-ascii?Q?8aOzPTXWK8XA2UlZOh2vt36U0N3/O6JxbTM8BzAWlLuh5w+RnIlPD2I8wfs3?=
 =?us-ascii?Q?dWm2waU0VdEEXdn8BrtwActXPXT1IVsboI9/hz2+1xnnEM+aDn+58PLU58lk?=
 =?us-ascii?Q?VwOPN/Qxxxlx1rJOsqXsIL75uYQweniZ/Bax1isUxjoeKtA3uhENPNfmjWmL?=
 =?us-ascii?Q?fKGLh0WkyHGXPlRhecdeKjdLEkMZ+vYDu+jWeJ9haSH0dlfA4eWoKy2K83IJ?=
 =?us-ascii?Q?Y8OgMLvC0yF6GRWkiaGG3oB5l5mTZcb+F6FEsc8h7gLDCUJ8Yn+UVGye56nl?=
 =?us-ascii?Q?i8jaoAJAG3fq00v/zJdJBXwKJL+TlvvEhCzDGaf7A96GQmumdUgxB1qJAa4l?=
 =?us-ascii?Q?VX1VXmYSuQqL3TfWoTCOyGIQceWZRqtdh+fM+dn6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be27f4c-633a-4213-c174-08da9d7a7ff9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:44:28.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTF7UxYUZSTboJT+GToAocADtT20iiyLFHagR5vfjMQBKi1hZQO6hZTN2YrNbYJPQ1t/5yK1GXvQOmNojsViOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5995
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:31:13AM -0700, Dave Hansen wrote:
> On 9/23/22 08:28, Ashok Raj wrote:
> >>
> >> I thought devices also cached address translation responses from the
> >> IOMMU and stashed them in their own device-local TLB.  If the device is
> >> unaware of the tags, then how does device TLB invalidation work?  Would
> > This is coming a full circle now :-)
> > 
> > Since the device doesn't understand tagging, SVM and tagging aren't
> > compatible. If you need SVM, you can only send sanitized pointers to the
> > device period. In fact our page-request even looks for canonical checks
> > before doing the page-faulting.
> > 
> >> all device TLB flushes be full flushes of the devices TLB?  If something
> >> tried to use single-address invalidation, it would need to invalidate
> >> every possible tag alias because the device wouldn't know that the tags
> >> *are* tags instead of actual virtual addresses.
> > Once tagging is extended into the PCI SIG, and devices know to work with
> > them, so will the IOMMU, then they can all play in the same field. Until
> > then they are isolated, or let SVM only work with untagged VA's.
> 
> But, the point that Kirill and I were getting at is still that devices
> *have* a role to play here.  The idea that this can be hidden at the
> IOMMU layer is pure fantasy.  Right?

If you *can't* send tagged memory to the device, what is the
role the device need to play? 

For now you can only send proper VA's that are canonical. 
