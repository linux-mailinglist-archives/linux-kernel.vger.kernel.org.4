Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDEF626666
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 03:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiKLCMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 21:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiKLCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:12:03 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C720BC9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668219122; x=1699755122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQd0tuGhFCozkOHjDWW+kUqRokl8phBHfghcLIyAaHA=;
  b=qL9wx0X+gDNSgpK7Yr4b4U80ZoMDpMiTDxVRnba1+I5cG1hY5P+2b2Je
   LbgjbYPk8Saav6rPdklZfBA88JitOWfit0mZZU0zS22E8aAdMZv9cJYQb
   gl6+Kwdj6eDwuOeYNyOt1eo7iRNM5/2clRpZnpFLw56T3nrokdO+R5a9u
   +zZlAufepkPd1cBM8dZEtnSXLz88ypTJXyh7IJZB+mYnNvegGCe7uHbFT
   XlkeUsLImHjcpbrqblFXoRo2XwC/s+RemzOdukjN98VU1SIVR2kI9c1DG
   DV9U4yCtozz2Fa4XxFMo6LroydDhakRPSwNItTtQNd5iamiPkgST6Pkoa
   w==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="216095408"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 10:12:02 +0800
IronPort-SDR: tWttrZF2sQAgKse78Xgd0bG1uDPcafC0FCHoZvoy5wrCuAdn7yHEzYT0n6CHr4MV7JukI8TNUW
 4r+v1dUNclkLq0MpYFNlTPm45qkfeoAuj/JfUmdg6XRGze/BiV2TPX4TKMnPjt47s1dKurhW8c
 pCQbPw8/RwuUzqVG33Ik9LsYKf9PHLgSg7oYI04cGkRVmEFysEUJ21ieL1I31BIet7YzofFjOz
 5gxNC9FelZ95SjqNeZD07Bd9fFesZOimdQxYFkn2DbOTZHYPTz+H+rwxQjqkAAYEYUiqx60vEV
 vMY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:25:19 -0800
IronPort-SDR: UN31LEdOgvca6mMvwgW5YWUY7p39NGwpAFu6qEUqnx17VY9zZN4Lv+m9/OFVSP64fVg7iWFEvC
 N0BkW1HiIyjautrpiT6aFwZUYMkvlqaXLcgOFzVApfvX4fVuwdNuXYy9clr74CQrQJ0uVkwsX2
 QvGHx73reBZlVrbYlB9Jcwc5dXuakNKLkXZqQXIsI+GuK+96CUQ2BOuUrAg/8DprTsnblGdrEH
 pVXShjdfLtiLfwH+xXluxfEi0L3nFMB33+IYV5o4soddJyT8VQymtPuAe81h6D/9612drkU+KO
 lWQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 18:12:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jwx6tnDz1Rwt8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:12:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668219121; x=1670811122; bh=WQd0tuGhFCozkOHjDWW+kUqRokl8phBHfgh
        cLIyAaHA=; b=KCsByQYCQKCcsAVQJbpvrQW/C28QXibvRw9idxiZLQgNE4Uxy+U
        SyuDTCc0Hd7UfRO3juvm1MDS0Pa2pQ7ntDffDI7cUdVEWxTBrcwEEggwZD7OrriU
        UUlDq/1k5J7Y+pUHwZSngowNDisYFG7KvGYx+OFEE5DBtAIu3y5HtKupzTCUXDKN
        ARGx3Ef0GizqejsLvwhj/FvZtgFWPX3jrXuMmgBfsRffiC4S6sGBtkyDLq2TL61D
        MbolNQmCZPGYxO6i5uPXhdLjrlM6Vn7btP1FfrpteUsvJAs+YVNuM/zDsVpjYmpS
        /5hXuO5BciF1Ai67XxWU0DTHqz4kMrBBo/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Sx8nqolotdrb for <linux-kernel@vger.kernel.org>;
        Fri, 11 Nov 2022 18:12:01 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jww5Cthz1RvLy;
        Fri, 11 Nov 2022 18:12:00 -0800 (PST)
Message-ID: <413631cb-b9fa-b148-9dc7-ccca6047ace4@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 11:11:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ata: ep93xx: use devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
References: <202211111647123266703@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202211111647123266703@zte.com.cn>
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

On 11/11/22 17:47, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_ep93xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index 6c75a22db12b..47845d920075 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -931,8 +931,7 @@ static int ep93xx_pata_probe(struct platform_device *pdev)
>  		goto err_rel_gpio;
>  	}
> 
> -	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ide_base = devm_ioremap_resource(&pdev->dev, mem_res);
> +	ide_base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
>  	if (IS_ERR(ide_base)) {
>  		err = PTR_ERR(ide_base);
>  		goto err_rel_gpio;

Applied to for-6.2 with the title chaged to "ata: pata_ep93xx: use...".
Thanks !

-- 
Damien Le Moal
Western Digital Research

