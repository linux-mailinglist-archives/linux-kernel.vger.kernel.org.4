Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345EC62CB33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiKPUhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiKPUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:36:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922FE65E6E;
        Wed, 16 Nov 2022 12:36:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so31899051wrt.11;
        Wed, 16 Nov 2022 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0IcH5gFiwo2T5jEqATk0ifRG4QlIgMjRCMEKXYZaC28=;
        b=K30djvpRBS+52IixL7ukZ+0jdbjNIQmzHPRzhFd/anfccasAqrR++8AAu1D2Rvo91N
         gUsrV56AcZQ77FR7TOGtE8tv7pstD4I8jBjpFi6104beoj8rZ9t1x1MKGKV/cARyUxdy
         1b2iOkowkFU20taFzrFt4U0K2KgMceRSfCzSUFlvHY0m765sBa5HXw8vaazf90bnDqgp
         sInfNWcrOu9xV6306OpEx1xwn6pWa7mOff/SE+9hsNP430Zm/fzSspy8RwygAZ5qPXSt
         kdhj9mVLX8Pe0Hz6id9j4Gb63BP2CDOu8Lk71wKQIkVWzwfgAzQ5quGeYx+EHEuwmY6T
         f62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IcH5gFiwo2T5jEqATk0ifRG4QlIgMjRCMEKXYZaC28=;
        b=XbEtlIsCyliiaAcwBaAUSehvv0mlWn1EOD+X2ImoMDRGtIrjMvnVvjO+ObdoUQMQ/B
         m05ukYSKIDVXfF+EHe6NLwRXrpzSRphKksnTQkF1yOuasRIy47+D1jZ9QkLXyh6AXSHU
         DqHrb88hJ4OK0EsFeXE4XsUo1FaCIEJZqvOfDDDMPjbf1IhFq3rPi58PVXEjrn9V2KDa
         JNJ4bmuas1qreS3a2pFZW/X9BAxUFusQHrWa6Rk4cUvr7Bb4JtEqZiMNlUrCHz9hZArB
         uescDmLT9lc2SmWW3aVB+Anu8DGiL1nosr64LtZL0o9BMGbF5uITWiCwvJjRrvPI9gWH
         9N+w==
X-Gm-Message-State: ANoB5pmh6EN5tD16Njfar2HZM1z30+k9wA6kx0Jg6HfXs+UiwMXmGMRz
        N1Njd/chAvtm2fBUOeIyyu5GWsTNGrk/idYmhmrOlsIj
X-Google-Smtp-Source: AA0mqf5/qvPoxAdwcYY6fUPkyWyWz+qeGrX/B7SAMbTEW+Ju9vU/fYPg1UsuNtRk2tQOOmsjgygqX9sl0CbgiY33+JM=
X-Received: by 2002:adf:fec8:0:b0:228:d897:228 with SMTP id
 q8-20020adffec8000000b00228d8970228mr14745392wrs.539.1668630996952; Wed, 16
 Nov 2022 12:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
In-Reply-To: <20221116200150.4657-2-linux.amoon@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 16 Nov 2022 15:36:24 -0500
Message-ID: <CAMdYzYrgtzeP2OL2Vw0pDHQuJDhRbUy3X4xq9+XchgTGB9dqpg@mail.gmail.com>
Subject: Re: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A SBC.
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> On rk356x ethernet phy support reduced media independent interface (RMII)
> and reduced gigabit media independent interface (RGMII).
> So set the phy mode to rgmii to support clock delay, also
> add TX and RX delay for phy-mode.

Controller based clock delay, the various rgmii-id modes (rgmii-txid
and rgmii-rxid are also valid) apply the delays in the phy. They are
usually at a fixed amount, but some phys support variable delays.

You want your commit message to accurately describe the problem, such
as "In rgmii-id mode, the phy on the rock-3a is unreliable due to
incorrect delays. Switch to rgmii mode in order to handle the delays
in the controller."

>
> Fix following warning
>
> [    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> [    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> [    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> [    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10

I've been meaning to make this a dev_debug message, because in the
various rgmii-id modes it is feasible for these to be non-existent in
the device-tree. In rgmii-id mode these are disabled, no matter what
they are set to in the dt.

>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2: Fix commit message and added the RX and TX clock delay.
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index ea74ba32fbbd..e1c75532dcee 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -253,13 +253,16 @@ &gmac1 {
>         assigned-clock-rates = <0>, <125000000>;
>         clock_in_out = "output";
>         phy-handle = <&rgmii_phy1>;
> -       phy-mode = "rgmii-id";
> +       phy-mode = "rgmii";
>         pinctrl-names = "default";
>         pinctrl-0 = <&gmac1m1_miim
>                      &gmac1m1_tx_bus2
>                      &gmac1m1_rx_bus2
>                      &gmac1m1_rgmii_clk
>                      &gmac1m1_rgmii_bus>;
> +
> +       tx_delay = <0x4f>;
> +       rx_delay = <0x26>;

These are pretty far off from the default, have you verified the upper
and lower bounds for the rock-3a? These should be roughly in the
middle of that range.

>         status = "okay";
>  };
>
> --
> 2.38.1
>
