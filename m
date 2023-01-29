Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8C68007E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjA2Rhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjA2Rhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:37:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D9119
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:37:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso7770959wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAL6s80AXM+XIKVK3wI20y7HYG7Hs9tx+FCABHAzBUM=;
        b=fduyUY71OvQ/GIHS+qgvArvtZ0n4w6sOGRL2uSsbCDRu6LElUclTj+swWfwJLwegXb
         5dREJIkWlZCDUJBRDjs6xKqx8T5+z8Cx8gv2KcUbQdZa85KYIv+HA30f+H1Ajb395Tpw
         BJqz4GR45wioEFVkwj1pRGr725UC05bYiuCthnQCREGm9AKesMslqqQj0mZ2q+onVQfm
         sY24k7d9XQ4I2kyGlZHkmWS4GekMWV7GVcnGIXghBLHEK5F5JSXeajJS+8Ou5ensZV4O
         OYOtYn50pJntfqqNG6ThqAtlSuWDLd+Fi8idBaENSdtHUkrBaBzcD7QgZ93ZtLtMrc7f
         CtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAL6s80AXM+XIKVK3wI20y7HYG7Hs9tx+FCABHAzBUM=;
        b=b0rPg0Rq1OI3imZR9vLsn5Soo56Mr33nGD7SwJjygoiWv3u3VY65/k2OTJVLR6oYEi
         DQeQjaZGpIK7TVYx9lROdlIRpAzviLPE243yM3frDdQgwN69w7Mn9bTQD0qiTaZVSX76
         P3pTSoFGqK/EsHSdRAauUGe51moyO7mjC5kDXL421NRvDHiTqPzCvtihd5WLNOhusuiw
         MgsV3t8sUPXaVgX2e55A9h+oiemGWPIWQfLXL2H0X0cGJ8fcIVj8bEbmAgr2TCehUtQm
         jLoCxrfI4Z2Vdy40YaukPavkZZwN7Z8GOp9OeOPpsDoEdPSUUHF48FBQzVlu0Ny6Cg2t
         nG5Q==
X-Gm-Message-State: AFqh2koO1bN7cKnjE5qG3Js6408+E+02LAEzgl19KUBBAJvKY8c+RARv
        uezKNqTlK/+jaMuC9AzciP3ejA==
X-Google-Smtp-Source: AMrXdXuR5gAMfmqDLdliVvRzowcIFg6DdokcNmYs24pvxoYrKK9ck/FP3emk/Se8p9FKL3/WNPookg==
X-Received: by 2002:a05:600c:310c:b0:3dc:d5c:76e0 with SMTP id g12-20020a05600c310c00b003dc0d5c76e0mr21171809wmo.22.1675013868594;
        Sun, 29 Jan 2023 09:37:48 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003db30be4a54sm13610441wms.38.2023.01.29.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:37:48 -0800 (PST)
Date:   Sun, 29 Jan 2023 19:37:46 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1 1/2] clk: imx6sll: add proper spdx license
 identifier
Message-ID: <Y9au6t91gMECzydj@linaro.org>
References: <20230119085421.102804-1-marcel@ziswiler.com>
 <20230119085421.102804-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119085421.102804-2-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 09:54:20, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error:
> 
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Improper SPDX
>  comment style for 'include/dt-bindings/clock/imx6sll-clock.h', please
>  use '/*' instead
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Missing or
>  malformed SPDX-License-Identifier tag in line 1
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
>  include/dt-bindings/clock/imx6sll-clock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
> index f446710fe63d..494fd0c37fb5 100644
> --- a/include/dt-bindings/clock/imx6sll-clock.h
> +++ b/include/dt-bindings/clock/imx6sll-clock.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   * Copyright 2017-2018 NXP.
> -- 
> 2.36.1
> 
