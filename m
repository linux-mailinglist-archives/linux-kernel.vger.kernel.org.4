Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC167FF40
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjA2M5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2M5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:57:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836D1C5B9;
        Sun, 29 Jan 2023 04:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39FE60D14;
        Sun, 29 Jan 2023 12:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF45C433EF;
        Sun, 29 Jan 2023 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674997039;
        bh=1SbuRSS1o7synNcf4/NiS2pZJBg1g2mbf1OV6EZD5Ic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JotFT4cck6ZH34MdvUqO5Dka0BvjA3WWpI8KJTJXY7VJJ9KuuUnEOE3XV4ZE4G54S
         bjGXGJDuOn0jqX0/EJm15u/zDJtRmpH7bnHmiaKF9IiZ4XutLOVFYFtAV27QDU9czt
         64cjVeFcov3U714gCO7J0q6DYobVIQBcTn5Hx+JG8hZoZtMFQpNMXOcmIDZO734/N+
         EWaZQ4Hb6/c2nGtYlr3g13L/OR5Q8MLJgjDSKq/Mql/T65aO1c10CR5df5++xHbu+L
         ZjBdvYVclhRcjY0NZy448Vuo1GSO43AQ+lgReVHPRr/q29QK3HzYT2XR1staKyx40c
         XayvJn22/7bHg==
Date:   Sun, 29 Jan 2023 13:57:11 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bus: moxtet: Fix reference to SPI
 peripheral DT properties
Message-ID: <20230129135711.721a16ac@thinkpad>
In-Reply-To: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
References: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 13:35:53 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> spi-bus.txt has been converted to YAML and the peripheral properties
> have been moved to spi-controller.yaml.
>=20
> Fixes: 0a1b929356830 ("spi: Add YAML schemas for the generic SPI options")
> Fixes: 8762b07c95c18 ("spi: dt-bindings: add schema listing peripheral-sp=
ecific properties")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/bus/moxtet.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documenta=
tion/devicetree/bindings/bus/moxtet.txt
> index fb50fc8653368..d6bf929c00c4e 100644
> --- a/Documentation/devicetree/bindings/bus/moxtet.txt
> +++ b/Documentation/devicetree/bindings/bus/moxtet.txt
> @@ -11,7 +11,7 @@ Required properties:
>   - #interrupt-cells	: Has to be 1
>=20
>  For other required and optional properties of SPI slave nodes please ref=
er to
> -../spi/spi-bus.txt.
> +../spi/spi-peripheral-props.yaml.
>=20
>  Required properties of subnodes:
>   - reg			: Should be position on the Moxtet bus (how many Moxtet
> --
> 2.39.0
>=20

Acked-by: Marek Beh=C3=BAn <kabel@kernel.org>
