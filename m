Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15593600553
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiJQCnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiJQCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:43:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139CF46865
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665974584; x=1697510584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7p1TMFScOznFktsWCSCUifkFaarpweirabw7CA2YiUQ=;
  b=bvncR5eH0Ab0dvoH5v7ZqNeiWep7qne3tO5XcmwFH8AZ2yv9SEy1KfJm
   GuRNbAn+45d7wg6MocsiC3NZaKpSMRMe+9DiLV5ZH9fEIckvbexYAezTh
   FTWozNgJY1ctw+5LvlfGH8dm1pEY39NHbyTtSoqoMZCtohrXN9qfpY5tt
   LTcRuHicbyzuVS/eX2VrgnCrR8kzgoIoAhPIdxcGUL6ztkDKMaa4bc0/+
   Hco7eLp16lGddb2W/BTUIGggZrwJVN5eoOGNnFXkItQ42OqNWlaU2K5lG
   LnCOS3DlArZ8IHUQS6x/f8LUhYgK38jRxFq6GxKAHqNwol7QzuD4ZZEmW
   A==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="214363091"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 10:43:03 +0800
IronPort-SDR: lW4KeUyAieZpvknA4tfW+gCYiqBbS2pEvU8w5Kb4Ni9gO3ZZTyyrb/OjZk6A85bHTlu0CCfdjz
 dlNzeRbzF1DDQr1ysx6atsvvACCRXxcmFF5/MP+fp2yXXzs9kCBWPCtKL/10MEWkZicmC3Fd+d
 gzoHfT/TBQ+BoaqBKyjHknYgHr7CX64vXH611fP4FiMgy3a2NUOH/WWpxDyox6eeynzIuGkXJ1
 chfnxzEF3Zx1wL5/H1bmUEB5m2xERJvqWJ/cvZABz+bXB98G2Ov1IXccTcbACvepJzU339iDJD
 swmAP6DfzKHHXqv2PTqoWIrj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:02:37 -0700
IronPort-SDR: FaHCLoLG+ZZvVHIfogvJTdSoTVGzfugOzoGu0NfnTr5s9Ys7f8jjgA8Qn5kHfk9fw7W1XShc9T
 WTg9cvaapWFxSXUTyahlYeBULKWOI4U8cjjJ7C92ohGKI2lcKS/Xudp6yaPE9NB+VuLeHo2G10
 k/Tb2xdLZvT5syUE7nCRlMvr4Wk05seQFNdcuz+A4cTl7yPckD+mlx3CdS6FZdCdLczAv535xB
 cZ3SFycOxpFTI+GeCvn3oXRRj3Sq3JmG/rZ2UYboYx8OV/zLgaETzINJyodln5fGPG4GDecEs1
 SLA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:43:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrLrl3Sqgz1RwqL
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:43:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665974583; x=1668566584; bh=7p1TMFScOznFktsWCSCUifkFaarpweirabw
        7CA2YiUQ=; b=q9s6mtITpeENVR1Es+hLT9EVSyoE8GVWa1lLojU1AY6YjZHprwo
        siaChWviaTVETRNhu3FoVJDauevBgKVhuSA5Jbedm0YsGYo9XksXPVmdkyE2zOvf
        7ErF1bDD4ubWVxzoClIhsCa+74XU3J9hM9nWL8FZoWC7pKVIojIimnJTNASj/lHS
        MyUN/Q+J+yf/KtJSWowBziP7eU27z/GoeAeqs5GXcxcTzhxUENB73Y35ek/VxQI7
        tIO4GufonIBnMwVVMdtiavMTv5bBaFNmPAA7BuaRk2CgealpXcJPGwSZMAkwG/Gl
        PDO7f4fJ28qMRnB4SIxNE6Ppnq8MPMNypjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bVBMyRe-V5SL for <linux-kernel@vger.kernel.org>;
        Sun, 16 Oct 2022 19:43:03 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrLrk3Lh3z1RvLy;
        Sun, 16 Oct 2022 19:43:02 -0700 (PDT)
Message-ID: <0368fdce-436d-4a19-1fec-fdd2f3038eca@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 11:43:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 14:17, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> 
> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/ata/pata_mpc52xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 6559b606736d..3ebd6522a1fd 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -731,7 +731,7 @@ static int mpc52xx_ata_probe(struct platform_device *op)
>  		udma_mask = ATA_UDMA2 & ((1 << (*prop + 1)) - 1);
>  
>  	ata_irq = irq_of_parse_and_map(op->dev.of_node, 0);
> -	if (ata_irq == NO_IRQ) {
> +	if (!ata_irq) {
>  		dev_err(&op->dev, "error mapping irq\n");
>  		return -EINVAL;
>  	}

Applied to for-6.2. Thanks !

-- 
Damien Le Moal
Western Digital Research

