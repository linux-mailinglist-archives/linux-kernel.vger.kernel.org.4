Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A717112D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjEYRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjEYRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:51:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99713A;
        Thu, 25 May 2023 10:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A48DE6480B;
        Thu, 25 May 2023 17:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167E6C433EF;
        Thu, 25 May 2023 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685037095;
        bh=mHitxRuzsrCDz6wDtNkPxZg0+Qj9SmhuC0cgq49LxIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR70UQHUyQLmkKcT9W7ECQblM2idV7tY1F7GXcQ5RJr1FKLYiTgrQaByckJxSrQTy
         X7P7eBJ+koJyFqxOyogc2FfJjWHlhKHt55A1gy8Rucz+95H7x21E0xbXhRQQWcdOH5
         0NJB3uG/wDQfBtj7kFZd3ShcFc5X1kfJemTTM7a5Xselgi3D8kWGRatL1rS2ZCTSCK
         lOV50B8onXaN4Wuz6ew/EoCAk22YPm65z5lKBFjqDalaQaxo4IhWvRmUCL0e+nZP2Z
         2EcBNnoELEmnWC6Ff3ebzBgllFLua2s9uZmZyM/YlixCxciD82eSPZaOu/xQBunjFO
         jAYpjylzuIrgQ==
Date:   Thu, 25 May 2023 18:51:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: replace unusable
 clock
Message-ID: <20230525-snuggle-twine-ed1bfc2aee51@spud>
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gOHHGwI3MUXVEdah"
Content-Disposition: inline
In-Reply-To: <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gOHHGwI3MUXVEdah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 04:50:27PM +0200, Alexandre Mergnat wrote:
> The =E2=80=9Cmcu_pm_bclk_ck_cg=E2=80=9D clock is used by co-processors an=
d should not be
> added to the kernel driver, otherwise the CPU just halt and the board is
> rebooted by the wathdog.
>=20
> Instead, add the "aes_top0_bclk_ck_cg" missing clock to prevent
> re-shuffling index and then preserve the ABI.

How does this preserve the ABI exactly? Please describe exactly what you
mean by that.
Also, what about any other users of these definitions, outside of Linux?

Cheers,
Conor

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  include/dt-bindings/clock/mediatek,mt8365-clk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt=
-bindings/clock/mediatek,mt8365-clk.h
> index f9aff1775810..0a841e7cc1c3 100644
> --- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
> +++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
> @@ -199,7 +199,7 @@
>  #define CLK_IFR_PWRAP_TMR		46
>  #define CLK_IFR_PWRAP_SPI		47
>  #define CLK_IFR_PWRAP_SYS		48
> -#define CLK_IFR_MCU_PM_BK		49
> +#define CLK_IFR_AES_TOP0_BK		49
>  #define CLK_IFR_IRRX_26M		50
>  #define CLK_IFR_IRRX_32K		51
>  #define CLK_IFR_I2C0_AXI		52
>=20
> --=20
> 2.25.1
>=20

--gOHHGwI3MUXVEdah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+gIQAKCRB4tDGHoIJi
0gjeAP9v0bdBygFs8MHWwrW4JshVYCnje5trYdbmwkeisP5Q7wEAjon3h1OrMg3d
GI0plInpgzPg0QIkgLGH6LFkO/vw/Qk=
=p2Bs
-----END PGP SIGNATURE-----

--gOHHGwI3MUXVEdah--
