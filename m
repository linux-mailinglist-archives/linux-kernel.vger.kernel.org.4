Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A90610A56
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ1Gaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJ1Gah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:30:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E7495CF;
        Thu, 27 Oct 2022 23:30:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S6UQaq058643;
        Fri, 28 Oct 2022 01:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666938626;
        bh=tTe8duNXpQL7SpPJcLpKbMe2aHabAC/tsbx1oi2DWUE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KCQZToxAbfLb2gbxpQyFzZa9n5Z0E/yynEhZ1xlo4HyA7pwiqwajiB1iQGBLfONtM
         aselVjdh3tIAVktZpz41/IVKanhuro76Jz8GII9FmxLeNRw5Rlf9tAE6u3WxK9blp3
         +3uEY28rh/iRp7cyefUm2q9zt+BYD7d0R1t2nmMU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S6UQfj071371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 01:30:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 01:30:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 01:30:26 -0500
Received: from [10.250.234.138] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S6UOqV065181;
        Fri, 28 Oct 2022 01:30:25 -0500
Message-ID: <0f5235b8-9f35-6f7c-37b4-8094e476fbd4@ti.com>
Date:   Fri, 28 Oct 2022 12:00:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] spi: spi-mem: Fix typo (of -> or)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-spi@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221008151459.1421406-1-j.neuschaefer@gmx.net>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <20221008151459.1421406-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 10/8/2022 8:44 PM, Jonathan Neuschäfer wrote:
> In this instance, "or" makes more sense than "of", so I guess that "or"
> was intended and "of" was a typo.

Using "I guess" is generally discouraged in commit messages. Please read 
up the documentation

on submitting patches:

 > Describe your changes in imperative mood, e.g. “make xyzzy do frotz” 
instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to 
do frotz”, as if you are giving orders to the codebase to change its 
behaviour.

link: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>   include/linux/spi/spi-mem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 2ba044d0d5e5b..8e984d75f5b6c 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -225,7 +225,7 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
>   /**
>    * struct spi_controller_mem_ops - SPI memory operations
>    * @adjust_op_size: shrink the data xfer of an operation to match controller's
> - *		    limitations (can be alignment of max RX/TX size
> + *		    limitations (can be alignment or max RX/TX size
>    *		    limitations)
>    * @supports_op: check if an operation is supported by the controller
>    * @exec_op: execute a SPI memory operation
> --
> 2.35.1
>
-- 
Regards,
Dhruva Gole <d-gole@ti.com>

