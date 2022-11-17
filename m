Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAE62D041
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiKQAym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiKQAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:54:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D38117D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668646479; x=1700182479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=riNOgWwi0YVZDaMR9EFjL4NPXxuqJupruAdY48xkNII=;
  b=YtNx2mZCbUV2ZWr8LWHycKATdUD1w2rz2AGyVN6peQ7lwPNU4lUV0Tda
   nD0Z2RIvE+OEwrUcPYC+DUeBIbFeiRnrdNeJU5akGFKt11zR8HaBLlZu9
   JD7DeH79YVMqQJVpiW31MCihZ3qBIMU/Zvzc3HIYgridLWMsK+3y6aPBg
   1iE5FV6rvCu/rbb84mQ9Rt7Dw6qTo6eDkkEk+ax2SAcfadMj5koQcj7mp
   pe6Smw4ITPV7AjHLd+FSCpVDimj4CnpiXHFftxry74Q+OuBiQEtK7/V0P
   9zASbmc05/WGjFbhWoJMZR0AKY7Sae+dV99Gge780XEVytOJs6mF4fjmu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314528965"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="314528965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728602343"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="728602343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 16:54:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:54:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 16:54:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 16:54:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh5vmnJIqi1o+f4N0atx61kITuNBDz4qMSBTa+KG83URZbeQBQBClrsXe763LXY1twshRK8t2WH2+MFKgR7rYD/xzMmLVkxIvFd34/xkRzRCPZFFNKXX4K4MLFAlwprzCydleJ4jx7ifxn3sCgIBrZ2t2FCrszlhmzs0ySZZShXT55McQLhxPYTVbhdqzgD0KFnQDAGkam0wgQfqfucSe2DZnhWhqEjEVn90FQhfnoLbt08xKtkaJ2WCvKauhsHco8kL5jFW+GFPsIzNH4yvDYjt+a2cdkxVVkHermoKWreYjHfHj/HIKwPsyOZtMK4PsAEHRzIXU4CLiDXmg3qSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLhSs+Qf3Cutbzbosr87z04qzhEQxRDwUjV2CAU7OTc=;
 b=HFCh/UHmIGhmMumDhWtKA9t8N6Xa6jWLnUyZB4rvdRzNlsnYotN991cVedaN1eP7b9lUArEZx7otBSHYOiinndtytLTMUb/bdPKRjBXuRRUBf75drfJ/Qv6fMJGtoChBKOPEgU7JWJeCx1zIhkYia83ztgCibmOqLemBoYt7BfM4rQaNfRv65VXSPmYhXADmwLXBLhJG6yI+yzcNzWOlSpL1ovNQY/G3vZyGW9UfCL3X6mjQnoOF9qkvycSMqhngAlVhR80ISkAW1JKHBPlmm2+c1owYpQt1F8yJF/mrvWByIU2+HvPnDtVKdvNyXt1JB91QcL7+ZbBnec3sqqWEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 00:54:36 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::296e:d1c9:648b:2aa9%2]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 00:54:36 +0000
Date:   Thu, 17 Nov 2022 09:03:48 +0800
From:   Fei Li <fei1.li@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] virt: acrn: Mark the uuid field as unused
Message-ID: <Y3WIdBYYoQQ0Ifqk@louislifei-OptiPlex-7090>
References: <20221116092254.66234-1-andriy.shevchenko@linux.intel.com>
 <Y3TMmDXEbGyDQrLF@kroah.com>
 <Y3Tlu0BjgMk3xNDQ@smile.fi.intel.com>
 <Y3T/qJalJ9H224Mu@kroah.com>
 <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3UKFQJJI/02QDWU@smile.fi.intel.com>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To SJ1PR11MB6153.namprd11.prod.outlook.com
 (2603:10b6:a03:488::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6153:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d09467-732e-4725-06b7-08dac8364c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvXadABRst59OoUAbh5YskXa7tJKQzcJ8NwGyrsbivRZeT03FWC1xiG6P+4D6Phok3XRbMwboAYFwmI6rt7WE8GW+FBKzLkhzWebZlfIYJvFsJf0qZiqev0JQ+ol/uxiFH/oOSjUr+e2JkXed2Jn811UeYUBSEw+vnhVR6+CSkD5Gb5uSPiSeafIMWUtA9n3prKhFmdhnDSx1Lcxv/l1IAWIC79ypYFIbCv2/9/Nh1hpov0jUPOi6e0p3/hlutU9mMQ1QBhuKJgcA8D4FCSEqV7Bg7WJNazyThMXwqCzhP7m+2/SsBHfQiqhUESqxQ3zfHk8SFJ31GB/iENQoyWoCwgoyH43smAU1Txt3z6coXZ50elN6DK60Vy7Ya1mDJ1yqLtFPhfqa5Y/xuRKDFMZ5s6GokMDX78sjeW6jCuyuOHjrFxMz5Jdt5QasjLoes9O3mnk3RHDcL+N74cxwH8wgmh8DoU8hrOsB9om4r4rCbZL2P1LL4aTVBjvWDguH7/F+1L4S/wGX+N+f9hiTTSlFJPsDXQsMJHgU4mpn0n4CSA2/m427gSHL9bDn0YVDH4ZHequSnJBZJDkkgXqEATmBF1JQ+6qVsztjvjtoX2IQIMtV8S6lSN4NKt8ZAcw/uQv8DsDWA5ry49BRHG4OtjRRE2IXvbhvxDVipYOMvx7KLQFvGunsyUh/v7lNRbnmRBHQ6VeY+YdRpOyt5G6nt+tHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(316002)(6512007)(66476007)(66946007)(8676002)(8936002)(66556008)(9686003)(5660300002)(41300700001)(186003)(4326008)(26005)(38100700002)(82960400001)(86362001)(53546011)(83380400001)(4001150100001)(2906002)(33716001)(6486002)(6666004)(478600001)(6506007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dq8ljPPWjNEfy379nFBv7/JALZr8wh70UKdekbjdMT+h5yh+DIya6V6siaGL?=
 =?us-ascii?Q?7e8JC9R9enWnBy+ha3TutM6nxI29ELBdHsY5Gb3c+EPaMjKIR3thqDH7IS3k?=
 =?us-ascii?Q?/ibhD7d3jOfd/f+sDHPgKjxL0/Z/JpeeGNRnylgii673oF5Nrhnljqi3ZZ8b?=
 =?us-ascii?Q?FxwbbGxne3Liie2EwYpBDzmwdyYMK1u+wqb1bEk07H0E7Xq8YenzoTMnv5vZ?=
 =?us-ascii?Q?qFlYdZRV+rpoiVEn1/2H1z6itCmXjqXLcty8kVUvv9K7OCWDQIR4JiNcr/Ua?=
 =?us-ascii?Q?sgRXbpqAg5HVkYcVXwgUN4dOsQgUClUY3NBTnCdsWQgk5k19IS3q+ipOz4V8?=
 =?us-ascii?Q?XZYiwTPKuiky6Zc0mUQF0IFirnygC6Qsca7OSHe6Ld6c4hBZmwAxwxXD+d4h?=
 =?us-ascii?Q?Mn0R/tdEcPqra8v70CIo9GitqdrMiBQX4LAiQttCGNo7UzIW9m3QYQeICXHO?=
 =?us-ascii?Q?uP0PlpBqoo3KexsBPuiaX5vLnM+LTtbD53fABwlYKbyxS3fwu8XSWqJbfkhh?=
 =?us-ascii?Q?i5BPtSKdQ1ylV6Yt9FmlS3lokcGoSrJGk5jfS07cdMrFNFpaVUZA3k32nMvh?=
 =?us-ascii?Q?fVN7nAxZQBcJincjKri7/nc/Mjj4ZQbXRsaM14/LETzD1djBwemECS+iC4d3?=
 =?us-ascii?Q?KNxs5MvKyTJQU6IdW7foIrAUzay4UH743g74ds881+htW/1CUIH9p0tqfh/S?=
 =?us-ascii?Q?4B0H3hDNfbcyFZAcke5I+tl0PWu18dg9tbuUcDYydn0YWC58/mkR6V3epVtX?=
 =?us-ascii?Q?8ZIVp0XBypx/O0Tpc6s3s8xJjaiIQgJvCAbsOGTqThlBwVLDUf5xyZYlX8Vo?=
 =?us-ascii?Q?Cg/38WRu+6lqeE4QPV1ts1vpK8rDoeU34mgFdea58pUVsn8tNmF8NgqtMgLb?=
 =?us-ascii?Q?7iyo5MWNrjcIYOS8kC6dK2kELRGWw4/kuAr8/hIfbHnIdj4FklEt/Dj4k2ZT?=
 =?us-ascii?Q?6PQDpgJqNuAnVuxHBS14IeXrRZGA3vkHxkGt1XtRX7/1QPeaeSmap9559k1g?=
 =?us-ascii?Q?kxwYdd6HSUJVktBIJlb8+RpoRiDA6jNurHogoftmUkfFhObV9QIecUBb2WZV?=
 =?us-ascii?Q?W/3EgTbxjl8ot7SouIFSfnXPgaWtgRdV2mUN48jessERiURSSza7zwa5dqh1?=
 =?us-ascii?Q?4jL5rGiVXNpROzMNZ7SU4vYIwv6yvBON841vZI16IOTf+hTdOO7FYXrjKMmm?=
 =?us-ascii?Q?olp0XPLapb+peU7fUHFsvTxEiYa19XZ9K8jbXpjPqQKduZWJQRpqkKnLp085?=
 =?us-ascii?Q?WNafHf6V1biPWfqwipcoj3K5D8m+Q/OhJ3wGFNYP9uMkdZbP/2Ep82nghVTZ?=
 =?us-ascii?Q?GXbGnADYqFcNLO0uEXJQXgbkDGwKno66CapAef/QXGaWm46u0XLDtA2ueyuJ?=
 =?us-ascii?Q?pXPVTTzuQfBcp1pz5yAxNIG079CGoVhn+0+XPI7jiLV9Y71+U/2zvA1DHlL0?=
 =?us-ascii?Q?wV+jUtvw/Rs3ggtoEyCayYJ8hX2t/fU11OimRHKStCejUhwgvdxSayZTGbQg?=
 =?us-ascii?Q?EPI/LKhw2qt50v/Ca0JN/5pOUMSxge2jyPIS/0Bgwwt8L7/pZ7khaNBsgctQ?=
 =?us-ascii?Q?OubNBwgEbGBx6zbx703p3m9l1hWfD+vjSzI0M5yN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d09467-732e-4725-06b7-08dac8364c1c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 00:54:36.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pROLwCe+Rf7IuLrlwvPAzBiYtB6LuHyEMGSDya+2pH4sSTqAsETiY2ofiXeqssTdW5YoEK9jWidG/J0sCzAHWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-16 at 18:04:37 +0200, Andy Shevchenko wrote:
> On Wed, Nov 16, 2022 at 04:20:08PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 16, 2022 at 03:29:31PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 16, 2022 at 12:42:16PM +0100, Greg Kroah-Hartman wrote:
> > > > On Wed, Nov 16, 2022 at 11:22:54AM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > - * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > > + * @uuid:		Reserved (used to be UUID of the VM)
> > > > 
> > > > If it's reserved, then don't you need to check for 0?
> > > 
> > > Reserved in a way that it may content something we just don't care about.
> > 
> > "reserved" in the kernel ioctls mean "must be 0 and we will test for it,
> > otherwise this is an empty/useless field that can never be touched again
> > in the future.
> > 
> > Please spell it out in detail as to if you can ever use this later on,
> > and what the kernel will do (if anything) if it is set.
> > 
> > And if "the kernel ignores it" then that means these bytes are now
> > "empty space never to be used again", right?
> 
> Right, I will fix this in v5.
Hi Andy

ACRN does not use uuid recently. But before that, the old ACRN still uses it.
So could we just change the uuid data structure definition here ?

Thanks.
> 
> ...
> 
> > > > > +	__u8	uuid[16];
> > > > 
> > > > You just changed the type here, so what is that going to break in
> > > > userspace that depended on this being of a structure type and now it's
> > > > an array?
> > > 
> > > It's the same. The previous was hidden behind additional type level.
> > 
> > Same size, yes.  Same C structure definition, no.
> 
> It doesn't matter, see below.
> 
> > > > And no other kernel changes needed?  Shouldn't you warn if this field is
> > > > set?
> > > 
> > > No, as pointed out in the commit message kernel never ever used this.
> > 
> > That does not mean that userspace tools never did, right?  You are
> > changing the structure definition, what tool just broke?
> 
> The only tool has been amended like a year ago, so the answer is none.
> The commit message has links to the commits in question that made that
> amendment.
> 
> Maybe I should remove Fixes tags? In such case we will very much know
> that no old tools will be run on the new kernel.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
