Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4115A5EB09D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIZS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIZS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:58:54 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58F6A49B;
        Mon, 26 Sep 2022 11:58:53 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1274ec87ad5so10539255fac.0;
        Mon, 26 Sep 2022 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zbSxAYa+S4SLhqXdiuG1/pxj5W4n/PshmvFvMJ6FuOs=;
        b=RhKSooat29vnWGGJ1MRcY/MTV0j7h3L01pJvhsesaqoBTuOJuQa4NWx8DoETqPqfKg
         /xa9x2vz+4aZJJ0KX7wbqqUsR2GO3FuwM+zbIDVAFbsVos1+KbhwJdCIX9TyFJAuQ15D
         r2zLSK62fQFC2qvmb/n1MbPNilxr8aJ3MAEjeWwv1NjTWVohYK7ErI5pkC09VOzgdWOs
         TgLp+oKJOd4q68j2ymoW6el+/YnBKX94fr9k5DAboRbw9GslqOufUbpriip1kWObZqL/
         wW5Fe7SdrEMc30vobKJubbHxKv+YlwXAJ7w4486WFqIUW1G2Eqe01KVqGlBhqW2os/cR
         /4sg==
X-Gm-Message-State: ACrzQf3auVdeERUtsooV5PhPaQw7PH/taEHsa1EpLGZqnegUAwqredot
        v9xogchemJh6RoNJQILxZQ==
X-Google-Smtp-Source: AMsMyM5KiiawLpglYP+YjV/EAoSeJPfC4zMVaKJ4G/SHGqccGTTbNtD8rDELy4Vywwc9vRuGW2z+Nw==
X-Received: by 2002:a05:6870:507:b0:130:ae8d:db0e with SMTP id j7-20020a056870050700b00130ae8ddb0emr113319oao.82.1664218733041;
        Mon, 26 Sep 2022 11:58:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k9-20020a056870570900b00130d060ce80sm4531663oap.31.2022.09.26.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:58:52 -0700 (PDT)
Received: (nullmailer pid 2586379 invoked by uid 1000);
        Mon, 26 Sep 2022 18:58:52 -0000
Date:   Mon, 26 Sep 2022 13:58:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: device: fix repeated words in comments
Message-ID: <20220926185852.GA2581083-robh@kernel.org>
References: <20220918094915.19567-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918094915.19567-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 05:49:15PM +0800, Jilin Yuan wrote:
> Delete the redundant word 'of'.

Again? Sigh.

Please read:

https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com/

> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Are you sure you are the author?

> ---
>  drivers/of/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 75b6cbffa755..6158173b92ad 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -19,7 +19,7 @@
>  
>  /**
>   * of_match_device - Tell if a struct device matches an of_device_id list
> - * @matches: array of of device match structures to search in
> + * @matches: array of device match structures to search in
>   * @dev: the of device structure to match against
>   *
>   * Used by a driver to check whether an platform_device present in the
> -- 
> 2.36.1
> 
> 
