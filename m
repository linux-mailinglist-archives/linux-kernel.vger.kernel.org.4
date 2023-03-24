Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DC6C7F57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCXOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjCXOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:00:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02E1BAE8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:59:49 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CA7A4166C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1679666379;
        bh=0CzCezUBFius1/QvCjfVKLrX7WEPXSwgwzTCxhDCoiA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qCS/UYShWWjYuJUvfsWa0wZfBAz++eP8q3/uuyMzQE6UymynpR/k+3ZP7G3OhQ+IR
         VJVjGR3TpTyVLYfTbFEJachqmC3rzEQS6JsE8Ecrad3RMSECIZutCHxQ1eHUxzxTEQ
         +8OrsiALQyVBbd/+bxsPs8hdItxnoJ55bvuKbQvOhQLnxpMXaMnRFnR2E25T1DC3HH
         auJ8JG0bXb/Ixdf19v/32NeojMFyPw9fwNYfxanTXNJDyZAyJWkDXMQTNIZkXCGz9C
         dqOTYKIoDtWhdNnYeWS0qRe95NCHzJfz1lQ5ZiWrhSfoUkrXmFcyzOilhKZAMmo5Dc
         Gsava+tZTrtGQ==
Received: by mail-qv1-f71.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so1041544qvm.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CzCezUBFius1/QvCjfVKLrX7WEPXSwgwzTCxhDCoiA=;
        b=VF39DkfZJPtF7FnA58cWF1idvBA3L+e9oKwRQCBQ5ZHzLv9D24m86aKYXn05pQC5eG
         LFemeV4Y2JQj0U4vte4eO1VLYfA7nmSc8CVNlOamdWNNJ0oZcaPv78uSqYrfK8Cl5xux
         a+VSOYnKqEHr5sxm5D4tSIxcqT4voA7t0abcVqSmNFNzEExQrQWousgUn//ebUc4LN38
         gjD/AiWIWuLQ32cuGLINTq6AuankB2TZHG33ej3OjSLcCiAoCtO2IEGjrAwhpNNdjdh3
         S+idD/FBS5YjBjFkJfEdJ2xC6ZhbzA7DxV/Gsjpohjdmwyjye5nNsDsrvavYx/Fi8a3H
         Yu5Q==
X-Gm-Message-State: AO0yUKX+tdJqQgDDHbZal8tB4yNYjlblVP9zT1ipWSoVjxukhFmRV4Hp
        mM8PtGdYQPvpvKkq4v+kf9MQ8kIjG3YfOc1XW6ILPTzxtntG4icwMT7bEkUne/fVi2zdObfimRZ
        qJHnCTUESO38J+KUXHYGfzSLsKgsAWaC2ns8hg1/OYrp5IwItZHGY/EcIOQ==
X-Received: by 2002:a37:a8cf:0:b0:745:8c04:2777 with SMTP id r198-20020a37a8cf000000b007458c042777mr503411qke.13.1679666377807;
        Fri, 24 Mar 2023 06:59:37 -0700 (PDT)
X-Google-Smtp-Source: AK7set+fYwdhVgyb9GNd32TrH8t4Pv6a28VQzyoEpE+xeNGm/T2XLuOweT5dKvtRVRvgDmnoGhBHVQhMCfEkxFGjGIU=
X-Received: by 2002:a37:a8cf:0:b0:745:8c04:2777 with SMTP id
 r198-20020a37a8cf000000b007458c042777mr503392qke.13.1679666377512; Fri, 24
 Mar 2023 06:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230324022819.2324-1-samin.guo@starfivetech.com> <20230324022819.2324-7-samin.guo@starfivetech.com>
In-Reply-To: <20230324022819.2324-7-samin.guo@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 24 Mar 2023 14:59:21 +0100
Message-ID: <CAJM55Z8_W9yOcL+yGAwB-qanD_-bbf16VjCP66P_xDFW6-c+3A@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] net: stmmac: starfive_dmac: Add phy interface settings
To:     Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jose Abreu <joabreu@synopsys.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 at 03:30, Samin Guo <samin.guo@starfivetech.com> wrote:
>
> dwmac supports multiple modess. When working under rmii and rgmii,
> you need to set different phy interfaces.
>
> According to the dwmac document, when working in rmii, it needs to be
> set to 0x4, and rgmii needs to be set to 0x1.
>
> The phy interface needs to be set in syscon, the format is as follows:
> starfive,syscon: <&syscon, offset, shift>
>
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index ef5a769b1c75..84690c8f0250 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -13,6 +13,10 @@
>
>  #include "stmmac_platform.h"
>
> +#define STARFIVE_DWMAC_PHY_INFT_RGMII  0x1
> +#define STARFIVE_DWMAC_PHY_INFT_RMII   0x4
> +#define STARFIVE_DWMAC_PHY_INFT_FIELD  0x7U
> +
>  struct starfive_dwmac {
>         struct device *dev;
>         struct clk *clk_tx;
> @@ -44,6 +48,43 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed)
>                 dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>  }
>
> +static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +{
> +       struct starfive_dwmac *dwmac = plat_dat->bsp_priv;
> +       struct regmap *regmap;
> +       unsigned int args[2];
> +       unsigned int mode;
> +
> +       switch (plat_dat->interface) {
> +       case PHY_INTERFACE_MODE_RMII:
> +               mode = STARFIVE_DWMAC_PHY_INFT_RMII;
> +               break;
> +
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               mode = STARFIVE_DWMAC_PHY_INFT_RGMII;
> +               break;
> +
> +       default:
> +               dev_err(dwmac->dev, "unsupported interface %d\n",
> +                       plat_dat->interface);
> +               return -EINVAL;
> +       }
> +
> +       regmap = syscon_regmap_lookup_by_phandle_args(dwmac->dev->of_node,
> +                                                     "starfive,syscon",
> +                                                     2, args);
> +       if (IS_ERR(regmap)) {
> +               dev_err(dwmac->dev, "syscon regmap failed.\n");
> +               return -ENXIO;
> +       }
> +
> +       /* args[0]:offset  args[1]: shift */
> +       return regmap_update_bits(regmap, args[0],
> +                                 STARFIVE_DWMAC_PHY_INFT_FIELD << args[1],
> +                                 mode << args[1]);
> +}
> +
>  static int starfive_dwmac_probe(struct platform_device *pdev)
>  {
>         struct plat_stmmacenet_data *plat_dat;
> @@ -89,6 +130,12 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>         plat_dat->bsp_priv = dwmac;
>         plat_dat->dma_cfg->dche = true;
>
> +       err = starfive_dwmac_set_mode(plat_dat);
> +       if (err) {
> +               dev_err(&pdev->dev, "dwmac set mode failed.\n");
> +               return err;
> +       }

Usually it's better to keep all error messages at the same "level".
Like this you'll get two error messages if
syscon_regmap_lookup_by_phandle_args fails. So I'd suggest moving this
message into the starfive_dwmac_set_mode function and while you're at
it you can do

err = regmap_update_bits(...);
if (err)
  return dev_err_probe(dwmac->dev, err, "error setting phy mode\n");

Also the file is called dwmac-starfive.c, so I'd expect the patch
header to be "net: stmmac: dwmac-starfive: Add phy interface
settings".

/Emil

>         err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>         if (err) {
>                 stmmac_remove_config_dt(pdev, plat_dat);
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
