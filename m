Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B246412F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiLCBOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiLCBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:14:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D6D4ACB;
        Fri,  2 Dec 2022 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670030079; x=1701566079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iEQuQ43s71cqOzVocrn05n2zSkpbBr+V1l74b11RJtU=;
  b=ZN105I22ZF/yRaInCZrtzWbBo3L/OinXNEbj8iq2kbB8HzmPOE4NbnRS
   bNK6xMgdpKr/5938Q5R3Hu5xRSNGI7LfSZs3AANjUCrgiwVTiQAWLgUI7
   en7bWIzpGHWf7QX4jQ8KIPtg7oSas/9fAOs5Jbx/LBW7RhvzP/eBDi+TT
   O/uKe3lpvoBOPWhMhTvKRcYdgCPXCiBg8Ngil0dnkq/F7/yu3mwuJzMZC
   r4NhMFHp47OBHlRIBpwfnCXVjagKoBhV3iUo2NADGJPnVOF9H5C5v2NjZ
   FQbKT0GXCAzelE+JO069aP6l3LOXKtlWHA5mmmv5NssY+gCpreJx+q/0+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314785912"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314785912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751479709"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="751479709"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2022 17:14:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:14:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:14:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:14:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Zmtsz8jFd4xD73cqQnk089hVBrPVCEACgouLOLtTBbE1Z/XzamdBu4ZzIIOsshsJHYXXBjiSV9pQMQzF+HA3rFWrqkAJzy9MNBlEeB53l4ohc9/R/w7PGY0ZPYTi5UZ2l1Af5oKjpIXc2v+Jqnvz7ASY0gUE/aesKjhH/jfnIpL4XggessetnIk3B7OuP6u/izG/tr9tjh3/P40apJccQ98ON6wX9mu264UhEORQmD5Gzjd+tZMnc+himuEzhuio7Gf2/i0wmZIjAeXgLH1EqCzuH8/Wmj2CGLQVClZMOc6J+GCat37U1HMSAcWD4JMnUID15IDPSkRjgfOG5n+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Df6ZjP+A5jd5ITVbmefxQWM/hOaCP9eAnWM28zC9Q=;
 b=Z5LK3myzevlx0oqfrfGZEZDzz3RH7JPbjl2ggo3bxHIw3RBvt//lmm1hLPFsw0ypHf/uyxQ5OpWh1SkUBOrho7sz5wBuhPFjw61qh6w2Nxcg6GxbmNYsdqCuBENHGUekgMnJ862jW6nwdxSKVvEu7YVQ75UiEy0Pdivqh2Y56eu54szRichaODhr74HMhQ72p4tTnOavE5s/1G/is7Ue5eq+XkJ21J9tHtRC2D+Ke6fmtSvmS99KqZPh/Tzl2XHdiTVl3+Qw1Pm7fboPdjh3l0dX8Gbh2xcm24bS96P9dYH4go1gYEwOXjb0UGxpB/E0YLSfQMWAxH+w3EJOpr/1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7417.namprd11.prod.outlook.com
 (2603:10b6:806:345::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 01:14:30 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 01:14:29 +0000
Date:   Fri, 2 Dec 2022 17:14:27 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <638aa2f3349e_3cbe02943d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
 <Y4qPAi/DZAyz/Djl@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y4qPAi/DZAyz/Djl@iweiny-desk3>
X-ClientProxiedBy: SJ0PR05CA0123.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::8) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ad252f-c3b7-45bc-36e0-08dad4cbba1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgVtrDo7JSzXTihaleu7oqHgcJLP0p+U5Ytef7DhUujjciBVcxrunToPK1mFhVMlgRhLij/JQqwUTuc5MgToehO0ylGJ2z2DPNTPLbDh6b5wl8/6hsTFjyExH4YZJoveNELm1HOR0jSBIo5sqHCqdk6sm9Z7TVO4RBA8vGKRYlHdsddxMPAzjZZ5kk7LlJUs/Zc6yVip70swWUO04roym2uHLazPgH/d0W9BluYp8iZXEq3StR5liwPBajv1+79/kiCw7eXiSgEVkaCQ+YA/U9E8NwhPhrPX8YouAcmUAWl7u9sxy1ZcfBRoqZ/qoaSHCUENw/SXFItKIrzL10MK62zwIQKskNk9nXwCpfCwSOjp2IIw5BeJNAoml8YyQsqOTdQJf8U23HBDZrvbjI9zyNS0emizr58k7MmPJqf/8/L12CKaUk7uX4pr5TZmw7xjWfupAYZqH6WPR3K97TijMxLv6MOBJyR4oDZhSHJx7mV7XhEgPO4DW7MW22Mr1bWXhjFChQDeAT9vHMGalhTxc8C9agJnUwObJzVJRM7nRgVd8Nd0Y/qz5r1YxS6JT1j2YC1fP4uQ91GusNrky5j9IQ41KG1rrCcFs+oHjruzhKXw4CVCiASdfHQcc7HnaTrkFhDTO3yPuohLFteQKmzqjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(83380400001)(86362001)(82960400001)(38100700002)(2906002)(5660300002)(4326008)(8936002)(41300700001)(8676002)(9686003)(6506007)(26005)(6512007)(186003)(110136005)(316002)(54906003)(66946007)(66556008)(66476007)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b4msB/biVAYdLottm85Bq1U5fS6V88ZdKtbdyY50DRBbP7aAMMZVXZIS/kSL?=
 =?us-ascii?Q?2VeUeUsIFaLvo1cfr1X6VByVizjPIfVkdfEPrX0cZ0Gslt5vTFxfWqgo/Fak?=
 =?us-ascii?Q?0Ce1d6hl7qRjuLr1R/QkCz7K4B2hJOAO2VZfWFE6Agd+6QX+vhNiYTLkRhPE?=
 =?us-ascii?Q?IjN/cEESJZ0IpNWInmfbuX5TBn3+MEhsL835yArWEF1A98qFiioawIXYMVt9?=
 =?us-ascii?Q?Kn5PBWtgy7ovDXI3Bc8//QAUnS/GS4UcENYX3MO0I5Lo8oQ/3imne6IPtOyO?=
 =?us-ascii?Q?rQI5APYS6/Wh2sL2XCjeSnAI6WlP9dgytRnYxhKwOnMyX3mZCnFC/q9FxKnf?=
 =?us-ascii?Q?EIBMrsCO3KDBjtag7hvbeFNzxGjITHC4iTD+1Wty0auUBb17RLV2h6YR06V5?=
 =?us-ascii?Q?J0E1ZrsO4gmq0x+E2GhBbWIsHqN2oXBrDfKhAVFWo/NV+0J42o4+3edXiVy0?=
 =?us-ascii?Q?ST++qZZEyobVJM9tdyjhWdXci61ooivlUMfZQmgYYeF5mQB/ojkEFtuLbx4F?=
 =?us-ascii?Q?8y+rl5GENgECOJcwNs4EMWcVQ4h5i35CHRZ1xLavvHEEWZskymG2qCDCWloC?=
 =?us-ascii?Q?0KIZwYDEPBucds3zDnJrXk2epcVRNeurA5GhuaUXy6z8qGUHCfytt65h6ZVA?=
 =?us-ascii?Q?ycagmKmzSOe624/nl/fs4BIApY+y5iH/Be8vDg8LYgtHj6hp7E+/9zX48Mm+?=
 =?us-ascii?Q?PCN5jL4hY29OxZQFpHMpL4jiEheeapI7FMzlhSQXbRjdL+fUyNoj27uGriXc?=
 =?us-ascii?Q?ev+kg1ozpIDUoopMAIu3Aa6JV8dSQf5nqJlP6qzgjjN8PriCvLe6ADggWHTJ?=
 =?us-ascii?Q?myF7T6I2K+8eO4Yk48bJrgBL4CWmA/ubAETwbtQ2dpiCOkAqB6xTDmedJYi5?=
 =?us-ascii?Q?8NqrEv2IgSncInbeNmXVfvBxNZne8sGvDCqX4zwQzPmBLAO3UBExmY8jPA+G?=
 =?us-ascii?Q?Zs+Bfu6F0MdlnlvHCjcP2fksGpkGXsq/6OSVx5Wvrd3cOgVJ0AvPNezz59d8?=
 =?us-ascii?Q?wSkHLPnHpcjM9A6TVTQErA79wM1ZJ8la2rhT/jTj/rRuZwaW30uCvPDs8GWs?=
 =?us-ascii?Q?0pujX9D6STNhwBRY8ISPC9/mU493Cf+yst7oD3fUGGREJQrGjbAcqlFETMfv?=
 =?us-ascii?Q?esYrllclF8m0HTkM7R+hH8Q4nuY60KIrPlrTVkH6XSuTm8bEmWSM8w5Q0I6Y?=
 =?us-ascii?Q?U6LF/O+0Mk0/2q7bJ3nTObhHgFM40UPj1bDVOIIr7UdUMyYWTfJig8zee4EQ?=
 =?us-ascii?Q?vhd+8WnpGzoGigKnXe4S7RW3r1BNKZd0ob6FzOktMiiRQMELCO4gXuNAkAgY?=
 =?us-ascii?Q?rW0vmfJ7RF3eav2RYqPYcavu7nZD0sUsPQMI0AvANvoAUg7VNbjNxoAz7zI3?=
 =?us-ascii?Q?57vC44bSkm8OHoQMf3FaR8iilhN92Q4YPNPFAcuL/XX3XZF2x/kc0yq6E+EA?=
 =?us-ascii?Q?vh5xuMoJJ5eAJmyscszSq856q9YJnYfvq7qbB2yOYCPn0PfIuxiUtloACP2t?=
 =?us-ascii?Q?8SgYEn6TQ5R3+Mvdt5r+GD1LmZW8SbwxM5U3au241pvUi3Kt+vnhvmGPDhGC?=
 =?us-ascii?Q?FdTKWZrBJNG5tVHWkLKStOEPnfg8yORbJ7ujaihxqNwSknbvXi9vVjPiojsi?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ad252f-c3b7-45bc-36e0-08dad4cbba1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:14:29.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNjYRzz9tZR5DMuYa40OqZ45yO5npY5LUbYOdzguRIDk+OXgbREcNsG8NtnYNuNVEtCa2LNsARylBmGQjA4q7+qZfMFz8hZ+zf8ilbvqKfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> On Thu, Dec 01, 2022 at 06:29:20PM -0800, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> > > command.  After an event record is read it needs to be cleared from the
> > > event log.
> > > 
> > > Implement cxl_clear_event_record() to clear all record retrieved from
> > > the device.
> > > 
> > > Each record is cleared explicitly.  A clear all bit is specified but
> > > events could arrive between a get and any final clear all operation.
> > > This means events would be missed.
> > > Therefore each event is cleared specifically.
> > 
> > Note that the spec has a better reason for why Clear All has limited
> > usage:
> > 
> > "Clear All Events is only allowed when the Event Log has overflowed;
> > otherwise, the device shall return Invalid Input."
> > 
> > Will need to wait and see if we need that to keep pace with a device
> > with a high event frequency.
> 
> Perhaps.  But yea I would wait and see.
> 
> [snip]
> 
> > > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > > +				  enum cxl_event_log_type log,
> > > +				  struct cxl_get_event_payload *get_pl,
> > > +				  u16 total)
> > > +{
> > > +	struct cxl_mbox_clear_event_payload payload = {
> > > +		.event_log = log,
> > > +	};
> > > +	int cnt;
> > > +
> > > +	/*
> > > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > > +	 * Record can return up to 0xffff records.
> > > +	 */
> > > +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> > > +		u8 nr_recs = min_t(u8, (total - cnt),
> > > +				   CXL_CLEAR_EVENT_MAX_HANDLES);
> > 
> > This seems overly complicated. @total is a duplicate of
> > @get_pl->record_count, and the 2 loops feel like it could be cut
> > down to one.
> 
> Sure, total is redundant to pass to the function.
> 
> However, 2 loops is IMO not at all overly complicated.  Note that the 2 loops
> do not do the same thing.  The inner loop is filling in the payload for the
> Clear command.  There is really no way around doing this.
> 
> Now that I've had time to think about it:
> 
> 	Are you suggesting we issue a single mailbox command for every handle?
> 
> That would be a single loop.  But a lot more mailbox commands.

I was thinking something like this pseudo code

int tosend = le16_to_cpu(get_pl->record_count);
int added = 0;

    for (i = 0; i < tosend; i++) {
    	add_to_clear(added++);
    	if (added == MAX)
    		send_mailbox();
	added = 0;
    }

    if (added)
    	send_mailbox();

...where it batches and sends every 256 and one more send afterwards for
any stragglers.
