Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5450E716232
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjE3Nhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjE3Nhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:37:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88669A1;
        Tue, 30 May 2023 06:37:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3b9755961so4886919e87.0;
        Tue, 30 May 2023 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685453863; x=1688045863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L62hZYIJeAwZ9usNe6gVxdmiFJEVpK/92EzkmikJeAc=;
        b=nxh6Bv8kYKSXo0qN2fySHv2hANhTTro5mrIyiRfi6cgxasQgIOaJSY9pXRT9Pwqiqo
         HqmryrFyfl+vAVi8o+n2t/gTaMJvoESYqCnx5lFwjYydRDFT1+D65fQw1KZi/BuFjmF4
         xRNaaiZRHZ2jgLWkTnnSgDO7+fjJMyi60IEG6N6vN6JTkOCbiNrEFug8b+yAsjwp15py
         RlQ59rq+WkzKwk6iaok0EquaacPVk4r86bhnxYYM+PhX/ipN/1ya/OdBCfS56f2ngEil
         stTzjzYYDRSrOEY/jX420FveVvc6KDMyoHk+xMiSAT0STET/X8YBM28skeyO6lIoZMNX
         TDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685453863; x=1688045863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L62hZYIJeAwZ9usNe6gVxdmiFJEVpK/92EzkmikJeAc=;
        b=hswiA/c3XM+d0zEG3t2Uo6nsjSpHf3Ds4JCcqWvuxx9I7iWhyPjHvJOPIcqL2/ZCtX
         ChZdSbzeOSsHgYVT/m8w7S1CVztG82yVT/qGGd47l9zMIY3BYqiBnkAkfQ821HUBQw+3
         zqpcoCp2ljjUuDum4Z+8n7gst9bCn2Im+gqkBCqtBSvORQZVLiSk43tTC1VzGqYRwV5B
         teKAp+C0Py7x/dP7B3qJ4uHKgWVWcs5L7n9ItZe7k6tkQuGZ8fPjqdA0f80SgRKGUtuP
         8NZIQZw2NgAR7Aw7GacQ2W5fwZstTzW891KkCRZEN44Y3EZSAwk76QnSaraazitJ7h8j
         5W3Q==
X-Gm-Message-State: AC+VfDwHvU0ZvEKZELYjh/HskLqpFoF1X4/NOR6eODtpWIwbcGDo1Nxh
        kZphkthRQHPS4hRnLOemxtHlPchIJ/A=
X-Google-Smtp-Source: ACHHUZ7hwGBCWY/vgg5RqBO5TG0PwY5kN7FhGacLOsnjJrz5hMcVM2XaZ87cGC8MBaVIfkkQ6ZHk0A==
X-Received: by 2002:ac2:43ba:0:b0:4f1:5015:43c4 with SMTP id t26-20020ac243ba000000b004f1501543c4mr800676lfl.38.1685453862683;
        Tue, 30 May 2023 06:37:42 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004efff420b11sm343522lfd.181.2023.05.30.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:37:42 -0700 (PDT)
Date:   Tue, 30 May 2023 16:37:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 2/2] MIPS: generic: Allow R5 CPUs to be selected
Message-ID: <20230530133740.2w2sbqg3hjhe2q2q@mobilestation>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <20230529135245.4085-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529135245.4085-2-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:52:45PM +0100, Jiaxun Yang wrote:
> Since we do have P5600 bitfile for boston board, we should
> allow generic kernel to be compiled for R5 CPUs.

Would be good to place the outcomes from the Patch 1/2 discussion here.

> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Anyway. Thanks for the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e437bf43ecfc..215fcdc059d2 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -154,9 +154,11 @@ config MIPS_GENERIC_KERNEL
>  	select SWAP_IO_SPACE
>  	select SYS_HAS_CPU_MIPS32_R1
>  	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_HAS_CPU_MIPS32_R5
>  	select SYS_HAS_CPU_MIPS32_R6
>  	select SYS_HAS_CPU_MIPS64_R1
>  	select SYS_HAS_CPU_MIPS64_R2
> +	select SYS_HAS_CPU_MIPS64_R5
>  	select SYS_HAS_CPU_MIPS64_R6
>  	select SYS_SUPPORTS_32BIT_KERNEL
>  	select SYS_SUPPORTS_64BIT_KERNEL
> -- 
> 2.39.2 (Apple Git-143)
> 
