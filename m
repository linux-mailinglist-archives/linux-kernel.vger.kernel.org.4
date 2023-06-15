Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE7773157E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjFOKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbjFOKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:35:34 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495F212A;
        Thu, 15 Jun 2023 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5tjG7fTn80mFODGDPDCGElfropwD1cl6RdLdwU6sFGM=; b=LJhx+eePN7naR6BdcMOLRU/g9y
        aU7yjuRBg3KnRL91F1c8KBS64B5f472cvkh9lJ6Tbk3IO9fDlePa8s3RmdHFWtQU6EQ2S/6qFp7A0
        NaqxVzlReLG78LLIIOws8xyqPMq/ghnSugslgHA4N1xOAfmK5dV4gQ+eG5PigGUt2S35aFSEJCmeN
        mXrj/KbBLTBi9CWbY96D0tjPlps6zjYAPD5J2wyCV8PB8iou3EdKkdOV+ymtueZPz0xYCv1dgYURz
        0oNvlYxBq2xdUMWL+XtCF7jzwqKsbCb+gGt1ickd+axS/aptkEK7oEWRVTmbXpau8IZ8pSQM08YwH
        oD7RolUg==;
Received: from [2a01:799:961:2c00:5fc6:a9a5:c042:d1cd] (port=59132)
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <noralf@tronnes.org>)
        id 1q9kK8-0071Va-QB;
        Thu, 15 Jun 2023 12:35:28 +0200
Message-ID: <81007308-02dc-b1fb-f336-21bc25033c12@tronnes.org>
Date:   Thu, 15 Jun 2023 12:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 shineworld lh133k compatible
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@pengutronix.de, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, noralf@tronnes.org
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
 <20230614123222.4167460-3-l.goehrs@pengutronix.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20230614123222.4167460-3-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/23 14:32, Leonard Göhrs wrote:
> The Shineworld LH133K is a 1.3" 240x240px RGB LCD with a MIPI DBI
> compatible SPI interface.
> The initialization procedure is quite basic with the exception of
> requiring inverted colors.
> A basic mipi-dbi-cmd[1] script to get the display running thus looks
> like this:
> 
>     $ cat shineworld,lh133k.txt
>     command 0x11 # exit sleep mode
>     delay 120
> 
>     # The display seems to require display color inversion, so enable it.
>     command 0x21 # INVON
> 
>     # Enable normal display mode (in contrast to partial display mode).
>     command 0x13 # NORON
>     command 0x29 # MIPI_DCS_SET_DISPLAY_ON
> 
>     $ mipi-dbi-cmd shineworld,lh133k.bin shineworld,lh133k.txt
> 
> [1]: https://github.com/notro/panel-mipi-dbi
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Normally I would take this trough drm-misc-next but -rc6 is the cutoff
so if I do that it won't make it to 6.5. If the other patches make it to
6.5 the dtb checks will fail. I'm okay with the patches going through
another tree if that's preferred. Let me know if I should apply the
mipi-dbi-spi patches.

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> index 9b701df5e9d28..c07da1a9e6288 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> @@ -67,6 +67,7 @@ properties:
>      items:
>        - enum:
>            - sainsmart18
> +          - shineworld,lh133k
>        - const: panel-mipi-dbi-spi
>  
>    write-only:
