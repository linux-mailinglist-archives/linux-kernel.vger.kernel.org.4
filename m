Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F985BD583
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiISUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiISUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:05:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBD48EAF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:05:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fs14so741998pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3mao7f5jVNZX08MqEeIxZymewe1+TVg9pBkmGQi0xQw=;
        b=soZB+RBfbYVEGaRKSti7J1OPW3wrlO4Z4NW2SsM/poVoe7jskG8ZFGH0UnDDgqNcNF
         6zUXqgznefT96aJXduVmFcYFEPr+CpAZe9LYyy0NcN1NEj9i3lN/ZAMO4QgmZMEd9j0g
         kQE5xndEzclgySkEI+QI+SNd6xNSNLwpUljMO2qdLesqS8nlyrceSjZa/XwKkMCeSShI
         7Xy12xMy3CkUH24qEYLyPW2fsmlkz7hNPXhjqOTtXV8snOqoIk6BBMG/kxPnLcqPgPDG
         ZHKzRLhUaZi9FRQBI6Tm1/S88StgpWL3myzSz5ZYpk1vgNyktWKEjIksm9B8vCIAvawD
         Xotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3mao7f5jVNZX08MqEeIxZymewe1+TVg9pBkmGQi0xQw=;
        b=Fwqj0YXoBCJNmBKDJBCUJHcorfRH+F7fkMTF9e798rhZ/vgp54Osle3LTwigm5XR0p
         WKB9LmDL2rBrp8wTYhYBr/ARHObFpyWv+z6IXSbBa9MlSY8JMx+NRerjxg0KjrVRaWrM
         rBYnCyVss7CzQggbF0AEigPwh55IYWuvFoM1syFpdR9969K/P1rxywPW93pMeG3v4Gik
         HhIimWaEwRWta70beEN1v0Xsti11ewu0irDG9OKbsJK28mrgmGR+uZKeGPsmteVZUg/m
         TNqJsNVGDYBJFyIZhRMghg6/i6IfysDJQO/LGO5MWNc37ecqnQHRJxTC0K1guPTzMGIW
         Gxug==
X-Gm-Message-State: ACrzQf3lo47oGrWWlCbVpKfgQSoit36k0oY+QXhZzynweSf71Bancxg0
        qlMccIokBVzuFHOn/JWMklVYbQdC9qiTeQ==
X-Google-Smtp-Source: AMsMyM49MbzERWuQOKEJLX3qmH2Yoajb931/+ouuCz6bP+3bYe6yq6xy2sF4RdMWhib32J87H8gQSA==
X-Received: by 2002:a17:902:eb90:b0:176:b24a:e69b with SMTP id q16-20020a170902eb9000b00176b24ae69bmr1387246plg.86.1663617934546;
        Mon, 19 Sep 2022 13:05:34 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w63-20020a626242000000b0053dec787698sm21564482pfb.175.2022.09.19.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:05:33 -0700 (PDT)
Date:   Mon, 19 Sep 2022 14:05:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/remoteproc: fix repeated words in comments
Message-ID: <20220919200531.GB759648@p14s>
References: <20220908123237.16911-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908123237.16911-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:32:37PM +0800, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Applied.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..6e8849f0df18 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -346,7 +346,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  		if (rproc_check_carveout_da(rproc, mem, rsc->vring[i].da, size))
>  			return -ENOMEM;
>  	} else {
> -		/* Register carveout in in list */
> +		/* Register carveout in list */
>  		mem = rproc_mem_entry_init(dev, NULL, 0,
>  					   size, rsc->vring[i].da,
>  					   rproc_alloc_carveout,
> -- 
> 2.36.1
> 
