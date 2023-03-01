Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDA6A641B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjCAARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:17:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85A3756F;
        Tue, 28 Feb 2023 16:17:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s26so47117882edw.11;
        Tue, 28 Feb 2023 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CX/UlvUpEOObHnKgy2nGq9RLjTYBpOBbXecaXxjC6bU=;
        b=TpkSu77EQxvtY0DpBTCQH9L31x0vlJwkJ0SVlP1ctEwuhdkUs2bR6FzJVSue8fxFzO
         6Bu9QM0Fbt4l5TuQPkF/qObZn84TY760HzbWuI8a5jcta8y/m79lEyxkv0LYMbqVdhCx
         8MMnGifFnuczhmWJnL2Nljafagvjs88t/oRno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX/UlvUpEOObHnKgy2nGq9RLjTYBpOBbXecaXxjC6bU=;
        b=GxK8RPpTifvgMvbojNEAotQJC+i9ZDevqkMS60YrTEv9XFje3N13IhQuM7X+eFnHHc
         DANU3OXubdzefr0XGYM8CtszeHXp7F7F/qTaSH7Sdn7tdzPN1xNGamlZ0ME1YV3a/xBn
         IxCvHyvNHt9id4UCcMwuRnaQPTX/Fhf5KJwhrQUk1OSXO9GnOaGaN/rm3AzW9U7vvVck
         WryFK1qjhPKc7/IvOY6Hi6+q0WJjxFd0913KhQ6S2Vp0zdBJopGZWS9JtaY/qI68O1C7
         lKVznXm+Q7tiKmCw/+0kfGykJTaJsfDTocYsHA9ux/sEOIU231oUHAN57AZTww5XaG0Q
         aspA==
X-Gm-Message-State: AO0yUKUST68LPuBeAFaTdOHKS0pbYCyGxzkQfptYkH1ZPmBVhGyT55Wu
        c4i/XsdXwwV2C/S7Z/LGPoHkYnhBENYuGSu8VbTc+O8m
X-Google-Smtp-Source: AK7set9nqT3/GW3KWnP4XtzE5YzdIhzPhnt4YkcC+fIxbs0hJzMGO1mJKle+lI7WC2l6DTANxa9ZQuH9wieYVA0c1Vc=
X-Received: by 2002:a05:6402:4494:b0:4af:6e95:85e9 with SMTP id
 er20-20020a056402449400b004af6e9585e9mr10379668edb.4.1677629867947; Tue, 28
 Feb 2023 16:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20230228102820.18477-1-chanh@os.amperecomputing.com>
In-Reply-To: <20230228102820.18477-1-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Mar 2023 00:17:36 +0000
Message-ID: <CACPK8XesuUATxCVEGpus=ZHTkjS=L=gjRHC3V+=XLSofU-WSSw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: mtmitchell: Enable NCSI
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 10:28, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
>
> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,
> so we use only one of them at the same time. The OCP slot #0 will
> be enabled by PCA9539's setting by default.
>
> Also, enable the OCP Auxiliary Power during booting.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

LGTM. I'll apply it once we have a -rc1.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> Changes in v2:
>    - Change PCA9539APW node name.                     [Krzysztof]
> ---
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..1e0e88465254 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -251,6 +251,14 @@
>         pinctrl-0 = <&pinctrl_rgmii1_default>;
>  };
>
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       clock-names = "MACCLK", "RCLK";
> +       use-ncsi;
> +};
> +
>  &fmc {
>         status = "okay";
>         flash@0 {
> @@ -439,6 +447,26 @@
>         status = "okay";
>  };
>
> +&i2c8 {
> +       status = "okay";
> +
> +       gpio@77 {
> +               compatible = "nxp,pca9539";
> +               reg = <0x77>;
> +               gpio-controller;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               #gpio-cells = <2>;
> +
> +               bmc-ocp0-en-hog {
> +                       gpio-hog;
> +                       gpios = <7 GPIO_ACTIVE_LOW>;
> +                       output-high;
> +                       line-name = "bmc-ocp0-en-n";
> +               };
> +       };
> +};
> +
>  &i2c9 {
>         status = "okay";
>  };
> @@ -530,13 +558,20 @@
>         /*V0-V7*/       "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
>                         "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
>                         "host0-shd-ack-n","s0-overtemp-n",
> -       /*W0-W7*/       "ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> +       /*W0-W7*/       "","ocp-main-pwren","ocp-pgood","",
>                         "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
>         /*X0-X7*/       "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
>                         "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
>                         "s1-overtemp-n","s1-spi-auth-fail-n",
>         /*Y0-Y7*/       "","","","","","","","host0-special-boot",
>         /*Z0-Z7*/       "reset-button","ps0-pgood","ps1-pgood","","","","","";
> +
> +       ocp-aux-pwren-hog {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "ocp-aux-pwren";
> +       };
>  };
>
>  &gpio1 {
> --
> 2.17.1
>
