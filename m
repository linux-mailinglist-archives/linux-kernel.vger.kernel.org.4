Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE763C680
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiK2Rfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiK2Rft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:35:49 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC769328;
        Tue, 29 Nov 2022 09:35:48 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12c8312131fso17916311fac.4;
        Tue, 29 Nov 2022 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RPeBrqlLllnhv+/xP5qeiX7uhtM5MABRLvbjSrXNkcA=;
        b=MUXMaN1YJxqasqEQgWhWdfdl97Sh0ikaRpvu4JTEovhw5IjCe6UgEN1wBKl8gU9+ox
         adWGbhemjB6+FJr7QdLFcD83cW617n3l2l+Bg57UGM5CBVtqhr5C8Zxv5Xd4nCwFnNLj
         mu4Df09fC28R1rxL9mgPOdsgKk0sK4iBltpz6WzxqtfGvfyHx7qxN3Xn2Dfe0BzBUWEm
         YxVx0MDx2ZEIv59Pz67tlKevKxZLszUeEtppSWDl2jPehVm43oL2E0hjFAA33cbd+gvp
         fkpcWhyXJiGK3XGCIxGLAe2IGNHVdIndFIXCCZ5jm8TGBiTVX6w0AZHmUMQHullmTTXu
         Ei5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPeBrqlLllnhv+/xP5qeiX7uhtM5MABRLvbjSrXNkcA=;
        b=Khw4/0u0BSFfXqMZ61JqFUj3c08WHI4d5BEOnlMBvzdjOdSwKVNh7c4flWZuVfNaYN
         Rf/XfFxkoAzFoA7tAFBIg7UCh6GXf7k0/LIIHsdf1IgTXxWLN35p22CmBjfdm7E9ep+6
         zR15/sJ8XO/vctzgqj9jAGJJifDy4+2mMnhgMItvn8f54jslSFXSUQl1qelbP9PfWEL3
         Kpw+hRlY6AOB6IzLDaVUM2IWINOXFSJ+vzhRoP+EYqevA40Pp890HkuKtQSUMlHITtmT
         snGqR3MIvH8d7ykJbYpQkWkzDzrRjH1iJkDNHTsPVUf3gRH7M8G9yFs1DAVCtEJPh9ay
         RPyQ==
X-Gm-Message-State: ANoB5pmQkbJna1hKrGyJITtA/Nitb+1e/HSZkdQZz78cRoG9MPeui1rr
        SoOeUqAnx28AkrzO0ew98C95Zvgz3aA=
X-Google-Smtp-Source: AA0mqf7pQyfHGcbevAT2V2dLYkTWAlVvQ+0+xk5w/L3Olgeiihs6cLvmKb0ae2fdNxG4zoMzto6ZaA==
X-Received: by 2002:a05:6870:591:b0:13b:bbbb:1623 with SMTP id m17-20020a056870059100b0013bbbbb1623mr24392682oap.115.1669743348085;
        Tue, 29 Nov 2022 09:35:48 -0800 (PST)
Received: from wintermute. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id p36-20020a056870832400b00132741e966asm7780724oae.51.2022.11.29.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:35:47 -0800 (PST)
Message-ID: <638642f3.050a0220.8b7f1.d555@mx.google.com>
X-Google-Original-Message-ID: <20221129173545.GA9712@wintermute.>
Date:   Tue, 29 Nov 2022 11:35:45 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix refcount leak in rk817_charger_probe
References: <20221128142740.1414-1-linqiheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128142740.1414-1-linqiheng@huawei.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:27:40PM +0800, Qiheng Lin wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Good catch, thank you!

Reviewed-by: Chris Morgan <macromorgan@hotmail.com>

> ---
>  drivers/power/supply/rk817_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> index 635f051b0821..d25a81d79fac 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1060,8 +1060,10 @@ static int rk817_charger_probe(struct platform_device *pdev)
>  		return -ENODEV;
> 
>  	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> -	if (!charger)
> +	if (!charger) {
> +		of_node_put(node);
>  		return -ENOMEM;
> +	}
> 
>  	charger->rk808 = rk808;
> 
> --
> 2.32.0
> 
