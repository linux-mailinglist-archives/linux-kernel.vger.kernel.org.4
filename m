Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4BD60AAB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiJXNgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiJXNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:31:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B75FE3;
        Mon, 24 Oct 2022 05:34:24 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13b23e29e36so10914254fac.8;
        Mon, 24 Oct 2022 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcGmlCRK6WN6ZG/jGCj5N7yle6pB40XVPW0Ha2mB7cY=;
        b=DTyl13zwGNI2L2P0eMGz201o5eswiW6LlwdR60hIrSy/znAIVU1lUBxbGenC4PNpGf
         pbyBoWWKkUt67+Ny7ETdFAG+Ds3tVPWZM33rJHvrjEBntMpi8IsvJ0NdFEWuOoTlhqGi
         YPWL0ArMWnF/3RD1g64XvWXSK4w1xZa2GTvX39dqWw6AxT9Acyx5fX/POelQ3MDOMnXv
         7CXUKY0j0nLQtqVE+JnEdmV/mzwa6LnCrQi4Th+h817ifxACqR7mDpRl1X2hFYO/hoJp
         hiJm5/5gDjV2zDZpxIZZHKHWsHr0fODP7aKd8bYD22N9aJ9+a5SMfnKpMIWIHRo2RQEz
         42Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcGmlCRK6WN6ZG/jGCj5N7yle6pB40XVPW0Ha2mB7cY=;
        b=O/BxyEqg8R10D3BX5YqIsqZWP4qfZ7ipLatO7BMUUy97+QU+K4F1VsRYqtrKAuzcgG
         ajOr736tcXVL/s33ZX/RKVLTTrceP63NhUZ9NAsD0p10PXvzjjwPHNAyLDfOcMvTIDzv
         lVsEFfXmXDEFHFrIMDeZcyRpkCegKTLT4bExUXbetx9RF+2W5ioOZTw2bvUkQLrkHVzv
         ILrJg5/8DZMeA1VlqdUm8GMa5V+YKmZzkCu2dQuFb2OvdLplfk1LjErceO++a8vE6A5k
         fAlg7paWAdhc9ZDXgWWV15hZZEkoRdXQG7FQOunp/JE1tRnr0WLwKublVjgacqUwin+9
         yLxA==
X-Gm-Message-State: ACrzQf0Y0dxSe8vqmMEusOXxeYiadzzuI4T1oxv7bMyK4dnWGzZy49wF
        9bexbWqFjzifYr1qXUIU4m+atCbopqWVFWEszulSmkUA
X-Google-Smtp-Source: AMsMyM5Wbatd2b2pPEV9BD4wN0+HBaMvhyEYRz3gNUPz+1LXWj2fimEF21KkWd8k2azbwYnuNj3bLbqg/JRTVhk8W+U=
X-Received: by 2002:a17:90b:190f:b0:211:5d2a:ade9 with SMTP id
 mp15-20020a17090b190f00b002115d2aade9mr28048950pjb.76.1666612643319; Mon, 24
 Oct 2022 04:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221024115429.1343257-1-heiko.thiery@gmail.com>
In-Reply-To: <20221024115429.1343257-1-heiko.thiery@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Oct 2022 08:57:11 -0300
Message-ID: <CAOMZO5B11Jbnr-3_86QA7Vec-YLGu6+Rv8TxBsMcn7bSG9ZhDw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Oct 24, 2022 at 8:54 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:
>
> With that delay U-Boot is not able to store the environment variables in
> the SD card. Since the delay is not required it can be remove.
>
> Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)
>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v3:
>  - Improve commit message and explain why it is a fix (thanks to Fabio)

Reviewed-by: Fabio Estevam <festevam@gmail.com>
