Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61A5E88F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiIXHJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiIXHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:09:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC22B875
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664003377; x=1695539377;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0cGqk+x7wxo5cgOCW8VKtty2qXVjDUZKz1n1srC1qhw=;
  b=SPDw4gksyniMxBynsJXf9IdH96maBWHdd5zQRaRvL6S8qqgsnoAaWV5n
   6e0RwaIOeGg5l35RW9fXlRs9Baz2TQgWqXahlRE3SwlihFASQYW+VwoCi
   eYzoZV8+8gUfp0z+kKcxx1HNSiWW9ufykLi/BV4rfTdecDHXzfSaRES5+
   uzC2UYKD2B/y3EtYDAvvssM1EiV23Mt//t047GUYET+Umqy16FwQa/11h
   EzsFvHL3Bcux3ov8P/gRj7bC6It0shkbl5IdbEe2wLXP2qHXhQya5ZWkp
   YaWxQo5anIi0wl43hZaWhF7Tl8Gbs4miijP3Z7kytilFQoDxqvOjqeEq2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300734680"
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="300734680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 00:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,341,1654585200"; 
   d="scan'208";a="949284327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2022 00:09:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 00:09:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 24 Sep 2022 00:09:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 24 Sep 2022 00:09:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPywuday52ZD6s+GLSslU8XWiZG7O7yLLfYYrrJZOMMtYHAazXKVaqZWwIEJn3o20xXMBf0UXpuFwt//lhlPlvZPvin0stveBIK1z9UVTQBGO+zuUm/l5amJ+cXe3Jlyl+d0y1OCA5tImRanw2SFk34xw8RJp2csywWwIsiG1ol9+xO8zq/lucSUcmbRI6YyVPyUCQY4PEgNbiY8xmjLLxwrtbZ8xS/Gx+rfVBpCdjcKHCder8WEckczdto7IszxHMrXgtD1G9aD5jIXI+wALRenW7mUs/h3guJJHclSNiA/kVsJXGVeJl4DRFi3BHg3ynmcaaH8x68jIgIFn2vXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxcZ0o01F8uhPlU5GHHm9Rn4OZjaMpMckWbeApa4pnE=;
 b=mxUV8Z8rudMWQNevWseUBOcstbL4fbdVhJ6c58GOzfaTRRhq9GfmOGUy+wLTQ+ZeU8IfrIuDJxcqmqyMovXyNsUdK+LI74wkUr73OiyHE2FnG+atMnTRd//8I6c+c/Ub/+NsuKSihxTE7HTCXPlZvpOs+Vd/i86T8t3VWbHxJQCCXJpN4B2tV82fK9GdHxET2KYMhMcb30cVSqRnt/e47+zSz9Yvu2jcYTHqqtX+06dn/n97OrmE3K0CeWs9xnY+df+kEq2j3yG1ry8SaTBiEBtblXWf/BDWf6cEhdynPv8BQwB4gt6FQh0z0kEVu8UJyCpcg9Nn1NK4iF9CK6DQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Sat, 24 Sep
 2022 07:09:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%5]) with mapi id 15.20.5654.016; Sat, 24 Sep 2022
 07:09:26 +0000
Date:   Sat, 24 Sep 2022 15:08:56 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Yy6tCCVOpC4hR7e8@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <1f2dd1b9-0248-a536-92e8-aa1a8d4b0fd7@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1f2dd1b9-0248-a536-92e8-aa1a8d4b0fd7@suse.cz>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf6b373-e848-4fbd-c855-08da9dfbb764
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUf4QiYHw93C9JX3w8xohA92GgC2VS8qNW3XYM7rZs0insa4oQGVJJX5BokPyv4HeFuy4ZSM4l9/z8gA/cjwWjZmfUvuYJ4dtv97H50I6ZYw02F9QD5JGiWazrS3hXhheuIePSW+V8ogV9CNJ9CM0sruCbBEuJ4CV1lGvHfb17TDxa1bljNtBUfvfzjkgQdvJnF8h7B9cm4kVswsxR8qE7RRN5LZE9/ZurQCEJaNqsB7cVMEWGy4RiNNwlicNeII6n98W2llfnXmgvO50Kl9ovKO1DUla6avOXRyr6ewfMDe6B/M69soYroZpmx/RQziUpDChD+sd43e+el3SKGPwjsToiD63ZYs5tZmSVTvGBYHa/FxeuIJAmhJQDT8m0sHckaVZ1Y6S2pSe5QDJ7tw4kGJiO+wDxUIrYLdKjDa/N/XPrzc5tuLaraN2mhK036og0LMXucKXEKtXv0dawhYlVhpWr7P6juPu9zbmjTYkCmGZnW815qejGbGz6jnVt6XH4LAZZ8v7wtHtQgKqyAYhhI4g4bdfx9Kq+v9ZcK1sPOredlU9ybc9crPt/EWHeP3FslZGhJveu9//1m+4tq5TIj8r0P8m1BdAID4XKm+/RgJIWtMlOSs1Ke335cpGEDCY0DXgK4ctZDAmSRo7ydBv+aoYDzSYPWqDTFY581LNpnrQbfD2tyeDQQLLKN38XrcEL73Kedcl31d/kI1OLrjKLb3fFskZ9Z/R48RHe9hgNqHfL+n0C7C10ZfJmDk4E+26VZayhZxDUMzhIgsGKNzgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(33716001)(6916009)(54906003)(316002)(38100700002)(82960400001)(5660300002)(7416002)(30864003)(186003)(86362001)(966005)(6486002)(8936002)(66556008)(66476007)(66946007)(8676002)(4326008)(2906002)(478600001)(6506007)(9686003)(83380400001)(26005)(6512007)(6666004)(44832011)(41300700001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PA4kB+bIZrBpnXnbBUqhsVzIfchqqaoIYn3d9P/VjFRA6AiPlaFlz5q6WDL?=
 =?us-ascii?Q?QYd+bN2Sg6WoPC2IJTdq6x+CkrUuVMqz5O8Gq5WiLnU18YKHED30d8P+r/im?=
 =?us-ascii?Q?KhFtffapBEzRCJ9HR8IY+BkipDdktBeI1tfMBUhsM0yY5WogkW+8k4NfAPam?=
 =?us-ascii?Q?dG/ZMELyByeWoWB/zbJ0QqlV+HXnKpqMveEMSDVsNmlO/pVdyYQfSoVdCA7l?=
 =?us-ascii?Q?Un3WTg9kVNZRwEOATUZsEyAz9btdbkcR4YZL/OMX42cOuwR7r7YcPaHuWiVZ?=
 =?us-ascii?Q?GngdPAVvXMdC4/kV45gCaqFkF9kNVgJMH5dGUrmRoWwMrvocD6k2j0LMtSX5?=
 =?us-ascii?Q?qfnjLslv2hi69HBm+Ud8K/r/ij31bvp0F5M8TfzfMlSDsmNBIhi31WsTislW?=
 =?us-ascii?Q?6DzkQfhbtSk+IaWm4KKZqwkndsie9nlz7DUZHg/p1OGgH6C5GX7lxWKQXlDy?=
 =?us-ascii?Q?3j10+uaZ9MR2RN61lvBXV5mOSWWaxaSFn39JtOaAYJ7YyfRpybwhfuKeBnyp?=
 =?us-ascii?Q?PDUOkeAG68XO+4KoE1X5Rv0xqQOpvjshUR0zkUzC4G2geVMNYKYcuLvFKpYo?=
 =?us-ascii?Q?K3Rt7RnhRPmJ/vtXUf993RiY7Blj97+yP+67kIiyjuwThPAnmT/3Eaw0Zw08?=
 =?us-ascii?Q?Pzuj0952UOy2MANajUD63nqxj5ZvwYygK7bOzYpsCMGecVfZhvIy5yXOXi4O?=
 =?us-ascii?Q?F9mm53F8rWy7rLir81lf2sWlrF58nkyOv7ChxMdunR8+sCYQfRCk5QL3GRSj?=
 =?us-ascii?Q?tqLvkJw/RJPtNcT4ciBD9+nMdfRMongJ9LuRfAwfHDY02ICv7PZc7Hl0hOOA?=
 =?us-ascii?Q?Z7b71c/jwfyrzdcIr1gXKhE7mmhXhIGAdBLKsS5dbmb0mVjf/lJsYy7maKGa?=
 =?us-ascii?Q?1LjFl3nflhQglj2j5+5U2lLy0Tg8/oopt45+PmiqzOYAflrrmbrTkFbfXXsg?=
 =?us-ascii?Q?YmCg8MP5KZjYI1vu+d1ysbpsITCqS9/7wso6uAnj2iYtW7sFgoF8uIP/Uy4/?=
 =?us-ascii?Q?ZEl02/XZMIW8fRJFEMKdmpM52DME1SyADo8TBdZIJFY5sTK5h40uuZk4b031?=
 =?us-ascii?Q?NSizhUNdQsUXVRBmaNqOe1udDG1hN0Mg4gpr9X39Q8L5m+sjlJSOSYyipS4G?=
 =?us-ascii?Q?e7PXw+QB9WVK0WzR1MdS1e0x/xrKYBGAr+ys95HaR2/takV1nPtHnxCkNUGI?=
 =?us-ascii?Q?Tir6uAqdNHrGPgfOrHy2QNBoi3GUctfvkxf93intrwy7csShr8hYKzbHG9p8?=
 =?us-ascii?Q?cnAXJTdNKN+09gBItbruvOB7gd2lx+81xlnqwnDO7nRPbTGlNVfs2GHywZV2?=
 =?us-ascii?Q?aSCFeU02+m6O/6NnW3RVMDk608S6gG4ltbR5Zxjx/FiJOk4SFtMWBWsYo1hH?=
 =?us-ascii?Q?YOufh2FrLlPuRGeWpRu3V3HhvDIDB56/kGMEoO9Y+oKQ4toMHwAGFkXpgk2q?=
 =?us-ascii?Q?9ydoObp5Tut/DpPBlYl0MrdbLSwM33O2x0+Q3MMBvHOuQZMBrxEm7EvBqY7L?=
 =?us-ascii?Q?aWz5U+cglGJyLLB8kj9aYbRQrmgdLGC//bzHQC5t8RjiXrccj8JMsS4akfJU?=
 =?us-ascii?Q?8pzUQQEhZWR4ZJjR3AO+ZNjaGDRDLYcFdW62kYiB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf6b373-e848-4fbd-c855-08da9dfbb764
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2022 07:09:26.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEWci57BgHhFnOxSKsczRsc9ugaVXgri3nXP/JPyLjx+wmk4VDCub+OOFkttQyN84cQYktCSKWpOL0RLblG97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 07:43:22PM +0800, Vlastimil Babka wrote:
> On 9/13/22 08:54, Feng Tang wrote:
[...]
> > which means in 'kmalloc-4k' slab, there are 126 requests of
> > 2240 bytes which got a 4KB space (wasting 1856 bytes each
> > and 233856 bytes in total), from ixgbe_alloc_q_vector().
> > 
> > And when system starts some real workload like multiple docker
> > instances, there could are more severe waste.
> > 
> > [1]. https://lkml.org/lkml/2019/8/12/266
> > [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
> > 
> > [Thanks Hyeonggon for pointing out several bugs about sorting/format]
> > [Thanks Vlastimil for suggesting way to reduce memory usage of
> >  orig_size and keep it only for kmalloc objects]
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Thanks.
> Given that the merge window is nearing, and the rest of the series a) has
> some changes suggested and b) could be hopefully done in a simpler way with
> the proposed ksize() cleanup, I am picking just this patch now to slab.git
> (and thus -next), with some small modifications:
 
OK, and all the cleanup/improvments from you look good to me. Many thanks!

For kasan and ksize() related patches, I'll keep monitoring and working on
them.

- Feng

> ...
> 
> > +
> > +static unsigned int get_orig_size(struct kmem_cache *s, void *object)
> 
> Made this inline for consistency.
> 
> > +{
> > +	void *p = kasan_reset_tag(object);
> > +
> > +	if (!slub_debug_orig_size(s))
> > +		return s->object_size;
> > +
> > +	p += get_info_end(s);
> > +	p += sizeof(struct track) * 2;
> > +
> > +	return *(unsigned int *)p;
> > +}
> > +
> >  static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> >  {
> >  	struct va_format vaf;
> > @@ -844,6 +890,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
> >  	if (s->flags & SLAB_STORE_USER)
> >  		off += 2 * sizeof(struct track);
> >  
> > +	if (slub_debug_orig_size(s))
> > +		off += sizeof(unsigned int);
> > +
> >  	off += kasan_metadata_size(s);
> >  
> >  	if (off != size_from_object(s))
> > @@ -977,7 +1026,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> >   *
> >   * 	A. Free pointer (if we cannot overwrite object on free)
> >   * 	B. Tracking data for SLAB_STORE_USER
> > - *	C. Padding to reach required alignment boundary or at minimum
> > + *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
> > + *	D. Padding to reach required alignment boundary or at minimum
> >   * 		one word if debugging is on to be able to detect writes
> >   * 		before the word boundary.
> >   *
> > @@ -995,10 +1045,14 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> >  {
> >  	unsigned long off = get_info_end(s);	/* The end of info */
> >  
> > -	if (s->flags & SLAB_STORE_USER)
> > +	if (s->flags & SLAB_STORE_USER) {
> >  		/* We also have user information there */
> >  		off += 2 * sizeof(struct track);
> >  
> > +		if (s->flags & SLAB_KMALLOC)
> > +			off += sizeof(unsigned int);
> > +	}
> > +
> >  	off += kasan_metadata_size(s);
> >  
> >  	if (size_from_object(s) == off)
> > @@ -1293,7 +1347,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
> >  }
> >  
> >  static noinline int alloc_debug_processing(struct kmem_cache *s,
> > -					struct slab *slab, void *object)
> > +			struct slab *slab, void *object, int orig_size)
> >  {
> >  	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
> >  		if (!alloc_consistency_checks(s, slab, object))
> > @@ -1302,6 +1356,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
> >  
> >  	/* Success. Perform special debug activities for allocs */
> >  	trace(s, slab, object, 1);
> > +	set_orig_size(s, object, orig_size);
> >  	init_object(s, object, SLUB_RED_ACTIVE);
> >  	return 1;
> >  
> > @@ -1570,7 +1625,10 @@ static inline
> >  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
> >  
> >  static inline int alloc_debug_processing(struct kmem_cache *s,
> > -	struct slab *slab, void *object) { return 0; }
> > +	struct slab *slab, void *object, int orig_size) { return 0; }
> > +
> > +static inline void set_orig_size(struct kmem_cache *s,
> > +	void *object, unsigned int orig_size) {}
> 
> There's no caller (in this patch alone) for the !SLUB_DEBUG version, so removed.
>   
> >  static inline void free_debug_processing(
> >  	struct kmem_cache *s, struct slab *slab,
> > @@ -1999,7 +2057,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
> >   * it to full list if it was the last free object.
> >   */
> >  static void *alloc_single_from_partial(struct kmem_cache *s,
> > -		struct kmem_cache_node *n, struct slab *slab)
> > +		struct kmem_cache_node *n, struct slab *slab, int orig_size)
> >  {
> >  	void *object;
> >  
> > @@ -2009,7 +2067,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
> >  	slab->freelist = get_freepointer(s, object);
> >  	slab->inuse++;
> >  
> > -	if (!alloc_debug_processing(s, slab, object)) {
> > +	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> >  		remove_partial(n, slab);
> >  		return NULL;
> >  	}
> > @@ -2028,7 +2086,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
> >   * and put the slab to the partial (or full) list.
> >   */
> >  static void *alloc_single_from_new_slab(struct kmem_cache *s,
> > -					struct slab *slab)
> > +					struct slab *slab, int orig_size)
> >  {
> >  	int nid = slab_nid(slab);
> >  	struct kmem_cache_node *n = get_node(s, nid);
> > @@ -2040,7 +2098,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
> >  	slab->freelist = get_freepointer(s, object);
> >  	slab->inuse = 1;
> >  
> > -	if (!alloc_debug_processing(s, slab, object))
> > +	if (!alloc_debug_processing(s, slab, object, orig_size))
> >  		/*
> >  		 * It's not really expected that this would fail on a
> >  		 * freshly allocated slab, but a concurrent memory
> > @@ -2118,7 +2176,7 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
> >   * Try to allocate a partial slab from a specific node.
> >   */
> >  static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> > -			      struct slab **ret_slab, gfp_t gfpflags)
> > +			      struct partial_context *pc)
> >  {
> >  	struct slab *slab, *slab2;
> >  	void *object = NULL;
> > @@ -2138,11 +2196,12 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> >  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> >  		void *t;
> >  
> > -		if (!pfmemalloc_match(slab, gfpflags))
> > +		if (!pfmemalloc_match(slab, pc->flags))
> >  			continue;
> >  
> >  		if (kmem_cache_debug(s)) {
> > -			object = alloc_single_from_partial(s, n, slab);
> > +			object = alloc_single_from_partial(s, n, slab,
> > +							pc->orig_size);
> >  			if (object)
> >  				break;
> >  			continue;
> > @@ -2153,7 +2212,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> >  			break;
> >  
> >  		if (!object) {
> > -			*ret_slab = slab;
> > +			*pc->slab = slab;
> >  			stat(s, ALLOC_FROM_PARTIAL);
> >  			object = t;
> >  		} else {
> > @@ -2177,14 +2236,13 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
> >  /*
> >   * Get a slab from somewhere. Search in increasing NUMA distances.
> >   */
> > -static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
> > -			     struct slab **ret_slab)
> > +static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
> >  {
> >  #ifdef CONFIG_NUMA
> >  	struct zonelist *zonelist;
> >  	struct zoneref *z;
> >  	struct zone *zone;
> > -	enum zone_type highest_zoneidx = gfp_zone(flags);
> > +	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
> >  	void *object;
> >  	unsigned int cpuset_mems_cookie;
> >  
> > @@ -2212,15 +2270,15 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
> >  
> >  	do {
> >  		cpuset_mems_cookie = read_mems_allowed_begin();
> > -		zonelist = node_zonelist(mempolicy_slab_node(), flags);
> > +		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
> >  		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
> >  			struct kmem_cache_node *n;
> >  
> >  			n = get_node(s, zone_to_nid(zone));
> >  
> > -			if (n && cpuset_zone_allowed(zone, flags) &&
> > +			if (n && cpuset_zone_allowed(zone, pc->flags) &&
> >  					n->nr_partial > s->min_partial) {
> > -				object = get_partial_node(s, n, ret_slab, flags);
> > +				object = get_partial_node(s, n, pc);
> >  				if (object) {
> >  					/*
> >  					 * Don't check read_mems_allowed_retry()
> > @@ -2241,8 +2299,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
> >  /*
> >   * Get a partial slab, lock it and return it.
> >   */
> > -static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> > -			 struct slab **ret_slab)
> > +static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
> >  {
> >  	void *object;
> >  	int searchnode = node;
> > @@ -2250,11 +2307,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
> >  	if (node == NUMA_NO_NODE)
> >  		searchnode = numa_mem_id();
> >  
> > -	object = get_partial_node(s, get_node(s, searchnode), ret_slab, flags);
> > +	object = get_partial_node(s, get_node(s, searchnode), pc);
> >  	if (object || node != NUMA_NO_NODE)
> >  		return object;
> >  
> > -	return get_any_partial(s, flags, ret_slab);
> > +	return get_any_partial(s, pc);
> >  }
> >  
> >  #ifdef CONFIG_PREEMPTION
> > @@ -2974,11 +3031,12 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
> >   * already disabled (which is the case for bulk allocation).
> >   */
> >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *freelist;
> >  	struct slab *slab;
> >  	unsigned long flags;
> > +	struct partial_context pc;
> >  
> >  	stat(s, ALLOC_SLOWPATH);
> >  
> > @@ -3092,7 +3150,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  
> >  new_objects:
> >  
> > -	freelist = get_partial(s, gfpflags, node, &slab);
> > +	pc.flags = gfpflags;
> > +	pc.slab = &slab;
> > +	pc.orig_size = orig_size;
> > +	freelist = get_partial(s, node, &pc);
> >  	if (freelist)
> >  		goto check_new_slab;
> >  
> > @@ -3108,7 +3169,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  	stat(s, ALLOC_SLAB);
> >  
> >  	if (kmem_cache_debug(s)) {
> > -		freelist = alloc_single_from_new_slab(s, slab);
> > +		freelist = alloc_single_from_new_slab(s, slab, orig_size);
> >  
> >  		if (unlikely(!freelist))
> >  			goto new_objects;
> > @@ -3140,6 +3201,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  		 */
> >  		if (s->flags & SLAB_STORE_USER)
> >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > +
> >  		return freelist;
> >  	}
> >  
> > @@ -3182,7 +3244,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >   * pointer.
> >   */
> >  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *p;
> >  
> > @@ -3195,7 +3257,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  	c = slub_get_cpu_ptr(s->cpu_slab);
> >  #endif
> >  
> > -	p = ___slab_alloc(s, gfpflags, node, addr, c);
> > +	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> >  #ifdef CONFIG_PREEMPT_COUNT
> >  	slub_put_cpu_ptr(s->cpu_slab);
> >  #endif
> > @@ -3280,7 +3342,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
> >  
> >  	if (!USE_LOCKLESS_FAST_PATH() ||
> >  	    unlikely(!object || !slab || !node_match(slab, node))) {
> > -		object = __slab_alloc(s, gfpflags, node, addr, c);
> > +		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
> >  	} else {
> >  		void *next_object = get_freepointer_safe(s, object);
> >  
> > @@ -3747,7 +3809,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> >  			 * of re-populating per CPU c->freelist
> >  			 */
> >  			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
> > -					    _RET_IP_, c);
> > +					    _RET_IP_, c, s->object_size);
> >  			if (unlikely(!p[i]))
> >  				goto error;
> >  
> > @@ -4150,12 +4212,17 @@ static int calculate_sizes(struct kmem_cache *s)
> >  	}
> >  
> >  #ifdef CONFIG_SLUB_DEBUG
> > -	if (flags & SLAB_STORE_USER)
> > +	if (flags & SLAB_STORE_USER) {
> >  		/*
> >  		 * Need to store information about allocs and frees after
> >  		 * the object.
> >  		 */
> >  		size += 2 * sizeof(struct track);
> > +
> > +		/* Save the original kmalloc request size */
> > +		if (flags & SLAB_KMALLOC)
> > +			size += sizeof(unsigned int);
> > +	}
> >  #endif
> >  
> >  	kasan_cache_create(s, &size, &s->flags);
> > @@ -4770,7 +4837,7 @@ void __init kmem_cache_init(void)
> >  
> >  	/* Now we can use the kmem_cache to allocate kmalloc slabs */
> >  	setup_kmalloc_cache_index_table();
> > -	create_kmalloc_caches(0);
> > +	create_kmalloc_caches(SLAB_KMALLOC);
> 
> Instead of this, add the flag in the common creation function, so SLAB kmalloc caches are also marked even if there's no use for it there now.
> 
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -649,7 +649,8 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
>         if (!s)
>                 panic("Out of memory when creating slab %s\n", name);
>  
> -       create_boot_cache(s, name, size, flags, useroffset, usersize);
> +       create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
> +                                                               usersize);
>         kasan_cache_create_kmalloc(s);
>         list_add(&s->list, &slab_caches);
>         s->refcount = 1;
> 
> 
> >  	/* Setup random freelists for each cache */
> >  	init_freelist_randomization();
> > @@ -4937,6 +5004,7 @@ struct location {
> >  	depot_stack_handle_t handle;
> >  	unsigned long count;
> >  	unsigned long addr;
> > +	unsigned long waste;
> >  	long long sum_time;
> >  	long min_time;
> >  	long max_time;
> > @@ -4983,13 +5051,15 @@ static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
> >  }
> >  
> >  static int add_location(struct loc_track *t, struct kmem_cache *s,
> > -				const struct track *track)
> > +				const struct track *track,
> > +				unsigned int orig_size)
> >  {
> >  	long start, end, pos;
> >  	struct location *l;
> > -	unsigned long caddr, chandle;
> > +	unsigned long caddr, chandle, cwaste;
> >  	unsigned long age = jiffies - track->when;
> >  	depot_stack_handle_t handle = 0;
> > +	unsigned int waste = s->object_size - orig_size;
> >  
> >  #ifdef CONFIG_STACKDEPOT
> >  	handle = READ_ONCE(track->handle);
> > @@ -5007,11 +5077,13 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  		if (pos == end)
> >  			break;
> >  
> > -		caddr = t->loc[pos].addr;
> > -		chandle = t->loc[pos].handle;
> > -		if ((track->addr == caddr) && (handle == chandle)) {
> > +		l = &t->loc[pos];
> > +		caddr = l->addr;
> > +		chandle = l->handle;
> > +		cwaste = l->waste;
> > +		if ((track->addr == caddr) && (handle == chandle) &&
> > +			(waste == cwaste)) {
> >  
> > -			l = &t->loc[pos];
> >  			l->count++;
> >  			if (track->when) {
> >  				l->sum_time += age;
> > @@ -5036,6 +5108,9 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  			end = pos;
> >  		else if (track->addr == caddr && handle < chandle)
> >  			end = pos;
> > +		else if (track->addr == caddr && handle == chandle &&
> > +				waste < cwaste)
> > +			end = pos;
> >  		else
> >  			start = pos;
> >  	}
> > @@ -5059,6 +5134,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
> >  	l->min_pid = track->pid;
> >  	l->max_pid = track->pid;
> >  	l->handle = handle;
> > +	l->waste = waste;
> >  	cpumask_clear(to_cpumask(l->cpus));
> >  	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
> >  	nodes_clear(l->nodes);
> > @@ -5077,7 +5153,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
> >  
> >  	for_each_object(p, s, addr, slab->objects)
> >  		if (!test_bit(__obj_to_index(s, addr, p), obj_map))
> > -			add_location(t, s, get_track(s, p, alloc));
> > +			add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
> 
> I think it makes little sense to report waste in the 'free_traces' file?
> So adjusted like this to make sure nothing is reported there:
> 
> @@ -5356,13 +5353,16 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>                 unsigned long *obj_map)
>  {
>         void *addr = slab_address(slab);
> +       bool is_alloc = (alloc == TRACK_ALLOC);
>         void *p;
>  
>         __fill_map(obj_map, s, slab);
>  
>         for_each_object(p, s, addr, slab->objects)
>                 if (!test_bit(__obj_to_index(s, addr, p), obj_map))
> -                       add_location(t, s, get_track(s, p, alloc), get_orig_size(s, p));
> +                       add_location(t, s, get_track(s, p, alloc),
> +                                    is_alloc ? get_orig_size(s, p) :
> +                                               s->object_size);
> 
> 
> >  }
> >  #endif  /* CONFIG_DEBUG_FS   */
> >  #endif	/* CONFIG_SLUB_DEBUG */
> > @@ -5942,6 +6018,10 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
> >  		else
> >  			seq_puts(seq, "<not-available>");
> >  
> > +		if (l->waste)
> > +			seq_printf(seq, " waste=%lu/%lu",
> > +				l->count * l->waste, l->waste);
> > +
> >  		if (l->sum_time != l->min_time) {
> >  			seq_printf(seq, " age=%ld/%llu/%ld",
> >  				l->min_time, div_u64(l->sum_time, l->count),
> 
> 
