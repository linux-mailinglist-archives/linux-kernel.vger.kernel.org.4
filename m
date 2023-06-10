Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD572A847
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFJCSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjFJCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:18:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3933ABF;
        Fri,  9 Jun 2023 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686363506; x=1717899506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p2/SOZwgvUrbuKh2S8ihtl4pl8q7acVIKw0dj6lmmzg=;
  b=RB9L85jPw1yNukrMXqcfJdV84tzmokCYwxESRXjtontUgD/WlAB6QvLw
   z3sxyULpOtENuMi36R/HUtukJPFKDyvZ80IsLNUnrd85Gyh2Gw00OS7j1
   UV7xs1qZhykYeku5lOW85ixJAmP443o32CFCl2KsJlL9Wz/MhEIRAvHBS
   y3HN6ecM8/Vfkl6hxLUzXJAmpdbA+qjmKfPYriqQLoTO6cE4e44XxX0LM
   t7NgX0QolB95VGKA52x6WkMQhYt6L/wjoR6rT65/z256Y2F+DgpImnFp4
   BoTNfrOTwqVNXGzcP2F8abuGxSM3nLwO2Su/qNXvNYNx4qbpwy/RmbwsG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337359522"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="337359522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="854928692"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="854928692"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2023 19:18:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:18:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:18:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8hUELByS6QkOvcgYRYJxTZ2uhg+idJRy/Wc/nXVgIgBMZDu/DAFmTvs2Ipsv5utU5yqQMwgf3nKnVRMPpLe/I8DqMJOPn5wlDtZSXWYn/5bZ2l09o432XBDiI4Tf9qRem6v3XNr3ytFF5VKKblnXA8OjcKdW5Bow9kDujwPVHvk3fmjWIQnDGKeA561v2E0JI0hOBqE4oCqkg6VLfNrjoGveWATHZE/IDR51hZmt5VsRtz5Y1D0/kCDv2AfkgWw4N4+bo4DUgnTgUzghYiZ7PTSeYI1KX9f9c6J0KBvqIb8PQIRkdPQJz7zUoAyEYK8ir0rHSZpCQZXwuZ+aOmglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU0Jy2mwSmokNsg9tyrA/7fcRuI5gXkDLhWp73cMD0M=;
 b=HwT4GK09yANQDLbfSOaZYGuc4h8Otcf69H35pLjeeHowLLHLEkGSMEVLVe6I2GNoEHXRuQq+LYlvSrdrc6iZQNvPq49DzvYFLd9nU795E80wgj9RPZBpcPSS1MSoCQgU1+W9HHB7TEprPkzxjrqyaGqDDOCgoN1c1OXCBK0x+sj9fxA0no+ZtYqypBxSNUxx2tTPMJibkmaar0zxauuqkQFBF8A+cPmjKg0PiW/7qKcLoOHSbaK0RM5c05u1EG9hmV1BcfvgcQoC7hQdl0ltp8r8SRVtoAQ2BdVQFs45nAIYn6pRqpe/sxoOqACxXyyyiiku+X8LUgoK93Fi8//Exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Sat, 10 Jun
 2023 02:18:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:18:25 +0000
Date:   Fri, 9 Jun 2023 19:18:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 12/26] cxl/port: Store the port's Component Register
 mappings in struct cxl_port
Message-ID: <6483dd6c77fe3_e067a29421@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-13-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-13-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:a03:54::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e34464a-f42d-4a5e-ad6b-08db6958f847
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kDLIevAzF6yPiZqHxTs4sRl+qx6OHqoguB/rk0EyPT81RuqmVWo8SayWzjeAYrbUZJ/Ct77bEoY2GCaY5TF1tX6lj9ZMKzOo8OwbdWCXGSRkEPcvfBMtd9KyC2qj7FNZMzPo6mdvWC2BQ3d8fC2wFXSdfw5xA3bGUp/5QZlUIepon2NUQhqN0Ib479bo4EYxYpnIyypE22Ow7pgjF+mx7qeVQqb7WD7sDmQGkz2havB77uj59hwejubNuNUVZ42BhaRF55b/Bx+MaI4EJim3gqIE/+PlT5/DNtfjAkJ0CF+Bldbuy43/hfRXQ+MqOd8ayYXQmYFtU/RqiIQALA9O+0pXNh2JkrxxKUgN67tSeL/+28Z0IXx2UedmN5yF0TPlNK78h6OzqoHo6TfJyS8VDjqep0ScpyDwGrfJWWPhAP8IWJzdoU2rXHKSkGkEl/1WxwjrSCzNXb1FsONAj5wmKiwEJJxC96lW2B8O9YGYIZI4vsulCi2UUSl9pOfLp3RlUqd6Zfq6kCmXs8shnUxrIScRPYvMhh0bfLEZDDt81/+EIEHyll4u6a0vb79tfAD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(5660300002)(4326008)(66946007)(66556008)(8936002)(8676002)(41300700001)(316002)(2906002)(186003)(478600001)(66476007)(6666004)(6486002)(6506007)(6512007)(9686003)(26005)(83380400001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WP9ICsSv/9spKlKGCnyznEo3VeRttPE5MrdveWpRWwxP94ORVfnAM2UQiYj?=
 =?us-ascii?Q?A3zfsxXOeRJK1vTrRL9D/UTjIZNf+X4QeMbcGjRm1KVJ544odoBRNqAgAoCO?=
 =?us-ascii?Q?qJiKKr/+4LUxeReRvVXKsz/s+eyIUVLn8cKUFIFUj3lGn5rP7YFuJoe3uGog?=
 =?us-ascii?Q?fDY3+gZP1LLVU0lCWPGOlkqS1hYWSyW+oUN1dzJSzuwaSb/py9lJ8rZDVJv+?=
 =?us-ascii?Q?SnOK6vItC41gr/rpx/oqCfhpCRzzSJXu2QistKHooYLyu6lt+e8unWPeAwq4?=
 =?us-ascii?Q?P98DKs67/qngnbi7N5kKFbv17bZpdtnUZy8xjh0Bkv9GY52xaUjs2hh45qCe?=
 =?us-ascii?Q?FroHGaJ7MHbXzPV+k/gcqXpeYZoaBkS0k6hMR23YQMMGru/RTg4Mp0ft/Qmv?=
 =?us-ascii?Q?9aTdMHHORY47ucvaPN7vXOriVMr+3q3yMKZFR4XuqOIBGy7Ilha9hIc3m1Uo?=
 =?us-ascii?Q?Nn1WfWifA+qCoaMvtRFaPqC/+9WTauB7AKrRMvct3SeM9ZMmW7RAN7FopvTX?=
 =?us-ascii?Q?UbkYXP2SjgnAkECP3zzYbC0fXm4t2uY6TrE8tUIlj2ag2bxx7oLf3E9/8HHn?=
 =?us-ascii?Q?oyF6xT2am6XzfvcWfqkd4b2V/qE9/HnPweE+4oXtgxtEsPNxPBJcfV5KBFuA?=
 =?us-ascii?Q?plRpwX0G7gJeasGwotmcrZJbaVcRBPl3kZ3wsHokVFiGR/mfjP2rqU+iRxYZ?=
 =?us-ascii?Q?jmz5NijQR8vSEFmlMqejmMHKAh/7cWVpjwlGNOCSVZ30H5Cpi0q8i8+Ql0L/?=
 =?us-ascii?Q?7ul34lT9NLRK21tEAIqPd2S5AWjRHewpXHKunqmRHn9/36ldCc7A2TyyNKus?=
 =?us-ascii?Q?mm1i5MK2rkD/YUuNP/QdF4sTZWOVFl5cMl83RVpGqfSvVFdNWhRYHKXufJoL?=
 =?us-ascii?Q?NGCXF/MEMvGlBzxmTyT4spP9wNkjTc5AVa5oq/AA+ee8HB6vZ996Yl5y4YFx?=
 =?us-ascii?Q?qtEHlP4DPANAWiuUMhxnaQBZccRHanbkXsnhCKerbd24/nMp7Pvx5jloAP4c?=
 =?us-ascii?Q?JwOtlLjB3RwkXCaWWavaBrz5WRchZRumrdoWIgavmgRAlcAVwmpwUK9nIJDb?=
 =?us-ascii?Q?j6cD0C6fPbvx9G9g87DEFU2Q7mchuewmN3w/2YVdVyvXBcUjRddvC4S2xH9J?=
 =?us-ascii?Q?bGpy9w+u1HKeR3rZCYcdly0RDv3SSwhaA6vffDvjgE6hYKXyTXQA7nMf8KlY?=
 =?us-ascii?Q?xZKM6dLo4rUaulMVERl29Kqy6BG15WFsTBUtAQz1UbwtXQB4IzN+ouAOw+tf?=
 =?us-ascii?Q?eGEHz0mGpyFl1VG78jrsrPnRIj5e6+6zx90fuUjnCTD+sEKLH9u2f5xQ1OCY?=
 =?us-ascii?Q?qBkFwVDkeaVaHwLDOrnGVziZxsM7mOMvVmPIQcb0LLC1ZFfhF45dDKfc9cBI?=
 =?us-ascii?Q?fXTXKX6P5zDAUQ08AaT77uzVQLvkegKWv65quZlnh2D0bZjk47Wy5/qQKckm?=
 =?us-ascii?Q?YoJfmPzQQF+KtKif766SwCGFEGBy8bO0yN9Rsc53g5zYobwE1ooZdzZLcdeo?=
 =?us-ascii?Q?NCwS/MmH5cq6Qd5z7sTnXV13lkScbjUY5u+Ttac2WXBpWwulV+7j3fJgmK4v?=
 =?us-ascii?Q?kauTJtG9yFTek9KiR/lbqjVFrSfMDEe9cIY4LJMOIoVhfFfBZSYOJWFADii1?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e34464a-f42d-4a5e-ad6b-08db6958f847
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:18:24.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N762wsyJ+naL/viBV86bDJ8qPtHUNX7Ri7KLuqnQWnTHWlhHy+y9FpdfHGlPfPvtlX2ePm2vC6MnQ8MnSa/zTF/gu76NEIBxEZ7aq46sKZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> CXL capabilities are stored in the Component Registers. To use them,
> the specific I/O ranges of the capabilities must be determined by
> probing the registers. For this, the whole Component Register range
> needs to be mapped temporarily to detect the offset and length of a
> capability range.
> 
> In order to use more than one capability of a component (e.g. RAS and
> HDM) the Component Register are probed and its mappings created
> multiple times. This also causes overlapping I/O ranges as the whole
> Component Register range must be mapped again while a capability's I/O
> range is already mapped.
> 
> Different capabilities cannot be setup at the same time. E.g. the RAS
> capability must be made available as soon as the PCI driver is bound,
> the HDM decoder is setup later during port enumeration. Moreover,
> during early setup it is still unknown if a certain capability is
> needed. A central capability setup is therefore not possible,
> capabilities must be individually enabled once needed during
> initialization.
> 
> To avoid a duplicate register probe and overlapping I/O mappings, only
> probe the Component Registers one time and store the Component
> Register mapping in struct port. The stored mappings can be used later
> to iomap the capability register range when enabling the capability,
> which will be implemented in a follow-on patch.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8b688ac506ca..305125b193ce 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -686,6 +686,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	return ERR_PTR(rc);
>  }
>  
> +static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> +			       resource_size_t component_reg_phys)
> +{
> +	if (component_reg_phys == CXL_RESOURCE_NONE)
> +		return -ENODEV;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = dev;
> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> +	map->resource = component_reg_phys;
> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> +
> +	return cxl_setup_regs(map);
> +}
> +
> +static inline int cxl_port_setup_regs(struct cxl_port *port,
> +				      resource_size_t component_reg_phys)
> +{
> +	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
> +				   component_reg_phys);
> +}
> +
>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  					    struct device *uport,
>  					    resource_size_t component_reg_phys,
> @@ -709,6 +731,17 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  	if (rc)
>  		goto err;
>  
> +	/*
> +	 * Some components may not use capablities or their
> +	 * implementation is optional. A component register block may
> +	 * not be present then and component_reg_phys is therefore
> +	 * unset. Instead run the check later when setting up the
> +	 * capabilities.
> +	 */
> +	rc = cxl_port_setup_regs(port, component_reg_phys);
> +	if (rc && rc != -ENODEV)
> +		goto err;

I would prefer to unwrap some of the levels and just do:

        port->comp_map = (struct cxl_register_map) {
                .dev = &port->dev;
                .reg_type = CXL_REGLOC_RBI_COMPONENT;
                .resource = component_reg_phys;
                .max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
        };

        if (component_reg_phys != CXL_RESOURCE_NONE) {
                rc = cxl_setup_regs(&port->comp_map);
                if (rc)
                        goto err;
        }

...earlier inside of cxl_port_alloc() since that part is common to all
ports. Then the confusing comment becomes unnecessary because it is
clear that CXL_RESOURCE_NONE is an acceptable case.

Other than that, the approach and rationale looks good.
