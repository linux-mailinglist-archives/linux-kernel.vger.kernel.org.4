Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42A68FDFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjBIDbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjBIDaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:30:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F853580
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:30:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id f6so1439634pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynm5YDNy6wcGn0EJjvlzzZ1xEB+UsfPBkImjjL8XoAs=;
        b=d1s3KZm3RPrzckGBfTN1l7phbnT0auQM1xfqJC5KIlfApVpjCB+EboJqnHefcD0VKG
         3F4bfkWVtLv5M2TSZ7W2JM7lmrt9HQ4UH1DleNm+Aj8iEdeZfgkYrK5ZchZYR121qFOq
         MTkSKvpi1J7E/zghgJGfBKy7Jt213M3Y8Rgs9BNyhiV8Tyv1Eiuh51Qa6O5NisBWXbub
         jMWC0SYrJGcaIl5iOk7ZB6zI9bae43UaEHcGDDSan4jPzExaOCmzXL4GKcrTw9UDGZcJ
         u3TUgL+mpiAv0FtrkV0JjKqXQ/4lGQxQf6yxttTGKUcgbXIPWkCiJDaqbXQPB9dzHX7Y
         7dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynm5YDNy6wcGn0EJjvlzzZ1xEB+UsfPBkImjjL8XoAs=;
        b=zAPrqzcWpqHYgCOEommWTOFmxE3KqB9wBMjOP7dtlvrJXKVzt8pzKd/7NFMzSjcCrz
         BmEqZoquliVBWccqHit6SbK8g/zPqZVedVsWOXZO7tcYy98hu1nyS3kLjYZqsPrvg6f5
         9qmcoo8VC9Br9lqPYe42DWom02SiIPQLJK7UeJ559bMIj1gFtbh1PgRmXMSFkZ/NomJd
         6Epy0DiH90aMbLN9qmwmhMJBQIW1AzNCkFHxxnVvB5KFckWs1YjKqhmdBcByuAJd0NCC
         6ITvQOJeQkZgSQFe0/80jGahAUrM1cp9yo4LpGYKE3dfmgV/D9fHKA8ukD2dLgdXccS6
         ZT6w==
X-Gm-Message-State: AO0yUKWyMKjVVwOMbETnZ1RkiqEI2ukh5flhFfFze2myahHhwhV2ou0Z
        ww3QeQNyx5p8eaNkBYSBg4I=
X-Google-Smtp-Source: AK7set8y75DwEB+NEpOeE3Qt/AFjnbz2f2clpWbT3NxooXsaJY83We2CjNffGMf4S2TErpYSZxFbBg==
X-Received: by 2002:a17:903:32c9:b0:196:82d2:93a with SMTP id i9-20020a17090332c900b0019682d2093amr12749822plr.11.1675913416946;
        Wed, 08 Feb 2023 19:30:16 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id jl24-20020a170903135800b0019608291564sm221877plb.134.2023.02.08.19.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Feb 2023 19:30:16 -0800 (PST)
Date:   Thu, 9 Feb 2023 11:36:00 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v3 1/2] erofs: update print symbols for various flags in
 trace
Message-ID: <20230209113600.000051c1.zbestahu@gmail.com>
In-Reply-To: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
References: <20230209024825.17335-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Feb 2023 10:48:24 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> As new flags introduced, the corresponding print symbols for trace are
> not added accordingly.  Add these missing print symbols for these flags.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
> v3: print symbols for EROFS_GET_BLOCKS_RAW is deleted in patch 2
> ---
>  include/trace/events/erofs.h | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index e095d36db939..f0e43e40a4a1 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -19,12 +19,18 @@ struct erofs_map_blocks;
>  		{ 1,		"DIR" })
>  
>  #define show_map_flags(flags) __print_flags(flags, "|",	\
> -	{ EROFS_GET_BLOCKS_RAW,	"RAW" })
> +	{ EROFS_GET_BLOCKS_RAW,		"RAW" },	\
> +	{ EROFS_GET_BLOCKS_FIEMAP,	"FIEMAP" },	\
> +	{ EROFS_GET_BLOCKS_READMORE,	"READMORE" },	\
> +	{ EROFS_GET_BLOCKS_FINDTAIL,	"FINDTAIL" })
>  
>  #define show_mflags(flags) __print_flags(flags, "",	\
> -	{ EROFS_MAP_MAPPED,	"M" },			\
> -	{ EROFS_MAP_META,	"I" },			\
> -	{ EROFS_MAP_ENCODED,	"E" })
> +	{ EROFS_MAP_MAPPED,		"M" },		\
> +	{ EROFS_MAP_META,		"I" },		\
> +	{ EROFS_MAP_ENCODED,		"E" },		\
> +	{ EROFS_MAP_FULL_MAPPED,	"F" },		\
> +	{ EROFS_MAP_FRAGMENT,		"R" },		\
> +	{ EROFS_MAP_PARTIAL_REF,	"P" })
>  
>  TRACE_EVENT(erofs_lookup,
>  

