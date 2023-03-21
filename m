Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1246C33DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCUOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCUOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:16:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9AE1B337
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:16:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m35so9663535wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679408172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTf4SFGvPPUH4a0PRrn6TfKCJyApZZxth8R3YNjD0S4=;
        b=lrGHU2vNwiejsHlaaBi6XrslNBo7vy249y7bQt/jTbqjrw6H703gB7PQInlelyXOVg
         XpUmZ+Di6KAOEplmoIDqTaaSv6tdALTazZMx/T09cO/6db6um9NOq6P+fwRq0s2hV1Mo
         Z3PrcT6ASbTycNjAbOz44lS7vO0XKdPXb3hMWxEXg7jDoMAbA5PGHPtCvy83IrZOl4BL
         fzmEN5WRsOAF/GjBuEdC7OuXhOO5NywlH/eUiI68VOhFCSi4f8v63ssCUmt6WniJD/Ju
         XY8R2i/vSd9rTKxfU/Rz6aOA7xXPREWWt+9r7h+5ozy789B9m/L5suTT3lstd8SUzMHy
         ma/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTf4SFGvPPUH4a0PRrn6TfKCJyApZZxth8R3YNjD0S4=;
        b=ofyA1YlumWw/C18w25uTREfja8G5xuGbA82Yr1mvz+Tyr6Ko6KIYf/OyLljeIO5BR1
         ATr3v3eAWR68dCz2xDWAqChpPXPtFHZtVupl/6atuOf7XmrgAiUmY1zOfnu3Kr6Mpxvh
         o/P0dgfbDZP8nytxYNQCoQ7nN3R++NVlOUtW3BsxA4SVFPUk//c1XV1IjaeK+YZGHhr7
         kbxsM6J5ioE5EQ/Ku/jdy4476hOs5Rrv0aWaFGwNDp3+LeR93dnGkPo5/jcwLuGJfBbA
         RaT51myPQgaQMRGng/mCg6U+6FV1i/YtG4VUtrWF6HmImNyTlW5Ay3igSyeMJHznwYtx
         H4tA==
X-Gm-Message-State: AO0yUKUlGXdMfY8YBZ/C3reCmVdC/8/ASf1agxKrXZWZu0GFuIsWGf70
        N77PGRvOVCrHF90b4wh16dvuvUVy2mOyMA==
X-Google-Smtp-Source: AK7set/b+JE78TqRXj3ubJBmPsRmXOUN7cB7sBTtlvamu22wSNF49RDmsukXzOfjOWwCbs8Y9ogNKw==
X-Received: by 2002:a05:600c:3649:b0:3ed:2a8f:e6dd with SMTP id y9-20020a05600c364900b003ed2a8fe6ddmr2357117wmq.6.1679408172584;
        Tue, 21 Mar 2023 07:16:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003ede03e4369sm7971218wmg.33.2023.03.21.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:16:12 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:36:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Inshal Khan <kziaul123@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Staging: rtl8712: osdep_intf: Improve RND4 macro for
 better debugging and safety
Message-ID: <d3307a75-fcc0-4a94-8a05-05b871f4fa9f@kili.mountain>
References: <ZBmX9cjTRNhwt2zA@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBmX9cjTRNhwt2zA@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:11:41PM +0530, Inshal Khan wrote:
>  drivers/staging/rtl8712/osdep_intf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
> index 95a21f380cd7..0e097b4a8670 100644
> --- a/drivers/staging/rtl8712/osdep_intf.h
> +++ b/drivers/staging/rtl8712/osdep_intf.h
> @@ -18,8 +18,8 @@
>  #include "drv_types.h"
>  
>  #define RND4(x)	({ \
> -		typeof(x) _x = (x); \
> -		(((_x) + 3) & ~3); \
> +			typeof(x) _x = (x); \
> +			(((_x) + 3) & ~3); \

Just use normal kernel rounding macros and delete RND4().

regards,
dan carpenter

