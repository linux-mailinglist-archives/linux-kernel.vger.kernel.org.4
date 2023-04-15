Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980C76E324D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjDOQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDOQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:08:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7263AA5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4my/HdVpvEW7ZsohZBuFTRTyuBzPr6i6gOfM7+nk0bs=; b=PvXjVvdgAC+nBUCJF2RkC1Kayr
        Zru0Yo8URlH+eWoljrVADs4S4LuZFpov7rLs31nhVbOV+LvnvAGDSwEYVep1dNA/XYkTRLYCHMTQk
        UMo4b4OtIdNfx6CTrKSzRLLiZeLGly/9xXBLVcM+/nTdnsXpZfeiPCIo2JP1fb9XemTGExMB1+9Dm
        fMWZn/+e5yzFeSdwvvrZhGPHN600/UDKPT1TnPh5ujg1jE0EY7ASAZZi+SLXO/cl3de+j4e8Gh7lP
        SpuHv5NgV1eajwbAihIiVWRelyOQ9D1UiUh6qEet5qsa4DZDQycu+BKUDZqvuMOtTbToDCsLEfEO5
        1Z5N3QxQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pniS5-00CQCg-2V;
        Sat, 15 Apr 2023 16:08:37 +0000
Message-ID: <84fd6222-89e8-58de-f386-b51af8cf9ebe@infradead.org>
Date:   Sat, 15 Apr 2023 09:08:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/15] w1: ds2433: correct kerneldoc annotation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
 <20230415104304.104134-2-krzysztof.kozlowski@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230415104304.104134-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/23 03:42, Krzysztof Kozlowski wrote:
> Correct kerneldoc comments (or drop annotation) to fix:
> 
>   w1_ds2433.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment.
>   w1_ds2433.c:141: warning: This comment starts with '/**', but isn't a kernel-doc comment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/w1/slaves/w1_ds2433.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
> index 0f72df15a024..6134ca2f37fe 100644
> --- a/drivers/w1/slaves/w1_ds2433.c
> +++ b/drivers/w1/slaves/w1_ds2433.c
> @@ -42,7 +42,7 @@ struct w1_f23_data {
>  	u32	validcrc;
>  };
>  
> -/**
> +/*
>   * Check the file size bounds and adjusts count as needed.
>   * This would not be needed if the file size didn't reset to 0 after a write.
>   */
> @@ -138,16 +138,17 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
>  }
>  
>  /**
> - * Writes to the scratchpad and reads it back for verification.
> + * w1_f23_write() - Writes to the scratchpad and reads it back for verification.
> + * @sl:		The slave structure
> + * @addr:	Address for the write
> + * @len:	length must be <= (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
> + * @data:	The data to write
> + *
>   * Then copies the scratchpad to EEPROM.
>   * The data must be on one page.
>   * The master must be locked.
>   *
> - * @param sl	The slave structure
> - * @param addr	Address for the write
> - * @param len   length must be <= (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
> - * @param data	The data to write
> - * @return	0=Success -1=failure
> + * Return:	0=Success, -1=failure
>   */
>  static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
>  {

-- 
~Randy
