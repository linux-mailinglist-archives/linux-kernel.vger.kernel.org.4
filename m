Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74E611A89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJ1S44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1S4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:56:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83A1ABA3B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:56:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SIumrX080897;
        Fri, 28 Oct 2022 13:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666983408;
        bh=d0Fa/qSkmZVddvA/MazQq0F2Vsj9eLc7Jjdg60CK2Hw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=H6KLNGekoLRw4R4gK4RAhjzY60wkx7jHp69mLpWaDTxk0RiCrrvioGp1JwrJ1kD7N
         f0KuG+RayBiEy7h2pRUyH6zCm4g/5ZJgEP0OMwKnj+WrkFlHCNkNFlyz426d/IbGz6
         /P59N+YB3byGqhOzD48dTwW/Bky3JmSyB9oZP6fI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SIumac082951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 13:56:48 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 13:56:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 13:56:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SIumIG017861;
        Fri, 28 Oct 2022 13:56:48 -0500
Date:   Fri, 28 Oct 2022 13:56:48 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Nicolas Frayer <nfrayer@baylibre.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <khilman@baylibre.com>, <glaroque@baylibre.com>
Subject: Re: [PATCH v3] soc: ti: Convert allocations to devm
Message-ID: <20221028185647.d74ncedmocfbr2s4@debating>
References: <20221028180033.606362-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028180033.606362-1-nfrayer@baylibre.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:00-20221028, Nicolas Frayer wrote:

Quick cosmetics:
linux-arm-kernel@lists.infradead.org (moderated list:TI KEYSTONE MULTICORE NAVIGATOR DRIVERS)
is part of the results of get_maintainers.pl  why drop not CC it?

 git log --oneline drivers/soc/ti/k3-socinfo.c
soc: ti: k3-socinfo:

Please fix the $subject

> Changed the memory and resource allocations in the probe function
> to devm. Also added a remove callback.

Yes, but why are we doing this change, what benefit do we get by doing
this change?


> 
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---
> 
> v2->v3:
> dropped module conversion part of this series while other driver dependencies
> on socinfo are worked out.
> A dependency issue is introduced by changing subsys_initcall()
> to module_platform_driver(). Some drivers using the socinfo information probe
> before the socinfo driver itself and it makes their probe fail.
> 
> Dropped series:
> https://lore.kernel.org/all/20221010131538.7333-1-nfrayer@baylibre.com/

OK - if we are'nt going to convert this into modules, then is there a
reason for this patch?

> 
>  drivers/soc/ti/k3-socinfo.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index 91f441ee6175..19f3e74f5376 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -96,21 +96,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>  		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
>  
> -	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
>  	if (!soc_dev_attr)
>  		return -ENOMEM;
>  
> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> -	if (!soc_dev_attr->revision) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "SR%x.0", variant);
> +	if (!soc_dev_attr->revision)
> +		return -ENOMEM;
>  
>  	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>  	if (ret) {
>  		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
> -		ret = -ENODEV;
> -		goto err_free_rev;
> +		return -ENODEV;
>  	}
>  
>  	node = of_find_node_by_path("/");
> @@ -118,22 +115,26 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  	of_node_put(node);
>  
>  	soc_dev = soc_device_register(soc_dev_attr);
> -	if (IS_ERR(soc_dev)) {
> -		ret = PTR_ERR(soc_dev);
> -		goto err_free_rev;
> -	}
> +	if (IS_ERR(soc_dev))
> +		return PTR_ERR(soc_dev);
> +
> +	platform_set_drvdata(pdev, soc_dev);
>  
>  	dev_info(dev, "Family:%s rev:%s JTAGID[0x%08x] Detected\n",
>  		 soc_dev_attr->family,
>  		 soc_dev_attr->revision, jtag_id);
>  
>  	return 0;
> +}
> +
> +static int k3_chipinfo_remove(struct platform_device *pdev)
> +{
> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
>  
> -err_free_rev:
> -	kfree(soc_dev_attr->revision);
> -err:
> -	kfree(soc_dev_attr);
> -	return ret;
> +	if (soc_dev)
> +		soc_device_unregister(soc_dev);
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id k3_chipinfo_of_match[] = {
> @@ -147,6 +148,7 @@ static struct platform_driver k3_chipinfo_driver = {
>  		.of_match_table = k3_chipinfo_of_match,
>  	},
>  	.probe = k3_chipinfo_probe,
> +	.remove = k3_chipinfo_remove,
>  };
>  
>  static int __init k3_chipinfo_init(void)
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
