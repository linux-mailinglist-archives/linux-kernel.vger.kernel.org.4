Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24475EB79C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiI0C1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiI0C1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:27:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A680A9C34
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245657; x=1695781657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D758pODE4Rzvgl7azCFI6oT2++v17lWNbGobwyoSx90=;
  b=Uw0PIda7PVg3mMombhZzD+gX1pkNRL6hL6mZdGfk8dMennC/zdjOOqrg
   AfauY7ajyOuOi1s1uEc+DkryzkaJqxNi74JAzfzcaRfPIpLq0LcSM09gP
   eZ1T/K1KHn2HtQRn1uTlMPhkpgAI7fF2+dVnLkfdzbRmuHDa2XSNDxE4H
   2QEQQCaN+r4DVLP7ozsM/sNtzYy3yqODcm6/ofuKP4jI07HtrpLiSzGOl
   RH+aN7sqyiJ2eVSJgfi6LNEhGZeGTyW/PbiIWUC3OM9sqF3pkJsdwNx/9
   4CC09S9aBuQPuoh1vYll7TX2/RSf9u5IFezYe6TKm9MLvy3hiE7jAkeBc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="217515688"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:27:36 +0800
IronPort-SDR: kb5+IPeVqpLVru73bqvOuIKlcZuAo6gUQHrYjXq2dyM/RU+owiJ6+48+zIhPTXJ2Nl65yOXYom
 /JrBC0qkRg3ApNQ+AUtWHddSadZ9HAVNe22HC5Mm9+jOEgFnE+rmdwCF0auhptUjwA/PSl6C2q
 aVeyIWM7dKXtisTaaj2mNE1l5NbEDLe0xCBpJ/JyNJsaiPy8tqTX0ZnAXqtAnLE2XDAoMDmwH9
 p2B3n0Wbdon4+3GUKTwfYYyWDfvbT8Pkyr799SRQzYkvY2lJZV/PRmhMI/Hs1bwcl3rbhC9sye
 pNp0MOxgjwGnq1WqQx5hEugF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:42:01 -0700
IronPort-SDR: INU/Jese2NFtfdhAW3w9K+Vi4/TITk3gvi/xFbF8LaTLEBSWjaCyH7WNqOe92yh5bmRL9eR3oy
 PomWedIfQk4RwWxldJ9tcUbPlcwoAQJIREjn8kjuG8kJ+ISIxsBm3MmaLd90ocqhkkK+gxBOta
 PvO7qfywEpJDjT2Qa92LmXfQuuZ+/VEtX1ORqooPw7oI4vPJNPjEMyh7wfTtiZ+rRrd5jKXC82
 XHA0icRs9wW4kaiPqK1en+7NtbwrNTd39Q+AuERKA13HauizJTvBWhjH+VyHFb03rCs5HhrB3Z
 WJ4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:27:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3S75Bw3z1RwvL
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:27:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245655; x=1666837656; bh=D758pODE4Rzvgl7azCFI6oT2++v17lWNbGo
        bwyoSx90=; b=Ps4/HGV9jjgaCQqhcLwpgU1kvjSap4SjXRshFoq7fBlOba4EU27
        gnSUjne7YEoHrVyic49CUbYMifhiMnmCuhWHhg2h/wEije1mEbncsxlKv9dTv/IN
        v5ia1aTmIKenHWLwmXBKeIdwXMb782ZRqEuf4MOzOjUiKlOi/wu6/TUXtD7/3V3J
        H43GfzJftpx7lDoEchChmXzuM18CbkB3fjuJB9h3WIpu+0lR+1N5uYMBFg52Mb+o
        1hCLxl53FCE7usynTmr828IP9Fy3o20loz+moJLVFkU46h7QkldouozmHBpCXfFZ
        CN0a39KdJritfTfDJ8S4/L/4G2QIo5IIJ1w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vsKN2loptazq for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:27:35 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3S50V6Qz1RvLy;
        Mon, 26 Sep 2022 19:27:32 -0700 (PDT)
Message-ID: <7f557035-0f9d-d93d-ce19-a73116076497@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:27:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 4/8] scsi: mvsas: use sas_find_attached_phy() instead
 of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-5-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-5-yanaijie@huawei.com>
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
> The attached phy finding is open coded. Now we can replace it with
> sas_find_attached_phy().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/mvsas/mv_sas.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index a6867dae0e7c..f6576ffabe9f 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -1190,23 +1190,16 @@ static int mvs_dev_found_notify(struct domain_device *dev, int lock)
>  	mvi_device->sas_device = dev;
>  	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>  		int phy_id;
> -		u8 phy_num = parent_dev->ex_dev.num_phys;
> -		struct ex_phy *phy;
> -		for (phy_id = 0; phy_id < phy_num; phy_id++) {
> -			phy = &parent_dev->ex_dev.ex_phy[phy_id];
> -			if (SAS_ADDR(phy->attached_sas_addr) ==
> -				SAS_ADDR(dev->sas_addr)) {
> -				mvi_device->attached_phy = phy_id;
> -				break;
> -			}
> -		}
>  
> -		if (phy_id == phy_num) {
> +		phy_id = sas_find_attached_phy(&parent_dev->ex_dev, dev);
> +		if (phy_id == -ENODEV) {
>  			mv_printk("Error: no attached dev:%016llx"
>  				"at ex:%016llx.\n",
>  				SAS_ADDR(dev->sas_addr),
>  				SAS_ADDR(parent_dev->sas_addr));
>  			res = -1;

Would be nice to keep the -ENODEV error here instead of this generic, and
meaningless, "-1" code. Same for the previous patch too.

> +		} else {
> +			mvi_device->attached_phy = phy_id;
>  		}
>  	}
>  

-- 
Damien Le Moal
Western Digital Research

