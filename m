Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113E06230D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiKIQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKIQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:57:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D287AE64;
        Wed,  9 Nov 2022 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012922; x=1699548922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u3D0RLSNbYIsGHjg34R01FrZgx59Cjxh3VLs5dthDBc=;
  b=YobKjMpzbTNmo98Bivg2FIFAmFTR1uQIZLCVpqtRmssDJKuz88xu6VV6
   bgmg8QvJbh73jHcBVQKXepsbgWZKSOkK4a8KFBh5of3J3lIWMnG7KC0M0
   Po+J0UYAhoK65QE3uEo82rhwG0sPkE+eGQFx/ERy/WfS3GfzxAirHJuH7
   ZYCKo5uQ9q8vpM4kzHf/qmXXz5LJeKYwI35g3OwHJfBmpGr5WHUIgHPMA
   KLX80Ym+e6wVcq9b0qV/ymgevXeBbyVMi3agaNBUMaHwHRezYzB5desaQ
   9QMX+oUpKWaQbJboWN/hIpzp8R/Dk/5zTNgRstb5IlnRDrqVJuKuSKf3O
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="290748247"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="290748247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:55:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="779411299"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="779411299"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.115.29]) ([10.212.115.29])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:55:21 -0800
Message-ID: <edb40147-5455-525d-1758-990c3aac3859@intel.com>
Date:   Wed, 9 Nov 2022 09:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 4/9] cxl/mem: Skip intermediate port enumeration of
 restricted endpoints (RCDs)
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221109104059.766720-5-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2022 2:40 AM, Robert Richter wrote:
> When an endpoint is found, all ports in beetween the endpoint and the
s/beetween/between/

DJ
> CXL host bridge need to be created. In the RCH case there are no ports
> in between a host bridge and the endpoint. Skip the enumeration of
> intermediate ports.
> 
> The port enumeration does not only create all ports, it also
> initializes the endpoint chain by adding the endpoint to every
> downstream port up to the root bridge. This must be done also in RCD
> mode, but is much more simple as the endpoint only needs to be added
> to the host bridge's dport.
> 
> Note: For endpoint removal the cxl_detach_ep() is not needed as it is
> released in cxl_port_release().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>   drivers/cxl/core/port.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d10c3580719b..e21a9c3fe4da 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>   {
>   	struct device *dev = &cxlmd->dev;
>   	struct device *iter;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
>   	int rc;
>   
> +	/*
> +	 * Skip intermediate port enumeration in the RCH case, there
> +	 * are no ports in between a host bridge and an endpoint. Only
> +	 * initialize the EP chain.
> +	 */
> +	if (is_cxl_restricted(cxlmd)) {
> +		port = cxl_mem_find_port(cxlmd, &dport);
> +		if (!port)
> +			return -ENXIO;
> +		rc = cxl_add_ep(dport, &cxlmd->dev);
> +		put_device(&port->dev);
> +		return rc;
> +	}
> +
>   	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
>   	if (rc)
>   		return rc;
> @@ -1381,8 +1397,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>   	for (iter = dev; iter; iter = grandparent(iter)) {
>   		struct device *dport_dev = grandparent(iter);
>   		struct device *uport_dev;
> -		struct cxl_dport *dport;
> -		struct cxl_port *port;
>   
>   		if (!dport_dev)
>   			return 0;
