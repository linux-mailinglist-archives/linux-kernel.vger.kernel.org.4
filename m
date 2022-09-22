Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB445E5A10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIVEQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVEQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:16:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332108E4EC;
        Wed, 21 Sep 2022 21:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663820177; x=1695356177;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XpPp6MYsGgDJcE8W7Rk/PaqVuQK1zvKYiyyWiudOzGo=;
  b=UjwpBiLYAPm6zqUKYnSBXD1/0d36JMx4vA/Trntj5liCxuhz60ITLVqe
   oFqr3pYcfN4CAzfgNe6yRs7xBF1RKWlZFKxt9ZJJyGsR3c4xtUH6TdgbG
   FmKS7y9lAWWbPrEK3BiChoTKUMDyVv7CS9n1rlybVVhljyjFUwOFJ+Leu
   kiO/nCH9PyIp+b78gRrTx2Qc4gC09ojPcT2PPreeUiGeKoGcJn53kF+kL
   E7et7+WU6EbTHNbPj/5tOr5Ov7Z7cd/DQSCGyX4TeRcdqyNmdpvlScJQy
   PKfXBZMuvEn0MVZ0/4Nv9dV7R3y0ATVboHgQIB+7X/zsO4xDJO5ltACRB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364171176"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364171176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 21:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="864703007"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Sep 2022 21:16:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 21:16:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 21:16:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 21:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORIt/vbf+ssfM6brkQjjFPhpQW/UohRMgioqzMyP9UuB+oVAskVjf0iajZH+G1Yumwl1ROQsv3zMvFR90qr3J6hJJGQInXsEQDZfq37J7Mj8GmcbspEXLRm7rmi9d6JMuaxuKxUsgewZxgOf98ziEoSELp6KVpcdnkunzwC+efqGN4G3CJ/ZhF9ltDX7Up7FCWUxmzoWSOdrQbzbuUFjp4CdsJaQxLR1UUs/SOEXZMebJKaYBzoiVtX0k67JQ16pn3jqFPanS8PDBnNxnm6YcfVPJgqb/YrQZBeIgtRo+Fa7HnvYWEWRfZsH1Lp7AX2L10WRbAIyzEjHT25VMXinQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHbeojv1Lvv6KCVl5BWKhfA7tQKIiJh/zGSnN9FsqDc=;
 b=SMDFzqVBQ9Rp0NBF3Fv9wdiMs1IuAxlaWrZ4SUo2xf+0+1uL/tizuD5U8xzlpfgWcTz+B/aYDGQl9HlrzqhdItlzbrnTUksL6mNQPoWr+sScT9Ll7X+dz0IrV0DiWoKlqF1haHPDy8+GbtlznKP0jf+kMl/7nSq46POjYhoClc7cm3PG1MSzqn9t7nq11fYAPAEhFDXIV7s7ugtyTYZO1gLKeVqw3K3MOnjD1RqZ8o7qf8drmkfl4YSFjZoeaKTndLbqILazAETF58qEQvKuLNq0l3A22bfDnExNOTAkAqBQcR1x93hgApoP6b5UzpX+EadaJC5E5RZaJ1ueCc0BdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5565.namprd11.prod.outlook.com (2603:10b6:5:39e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 04:16:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5632.021; Thu, 22 Sep 2022
 04:16:06 +0000
Date:   Wed, 21 Sep 2022 21:16:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <YyvhgeGRDM5AqdHb@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220813053243.757363-2-ira.weiny@intel.com>
 <20220824165058.00007d4f@huawei.com>
 <Yxgd51zdrk9pEXE6@iweiny-mobl>
 <20220908135240.00001217@huawei.com>
 <Yxun42yjtZREEeRv@iweiny-desk3>
 <20220920164904.00001be8@huawei.com>
 <afdac388-061e-a403-3b9e-1273cee98509@intel.com>
 <Yyo6Un8YmRM7aOLz@iweiny-desk3>
 <20220921173642.000050ee@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220921173642.000050ee@huawei.com>
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b5f3f0-3ce7-48e7-4821-08da9c512b66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FBYIAs35NOb905TGaJ2UYT21YCmIlCKUUWJHc9aRU38VegMfTBXeSkLSblS6l7mpFmi2+3fIqNEZwl8eSznjTxTUomo4WP+9LmLX2Wf5eO6Tum+msTq8KkCPBLONX/Ny95EJ/ffSv4ydNpaTeTtfOyQkWl48sh7vcn8vcc5Y5rDgnUQ8LF/egS5p9WWq0wepBljlE14FQMTzpUZxRu9A1e+NuTMuav4BE3SnD212znLFIAAL0KtBE3gSJyr9wjibZEh2cCMJ0JV/ZWunA25PJFgXGYE9O7nyLPWZ529kzH1i7VhOcvfeb7s91yfik9gqwV4yZUFcThLTLtnafQHA0FOIeBeJR8N75xNDmgeX56KTIxcLxfvwLfaZVNivrP4nvtNGBDvLNfTukUG2VoRraocY6f4mcb2YdC3jH9KV3Eig19XQ5AXtnW8Wu0PsyEoXDc/O9JQ28m7+tsVv/FJSpoFWvO+iczFaOQgrNK86nkB4BR4ZttWXDf34EBOmi7IhmQYB3bNc9hVGTMTM0JCfQxSsQOBfgSHTuZs7I8VRBRw/PG2YbEiWYi6oPZwx3MR8abulFND92JJomwtkX5naXiuJ0enjcpFRW5P9LBCeDmAiWEFqRqiJ/+ChRg7QoH48JsuOgrZ+Js+znUiOgHq76pQ0DDjg5WcvCNUwSxKOSD7916IeSqJyHW2z2NClC6D5rp5Fwla/l5X1TH08+ZetQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(38100700002)(8676002)(186003)(83380400001)(26005)(8936002)(6512007)(9686003)(6506007)(4326008)(5660300002)(2906002)(316002)(6666004)(66946007)(41300700001)(33716001)(54906003)(66476007)(478600001)(6916009)(6486002)(82960400001)(66556008)(86362001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuAF0iRLSvkWxJRiqkNbG337tFn7vAdL7kGO3xbuefnofgseqDrXmUYkzjgy?=
 =?us-ascii?Q?SxHFrxPOoWw3+QkiPOKpYeyss5aTjQ81krFCJl9CzdzrAoTHyGLs2h3p4j/u?=
 =?us-ascii?Q?c9x1so+yhO9IQmD5hEEY19sdzSMxnYW7yACQpdlysAQDNJ4a/Tw5XQtkO/Ac?=
 =?us-ascii?Q?0TNOBgSNJIAKe2y1YNWRlD6DYtW0fppldRGopBmCvCYkrCO1/CPmZ/hv+JhV?=
 =?us-ascii?Q?3p2IXn8lJ3GgtJkJ0eAFCV0wyEUxx4yrjRsCYOAc1TS0Wf8/1RIqB9+W01V2?=
 =?us-ascii?Q?mcxbNiCk3ie7RLOZ/p07PFdA3UuC4WJQcaejK3Hq6vMPZiwIpCKQLnaBbzoJ?=
 =?us-ascii?Q?7BZBJBpoj3Tq7w1W/+rX21twQZ2Dk+l04v7hOUqICIrc5aOjyBFlXKVqf7kC?=
 =?us-ascii?Q?MysmOj4Nr1ySXK0tGZtelnA0R+4LFe6teTPox8Ta8OUH9EkUl7bBj1CbZ3HV?=
 =?us-ascii?Q?ZprQC+nKNPI26QC178iChTn6RQk0OrOmj5I1/zp3u51NVt9sv156V8tb7Iai?=
 =?us-ascii?Q?gLWgdcHosnOnq3mxtmx3b2NrBE9iqzvUyQtocw8DPkADgRLROTjl3GqPQmcB?=
 =?us-ascii?Q?XZKK0ZsDkeAtMX/fB14uRKDW1xG5nURhVGzDuh/E6n4AUSpNnkrOh3gJiQlg?=
 =?us-ascii?Q?RNPxlVNQK8shzpgtBK3piBjevTvlLXUIRdoN43XmOeX7J4HXjKx0+urgroUa?=
 =?us-ascii?Q?B1xG8NsoSsj43xFvSE2B4kkJ8HvUUinBo8WgEMW0u+eWWgvl3thCjD0Yn72V?=
 =?us-ascii?Q?DH1Jc1d/LIrbIL7Cgy1cGo/Q0zEF4Es3DYS+h18PAKf8Z0HYwFj/lN5/JFPF?=
 =?us-ascii?Q?0AtWChazH5ilPDMfMSIxfJFMaFM4syez/bdMld50OiJt7XTgSHMAMyy3CWAn?=
 =?us-ascii?Q?egZ32MQbqb9vv0+g0IoUjv7MCODhvh2xSdaWpak0vCRp+sQTYDo0VXALR8ZZ?=
 =?us-ascii?Q?WpaZ64o5H93BlLw7RArmVumLnVK8MUzkzPz64UFJ50/y1xoKkeMmbExTWf+K?=
 =?us-ascii?Q?D8f/1VAay6C/FVh/FMI9OqK8yQES6M8eEoq4DW8YI+mLLh6DudPgD0GjxTY6?=
 =?us-ascii?Q?vWBFxvsOncifCnUSkjdjnFXEVXfUKopnTNddN92rx43V1P6o7KyO8ksm1yUi?=
 =?us-ascii?Q?m7AecctydToj+wbGqeSZoE8ADVu2ip4P5NvnuxXki0WiKB0i63+1hxgxQx49?=
 =?us-ascii?Q?qVx75jxKlAfljUBaeLwtW/SI0IPdlCNa2eApicEmZK8nrbFgevziavy6GnBm?=
 =?us-ascii?Q?tFqxCHqtl9CMPpfYRUQohbIdpFi2s7UKY8UvbExB0k5dVSjOsa48MH89EDG8?=
 =?us-ascii?Q?EBBkZcH0SMAcwMl9y0PYbjPAJm/gMyuwb3TLSa54l7qhDoi94BL4gfWSsG40?=
 =?us-ascii?Q?Sh+q0OG/ytLvUSXeApiDqVWSoX+ACfLo8xavuU8DEKypCANeaMSH4Q/2DnYq?=
 =?us-ascii?Q?XpXgUPXe8PpC44Di9QCr8jTD7JYaAbpjiBnwrD7Eaqc5X/t7yVLO65xmfPv4?=
 =?us-ascii?Q?O0gDyV8KjzGCNRhwzZL4syD2Pv7sewoCOUQTCaDDMiNK3ZEM30lkggexPPMw?=
 =?us-ascii?Q?RoIt3sFBgleh+B86ASWO+wZX4if9Gy/rR8+zAKm5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b5f3f0-3ce7-48e7-4821-08da9c512b66
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 04:16:06.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIvz8Wa3eluqOgRWqBcF9LabpMLqJEDr9gsIxDPl9PS6fFXHrL50wpex1i1SxX91pNsEsZnHPG4pzAW9lQ2OtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:36:42PM +0100, Jonathan Cameron wrote:
> On Tue, 20 Sep 2022 15:10:26 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Tue, Sep 20, 2022 at 01:23:29PM -0700, Jiang, Dave wrote:

[snip]

> > >
> > > And what gets printed
> > > to the trace buffer can be decoded data constructed from those fields by the
> > > kernel code. So with that you can have access both.
> > >   
> > 
> > Fast assigning the entire buffer + decoded versions will roughly double the
> > trace event size.
> > 
> > Thinking through this a bit more there is a sticking point.
> > 
> > The difficulty will be ensuring that any new field names are documented such
> > that when user space starts to look at them they can determine if that data
> > appears as a new field or as part of a reserved field.
> > 
> > For example if user space needs to access data in the reserved data now it can
> > simply decode it.  However, when that data becomes a field it no longer is part
> > of the reserved data.  So what user space would need to do is look for the
> > field first (ie know the field name) and then if it does not appear extract it
> > from the reserved data.
> > 
> > I'm now wondering if I've wasted my time decoding anything since the kernel
> > does not need to know anything about these fields.  Because the above scenario
> > means that user space may get ugly over time.
> > 
> > That said I don't think it will present any incompatibilities.  So perhaps we
> > are ok?
> 
> I favor decoding current record in kernel and packing it appropriately.
> If that means we don't provide some new data from a future version then such
> is life - the kernel needs upgrading.  That information is unlikely to be
> crucial - it's probably just more detail.

Dave, Dan, and I discussed this further today.  Dan expressed the same opinion.
So I'm going to remove all the reserved fields from the next version.

Thanks,
Ira
