Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B36B85CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCMXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCMXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:02:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298F1025F;
        Mon, 13 Mar 2023 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748487; x=1710284487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HJS7XnLxwuElRmE8BYNgt05CMPQBJzQAudJR45nUDi0=;
  b=egc7sxU17eotLNztr7zcDNSSt6/ij1LokzFVr1TSIrLPnOuAjh65erCc
   xLvWnvGs2ZIP9l1tcIxKBpQVxqoOmXrPS6l3hgLNFDQX0QCNEBkANGscY
   IONS4cGwVSROnNsd+1/hU9OOtj8VqdszGaeu8uPCxIvS/ZNIudJI7vL/b
   QuBg6qD0bWfArDK1mCBkj7nYNlHm2T205fSySaKpPEwG76QOpwIQZCh5B
   HXtseoyfSrdmew+Rt9slbPZhSMAhNWOqoFND3UVCZjp+wjNMS7DLSmgpy
   XS0v1HFIC7cdLJViEpJbh3XeGPGbu5Fe521XymEHfnya7W1ZfV2ozfC24
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337303999"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="337303999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="924680052"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="924680052"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2023 15:56:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:56:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:56:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1AkygQ6GHnH4FvM2tyC1FjyYQBxi2calHeMTBWHU8nG114JgOhtMNaG+4+bTAzOxr8iR+DBSbssBmSLOqJLc/ecnxu3gkG8NMUHoYU8qidoJuQOVPZJQq7/DLxO62pX34rfyHexjU6rJAFebvOczIh0oMV668ewBXVgQIANQWcg1qV6BVbPsJ27j4N4mFvO4GIrXMySIGLkV3zwwXZbL+2BJ0UkVwGBfMIIsfxVAfy9kkFkFkBZ7T/dQh7L8zZpiHAi4/lLlV8aLask+VraOwy3ubDyshc6096g5jzqI7MPYkzDilwSAIfJeyGP9LdeTW1HhHTCnMmzZRWw0IKYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/x191sWqlSDBQ0rZX07kohrdRlzycw81Kwt5UFyPDw=;
 b=YjOQd1dmmleQoKn9yGF5EdrU3X+4DjnoyOFN1diNRgtOQQs88G4LhH0y4CNb2WduOV57nr2QmPjuqfYSOTNA1WUPu8ptNSSWeEgP5qbOZMgsBh2f1NvgSB7mBeIiuyjW24oW/LTTRMCceO479V3qSLAtld3YpgV/F8M7QvEai1KGYtvNyGzJWmoWjwX8SbFAQIUsu/udpQOdnnxGom6kgApt+js8GCtVlCWLV6j9fcRUb6TJtQylE+EZ9mtrpSyg6PycMB4e/GGaWTOIzK+EDDTpV5bQKwEGRP9xWvjcvSGPsv+CpoJXCzSo4+AFUtLRheyAv5M+G3FnfOTKETkZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 22:56:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:56:31 +0000
Date:   Mon, 13 Mar 2023 15:56:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8 5/6] cxl/trace: Add an HPA to cxl_poison trace events
Message-ID: <640faa1bde61c_22c07f29431@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <b784c7320da183bca8b2c0c0346f3006d88bc4aa.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b784c7320da183bca8b2c0c0346f3006d88bc4aa.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8439d3-69eb-442c-90d2-08db24162fbb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90XUXoxwT0i7g/eO1qqE8+SeQgb1byPRUfCVY0Q4IBMtqZgjII2p4ZMslc/ZBEzsT62b++JiE3bl261C9FklGpQkiXj1HXsIEKIxZC1/maqvnr497QRPW4PlgH8vT/h+5lycyj7hkfW4ovnT4TmrJOKUrnu4AZl6E9PTzHM2I/iCUoPB7j3f8+OVBMWu352BOy0o1NEbsE8aEl7P6H2SHOr6D+OVDZBPZ2y1hAlTStcaMxy4sgbBR9NlVB2S4U6IClgx1fbTTIT6CjnMaRqVImKWUMralvEV3Rjb673Q5BwxQszcSw6Q8RKBRSyRjRQf2y3EtdxeSspyzIgHiursOgHn1sB4rdtxe/3waClrwVqsPCdyinBP69pI15+D7s3L3IasB2npODWq/UdIeLh+KDGxleASmGJWfal04vXf3Vq3WS86Y0bG3mky9ihW2G0OVIrsAC0vhBx89ZUu/B8T2BHCqQveImK82TG882CDwbDClBxbpj+KX+yYbIl8reoPZZy+usdhpYDGZbirxvHM1Ev3PJsWUcA2VEkv+MCasag0JGK+0k+5GHmUzcEDaH52YCDowPHLgKyDe4J7hzJ0wzp556YtIQ1G6LSm2dz1F/7Ge0XAx7bp7QxCsthkPmq3bFJcofshwjIsqG3Z/ndVOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(186003)(9686003)(6512007)(26005)(44832011)(6506007)(83380400001)(8936002)(6666004)(82960400001)(38100700002)(5660300002)(6486002)(66556008)(66476007)(2906002)(4326008)(8676002)(66946007)(41300700001)(54906003)(478600001)(316002)(86362001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kFhRUTWg2v/TCxngJRf4Um9Od76luY8NG8fBbh9PbQNuvkWTs7RMQtNcq/i?=
 =?us-ascii?Q?IHseCCVRf7MBk3UBecYLUiwD6G3wTMA7LKqKIbaQ91UImDE8HkPca3/c+gBf?=
 =?us-ascii?Q?qaHTIxaQerzCBIPPrZPXVbKXtXrptl4yPIrQou0pjVZussGxSZuusPWxKp1r?=
 =?us-ascii?Q?urphWr1vfAfEp6GXY66AB2FO10if2eG0+RjG4JUPRMWAtP9Hy37NZKpIdlLw?=
 =?us-ascii?Q?11dYB5jhcGcNXkReL7voT9TAH4Tk5joppi1TW6t1qj8tzHw1d/XzcqylTBZ0?=
 =?us-ascii?Q?4Y0ewvXsTyD2fxN6GBjWT33HcCYtwesZD32sBz/uuXSFZUPabtABMmgdArzk?=
 =?us-ascii?Q?/4crC6B6I3Pwi/VUw8aRq6a7CraQ9W5hyEUlwU3w9wKDYPtOp+pdRL4o/xfj?=
 =?us-ascii?Q?k9D9SpAZUgXK72/EKXHYITCwISj/glZogKYfeVY9A+pNRUAIairWZFuS8Msi?=
 =?us-ascii?Q?A0xeYCwpNXFFhA31bfpNGqAwgI8kgjPHyix35qrAEdphlWTuPEifmD2DkpvW?=
 =?us-ascii?Q?B9rV57YJBhIOZLZISfGFIJ8QyksH6i7Om22Tu9j+ILyEaddJMzHNMBtQBMhv?=
 =?us-ascii?Q?yugz8LM+dObqxKLCVZf8J//dY0w8+ANbPG2nqpYxYSJy4vDdLTRhpBMy56fi?=
 =?us-ascii?Q?/Wzv3EmWZcDay4qVbqr/bkl03Mm+y2zH+1zc4ZkitNnr/TILcaDclJ/Mvbob?=
 =?us-ascii?Q?Hn5cbEylpeA7lQgRYvkuvEZiaBJo02+8TkQo4owUPAum9e40MRUmiiGJy3ek?=
 =?us-ascii?Q?qpBNaQYIkZfmRzJEakuc6A/voLPecuaww4l3FjTHvrYULcA5ezaJ5ss12i8o?=
 =?us-ascii?Q?d5LN6xDMDp8gTh8e9hnmgsCEvyE08cUA2aO3F4bPYITU1lVjKDJBaTNAAkDT?=
 =?us-ascii?Q?dctz+SChRpyk2XhqbhsijNyRbAkDHl4LGwfuk5bGQfVaTcQezgyGyryTEtff?=
 =?us-ascii?Q?2NlYPwqlHmNj7ZXqCcvYksOi4AbCCq9JpF4YBA/X2fzAMKEs/1PLR9EX3bmF?=
 =?us-ascii?Q?P8PowFZWiAtws92Ut3msmjF7DCJ6ugvfhoDgVZU35WxWV/IeAm/xSKjfrQUC?=
 =?us-ascii?Q?pjOK37vhOu0Bc21MxuFkDU4lvH2Fw0P6bKKTJUJCF/qflqv5u0YtveEIyTgk?=
 =?us-ascii?Q?WOq/fqB2abFokatTUK/Vfb7t/j+spcjrG5EfhQrY/tYdKTOdV4Kn+ZSm9Tnu?=
 =?us-ascii?Q?6mw3Ny6W3eRMbTD6BwC6snnb7FAMax2FuLAilbdkZGSRFPhw1MGSZ1Wuic06?=
 =?us-ascii?Q?qDwc14h8BeyITDcpfKjykoOQ1vImU6ybjMkDd3lhMA/aZ1YEuNFDZgKjm+EL?=
 =?us-ascii?Q?U/9JIotmjQC3Lwx+hvqKkffytAJqpTJ34cSuygazP1lHWNI5NuSjA/94aHTb?=
 =?us-ascii?Q?YJ2Pq3xtWH+zK7Cl6qH9MP72/E9fV2fQbEK3uniS79J0zCNS+BaB0qSf3lwv?=
 =?us-ascii?Q?bZ92+GbwIZozs87M4iFXBKwo9sSmilOY4ph9VUh8/SjYlyIoJ5mZEf0YwhWx?=
 =?us-ascii?Q?/wte8RO+gW493EQFMcyz550IODNeP3MRoiFtdAqauCm61gJR7tsencmowIrm?=
 =?us-ascii?Q?391NrtfTA8fg0DnJFsW9Lk4IwghZbDS7gGHFPCNe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8439d3-69eb-442c-90d2-08db24162fbb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:56:31.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNIKZ4s2UCvytcbU3Svn8w2h/yhl+fumDyF6no1w6Gb7bM5FGh3G55ApU5TAACiwqB5veg01ZD7LI66J0LUrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a cxl_poison trace event is reported for a region, the poisoned
> Device Physical Address (DPA) can be translated to a Host Physical
> Address (HPA) for consumption by user space.
> 
> Translate and add the resulting HPA to the cxl_poison trace event.
> Follow the device decode logic as defined in the CXL Spec 3.0 Section
> 8.2.4.19.13.
> 
> If no region currently maps the poison, assign ULLONG_MAX to the
> cxl_poison event hpa field.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h |  9 +++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 29ae7ce81dc5..d0403dc3c8ab 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -1,5 +1,99 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
> +#include <cxl.h>
> +#include "core.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> +
> +static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int gran = p->interleave_granularity;
> +	int ways = p->interleave_ways;
> +	u64 offset;
> +
> +	/* Is the hpa within this region at all */
> +	if (hpa < p->res->start || hpa > p->res->end) {
> +		dev_dbg(&cxlr->dev,
> +			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> +		return false;
> +	}
> +
> +	/* Is the hpa in an expected chunk for its pos(-ition) */
> +	offset = hpa - p->res->start;
> +	offset = do_div(offset, gran * ways);
> +	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
> +		return true;
> +
> +	dev_dbg(&cxlr->dev,
> +		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
> +
> +	return false;
> +}
> +
> +static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
> +	struct cxl_region_params *p = &cxlr->params;
> +	int pos = cxled->pos;
> +	u16 eig = 0;
> +	u8 eiw = 0;
> +
> +	ways_to_eiw(p->interleave_ways, &eiw);
> +	granularity_to_eig(p->interleave_granularity, &eig);
> +
> +	/*
> +	 * The device position in the region interleave set was removed
> +	 * from the offset at HPA->DPA translation. To reconstruct the
> +	 * HPA, place the 'pos' in the offset.
> +	 *
> +	 * The placement of 'pos' in the HPA is determined by interleave
> +	 * ways and granularity and is defined in the CXL Spec 3.0 Section
> +	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
> +	 */
> +
> +	/* Remove the dpa base */
> +	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +
> +	mask_upper = GENMASK_ULL(51, eig + 8);
> +
> +	if (eiw < 8) {
> +		hpa_offset = (dpa_offset & mask_upper) << eiw;
> +		hpa_offset |= pos << (eig + 8);
> +	} else {
> +		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
> +		bits_upper = bits_upper * 3;
> +		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
> +	}
> +
> +	/* The lower bits remain unchanged */
> +	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
> +
> +	/* Apply the hpa_offset to the region base address */
> +	hpa = hpa_offset + p->res->start;
> +
> +	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
> +		return ULLONG_MAX;
> +
> +	return hpa;
> +}
> +
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
> +		  u64 dpa)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = NULL;
> +
> +	for (int i = 0; i <  p->nr_targets; i++) {
> +		cxled = p->targets[i];
> +		if (cxlmd == cxled_to_memdev(cxled))
> +			break;
> +	}
> +	if (!cxled || cxlmd != cxled_to_memdev(cxled))
> +		return ULLONG_MAX;
> +
> +	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
> +}
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 33a22d26e742..25dbf52ac327 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -631,6 +631,8 @@ TRACE_EVENT(cxl_memory_module,
>  #define cxl_poison_overflow(flags, time)				\
>  	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
>  
> +u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> +
>  TRACE_EVENT(cxl_poison,
>  
>  	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> @@ -645,6 +647,7 @@ TRACE_EVENT(cxl_poison,
>  		__field(u64, serial)
>  		__string(region, region)
>  		__field(u64, overflow_t)
> +		__field(u64, hpa)
>  		__field(u64, dpa)
>  		__field(u32, length)
>  		__array(char, uuid, 16)
> @@ -664,18 +667,22 @@ TRACE_EVENT(cxl_poison,
>  		if (region) {
>  			__assign_str(region, dev_name(&region->dev));
>  			memcpy(__entry->uuid, &region->params.uuid, 16);
> +			__entry->hpa = cxl_trace_hpa(region, cxlmd,
> +						     __entry->dpa);
>  		} else {
>  			__assign_str(region, "");
>  			memset(__entry->uuid, 0, 16);
> +			__entry->hpa = ULLONG_MAX;
>  		}
>  	    ),
>  
> -	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> +	TP_printk("memdev=%s host=%s serial=%lld region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
>  		__get_str(memdev),
>  		__get_str(host),
>  		__entry->serial,
>  		__get_str(region),
>  		__entry->uuid,
> +		__entry->hpa,
>  		__entry->dpa,
>  		__entry->length,
>  		show_poison_source(__entry->source),
> -- 
> 2.37.3
> 


