Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7563F3F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiLAPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLAPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:30:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83999B0A10;
        Thu,  1 Dec 2022 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669908654; x=1701444654;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6UdgQzG6FK8nMTxZet3qPS2L2PMcpAo4aT4ngOPoqP4=;
  b=dbFamNtCXlr9KkbIMaATYvVUOZOeMMxUtiQU8tn/nxRk8pKmIP+18u3d
   KUpHQ38Y8QQX5OUfqeAddU4CczRJd+6UNKUnpdWvded16mZnD5IWQYU3c
   Jp3fWKFUu6Ks+bXsAJXT7UqTF85DXqAiNZiROX6VTgIQwDfjIA0cdM3U6
   fEtLkR9CQA5+2xepjEpYoAr8NCHEdCBA1imHaeQEeU/05JhBDAzRMmMUo
   Ph4RlUUh2AO/pPFT0s+tp04n2ZfcgKoF5HVI6uP2EtqCWZEWS7rOCGFkg
   2YN3vu2bBPYLQZAC06BRVh1W+2bybzJwc/Wi4oogpLGUVjkEX5jRiL0YR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314410510"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="314410510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 07:30:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675474654"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="675474654"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 07:30:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 07:30:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 07:30:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 07:30:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI5Tgh7BLb8KjdDyXqqwISopev8zl/92LsSUfJvNwbl0URjSywa3wL3St+O8JEhiOhX4T6OeN7+P/lSjX3l0wHvjOhViYh/ZrvQJdCCmTNv36E1RcnK7UnfuGgHjmb5h3ONCufKbc4mVVENJJPAgPWzMfqlPlBE57ozhczwDQVDlWePVP9y3KbnbvJ0uhbfYs62aMICzuQwvB778lo8b+RjVlx2yYfcvVXV4fUq8l0EiXUriiZk9wUDcT/POBG3dVejnzNjO8oCTbrwT93ksOXrM6Am6SbQwQXzwsdjLTTkTJaahS4Fb0GrcB7E0hKrRbKNCBeRdTA0YZC8wTiqjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpaWI2374TTxuTt3oqYpmjJ9AX4fGc/zzdd9+rYSmJ4=;
 b=j9pwj9EXTb7Jq5XATcfopcgiS4E6uN/GwsDAIh6Di0d4Izawr5afhSvghWuaHLEDAapOJQt9Dy6Svk+clBSFKB1cOwyQ/+Z2LqUG1dQCQ312Epqyt/ktrsgT6SF3rzZuOmSbiRYcWP0ngzz/ynpgIc1H9Q0cuTv9lWW3u5puPcafPqpw2Rp0YiKBL5yN83ZsKB7h4Bk0KAMO+kFBJAp1HFL0wBJ2i4PvjRwa8ShV8Sap7st07emttoZxn6fMLYJtVlWFB5FYh3/KPCMGX3bEo3QG3B5qc+zXgxlYtdKUB9cmJO87lcVp0I8zZutayhrF83tOuTSqGprUWAylRLZAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:30:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 15:30:35 +0000
Date:   Thu, 1 Dec 2022 07:30:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y4jIlte0qPbCJNFE@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <20221201132618.00006602@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201132618.00006602@Huawei.com>
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: c24fc237-0f2f-4707-469d-08dad3b0fdf2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahMbZCZO7n2zMT/q5SfmYy4KglZD6Ix6wRL59RBDEISyg2c49swJv85WQEthVxKd03ljRPGqTVQEWEXpfvpJXdMSAyr7jFqtXOen0wB2GN+FfGZA9kSr+724BDdA44r3zBvVakVWFspP65CIg9bKDWKKf8q86li1ZLM4gOE7tmjJbBs74MmhGgPVEh2Nf1QwYYcG9piE2hofw6Ff9CeGiFzRGrc5GVcAPHEGczPgMh90pLw0haqeGXnQDQNnxIZS/GcvNnOTNA7XocwogCnIWXoDPDWk7Dn0gvc0UNPz9oGD6lcRp5LgJ385ktCv1un7VFhRJT0tr3B7OxbuTaTMvpzTxCs+RxTybF/6tRDwT0yX16KXw6hNTuuix1J4jnHWGXXvgpOArxuYUY/6lQLFuxEJdhG8Qo6jn0c/z7xgXeVMdragCHUlxPvogb2gv+e1JvHYgidGdRYdwBjxC09NeJzpTLIcHQiFGbvC4FjfL96drGMRMezUFdTFLJeZy34HGcWcAb6OcxVbaGYZMTedVwJq9P/P2XE/HI2MoxMF9KD/ARqHvv8MIFniemW/HSAaMNhJOSpu3ocOEoyCbqLpLIiskoaQWpz2zEdZSbewIDRYEswadB9VAhviIb1ka33+E70FiS5ZNtcbp1Tl9Eac4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(44832011)(66556008)(8936002)(41300700001)(66476007)(4326008)(66946007)(6506007)(478600001)(6512007)(8676002)(6666004)(186003)(9686003)(86362001)(26005)(5660300002)(33716001)(6916009)(316002)(83380400001)(54906003)(38100700002)(6486002)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jbavGrIkhqWwYXLdAKIHqSXROXN5NgfhjjMYwKH9nHRbfIJY+GspyDDD22y?=
 =?us-ascii?Q?0W5joxSn1bBhxVOxGOGl9Mvt4Bvxbq0hi5QhYc5S+u17ENvzEI3ikbfrwQ8e?=
 =?us-ascii?Q?X63yiahJ1j2iptTbsufweScqHtWISWqC9RzdsxC2ztRyZd4BSMdQRXj7GTQg?=
 =?us-ascii?Q?Z3kaI7RSC/rexYeD5NLYU3g5vGpGZEorsWZJvd3EHyq6cZPV9aJlnZkbVPee?=
 =?us-ascii?Q?KthLu1mwmybx7fsmKf/jQE6G/KP0GHsV0nPuI+NzfjlOzE91DDzCd3OVH+Wy?=
 =?us-ascii?Q?wJ6XU/dzrB8q15aMPTfLP9Z2C3chgmzzIfGf4HHL9krANlAeEuvSi6WYPo7v?=
 =?us-ascii?Q?ubkzcgSw7h8XCx9TR5w9SfediQ8A7LEb7yxnjEuFnPxLK/GXThWEPxuRJ7kU?=
 =?us-ascii?Q?A71lyZYExCgh5etN5/AW9jlxn0IwsgIA6PfgWBFcd7tv/P7EglE4l7wD1nwW?=
 =?us-ascii?Q?NQ6AzXNeQGAzU/Ywy61RFBFZuSrfMemJc3RzfmNdR8UOCqOqMdixCzGQdLUO?=
 =?us-ascii?Q?gyJKqsd20XVJWICSg0crmPXNhyhSnYjvOCkUlmhtMpWkBg6awABeT6ZvVyuT?=
 =?us-ascii?Q?nGEG1Rl3sggR1/E2tdpIkE3nY8eotFx3swlMA9z9ricwFYKt0z2e8SjMYkWT?=
 =?us-ascii?Q?6hT7YG2Pl6wUc/7CT0c+qILJww+JX3Ae+ioStz47qudttStpDJ+ewTAY+3oW?=
 =?us-ascii?Q?PAv++A7nn/sCUN4wK3bCvZBMGzRGsw2KXYmqGnctr+rhHauldDfOQFWppMzd?=
 =?us-ascii?Q?hwiPdhMM7xWj/cBZF3DOtAS1bqMTqQbHKwz4wh5Rg7VOrzSyWhVsWWLHgS9Y?=
 =?us-ascii?Q?iSTtrpHMO57jIXtetL98jOr78aMlPIEXXCsJvjN0yYhvl3JdI0ae5ATlrPHU?=
 =?us-ascii?Q?rFwAMVgMM9+5PeCB4VVTg/s8/uNRV9RePVQqdTNb5T9CX/QfBqf/2ZQt6ok2?=
 =?us-ascii?Q?oR0sdLbHc81EA55OMXNa9dPdBRJParmI+iAP+r3gzM0i38i6RETx22KUZyGq?=
 =?us-ascii?Q?QAjfuvvn2HCYXCXEQ4VX8Z/mEBdF717YmvXWKC9uq0WOOgldxOBYnz6H7O5M?=
 =?us-ascii?Q?6rNMpioPSOct2YIBnVe+GYvtszTyb9bEVksn+GRoASlZEy6IsltlG0Fh3xTE?=
 =?us-ascii?Q?2blgB8wJSCio+Uijs9+stllj4UTjbGk/HyJKnIYfdqzqjzIi8a1IG6UHirAS?=
 =?us-ascii?Q?HbzGatUZj2yPkjfQXnqax6223UiyX+MmJ6MA2Xl3AGG+bRpUU0bQ/wDxM0x0?=
 =?us-ascii?Q?CCDtcSRy4PBVt+tcOrOP6Uzhs531SCnhx0Wb1QLZLMNK3ImyoBJ0POJOaqlp?=
 =?us-ascii?Q?GHf7Ek+V+iD5KtmVBXObn9qaOz+y6O+h4pw+NXA+Ki3NzxWCG1r3X+2DF+1f?=
 =?us-ascii?Q?uVmQN+tTNfeuFqQVv1jNNAqdGYaZSWzxNBGk8xiCET47+Oo1quZC5443zLY4?=
 =?us-ascii?Q?ygmUp/6pkljS3/mMxZPsWB5PWr9gFc8jk9xG9fXZhKT8jvN8guQepu3wNR7X?=
 =?us-ascii?Q?r+h5aLEfTzm/QfJqCFWPTna79Ys5uqm9X0WqO+4mLWxLRFZcyXHpkvKyUvYO?=
 =?us-ascii?Q?lk5RH3lZ4uRlKfDgrlMiZ2SOpWtyvfyDWzaC38pA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c24fc237-0f2f-4707-469d-08dad3b0fdf2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:30:35.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6kCE3rPO+8YE9L2p5o2nz6eQwoypMBwBfPEuVd1U3q5KTzzlA2ZdTVAdpl6NKpMdMfagVHMMyHzM70GIALlwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:26:18PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 16:27:11 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> > command.  After an event record is read it needs to be cleared from the
> > event log.
> > 
> > Implement cxl_clear_event_record() to clear all record retrieved from
> > the device.
> > 
> > Each record is cleared explicitly.  A clear all bit is specified but
> > events could arrive between a get and any final clear all operation.
> > This means events would be missed.
> > Therefore each event is cleared specifically.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> I think there is a type issue on the min_t() calculation with that addressed
> this looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > ---
> > Changes from V1:
> > 	Clear Event Record allows for u8 handles while Get Event Record
> > 	allows for u16 records to be returned.  Based on Jonathan's
> > 	feedback; allow for all event records to be handled in this
> > 	clear.  Which means a double loop with potentially multiple
> > 	Clear Event payloads being sent to clear all events sent.
> > 
> > Changes from RFC:
> > 	Jonathan
> > 		Clean up init of payload and use return code.
> > 		Also report any error to clear the event.
> > 		s/v3.0/rev 3.0
> > ---
> >  drivers/cxl/core/mbox.c      | 61 +++++++++++++++++++++++++++++++-----
> >  drivers/cxl/cxlmem.h         | 14 +++++++++
> >  include/uapi/linux/cxl_mem.h |  1 +
> >  3 files changed, 69 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 70b681027a3d..076a3df0ba38 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  #endif
> >  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> >  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
> >  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> >  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> >  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > @@ -708,6 +709,42 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > +				  enum cxl_event_log_type log,
> > +				  struct cxl_get_event_payload *get_pl,
> > +				  u16 total)
> > +{
> > +	struct cxl_mbox_clear_event_payload payload = {
> > +		.event_log = log,
> > +	};
> > +	int cnt;
> > +
> > +	/*
> > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > +	 * Record can return up to 0xffff records.
> > +	 */
> > +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> > +		u8 nr_recs = min_t(u8, (total - cnt),
> > +				   CXL_CLEAR_EVENT_MAX_HANDLES);
> 
> I might be half asleep but isn't this assuming that (total - cnt)
> fits in an u8?  Shouldn't this be min_t(u16, ..) 

This cast will ensure the value is never out of range for nr_recs which needs
to be u8 and (total - cnt) will never be negative.

But now you have me double thinking myself.

> Also, maybe u16 cnt would be simpler.
> 
> Hmm.  This is safe but only because of how you call it alongside
> handling of a particular Get event records response (which must
> have fitted in the mailbox and has a longer header).
> 
> Looking at this function in isolation, I think the mailbox could be
> small enough that we might not fit 255 records + the header.
> Perhaps we need a comment to say that, or at minimum a check and error
> return if it won't fit?

I did not realize that Payload Size applied to input payloads as well.  :-/
There is no check in the send command for that ATM.  Looking at the spec I
think you are right.

I'll further limit the payload size here too.

And with this I might get rid of the min_t() and just cap based on that value.

> 
> > +		int i, rc;
> > +
> > +		for (i = 0; i < nr_recs; i++, cnt++) {
> > +			payload.handle[i] = get_pl->records[cnt].hdr.handle;
> > +			dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",
> > +				cxl_event_log_type_str(log),
> > +				le16_to_cpu(payload.handle[i]));
> > +		}
> > +		payload.nr_recs = nr_recs;
> > +
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > +				       &payload, sizeof(payload), NULL, 0);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> This feels miss named now but I can't immediately think of better naming so on that
> basis fine to leave it as is if you don't have a better idea!.

So we leave it.  Naming is hard!  :-D

Thanks for the quick review, V3 coming ASAP.
Ira
