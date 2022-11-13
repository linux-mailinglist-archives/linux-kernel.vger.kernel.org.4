Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC495627379
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiKMX33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 18:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 18:29:27 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75896268
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 15:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668382166; x=1699918166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ls9hQt+lxjdR81yzo7Tym71L3DnGEQ+GNDfIHWzpK8=;
  b=XuZXhpa4EDtqIC14H9U+YZGEqHr+XKcZl/tsMAvIVkFY3IO9R8yvTged
   65Q9rO0L/z75jGp2s6HFQwcvY/tBxJ6hO2GR7U/D6GJzRJq2MIizehgcw
   dLUm6l5rXbMVwhP6YKBCUrX+Yno+F+QeAjnDSfjNHdDS7dJCz//uEyqub
   gcjzy5pFxrFudHGkyXrDFm34ffpNz1/Mxbsa2IYDtFSge+pAwBjNf7oTR
   f/XPIOQcfxSl6IbSR0S3TFGHBizLbDYufz/h5AFlpZt5T8oRlkZ8Z9RoI
   5K0hpGkbJAVtda9gb+89RcDj+Hfq9OUUbxWGInVO/KHoZU+vWH/vOOEy/
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665417600"; 
   d="scan'208";a="214441177"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2022 07:29:24 +0800
IronPort-SDR: foIqgYcIfQKfcgqAWDb1aey7JIdlSvYlWthcXy02MvqGlTloG6qThr9mizbzIp6xeRvClN8Oya
 l9KtLbfbHuh9DIGwxqTEUVI+nFk7cMy0eHDFzc7ekfBAXE/a6Fxn/shaK9UYctyB1i/EWr8ELh
 ZCk3xleohCK3SzPFwNVR0kGoVEeJMQszssiHhuX6hvmJTUgzpuQffSyeVb8XHCEn+0ZB2BFVgD
 v+ZqPDzNw5dPmEhswAOcPqcGNLhWQNjg1QVXl20rQRASMPwzIfop3VEtV0YQHb4CxLgcFG9aY7
 9c8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 14:42:38 -0800
IronPort-SDR: GzpFw+gaE7EyRIV11HjQcVYF/xiv0+zIHFz4JRN+sn9SjMY9kfPOauoA+QUK60RufjiHX4XKpP
 mkE7idrz54qjPmdHLW8gpbRBxbqLOmrfccYMUpCHVy5P3smCwSSnwFbSg2iBHVgtMfSD8uLlUe
 2A2SeeHLUjH4B8nZmoK8RPlfLXLuJmxo85BIrq5Lmju8rnc/Ibk3+DaOmhwC8jwoLDJ/dRKdS7
 LiF3GprbMScUYMWe/lfzyoan1224C/AcpDB03Ef7umy42AVpoToHedQZOVmKi09iIHEEZfz3v2
 xKk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2022 15:29:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N9TDN3QXXz1RvTr
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 15:29:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668382164; x=1670974165; bh=7ls9hQt+lxjdR81yzo7Tym71L3DnGEQ+GND
        fIHWzpK8=; b=OHBdV7iS+fhHcMiLou7YXBhriHt70OV0cj3B8N9HaNJ+Yvy9Inr
        l5uQXP1qOfR12B7pZYv2z4pTZDBqAXtauF7+5/HzggsJVRDuAtMfIovIP9ieY3pS
        zRrMFIJYdXnPBHX8RCyBIPkItOM6aBM86rLG5Xa06SrL/ScUKMoM+XOrGzVS3hZh
        ZqlQG3420c/bPbYm1674ZoKGEgBg+QZPUu6iBDQ+hsp6x049h0E6M7o/G0RwT0NO
        ERCAAGLwLczmubsqSsNE8Gjrxc4cw8Zll3+8Njm08yxjFvXro2qDXHA22cBR5nLk
        Zv+U4No5H5udGpjnIQuaSFx6gRnG9hMpoPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Le5c1ZPPSacE for <linux-kernel@vger.kernel.org>;
        Sun, 13 Nov 2022 15:29:24 -0800 (PST)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N9TDM2v6fz1RvLy;
        Sun, 13 Nov 2022 15:29:23 -0800 (PST)
Message-ID: <ab4d249a-a99f-3d3f-6823-240f8aca2da8@opensource.wdc.com>
Date:   Mon, 14 Nov 2022 08:29:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [patch 02/10] ata: ahci: Remove linux/msi.h include
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org
References: <20221113201935.776707081@linutronix.de>
 <20221113202428.374088146@linutronix.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221113202428.374088146@linutronix.de>
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

On 11/14/22 05:33, Thomas Gleixner wrote:
> Nothing in this file needs anything from linux/msi.h
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: linux-ide@vger.kernel.org
> ---
>  drivers/ata/ahci.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -26,7 +26,6 @@
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/gfp.h>
> -#include <linux/msi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>
> 

Applied to ata tree for-6.2 branch. Thanks !

-- 
Damien Le Moal
Western Digital Research

