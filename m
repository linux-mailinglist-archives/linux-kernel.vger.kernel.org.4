Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30C4625513
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKKISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiKKIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:18:28 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9856E9B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668154707; x=1699690707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=goKayUn+kIt0wuTD4YEeWlIv9qi4VVZqBIGQMIXzaHc=;
  b=ceQzjG2HxD216Iblb9u1qQ5BTawZZN+uDCkBGCvy60S5Irci/ep5QGuT
   yM7EjhHB005onKZE148khyYHbEVEX51ZOUxreIuStoKaUVGo7YeZ+Ld2G
   LZ1Bcw/5TqWt6SIzXb6gZjyfwInPd6fk3Y4JZIWDB6pE9nBRfahcUE1oW
   VYVWJVSleEOTfJEfocpXAvyBlV5YWbmyIClKDmBNRpQPUrniVuSyFuvJJ
   JFXAT7O+QcvbDFEh9JwHqcugPPkhNfo2f2EUTQb/2RDj+lajDlvFiv9NM
   kRQPB+tRyGOdqXY+xiAtWRzup41+j/vY3GfAuPfsvCKXA1gamqJe86nQm
   A==;
X-IronPort-AV: E=Sophos;i="5.96,156,1665417600"; 
   d="scan'208";a="214310449"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2022 16:18:20 +0800
IronPort-SDR: rgdUYdbkV3RDFLyXR0JXWE2tl4kj+2YOtRP5K8vmqRq2AsbQiVunKFNxGUeMeM54aE3RuRDYLX
 +6/G1Y2r3aiCq1uC2+TIdhdpBdwgwvUlouYaurKApGUGFNKby3Gi+7Wza8o9HBlPubni2mGy7A
 3yC8MDp6hV51IIvVlH2YXog7aTYTIuAfD6ijRruZpJ8Zs6YgzSL1siZvoyBgj77KCswkm5HgZg
 KDddDwRqkZXXEUI2SqsGI3d5WYEWNyRYUb0sTDx/lMI9/omT4IL1jlEJnnW1hZQpa6QsISJeWA
 kaI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2022 23:31:39 -0800
IronPort-SDR: HhD4Ws2MSC0kr9rzSUrpaCEt8wGx1bX9fA6yOwSYZ/ZsKP7p4dxpvGCwzB0IuXJ7qExwJDFMJd
 U0pHL+Vg1eJ664gQVS9IjLx3Kky3SucbBh1PPcZTmPMQig58Sp4/5seBiXDS4bZydhGMSsUKZj
 1pDwniBxRY+8cUCzf0VZodR3Q7IR4q9b2DJPvARyF+RRu1Uso5lv0YZmXeUWAUXGVgYZTREF7M
 tPXogoW7XQesSdsG+qPwx1fdb7thvIm9mV7hcYP7P9BuPrtE8fd8/kT4/BcTp8cHe98LOieE08
 VJY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 00:18:22 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N7s645FKmz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:18:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668154700; x=1670746701; bh=goKayUn+kIt0wuTD4YEeWlIv9qi4VVZqBIG
        QMIXzaHc=; b=HA/WKu5F8bhHjH0pdZK7L3s+ZdHK3f8+HljbszWVD+YLYCN2o4C
        XJ37sPdqh+YfWmXnyMwC0IX6OCW8seZUapqMvPa/3jEzmpnjE644uj4VgPQOHuDk
        C36UsbrfrOX2iFWTYwkJKDy03lYwFxKP7MvCe8AgR3Jk1NxYa90DtE3kKAWb19w5
        4UPAGhuevueX+9QM7rYZlJLTA7YgvQv8X2yxxE1toV8hLkJGBEXhfJ1S7SnIRaql
        numrMsGloqegW3qYWeztlYxjFLhO+DVFjp/kMI68s3rEuVsrAPr09M82LRx0T2bP
        RD2aH2sSs9e7C0I8Gi5+HC2ZdKwtpdZ2QDA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FEVl411fEk5y for <linux-kernel@vger.kernel.org>;
        Fri, 11 Nov 2022 00:18:20 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N7s634918z1RvLy;
        Fri, 11 Nov 2022 00:18:19 -0800 (PST)
Message-ID: <5b301bb6-3d50-b6f3-e541-7b6754ceeb7b@opensource.wdc.com>
Date:   Fri, 11 Nov 2022 17:18:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: sata_dwc_460ex: Check !irq instead of irq == NO_IRQ
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a99c89d7b39b63663739f064cd60514938b77833.1668106138.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a99c89d7b39b63663739f064cd60514938b77833.1668106138.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 03:50, Christophe Leroy wrote:
> NO_IRQ is a relic from the old days. It is not used anymore in core
> functions. By the way, function irq_of_parse_and_map() returns value 0
> on error.
> 
> In some drivers, NO_IRQ is erroneously used to check the return of
> irq_of_parse_and_map().
> 
> It is not a real bug today because the only architectures using the
> drivers being fixed by this patch define NO_IRQ as 0, but there are
> architectures which define NO_IRQ as -1. If one day those
> architectures start using the non fixed drivers, there will be a
> problem.
> 
> Long time ago Linus advocated for not using NO_IRQ, see
> https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
> recently in https://lkml.org/lkml/2022/10/12/622
> 
> So test !irq instead of tesing irq == NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/ata/sata_dwc_460ex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index e3263e961045..5fb80ccde65b 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -242,7 +242,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  
>  	/* Get SATA DMA interrupt number */
>  	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
> -	if (hsdev->dma->irq == NO_IRQ) {
> +	if (!hsdev->dma->irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}
> @@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  
>  	/* Get SATA interrupt number */
>  	irq = irq_of_parse_and_map(np, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}

You can also remove the:

#ifndef NO_IRQ

#define NO_IRQ          0

#endif

at the top of the file.

-- 
Damien Le Moal
Western Digital Research

