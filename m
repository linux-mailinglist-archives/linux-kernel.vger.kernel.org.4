Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAA5EEB95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiI2CSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI2CSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:18:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE81123869
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664417911; x=1695953911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3C7CtpOb0l54DwObhkR3R54ov4xRYh0NR5cxz71mUVw=;
  b=UncAMXmRVUQ2PZkR8vXPmBxt58asxjgdN7G0RBgq2chnhR0SvilFp+VZ
   Lnipzsbk8arT1Z5SiUdljgg4Rqsxxqlwma4X2o4oZBuUhLwf8ZqeVTatY
   DKW2ZVBJsRocegpFqyowBpaV83Z+OvG4J0oKIOid3xvWcB4DiEc3JJPrU
   44LRJfpYe5UTx2TDDey9y44D014ySEG+QGzvaEGKk/wQ3WZMf0Hto/tbw
   q7X0J88a9uOHDDQSO49RUlGbElsa79V2+oUPLkFb3+etW6cjBfAQ3PEdB
   PfP1N66dbpL07Q/V+VdoSJqUrMfV6363qd5+Zsw6eFvmVhpRD+9h7bL/J
   A==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="212947462"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 10:18:30 +0800
IronPort-SDR: lNAXpVL/tXsASWKd6pQOM+qAWjNsvhGlJudcAXuMdSZgI+mezSVr5Kc8RhppIJ8/JmfDw4JTxs
 olTXibJBONVD6Jyl5ZC5HIt4fM9JAq1d5ZTxFRl75yZvj8MSdiZH0umkc49QADrXw7id44zyp9
 3ckcO9+Rvejl9nf0pxOZ46K7zKHQG21wa3IGuK/JnBCbdQNuseNTUayNZRNuD06IiuG2AmRJ6E
 jPZ75VJr+hPLTdRKMKQCosQuEMRZ4kEtUbZQqXz/j/S3a4cR/Iudt8+a7J4S+VHBek9Y8yQ4tH
 qbzn+20LbFm8Phfht8UJK/PY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 18:38:25 -0700
IronPort-SDR: /Wm5ASEt4XWaPksdY7wvZ+h1EGkEmhVFL1FrRI/WGlgI9K0WSH8kBeS76MKxOy9MgoliZwWVCm
 yQEf/Gk+MZL3k7i/UAqpXmgm+IXeD3bSarpkHCZuTZQ2+z82vf2CaF44RIIwhqvFBhQh2Z7xeT
 NPsqAripytFtii3gjD7Vt4epPkJEAqbFFKYisHiOTrOXzpWSQVR7bTIWfdLYLzs3FqK2JuWNGv
 MRnHaPJk/5yNBhJ5Bpy8F4SHONS7BEgzVj3ME9hV4UvsJLwb8yBIzUxy7fRYKnLOhsycoUdTz7
 cc8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 19:18:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdH8k1J1pz1RwtC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:18:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664417909; x=1667009910; bh=3C7CtpOb0l54DwObhkR3R54ov4xRYh0NR5c
        xz71mUVw=; b=tI8DR50vqiC2j/8wIJUjpJtRnK6KvK0GZRlw1aE9mmaLzwCxePb
        B8tLvpChjjEk1TM47jRMKRN7PHaptnNscM/v3sD8VaV8O5iXTqH7zjB3nrkwj5Qj
        GUGfrTvG7LsGU0CQMU4L/npcc1Ya3plbh9wScKz/cvgnJfzZbL505M38pHSPXDCU
        AuA8IxWMUNWPQKclYSM2TwB4+rCp4jYBilSftkl2jN9JFizDbwCIuTRjjiim21qz
        CVgo/Fuhl5WaAzjZ5/HQmth6Fa2VcN9YHiK3B7Fqr2QBytPaJ5diQJLLpZ79DQSs
        nn2ou/6Utx4fZi++LqYtX7blKc1/rPw2nAA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zBplLxIyU4V6 for <linux-kernel@vger.kernel.org>;
        Wed, 28 Sep 2022 19:18:29 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdH8h010vz1RvLy;
        Wed, 28 Sep 2022 19:18:27 -0700 (PDT)
Message-ID: <f2c1bfa1-536b-7214-f997-b360d6db3207@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 11:18:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 5/6] scsi: mvsas: Delete mvs_tag_init()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, hch@lst.de
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-6-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1664368034-114991-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 21:27, John Garry wrote:
> All mvs_tag_init() does is zero the tag bitmap, but this is already done
> with the kzalloc() call to alloc the tags, so delete this unneeded
> function.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/mvsas/mv_init.c | 2 --
>  drivers/scsi/mvsas/mv_sas.c  | 7 -------
>  drivers/scsi/mvsas/mv_sas.h  | 1 -
>  3 files changed, 10 deletions(-)
> 
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 2fde496fff5f..c85fb812ad43 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -286,8 +286,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
>  	}
>  	mvi->tags_num = slot_nr;
>  
> -	/* Initialize tags */
> -	mvs_tag_init(mvi);
>  	return 0;
>  err_out:
>  	return 1;
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index a6867dae0e7c..0810e6c930e1 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -51,13 +51,6 @@ inline int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out)
>  	return 0;
>  }
>  
> -void mvs_tag_init(struct mvs_info *mvi)
> -{
> -	int i;
> -	for (i = 0; i < mvi->tags_num; ++i)
> -		mvs_tag_clear(mvi, i);
> -}
> -
>  static struct mvs_info *mvs_find_dev_mvi(struct domain_device *dev)
>  {
>  	unsigned long i = 0, j = 0, hi = 0;
> diff --git a/drivers/scsi/mvsas/mv_sas.h b/drivers/scsi/mvsas/mv_sas.h
> index 509d8f32a04f..fe57665bdb50 100644
> --- a/drivers/scsi/mvsas/mv_sas.h
> +++ b/drivers/scsi/mvsas/mv_sas.h
> @@ -428,7 +428,6 @@ void mvs_tag_clear(struct mvs_info *mvi, u32 tag);
>  void mvs_tag_free(struct mvs_info *mvi, u32 tag);
>  void mvs_tag_set(struct mvs_info *mvi, unsigned int tag);
>  int mvs_tag_alloc(struct mvs_info *mvi, u32 *tag_out);
> -void mvs_tag_init(struct mvs_info *mvi);
>  void mvs_iounmap(void __iomem *regs);
>  int mvs_ioremap(struct mvs_info *mvi, int bar, int bar_ex);
>  void mvs_phys_reset(struct mvs_info *mvi, u32 phy_mask, int hard);

-- 
Damien Le Moal
Western Digital Research

