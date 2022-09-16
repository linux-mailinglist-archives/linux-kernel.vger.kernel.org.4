Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E615BAF20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIPOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIPOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584F86FC1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338071; x=1694874071;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=O+pqlwbxQg1hAAq+luWu/GEhDDgCmFWLTEZMPBOz8xs=;
  b=pxclNn6p7qEsOO9IUB24pAqKFZh8A1xlYR5Eaw068wQJeI1/AHNVJ/ZU
   pfo99rRD75P9DcFZnS14z0wdNVRcGBDX/yfyk3fYWrBVP09JUfZ2OcuYl
   LrRmF+dlW30/tWTjlSyG2iMbbMhzLOJRN2jxW7bliCZElXjd/OHx77pG4
   ik7xFLPB8L/lP6EkCb/1slqa6dnLsG20bm7UFG8bdzvRoq3F7GGyf+KZ6
   U9fuQv771DYgHKlK9GLdfWj6OJKIkh7CY5tI9d5YsCYuLqkoro7FYqvKa
   XkzOqdhPPTIaKpHXiaYFgiXB20wsUrTTmsxHHxgJ9KG6pl2ZT31K7wZg3
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216707658"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:21:07 +0800
IronPort-SDR: QnA7rNVLJ1wG9weu3lMUbxRFicgoIYEHg/c9EyKwBeHW8122MdMcu8E5VTKjVoTxjPr5GtgSlv
 4ntJWlQk95p0d33jtmp42BTuB9Xy0hcnlXlkd6qa9lszf/6PARxfxxOcFrpXr7hv1Inh5xMkAo
 RbV13NHgMJ40qyAnESzLY4rWP8dE4x1RgECa+YlE2luAviX2rXpnyTJValIcPBxeuDgIDh1nf/
 Fsu+NN7lwF8w22anirGwSpRdw5yJ8oEkuhXV/zybjEx7GL6yVMsoQgdLVlrLP32VTKSHkzLVtb
 kut3Mh9cNw5I5dNHI0gQE3Ll
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:41:18 -0700
IronPort-SDR: ZyTjRFcDZHvz6YE0IkSTgSd2LvwSSmy8EbQ4J071R//Uqe6kJSNQLytVW30FBlEJdrATWoAjig
 DZn/gPf51PEcDzkuxmoO7TL55WAACMupPA1RJJuq/GN/6KDVF3Jhs6q9wCEZyM2yVtGw4jRqsa
 DouvT8CPFHsitoej+XvjysyaiR9lYDUQISDMqn9YqUGax2pB3JKfiAGXVUrPE6PQvOa5eAnZbu
 GaLtrWpfkxeDgkfnqiqLx5+kPhSZwCznK/sXMHDYmn46S5SkJUZJezACvpCfKjeTYSW1AZ04xk
 HeE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:21:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbpX5DCYz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338067; x=1665930068; bh=O+pqlwbxQg1hAAq+luWu/GEhDDgCmFWLTEZ
        MPBOz8xs=; b=obazrQBLnRYGfFJyqigB0N1pI915+a7he34qV7FvbJ7M1prfbj8
        J4uaQJ8PWdZCBoeAsPdvCfF0fVHBZTUE/aR1JFuBs14Uer6ZY/DQ4vPUoh9/fK7H
        XzrY7mMpKJvs7MjMmbSt8DlcVeKCGFrefFsbxV2LGTALggDoYvuUfaXFBHZAYTg6
        WgRbs6pgusS+gosyq2w1O1owGrjZLjumL0inM6BUqJdTHTo8PHrKdQMMIzH/z+ma
        EfMFAFspdZPtcV59NKs4fTD3/7lwUmUmJ23ta8OExPLITXQ7vunpy3i+Vuc66+ww
        ArZG0lcfqJxd/Q+Ah7O7BmVak3PgYgqVTZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id baPQKbMxqsA4 for <linux-kernel@vger.kernel.org>;
        Fri, 16 Sep 2022 07:21:07 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbpT0LZwz1RvLy;
        Fri, 16 Sep 2022 07:21:04 -0700 (PDT)
Message-ID: <198dc594-4d74-ba85-bc4e-190981592ae6@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] ata: libata-sff: Fix double word in comments
Content-Language: en-US
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220830075024.13917-1-dengshaomin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220830075024.13917-1-dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/30 8:50, Shaomin Deng wrote:
> Remove the repeated word "Transfer" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  drivers/ata/libata-sff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index b1666adc1c3a..7916e369e15e 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -776,7 +776,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>   *	@qc: Command on going
>   *	@bytes: number of bytes
>   *
> - *	Transfer Transfer data from/to the ATAPI device.
> + *	Transfer data from/to the ATAPI device.
>   *
>   *	LOCKING:
>   *	Inherited from caller.

Applied to for-6.1. Thanks.

-- 
Damien Le Moal
Western Digital Research

