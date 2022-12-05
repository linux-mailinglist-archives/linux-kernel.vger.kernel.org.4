Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72719642D22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiLEQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLEQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:39:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B093CDF;
        Mon,  5 Dec 2022 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670258255; x=1701794255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oD/Rab1cK9SPuo8VsmfAqAiCovkuC684q1jJvuoBW0o=;
  b=X2UDizhfD6qEyPNUFylgabgC+S/Val0pQ38e3R1+8vSkjVzJuR7an5R9
   pV6zlaPJ8FrZXby7T7YVEXVp+IAVRZ4KFOb1DdS4M54VjoTWT0qEJoPNZ
   37EE6EzTjkXVoNaDf6+xYGFp9iZyHTDi5R6VO2Er8LBh9mLdfWjZM40Ss
   DnFPEYU9nCtU+S70EmrwEjQFRInqHDqYFulrWHsUTfWtbhFKaQQFWOOw7
   oykvm7bRwChJkSM5pqx/bmb9OV5CgviBKr7KrSCjOA8bAXbxp2S5F4vTw
   QIZz3sUEj1FjzMOheO5qjIq8bJTN2nOEzpw8Gtgy4tL0unNFSeCWPaT6C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="296754242"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="296754242"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="974744758"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="974744758"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2022 08:35:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 08:35:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 08:35:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 08:35:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClTvX1nsDe9rX9lyOnt6flajzPDwba9vjiWxYp7AMHasJEu8ubefH5SQAFFKWopHt/FrxblPtSEvTrY+xE+1VfYplCvtCfzJBmRl911SkdApiZxEBnEF36ygtL0mtA4woP6opYm9fBkEwG1J3cAweexCyzmeHL8K6jwuWCkURjYum8DsavSKyDm9xBKL4ke+pbwlpw6yurf9xbkXLYKWNoJq2Pwl6ybUfu/YdK2ZqADcwYLC48xZy8tsISEud/vZYWKfN7Ud63UPVPxMePqlR4w4rcv8S2qkdzkRaIVf2/2B3hBG6lbtI8Mvb7Ax+/tcLMcAkUDe876d/WaJa9w/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IREAcznB0uwBOp+c2C7A92sN2mnR8fiCWwU+4/wTEfI=;
 b=kN86hwcLEcngCDf3rKecIlG4/EqOgDjGT1BcYoSrkUXi6HpBx8oEA9oWYmgUFuP9I8DQ5uEjizDjgZevudumfieMCaKt9DWRXrPdJxZ1Ruq/qKvzoEULAI49Evn9B3qs/QMM/bW4ihwW3tvDLtd17tdgP68UfwbPviv5MHlJVFoHk69GSgTBhVptA0W4ie/NpK4FlZ5eHM8KHv/Tw2RMeURlPHyq/e8VhbjCmv21yjEUTzxvjJiO4+T1W/1HYQNeLurqGkH7ptbfVa6dDlu/sW6jfG/OsEpy0rRTFcUKpPGNPIRG1mdFcS12C1PAxGfvPwH8hpO+YjmTD6mC8spUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM8PR11MB5703.namprd11.prod.outlook.com
 (2603:10b6:8:22::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:35:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:35:38 +0000
Date:   Mon, 5 Dec 2022 08:35:34 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <638e1dd6aa7bb_25af829435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-9-ira.weiny@intel.com>
 <6389ab5156083_c9572947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20221202141901.00003016@Huawei.com>
 <638a55611405d_3cbe02942c@dwillia2-xfh.jf.intel.com.notmuch>
 <20221205130129.00000cc1@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221205130129.00000cc1@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM8PR11MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d2a9bb-357e-4727-4d89-08dad6debd30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vq9RvF89jV5U2sNVFN/nwTL3hNmjm74hFJnza5TbfQ2qkW97tMp4ly9/Wo74TcA29DNp/lpS8LGvdJC7jJiLZN/1xcC/IqegacOF2g9U5DuGzjdzUlg8jiusEjRU3BqbT6D8mq15rCSQAWO1IGXJT4NsxFKKV0DD4A2ceKJrIQ11vDHy5NFWtBvpddL8IoaCYS1gW8+H2Sfr1EC8NB58g1LDZQZpEmcwLH5u8wpD9C9TDEGJ7Bm1WwQ95d6QPfkETilCVz1YyZcX1V0Z2QOnDOxMeIP1pv5Tp+2TJuWx+DzkpGdBuFdpEy4ViInZLOs5ZtVuypxLzN+28S4RM+3Ot/e2XZeaJxjhrcuJ+TSkZPO2pfKb9ngek964mtfBJD9lqV09FwsdMEdFQVDYxrMGXIfg0YOXR4J6hJPFtmAW1cT/Usquwdt9nY+MM1naeB8ppjGm+2cJ+eTBp85ynbZDSYDWmlXPnsVDDJDvd9k/Lg4g3ui0CKtbXvD+LSREp6D+EGtuW+EikvduoyXCtX/ae5bfvQCDrpqmYeAiZoSkTxU5KKIL1fe57UNxC4zpY8ZXCS/W92ehR/H/n1gveFsGchvN9/OMk6tyZL5SD32t62IdP2YfiUm80u7sS2+MMb1ftTVJByL4DVFYQYTrolsnoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(66556008)(66476007)(2906002)(8676002)(4326008)(66946007)(6486002)(316002)(110136005)(5660300002)(54906003)(6666004)(86362001)(186003)(6506007)(9686003)(6512007)(26005)(8936002)(478600001)(38100700002)(83380400001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02eGaeFKW30IZOAQ8cU9mNBnowKvCqjGOwcm0nXAvrNf4yM2YCxiJe7NkmWG?=
 =?us-ascii?Q?gRsD+V0TrMtrGzKhztnb7Makps4FWnCrC8nZdIQl8lYWdJCSo8IcjkrzW7a9?=
 =?us-ascii?Q?yGEs4NjLWKP2Htpf52Z0IO/H6PD9z+Y9LSEds+64WzNEYAsqSaX5CsqBdoA1?=
 =?us-ascii?Q?C8wiScngHDaLhfLdd6X2DWDJBTRT417ZCrdlZ8z3ibtbpBipIEY/qGk42C79?=
 =?us-ascii?Q?2nIZRPa/zhTtRx3h07FLTZp42Gs0UGKFaZXZibm9Nzd+6WUbSaNo0C5nENBD?=
 =?us-ascii?Q?JgYzcKiIXlaa9uvWT8D+FwsIK4qa3p2iEb2J4XKBG8NW+mIJmooCbqR3iZ8N?=
 =?us-ascii?Q?TUhjEGVTaxD3kufAz1J1p5Z2jkzI16S2XORKFZDG2xbZtjhPBfiwca6VDziF?=
 =?us-ascii?Q?fE6RiD0xiu6MpOYRlLeaR+kftwhOxIzyhcUs5HUKKnwmD5eaxdO6p3gCA6PA?=
 =?us-ascii?Q?bPgO93dfdeg6eC7NYbIii11Rg6sb9NgxLoRBy/kETgkNNUnq2BbNIwFIT1E5?=
 =?us-ascii?Q?RLys0hBmU2qRKJecIOqbG+0QtKXcj30auDjPskdTHQGbJZgEXXmbXeOouvVA?=
 =?us-ascii?Q?fTkknqCyeCNmUitRD5AmVuyaNlbUSlOPX5e7Xh5xE6CFwjpzP/1wduEbHiON?=
 =?us-ascii?Q?IIEp8vb2oA138bPHj1HugeBwoVn7g2bBZY9ZJuTJ9vbh17t3aULE+KvtMM9Q?=
 =?us-ascii?Q?2fGqkqRIjBmkLqzpMpG3wLwi1h2mJBrNphnjOuRIctRmDa+Urif6H0MLW5lt?=
 =?us-ascii?Q?mkIQzrYyXxCqL4YUk1+MQdn7VT1vhV2OgzEvKxXAOzcXn6RSjcYKXHcVJBQO?=
 =?us-ascii?Q?JIViBIRMQePazP+m0/dd5HfRAujyJYK4VNtH6xHo79XWdKYcOx4QqeejFDn3?=
 =?us-ascii?Q?2M4G+5VtLJhK8y67kCT2qroP8DnYN/n6fuDglatxDR+q47AcBaDLNpvg9dIe?=
 =?us-ascii?Q?2pwfX2ZyyNVeD5NzfRam+eKEVYEtbcSgXWZ5l4xaDsy936iEvPoyaL64QOVv?=
 =?us-ascii?Q?xb5+9RoykPd6mWGZqAEcucIp0V4M5IvmLz0A4rj2zNaKO6CMCYqRYC9YvCXD?=
 =?us-ascii?Q?PGszz+caVg0aX4815b5+adH/NOxBIWeu1Mdd332VrwOZsz4Nt2NWqMOccRJX?=
 =?us-ascii?Q?9xvkNTpzvMItDtGvgSFPtUxgUt5WtVKJ+Qa4yWHLB3AtZ55GdQ0qnNitDoqp?=
 =?us-ascii?Q?JK0/I+uxYY1a9u+i2crJ3CNvBxKgToIPVq/kAu+LZXawI31shgWG7IrDVHV+?=
 =?us-ascii?Q?6aGCx9Z1xsW4tsfXczFvCmdpvBql4UljU5oto8YIKu+PHNxuFiXWzQQpEcm1?=
 =?us-ascii?Q?4CdF7LS+NEa+D4MhBcRGT3TgoqmqwDcMv407V5a23EUb6Z79VJTa1QpqvpiI?=
 =?us-ascii?Q?gs146WvFYkixuhT2rREAsXqRmkpKFaNkzOOVBKhx7OkLsCOnoZLQ7Ne+r60j?=
 =?us-ascii?Q?3Mh/x8euGcPSjfCYr5BCG+Gx2xerkECPxfhwyB4xV4vpZr/YcuRguPAMdenv?=
 =?us-ascii?Q?XEvnsWIP8aM8BR8QOupPZlo962V5p8a3y2nHfAHfACm3M2Sl6sYYdgyn0tmV?=
 =?us-ascii?Q?llv4a02zqp6AGB2dPS2Xl+jHoiOuhTwOOOfd1gBPYIi9tm1t+kWnd/FlGCf0?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d2a9bb-357e-4727-4d89-08dad6debd30
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:35:38.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXn/VdXfjNSL8OPimRtsJuzVDbT7Xr1JlihnwHPhQVq0F54eRfBJHuX92SnVpWDxmlB9Qvc6zeDzUJFdhz4u3IhZR3+q7Hwn0QDdyRqHnDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 2 Dec 2022 11:43:29 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > >   
> > > > > +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > > > > +			     struct cxl_event_interrupt_policy *policy)
> > > > > +{
> > > > > +	int rc;
> > > > > +
> > > > > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > > > > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > > > > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > > > > +	policy->fatal_settings = CXL_INT_MSI_MSIX;    
> > > > 
> > > > I think this needs to be careful not to undo events that the BIOS
> > > > steered to itself in firmware-first mode, which raises another question,
> > > > does firmware-first mean more the OS needs to backoff on some event-log
> > > > handling as well?  
> > > 
> > > Hmm. Does the _OSC cover these.  There is one for Memory error reporting
> > > that I think covers it (refers to 12.2.3.2)
> > > 
> > > Note that should cover any means of obtaining these, not just interrupt
> > > driven - so including the initial record clear.
> > > 
> > > ..
> > >   
> > > > > +
> > > > > +static irqreturn_t cxl_event_failure_thread(int irq, void *id)
> > > > > +{
> > > > > +	struct cxl_dev_state *cxlds = id;
> > > > > +
> > > > > +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > > > > +	return IRQ_HANDLED;
> > > > > +}    
> > > > 
> > > > So I think one of the nice side effects of moving log priorty handling
> > > > inside of cxl_mem_get_records_log() and looping through all log types in
> > > > priority order until all status is clear is that an INFO interrupt also
> > > > triggers a check of the FATAL status for free.
> > > >   
> > > 
> > > I go the opposite way on this in thinking that an interrupt should only
> > > ever be used to handle the things it was registered for - so we should
> > > not be clearing fatal records in the handler triggered for info events.  
> > 
> > I would agree with you if this was a fast path and if the hardware
> > mechanism did not involve shared status register that tells you
> > that both FATAL and INFO are pending retrieval through a mechanism.
> > Compare that to the separation between admin and IO queues in NVME.
> > 
> > If the handler is going to loop on the status register then it must be
> > careful not to starve out FATAL while processing INFO.
> > 
> > > Doing other actions like this relies on subtlies of the generic interrupt
> > > handling code which happens to force interrupt threads on a shared interrupt
> > > line to be serialized.  I'm not sure we are safe at all the interrupt
> > > isn't shared unless we put a lock around the whole thing (we have one
> > > because of the buffer mutex though).  
> > 
> > The interrupt is likely shared since there is no performance benefit to
> > entice hardware vendors spend transistor budget on more vector space for
> > events. The events architecture does not merit that spend.
> > 
> > > If going this way I think the lock needs a rename.
> > > It's not just protecting the buffer used, but also serialize multiple
> > > interrupt threads.  
> > 
> > I will let Ira decide if he wants to rename, but in my mind the shared
> > event buffer *is* the data being locked, the fact that multiple threads
> > might be contending for it is immaterial.
> 
> It isn't he only thing being protected.  Access to the device is also
> being serialized including the data in it's registers.
> 
> If someone comes along later and decides to implement multiple buffers
> and there for gets rid of the lock. boom.

That's what the mailbox mutex is protecting against. If there is an
aspect of the hardware state that is not protected by that then that's a
bug.
