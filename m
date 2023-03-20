Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549516C2369
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCTVKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCTVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:10:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D672472D;
        Mon, 20 Mar 2023 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679346649; x=1710882649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AuyMGEn/LKntExlz0/427+egqC/JX2IpiKTx9tqg5+A=;
  b=HloptGlxhXQD3GEQpbJb6wTPDQJupXjwdx3YCybCA3oRAPJKOu8fhChn
   LgK5EkqiJZDyqVro/6h90+O7gqhgFbD82f4EjH1asJhhCvY3KLK6mlPy7
   04ZGBFTUNFn1gofy+ciCNuDgMTeaydpOeg8E6mYhff8lNMNpFN96srXmB
   IVQ6KJ5YI9K0Uo02fCKlfgHRWnBPsk/53fSSsBt7u1wC5nyDIxWKMmIi6
   W2gvO7SD76KBGaH/c7oatO5YWUUIMmjzkRNIuf/QQHzrB+CK/phTvz0SD
   zMLKwZEAAgCOthRddmburfiRkvoxshkfT9IacPNMWjHcoBPt2CRgne9ZK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322622737"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="322622737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 14:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713700539"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="713700539"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 14:10:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 14:10:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 14:10:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 14:10:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG3DD7kOYlV33ZHMNrX2zI/jiDv8tPSoswpmZm/Q1E7a19J47mlo88Shz0bkjPY77wpGajZJuHy9NsaQZl+kGiQ0NgFLrrv1aaQyMUHDk2arE0AS9wSSAaD5FJfDoe+KGCh8IE2Esg+hK0Ruou3BfZ87x/MnHDkahrJrfCCWZLGnGwEBuhK7FEvGPXDB/+vLfDkFsQLF+Ejn3SIxKnIMLgv0KRe83SKIALCf9cP/wdbIG/Yat8kg+6th87/mv8h/eaGFqmI/G7CphPcP4dKXXkkM0IvqUgVH14Q0E87+BACJmtci/Psmki0576yFtNrzqn9Gw7nsjBDl7K6PfMiI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Gx2OtRiBM6yV0RuQx6owqSVBgTO+e32MPWCK/Qo1H4=;
 b=GiOhAKoeOWLbQ7i6yrGKYVAE2eIXBNb+AWzzXMIt/7moEiIG4Oh/27g6k0yuZhsQlXF0b6HfmSUE/TFJQTzrfhk/QzwruhnVbkWCJcPoW8v1BUWmHZmzsBx3r78ma9uj6qbVI+zlz2Pxv+c9x+fSDBdLG6cghtQi/vP9by+WnE94I38SQr2OqYAp1S5qpgjTJXcTiXyB8X9AQM1DDmKQW1mPMlMj7deYwt7T455C0okrhQ6pWyilEoVbzVAlLEktJuvFTFqzs+0k2byQkII+gQeDd42VamGcau1iOiy4tEbe2UmtqBgs48mYQDXOunh2tjzVbkwvbK8GN3QsYZ6N2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 21:10:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 21:10:36 +0000
Date:   Mon, 20 Mar 2023 14:10:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
CC:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <ac100@lists.launchpad.net>, <linux-tegra@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <outreachy@lists.linux.dev>
Subject: Re: [PATCH] Staging: nvec: Change container_of macro to an inline
 function.
Message-ID: <6418cbc98b225_2c274e29437@iweiny-mobl.notmuch>
References: <20230318170514.GA49181@sumitra.com>
 <alpine.DEB.2.22.394.2303181811260.2914@hadrien>
 <20230318175532.GA49651@sumitra.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230318175532.GA49651@sumitra.com>
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 922ee535-0183-4c33-8ecc-08db29878cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vg3/PvN0pqqNhrGNWExwiFjcv9rRV0n3lD51lq/X0/i8vnTRP4nwqWb81n1a7QAy9xFuIIvnFzBK0PEFBWtlibQxUYw1N3oyRV9dCHwnNdGSN5BseX3CXkcmbvgz0sHBwnTpD5kkRNHR4kLannJxyKOcCdKgqF5bN1x3m428s+bEZz+0Z7LIx8Xkoq35fg7RnPTjdWvkCvqoy+DcbeaRu1z7djgkNre7BnEJaR/4r1SdkYYmrGBoW/f4zB2PkVAhxuE4hCScYEaZYGjaZgvTKmMlABlyhqp88fCIyq/JNKfFe53iA295jdLDkXaZom0FjfKiRi6zuI/75pdyFQtm+G1DVeG135QN4SyfsS2+AGx0/A+qGSAcb9/3ajpo7gfw4LoGzCUsR2VBDREA0EoxGUQ8oLR6bnYKdM0ExxRdcQezGE8LqG+ARBsA17WfBvHhR8PPdyNsFE31TngscyPEQCFH1su5IeT6+AsgKuZsdtsZRJMlsQaYxvoQPZYRMSl9gMndeDmLqnGB4+QwVjPbypYvhI9DN1uBXFqKBUDDSJd6IKTr5KCGTlcM2moytKI80EKn2mPNYoSEjBiF/yruDhAsYv3tdLpwWYgVXT6t8U7cU3ZOsgFXicjMSpab/BTqyVp1lYTUxhudq8kbT8ZEZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199018)(41300700001)(186003)(6486002)(4326008)(6666004)(478600001)(83380400001)(8676002)(316002)(110136005)(66476007)(66556008)(66946007)(6506007)(26005)(6512007)(9686003)(54906003)(44832011)(8936002)(5660300002)(38100700002)(82960400001)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ck2RHVD/PgyBcaJOw9tnWUCJk7LHLFP1E0kAzgeNeWYk16CeIgiyi+JxhlC?=
 =?us-ascii?Q?4CFkWlNZbbHFw+ccdBkMkWRDsVSVjW7B2mWIaXw7KyvFr0T5T22kpVJ+6ucz?=
 =?us-ascii?Q?ZFw82oIOfyg8NxDZoZCj55YEkQU7tl+vRrWr5dsGF2rK1xfprhRSjDcF9Z+M?=
 =?us-ascii?Q?s0sp/Kj/1aIfDfBIum+21FIFRLN+ENCTEFs/JXvGqpz9VWk+V788TussrXm9?=
 =?us-ascii?Q?K73QDNYlOw745qiupny6ukyOK/rN2yzyNeP4jZv48UFIZuYKL3sxnn1RnOy+?=
 =?us-ascii?Q?194/y4sTOZBeQX51WvYsBimgqy5wORq1i2n1tqozSckOXVexVmBRqf21msQj?=
 =?us-ascii?Q?We1OGq076Lp1IlDYlYZXvr9t13Kr1/1zDlXOaY/aWb5jgjxqyIDB2mx8C1Oe?=
 =?us-ascii?Q?7dj2GKyAGyrshXP99qrAsILwLA1Qkx9r13j0jtD6+uQXzCtZBdYcRWVVonYV?=
 =?us-ascii?Q?xu0w9HmLHlS0d2Y9i5zAMoTctAA+fAPPvSV5PpSOj8ZMId/ON+QKxLSkTIxF?=
 =?us-ascii?Q?Ke+TLoxWDmyeUZIRqDi7VyjW6RwwjnTrRsNTvoJoHSghF+e/l1qsPMSuowvo?=
 =?us-ascii?Q?DhBl6hW1J22bRIUXuPExsmNwfNejX06c6h5UcAqTmOyuY2+TLBmnEJZEJu/Y?=
 =?us-ascii?Q?yJ6L2u5ll/bqMTqsB+ZT8JTx0lrTyiiPcxl8Z3jvG+5kgKyplt+NmO8vpFMa?=
 =?us-ascii?Q?pQ9OjAGivPNF7LYAIfM53H++ZMXscpFn4N7X06LUqwpiFgfcaX33GnNlAqRO?=
 =?us-ascii?Q?+MsBnEOIj1VD9D2j8UKW2HijEw4XPQvIS8jSzVU3qjxVCjMMQ8gbfEMtvi5r?=
 =?us-ascii?Q?Hncixlczr0KOlxDiS9poA3sIBVMrZlZGrpQoYiwpVQiFSTMqABxSG5EtCToF?=
 =?us-ascii?Q?D1GUIxru8zbawxEeYobjGzMFBrTxmheTor4l39gXV/mc9YqPz7bcASp6nNaT?=
 =?us-ascii?Q?DtTisiMQwNVB1BaXpC6ZVSlbq+8teekxp4hZNwdtyWUXOUMwP/CDBqjMRvxS?=
 =?us-ascii?Q?49Iy11r7VUNi5XnMLi42l0C1drY8xzvpcm7HP1ByX6n+XsfGIGlKgw0ug/od?=
 =?us-ascii?Q?/jlG6/bEOEpPrxBwn+QG0gm7tYT1hsM5HHjWR5B0xkMUix7vMhAg8wHYLu98?=
 =?us-ascii?Q?a3CtYErRtEDdDCVPQfwqBn58lkdSG0IRzAsl8xQ7kiXhd2UxqdEt6axBg8ES?=
 =?us-ascii?Q?0V5Es61144KorwIZECUuW5ubF00frkjgFQNO9c4NKUg2lu4m6/IwThQcjlaK?=
 =?us-ascii?Q?bppCvMP0m3jDXppOYQjJkdUVIW/LjcfKPdv/JP2jp9r3lUVC5sfDv9JSlqXP?=
 =?us-ascii?Q?AyujL75XhtL1rZC/lX1U/HSjXE1PYcW4gpp2mYzCnNqHlWkmAkTp467dqBaf?=
 =?us-ascii?Q?hUlyxn9DxjQQleXLZVN/KtkveKvFuG3rCNUDFko+Ye78Aerf/nm1Reuzffb2?=
 =?us-ascii?Q?FYBtgu6x/zJeIAv/vL2w385XT8NkeK3jcCIXl3hK0+03Ny0RCKmhtp1Pg5ra?=
 =?us-ascii?Q?Ii0iiUGefQn/0shC9qWPSO4hW4U62Z9yB3kXbsXyLfM+tM1hy7DUsY5b0ShR?=
 =?us-ascii?Q?I8x4XrfsOOha9vNxlArQFrgrjEDf88kq0SzX7iI8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 922ee535-0183-4c33-8ecc-08db29878cf4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 21:10:36.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dheW8l1OKb4EiKuIQ7GM+BQFBsk2MDqIpCECqijLc0wYim1jiXsM6HWMXvkUjG1tbQePzyKefevhJbuIUq8eWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumitra Sharma wrote:
> On Sat, Mar 18, 2023 at 06:14:50PM +0100, Julia Lawall wrote:
> > 
> > 
> > On Sat, 18 Mar 2023, Sumitra Sharma wrote:
> > 
> > > The macro has the drawback that one cannot determine
> > > what type it applies to by looking at the definition.
> > > Hence this macro definition is not type-safe.
> > >
> > > The inline function gives the same benefits as the
> > > macro and only accepts the specific type of arguments.
> > > Use static because the definition only requires it to be
> > > visible in the current file.
> > 
> > Sumitra,
> > 
> > The subject line and log message could be a little less generic.  For the
> > subject line, one has the impression that you are changing the definition
> > of container_of itself.
> > 
> > The log message is also a bit wordy.  Something like the following would
> > be more concise and still present the issue:
> >
> 
> Okay. I will focus more on writing better patch subject and description.

Sumitra,

I can't tell for sure via email if you are getting discouraged.  But if you are
don't feel bad.  Writing good commit messages is hard.

That said, I see a couple of build errors from 0day on this patch.  Do use the
tools to correct things like that before submitting.

Ira
