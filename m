Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736646AA0BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjCCU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjCCU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:58:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B113530;
        Fri,  3 Mar 2023 12:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677877097; x=1709413097;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rdobaaUMtJohPe4ctXj3xh1KvYFyY5CDcTcPC53q9NU=;
  b=Czbrpb+kFzN4kt/kzNHzdWeiBxzBjCK3pLSiBilWxnNbpJNCzY+R0hpB
   gbgOY8MzkQMpipo0g8uPnrSZSZWK718uSqNaxu2zG8DY+6OrPAXZsJP1K
   I9b0vSUhe7XVSSw7c3NZs/q568MNG5mX1tRF/ov2xnUpDf8mvnK5YPQ03
   rJPHC67lxDqKN/1DfzPXhbqni9X2OCbQWsiOxNGOs1VfhVmdOUcUYT/rH
   2r4dod5ZshpXxzkU2d8LxGir5TQ9sF8JsJ3oy3WcYvarWbz82W1oj2RzR
   4ywAoInWAk9jo9nU89PT++wHEw0QwG4f2vCMT1ELtMFwD5ZTjQpVLxb1n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315554928"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="315554928"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 12:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="799345961"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="799345961"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2023 12:58:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 12:58:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 12:58:16 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 12:58:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ8tyLPEPWGgonHPzU+AdESePZMHtANckGswiwlsEC26hBti4QvC5rmlbVWdfp/9cfqgftNasaLRg2dHCDE7LwCOHs9/epZkzpOkb7KMFvJRT7K/ZFmrHxDp8YrJhl/HuIUda1I9wJi5e/xYxv5B4/BR5udVaQEx0IVRfC4JOSmajsasrja7FnryB1IdBrVPsgYduuGdf0acMhu/0V/erntbWGwoNSBsciNwf1tZp0LSvPkn4tmdJWMmtn9neVOk5XpI7rkFeE45nAxsjGQv56UROvD0mNKHxqXzMi7sKiDJUgzzRhirC0e7cZOtZKJ6iDGItNEHYdP++7mKsqR00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjFzhViOzxI7Rky45TqiwM55Qk4JISp0SryeIy+aDyw=;
 b=QnmJr0jZpk54N94kSw86Iq0XkiuZPROj9W1nlb++e1aXlIqZWLfcwHYUpV2PUVlB+W+/G3QXP6WmKCZ91pn0cEPRk/rs31C6oAOjfDYWComS7y5qAlFdpzS2MeO7UNH+EwAWwwM5gg9Hl646To9Jzakmo63jQ53vSWyGRAIBzzS9lJfJ2Y44iOTtOsehz+DXbUH7I0yqU7dfbt7Hm2RcVeg7x/U4PUh0WpemUTwu/F1UTwih7x6u5WJ7ZrYNFOT4PPPyxyZzCTWAKYZel0C05xihMqbGP8J29HgyahhTR1ZHwJXGamMwfJ6nmMs4vV5pmEq/CfAokJ3wTJe0a3ynmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 20:58:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 20:58:12 +0000
Date:   Fri, 3 Mar 2023 12:58:10 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Ni <fan.ni@samsung.com>
Subject: RE: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <64025f6219d2d_71138294e5@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230228224014.1402545-1-fan.ni@samsung.com>
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 88853d88-1f76-4d30-40e7-08db1c2a0060
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFjegFwnCLpIE/jxVxeEq1ula++9gWS5brDgprfQ4nPuL9gFbcUX9EOsK9xbcajFDFB7tlMvEhHtZr+sMf5ObCELOqQsdzvyRwQ8veeEzHUnejoTzc4kcGIHSX2uxiBDY+N8DypjSuaLZQ/gzDx81s83f3bJqPQyb9zEeSGHYknuL4v1GhPy4kq06ztPvbHqbN4h9sUF6+b8IGaX3xyho0uZl45hjPTBXt1kEsQVY5n5ECe93GnsmuczdWyfPyC5WX2lKmRuwtutOAz3DckwDgHMkESrjR9ayxUFoH43mUt2aDs+HQJaxjQAGDSSzTtF25hIAqJf0iQnueAofL6O+UPG5ulLXpOJU6MrWr0uYwLqWkfFIQwXhqgqCrWr71zTDLk85NVre9YwZJ6P4zF4JLn6ZXFwRl0ATECqTl4hdMj8owH29XQXYafOwc5FJrNCmuotq5sN316hfbSDFJRrOnCJqkd5wEUEFQlS2T5kEkQdXXrGtIyFuEFfXiK/RVIzo7b+SI9uxPz7oTTw/3x+4Cjh81jaGdzjNVyLDAUE6BMvwT9+heZZO0rJK+F2mCHmPYaDjrX5e5wi5uFgDgavjEXFLNV16zhP35ZJMddRghYpddHj57V77JBHFWBKewSXb1ZsIuIoU38tYZSjpRigOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(86362001)(6512007)(6506007)(2906002)(6486002)(9686003)(186003)(26005)(82960400001)(478600001)(5660300002)(110136005)(83380400001)(54906003)(4326008)(8676002)(66476007)(8936002)(66556008)(316002)(66946007)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6zhciBasSZJEckrh8bsnPnQjsNqDyJN80mW3wyt9MIcUUtIIEjHbmtUGDLh?=
 =?us-ascii?Q?MQPvQ/RqknCRUcTLU2Ee5bifFE3BkszldO+KxVHcnc5yc6QLRaYtgyjOAnpR?=
 =?us-ascii?Q?FuaNGM3idRf+4zI983Gc4hYfMoHfHUHb3Xd0KtZmIBerheHGMiGI0f9FDEmc?=
 =?us-ascii?Q?FZ0B1E2MM2fPCtzM9pBXPgM2f8SmTGZdfX+LJd/YUgeaLarKZBkSKCIO0oUI?=
 =?us-ascii?Q?cuyzX2hEx6vMhtk8ADPM3AgbSXvnQNGhHH09+G6lSHpzR2b3rjvMFfzXASAt?=
 =?us-ascii?Q?+xqvnJgylm45i1Ch9xA/v+RUz+ZAZn2rp3mi3goWL2Bzh+co3lcP+zbl0u88?=
 =?us-ascii?Q?miHgyfkmJ4qkoC0/Q3xSsv4iIj0jWdn2xLjy5Tixg8X/3Q6lCvoExjLqM0xy?=
 =?us-ascii?Q?wgp5F6CUKiGTwV75LhVw8qweAjHZI2vA7nfsynUHgYnpJqEPsWt+xoV4p/eo?=
 =?us-ascii?Q?dlSubIFCNW3FyVy/OLh7W/G+xApCaDw0bS3WJbQtEWeMGcHR8znzjRZCRf2O?=
 =?us-ascii?Q?k1f/o8xOrBgjQ/GFetKM1G8Ptzzp0f9d+9Owy2RGlIwoySo4eriMotuGBash?=
 =?us-ascii?Q?Ish7/b5R39oPBAnNG4OZK8apG4sj+fsmXPvPi56E5RHanR7tN1V+8AEbR9Jx?=
 =?us-ascii?Q?jjHgVE3sEnMxJkMrxtG/kLtBi5zugfAJBfBQwVkswtbbAshNl6+X0ZswS7qa?=
 =?us-ascii?Q?0dX1ZL/BBps8LvAx7BTfYEUFRKEOpXVbLF/OMQHIJl4D058CMeZV/4MkMTr6?=
 =?us-ascii?Q?5aBfO9+eGBUVbBQajQFNNl/qoheEK1AdItsqeU7PSV3jblIuYg1Zv0mOV4ft?=
 =?us-ascii?Q?re7pSRZLqnElZP+Ywiydkce+VWVVgzmpCmS5ky5atZLg8yKX8zR4pQJwuJoc?=
 =?us-ascii?Q?gWc76T1iB4VTZRZWuReQe6SEDut6hK7VcFRpbptxD59yml/xfMupha0LddWB?=
 =?us-ascii?Q?KoJ3yFQTRP17oTKJUq53SklXEpsj8Spqavij2vJIrDeDBlwxiAgh5M+IGs28?=
 =?us-ascii?Q?pisp5j3ajzCC2FeZVEc/CHcO5RuO8rNHMxKFMRjGwmUQu/qDy1IAZMWcADxX?=
 =?us-ascii?Q?lfwFXP+QKNWjIesHSLwbP33Cbxm76uyuWGeI5Hkwe3t8OpOslQ+BEf48TSpg?=
 =?us-ascii?Q?tc0iWnQe19KcN+8HfIP8Xc00vZCPqg2HiiecXDUyfcNg/JC5m1OONZ0pguYO?=
 =?us-ascii?Q?CtHbLc7Szb9/FAI/DazBuSajH/odf1GPkQHxB+GdV2B6g+HA6nKjbEoLXYER?=
 =?us-ascii?Q?1w3xH8hI8Xs/yy/8stJ03iySv+gwQN+rx7xsgl3K0lWNW386XFCfpMAl4uDv?=
 =?us-ascii?Q?hl+SRL3zfFP9/aoUnLJRIVnMfuOsS4Q+IjvO195l0IcaLWDuzGPlh+NtAedu?=
 =?us-ascii?Q?o2DwjHxYE4MTt1XsLUiRzw/ATvqznjV/UuAPbpI0g7NvI17+BiBdc9tKzBmP?=
 =?us-ascii?Q?fRIAMwAwI9cght1cYfVRdCY3AN5I0rFnakFawcUR6ufbHuLpG9RAFKc3gWXH?=
 =?us-ascii?Q?F1wyaFcYfRjYsPL473D+M9S8iHX1FVYFOjo5FgwSjAuAETQVRdc6Ii/nyFPJ?=
 =?us-ascii?Q?NpU2QAYL+atd3C43mgLXrQCHJrlQzz6p2/j9zxS9/cDy1WPsmrII5L8pu5t1?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88853d88-1f76-4d30-40e7-08db1c2a0060
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 20:58:12.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WESLp7bhSwyDAxKkSzHtCIdctYP5H0dgctTZsYYcYLcC2/lrzRarKpI2gJbAHYDg//CeaGrxslIULPhibVZq2DEKW8cE5oOJXKvUPD60b9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fan Ni wrote:
> Add COMMIT field check aside with existing COMMITTED field check during
> hdm decoder initialization to avoid a system crash during module removal
> after destroying a region which leaves the COMMIT field being reset while
> the COMMITTED field still being set.
> 
> In current kernel implementation, when destroying a region (cxl
> destroy-region),the decoders associated to the region will be reset
> as that in cxl_decoder_reset, where the COMMIT field will be reset.
> However, resetting COMMIT field will not automatically reset the
> COMMITTED field, causing a situation where COMMIT is reset (0) while
> COMMITTED is set (1) after the region is destroyed. Later, when
> init_hdm_decoder is called (during modprobe), current code only check
> the COMMITTED to decide whether the decoder is enabled or not. Since
> the COMMITTED will be 1 and the code treats the decoder as enabled,
> which will cause unexpected behaviour.
> 
> Before the fix, a system crash was observed when performing following
> steps:
> 1. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> 2. cxl create-region -m -d decoder0.0 -w 1 mem0 -s 256M
> 3. cxl destroy-region region0 -f
> 4. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core
> 5. modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem (showing
> "no CXL window for range 0x0:0xffffffffffffffff" error message)
> 6. rmmod cxl_acpi cxl_pci cxl_port cxl_mem cxl_pmem cxl_core (kernel
> crash at cxl_dpa_release due to dpa_res has been freed when destroying
> the region).

I think a separate fix for that crash is needed, can you send the
backtrace? I.e. I worry that crash can be triggered by other means.

> 
> The patch fixed the above issue, and is tested based on follow patch series:
> 
> [PATCH 00/18] CXL RAM and the 'Soft Reserved' => 'System RAM' default
> Message-ID: 167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/hdm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 80eccae6ba9e..6cf854c949f0 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -695,6 +695,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	struct cxl_endpoint_decoder *cxled = NULL;
>  	u64 size, base, skip, dpa_size;
>  	bool committed;
> +	bool should_commit;
>  	u32 remainder;
>  	int i, rc;
>  	u32 ctrl;
> @@ -710,10 +711,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>  	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
>  	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	should_commit = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMIT);

This change looks like a good idea in general given the ambiguity of
'committed'. However just combine the two checks into the @committed
variable with something like this:

commit_mask = CXL_HDM_DECODER0_CTRL_COMMITTED|CXL_HDM_DECODER0_CTRL_COMMIT;
committed = (ctrl & commit_mask) == commit_mask;
