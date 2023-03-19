Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820ED6C0295
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCSPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:05:54 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD7B744;
        Sun, 19 Mar 2023 08:05:52 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pdubU-000246-2r;
        Sun, 19 Mar 2023 16:05:49 +0100
Date:   Sun, 19 Mar 2023 15:05:35 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH RESEND] dt-bindings: pwm: mediatek: add mediatek,mt7986
 compatible
Message-ID: <ZBckvw5NMihHx0Ja@makrotopia.org>
References: <Y+zfb2uQyKHng0kS@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+zfb2uQyKHng0kS@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:34:51PM +0000, Daniel Golle wrote:
> Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
> support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
> been added. Also add the compatible string to dt-bindings now that
> they have been converted to YAML.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

May I kindly call your attention to this patch please.

It has received reviews and no further comments for more than a month
now:
https://patchwork.kernel.org/project/linux-mediatek/patch/Y+zfb2uQyKHng0kS@makrotopia.org/

Follow-up patches adding support for MT7981 are already waiting and to
avoid conflicts it would be good to have this one merged before.

Thank you!

> ---
> Resending this patch as I missed sending it to linux-pwm when first
> submitted. See also
> https://patchwork.ozlabs.org/comment/3049442/
> 
>  Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> index dbc974bff9e9..8e176ba7a525 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
> @@ -22,6 +22,7 @@ properties:
>            - mediatek,mt7623-pwm
>            - mediatek,mt7628-pwm
>            - mediatek,mt7629-pwm
> +          - mediatek,mt7986-pwm
>            - mediatek,mt8183-pwm
>            - mediatek,mt8365-pwm
>            - mediatek,mt8516-pwm
> 
> base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
> -- 
> 2.39.1
> 
