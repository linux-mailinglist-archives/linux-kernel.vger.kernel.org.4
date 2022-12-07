Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD708645ABC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLGNWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLGNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:22:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7155F65
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670419359; x=1701955359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MBA3RUU8atxV2pIWYj0d+jaKkWZZU9b5BLBBvfS8F40=;
  b=IZwqiHt68X5LQeF6H4CKGLdOYLluoutSdihbkgYCW+m/z6XaAEIeErmT
   /Jb084fZMqHofk1VoL7Ku9fi3Vy3RMNcVxoi5Ne0Cp1MiCv0Wdwz9FxG7
   avj7nT8XOuywtEee93x2DX3AZG3VuUWvbcuukYHluSjam/GBJAQa+ombm
   A6jTyYaijl0FmCwXrdidLiTyqTUNFOH9RIPnYQwEntIDts86TlNfh27E0
   mtZrSllG/RFJ9TjeD6NvU1olFN+db9Ua/zLY5Tq/p6UM2Eke2rzKc7+Hw
   mL+6MGaclMwBiyr4sCB9/lkYoLSQIYUNuewvzhMFGWy4w1QtXR+QxoMXo
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218095704"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 21:22:35 +0800
IronPort-SDR: yXczMUtKlfbLNOpC9QHY+oXT/FGHc88hAZrrIxRyQWiXcqWOSzriekzjZY1xe7Is2JvJbvYrb7
 4LooAvBU5a5jvjFqzDkpHBVhtZSX8mwZ7doeQ4OtNrlFyG0GE9RBu5vYNG54veqKS06LvDlDf2
 Tfa4REoSJrNI0baAnKYdoFrEpo3OKOBBA0wjITda6Rl00TcTlYHmTIL3HKGGcCKPogPTAtK9pN
 YcYlOWmpVcnj1t2JV4G2+OyQO+/f05zeiEHFbEs6zbEqDFM2oBAA7JUd9FUmPhgvHKMksph3Cd
 dlI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 04:35:21 -0800
IronPort-SDR: Wg+xI+Ux+u84RXpqgNs8iTdm6P+l0cyt8Qg0mcopcUQiKV9E7Wzf5p0PaRLMa3GOEnAf2BA01O
 yXo3RfzuIEPYdN2PdF+o7CXLT8b0tRSCCTFkzekfmbJfuUfscQaUTiWVs25TgxUK3tX5pUP5NZ
 CVsd+7OiCQyMDYyK4pj2U8/RKsT8+y7jMVy96C3l+y3HMMOllb6skdlfxwQBjZKG1m78550g3p
 /oSMxFiOaS4RJ74LDs2seO1ROaK4fgxYyyGDAnbOTqkC5+ozZoP8vH6DUdcQ6d8PYQL1hFpMTv
 tYg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:22:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRyd670Bzz1RvTr
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 05:22:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670419354; x=1673011355; bh=MBA3RUU8atxV2pIWYj0d+jaKkWZZU9b5BLB
        BvfS8F40=; b=kucfA1Q+jycUqtYawXrLAgc95qX0hndDZ/YSlFIFBJkM0riSJXe
        9owzJ/kjZX1maNEyjXTMQxTFR3vkm6rwz0yOBLPLH/3rCThrcHmDi9Gu1fOePlbm
        aYPEKEIJty4lSjEwiujFikEqvYY0mvlMCLnXu5Kx7jeBdn2UUcxjlfytYdhRqcFK
        IcqkveHcXMc/FdV4dcpOdqGBM5OFLLKnuXFcUVa1jSweJcDVVnffZrpRtqaxGCs2
        4X0nGqI3DkN4NiBoDYk7z1mXsJPAoYzrl11Tmorj4ZlDN7i3zzDnTWNITLB+jL//
        xVlzf/9tqsPoHnyueNV78Ap6EOYSSopH5SA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SR7BEz7UpAEh for <linux-kernel@vger.kernel.org>;
        Wed,  7 Dec 2022 05:22:34 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRyd56nZJz1RvLy;
        Wed,  7 Dec 2022 05:22:33 -0800 (PST)
Message-ID: <4d105e81-7f99-a17a-2a84-5eb70c74cc91@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 22:22:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] libata: Sort Pioneer model in blacklist names
 lexicographically
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221207102656.12486-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 19:26, Paul Menzel wrote:
> Fixes: commit ea08aec7e77b ("libata: add ATA_HORKAGE_NOLPM for Pioneer BDR-207M and BDR-205")
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d3ce5c383f3a..c08c534b7fc7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3990,8 +3990,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
>  
>  	/* These specific Pioneer models have LPM issues */
> -	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },
>  	{ "PIONEER BD-RW   BDR-205",	NULL,	ATA_HORKAGE_NOLPM },
> +	{ "PIONEER BD-RW   BDR-207M",	NULL,	ATA_HORKAGE_NOLPM },

Nah... Not worse the trouble. If anything, I would rather have the entire
ata_device_blacklist array entries sorted alphabetically by vendor and models.

>  
>  	/* Crucial BX100 SSD 500GB has broken LPM support */
>  	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },

-- 
Damien Le Moal
Western Digital Research

