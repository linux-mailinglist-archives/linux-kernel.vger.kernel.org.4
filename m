Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21174D9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjGJPQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGJPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:16:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B615A0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689002174; x=1720538174;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nO6pdrZX7bgx/9TwoHXwSiAGaMC1oC8sBd962yaTfoU=;
  b=b1fOWaYiS2Bmt1B53O2l0iL+lDAA+xhVUF3RNNWKIyAqUtSz7lAZim3J
   Q7VqRLdfc9RznOa3ArViLHvHvS0z6guHwFxjEOhFPHuUehfEWO4W+FujT
   uyKZww1MogbsGfNdT5uQhg7euqPo/bGiXPn2MWiWkFR7NPkG9/dM17bB8
   QvS5IZAiLraL0zU4OiY9hTVn5lTsyvGHEXqk8zU3bBHr7o6NYTXr79ky7
   +ZXyHpiHLymassBwYFwcWULUrlNJMICZtQjKY7sS+9UnSvL1H1nHc3WVT
   dUfM4fHQiiMidKCDN7edqCmGZYgEaqDmQwfKnRXIwT75TsKNDG2zgtiXk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430448356"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430448356"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="724044740"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="724044740"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2023 08:16:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:16:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 08:16:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 08:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aphF9CSvyDwcDD1VemYCf+fVjrDtDmBKvbh4KCLIM3dla8hh2ULCb39HUoZRXQSKru0SsP+j/u7UVrn2H5DMnhkOZDGcHuBKBM2h0bST1mj+FP1SKpx5IMa4SpT9/9y/hc8dHDf4h4lgLtKuKehsiygFWUaxLbj90nzYApzSiVAIVHz13ESGuqLXpPmY22rrEWRIOuGkegDvj/cRWImg9Luph0gGm567eghTpuwPEMdbmEOIsnG0XACZg1AzfIAYHkk7qLpGq+XofnKJhYKN1tMrptIWQXy5zCKwrCHBImnGrnXg+2Zg0awXjmLih2HTlAyFaiJjltilGqV6/EtPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpHrFzgrKAWcrQxgIuUExYICoMpNpuaRV0fSxb7zDVQ=;
 b=E9kgSJhh6BsMoIiQidAqbwOUukLEhMZ8G2jRlj9EBbcjRM52iY3cazoGTGumiBffq37i57LY7RQrHhH8hKsSnTYIC0zLZncQK1mCWSFLuJmhrmJCr/Hg5CCzJPsg2L8gJRslBq+epCzS3j73Lwy2dWMEry6rMJ9CGR3tWn9lHPPux6hT0tMgjxuoSHbz+KZ1A4YcRcmq6df/A7St8cIQGpUACk+w+V+pPXCHZYtSxdBg0d8luydpcMRZptEzCi3K0j6ff2J5jo2fdb+fuNnN0Y2sYs2LrLqQNvsElI0BkTxJ4VKg6hjkpFv+oR1PQaOWFtR4xFZMXjzUXhw+bOeD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:16:10 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:16:10 +0000
Date:   Mon, 10 Jul 2023 08:16:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <oohall@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v3] libnvdimm/of_pmem: Replace kstrdup with devm_kstrdup
 and add check
Message-ID: <64ac20b56f0b3_ff2c929448@iweiny-mobl.notmuch>
References: <20230706085839.31145-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230706085839.31145-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b2aaa4-63ee-4380-2e07-08db81589759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gC0axTDYhWgkZA4JPotNt+kCyRAdM2C0DiOm4FJiuewRDfIQc5qVDAU7pHN9G5TGVSOAbV21Fr+JKrDYXSXsjlbJZJU192ewf2VK1qaNevQjMkBw4OdI9BszvcZFQn1Cgp9HKopL1Ye6KBdZ6zbQE48cGBDJXIHlg8shGfiY+PW3HPsJFlK5Ka88bGlx8hl8SBcaaB9rZ1ovjsyoZBbSdIRQEJB/3uKP2BrfzoasaBAyToUGU87yZN8imlnYLkBH3me8LXjvHHuMHM8w77o1PpKK1+utU78SrCWne4DHxfT0VWtfUbNT/tBaY4sjBKoudB8K3ZIDAsr7jUuJ7RtHrut+7h0s0rfLTeSUMm20wieBHxMhmQbM29hi6juN6pG1BmtxQ8MUCmviZjURbU2xYdc6YFz1Bab10WHv9d6Fj57JQNiw22m1GKNyINX/8brrC5nKi5Jbvo7vXYcfrHDj6XwbQG4LLBWYRKE37OuhUmtCKmAQ8qwIKL8D04RK9eM04YDyPVgMo1cgLkbt1BrXtrbI5HP6FCNrwibVAqXuCHln7hhwyGqOBZEajI8UAMn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(5660300002)(8676002)(8936002)(316002)(66946007)(66556008)(66476007)(41300700001)(2906002)(4326008)(6666004)(6486002)(6512007)(9686003)(6506007)(26005)(186003)(83380400001)(38100700002)(478600001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epWuPZXrSiyCDLNX9GQ/cO9A1YEOlqewIyClDBtIRKIo6H7eQgh3hMrlMT8T?=
 =?us-ascii?Q?QzK3AMadnwSl2N4MqIkXvKkf+FND8pv3ulB81pDWxo5B8CwDWsaQN4OXNKBD?=
 =?us-ascii?Q?p5H+9XawzULaC5fKglYTN8Chr0kcY6MOew+kqpIjJkEXj9CuEp09NZwC+XqB?=
 =?us-ascii?Q?Og1eUCL833t0ftXd2tEWyj6mFffGdWTMnxWyicE3PQMdQcodVfjx96KlJh7o?=
 =?us-ascii?Q?O7R946lQdo9XxTGI8hQ/1upHjKwOA7TU6vva1SjClXfrybfMQp+CMPqJXPPY?=
 =?us-ascii?Q?PPkiJExWdIuBvQtysrfyujUEe95/afe5idsr0pIO7Qd41Y2f6SiqmGD2pIs8?=
 =?us-ascii?Q?K1NaSrw4IBW/tPx4KMzwWyZkqwnYGjZkqOcyN/QFd6IArYHtSVfXLgxpRD4z?=
 =?us-ascii?Q?Y9Z7F7gSmwGzd5E7e6slk18eidbpyM2ZNYmob2e18L2SnSPx0RfMWi7+h0cE?=
 =?us-ascii?Q?8HA2R9FIIxuD6GUWEwHWI/yYVu9R2/5CJrFJNOq7JDR51zCgy+RQQpq7Dcyw?=
 =?us-ascii?Q?Zd45QrSAEC+VZftM8dN426xCo6uE1XAhXoycdNCKiFbK6VErLeE8XAVd6LiQ?=
 =?us-ascii?Q?VoQbHPNAkiwPY6kDc8fAWqN5vscfiH8/n3bbqGGfQE4emfkaw6RHeFqoyYeR?=
 =?us-ascii?Q?qpRtwDNu1U5A0HajYyF46P0XjEm1PChK/xM8GBKxQMpiCN072BvRPJBX5sj1?=
 =?us-ascii?Q?3SS6+McDexabyS0WrA+8di0CGYXIE5YpAND8SXQBp5WwvpjSdo726i8cOjbZ?=
 =?us-ascii?Q?keTHu9aUORVTTCweDU1yg9Iu2J23DkR8/4aoWCj4RSV+0JpTuJgOPOeF+xIy?=
 =?us-ascii?Q?SvjH9kV2SilXOO2JWOOXjHkIA44fY1kSM4allTnlwqsTUa6KnbhaD5/3wIMQ?=
 =?us-ascii?Q?oWltO+VBILrTqpPXPmPRbpoj/Q8BxRTds4hdfCyOjF1MTJqwoBdrtdZAs9aJ?=
 =?us-ascii?Q?oPg6GZmM2DOHEFEvblKmvEvUMqE7e8XdlB7n63+I0QFa2rrGYL5ENSTgo0gj?=
 =?us-ascii?Q?ruOLT6YapxS1Pp3uklK53cvJyW2afqB493Xen/YIPO6tLCE7jz/kOOxEZreF?=
 =?us-ascii?Q?ApdAgOiKV7Rx8khjIv7uAj0bKyWTSbAwzZqNWwJvjZL/BC6UL0TIe6pGvBP/?=
 =?us-ascii?Q?M3me42IgRdVj9bUqr5y9lwMj3dbesC8asLws/Clr+r9Y2pvh2P5JfUpUnJes?=
 =?us-ascii?Q?twnLi3o9aWvGqpXkdDBSJ2EZkHBkCJt7ka8069fY+kdcOg0JCFF/WTXl3bS5?=
 =?us-ascii?Q?VG4Lz8qh9BV00U7/agRh9E5B4hYo3xx+IR9NtPxmHlIvd3ERP/wWuoCK1/tD?=
 =?us-ascii?Q?jw3p1qNqYpUgQWXQNd6zXRnTTC5S1AAM49asZPfvM8ksM16HwCMN+wFtTpMy?=
 =?us-ascii?Q?vSILeyUvG3JwPk34MI37VXD/1aVXBrsUYBKCGuxn5/rDFCzji2YAWtCL4ilh?=
 =?us-ascii?Q?pTrkwI1w0xGu2O4exTUSCEBPj65BNEgJ9Ln8FkuCboA0XfvInMGpYjlvSguz?=
 =?us-ascii?Q?Mg9JGX1cJY9LggLLBe2uMeAdzFdTCvK3+YmjiUhq/QucoAHVjmbB3aE43DKS?=
 =?us-ascii?Q?cygHLxVTQBgEDIDtRJpFF7P8vBRYjPfFFgHYEquM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b2aaa4-63ee-4380-2e07-08db81589759
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:16:10.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUbwRNdIYn5ZgQEFSLVtLVudT8sLVxnOAvPlDoTg8OJUJHkEzWRyhMHfP8xvWd5smesdXW+j4aXnTsajcaUSfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiasheng Jiang wrote:
> Replace kstrdup() with devm_kstrdup() to avoid memory leak and
> add check for the return value of the devm_kstrdup() to avoid
> NULL pointer dereference
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

LTGM
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Correct the usage of devm_kstrdup().
> 
> v1 -> v2:
> 
> 1. Replace kstrdup() with devm_kstrdup().
> ---
>  drivers/nvdimm/of_pmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..1d2b1ab5b737 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -30,7 +30,12 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name, GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
> -- 
> 2.25.1
> 


