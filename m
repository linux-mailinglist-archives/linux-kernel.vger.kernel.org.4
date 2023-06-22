Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCB739FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjFVLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVLjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:39:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2E1BE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:38:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f8792d2e86so4908985e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687433930; x=1690025930;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMvBbqevt6fz2GgJuqzMS1tZRMa6rROyUcT/PkIxy+c=;
        b=n2jxzZW24hxQ7VWBD5Wk3DxP0g3z49AD6qqrxIWPh86FMp6UrfuWHK0bdvTXJxXylE
         CMTUMAp9Km4iJPyTX7NJQpKQQJiAelzJtA25RwUJaSYVH7DGoir/DDgD+WAFKlFDo/aI
         ClyH6CHdxEy94iHNPWB8D+wNfjdLGhn36enHysdZYzO30A5f/sFt3Jl0/ZkHbTCoY/p4
         0bh11XTaR4+h016Km508z126Bw2worap8bFkaVZ09z+21xbGIz04cPsu6B752DlPLUkd
         clw5yf/ia/Ihb5hKFSiKXt/1H4T/qXZV7XOPV50NAx/OrBucE51/CfuDW0yNczul/J/s
         JXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687433930; x=1690025930;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMvBbqevt6fz2GgJuqzMS1tZRMa6rROyUcT/PkIxy+c=;
        b=ST9kl6rsCeBJefvXjoe5dEINwlCocNtDbOfXc27PYNjAyLIvnNDLmqvexfuhgSVSai
         ZGiak/ZMZneja71f7G0ArAz+1+pKqaPxgjBznOUFn57IPLzSR83p0P81RBfiov3I5LWQ
         YfC47b/93Bv8A7c2nwjDmVL1Mrt3IIpaRfGttXwYn3aseSnhT2ofIQbynnOI7Zw8asmu
         nVAGGLylKeYfcc9e9pOsvdchOalV35UIO+Jf6sNbacrMlKn9lNAYeSzBSMjl5o7nSgaM
         U/XZsqDIkI8hSUjRLTRB9v7iP9lJdul14Gp049ygyoJx1suZ74EYR3wc9mUSv7pfeME0
         XeOw==
X-Gm-Message-State: AC+VfDzUppoqvhdziR5pbKt50i3wSRQqgLKilsbLsNYvJB/o/o+GfNrA
        ME1xbEGMRpdboTIe1KDVZJ0zZKwF9C0=
X-Google-Smtp-Source: ACHHUZ6+0H8VrwAoguy64er6Go7pAUWQhtdIA6KK5K6o5uSJlNwrfURjjvY51H6Om0gn2euC50U16g==
X-Received: by 2002:a05:6512:23a6:b0:4f9:641a:56b8 with SMTP id c38-20020a05651223a600b004f9641a56b8mr1413810lfv.65.1687433929980;
        Thu, 22 Jun 2023 04:38:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-154-132.dynamic.spd-mgts.ru. [109.252.154.132])
        by smtp.googlemail.com with ESMTPSA id w10-20020ac254aa000000b004e843d6244csm1080788lfk.99.2023.06.22.04.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 04:38:49 -0700 (PDT)
Message-ID: <a8d2bde9-174c-afed-f0e5-ed1ed2d1df0d@gmail.com>
Date:   Thu, 22 Jun 2023 14:38:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] misc/genalloc: Name subpools by of_node_full_name()
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230622074520.3058027-1-linus.walleij@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20230622074520.3058027-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.06.2023 10:45, Linus Walleij пишет:
> A previous commit tried to come up with more generic subpool
> names, but this isn't quite working: the node name was used
> elsewhere to match pools to consumers which regressed the
> nVidia Tegra 2/3 video decoder.
> 
> Revert back to an earlier approach using of_node_full_name()
> instead of just the name to make sure the pool name is more
> unique, and change both sites using this in the kernel.
> 
> It is not perfect since two SRAM nodes could have the same
> subpool name but it makes the situation better than before.
> 
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Fixes: 21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/misc/sram.c | 2 +-
>  lib/genalloc.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 5757adf418b1..61209739dc43 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -236,7 +236,7 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
>  			}
>  			if (!label)
>  				block->label = devm_kasprintf(sram->dev, GFP_KERNEL,
> -							      "%s", dev_name(sram->dev));
> +							      "%s", of_node_full_name(child));
>  			else
>  				block->label = devm_kstrdup(sram->dev,
>  							    label, GFP_KERNEL);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index 0c883d6fbd44..6c644f954bc5 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -895,7 +895,7 @@ struct gen_pool *of_gen_pool_get(struct device_node *np,
>  
>  		of_property_read_string(np_pool, "label", &name);
>  		if (!name)
> -			name = np_pool->name;
> +			name = of_node_full_name(np_pool);
>  	}
>  	if (pdev)
>  		pool = gen_pool_get(&pdev->dev, name);

Works great, thanks!

Tested-by: Dmitry Osipenko <digetx@gmail.com>

