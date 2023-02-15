Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123F069757A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjBOEmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:42:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880DE173C;
        Tue, 14 Feb 2023 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676436169; x=1707972169;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W/W+ZqDw4LV7vFFizmJVs30a34WDO8gEktkcW2wujsY=;
  b=iRS9kSPh3b7Sevyen2wemTqkLzmtzcRzd7pkllensz+aB3Hs/wIIeyO4
   zTlGPVxwXmWIJNgzWIeOoPBGlSaH7o9+bi/ktOuxyJDWVTKeiL9G46onK
   L54arif0gSix1s74HX2+gGzslLHbs+R/8ACm8PW4JLqdLSsQtmrjzvQaJ
   ZmfRhTBuiOIVnNJ+iSFU783dZxtGdHOxzX2M0Q4spjX16q+cKHs13Vs1W
   fNavW4MR22OBYKL+wzGTGoJVsgUafNTYyH4zGBfjWy1BFg47U92Gh3D0w
   Zi+WuoVTWQEHMfaYm3M71LomAyegvJ4wZeoIBcMzmZfjLDexo5e2V/LVC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358761917"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="358761917"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="738154663"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="738154663"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Feb 2023 20:42:43 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 20:42:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 20:42:39 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 20:42:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McwekfGMnxN0YjD6upngTVjTGNLBCt0yQGcbKDqj5rjZSk65VW5EDy5XDcy87yG4P6qwxTAlvcmZHO+wUJ0edP9cHa846DNsuDPUyOouI7tyMLlVNxCtcArzWMleRk+0lpIBIN3WXWNCzfeV9NzOOH0ivihqodLbiDQNUIHteBw9AIF7XvgkEFElPho1HHDl5NJjgtN30E/XepjGC0i820OjMz7XOY1iN5W1SW6HPx1VlVhRkHlPMqP0yC6+ff2el425vbMlSa+44SJ6opmJNUTKC5pyDMK2ogI0US0J3/uBADHUEPzWcyfCTi01I+psS8zSohdVpotSsXNPoCmVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk+qS60w+z0D6/H0L8kyRBK5ruyJs+OaNheLV7j6dpA=;
 b=CYS+wPRj6nS4N7vvetHGxlBg8G4X5NDh7fJ0qKuSB6DHIh2dfOPTIDL04oVi5pKYiJpRQ/8Ob9rKAwl2sabamP3+qJCMzxOosfJjcfbLWeT7qH0ny63NCbPWEudW2jzt71O/z8QRC4R0EAanUXMcCVatrQQJ1QIIAfJ3ssFfkuQtW0fPUWGU/ugWbE8vlmkgpMK4panx2V/xj+l8MlhF2jJmcG75qlRh0TW5rDFoP7Q47KnbJkLMo40Ldd6dmVVSOBrqicU2hrw+z2Frjx/Mi7B/zuIXVDfjAoWY5u6jrkOkIGXLHnj8cA9oVbP2iBTtit/ioabTtKY9jj17HdA7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Wed, 15 Feb
 2023 04:42:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%8]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 04:42:37 +0000
Date:   Tue, 14 Feb 2023 20:42:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Tyler Hicks <code@tyhicks.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Muchun Song" <muchun.song@linux.dev>, <ecryptfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/ecryptfs: Replace kmap_atomic() with kmap_local_page()
Message-ID: <63ec62b9a1285_18bf5929449@iweiny-mobl.notmuch>
References: <20230103190259.30944-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230103190259.30944-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:74::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a23f79-c712-41d2-95d1-08db0f0f0fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLt6Dkptu+PriRicMfVD20oajzYO9mtgcsDYolqtRZlbJ/8T/dOy9XNnB2y69sxMI/MvS30SHta22yz2abJ89EqBN65+Jhqr2xTG4PWrmvnefxOdDNEDRdMx6AEgNQXRlsO9jd/KcDoJxnZhzjzm413SRikKh6EcYuG5KE5tfUTvBCu1LbAMlGhsma0JDyGZO3Hi3f36O+4LRl1f+yr+zzyopuiGw66ULXezJzXdxJQDB0zZ7agLMiO12SeqIjfHJ8kVCtqv4t6Q31KVU++yyML5O5eI9CRf9k5wsJngeZxXYn1kpiV+lfW7kW9er3j2loLYbTgdy32wmGuyoV3LaVVSZF1Ly346bOo1HpaHCMT/ya2BW1ZjKcJtG/hSR2ptna1nko1Wya8pr5kegmrkuOedTcVC3fSYnCGNlOQ2ahZ1tldCvWOvFbDOAoDxpN0C7VQ21jAtQ775cnuf2NEj0dF80bLITCB8EAFsedr4VE0hR/d8tNjgPsKNnak/dyM8lt1YvGSSAp2uCQXBfuvnK7hNu4dZI/xTVToZXFH6h2D3gwXlN+UEwTlNQ2F6wJbNavcpks9lRd5LpHe5P5K8AGSSbcMkwZ4TRQvN3sE5yRqnJZV1PEmnzHNKc/gK2bqXrpnreaXcjv8RHW95O4rmGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(6666004)(26005)(8936002)(6486002)(107886003)(186003)(9686003)(6512007)(478600001)(41300700001)(6506007)(2906002)(44832011)(316002)(110136005)(5660300002)(8676002)(66476007)(82960400001)(66946007)(66556008)(4326008)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PobANa45yv4bcKt8ueycI4V8KeBIaOg77nHmGwX4NjfA8mPYJlPo73mJKxCo?=
 =?us-ascii?Q?Q7B7nCbCgGQzwePdXGqbfY6IU9zSwSBjFKziz3IXoQNCtKHCr8EiJN0J9Kiw?=
 =?us-ascii?Q?D4TfZ2GepDh4MkTFojR6T9e0/8yXA1GLmkS3v13TtFrdJYGs9y8CoRVFPurh?=
 =?us-ascii?Q?kJkEN+4U+pPhLUTBPXBcc6XKLzC/hKqawXC+0P8t0FGv8goAxM0+fCw2vPkV?=
 =?us-ascii?Q?QPI0RvcH/6Hzsj9+WJz2Bb4xS5KfuJ8Kj0EFk6YbNHVUCa7UjdC0iEOi08lJ?=
 =?us-ascii?Q?kzy0iMTkZBfWKqYVdOOyCXFttoxWFi05AmCXlbo+QwTfmO7SSotk9/E7chvw?=
 =?us-ascii?Q?cZFToXdUB66xLVjIU5dw0sgtbsIwbIoeiQB946KcJvzTpHJKfBNZNBq80vOA?=
 =?us-ascii?Q?YytovDqvtQH/+w+FjrN7UqHY/J0wbBiwCHUPaQGJaQ2/5qrxUnZ5ewOVwJIp?=
 =?us-ascii?Q?qodQ9gf6mOLVnHOFJblmLGXUJB8YApk7CqbpvWkbHbS/GrEeWpmGYFISIUOW?=
 =?us-ascii?Q?Pk4rJUl6E0fHdrGeBd15nEPBolfoewEvZMtv45mOazuNpoqu6IkesEyU2z4/?=
 =?us-ascii?Q?ge+6j7ywJ4GVSwxFdgwKpMn8TD2qslTNVGzRbeq5IZCGWnwbCfD/E+4nR9kS?=
 =?us-ascii?Q?w05R6JHc1IMSzbY/62lQm9WoJFFLNyOkz4JLmtY+qVguLe7zCGzT+7EJP1Jp?=
 =?us-ascii?Q?t9pWZDwtW0eraJFx6QXM16BoBFvFlbdTff1PvjxkUt5GVozaqZgDBbEozM7p?=
 =?us-ascii?Q?i9/VQ1Uz+9B0tj9b8cFLduEKQt2zueuAAVfuwIxXhTWcuG/X3BGRlhkzBYfV?=
 =?us-ascii?Q?nK20buDUNEAbA6Qib/594jLQKAyQ/HKtOo827t6Ktu7Ug0xOioo96a3uH7Wn?=
 =?us-ascii?Q?4bZAivs2d2EntljtbctHihWsWSHVfV7qQI5GKG+jvs4Ji0zqlJp9w7zadOEw?=
 =?us-ascii?Q?FFI9lYGYF8lUXuM4wuj+3UKjesnMjOzOcLvSaOq39ZS6K6IJD7P/Q0xuGbsy?=
 =?us-ascii?Q?jZAM2lki5X0vmdCZ3ydhibL89xpR1JYCOGZuLqhB+SR/QXmxPDguYJt7gU5D?=
 =?us-ascii?Q?LvEc1Rg6ntkyiDcBdlAXc6oM94FLuAFwFhUMXe0ah7hfIYyjPNjgKQwhVU/V?=
 =?us-ascii?Q?hDn9JiTuJBKlMlnxL90nRrUa8SXfxevSGPi4tBxliy/E1H+uvcXf/AFAsZCZ?=
 =?us-ascii?Q?p3mcMK2ZTaaJ0xrVDi2FYINNcYbMM2mutByI+UkxDAyUpInS14E0SBFnnTfK?=
 =?us-ascii?Q?ysI9iu250fSxkD7tQ7BrR2ZUwOrCcfQrwiyXz8v4EjytoEfTy1TycsGQVW0b?=
 =?us-ascii?Q?ayIXL8FDi6einOWPcuhOI6fW9oF51yJFZNNOdhM5atDgubdxFvtjkdU7QncA?=
 =?us-ascii?Q?3oBwXVfKwcYDiTuJjvd65ddNx4RPChdKIW9JuwL8nIrJi4rmeRljoVpa+sqD?=
 =?us-ascii?Q?YCFDOsRHeYDm8Cg85k6ObH3AFxJs+0XcNv0BbJmx27mxf/sIQtYsR7foC7oB?=
 =?us-ascii?Q?ftOdrdvyRDeM5p5S+lgH+eD1HWjhNo208ESiwA7P3yVr/NpZDPZLcArDK7sa?=
 =?us-ascii?Q?JE8cDVb8ZLz0e7+qBfCQvz9dDB7bYOfoNTqalgIA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a23f79-c712-41d2-95d1-08db0f0f0fe8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 04:42:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uod4c1l5hUEKbKsSAmd0q6QGmL/cs7eRDnrOVAPLartqgp/O+hhQua4AAxFIK5p50Ss/Jyoc9Wogq3MGBhf0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page() in ecryptfs_write().
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> 
> The code within the mapping/un-mapping in ecryptfs_write() does not
> depend on the above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all that
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ecryptfs/read_write.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 5edf027c8359..3458f153a588 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -140,7 +140,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			       ecryptfs_page_idx, rc);
>  			goto out;
>  		}
> -		ecryptfs_page_virt = kmap_atomic(ecryptfs_page);
> +		ecryptfs_page_virt = kmap_local_page(ecryptfs_page);
>  
>  		/*
>  		 * pos: where we're now writing, offset: where the request was
> @@ -163,7 +163,7 @@ int ecryptfs_write(struct inode *ecryptfs_inode, char *data, loff_t offset,
>  			       (data + data_offset), num_bytes);
>  			data_offset += num_bytes;
>  		}
> -		kunmap_atomic(ecryptfs_page_virt);
> +		kunmap_local(ecryptfs_page_virt);
>  		flush_dcache_page(ecryptfs_page);
>  		SetPageUptodate(ecryptfs_page);
>  		unlock_page(ecryptfs_page);
> -- 
> 2.39.0
> 


