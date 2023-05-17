Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774647060F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEQHRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQHRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:17:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C19E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:17:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so51300935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684307869; x=1686899869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3b7hHEbI+h5xExrBy/3T83CDD//SAXlI6SxFmf+dg6o=;
        b=k/U/uR+Kh2i8gM7Pk6RUGeZwy7PDiUYiTnAV/R3uiK0IqpFL70tKxc9hp7IdwFlPa7
         xUUIcNxQhDYAY9LsvdDpjgWgZEreMKVqY93hiz8/RlgBMI7BsE7GSEAfrdVM4Ig0bbQ9
         wR8PKfUscO1vVY2odj8vQH+U/hDGDbhVUg9tlVdFCoHVHRW09CsgiQ2/XIQfWJkGsRGK
         8JNjUNt9KtUO8fyuWb4LIXe298IL2XLTSEqP0ywZ2dnZuMG+yHqUq2Vcwq5YxkZgH3Pb
         QRSp4tt6bXwHCiJyXY3xuw/GoDx5ZqiJbVWaIbJecOaWmSRDltxEVHuM4b/uVGY8XIjK
         +Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684307869; x=1686899869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3b7hHEbI+h5xExrBy/3T83CDD//SAXlI6SxFmf+dg6o=;
        b=PDErS/ttFOKTGXhdxkeeJDLTgIc9EVMHEOHeSrp7hpylu1HC+GIqdsM9Hvr8E+YS2R
         90rtbQq6tXXuzo3wvVTcw85umNFPhF35B/iECt68eB+TmLmeNBM0H2/FezLv5HSkFT4m
         RgCmBMagrqQugCOTQAZkgsjSEVnwoS4HPylxe/sqi978+Os5PZEZpmtFCq26G2X+qk35
         skQzEFcuKBwl18FLzBW+FMtrieyL72WOtkbUQOUF9xAnZ1AJWEwnOMof9d4saFeC3VqF
         zYaH0+u8w2T5guNyzCGxhqiZXuno+Ugtc74XSuA7bUC+iQGKEg3x37Bmmra8b4QJwEYo
         GV1w==
X-Gm-Message-State: AC+VfDxZMUGumGi9bi9ih5fKL4TOnY32oLOx5S8FMpAf86Ja+aZmUdmV
        UPeUMLgi1xPpaPX+WxqI5WRLIQ==
X-Google-Smtp-Source: ACHHUZ7L8yq0YUXp4EkM5Pe8eXsIVBrvz531exY2hfJ5I3XU3mTKbCCNdU+W3txyHrHKucWdLC23/Q==
X-Received: by 2002:adf:ce8d:0:b0:307:cf71:ed8c with SMTP id r13-20020adfce8d000000b00307cf71ed8cmr780409wrn.35.1684307868772;
        Wed, 17 May 2023 00:17:48 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id d15-20020adff2cf000000b0030647449730sm1762852wrp.74.2023.05.17.00.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:17:48 -0700 (PDT)
Message-ID: <41d0bb3f-559d-ac70-9525-dd98b820a85c@linaro.org>
Date:   Wed, 17 May 2023 08:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] mtd: spi-nor: spansion: make sure local struct does
 not contain garbage
Content-Language: en-US
To:     miquel.raynal@bootlin.com
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
References: <749c2fc2-93dc-585-3826-dea581602d6e@linux-m68k.org>
 <20230509193900.948753-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230509193900.948753-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel, please consider this fix for -rc3.

cheers,
ta

On 5/9/23 20:39, Tudor Ambarus wrote:
> Following errors were seen with um-x86_64-gcc12/um-allyesconfig:
> + /kisskb/src/drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]:  => 495:27, 364:27
> 
> Initialise local struct spi_mem_op with all zeros at declaration in
> order to avoid using garbage data for fields that are not explicitly
> set afterwards.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: c87c9b11c53ce ("mtd: spi-nor: spansion: Determine current address mode")
> Fixes: 6afcc84080c41 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> v2:
> - init both local vars with all zeros at declaration
> - squash patches as the blamed commits were just introduced in this
>   merge window.
> 
>  drivers/mtd/spi-nor/spansion.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 15f9a80c10b9..36876aa849ed 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -361,7 +361,7 @@ static int cypress_nor_determine_addr_mode_by_sr1(struct spi_nor *nor,
>   */
>  static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
>  {
> -	struct spi_mem_op op;
> +	struct spi_mem_op op = {};
>  	u8 addr_mode;
>  	int ret;
>  
> @@ -492,7 +492,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  			  const struct sfdp_parameter_header *bfpt_header,
>  			  const struct sfdp_bfpt *bfpt)
>  {
> -	struct spi_mem_op op;
> +	struct spi_mem_op op = {};
>  	int ret;
>  
>  	ret = cypress_nor_set_addr_mode_nbytes(nor);
