Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D376CD412
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjC2IJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjC2IJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:09:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731744AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:09:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u1so8330962wmn.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680077362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLdWMB6a0VCi83xicLt30Ext28QYexvZbROoSpMQLRk=;
        b=dHX5ZUMs6uiCsDicCRaKfn2wiHQwaOjDICT1/hlsL55ZWpIG8mD40idT2wyzDpaNTe
         BTqNjgx2JHuH0Nnhe9t8YDo9Kg8lUdYRIX2mGVqZT5xPM8YndmgxS3DbfjjIh01etp1t
         2eAeTkCdAL9Y5i8VNHjWDpIBSfR7yY+xisq1zEFmyQ4BHxa9JYu31NhBWK8ytuKzACFT
         D5gcu2WobCXPYVm8A56imQq2KOzKCHmad7dIrg4HgK+lSzy8TL9qq8SsmtxQVx/AO3Kj
         rC2I4mnNwnybLo/L48S/65m28gCAweaphtcHCou0e0DpjG20BkWBEd0Fjs/anMUyGMLi
         f+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLdWMB6a0VCi83xicLt30Ext28QYexvZbROoSpMQLRk=;
        b=UU2U8FfJWaYkU2v15BN+sK+2er5h9qoStu8FVjo/EKpWKZ0aiM7AYOhYxq9eKBqJU2
         tKcU977aCqSBfJJcIgEhXepgGc+fu552lbIMiHeKOVdAXgxYhRR5AbZzR4Vy/rv+wlcM
         HOc1QqxZhyNOuWaQQDUYGbmVJeEiLgqboy+rHquGyRrCFMQP8M/Wqy0sQwLQSJFVp0fW
         h8IMZ7RMEzYauRcXGw4jm/0r9gQlEv8Qvj36PDKnsXpsaQlKaol92F8JupY8pMZiV3Hg
         c3mV2Em2S8sTpS/Nzy9TI1O7uZJqxx375sXB3l7XkXIIlELC0dtj4JqWe9yfFPDbd7gl
         7bYA==
X-Gm-Message-State: AO0yUKUB6Cu0aL0ma5SQ8HJxaDszp+fYPfTKe8DoyVEDPJ1F92sU6//L
        0UNsPQS9aRo7ZBgbXtiJ5diaMA==
X-Google-Smtp-Source: AK7set+yuUUNR2BqBBq1FLddiUCg9y0X+HaaE5ZzLogipqWdnk833lB7mY3jsoAlG/n1rT4XTP1w2Q==
X-Received: by 2002:a1c:4b1a:0:b0:3eb:37ce:4c3d with SMTP id y26-20020a1c4b1a000000b003eb37ce4c3dmr13865061wma.38.1680077362135;
        Wed, 29 Mar 2023 01:09:22 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003ee8ab8d6cfsm1393756wmn.21.2023.03.29.01.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:09:21 -0700 (PDT)
Message-ID: <447abc1b-b4a3-5848-c99a-ecbff11486fe@linaro.org>
Date:   Wed, 29 Mar 2023 09:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mtd: rawnand: meson: fix bitmask for length in command
 word
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
References: <3794ffbf-dfea-e96f-1f97-fe235b005e19@sberdevices.ru>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3794ffbf-dfea-e96f-1f97-fe235b005e19@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 08:47, Arseniy Krasnov wrote:
> Valid mask is 0x3FFF, without this patch the following problems were
> found:
> 
> 1) [    0.938914] Could not find a valid ONFI parameter page, trying
>                   bit-wise majority to recover it
>    [    0.947384] ONFI parameter recovery failed, aborting
> 
> 2) Read with disabled ECC mode was broken.
> 
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index a28574c00900..074e14225c06 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -280,7 +280,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>  
>  	if (raw) {
>  		len = mtd->writesize + mtd->oobsize;
> -		cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
> +		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);

What happens when len > GENMASK(13, 0)? Do you check this somewhere?

Please introduce a macro/field for GENMASK(13, 0), having such mask
scattered along the code looks hackish and doesn't help readability.
You'll get to use FIELD_PREP as well.

>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  		return;
>  	}
> @@ -544,7 +544,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>  	if (ret)
>  		goto out;
>  
> -	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
> +	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  
>  	meson_nfc_drain_cmd(nfc);
> @@ -568,7 +568,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>  	if (ret)
>  		return ret;
>  
> -	cmd = NFC_CMD_M2N | (len & GENMASK(5, 0));
> +	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  
>  	meson_nfc_drain_cmd(nfc);
