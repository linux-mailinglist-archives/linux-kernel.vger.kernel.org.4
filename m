Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BD5B325E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIIIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiIIIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248D12D183
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:52:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d2so1608287wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jP0pFkmG2zxr05jAdP1hMbeqbKg9CqioB38AAHYVmvI=;
        b=MWcZT2bBh9VDvvGbZLvEXabNfeumwaVjX+C8C2lPoW4Lzw2BVRn9kf1sdPts0yU59Z
         6w+JLleDLWIcIh/3S3Ff0eN/U+jzEy41q+IYpzzmHe/N1iGnVQZSoQzADliQBn1KENxq
         j38StCiYIncAbOmbMVjX78rijk0Ts7f0yZTOaxH8hL704wVr3jhAv8dT3/8RORO1kP02
         PsR0Nv6voD2mRfTNa2D3quz4Yg5ywoWqkPBTATHfI4uio4FeFwF5pTbCW4cXqCupay9F
         QlaIOHDnK9FTYRmjbW0ZA98pihdseqyVQPMNL9xDTi90hZxNEGC4PFTZK7QNfNtUzIit
         EgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jP0pFkmG2zxr05jAdP1hMbeqbKg9CqioB38AAHYVmvI=;
        b=M8Icl/l6qJZQKXpPwvYgvdHyiX6T2vUiDGkFK/Grc8QwBffLktnCmlAeh2dwIDR7+T
         ojnsVTVh4/1As+VKsY7OO4a1CLLIg3sDpMOAHlurYlWKHi4NElo7Cj4WHkpJCVkqBHxR
         FzcuEEcZgOP04liypbdqVDDUqMQaD5YnROTM//U/p8oyO3J4sVAmmDawCbWH9/Wa3bsr
         kEKFkFoUg7p5ZkqpMqVrmanvOh9nBxDa7KNQ+cBVD35q0AUdPIeQWdMG5EOpz5QCu5yf
         LYOmvs8G9HRUL55XVcC1K1j+XHopQk8gLq4mzxZD6EJWrNxzqIhFh1IF/Z2X35+50n2d
         FPkw==
X-Gm-Message-State: ACgBeo0B/FEZQrDVl6ZKYmmrfi9fH9XUrE5t1Ts4O31ioNzxxKyNW3Ok
        wb8mVA+IVBlLgkYsazR1xUMzew==
X-Google-Smtp-Source: AA6agR7U4hYZ9NiomZcOOo9VGy/PUI8bKuRPuMPqKufZMN5CbjFrj0TUBx99J+MQ2ojU8hv9P1zvqw==
X-Received: by 2002:a05:6000:110d:b0:228:db67:75c4 with SMTP id z13-20020a056000110d00b00228db6775c4mr7518711wrw.217.1662713543296;
        Fri, 09 Sep 2022 01:52:23 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id q3-20020adff783000000b0021f15514e7fsm21381wrp.0.2022.09.09.01.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:52:22 -0700 (PDT)
Message-ID: <373b10aa-f5c8-28b3-88b0-f87a1a40b000@linaro.org>
Date:   Fri, 9 Sep 2022 09:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 13/20] nvmem: core: drop priv pointer in post process
 callback
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-14-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220901221857.2600340-14-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2022 23:18, Michael Walle wrote:
> It doesn't make any more sense to have a opaque pointer set up by the
> nvmem device. Usually, the layout isn't associated with a particular
> nvmem device.
> 
This is really not a good idea to remove the context pointer, as this is 
the only way for callback to get context which it can make use of.

I would prefer this to be left as it is.

--srini

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>   - new patch
> 
>   drivers/nvmem/core.c           | 4 ++--
>   drivers/nvmem/imx-ocotp.c      | 4 ++--
>   include/linux/nvmem-provider.h | 5 +++--
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index d31d3f0ab517..6910796937f9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1523,8 +1523,8 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
>   		nvmem_shift_read_buffer_in_place(cell, buf);
>   
>   	if (cell->read_post_process) {
> -		rc = cell->read_post_process(nvmem->priv, id, index,
> -					     cell->offset, buf, cell->bytes);
> +		rc = cell->read_post_process(id, index, cell->offset, buf,
> +					     cell->bytes);
>   		if (rc)
>   			return rc;
>   	}
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index ac0edb6398f1..5e869d4a81c5 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned int offset,
>   	return ret;
>   }
>   
> -static int imx_ocotp_cell_pp(void *context, const char *id, int index,
> -			     unsigned int offset, void *data, size_t bytes)
> +static int imx_ocotp_cell_pp(const char *id, int index, unsigned int offset,
> +			     void *data, size_t bytes)
>   {
>   	u8 *buf = data;
>   	int i;
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 9d22dc5a3fa5..46067a6a0395 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -19,8 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
>   typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>   				 void *val, size_t bytes);
>   /* used for vendor specific post processing of cell data */
> -typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, int index,
> -					 unsigned int offset, void *buf, size_t bytes);
> +typedef int (*nvmem_cell_post_process_t)(const char *id, int index,
> +					 unsigned int offset, void *buf,
> +					 size_t bytes);
>   
>   enum nvmem_type {
>   	NVMEM_TYPE_UNKNOWN = 0,
