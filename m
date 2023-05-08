Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC59C6FA144
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjEHHnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjEHHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:43:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807F8687;
        Mon,  8 May 2023 00:43:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3487hM9g121553;
        Mon, 8 May 2023 02:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683531802;
        bh=MfY2xrMsVZUkP52jNIJv+zjO+spcroa1bpXFUW38sKQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JlovnVqONnuT4TWnrKYzT+zuh+AnKhQAn7YRxIPwEkJzY8XcDQfiMy7Zn5Tr3EMfc
         cMSEl51s0R2QsYfteECEFeRYLzDz0UB6HWSo7hFT0fkFkUFpgsnJlUzXjuuRkWMDIL
         TFwEXatVV5g7RKHzDH8SbqPj7ll5IUBn9mFCsGl0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3487hMtW085993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 May 2023 02:43:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 May 2023 02:43:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 May 2023 02:43:22 -0500
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3487hJ2v068773;
        Mon, 8 May 2023 02:43:20 -0500
Message-ID: <a25ce95e-126e-7a1a-1bb0-2a3d73ea4aee@ti.com>
Date:   Mon, 8 May 2023 13:13:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: defconfig: Enable UBIFS
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230417092243.967871-1-d-gole@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230417092243.967871-1-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/04/23 14:52, Dhruva Gole wrote:
> UBIFS is a file system for flash devices which works on top of UBI.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4f59fa575b47..a632d2a1db93 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -267,6 +267,8 @@ CONFIG_MTD_NAND_BRCMNAND=m
>   CONFIG_MTD_NAND_FSL_IFC=y
>   CONFIG_MTD_NAND_QCOM=y
>   CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_UBI=m
> +CONFIG_UBIFS_FS=m

Gentle ping on this patch, can we please pull this in since nobody has
raised any objections since over 3 weeks?

>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_NBD=m
>   CONFIG_VIRTIO_BLK=y

-- 
Thanks and Regards,
Dhruva Gole
