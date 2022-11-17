Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D036362D096
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiKQBYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiKQBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:24:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C122C67B;
        Wed, 16 Nov 2022 17:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668648246; x=1700184246;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1hMb02cgakBIggATR85P41kGpOPNO4Mz1R699nIFac8=;
  b=OEy9noWicON3RcyZ+M3j2pOTg/orz/ZknBb3ML4uDSJ8EvQgJe2mqY1u
   KvH8bTyeyCk4+NETSaNRkLPYCwxVB0f2+PjGLFlyO0fWPZIL6fAzewaPI
   0DgoaCTnecxy57sqnx/4wGNMaWRi2RRnPFgTIj14udO15zVQgid0RZQ/V
   hp0YD97sbGoc+fsLASy48YmY3PlhR9WSK2n+IqMJ60a/UgBX1xVFeGaiv
   7zUosPmNvFCj5NQEvV6m3sj5iu+ACLUQEJ84Is/j4oV6IaYixwZ8+nC5k
   afazgrZmxr+XS2KNS4qfKkm5Z1hDTPrPgWTjPekAUwUvC/9TnETfVu0Ja
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314535067"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="314535067"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639587825"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="639587825"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 16 Nov 2022 17:24:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 17:24:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 17:24:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 17:24:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7YNg7BHaIjcGxjnHyh15f8wHkBj9YoIMziyk7TW0yvrOJbnmjijGZAS0bavcrwNyyn2i2PlXaBqEzJzDbLRDLLe4sPzK+Nf6PfAnP2bvdPAzaa4UOjVveJfQ4DIa9sdC7A7pTm6VrjSO4I1pxRGy/qSwL17JGW6AIA3KQsKTnmVUqru5IzEWcsNEEjqkoCxLCZan21fZwBbY8MRqWwf0imQZr3SzBEA0PPjPIROB9lyTmcvPu9OhbuZgA5fK5sRrfR4i38rhys2OSjstc1329ovNuBEerxwBPAyPTVzoV0wp1/JOnqw98uvytnlJbTLIehVhjpv3NNU5vcjm2qZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wZkKxmF77XdY+YSTj53+hqcWnO8ykq97sYnljW1cu4=;
 b=FCZ7CHsoXV0kOjJkiHfqoEFIVLvsKyxbXiBGfiCQRp8icRq0pb+QKtZH8fPn3UeIj3yWjoAb1+/3hSV3gz15cfUkArhZ2dGRWOnXAcrzAyw42n+N33UYdz179NDJk8zImaEw87fq3vIYD802/oCzAA4+nIdZu4K01LxlhYUpqansQhwuYaADwz8/ttMR7c4tuXcDm7St1u7eIlNw4mvnTndQfOaJ4ATv9fBJ34XvPmiwyEmy3JqxhZEcdXLMTBlR+DyAk0lr83Wxt1pDVCL9fYPq7aMPb86Lxq6AM8ks0HbtFgJ1UYVjSz0dEhEoTbuTEWEidKMVcpu//Q8SXm6uVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5485.namprd11.prod.outlook.com (2603:10b6:5:388::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 01:24:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 01:24:02 +0000
Date:   Wed, 16 Nov 2022 17:23:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <Y3WNLtyZYLQNMZzj@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-8-ira.weiny@intel.com>
 <20221116153528.00005af7@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116153528.00005af7@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: b2592e98-e101-4ad9-d4f7-08dac83a693a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6e9O5v2LtaK7VtR6lC77rElVz5gsBOjEDLxzeCvZSo7V+uJYx4oDlnucLW3pm+Lks0h9cdY+4BGzCDsILRkcel+qTEbPkjwrrKLW2O/Gx8badVN1P7/Qz5LjPMWAL4fFzugJ8E+DCWxoTFWeqah8si2Vj5LNRDJVzlzmaqtl9k3INVhBXK7rlK1uKj6qr0ReyAbu/8XWvTPJImWOh08rT/FqUbV4e1EW+uW25HdaPGGJ9sdxBC6AT9/nCRS50O4N+oYFNnnluxwMr5lOCVFw63Dqnk3CCgC3yK2BsMJqd2etYwvxK9dSX76C9HGPdUegmATde1bFKKUymz76mxY2NE9UvxIiNNRS3WE+KvZZZKyUqLTQrSJRrP+o18+wGEdHrxUzR+RqaNAvNi6sScWlpr3z0mUZPrnbNnIK7RyTNM3Hqmh0FjTUZCD/t9+j3UD6vqpA9bNT83aSt1MXYB6dka+SGfwWEHy39tlLM4GNNS7fUaJ1DUp180M2C18kSmA3fsbOz5aHJtGgNjEaMF4saXe6ubvjQLPdPiZIwcWAU3mFTDwVkAa6l5JjpuZk78NGlsczQmNcwD0ehYIOwjawrxcg0vCWJne8MAoeMC71FiRQOeWqUGCHAyh71v+0iYbpXcJLM7evUAaWxJtIeC2jg9bq32b6H9mPYaO9uJp6wZjGwtZz4vlGiq4lSI942oZD6gTMtX+4u699LoF42jJGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(66556008)(86362001)(83380400001)(38100700002)(44832011)(8936002)(5660300002)(2906002)(8676002)(66946007)(82960400001)(4326008)(41300700001)(9686003)(26005)(6506007)(6666004)(6512007)(33716001)(186003)(6916009)(54906003)(478600001)(316002)(6486002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fwZ6J5D5IAgaVqUmBhYkFWo/rt6xbCZ7VHIgp1FhudGiBcvW9mLgkNpRoNy6?=
 =?us-ascii?Q?hmFMv8DvLLF8UWG5E8w4a4IR6/nvH5PdX7+e/lN0L9ewZZoGTtWA9y7CLMOp?=
 =?us-ascii?Q?Ix6NY8Q9+i2MPh0aaywfVdDu3MOfc5JCUW7yFugTaBNK6ojfkno4lSU65HiK?=
 =?us-ascii?Q?F48PLFUXZ+43ZroxzfF3cV2tuZMDRhACWlDG8a+N+5Vf7GwcS6KyOxepy/+E?=
 =?us-ascii?Q?yqEfmLwprSSg180G5bVBxhU0OIFGlgKBtnRQWQSZUYwePtleQ0u+4GkbpD/+?=
 =?us-ascii?Q?t6BNyT61LjJlT95w6/pFwyQQQlHiSxrVgOFyo36LW4t4Jxx/0T7ha5ANDjYx?=
 =?us-ascii?Q?/olqgHSgfk/Mcf5Nr0Xk3E/OXhXU3wKzEweGGboOzoi4U0dKh0F6L/sVXqu8?=
 =?us-ascii?Q?LyiB7xBnbTMMr+WzCLe+YFDp+5LmxBWvcTrmHAQO9wKgEmER0q7zVKAyn2Dm?=
 =?us-ascii?Q?ewt5zWvoYJN/a3H255Zil8fvdUEUpGNBwYeygYE3KiTyR101s42o+07T4PTP?=
 =?us-ascii?Q?mEKW7dVDdAoTlFYs3Uug6s10Gx7cJ8OWPem7CrEdv3TcRJsKHVPYKH/bRE/y?=
 =?us-ascii?Q?WchXRRepZWVg+MIggpKB6Z99XX4R4ExCOWH32EmYHGYoYJVFoHyR9QTEl2hZ?=
 =?us-ascii?Q?1m8BjgTnMxdEOCWEnWalfT1Ji/0Ys2MGiHUhUWyIWyOk1Dnwm6z/xxBVd5WC?=
 =?us-ascii?Q?rHPbT+jYwkARJpPK2nxOv3rLFSwZ+PXXo4uU50B5OomhHbtE2dUEvcm6ZCQ+?=
 =?us-ascii?Q?maAT8fHYZpAd6M2oP2NGZulPuggUH8FjOWQfUMumlSXzQmOvV1JB5H7W3i+q?=
 =?us-ascii?Q?7S6ft7LaRnps5ZNfxSGZFZJjMytoxAHLEjDggdZSTONZAdF6eFV2VhpmxJJ0?=
 =?us-ascii?Q?4lVZXC2XChPNfQLIMONLlW1kNawB2VzckrkUVIf/nU7Ou2wY9/LXqFcaBmkr?=
 =?us-ascii?Q?d7sC5eMcOiRjKfxBQYOzfTcPtu52pYQxwui8JQCRlC0QHdoUpi/zLhEXLFR3?=
 =?us-ascii?Q?LGXea1rL//ko1xUucgMQXqdqZ6Fhp2nS13rl+/tyDAXavzgwlO7bp3nWMm5b?=
 =?us-ascii?Q?0rBj3MpnUJQE+RHlmkyDUkPWBYVgMUjGHlNLh5L5zIHwOUuo5M+12mL0i9o+?=
 =?us-ascii?Q?wKCcmC0dYHnBivzdSZF0I4G3X+l2jRN1Uz0LHd6WMgrTxHlxKzUA0FWrR9wN?=
 =?us-ascii?Q?yScbYNZE3+VRnHT5v/ama7C77sSdvxUqvzhjccn5VMlGBhbDWAzYYbIocIdT?=
 =?us-ascii?Q?2XwnXMK3ebFn3gJD1MvXbbRCF4JIHigS/KZfaQvBNRjwD7OXSEvRkBrxU52Q?=
 =?us-ascii?Q?yzQnyQyPCp3V1BDaDoQPrvb+/3PEY5yyYokrLM0p+vohgeCRGvrHf9GX/l8u?=
 =?us-ascii?Q?iE/wjK9gVzEOaOYYzWp5HaY0Ip4V2N6vDp8x23Jv8iD2zfv7bVnFgwevdZLI?=
 =?us-ascii?Q?MOVagAogzQ09cDFbvps2O8NPEKW4apfkgx+tkHzcK/LIVu7OjbnJDEe67ls0?=
 =?us-ascii?Q?5iLPfh4hct2oKOF79VhGUuXzv/Jjl2gPKDgJyigBH0GiPyEWxXfYchC7fJdG?=
 =?us-ascii?Q?s4DjQ8zgrzAjfVTStWii81CxAXnnVQZG1L9AKa0G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2592e98-e101-4ad9-d4f7-08dac83a693a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:02.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5oPWKHEkd8YAEGFDDWw5OcHo6NWkCjXtsd4oZgEoH+0T7oS4z9/WTzjJvCDPtnZN6E4/u7pI2QQUUDYWCVvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5485
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 03:35:28PM +0000, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 10:57:54 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> > 
> > Determine if the event read is memory module record and if so trace the
> > record.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Noticed that we have a mixture of fully capitalized and not for flags.
> With that either explained or tidied up:
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > +/*
> > + * Device Health Information - DHI
> > + *
> > + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> > + */
> > +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> > +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> > +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> > +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> > +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
> > +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
> > +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \
> 
> Why are we sometime using capitals for flags (e.g patch 5) and not other times?

Not sure what you mean.  Do you mean this from patch 5?

...
        { CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,         "Uncorrectable Event"   }, \
        { CXL_GMER_EVT_DESC_THRESHOLD_EVENT,            "Threshold event"       }, \
        { CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,       "Poison List Overflow"  }  \
...

Threshold event was a mistake.  This is the capitalization the spec uses.

Bit[0]: Uncorrectable Event: When set, indicates the reported event is
        ^^^^^^^^^^^^^^^^^^^
uncorrectable by the device. When cleared, indicates the reported
event was corrected by the device.

Bit[1]: Threshold Event: When set, the event is the result of a
        ^^^^^^^^^^^^^^^
threshold on the device having been reached. When cleared, the event
is not the result of a threshold limit.

Bit[2]: Poison List Overflow Event: When set, the Poison List has
        ^^^^^^^^^^^^^^^^^^^^^^^^^^
overflowed, and this event is not in the Poison List. When cleared, the
Poison List has not overflowed.


I'll update this 'Event' in patch 5.  Probably need to add 'Event' to the
Poison List...

Ira
