Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126106ED1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjDXP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:56:31 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69E422A;
        Mon, 24 Apr 2023 08:56:30 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a5f765d5b8so3542757a34.3;
        Mon, 24 Apr 2023 08:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351790; x=1684943790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ospy+0e+g7CaAevMAfgtm5j51EvWWuU+Q6as+suKlmE=;
        b=bE8JLpTL2Yp/X4bq787vES61o+o+x62tCx98JpdQ9CV0teWrqzr7EFh1oI4vtsp/Fk
         HKea0FdkpuUnucvJtCVP67a+nhUwpKgEfyZgEFuw/egnP2tYh8NqmLIm7xW1SwVscu5U
         I+vrgjKwryW1PDRiDBsPFPxN1+65sDwfV96EIKwX4rYn0kHRKK/x1GUKrrFucEz39LVE
         dtgYKkbn5xAUUXrxgKtL7s9aOD48wpnCHvhJcdIJLLlbTCqdidTzM3+Pxsjnm1DmBG3J
         tXTRFFmaRAfh2xNtIwzJtZAjW7oqMsWIF9NYjQA3GXvjD2SmjfPtayjMyjnekRWsdTPG
         2ZpQ==
X-Gm-Message-State: AAQBX9eGggcBnqjJCPIYNPQj7fjObIkEZSOoe/raD23hcI//JS0sxsH+
        3e2oeh+IYvjWEJwOnGqICTPexjl9kQ==
X-Google-Smtp-Source: AKy350aQBab5M7kAF+uXaFdNg48iN7n8UM9QhRUPI5ShiaOukm/0Mb2cnXeg2yclCJr4/1Y7Yv2L+Q==
X-Received: by 2002:a9d:7415:0:b0:6a5:ff5f:f923 with SMTP id n21-20020a9d7415000000b006a5ff5ff923mr7803527otk.29.1682351790171;
        Mon, 24 Apr 2023 08:56:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h5-20020a9d6405000000b006a65be836acsm1417089otl.16.2023.04.24.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 08:56:29 -0700 (PDT)
Received: (nullmailer pid 2704587 invoked by uid 1000);
        Mon, 24 Apr 2023 15:56:29 -0000
Date:   Mon, 24 Apr 2023 10:56:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/43] rtc: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <20230424155629.GA2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-9-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-9-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:24PM +0300, Nikita Shubin wrote:
> - Find register range from the device tree.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     Arnd Bergmann:
>     - wildcards ep93xx to something meaningful, i.e. ep9301
>     - drop wrappers
> 
>  drivers/rtc/rtc-ep93xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
> index acae7f16808f..8bda20a4940a 100644
> --- a/drivers/rtc/rtc-ep93xx.c
> +++ b/drivers/rtc/rtc-ep93xx.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/rtc.h>
> +#include <linux/of.h>

linux/mod_devicetable.h is the actual header you depend on.

>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/gfp.h>
> @@ -148,9 +149,16 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
>  	return devm_rtc_register_device(ep93xx_rtc->rtc);
>  }
>  
> +static const struct of_device_id ep93xx_rtc_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-rtc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_rtc_of_ids);
> +
>  static struct platform_driver ep93xx_rtc_driver = {
>  	.driver		= {
>  		.name	= "ep93xx-rtc",
> +		.of_match_table = ep93xx_rtc_of_ids,
>  	},
>  	.probe		= ep93xx_rtc_probe,
>  };
> -- 
> 2.39.2
> 
