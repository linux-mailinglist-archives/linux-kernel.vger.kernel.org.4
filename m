Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66AF6DB3FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDGTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDGTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:16:46 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6821EB463
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:16:41 -0700 (PDT)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 037623F20A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680895000;
        bh=6sYEIBV5kXMam6UqwH6oM6O2pVhy0udkwjOT9QqT4is=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fhiy6iZH0KuXk0Xa0W+FN2+H1k8UGgOWYfoVufbuHsEDU3fMB78MuKQ8ecB4PR9rj
         GLyU19+Z5TgVUsmW1s5Y2zCbwgWVprFMq9bb8URGO9MCPNGrA4uNgRXY/UQD8RZY/e
         ClMhg1dI0IBrm5IdXvSNkmknWQaj8EY8whEF6xWVT7KMWcJ5cCF+7ILivI8GcdVrwr
         SWIAXbQigDBdPwAPp6B3JtHUze71pUdYC4UHtvtEOFw6KCMaKzjfUOLjXkpsnKlhV3
         sBb8Q5BLSXDAcZkYd+jJSce+0n7By5Z0HRXYOVgVWW+ubVYSdoFTJpBk81F6UbQuIN
         +bbH1kMwWi7Jw==
Received: by mail-qv1-f72.google.com with SMTP id o14-20020a0cc38e000000b005e62747d93aso2668497qvi.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680894999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sYEIBV5kXMam6UqwH6oM6O2pVhy0udkwjOT9QqT4is=;
        b=a2eTaSYpLieGOP2nR9pfCGuTz7nRHrlAP6EgmS6aNaGh9n05rfJy7igJRrmjA07ZPH
         XkGdYSpgqldIteD5CJ3RgzOKGL1N8oeoTSwwCmA3gWMEzFfh0m3zGKBTj9KUbuwbIcrY
         w03yeC4Uf8iQyQvlnAHpUYCRefE1mMQ3eKwMrG9yMmnm+sv+3VKaAOWcSgANKy7ckz/R
         lpao9iVwgdZWw1T0M62ZztZ0VfE1ATZ+14kdgAMJ7OJAHkCV+NgjXq6NEIZQs6EpKBXZ
         DFMCH3wstwpVoq1IrX1lfLO67pixhAxsB+4tvj951mT4Liq1J00cRCKvueNvNyH39Cmn
         D1iQ==
X-Gm-Message-State: AAQBX9eYXjJsVVeow2GhAtcER6pb1fJe85yjqw92i8FcTgaSkpaHsJ+r
        aTA77nE80O005D8YUDa0CfS8pNfEFRpbqU54cZvGiYH12zFp385LbaBQDcSCortxUp9PL1wXRv1
        6hWl7C9lT0bI+zErQCj/NAB/FYfPtgkHdtexlJi2JCMTU6cIdvER/2zN7+w==
X-Received: by 2002:ac8:59cf:0:b0:3bf:e265:9bf with SMTP id f15-20020ac859cf000000b003bfe26509bfmr1125156qtf.5.1680894999089;
        Fri, 07 Apr 2023 12:16:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350azJsoHtLW5iJVxAs7mqBBFmK9URhRqiPq9rW03ZcwqNgq7AmVUNj2Sw8I4d2ImHV3rL/4EjmZmsUuSs4OrUPc=
X-Received: by 2002:ac8:59cf:0:b0:3bf:e265:9bf with SMTP id
 f15-20020ac859cf000000b003bfe26509bfmr1125140qtf.5.1680894998772; Fri, 07 Apr
 2023 12:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230407110356.8449-1-samin.guo@starfivetech.com> <20230407110356.8449-7-samin.guo@starfivetech.com>
In-Reply-To: <20230407110356.8449-7-samin.guo@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 7 Apr 2023 21:16:22 +0200
Message-ID: <CAJM55Z9LF+p-jWQkPzK=0ovfrXN0b-E5Ed49sbC9xOdrH5SuKA@mail.gmail.com>
Subject: Re: [-net-next v11 6/6] net: stmmac: starfive-dmac: Add phy interface settings
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
        Pedro Moreira <pmmoreir@synopsys.com>,
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

Hi Samin,

If you're respinning this series anyway, please use "net: stmmac:
dwmac-starfive:" to match the filename.

On Fri, 7 Apr 2023 at 13:05, Samin Guo <samin.guo@starfivetech.com> wrote:
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
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 4963d4008485..d6a1eddb51e8 100644
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
> @@ -46,6 +50,46 @@ static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed)
>                 dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
>  }
>
> +static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +{
> +       struct starfive_dwmac *dwmac = plat_dat->bsp_priv;
> +       struct regmap *regmap;
> +       unsigned int args[2];
> +       unsigned int mode;
> +       int err;
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
> +       if (IS_ERR(regmap))
> +               return dev_err_probe(dwmac->dev, PTR_ERR(regmap), "syscon regmap failed\n");

This message is a bit misleading. It's not actually that the regmap
failed, but getting/looking up the regmap failed.

> +       /* args[0]:offset  args[1]: shift */
> +       err = regmap_update_bits(regmap, args[0],
> +                                STARFIVE_DWMAC_PHY_INFT_FIELD << args[1],
> +                                mode << args[1]);
> +       if (err)
> +               return dev_err_probe(dwmac->dev, err, "error setting phy mode\n");
> +
> +       return 0;
> +}
> +
>  static int starfive_dwmac_probe(struct platform_device *pdev)
>  {
>         struct plat_stmmacenet_data *plat_dat;
> @@ -91,6 +135,10 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>         plat_dat->bsp_priv = dwmac;
>         plat_dat->dma_cfg->dche = true;
>
> +       err = starfive_dwmac_set_mode(plat_dat);
> +       if (err)
> +               return err;
> +
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
