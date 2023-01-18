Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64067213F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjARP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjARP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:27:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA01CAE0;
        Wed, 18 Jan 2023 07:26:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r30so9892548wrr.10;
        Wed, 18 Jan 2023 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypPAzYEJSbtUHwI+8APhdCEH8lcbIVf9Cb/fG9P1p/Q=;
        b=b1LFdXq6UsyoNYZJSZ7z8zdAZJUQLpfM6RxV1TR5vx6KIgxuoZC3qsNzovOh7JxmRQ
         6nIahIMfk2OG02NbwbUDdoJvTV4IfPa0t5kepbJN307sQzfI8PlGNtccTZ32nadKN7TV
         8ZLcuBHPCHaGNkRujMRps8KheTLYciw3l987dtIRqa7jRQZUarzSPGKC3wwSGS/QatUd
         PxOz4L8+gSqtPXnNdqt/VcSL5sLr9HQDZ+U6z/9zjCT1ai3ly7jyLJhSBurpHwMv2kJ7
         dLWlkA/GJZJ+xpVocP9jSjzD5PWfSYz+XMuMDLk928f8SRGesjK4lp2NXTdQPKLNoTcU
         m+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypPAzYEJSbtUHwI+8APhdCEH8lcbIVf9Cb/fG9P1p/Q=;
        b=hltsJIWENzUTdUmFnsI8JDiFJvkLfrGX0wUkw1TK1y+Pn2RlUuxp/uwxEgmZnNtrVd
         CYbpwL+Gnhc4bHLLhNO5rfnEgQQp7thWPb++X7+8hutW3kZZF5yxIqbZKz0/0aWB/70G
         rOHzjmE18DPsEI7402lT30l4epjibtfWVgztYxFzLksa0wFU3+39C+mTu0MourgKXSgS
         iSV1YQe4eVGvZd5ulm4eI/fXwapOL0FR+gNwdGKyqaUQkAjvikykmBHHZLpUyCdl+rE4
         GWa83f7G80tPjgvIhSEkS2xtk13vCOwJUR0MYk+CIcu9x3VcVmuYirtx6XBbb4gHKN6i
         AWOw==
X-Gm-Message-State: AFqh2krgn6fZ8WMh0nWyotbMLGDE4h+6V/8h5a+TMqqSgB7uHsR0RREp
        xRah9Pw2XkyGA4LHAiFI2lU=
X-Google-Smtp-Source: AMrXdXuCq08opotKRprCnH9Sx/BDKWlGWP9FMJHuvV3tcH8bNrfV2MD+oeI500xtKhdsjeZCYtClJg==
X-Received: by 2002:a05:6000:5c2:b0:2bb:eb3d:8d20 with SMTP id bh2-20020a05600005c200b002bbeb3d8d20mr3483580wrb.43.1674055614334;
        Wed, 18 Jan 2023 07:26:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056000078900b002be1dcb6efbsm5451116wrb.9.2023.01.18.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:26:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 18:26:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     ailus@linux.intel.com, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH v5] media: atomisp: pci: Replace bytes macros with
 functions
Message-ID: <Y8gPuh+WDO6vJPu+@kadam>
References: <Y8gImBdR6YpEKZEb@kadam>
 <20230118151656.20558-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118151656.20558-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:16:56AM -0500, Brent Pappas wrote:
> Replace the function-like macros FPNTBL_BYTES(), SCTBL_BYTES(), and
> MORPH_PLANE_BYTES() with functions to comply with Linux coding style
> standards.
> Replace multiplication with calls to array_size() and array3_size()
> to prevent accidental arithmetic overflow.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
> Changelog:
> V1 -> V2: Use size_mul() to perform size_t multiplication without risk of
> 		  overflow.
> 		  Remove the inline keyword from function definitions.
> 
> V2 -> V3: Add commit message.
> 
> V3 -> V4: Use array_size() and array3_size() for multiplication.
> 
> V4 -> V5: Fix indentation.
> 
>  .../staging/media/atomisp/pci/sh_css_params.c | 38 +++++++++++--------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
> index f08564f58242..7e111df5c09d 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_params.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
> @@ -98,17 +98,27 @@
>  #include "sh_css_frac.h"
>  #include "ia_css_bufq.h"
>  
> -#define FPNTBL_BYTES(binary) \
> -	(sizeof(char) * (binary)->in_frame_info.res.height * \
> -	 (binary)->in_frame_info.padded_width)
> +static size_t fpntbl_bytes(const struct ia_css_binary *binary)
> +{
> +	return array3_size(sizeof(char),
> +					   binary->in_frame_info.res.height,
> +					   binary->in_frame_info.padded_width);

Nope.

> +}
>  
> -#define SCTBL_BYTES(binary) \
> -	(sizeof(unsigned short) * (binary)->sctbl_height * \
> -	 (binary)->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS)
> +static size_t sctbl_bytes(const struct ia_css_binary *binary)
> +{
> +	return array_size(sizeof(unsigned short),
> +					  array3_size(binary->sctbl_height,
> +						      binary->sctbl_aligned_width_per_color,
> +								  IA_CSS_SC_NUM_COLORS));

Also nope.

> +}
>  
> -#define MORPH_PLANE_BYTES(binary) \
> -	(SH_CSS_MORPH_TABLE_ELEM_BYTES * (binary)->morph_tbl_aligned_width * \
> -	 (binary)->morph_tbl_height)
> +static size_t morph_plane_bytes(const struct ia_css_binary *binary)
> +{
> +	return array3_size(SH_CSS_MORPH_TABLE_ELEM_BYTES,
> +					   binary->morph_tbl_aligned_width,
> +					   binary->morph_tbl_height);

Nope.

> +}

regards,
dan carpenter

