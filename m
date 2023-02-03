Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631F68A06B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBCRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjBCRfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:35:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813AA4286
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:34:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e6so5921593plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MEBOqmYVnowGWJ+YUaXh/f1azcKJtjNGDvdAjfhbvM8=;
        b=Oi4o51kyoZSIiv6oYeYU/HtBKTh+/VItEK86CZvJmWamElZCPxm2M2Ks4EKlchMEpj
         oWaIBy/N/xoSjfK7aa6QWIGo/DTfnc5hy7JN/JlVGYRX5DHeg8o0api455JJsdMXJ6hs
         Oe+htTPTXhakszXR5NTyAUP//SlusjacK6HTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEBOqmYVnowGWJ+YUaXh/f1azcKJtjNGDvdAjfhbvM8=;
        b=xVPIvgRRMmtngjLAM3B0Nq1V2XCZeAYEOZz28BHcuJPHbo8LDir1XHYNneLBjCtSdg
         bQ5qbQPTyhwWfrtePLdh8Z7dXMNy0wyYHiUTBmABNa82ssHVBgJyJdut846TRPXjY9mZ
         0nOs+UiBk5Xt8kkHPqsxzIQb3nZf3Z+E6vCvQIV4g/hu6tXxcG/Fh52hEOdy5yLVPueM
         MDX+wjzR7awRT4tlhOzlKsWaA1hY2T/dYLZ5aV2R9NU+FkliGMxZXZsnB9m0K6QbSm1P
         EVMm7kqdDOCrMuLIXueZGO1lN9AHAgqTUo9n5BeF0ugHJjV0Zj+8GD2c7El46AMpE4Pd
         pPCQ==
X-Gm-Message-State: AO0yUKW3K4TUKW8yNXAzoSSUp46+qaFZVIZPayGHDR/ymonm/RP765d9
        AWX8YMI07H41hRQGMt75aADJjA==
X-Google-Smtp-Source: AK7set/AQM0Ji9+iu7yCcSHpz6XZp/wkU/jWpC1o+zuY10aEF2jgUrFy3VWn1v2JSZ0ZdVNmWx49DQ==
X-Received: by 2002:a05:6a20:9381:b0:be:d873:9998 with SMTP id x1-20020a056a20938100b000bed8739998mr14324339pzh.4.1675445668562;
        Fri, 03 Feb 2023 09:34:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b26-20020a63715a000000b004784cdc196dsm1755947pgn.24.2023.02.03.09.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:34:28 -0800 (PST)
Message-ID: <63dd45a4.630a0220.a9771.37d9@mx.google.com>
X-Google-Original-Message-ID: <202302031734.@keescook>
Date:   Fri, 3 Feb 2023 17:34:27 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Update to upstream version
 v1.6.1-66-gabbd523bae6e
References: <20230203172430.474431-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203172430.474431-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:24:29AM -0600, Rob Herring wrote:
> This adds the following commits from upstream:
> 
> abbd523bae6e pylibfdt: Work-around SWIG limitations with flexible arrays
> a41509bea3e7 libfdt: Replace deprecated 0-length arrays with proper flexible arrays
> 2cd89f862cdb dtc: Warning rather than error on possible truncation of cell values
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your help with this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/dtc/dtc-parser.y  | 11 ++++++++---
>  scripts/dtc/libfdt/fdt.h  |  4 ++--
>  scripts/dtc/version_gen.h |  2 +-
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
> index 46457d4bc0aa..bff1337ec266 100644
> --- a/scripts/dtc/dtc-parser.y
> +++ b/scripts/dtc/dtc-parser.y
> @@ -404,9 +404,14 @@ arrayprefix:
>  				 * within the mask to one (i.e. | in the
>  				 * mask), all bits are one.
>  				 */
> -				if (($2 > mask) && (($2 | mask) != -1ULL))
> -					ERROR(&@2, "Value out of range for"
> -					      " %d-bit array element", $1.bits);
> +				if (($2 > mask) && (($2 | mask) != -1ULL)) {
> +					char *loc = srcpos_string(&@2);
> +					fprintf(stderr,
> +						"WARNING: %s: Value 0x%016" PRIx64
> +						" truncated to 0x%0*" PRIx64 "\n",
> +						loc, $2, $1.bits / 4, ($2 & mask));
> +					free(loc);
> +				}
>  			}
>  
>  			$$.data = data_append_integer($1.data, $2, $1.bits);
> diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
> index f2e68807f277..0c91aa7f67b5 100644
> --- a/scripts/dtc/libfdt/fdt.h
> +++ b/scripts/dtc/libfdt/fdt.h
> @@ -35,14 +35,14 @@ struct fdt_reserve_entry {
>  
>  struct fdt_node_header {
>  	fdt32_t tag;
> -	char name[0];
> +	char name[];
>  };
>  
>  struct fdt_property {
>  	fdt32_t tag;
>  	fdt32_t len;
>  	fdt32_t nameoff;
> -	char data[0];
> +	char data[];
>  };
>  
>  #endif /* !__ASSEMBLY */
> diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
> index 0f303087b043..99614ec1a289 100644
> --- a/scripts/dtc/version_gen.h
> +++ b/scripts/dtc/version_gen.h
> @@ -1 +1 @@
> -#define DTC_VERSION "DTC 1.6.1-g55778a03"
> +#define DTC_VERSION "DTC 1.6.1-gabbd523b"
> -- 
> 2.39.0
> 

-- 
Kees Cook
