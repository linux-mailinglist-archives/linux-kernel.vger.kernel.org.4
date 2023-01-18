Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9F6711BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 04:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjARDU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 22:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjARDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 22:20:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7D521D3;
        Tue, 17 Jan 2023 19:20:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so16945699ejc.12;
        Tue, 17 Jan 2023 19:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8FzgOUe3N6aaG9WcYlJy+T4HQMpFm5yBh2i8Tj448wA=;
        b=jhYPbsnIxrHWZQj/falPBOBFXlgFF9aBZZYvuLYD55LhbnYoeDIV4uRhgDAcVq7dI6
         9yOp2fPT5trimwTR0KCVpNJWkH3AWE5ctEySeyHVVAkPBsAaexXLaBpDbSRjC0yz9+hS
         juoEpJfv2521BVAXNKkkfWW5l3ho/1EuYdC3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FzgOUe3N6aaG9WcYlJy+T4HQMpFm5yBh2i8Tj448wA=;
        b=G3eVmGjORW/NM4oSKlTY8Wo2bqVlloU9+RlrWrcTmlgmGdBKMDnUJJyLnQ5SIxBCnG
         PI5IPTv8QwVaYhw43iKPW1/Nwgwg1PJqpHhk4jHVIGxltgwIeteayPQHgjjR/g8a2Ovj
         TcqUg6Ycypatdl8YvQI0cgLIFct/H3fkv/PkS13OVo5e/aft0vzsSzafxwmSXqYPSdo5
         RqwX2swofInUYdV8jNfs7WpqXqqu69XR671XE8Nhs7r9agzxlUJvpbvFkuCQBwIgmLQ3
         3x4lAWQx1TDjj1nAu0tH23GItfTTLIinShFm+UW7Oc37xuvDsIh4aUAX4H2jr7gcm3np
         GH1w==
X-Gm-Message-State: AFqh2krIAjYwPhfPv2cB1ovqN/Qp+LAHWAq0mZvGTqBlV3d0dEllvBiN
        DTQGClTtfQzKszzIDwH5eWjW87dbqPPX6WBZE3g=
X-Google-Smtp-Source: AMrXdXvJg7JrQ0tQpOiGpYa3Hc2tprQvleaQu13cmOeI6UjvDDfMyHMpwohsZsAvZq+uHsMty/a3nlybLbMFu/LNHGs=
X-Received: by 2002:a17:907:9541:b0:84d:3532:eca9 with SMTP id
 ex1-20020a170907954100b0084d3532eca9mr479621ejc.394.1674012021802; Tue, 17
 Jan 2023 19:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20221025055046.1704920-1-potin.lai.pt@gmail.com>
In-Reply-To: <20221025055046.1704920-1-potin.lai.pt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 18 Jan 2023 03:20:09 +0000
Message-ID: <CACPK8XcgzVPkmKLim7FTbsAn7W4h+d_DMnrpwHHRdWau3qcrYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: dts: aspeed-g6: add aliases for mdio nodes
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 05:52, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add aliases for mdio nodes so that we can use name to lookup the
> bus address of Aspeed SOC.
>
> For example:
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
> /ahb/mdio@1e650000
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio1
> /ahb/mdio@1e650008
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio2
> /ahb/mdio@1e650010
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
> /ahb/mdio@1e650018
>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Thanks, that's better I think.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
> LINK: [v1] https://lore.kernel.org/all/20221025024145.1561047-1-potin.lai.pt@gmail.com/
>
> change v1 --> v2:
> * move mdio aliases to aspeed-g6.dtsi
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 0cc92874caa8..6f159ef1efbc 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -36,6 +36,10 @@ aliases {
>                 serial4 = &uart5;
>                 serial5 = &vuart1;
>                 serial6 = &vuart2;
> +               mdio0 = &mdio0;
> +               mdio1 = &mdio1;
> +               mdio2 = &mdio2;
> +               mdio3 = &mdio3;
>         };
>
>
> --
> 2.31.1
>
