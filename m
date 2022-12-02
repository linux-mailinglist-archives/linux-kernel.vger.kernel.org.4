Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24C6411A7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiLBXtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLBXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:49:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD9B90F9;
        Fri,  2 Dec 2022 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024970; x=1701560970;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b5EQzjGtWHcGdiPTiInG4c/aEhsp6p7A+m4XDiSFawA=;
  b=NA89pItjKu7KI2+q/T9b9VdMkjiH0vBFp2g37hTQ6Zaknlazh7rgfnLA
   Gb6J/pvpSKKp8HLlICTCkB4pKeIQa1bm1+QCC9krlHYE1Ad7AmDrFN4er
   1QLd5XJrSso2G1lY202gUToZCLSKi5WO4vghTq7b+FxGOn+VPxNhGsrig
   TRXOTIqjLtabfHjDtzxFSJ4joyq/MAMF0ZHiQK62fCdvwAELq5raUn9pw
   rtJRQzH9Q2HPBFvxoVqj62yy+62IxGNYtJ6x4PkOkBVfnxi+T4WrUFOWJ
   8LxQl38SlKL0AHxXCOKcv+uDjgHsvTt9V35QNue4ok3hikPc2OSGjqvzy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="343040482"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="343040482"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="890333243"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="890333243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 15:49:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 15:49:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 15:49:29 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 15:49:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIO5KfVq42PZQHCkfmOYeDQwvptdIUDOP8Pi01ICOiEe5prZr8E8oHPOcewsBIrufMCqflCBYTv9mCjD1lyvZEp8Knw/SIRmU0DygfLsaJgnfdDUrYT8Dxn3gwE8K0d9DEpw/JL2AVWCRPzQLHLI/TM7xJG8gKNsptVyKreUcMgky6GLpQck4IHSrdSysad0KGr5SyLMtTr6g0AUSCzi6+O4lkkuPA/yia7N4X3Kciw73FcdYos42JTw2IsOvlbLH4lKucr5PVVvizHxi2/c1vhtATYGvcp9IwbrKWgxPKNZX3Z2g7eFSkfqtsq4Mjnb0RkeVu2X1PlmkbVPgCD6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQX1okQ1HdNlB0iSDzSC6OVsNy4m2oaDpxvJ8rZIcZM=;
 b=GGwS+fkRiRwC3NJgfEr46qr3sBnTBR4oFOi60b1medBoD1cW+tEwpZsytKNrOWXh/+M3vEKkG3PmKw1//Z46TkjycINdUICbj9a5yG5vMgZou0bLDtAu+2xjBGaabvtR2aPH+/o1qy2MhhIWUf+PKhbawue1ihdn34eLRcP7U1Hu7MNBbtGiqu3RrcZavxIkw6NJkm9AVb0gVbX7h0iYdVv+uKrhICDK8jJODN5XsdExrg7NfB0O4ELMkP0SOk57c9w2wT4KPee6tDx1NIieLoSBQjZV6G6T+sdRCuS4M/sbJqsx4o9OyXMd41sVK4mXEthk+rsHCigUSlLhkTMLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 23:49:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 23:49:26 +0000
Date:   Fri, 2 Dec 2022 15:49:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <Y4qPAi/DZAyz/Djl@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
 <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 096e2254-a1e6-4895-be12-08dad4bfd8aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNrPMVQJxrecDre9uo3DilcyTxSdmO42+3X9Q1HiDaAqhpULAdIyPJdIIQslP1P753EGhusAwT0UVmQTRENfko7IIUwF225CRy/DY1XHk9nHFqBHuuajdusU8hAK1Arz/kKW7eDVxmy+x6TgmhcaNUDEXn0Onf0SAzCjV+mLIbwHSbtJ2U+fLCv1RJVoMa7s0ebUOu1T/47ywijQVCZeDqUk0d5VnD20SKj9sHFjq4xrH+JPkXyi67ziN/ivZCcn/Rswy1Pk4hWhOWI/9hrN+vsK+KUVpvmRMXpYxRe+yWhmI6bF+jeEaBYh61ahXiFNKLYN/rHIBJEpFrRoiM6c5anXJPtQXUKgsA4FcSgLPRzyEUTBZYqgurtDI0bqLdHm11bW4fL4LdWByBC0XrwavwKomfUhsu1oWP1ic3mvu2uKYs5CPtdtve+Db0ACXmVSzuuPKQ383dv1jOrN/5w3RCbOYRtDVjuJBanDlCSER+Imlna7AOLqXvDTbWXrm2a2fBDl8N0aBRKBCGay1mLHd3mBurBpyIfiQQSsMSkMfch3vO9r1XXv4vKk0LReL9MJbCNFrfBbII1DwwetUTvthiDuuYPdihxwn2qLtHPXIVJonAwA5NYSJz43PQGMjTJBJOeulDLWP/F3E8tocFpTGNQ+nwDFd986/IvhqWYKnWfjjp5kblTBDStZSOVLpv3F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(6486002)(6506007)(6666004)(478600001)(38100700002)(33716001)(66946007)(66476007)(26005)(6512007)(8676002)(66556008)(82960400001)(54906003)(8936002)(9686003)(316002)(6636002)(6862004)(4326008)(44832011)(86362001)(5660300002)(41300700001)(186003)(66899015)(2906002)(83380400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rF08/sgkwdYCYver/BL2d0nbhZemNorfDkKfK9O6ca93nB/IJyDT5zfGDkbK?=
 =?us-ascii?Q?3RLSfi/MVHCYDBaJ5gzL5Ni+EbXfLioXS1SikYAUNQ91GbtkPb5rXWWsFCCo?=
 =?us-ascii?Q?aYqZsZWQc4s1V1AkgQ1fRhu/5fcpmdQBOFUjgrvm6k3OJ8aESHRECQQNyTcD?=
 =?us-ascii?Q?Vn/KUjo3DerIWIV3+4+NqkaJAtoA3YrtLJEVrIZ8BCNpBc3rlesi4nSTQgzG?=
 =?us-ascii?Q?Uo0qQUZKoa3aZagZX/U1FUmHTFmGQilf/nR+zDv65XBcOAstZXUE9LDJncDN?=
 =?us-ascii?Q?URhUAFKXQZ3NnXtiA/hsI0fr2y7GppbZ7o8rmIPMDAqLgHTj92D+qfJBxG44?=
 =?us-ascii?Q?dAnTeOAFG62pWI4Qqvtbpn7ClK2Jo4lH1O4TYEx6xeOAlmH4sxkh3AMsPuXq?=
 =?us-ascii?Q?k9jQ8qPTF2ArG3GRkXBPB2fSD7NU4W0E5y4lbqP+BsLSB5rqUz6TMQs9DB6j?=
 =?us-ascii?Q?BanniI9UTIEU9hmmewwv0OOvCkjPKmgscIAtEujKxHcyhUwIgA1CiLO4xeOk?=
 =?us-ascii?Q?JHmSXyrsyat0LYglfKuFZ3yDpPfG1XIoefrYQHl4Hwv+3RhLTz/16CGKw5Vu?=
 =?us-ascii?Q?fEpAzDmKyynTPBmtxZDZKxLoq91O1FXv3oNoQ5bQ4UE1XqFXMgM1gtyQfabA?=
 =?us-ascii?Q?2wWQY24YrGuM39hNrbbk75eIQCOaPVFB7uuz9XJ+WkL3W/Aw0rwZ8t7oHSJu?=
 =?us-ascii?Q?Dm2DbSH3WV4RMwiCGwNC3r6yrsUwPComFiRP3U6wyboGrGIofvjKAf+OQAHq?=
 =?us-ascii?Q?LtstCHjTAWOIY58tk/H4MnwJWISpWaDa2CvBtYhWpKwoAx5JJSQ1MFA/V40H?=
 =?us-ascii?Q?knLmN+X+1IINaIQXRne9neJgyPcqAqWOZjSbJ4Np2+o/d9O5Ti+u/MAu3Ny1?=
 =?us-ascii?Q?BorLMoX2U6skPFm8zaAsY+0oUZfjPLag/zBo6vrtTKSici1nft1XWZPoG5ll?=
 =?us-ascii?Q?rfSPGjWx1N+wK7zCY2ArH8dPuHUbzmP5wtrRwVANyhKSZibGwaxlGhAf3rpR?=
 =?us-ascii?Q?4BwTCssv1gl2s97prUqUPjV0ZSFLXEW5moLjIzpwWYXA9v7VH9LDzLNjFvuS?=
 =?us-ascii?Q?dHwBIbbe/Nt2zMuiY5TZzvnKZGep4YKSsLICd7AYBHHrRZrp36NhB3TZ7T2v?=
 =?us-ascii?Q?CVXsTysSE6c34ffF+WBiqRAuUURgtPTpgW1e0S5A/qNu4IzHYVnNp9RfynwA?=
 =?us-ascii?Q?gDMkPZi0W5hhVzF4UFZxoY66tYtA+9o2cSrxnbBKbHO3Vx1x2EUbJu69dh86?=
 =?us-ascii?Q?B9pc6ATRTG4BWUiDxm9N9iCjmZkQiyI5ibK5Y2ij1kbEWpWVC0pNEUWZvSI4?=
 =?us-ascii?Q?s6UBae6Uf+ZT/q2KP5MzdTq4MiTZVIbMc/k5OaRCQfjV2oqcKHIQ8kRtfbdV?=
 =?us-ascii?Q?lDCg6AgGA5iw+UIQkhsmY53gAOlNjIZjur/jwW2F9NTUV+C1+EQRyRhNA4VG?=
 =?us-ascii?Q?QdtXG1X9lnMJlxSC5eC0mPyNuHkSES85PQp9TPIwxDMsU30yK6CEtcSlpGCu?=
 =?us-ascii?Q?UBajXvgZO5yVncnBySVIZnz3Ds4DN49XOxG8d2U2/lZtQJ/HLF/RJNEMIpiF?=
 =?us-ascii?Q?UWMN6LWE2P175R7LSXW9kR5/i3EzZnmAIwSXvQo9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 096e2254-a1e6-4895-be12-08dad4bfd8aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 23:49:26.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHUtgrL4IkyKRwfogRVcQsc6cUrSgzGWjyksisNy5f3Ik+qWA61/KxjSK8x2hfmP2CLf53+GuzSBX33I7b16WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
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

On Thu, Dec 01, 2022 at 06:29:20PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
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
> 
> Note that the spec has a better reason for why Clear All has limited
> usage:
> 
> "Clear All Events is only allowed when the Event Log has overflowed;
> otherwise, the device shall return Invalid Input."
> 
> Will need to wait and see if we need that to keep pace with a device
> with a high event frequency.

Perhaps.  But yea I would wait and see.

[snip]

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
> This seems overly complicated. @total is a duplicate of
> @get_pl->record_count, and the 2 loops feel like it could be cut
> down to one.

Sure, total is redundant to pass to the function.

However, 2 loops is IMO not at all overly complicated.  Note that the 2 loops
do not do the same thing.  The inner loop is filling in the payload for the
Clear command.  There is really no way around doing this.

Now that I've had time to think about it:

	Are you suggesting we issue a single mailbox command for every handle?

That would be a single loop.  But a lot more mailbox commands.

> 
> > +		int i, rc;
> > +
> > +		for (i = 0; i < nr_recs; i++, cnt++) {
> > +			payload.handle[i] = get_pl->records[cnt].hdr.handle;
> > +			dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",
> 
> While I do think this operation is a mix of clearing and cleaning event
> records, I don't think "Clearning" is a word.

LOL...  I'll fix it.  :-D

> 
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
> >  		}
> >  
> >  		nr_rec = le16_to_cpu(payload->record_count);
> > -		if (trace_cxl_generic_event_enabled()) {
> > +		if (nr_rec > 0) {
> >  			int i;
> >  
> > -			for (i = 0; i < nr_rec; i++)
> > -				trace_cxl_generic_event(dev_name(cxlds->dev),
> > -							type,
> > -							&payload->records[i]);
> > +			if (trace_cxl_generic_event_enabled()) {
> 
> Again, trace_cxl_generic_event_enabled() injects some awkward
> formatting here to micro-optimize looping. Any performance benefit this
> code might offer is likely offset by the extra human effort to read it.

Agreed.  Gone.

> 
> > +				for (i = 0; i < nr_rec; i++)
> > +					trace_cxl_generic_event(dev_name(cxlds->dev),
> > +								type,
> > +								&payload->records[i]);
> > +			}
> > +
> > +			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> > +			if (rc) {
> > +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> > +					cxl_event_log_type_str(type), rc);
> > +				return;
> > +			}
> >  		}
> >  
> >  		if (trace_cxl_overflow_enabled() &&
> > @@ -780,10 +826,11 @@ static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds
> >   * cxl_mem_get_event_records - Get Event Records from the device
> >   * @cxlds: The device data for the operation
> >   *
> > - * Retrieve all event records available on the device and report them as trace
> > - * events.
> > + * Retrieve all event records available on the device, report them as trace
> > + * events, and clear them.
> >   *
> >   * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> >   */
> >  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> >  {
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 55d57f5a64bc..1ae9962c5a06 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -261,6 +261,7 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -396,6 +397,19 @@ static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> >  	return "<unknown>";
> >  }
> >  
> > +/*
> > + * Clear Event Records input payload
> > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > + */
> > +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> > +struct cxl_mbox_clear_event_payload {
> > +	u8 event_log;		/* enum cxl_event_log_type */
> > +	u8 clear_flags;
> > +	u8 nr_recs;
> > +	u8 reserved[3];
> > +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> > +};
> > +
> >  struct cxl_mbox_get_partition_info {
> >  	__le64 active_volatile_cap;
> >  	__le64 active_persistent_cap;
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 70459be5bdd4..7c1ad8062792 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -25,6 +25,7 @@
> >  	___C(RAW, "Raw device command"),                                  \
> >  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> >  	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
> > +	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
> >  	___C(GET_FW_INFO, "Get FW Info"),                                 \
> >  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> >  	___C(GET_LSA, "Get Label Storage Area"),                          \
> 
> Same, "yikes" / "must be at the end of the enum" feedback.

Yep,
Ira
