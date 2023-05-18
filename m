Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94B4707D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjERJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjERJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:38:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D131726;
        Thu, 18 May 2023 02:38:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QMPxL5Pc4z688hZ;
        Thu, 18 May 2023 17:36:22 +0800 (CST)
Received: from localhost (10.126.175.163) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 10:38:12 +0100
Date:   Thu, 18 May 2023 10:38:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/pci: Update comment
Message-ID: <20230518103811.000015e9@Huawei.com>
In-Reply-To: <20230426-cxl-fixes-v1-2-870c4c8b463a@intel.com>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
        <20230426-cxl-fixes-v1-2-870c4c8b463a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.163]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 14:28:11 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The existence of struct cxl_dev_id containing a single member is odd.
> The comment made sense when I wrote it but could be clarified.
> 
> Update the comment and place it next to the odd looking structure.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index f7a5b8e9c102..ad7a1276fdc5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -469,6 +469,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +/*
> + * Threaded irq dev_id's must be globally unique.  cxl_dev_id provides a unique
> + * wrapper object for each irq within the same cxlds.
> + */
>  struct cxl_dev_id {
>  	struct cxl_dev_state *cxlds;
>  };
> @@ -506,7 +510,6 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
>  		return -ENXIO;
>  
> -	/* dev_id must be globally unique and must contain the cxlds */
>  	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
>  	if (!dev_id)
>  		return -ENOMEM;
> 

