Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C58726A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFGT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFGT7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:59:54 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3006::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B419AA;
        Wed,  7 Jun 2023 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202212; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/b4ajCqI25DW6ri9g92RjyuwGLkAwnN2KYxGew63Kmg=; b=QZ7HpcUQXI0kzfxOYpZY3EIIpM
        fOcpFu5bQwUIHgsHdeDG5gWwSxKRTnKemoGMHddPycz2U4DN14DAXJz+qICPM3Q2niZdSfJxFDasc
        uK32Lth+ZHIT1Wsbdutw/GXYMjpeAZbo8D06Y6RL87GgcljEK9qbEiw4+aGkWPuGlqE5z0xDgnTHX
        E3PWzSwO7cJKFrpWZTwFfDHvuixMw+cdOqXZQ4nKUQ19jGvyV3UKSsyxaO+LvDdHtk2vXylggZ8b7
        fy/DndbQnQhBwy2wFYvosY3kSE1/g66fViSmq0uyR8frMrCoYhNuMwR76srqf/YkzPRDNYPuZ/rb2
        wAJAK+1w==;
Received: from [2a01:799:961:2c00:5fc6:a9a5:c042:d1cd] (port=55530)
        by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <noralf@tronnes.org>)
        id 1q6zJs-00BVdA-RF;
        Wed, 07 Jun 2023 21:59:48 +0200
Message-ID: <69fdb6a2-12b6-547d-019b-c77dd2bd98cf@tronnes.org>
Date:   Wed, 7 Jun 2023 21:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 spi-3wire property
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, noralf@tronnes.org
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-2-l.goehrs@pengutronix.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20230607115508.2964574-2-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/23 13:55, Leonard Göhrs wrote:
> Some MIPI DBI panels support a three wire mode (clock, chip select,
> bidirectional data) that can be used to ask the panel if it is already set
> up by e.g. the bootloader and can thus skip the initialization.
> This enables a flicker-free boot.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
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

I don't think this should be added here. spi-cpha and spi-cpol are also
supported but they are not mentioned. Instead those are documented in
bindings/spi/spi-controller.yaml. Why they're not documented in
bindings/spi/spi-peripheral-props.yaml instead which this binding has a
ref to, I have no idea.

Noralf.

>  required:
>    - compatible
>    - reg
