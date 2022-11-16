Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAB62CB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKPUqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiKPUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:46:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058A5D68C;
        Wed, 16 Nov 2022 12:46:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so32004644wrq.3;
        Wed, 16 Nov 2022 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3OB7wrdvxiJFRvhmiue8jC5Fpuj0dFMnx5brAbEwXVA=;
        b=pUKnaYduYgV1XUs2jZu2mdRajyGhoNshkA/qoMX6esDtu5Kqtpy768+SqB+HO0jnqj
         L+m6wiKPXyyNfvVQSBgj1W8pAHury2R+0ytWYBC3WD0FLAyTbpcnd3biN7qULdrEpkd+
         NE9mzT8sSo1tmoyo3p8eO7qwBobD3rJ2PQpkV9qbHQm1rW/eOhy92hhrjlNipEpAld/C
         IvQ5PSHX7kC1tDc7w81UJEmSmv7Zq5pS95eGZEXx/U4S63fWvB7698yg2Is/1xxCPNb0
         u3XlN6gC/bAKZr5pE/WZAGeTIzlfcZA/JYZZ4rjkFzWkKKwh47zlIZd5NFLLsVcb6xcP
         NIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OB7wrdvxiJFRvhmiue8jC5Fpuj0dFMnx5brAbEwXVA=;
        b=bSWUS9hDGEat1YdyrsudSfjNIMi0ijEqBmzA5c+/TrOeiwKS1l3DLP7vVR/dbMniy3
         yF+0jVjoCizCLtS333qKfkc/cFUAH8ZoMtbMmD6rIufcKd0PXLzW9tubDkL/WlyTJoYb
         tPqzclSzStqGXHjpe5zUn6vERsKGvIajnzd4si3pelxPkiC7Ju+kuH4eEbtAdqnQTgLM
         L7dSzrr5kZbcIAPQALCb1sq4x8AvXYfZ21Cv1FQHBmfmhdfT+98HkGr31cekOrPhOhGr
         JJh+ddNDYykjiLo6sPYXd3ajvIahuB116ix4qXljrx3IudusbRw8cuL0FvVwfexFQICY
         KgOg==
X-Gm-Message-State: ANoB5pnux5NaMToTxua8dcJmFuLMlVdlYtqe2Dxt4muK5qDQ2TmSURbe
        MTb4BkFEOubMefNMXpyWgskVgRdgA7SBfj84oDaefXce
X-Google-Smtp-Source: AA0mqf5V8tXQyCU5dBQqIqiDBcoHdqGQFIeI614+qSzsagnrGq2cT8NBNg6JJ8/wb6ovyMf0bPbapdaxs+ObqZxrr+Q=
X-Received: by 2002:a5d:490a:0:b0:234:ee55:a8a8 with SMTP id
 x10-20020a5d490a000000b00234ee55a8a8mr14595128wrq.689.1668631584012; Wed, 16
 Nov 2022 12:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
In-Reply-To: <20221116200150.4657-7-linux.amoon@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 16 Nov 2022 15:46:11 -0500
Message-ID: <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
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
> Add MDIO description with ethernet-phy-id compatible string
> which enable calling reset of the phy. The PHY will then be probed,
> independent of if it can be found on the bus or not,
> and that probing will enable the GPIO.
>
> ethernet-phy-id is read from ethenet register dump reg2 and reg3.
>
> Fix following warning.
> [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2: new to the patch series.
>
> alarm@rock-3a:~$ sudo ethtool -d eth0
> [sudo] password for alarm:
> ST GMAC Registers
> GMAC Registers
> Reg0  0x08072203
> Reg1  0x00000000
> Reg2  0x00000404
> Reg3  0x00000000
> Reg4  0x00000002
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index 9f84a23a8789..fe36156a5017 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -585,7 +585,7 @@ &i2s2_2ch {
>
>  &mdio1 {
>         rgmii_phy1: ethernet-phy@0 {
> -               compatible = "ethernet-phy-ieee802.3-c22";
> +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
>                 reg = <0x0>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;

Have you tried instead moving the reset to the mdio bus? I've had
success with this, though you'll need to change the reset assert and
deassert timing handles, they are different for the bus.

> --
> 2.38.1
>
