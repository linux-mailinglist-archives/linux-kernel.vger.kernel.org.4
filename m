Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93023731582
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbjFOKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbjFOKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:36:19 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314D2735;
        Thu, 15 Jun 2023 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tG5feDrl2Mw6hEmR2hb46eHTTsEGlzKg28JrQ4NlezE=; b=WJWgjqmxVqTfDmbHE1yLpH20s5
        Tmnb0LR3PAcKmq0Kp++HDR5UnXFXFeS27wcsqYUnzE/xMUnvVE+se6Q+AAR/HzLUgppANR1oI2CQU
        +KvYjAz/eetICRUuoIAKbqzPviYLRjbrKlVOewOSf1YiNgyX0O8LUMqyRkznrPluEUU0oZc584RPZ
        JZUo1ow4WRtl11LY7OR/ee+MRb+uZDkazT9ISJV/OHmL9mocjaQF9m4LV/xXxhsDdXYe/t0dZKFXO
        +joVo25gB+GwQMke3qd89L10xraKkAQB11RiniQHHmS4/1xX8WuF/7j97Z3R0CY9rGgXq+dI4eXiK
        nmEA3Lnw==;
Received: from [2a01:799:961:2c00:5fc6:a9a5:c042:d1cd] (port=49824)
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <noralf@tronnes.org>)
        id 1q9kKW-0071lE-JM;
        Thu, 15 Jun 2023 12:35:52 +0200
Message-ID: <0ece62a0-2e77-190d-942e-e4fb69ef8d62@tronnes.org>
Date:   Thu, 15 Jun 2023 12:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/8] dt-bindings: display: panel: mipi-dbi-spi: add
 spi-3wire property
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
 <20230614123222.4167460-4-l.goehrs@pengutronix.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20230614123222.4167460-4-l.goehrs@pengutronix.de>
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
> Some MIPI DBI panels support a three wire mode (clock, chip select,
> bidirectional data) that can be used to ask the panel if it is already set
> up by e.g. the bootloader and can thus skip the initialization.
> This enables a flicker-free boot.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> index c07da1a9e6288..2f0238b770eba 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
> @@ -87,6 +87,8 @@ properties:
>        Logic level supply for interface signals (Vddi).
>        No need to set if this is the same as power-supply.
>  
> +  spi-3wire: true
> +
>  required:
>    - compatible
>    - reg
