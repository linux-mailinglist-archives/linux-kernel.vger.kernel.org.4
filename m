Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEACB6F5F37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjECTgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjECTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:36:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37626A6;
        Wed,  3 May 2023 12:36:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0A73755;
        Wed,  3 May 2023 21:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1683142595;
        bh=OISN3lnEGX5h+/hgrl4D+o6AnERV3z8aJH1158I66Yg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FdptgKp4JFeMseqRT/XgDE+GfGGnBlJXElhgcGaF7rL13mHqUw6a5g73feuVoWQr2
         socpbwCPDTJ3qfdKOpt8g4VVL6uZvBDVp95W65wZf7hWYwFmTLPcPjRkiv65JuK9du
         Qt/oVej6YABXcvy07oz+n/KBRj9s8Miy+HQP84TY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
References: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] dt-bindings: pwm: Add R-Car V3U device tree bindings
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org
Date:   Wed, 03 May 2023 20:36:35 +0100
Message-ID: <168314259577.1880445.14037728409745166769@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2023-05-02 17:53:29)
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml =
b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> index 4c8097010687..6b6a302a175c 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> @@ -35,6 +35,7 @@ properties:
>            - renesas,pwm-r8a77980  # R-Car V3H
>            - renesas,pwm-r8a77990  # R-Car E3
>            - renesas,pwm-r8a77995  # R-Car D3
> +          - renesas,pwm-r8a779a0  # R-Car V3U
>            - renesas,pwm-r8a779g0  # R-Car V4H
>        - const: renesas,pwm-rcar
> =20
> --=20
> 2.30.2
>
