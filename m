Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA46725BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbjFGKnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjFGKnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:43:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAFAA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:43:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 357Ah5Zk113481;
        Wed, 7 Jun 2023 05:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686134585;
        bh=Qcz8DifrMVl6LnMzgJBxNEBKYKPqirKpYcU7aJJsXzE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xye/ZWHEl9jum62rp7w92Re4ownrpd5UP7zdoxG6cDo+H7Pfaxol853AVgOurwpuz
         KVYFpN/uPfYY3wuzBsPwotftiJPP19Nnky9+U6JvQv95xvWPYv76Q9DLexz8/gAMSj
         i+GbsANZw229ZfhFa0I/AuKS1PfjXFLf23vkrzw4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 357Ah4Hh003163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 05:43:04 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Jun 2023 05:43:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Jun 2023 05:43:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 357Ah4In078118;
        Wed, 7 Jun 2023 05:43:04 -0500
Date:   Wed, 7 Jun 2023 05:43:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Thejasvi Konduru <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Fix the silicon revision misprint
Message-ID: <20230607104304.iengykppptr3fxe6@reflected>
References: <20230607080349.26671-1-t-konduru@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607080349.26671-1-t-konduru@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:33-20230607, Thejasvi Konduru wrote:
> For J721E PG1.1 the silicon revision is reported as 2.0 instead of

There is no PG1.1. There is SR1.1

> 1.1. This is because the k3-socinfo.c code assumes the silicon revisions
> are 1.0, 2.0 for every platform.
> 
> Fixed this by creating a separate list of silicon revisions for J721E.

what we are doing is to add to the silicon revision detection.

> 
> Fixes: 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")

This is'nt a fixes.

> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
> ---
>  drivers/soc/ti/k3-socinfo.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index d15764e19d96..365bc37793a1 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -46,6 +46,8 @@ static const struct k3_soc_id {
>  	{ 0xBB8D, "AM62AX" },
>  };
>  
> +static char *soc_revision_j721e[] = {"1.0", "1.1"};
> +
>  static int
>  k3_chipinfo_partno_to_names(unsigned int partno,
>  			    struct soc_device_attribute *soc_dev_attr)
> @@ -61,6 +63,21 @@ k3_chipinfo_partno_to_names(unsigned int partno,
>  	return -EINVAL;
>  }
>  
> +void
> +k3_chipinfo_silicon_rev(unsigned int variant,
> +			struct soc_device_attribute *soc_dev_attr)
> +{
> +	const char *family_name = soc_dev_attr->family;
> +	int j721e_lookup_arr_size = ARRAY_SIZE(soc_revision_j721e);
> +
> +	if (!strcmp(family_name, "J721E") && variant < j721e_lookup_arr_size) {
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s", soc_revision_j721e[variant]);
> +	} else {
> +		variant++;
> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> +	}

I am not comfortable with if else here. Why not extend k3_soc_id
structure to include the variant LuT? Are there exceptions to this rule
(Say AM65x?), those would make sense to handle with a compare against
the partno?

> +}
> +
>  static int k3_chipinfo_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
> @@ -92,7 +109,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  
>  	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>  		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
> -	variant++;
>  
>  	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>  		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
> @@ -101,17 +117,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>  	if (!soc_dev_attr)
>  		return -ENOMEM;
>  
> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> -	if (!soc_dev_attr->revision) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
>  	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>  	if (ret) {
>  		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
>  		ret = -ENODEV;
> -		goto err_free_rev;
> +		goto err;
> +	}
> +
> +	k3_chipinfo_silicon_rev(variant, soc_dev_attr);
> +
> +	if (!soc_dev_attr->revision) {
> +		ret = -ENOMEM;

-ENOMEM? I dont see a alloc in the changes.

> +		goto err;
>  	}
>  
>  	node = of_find_node_by_path("/");
> -- 
> 2.40.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
