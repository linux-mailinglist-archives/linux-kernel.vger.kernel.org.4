Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89E733FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbjFQJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:37:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EBE6A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:37:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d20548adso1052035f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686994647; x=1689586647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RZsSEqkPqjOoyob7BwESxMJrfyBSDtQOVj//55DVlk=;
        b=g32b9Eu3F61GLUFvjdDWkKEgaosZry8knKL6Uqa3EbHmUjO7A9YJSyk3Vaoosg36ay
         95pzVspZ3iU1/5n24G3LpARjEkOFaSaBMAHXQhqghrD7icDm3n7J82XND2GTuEUVDxQT
         fHSiZ8P9VeeNdrtyKQybN+aTfeK/XOIapxze48ShpUbjdK3oSeKB9GQY/lcepWx+gBxN
         d65q7mxulB2HTOtOdCwOrOz2ZP219GrIGG6efYlfvW4BLFA6qM2wskzU7DFuJt87x3Ac
         LtyspTcunuhvuhGegmGWhT4B1kZes2Ma5XmlyOMxxgqUc6uDTqHwEtgrKft861dxFVlq
         NYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686994647; x=1689586647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RZsSEqkPqjOoyob7BwESxMJrfyBSDtQOVj//55DVlk=;
        b=kP3VHib1dWlwftv4r64oWhEUtxwT0yrNBv9sskmVXnGEgpBcJ4U9Ae0qRpah8wZrVR
         EoYbilRnXgyyMNvY3e85OraHrqyUbuJdXvQwuayhluz++acEC/JH/yK95hPYkfXKhO5B
         bDqA7HbIIGUCqLXIEvEMvsmeI2CAkkxrst4CgbVbxEEqmIgl2dV5GzSxYcsFIdQOvNkf
         +GRxzRoBjDi7eVlSfF2Lit2bEfGGrtHqnDE4o6DnjNHqYhG9Zb9bnIMNRkxzTYk5Kox7
         k5vwCsyfruaPnfp9QKxF80kvGVuNLPnc6zGAJhw9Dlzg2gMB5GPkFbFOc3MJ3oLOqPgW
         5TzA==
X-Gm-Message-State: AC+VfDwadDhMXvGPuE5RV2nX2aTvNvO8GhNez7Hwnsa981bDbhnNm4r7
        h8OOWSX8kAxxJPh0I+K+A0EFnfN/hr0qsgrWqtikTg==
X-Google-Smtp-Source: ACHHUZ4A4TANxWCTCFqJqNCqV+3Guz04XkAgLUa2iOUseEYh9FGN03ZfyLtVRwGI8HT4ItPAbaFckg==
X-Received: by 2002:a05:6000:1008:b0:307:8c47:a266 with SMTP id a8-20020a056000100800b003078c47a266mr2520982wrx.61.1686994647030;
        Sat, 17 Jun 2023 02:37:27 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm25786861wro.95.2023.06.17.02.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 02:37:26 -0700 (PDT)
Date:   Sat, 17 Jun 2023 10:37:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZI1+1OG9Ut1MqsUC@equinox>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612110040.849318-2-jordyzomer@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:00:40AM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..ecf2b458c108 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -264,6 +264,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/nospec.h>
>  #include <linux/slab.h> 
>  #include <linux/cdrom.h>
>  #include <linux/sysctl.h>
> @@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	/* Prevent arg from speculatively bypassing the length check */
> +	barrier_nospec();
> +
>  	info = kmalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

Hi Jordy,

Looks good to me,
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

I will forward on for inclusion.

Regards,
Phil
