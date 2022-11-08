Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816786208B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiKHFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKHFB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:01:28 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE86FCD5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667883687; x=1699419687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HwggHoQfuva0EHxrxsa0iScKJ5Q+Jys9IWgVhrFPor0=;
  b=rfOizIrnuWFN2dKatGG7Gl3Fp/GiUFUzFyjMjCbbh4RWNzluph3C/kTZ
   nxpuVkn/AwIy0/uRYjMahGlk1fgdR2vFdAoxL5tOgyJo1dcZbvSdwPBMo
   BMn0JfwwKG87FyPn+Y7Jr9bcz4IUAWylKGJGz+JDlBK0Oe5+yiyPSQBlH
   RaI8488nLXmTL1t5QDZZT4ThnxfSE6fhLyoRqomLMZpTbfYx7CpFUg3XF
   WZlCaXQGe+eU16G2aoFCG00iK5CpDQRPWrG9LHH1tQdvLF9yAc+Dz4h0Q
   O4i63vrmHQ4r09VBRVTisXr/jtEWCJhP4BPX09NFoFwwMDXvPWF9tCpW0
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="220886212"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:01:26 +0800
IronPort-SDR: tvg1dmtGgd8M4wHiBpLQaeJ5W8taDgH2yT836VugndlWkiAVc4VoPt2Dg+SHj+n8g7Q2qUrjq1
 TouOMj/vQVQEFDhAFqw7YW+cHW81QE18WrbeAR2ygu4+07JZ/LuVEesmbp8H3v4LRqMp0Yhmnf
 LmEvRGxfX8ZwoVt6AK5VaiyG5AzAgr9QoD+o4EJ+4yYpiN6sTu1gEhiX2Yzt5e6+i3Ct5T4HJk
 Oa+PrckWg87kv2/BIdJqUaNZhmtBwkuEnFpxXW2/IuOACo+rCRX4zLaR6I54o374O9LLLDPcHB
 ILE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 20:20:33 -0800
IronPort-SDR: DGHkWND9LXXd7O+o1BOsCRSB9bZO2vtRFF0TKTfd6llit7ooOgxLIchure77TGxUv5okcQhT1i
 qUv+81CuJZxSboMYbRZ9r4bzK24usRUnNc6DmnAf6zh7wRLvRHibbg4sqTXu+dZM44HuWD5pme
 gH5ddsumyYBYKMChvLTN5yPIEAYXNQ1bGCox69sFMJgaKsUfWoAiZycpKHNmr95oxpsGG8N0BZ
 D/aWHbGZVG0dRxmmrDgmB/8dbIhnQFFf6AJ6x+kE13BzWPpWNbdX8y9QCvnEeRSuq4VNdON7D6
 7Vc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:01:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5wtG4gD4z1RvTp
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:01:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667883686; x=1670475687; bh=HwggHoQfuva0EHxrxsa0iScKJ5Q+Jys9IWg
        VhrFPor0=; b=F1NO0UL0nWY/meUtIBMKWB/2A6jfp81X7Wv9I9PJbSP2A22Rnrh
        LSqNBKQ3JrEZmk3b2+GIpjKh3n94cZvbeuIS2dDNdDEgO0MlQ5FJZefcj+Fr2OMt
        feVEQaIVQ3BSbWnQNzGaPcRohQ6sOogXYpfnJfTyvO3YE4dvwskY5ykIL951kf1/
        lQWflmtVzyeFOoBTCg9zcpdGaOsWJwn+yo+IAvK3Cf7Wg4swHuYLpWNkPF0Qj3vi
        LQa+HsopZosVkqjwMxofnKzOoLf/E8KWuYNzRVZeU/7oLMWXBaLcSZeFdSRS4TKm
        13yXavclrdbKbTJ12YZs67WgLTjixYulO8A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eSRposiV1JvY for <linux-kernel@vger.kernel.org>;
        Mon,  7 Nov 2022 21:01:26 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5wtF3rFcz1RvLy;
        Mon,  7 Nov 2022 21:01:25 -0800 (PST)
Message-ID: <0b5aaeec-682d-9f9d-50e9-4a66f589e592@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 14:01:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] ata: ahci (gcc13): use U suffix for enum definitions
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        linux-ide@vger.kernel.org
References: <20221031114310.10337-1-jirislaby@kernel.org>
 <20221031114310.10337-2-jirislaby@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221031114310.10337-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 20:43, Jiri Slaby (SUSE) wrote:
> gcc13 now uses the type of the enum for all its members [1]. Given the
> ata enum defines its members using both unsigned and signed ints, the
> type of the enum is promoted to long.
> 
> Make sure the rest of the members are unsigned ints using U suffix.
> 
> The error in question is for example this:
>   drivers/block/mtip32xx/mtip32xx.c:722:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long in'
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113
> 
> Cc: Martin Liska <mliska@suse.cz>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/ata/ahci.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 94b5c81f08dd..14eb6e97f6f7 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -39,7 +39,7 @@
>  enum {
>  	AHCI_MAX_PORTS		= 32,
>  	AHCI_MAX_SG		= 168, /* hardware max is 64K */
> -	AHCI_DMA_BOUNDARY	= 0xffffffff,
> +	AHCI_DMA_BOUNDARY	= ~0U,

UINT_MAX ?

>  	AHCI_MAX_CMDS		= 32,
>  	AHCI_CMD_SZ		= 32,
>  	AHCI_CMD_SLOT_SZ	= AHCI_MAX_CMDS * AHCI_CMD_SZ,
> @@ -178,10 +178,10 @@ enum {
>  	PORT_CMD_SPIN_UP	= BIT(1), /* Spin up device */
>  	PORT_CMD_START		= BIT(0), /* Enable port DMA engine */
>  
> -	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
> -	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
> -	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
> -	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
> +	PORT_CMD_ICC_MASK	= (0xfU << 28), /* i/f ICC state mask */
> +	PORT_CMD_ICC_ACTIVE	= (0x1U << 28), /* Put i/f in active state */
> +	PORT_CMD_ICC_PARTIAL	= (0x2U << 28), /* Put i/f in partial state */
> +	PORT_CMD_ICC_SLUMBER	= (0x6U << 28), /* Put i/f in slumber state */
>  
>  	/* PORT_CMD capabilities mask */
>  	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
> @@ -191,14 +191,14 @@ enum {
>  	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
>  	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
>  	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
> -	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
> +	PORT_FBS_DEV_MASK	= (0xfU << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
>  	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
>  	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
>  	PORT_FBS_EN		= BIT(0), /* Enable FBS */
>  
>  	/* PORT_DEVSLP bits */
>  	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
> -	PORT_DEVSLP_DM_MASK	= (0xf << 25),    /* DITO multiplier mask */
> +	PORT_DEVSLP_DM_MASK	= (0xfU << 25),    /* DITO multiplier mask */
>  	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
>  	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
>  	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */

-- 
Damien Le Moal
Western Digital Research

