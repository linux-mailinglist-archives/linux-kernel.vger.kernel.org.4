Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EBA63B5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiK1Xa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiK1XaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:30:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC2326C6;
        Mon, 28 Nov 2022 15:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669678221; x=1701214221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oNnrllVdo/L3mYj3m79taLhFiraqupmVEqUq9T6mRVs=;
  b=l4YpxXCqVrP3B9w1Gv0ediwauwCAl/X4HQIqeJ/e1OKBLtorLG0iziWI
   fjXBjN2Jb08FSBVsDpSizgNgnGmRNXrqhZKjRY4mpy9JM3ABXSbAuzxYA
   c4iLVSWbKzFYjZuXJYqbL1WlQQXQTTPqzQB5cNTmYpPRhxJL6eRiP5yfG
   L3TON2DEtWLkCtgIkEipmlfSMnfhuRL5n1hA2FWjFby3Qw0WK2xHV1Pqv
   +zH+ZnQsaR9d88uc91qMMf+Il+tZ2qLSESd2Uy/l2LIlUSkuI0CSLQvlb
   V3aq+Z473VARE5Y4kmd2McjCO4rO/O3QkamVpvmROhIfv6ssStN0GR+Z/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341891178"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="341891178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="674408921"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="674408921"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2022 15:30:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 15:30:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 15:30:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 15:30:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOFs/kgZPzkQaOPeUBOU/V+AgZ5n3azKmWGZuaE+jTfs8kduEISFSzpYGPY5cDcApscI6mnDWj9jfi13/Ynp7ZLpU2GEQwjm67osZtKYk+BE6buq/1n77Ol7gqV2/9NGMQ0QsCBKHHNFJpWzVdSj4YjKTj9wPkzHWEXko8XWTXBRyL6b6OE+NvE1WTUBrSzBgV7YBSXzyl0VaikbW7+9yKzD3YukaPaMTjernjcR5bo5OhuQ1u+1C/lD1TtCRBwcZkQI982sKGSDCY7Ce1eg3Hk6kYFJy1kJtkcIwYmXeQsjYlFdYU93viitPSAT7QcNN6nZG9v7M9qxuq5eQdVYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHOa4ExapiypFDFOU0ZeD3Z9C+dz6fPTaD4uTxu+hRU=;
 b=E2GgTnz2HOvHaoP73c8+/y/QATdsAkfJNXLLXKuohrJrhbo+4j5uNRZ5uxU3jE8IMsrgJc1uDgcTHfH1LvkU/LmPcbJw1XGVpj50PORlKFlOPpave54O0MYmuKq40GVjx9boaIwlY3gVRdjKNEapGZSNJIZ+tuqQTlGNqjN5mgssqN4hAOVgUQl4Y/JWsfF4k75HSSh8CXCIR1WE1rmMSbQH7YG49hIMfrcuxw/ZSJPStABYUY3G2UYZpHAWbWw5+cpJH3aFh5wlXPRHRzCV17EdcRFMSc/XvIJlZ9ndt8vTcNLYbCTR2pqv0sb8PjnogriWlTvHyQUGyadaa317KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 23:30:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 23:30:16 +0000
Date:   Mon, 28 Nov 2022 15:30:12 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4VEhNNTbXj5EwOm@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-3-ira.weiny@intel.com>
 <20221116151936.0000662f@Huawei.com>
 <Y3WEmMlLfPoYG1R5@iweiny-desk3>
 <20221117104337.00001a3f@Huawei.com>
 <Y3gUmSuR3OxUwkDm@iweiny-desk3>
 <20221121104714.00003bab@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221121104714.00003bab@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af79f45-4166-4139-4077-08dad198817e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdm6tzG5PwasmLz72s5c1DoJHuJ8xmtUtpoLodXE7pVV8uIiny5vrnkxNTJ70Ojus4J5DqurXzeXD/FaSuTbRBQ5JSVlHHKzf5vMiG3Urj+XsoLdK5FZsCLmaa8vwbNKSbdHO3ngiG6g34HnoxYXOUlIipt7DDt1IoZv+iSDH7HKNJwtmJeFNTbVcYbHHIFCteByQTZawDKc1y589dMR7ac4go6PMC35hRf141HOnXFX+DG6ydhwIwYh4+8ACh/UXPljpfCVXoqGA7uVl7Obcw8FvIiOVVmj4F71aTYWnsscDzGydivFZorfGz77bQPJgj55w3ome+Llvyj34+vWcb7E0brIj+WNZvVxoNLIJONqZtQqAntuK/8WLOPLkSDLuUc0OqW9wo15RqHIZ/ccfrDsu74WP79RgSsdOgR0c3qQ28jzeABZbFt8lqI81OdqvsWbhWan3QSWRwMD7utiY3+xL3/HuwsaqdWdyIRXasx30XPH+eUyhDbzWN5L5wtf1tS3ISwSfdVtZUoivniOd7QPllfa+GR1Hza69Zely/EHUqMZOQO1fPO/hh1vUvS107RX1XhstpH5QgIZvkGAXTLiBAdX5EpQ+jHJdI07xb9MQ39c7JBvq1+jytGmEcByKKxk24RcpeiIph5nepOxHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(41300700001)(8936002)(2906002)(5660300002)(66899015)(6486002)(6916009)(316002)(66556008)(8676002)(66946007)(4326008)(83380400001)(54906003)(478600001)(86362001)(6506007)(6666004)(9686003)(26005)(186003)(30864003)(44832011)(66476007)(6512007)(82960400001)(33716001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFAYcCasY8BziSR9xylYEHZKTVjutrNg4tTRu0IxTCB3rrxTeyc33tN7lqSH?=
 =?us-ascii?Q?104LgvG2xZ5iCDP/BQxP9jH1K/KwExNW0PQqNBn9w84SIM/llZhpa/MBdwTi?=
 =?us-ascii?Q?9kxJ7Sg3kJwvt68KEXBRIvJO/MZQDIBlOrzj8+pzKbqIRis5vm3yqZ1mLdoH?=
 =?us-ascii?Q?6TPVqZiLppl3pJQ2Ep2KBxAioCs4dfEvmI/6OVvO3vPAmZJ/kFc4UU0Es5i1?=
 =?us-ascii?Q?0CCx61bA0GrSyCIs07ufS9lEwVApc76m9lijPylpqoLbn2J1AVWozeqw5q8R?=
 =?us-ascii?Q?QgBPKUHUTP2k6Q2QAyxY6y7EIBzA5vYqrL4KwOXlF/2fmZK3h8kmVW4dn5AC?=
 =?us-ascii?Q?YWhbTAx+TuR/RSW9n6VNCk1YPJg33XdsmAercFZ6kzdNKFXE300y6jrQGyN4?=
 =?us-ascii?Q?KiHHSbr3vyWWPBz3q/ojOLg0enaogq58OF81jh1RBPjXJc+PANxNBbysOGM2?=
 =?us-ascii?Q?0P0NF4trILamFsY4CLFDukcBtCbtntfsqGEnJMdlys07vPMLkP3Q7EEnTOVV?=
 =?us-ascii?Q?RWYkEb7rw1ZgY/sxKq5/M6NH0NIn8wHL4wnQbRAt/f7HptJ6GC332fFaCZ4G?=
 =?us-ascii?Q?EoErMR6rFQ/ySAQuY2PuVy8yrlwqX8QnEX5os0dNjWFyyasjsnt3CHm8E+64?=
 =?us-ascii?Q?dJNdTI6dcV/MiqJho2xxJ0tbLGp6SPjBs+kJPB1IMdTHFbYFfcHiiHJ88nl2?=
 =?us-ascii?Q?qHrt9VblQ1LWoPJHrJ+Y677QQn84SANq8OfwTvoKAv7rRcQZ3t0g9XstlSn/?=
 =?us-ascii?Q?3er2Ok2oQWgkLwOwcknU7eCg79jYcgxpzcSFhs61ZtKrKBgLQKfVgI3x+Mhy?=
 =?us-ascii?Q?aOY/hzqLMPhiiGJl5+mbCfRSeVSrXRGalGeg9jp7ibwf+TR9aN/xD4KDCQZv?=
 =?us-ascii?Q?j3Z7TsbzA4AslRB4O3g4QYDKLWVuRf3WiqaD+vpPdKoEf5ljqErEfBmwp7Jv?=
 =?us-ascii?Q?imH/6pCz5vBwbKIFWVdGIR7qGhUYNQvjEdx6N8qkVwpRCTmgwEgBdQX2kCZo?=
 =?us-ascii?Q?HqdV7jHr5wB3XrrOW7DfFL5rO4jmoAfV9Qv4jvBmX7zNkL5URpr+RQSileOg?=
 =?us-ascii?Q?9SVHzPJ1pkvnCPZs7xICW7sdHEimVbFbtZ4NLZs+yB4hmKkx6PU+EJgciOVL?=
 =?us-ascii?Q?tASJLxghLbMTQ8rcHhOCzA9v5jHQc1nf2FXAiQ0POrzgG5iSndb8vtGNuepY?=
 =?us-ascii?Q?ORJHaMJTebQqcGp5apo91ilVfcMeShXL0q+iOepDWJGqgSyoeQNAzIwYOJku?=
 =?us-ascii?Q?eNEyMyQf/wzHpXmo92pqbs3vIEas0G7UwV8NGf3m6Nl3XBG5KBAJTw3m3m9h?=
 =?us-ascii?Q?2JfxoAdlalDwBet+xNJnHlAHa6h74J7D5x3JUXpx31HY48gpLZ28uvmtkJJL?=
 =?us-ascii?Q?PYZj59p4EjN6zNW1dpJBl9Hm3RFcrhzFxXjM+nRQGX470v27O70/Ve1lC5LP?=
 =?us-ascii?Q?IrVQk3igy6BJYk51I2rTRK8Wau4J63yWGs7nsipf4l+DZM7s/489kp02e05i?=
 =?us-ascii?Q?oPyRwk1QK2YFzuDxTncgm/0XwlF7UajLZWOm9mZOaV7JF6lrfwPnnr1GXMX+?=
 =?us-ascii?Q?psHyOfIGCXiLf7wnAt21MB5MIGi2P8gVa0D8vQCq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af79f45-4166-4139-4077-08dad198817e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 23:30:16.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKdNgItmwoOYqmdW7Kw26qqEkxh9c1llDqGv/nBlbxL7UGK5DUIKxRHNSMhdWOledb/YIglFzLyY0Ogaf21Gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:47:14AM +0000, Jonathan Cameron wrote:
> On Fri, 18 Nov 2022 15:26:17 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Thu, Nov 17, 2022 at 10:43:37AM +0000, Jonathan Cameron wrote:
> > > On Wed, 16 Nov 2022 16:47:20 -0800
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > 
> > >   
> > 
> > [snip]
> > 
> > > >   
> > > > >     
> > > > > > +			int i;
> > > > > > +
> > > > > > +			for (i = 0; i < nr_rec; i++)
> > > > > > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > > > > > +							type,
> > > > > > +							&payload.record[i]);
> > > > > > +		}
> > > > > > +
> > > > > > +		if (trace_cxl_overflow_enabled() &&
> > > > > > +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> > > > > > +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> > > > > > +
> > > > > > +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||    
> > > > > 
> > > > > Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
> > > > > payload not the total number.    
> > > > 
> > > > I don't think so.  The only value passed to the device is the _input_ payload
> > > > size.  The output payload size is not passed to the device and is not included
> > > > in the Get Event Records Input Payload.  (Table 8-49)
> > > > 
> > > > So my previous code was wrong.  Here is an example I think which is within the
> > > > spec but would result in the more records flag not being set.
> > > > 
> > > > 	Device log depth == 10
> > > > 	nr log entries == 7
> > > > 	nr log entries in 1MB ~= (1M - hdr size) / 128 ~= 8000
> > > > 
> > > > Device sets Output Payload.Event Record Count == 7 (which is < 8000).  Common
> > > > mailbox code truncates that to 3.  More Event Records == 0 because it sent all
> > > > 7 that it had.
> > > > 
> > > > This code will clear 3 and read again 2 more times.
> > > > 
> > > > Am I reading that wrong?  
> > > 
> > > I think this is still wrong, but for a different reason. :)  
> > 
> > I hope not...  :-/
> > 
> > > If we don't clear the records and more records is set, that means it didn't
> > > fit in the mailbox payload (potentially 1MB)  then the next read
> > > will return the next set of records from there.  
> > 
> > That is not how I read the Get Event Records command:
> > 
> > From 8.2.9.2.2 Get Event Records
> > 
> > ... "Devices shall return event records to the host in the temporal order the
> > device detected the events in. The event occurring the earliest in time, in the
> > specific event log, shall be returned first."
> > 
> > If item 3 below is earlier than 4 then it must be returned if we have not
> > cleared it.  At least that is how I read the above.  :-/
> 
> In general that doesn't work.  Imagine we cleared no records.
> In that case we'd return 4 despite there being earlier records.
> There is no language to cover this particular case of clearing
> part of what was returned.  The device did return the records
> in temporal order, we just didn't notice some of them.
> 
> The wonders of slightly loose spec wording.  Far as I can tell
> we are stuck with having to come with all things that could be
> read as being valid implementations.

So I've been thinking about this for a while.

Lets take this example:

> > > 
> > > Taking this patch only, let's say the mailbox takes 4 records.
> > > Read 1: Records 0, 1, 2, 3 More set.
> > >    We handle 0, 1, 2
> > > Read 2: Records 4, 5, 6 More not set.
> > >    We handle 4, 5, 6
> > > 

In this case what happens if you do a 3rd read?  Does the device return
nothing?  Or does it return 0, 1, 2, 3 again?

It must start from the beginning right?  But that is no longer in temporal
order by your definition either.

And if it returns nothing then there is no way to recover them except on device
reset?

FWIW I'm altering the patch set to do what you say and allocate a buffer large
enough to get all the records.  Because I am thinking you are correct.

However, considering the buffer may be large, I fear we may run afoul of memory
allocation failures.  And that will require some more tricky error recovery to
continue reading the log because the irq settings state:

"... Settings: Specifies the settings for the interrupt when the <event> event
log transitions from having no entries to having one or more entries."
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This means that no more interrupts will happen until the log is empty and
additional events occur.  So if an allocation failure happens I'll have to put
a task on a work queue to wake up and continue to try.  Otherwise the log will
stall.  Or we could just put a WARN_ON_ONCE() in and hope this never happens...

I still believe that with a clear operation defined my method makes more sense.
But I agree with you that the language is not strong.

:-(

> > > Record 3 is never handled.
> > > 
> > > If we add in clearing as happens later in the series,  
> > 
> > I suppose I should squash the patches as this may not work without the
> > clearing.  :-/
> > 
> > > the current
> > > assumption is that if we clear some records a subsequent read will
> > > start again.  I'm not sure that is true. If it is spec reference needed.
> > > 
> > > So assumption is
> > > Read 1: Records 0, 1, 2, 3 More set
> > >   Clear 0, 1, 2
> > > Read 2: Records 3, 4, 5, 6
> > >   Clear 3, 4, 5 More not set, but catch it with the condition above.
> > > Read 3: 6 only
> > >   Clear 6
> > > 
> > > However, I think a valid implementation could do the following
> > > (imagine a ring buffer with a pointer to the 'next' record to read out and
> > >  each record has a 'valid' flag to deal with corner cases around
> > >  sequences such as read log once, start reading again and some
> > >  clears occur using handles obtained from first read - not that
> > >  case isn't ruled out by the spec as far as I can see).  
> > 
> > I believe this is a violation because the next pointer can't be advanced until
> > the record is cleared.  Otherwise the device is not returning items in temporal
> > order based on what is in the log.
> 
> Ah. This is where we disagree.  The temporal order is (potentially?) unconnected
> from the clearing.  The device did return them in temporal order, we just didn't
> take any novice of record 3 being returned.

:-/

> A valid reading of that temporal order comment is actually the other way around
> that the device must not reset it's idea of temporal order until all records
> have been read (reading 3 twice is not in temporal order - imagine we had
> read 5 each time and it becomes more obvious as the read order becomes
> 0,1,2,3,4,3,4,5,6,7 etc which is clearly not in temporal order by any normal
> reading of the term.

Well I guess.  My reading was that it must return the first element temporally
within the list at the time of the Get operation.

So in this example since 3 is still in the list it must return it first.  Each
read is considered atomic from the others.  Yes as long as 0 is in the queue it
will be returned.

But I can see it your way too...

>
> The more I read this, the more I think the current implementation
> is not compliant with the specification at all.
> 
> I'm not seeing a spec mention of 'reseting' the ordering on clearing records
> (which might have been a good thing in the first place but too late now).

There is no resetting of order.  Only that the device does not consider the
previous reads on determining which events to return on any individual Get
call.

> 
> > 
> > > 
> > > Read 1: Records 0, 1, 2, 3 More set.  'next' pointer points to record 4.
> > >   Clear 0, 1, 2
> > > Read 2: Records 4, 5, 6 More not set. 'next' pointer points to record 7.
> > >   Clear 4, 5, 6
> > > 
> > > Skipping record 3.
> > > 
> > > So I think we have to absorb the full mailbox payload each time to guarantee
> > > we don't skip events or process them out of order (which is what would happen
> > > if we relied on a retry loop - we aren't allowed to clear them out of
> > > order anyway 8.2.9.2.3 "Events shall be cleared in temporal order. The device
> > > shall verify the event record handles specified in the input payload are in
> > > temporal order. ... "). 
> > > Obviously that temporal order thing is only relevant if we get my second
> > > example occurring on real hardware.  I think the spec is vague enough
> > > to allow that implementation.  Would have been easy to specify this originally
> > > but it probably won't go in as errata so we need to cope with all the
> > > flexibility that is present.  
> > 
> > :-(  Yea coulda, woulda, shoulda...  ;-)
> > 
> > > 
> > > What fun and oh for a parameter to control how many records are returned!  
> > 
> > Yea.  But I really don't think there is a problem unless someone really take
> > liberty with the spec.  I think it boils down to how one interprets _when_ a
> > record is removed from the log.
> 
> This is nothing to do with removal. The wording we have is just about reading
> and I think a strict reading of the spec would say your assumption of a reset of the
> read pointer on clear is NOT a valid implementation.  There is separate wording
> about clears being in temporal order, but that doesn't effect the Get Event
> Records handling.
> 
> > 
> > If the record is removed when it is returned (as in your 'next' pointer
> > example) then why have a clear at all?
> 
> Because if your software crashes, you don't have a handshake to reestablish
> state.  If that happens you read the whole log until MORE is not set and
> then read it again to get a clean list.  It's messy situation that has
> been discussed before for GET POISON LIST which has the same nasty handing
> of MORE.  (look in appropriate forum for resolution to that one that we can't
> yet discuss here!)

I can see the similarities but I think events are a more ephemeral item which
makes sense to clear once they are consumed.  The idea that they should be left
for others to consume does not make sense to me.  Where Poison is something
which could be a permanent marker which should be left in a list.

> 
> Also, allows for non destructive readback (debugging tools might take a look
> having paused the normal handling).

That is true.

> 
> > If my interpretation is correct then
> > the next available entry is the one which has not been cleared.
> 
> If that is the case the language in "More Event Records" doesn't work
> "The host should continue to retrieve records using this command, until
> this indicator is no longer set by the device"
> 
> With your reading of the spec, if we clear nothing, we'd keep getting the
> first set of records and only be able to read more by clearing them...
> 

Yea.

> 
> >  Therefore in
> > your example 'next' is not incremented until clear has been called.  I think
> > that implementation is also supported by the idea that records must be cleared
> > in temporal order.  Otherwise I think devices would get confused.
> 
> Not hard for device to do this (how I now read the spec) properly.
> 
> Two pointers:
> 1) Next to clear: CLEAR
> 2) Next to read:  READ
> 
> Advance the the READ pointer on Get Event Records

And loop back to the start on a further read...  I'm looking at changing the
code for this but I think making it fully robust under a memory allocation
failure is going to be more tedious or we punt.

> For CLEAR, check that the requested clears are handled in order and that
> they are before the READ pointer.
> 
> Maybe we should just take it to appropriate spec forum to seek a clarification?

Probably.  I've not paid attention lately.

I've sent a separate email with you cc'ed.  Perhaps we can get some
clarification before I completely rework this.

Ira

> 
> Jonathan
> 
> > 
> > FWIW the qemu implementation is based on my interpretation ATM.
> > 
> > Ira
> > 
> > > 
> > > Jonathan
> > > 
> > >   
> > > >   
> > > > >     
> > > > > > +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> > > > > > +}    
> > > > >   
> > >   
> > > >   
> > >   
> 
