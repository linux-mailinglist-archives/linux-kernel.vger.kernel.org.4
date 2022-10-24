Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40960C050
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJYBC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJYBCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF477FF8EB;
        Mon, 24 Oct 2022 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666655858; x=1698191858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qRPGgxsyhxp2T3Y2yjmVvL5qu+tB1jEtODkBu0BTxKo=;
  b=CYrcm5dJ/b5zknfUujrMac7UtdbkPImfgFSXQB4ehZCXzrPUIOigyTmy
   xnkXUQCVzs5eD9QzuoWAXEuKrLUnaJRCvGoIwXMMAwOjEkW9Imt70EZmT
   vydp7LCJHcUB745N/G7//XYylVgIdJACPaDWoFxmiFvKqwwA8huTY3VsL
   v9V/n30VckGgGXWCDBQbj5HKIIKT+w1a/wxaH6M1SWe7S744pYCZWVuDA
   8RyeRhnapL9PepCmuSdHv6ECykkdOTd32n1SwRK91hmCyYyx6lXjiR5gp
   WorbwvI9Q9dzWKKSVcJD9SIxKYPWsO7lHN5iY3fUkbiADk7zKDU77PcVj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308641703"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308641703"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 16:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664717828"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="664717828"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2022 16:57:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:57:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 16:57:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 16:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4NIfkcFpd7B4nVu642fsfP5FEKEB1WognnsGjslSnDdJ6OJU3yDswCTVCB0WcZoNqER/dHqLT87WJ9WssyGR7SFoQ2FUHnjYQisR5CA1gZIEzLNdZvFA1/bG2JQNB4slncIsuEcUhK3FYdD0j6HPnaHplLtPl+I73veQr6DcH+MAvj42JJqzvvhqpf44sgteMlpQ+XUPRj6VCMgSMJndjqTJDdGXgrW7GpEQc0MYKIfnat1Y80YV3kZ4X+YsMxxr/1sCOTPaSWdS0kF+Xmihc0yi9v38400Uwgzzzs4lcT2/Wk/7NlJnAGyySBhEQELCJWVz3oQVTS/nM12UJu9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHEgmPcleoOC4Jf73edsgSMMf038V9W6dhi5s6PolpU=;
 b=lJDxXZBMjVS1sJGY6twrOAHamy5I+4Uz9GFGquNhaRMhlkle36khUBOz09pivez61bxF0P0L45Y/CGYkuD5F7RqODg2Djtq3lvpG3PUesBZ/cHUcwBrkwD8gTSTpfDiBWe9txkg8wdJgOdOCPtQPCs/Yh+wNzSaU2XBkhHwX1WQwxzv44LmxCSMXZNX0LLjlqBTrl66yUybteC5e72zHy8f/ablwcdkSS65+8DiUs/j2WW9ShYmBQueqy+iOshkbECtH1tNgDKoT4GT8QunLVsL3cy0KWb5Rh77x6cJBFkjiIbqwVpi0vrENvkxVnxkL//CLZ0b5W976LLwkflUi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5035.namprd11.prod.outlook.com
 (2603:10b6:806:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 23:57:28 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Mon, 24 Oct
 2022 23:57:28 +0000
Date:   Mon, 24 Oct 2022 16:57:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 06/12] cxl/acpi: Extract component registers of
 restricted hosts from RCRB
Message-ID: <63572664e884c_4da329497@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-7-rrichter@amd.com>
 <63522b53321e1_24ac29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Y1b92DF0c36/QDbo@rric.localdomain>
 <635702a652637_4da32941a@dwillia2-xfh.jf.intel.com.notmuch>
 <635713bd6bc15_4da329434@dwillia2-xfh.jf.intel.com.notmuch>
 <63cd195a-f5d0-b016-d833-b3a9c86ff6ee@intel.com>
 <Y1ckyqeoWQAs6R9B@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1ckyqeoWQAs6R9B@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: d8be8706-c831-4d81-be00-08dab61b819f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNTeDKw7lSLo6+uGQSynxN3fzOgSC2GJLx5Zb0eCHJxBl4j51Dl/P8LkVAULUm9EyItWJZq/vlu5psSeXHJ+h3MoymoV3kRyrN7QE4s+gqFsGPR2mvN71EDMXhT6N1uPh9qDca8eHd83JtOVxdP2K2+s2Sl3WMvQP/bfm6IVOq8MDpz5AGVrykU8tsi5nVWErVxm/DOqnExbe9LvwhAqzgmnKbGpFWb1I+70ki6t3laL4YOWQ0fu3ja37f8WBSmOWgxHAfxXg5R8THpPEE6TDrZCJ+UuKplybavRt5Xe+BxY3q6Mv5r5RDwZQxuYitpZ5tHVMHYMhqxWnuc52coUce2gD6tXBzT/fqXLu1lt2jFYokxDeOb0RaV3JI2DqyKPtfyZZJBAAYO+sOMMxC68d1Jwjw9mmN2LBIa3HGLs8OApnwCtpVF7nqpkiDhQNwpv6VQq2c83IAdj0V52N6QvqbmsIrNjIvdUJ5YuSwsGrg8omVe+NVE9Hw4Rb+NBnUwhZ1mBXPhighWbBzbTs2JOmqUrsMJ990dm3nfyE444hGUqPVfqTuhAfTlih5QVzqLbLukXbwhfleYKrp30sk6PdtJLAhEuJ9vYP7v2KkI0lsJd0kb5idUZCyvi8ebxiTsGMgMTCibVFFa8Ilukl/adFmK5w6Kbah+TWGezaIVR1kj2Ofh2eKO8QkHY6FFRHWXRK6ctU5NCtfpl+ooB9uhe16JnJEtiG3L7oiv3ZsoM5aJSHptrbJ+3WAa0ZZCLAA2DzditAL2aHEn2mL2N1O4J1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(8676002)(5660300002)(6666004)(41300700001)(6486002)(478600001)(316002)(38100700002)(82960400001)(2906002)(966005)(110136005)(8936002)(54906003)(6636002)(86362001)(26005)(9686003)(6512007)(66946007)(66556008)(4326008)(66476007)(6506007)(186003)(53546011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yAIVEYufLGrw3O/rmhdu/6Tcjh94IAwuQVF4Ym3p9TlVYOGRDAJOIBCXAma/?=
 =?us-ascii?Q?RLUnpedoT4aCrfF8GGpnfFnXHy3qphnl+KbAKtONlnRCvXwTp1oMty9btn20?=
 =?us-ascii?Q?hz7SM8n3yGHEF/5lt8QKmN6xhgiLydJAyOPNv0C0sML7WdxhfYOsRzsap0Gb?=
 =?us-ascii?Q?TwB0v0vc7k2m5Ie/0wQJK5FTGXeqMQqUTNb0piBYQKL6dH7/HnP91dwxcwsz?=
 =?us-ascii?Q?+d9bs3qPrdqPqAOrTzfEYhIh4hr+kZq2oR/p22IQPEHPMznOIITTu/Cok8pc?=
 =?us-ascii?Q?1JM8wAoR9py0j07x0Rbo1zakfS9j9Q2zFjsBlBQ2XS00GFGSQ393qA3E80Ia?=
 =?us-ascii?Q?fQh5NWhKkW7uhOwn+FJ3PCR9ENamIPAqUYtpiZLwroQV03qmTY2gg1KCp0vO?=
 =?us-ascii?Q?4vPaeLo48+z20UlrdpreVrBIt6DL8565vhV//1zE/1G8RBIc7lc6ISLkvmjE?=
 =?us-ascii?Q?/m5jsj0rH7u7P7ghDldekByytoG0vKEGp3BWzhOYPGgB3OE/PpyAvV7cmspi?=
 =?us-ascii?Q?vuXyWGzoHhbciLZVIPgVnr2zfZBlqnaQ/uUTyQURoau7s8RLq3j+YMVtQahF?=
 =?us-ascii?Q?I+nUnk5FjgGxNpj7AHX3Zf1Jm4K8Gp9nK834g/dlv18kXA+uaqLrRCHWw0zB?=
 =?us-ascii?Q?KwnbjgzHi62kzoEjhyjPOLFCt6HA0nSBt/JavuU6gjOOcY4w1alnvd/fjmhB?=
 =?us-ascii?Q?txBhFxjCwIhMa9SzVae5bQCKeLpANjXPe684GrXYtz4A26SVSFv5a+7E1lfu?=
 =?us-ascii?Q?nVidqo0Q9SzSONDaOwSgWpAwWk9Y/rzUadD0t9M+Bi3g9jarDxByb3mQ5dzI?=
 =?us-ascii?Q?2jHnAeAMEUWEoYcmR7DDG14LMKpn3I1b6O+7up/4lGscqLGTPzYuYEz5o6ii?=
 =?us-ascii?Q?/yxAt3xwg3/FkZ6bWz8CjhwBkitX1l4wSWWKi+WBcHXaeo8+UbspHHkSiBXt?=
 =?us-ascii?Q?jrjlypye2a71el8/8NACRozFCvXoPLAPt7qp/snEBqI2HE0zC89Hoq/j9Akb?=
 =?us-ascii?Q?qVOeI5HZdGacl9kVuYRZRwYkVyx/IKh7Aj5Ktp2YEDcok8pejuzNaI4TZv37?=
 =?us-ascii?Q?cdY5DndInAEEX/iHJbLzRSQy+JuLH57I325ZxHZDrKAzkyWuE/qWAA+F1K8Z?=
 =?us-ascii?Q?sYvDPBM6HTSEzPE+YO3TQH8vVdmVId5DZl9rguS1OkS4DT6+amr5iwKMY3SP?=
 =?us-ascii?Q?NtqzUfRSxp0v9JZEJdAsgzeKvwkDnIylFmbtCJzue4jcV9QiCBc0K3nq7jDB?=
 =?us-ascii?Q?Tc+zS/+m1XWx4Bq0LVLZ1pWdRYjezJMjv7Wrnde7syJSf5WbcXC5zEipsyLP?=
 =?us-ascii?Q?/iQVk7Rmfc5hpxqDPRxPd2QhKRLLzV6v5pMVRslOW6iTbnwNv8Rpusr9FzUH?=
 =?us-ascii?Q?/CxiaMqGXlCno2W4mNA3DF+oZ7WDRIRF0xNi4SVy5OQLiV5Mlo0mcibcXaMV?=
 =?us-ascii?Q?MIW2KXM9t4POwUgjj9oiKT/dy1gXpoCqc3+NyTjObvCzC6v2ECEAo9g8AqEV?=
 =?us-ascii?Q?FEooWtBlf9CNbDabDKAJ8KxA1ttq87TRXGVwi3x9hKDyHomOXbYxMz+U6ApQ?=
 =?us-ascii?Q?LHm+6lr0CUqA6+ufiJps4+QlkcU2tDkXMwVkJcuyt53TnPdyxlZ8irq9PjDV?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be8706-c831-4d81-be00-08dab61b819f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 23:57:28.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BOee5xq5K6lVKq8QGxmU7hpRp+LetacPyShypqfP7lLJCj8sUYvCQR70Yml3+nmGnOiPRoawnzcEbM13CrrQnbp4PuqUKURPTyZx1k1Ei0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 24.10.22 16:23:39, Dave Jiang wrote:
> > On 10/24/2022 3:37 PM, Dan Williams wrote:
> >     Dan Williams wrote:
> >         Robert Richter wrote:
> 
> >             Ok, I see where to go here. Could you point me to Dave's postings you
> >             are referring to? I checked linux-cxl and could not find anything
> >             related to RCRB or that changes regs.c.
> > 
> >         He was in the middle of tidying them when you posted your series, but I
> >         think it would not hurt to push them to a git tree so you can grab the
> >         bits and pieces you want.
> > 
> >         Dave?
> > 
> >     Looks like the list delivery is backed up, so I added Dave to the Cc:.
> > 
> >     He pushed:
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch
> > 
> >     ...which was his original attempt and:
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch-robert
> > 
> >     ...which was an attempt to rebase on top of your bits.
> > 
> >     The common RCRB mapping function is here:
> > 
> >     https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?h=cxl-rch-robert&id=5be44cad37972517dae6a79001080ccfbdb67c49
> 
> Thanks for the pointers.
> 
> > 
> >     I think the path forward is to build on that common RCRB code, fix
> >     cxl_acpi to register the pci host bridge device instead of the APCI
> >     device as the dport device, and then rely on a flag to skip over
> >     devm_enumerate_cxl_ports() in favor of just calling cxl_mem_find_port()
> >     directly in the RCIEP / RCH case.
> 
> Yes, we can completely skip devm_enumerate_cxl_ports() now. Though, I
> am not convinced on using the pci host bridge as dport_dev as RCD and
> non-RCD mode will diverge too much then. Looking into details here.

Oh, I disagree with the initial implementation Dave had here. Both cases
should be specifying the bridge device as the dport. That's a fixup that
can go in now even without the RCD support.

As it is the tooling needs to jump through the physical_node attribute
to provide the useful information in cxl list:

# cxl list -BTu -b ACPI.CXL
{
  "bus":"root0",
  "provider":"ACPI.CXL",
  "nr_dports":1,
  "dports":[
    {
      "dport":"ACPI0016:00",
      "alias":"pci0000:34",
      "id":"0x34"
    }
  ]
}

...and I think that should just swap to this in all cases:

# cxl list -BTu -b ACPI.CXL
{
  "bus":"root0",
  "provider":"ACPI.CXL",
  "nr_dports":1,
  "dports":[
    {
      "dport":"pci0000:34",
      "alias":"ACPI0016:00",
      "id":"0x34"
    }
  ]
}
