Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA861632BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKUSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiKUSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:18:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4ABCB6A0;
        Mon, 21 Nov 2022 10:18:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 6so11880175pgm.6;
        Mon, 21 Nov 2022 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+on0BIC3CWKsQ/zQgT7Zq7kaAAA97DJzG1xxvLCYCd0=;
        b=Y2s0QwXYrb3JZrFrFOem8gxmiYnaXcD53JwjtTM5LgVmhPSgCom9h6ZoSMmFC8EWVX
         ydMHZcweTpXZyt2CHQhQ40CDwQNLJs70jFsGZlp9wzZ17FSg0DZtTdWCvNXTJQ43Xc6Z
         qHp6p6sn1SOzrTC1s+ktxqpx28mB7O3KrQ5t7/2JEMdXCQw/ucP5sYtbUxudMJtvR/2x
         xvDIz3Y9dTEPRVM2McBBEfPfpnvb2rGw2w0pc2p8DRQwML8/0yk9rvpR6QGB+IOq7plS
         2krvaNLFAOfEsiW8MP1iLUyRS+OgM4z2RhvigUKReEn3dHZ9JJ4kQHRUsrFeyBp8cD7F
         NEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+on0BIC3CWKsQ/zQgT7Zq7kaAAA97DJzG1xxvLCYCd0=;
        b=HLaItxqZu0nQU+H9zy/KuagW219qC7n19dB9b9hNgbe4L7Iur/g1pg9njMleousQxk
         S6rxWREO8RhwfQwtJZ8kDrhVtFD93///wpNxL4jQsG7hivy8Cwk7YxMxSKCWXnvD3WqN
         JnV7bPHAzl/q/39IYW7oHeGD9z0MxJ7SJbmHxMwp7n+TJ3I1Q+aLM1TSlCVO2SMzf/F6
         KkSWR5fJkUjn8XHsh3hL4HmDhHz6TqgyoHF1whmYMAfS8ItBa8PUWOOra/TxGcJb6+F7
         NAtP63O6qH40GMCxK4YO7MYNgXl+Qn1JVW6FaT9AjmMqF4CG4N7jkRi2xfqtUVitInDt
         no0g==
X-Gm-Message-State: ANoB5pm4Dy+0qfkt9hO1lLxeN9DwUfvqCK0Ae/ztDXy8WdZk6H0JjzNb
        9EWvzB/rUCV0OQUDEBqo5nsDE7MuCQbRhr5jZrw=
X-Google-Smtp-Source: AA0mqf7LqN1T/OFto2jVhaNxZ2yGDqc/xRjAOptQIyQmYXhv8nQeAlkd38TMX7ofEDomjM8uh4mAaGxiaYXcFihRecU=
X-Received: by 2002:a63:2f46:0:b0:477:4a13:f38e with SMTP id
 v67-20020a632f46000000b004774a13f38emr2304423pgv.131.1669054730967; Mon, 21
 Nov 2022 10:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
In-Reply-To: <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Nov 2022 15:18:32 -0300
Message-ID: <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO polarity
To:     Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        David Jander <david@protonic.nl>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
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

[Adding Angus and David]

On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz <foss+kernel@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The reset line is active low for the Goodix touchscreen controller so
> let's fix the polarity in the Device Tree node.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts         | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> index 9fbbbb556c0b3..df7e5ae9698e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> @@ -107,7 +107,7 @@ touchscreeen@5d {
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <8 IRQ_TYPE_NONE>;
>                 irq-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> -               reset-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>         };
>
>         temp-sense@70 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 6445c6b90b5bb..b038300812b1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -542,7 +542,7 @@ touchscreen@5d {
>                 pinctrl-0 = <&pinctrl_ts>;
>                 interrupt-parent = <&gpio3>;
>                 interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -               reset-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
>                 irq-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
>                 touchscreen-size-x = <720>;
>                 touchscreen-size-y = <1440>;
>
> --
> b4 0.10.1
