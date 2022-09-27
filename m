Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E765EB7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiI0Cbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiI0Cb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:31:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5AC696C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245886; x=1695781886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=maO26ivypjPINwRmECCY3/niEwSrPRX9QVMFn7Sxe24=;
  b=B96UF8u9PUwWWAamrs8QjbGYZaSX75EvvmWPHsLB0Q+PB7wbhnUhtVmA
   8xf8fSJEQmLzs/ZK3CSuARXs/AJsWIdB97Vx66bavS4jiLRUWWf2FSUU+
   6cmQhM9G+5zzEsrTx148vnabW26cr4HaMm4rplVO/ZDpaFAcSJi7XpbCW
   o3rYWY8yM7sQk7THckY58GX1Nkn2G4EoiAnN4JYt2HOUt7z8XBS78yiET
   KfZizZrs+xukUjwgTz7ogEWxtyOoo/Ujo10DpNxE3u8pgwdVhmGNwnKRw
   bTKZxqBiwDnbCzju6UeIZLZCer744AY6vPNS5mlivypSU6TpumDNjIcs5
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="212341182"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:31:25 +0800
IronPort-SDR: 0j9kXyZUFWHerWsdG23nvjGK+JS6LSFIn8eXPhIWfVd+OQDqRDE08Z1sXTylIieJN5kl3nDIaz
 4kfvm6qstefRuWxARUlr3VFJy0DvTcgzI0zlbBTVaHgXjyvAc+k8iukiuSS94NkaTNbjs0x9Bq
 240Nr+HdhiuWn7KCC0qsQI/GEvX4GkpAtUFyRN0zaYbyDWcTDycPsxMXgvsDwtb7BV0RkOY/Z1
 ug6Ogt12wxhH2bgaIvmgCLmDjttAgXPEVJUrqFlmRjO3cNgxh84b18FMSXNoyRUZ3psQRQ+QDF
 hepZAuorin7axfw/HoEgYXW7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:51:22 -0700
IronPort-SDR: 1NqMccdgp2VoIt6zCjwxiYKPnYAp3+D5INh+lIGQ80PNDSvswLKvrZ+H6avvAKl1TfLRk5kkoK
 WXtZv3ak3pLzI03CZqLEYXrRBtNbuwEwnVWMduPjTUUdD6RxYCvCbmE+lnCpXqS109moKB4Kgi
 I3NuOPaPfSzFCLM/F6JKcwqoVSNggUSGBWKuPuOE5yIZdXCDxgnXFHAVPVITRxY3sss470v3a5
 y4moEpQ035duqoy9s3Dr/bkgE1fGt4m5ZGXvdfl3j936n6TEmMt9J64mr9kA/biTmFrLfNHLM7
 edI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:31:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3XY1zF4z1Rwtl
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:31:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245884; x=1666837885; bh=maO26ivypjPINwRmECCY3/niEwSrPRX9QVM
        Fn7Sxe24=; b=pUqDOLF+vO6H3Bp31yGRnsz35t4STUSSNZnVMn6Vqf7JZsHQBc7
        bjXQWhAc6pAohUBUc9smzaaZrg4UmZW/UsYWALZZMua4ubbzhhLVirU9/zUY8tDz
        5H7Jvyfj+/lrkC9/DOlvc0X/z89yhKjipzTH88h1Ta3m/wUrkfVdJAy+zDidjRbT
        8BLRUM2M/14/eT67S9NfqEaBp7g5cdLDgCNhfUqzrpxYOvqpNBXlliviOge+1LDK
        ddGpoSB6kLCfmgNMLJY3+sEb6KlDpj7yDLFN1kOE3aireFE+lYS4dU1NQodUw2JZ
        jQFyQbrLlhQOBtJ6krT/DsHR0lAJeWUd7Pg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DR_zrEO2XpO2 for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:31:24 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3XW1QtMz1RvLy;
        Mon, 26 Sep 2022 19:31:22 -0700 (PDT)
Message-ID: <20bbed3e-272a-0a35-c727-4b0b48d2baae@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:31:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 7/8] scsi: libsas: use sas_phy_addr_match() instead of
 open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-8-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-8-yanaijie@huawei.com>
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

On 9/27/22 11:29, Jason Yan wrote:
> The sas address comparation of expander phys is open coded. Now we can
> replace it with sas_phy_addr_match().

s/comparation/comparison

All the other patches have the same typo too.

> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

With that fixed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_expander.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index b2b5103c3e76..f268291b7584 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -2058,8 +2058,7 @@ static int sas_rediscover(struct domain_device *dev, const int phy_id)
>  
>  			if (i == phy_id)
>  				continue;
> -			if (SAS_ADDR(phy->attached_sas_addr) ==
> -			    SAS_ADDR(changed_phy->attached_sas_addr)) {
> +			if (sas_phy_addr_match(phy, changed_phy)) {
>  				last = false;
>  				break;
>  			}

-- 
Damien Le Moal
Western Digital Research

