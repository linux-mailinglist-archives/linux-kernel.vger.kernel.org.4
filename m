Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DB5EB792
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiI0CXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiI0CXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:23:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2CA6C2F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245396; x=1695781396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CcydczoRB1wShpaonoeda496cVy8GQEVlia89fuRyPU=;
  b=Z4W/lf4/FFqIrzQfu/sE0RDjx9qW4qX7vXvq23ZRRHNITIqodHWvoDhq
   W4qSkU+VaGyMA+0TK9xN1Kk4VTc6lW5fWuAZhZ8uktNhZ/u5Dilb97KI1
   T/1KrYhxUfvhj8PhLrNsF4QkLHcmT54XzQ38fM+b/uLwYLa5GC23PjqDn
   Byvo6XVahZRNWHSQ4RLXABcG/jqB7itWwP0g7iXUfb/Cz8+M79GQiNGNL
   P+mrD5KZFnSgtzltak6F4rigzfaZX/K1WBoTzG8KCPpvGA0m24o+AO/1m
   JW/S6I0SxID0hG+iUJ+LP5fK/0iPStyQ6qCjn5/lwgOkpIM3gMr5G8kTt
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="210704490"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:23:14 +0800
IronPort-SDR: bI7NtMaw2YkKbjFQABgEDnNhMMYA6b8uBAAwU9z85PtRZaSZCyo25OlAT0HGpSFvn3Ft3dPWGd
 WPAiDw4aWy5a0InN/sMurKtx2aaKYShJe2It89odvDsWNkFTWNOfsHldmMY+mMC/wrwEWOj6Ag
 ba8YPLATNU0jvKzKPJqYCrXZhPFh2LibxBgXMJECxPevOGlOuEQ0pJIMZfpjMFftHbLq0UH5Q9
 dSOh+X9HDGKWESgzefiziChRuwWbdBiFs8G+6fM5Egjo6tEyTtOYiOSdcmDMOKlESmZdQ1mRnb
 Bjd+SaG2Qbdt793fbYUhtnkO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:37:40 -0700
IronPort-SDR: TSdCl4g6FtqvlNtAznOAiXM9fwUi9CkqOCfBRyTvM+cwfEPaQpMifEQQD+62H5kSwq1XBEXf1L
 UjI26z5P9ioT6+LIklUtzjFM/mmLvNmXoGSG6wTvIpuMOXXIbvVxCCx4qK+CXRqBMyt9oI1y4h
 oa3GI6yvhNgbDatIL15LmgAOYHwq+n1ua9+1YziXv+0aMcE7IXhP0QrpGNHe8SJP03uTceFiu+
 nwcBRMVKV48fzz2v4DmWNG1TPBlt79RalHhPS0e4yiGEgQTbw4dT68DH5LpnSPkX67tX39o5xw
 6ls=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:23:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3M54zx4z1Rwrq
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:23:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245393; x=1666837394; bh=CcydczoRB1wShpaonoeda496cVy8GQEVlia
        89fuRyPU=; b=RCASez9hpIQxk/TENgJZvKTUug33qAtamS/J2XKyOWc6AY4zRSI
        aXJKuwZFPmm5fXHUqgk94P6tJPgBk69ITciOJb9GawXxZuh4FNrmXbb2Yo9wnFRb
        auFtFqPj89AP/qRhHGuKH7+wcjXv6Kzr1mupQRbC2yui9FyIgw2CcGbbQ8oG1wXK
        V2LuxpcmnhJLyGPaIhrnZdcwiCKTiTed9fnpgMFH45F3kNr/MOs0izhOQr9vrBpI
        OM9erGxUK3FwAckRO88l5wznbYpWQIZMUxhwGcdhfvYNVqaptY2T+MRozoq93HKL
        CaxeQeafB3hMZ8L5xs5NQf69mkG3IfmBnUg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2VutbCbbEwHn for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:23:13 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3M31B1rz1RvLy;
        Mon, 26 Sep 2022 19:23:10 -0700 (PDT)
Message-ID: <4e829dd7-6db3-4dbf-1b8e-9f7bb805f723@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:23:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/8] scsi: libsas: introduce sas address comparation
 helpers
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-2-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-2-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 11:29, Jason Yan wrote:
> Sas address comparation is widely used in libsas. However they are all

s/comparation/comparison

Here and in the patch title.

Other than that, Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> opencoded and to avoid the line spill over 80 columns, are mostly split
> into multi-lines. Introduce some helpers to prepare some refactor.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/scsi/libsas/sas_internal.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 8d0ad3abc7b5..3384429b7eb0 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -111,6 +111,23 @@ static inline void sas_smp_host_handler(struct bsg_job *job,
>  }
>  #endif
>  
> +static inline bool sas_phy_match_dev_addr(struct domain_device *dev,
> +					 struct ex_phy *phy)
> +{
> +	return SAS_ADDR(dev->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
> +}
> +
> +static inline bool sas_phy_match_port_addr(struct asd_sas_port *port,
> +					   struct ex_phy *phy)
> +{
> +	return SAS_ADDR(port->sas_addr) == SAS_ADDR(phy->attached_sas_addr);
> +}
> +
> +static inline bool sas_phy_addr_match(struct ex_phy *p1, struct ex_phy *p2)
> +{
> +	return  SAS_ADDR(p1->attached_sas_addr) == SAS_ADDR(p2->attached_sas_addr);
> +}
> +
>  static inline void sas_fail_probe(struct domain_device *dev, const char *func, int err)
>  {
>  	pr_warn("%s: for %s device %016llx returned %d\n",

-- 
Damien Le Moal
Western Digital Research

