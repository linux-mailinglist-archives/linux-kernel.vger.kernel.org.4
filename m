Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA961707454
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEQVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjEQVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:32:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155695B9C;
        Wed, 17 May 2023 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684359160; x=1715895160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ALP6q/HBXLESbOsVUZityYDExia8gEAKg2M7phXtEn4=;
  b=dTCfUhi3qt80In2KQaYOZZGOrHX3igg+BRf7K1ShR5ckkrO9U+l/qdl0
   rjY9uWCgX9Tfz00ir/w6h9LzsPMndX3LLl4tOWb86zNiDcGN+2nqHF8lE
   pvSaHu9e0FEqeFEt3R2DxzTKOHCdPUxEtedtX7lQ06bo0rLJyMYJIkIbw
   E0WYccgpcFLiCyFPZnkUwj16HvENK5F1tadJvKuFVYN9U6uFwf5EOETKR
   cMUlDwUvQ4nZ+3xon8ZJkCrEDGlcX9YFQU9G13YCVhJOcuE45sISJyccR
   8aVB7N67UlnoBeWd56mFK63nDAGmkXgCrOi2XsYl0XRV2oGwhgLUxiYxl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341275599"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="341275599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="846230632"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="846230632"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.83.61]) ([10.212.83.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:32:37 -0700
Message-ID: <5442f2af-ac58-e52f-0083-a3b1222f7e7c@intel.com>
Date:   Wed, 17 May 2023 14:32:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] cxl/pci: Update comment
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-2-870c4c8b463a@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230426-cxl-fixes-v1-2-870c4c8b463a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 2:28 PM, Ira Weiny wrote:
> The existence of struct cxl_dev_id containing a single member is odd.
> The comment made sense when I wrote it but could be clarified.
> 
> Update the comment and place it next to the odd looking structure.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f7a5b8e9c102..ad7a1276fdc5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -469,6 +469,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>   	return 0;
>   }
>   
> +/*
> + * Threaded irq dev_id's must be globally unique.  cxl_dev_id provides a unique
> + * wrapper object for each irq within the same cxlds.
> + */
>   struct cxl_dev_id {
>   	struct cxl_dev_state *cxlds;
>   };
> @@ -506,7 +510,6 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>   	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
>   		return -ENXIO;
>   
> -	/* dev_id must be globally unique and must contain the cxlds */
>   	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
>   	if (!dev_id)
>   		return -ENOMEM;
> 
