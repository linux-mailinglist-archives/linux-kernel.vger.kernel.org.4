Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A7D6D743C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjDEGLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbjDEGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:11:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373384C0E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:10:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-942e6555947so18982266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680675030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lipWrU7ws8k0XHEltTp4ENTKDfUcjLK1gcfrrHJGo04=;
        b=PDgHyB8Il+v13U2eTHVi9Y2+DCycCYbHRsy7N3nzNjwZm9E8MEHIpZ7X3ENqBRVLHC
         TauOYvso5D6msadjl9C31D+rsq7pa1/0xkcAYEeaMN040Ebd8y0wTfyQL9liIi4qq9/r
         REf4ORC4VVc9nAaLaKRg9p0ry3BuSZr05nV9yx+vgPXncoDv9VnNDE6tVrmfF7XytqjY
         Rc69Py5wwpaJPEruezMUqYPji7RRWb7hBA+uoTfVWgEy9nUSR8QWF6NiqMW5UEzDbD0f
         xgQp1ESwra0fG4vpRGTH2jR61gEA0BuFcQH52qZ3vfxijPpZdcWAc50VZKsUbACfMh/Q
         7UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680675030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lipWrU7ws8k0XHEltTp4ENTKDfUcjLK1gcfrrHJGo04=;
        b=O8V121TPmn5epU9utuFK5dsdnPEDZFAQIo6UG1YYfumN6GjBZYBsQC3gAdFYNpBfRh
         wEm6+cx2IpJCMV8A0dI1Qv0InREJ6s9eLfoRUHzNC3XS1ZXyKnDFIOd9gq0jX1rmMIbt
         wwnA8gLYRlm2OPpEfk+9YAEINkRpupW+44fNIJDtxJQAXhAEqogborSUPEDkT9bbT4pi
         9a5X2F7jRt+JSS55NCd0dejkiN0WNBF03cIlh5SYYL1qwKpzM8lmEeMFByHaM1ELSeIs
         OjgZKIZKEUJorNXDCKsoJoFvCilfYQ+jW+gK3k4VoQY8Tgntwxnk0CR1D6O9AIehg+90
         5OcQ==
X-Gm-Message-State: AAQBX9eRYJAF0KUeiWdIoWNwgMd2G3ywtO7UlS5OiNQACCUEK9JcJnW/
        dMdY9NssR2SQmoQHUD/D2XA4Ow==
X-Google-Smtp-Source: AKy350YcrBZIVBKAPF6vi4k4l80HzGn44inlozPi5a4JPPs+ZT+6sK3AHg+3Z2uiK4YlNMeFSw8LCw==
X-Received: by 2002:a05:6402:3d9:b0:4fd:2346:7225 with SMTP id t25-20020a05640203d900b004fd23467225mr927888edw.34.1680675030593;
        Tue, 04 Apr 2023 23:10:30 -0700 (PDT)
Received: from [192.168.2.173] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id y2-20020a50ce02000000b004fa268da13esm6799708edi.56.2023.04.04.23.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:10:30 -0700 (PDT)
Message-ID: <4d3513a0-6553-73de-1cf8-619627a7a445@linaro.org>
Date:   Wed, 5 Apr 2023 09:10:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mtd: spi-nor: Allow post_sfdp hook to return errors
Content-Language: en-US
To:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, michael@walle.cc
Cc:     bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230405060751.49056-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230405060751.49056-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.04.2023 09:07, Tudor Ambarus wrote:
> Multi die flashes like s25hl02gt need to determine the page_size at
> run-time by querying a configuration register for each die. Since the
> number of dice is determined in an optional SFDP table, SCCR MC, the
> page size configuration must be done in the post_sfdp hook. Allow
> post_sfdp to return errors, as reading the configuration register might
> return errors.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/mtd/spi-nor/core.h      |  2 +-
>  drivers/mtd/spi-nor/micron-st.c |  4 +++-
>  drivers/mtd/spi-nor/sfdp.c      | 10 ++++++----
>  drivers/mtd/spi-nor/spansion.c  | 12 +++++++++---
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 8cfa82ed06c7..a9e5e091547d 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -426,7 +426,7 @@ struct spi_nor_fixups {
>  	int (*post_bfpt)(struct spi_nor *nor,
>  			 const struct sfdp_parameter_header *bfpt_header,
>  			 const struct sfdp_bfpt *bfpt);
> -	void (*post_sfdp)(struct spi_nor *nor);
> +	int (*post_sfdp)(struct spi_nor *nor);
>  	void (*late_init)(struct spi_nor *nor);
>  };
>  
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index a6f080112a51..4b919756a205 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -131,7 +131,7 @@ static void mt35xu512aba_default_init(struct spi_nor *nor)
>  	nor->params->octal_dtr_enable = micron_st_nor_octal_dtr_enable;
>  }
>  
> -static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
> +static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	/* Set the Fast Read settings. */
>  	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> @@ -149,6 +149,8 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
>  	 * disable it.
>  	 */
>  	nor->params->quad_enable = NULL;
> +
> +	return 0;
>  }
>  
>  static const struct spi_nor_fixups mt35xu512aba_fixups = {
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 69e47c9778a2..e501686a6dc3 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -1260,14 +1260,16 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
>   * Used to tweak various flash parameters when information provided by the SFDP
>   * tables are wrong.
>   */
> -static void spi_nor_post_sfdp_fixups(struct spi_nor *nor)
> +static int spi_nor_post_sfdp_fixups(struct spi_nor *nor)
>  {
>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>  	    nor->manufacturer->fixups->post_sfdp)
> -		nor->manufacturer->fixups->post_sfdp(nor);
> +		return nor->manufacturer->fixups->post_sfdp(nor);

oops, this excludes the next call, sending v2
>  
>  	if (nor->info->fixups && nor->info->fixups->post_sfdp)
> -		nor->info->fixups->post_sfdp(nor);
> +		return nor->info->fixups->post_sfdp(nor);
> +
> +	return 0;
>  }
>  
>  /**
> @@ -1477,7 +1479,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
>  		}
>  	}
>  
> -	spi_nor_post_sfdp_fixups(nor);
> +	err = spi_nor_post_sfdp_fixups(nor);
>  exit:
>  	kfree(param_headers);
>  	return err;
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index c937f0ac61de..519fdad79a19 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -370,7 +370,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
>  	return cypress_nor_get_page_size(nor);
>  }
>  
> -static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
> +static int s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = nor->params;
>  
> @@ -379,6 +379,8 @@ static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
>  				SPINOR_OP_PP_1_1_4_4B,
>  				SNOR_PROTO_1_1_4);
> +
> +	return 0;
>  }
>  
>  static void s25fs256t_late_init(struct spi_nor *nor)
> @@ -409,7 +411,7 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
>  	return cypress_nor_get_page_size(nor);
>  }
>  
> -static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
> +static int s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	struct spi_nor_erase_type *erase_type =
>  					nor->params->erase_map.erase_type;
> @@ -431,6 +433,8 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  			break;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static void s25hx_t_late_init(struct spi_nor *nor)
> @@ -463,7 +467,7 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  			cypress_nor_octal_dtr_dis(nor);
>  }
>  
> -static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
> +static int s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  {
>  	/*
>  	 * On older versions of the flash the xSPI Profile 1.0 table has the
> @@ -489,6 +493,8 @@ static void s28hx_t_post_sfdp_fixup(struct spi_nor *nor)
>  	 * actual value for that is 4.
>  	 */
>  	nor->params->rdsr_addr_nbytes = 4;
> +
> +	return 0;
>  }
>  
>  static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
