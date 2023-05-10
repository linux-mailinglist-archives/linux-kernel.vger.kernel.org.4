Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E96FDA19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjEJIzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjEJIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:55:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11818C;
        Wed, 10 May 2023 01:55:12 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pwfb9-000485-Ls; Wed, 10 May 2023 10:54:59 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     krzysztof.kozlowski@linaro.org,
        Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: vendor-prefixes: Add Emtop
Date:   Wed, 10 May 2023 10:54:58 +0200
Message-ID: <4504546.cEBGB3zze1@diego>
In-Reply-To: <20230510083346.3692555-1-himanshu.bhavani@siliconsignals.io>
References: <20230510083346.3692555-1-himanshu.bhavani@siliconsignals.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Mai 2023, 10:33:44 CEST schrieb Himanshu Bhavani:
> Add an entry for Emtop to vendor-prefixes.yaml
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

you forgot the
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

you received in
https://lore.kernel.org/r/e1d3b716-74ed-a2ae-a05c-7459eafd15ac@linaro.org

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index ed64e06ecca4..e6e3c99f6ac1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -412,6 +412,8 @@ patternProperties:
>      description: EM Microelectronic
>    "^empire-electronix,.*":
>      description: Empire Electronix
> +  "^emtop,.*":
> +    description: Emtop
>    "^emtrion,.*":
>      description: emtrion GmbH
>    "^enclustra,.*":
> 




