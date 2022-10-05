Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444C5F5539
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJENSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJENSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:18:44 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA70C4E;
        Wed,  5 Oct 2022 06:18:42 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso12576902fac.6;
        Wed, 05 Oct 2022 06:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7WBRE0TSwdycfwFVKlR15yRSU1xPZaaPnpCRj9i22Y=;
        b=2YzFbEre5D1Lowapj2AMwX8Epvsi9QAZYdO7FBPBdtCM0pnwTtmhelfmB7ctjhXZ/z
         xYLBvlxMudxl3D9w6VEYgAFjJjNCpinlNhsJTwLUjl1ioI2EMT0JbR2/x9LnJdpngPo1
         2B3dnS3+EvYDhNh45UJmMrVkYelq6qc01BtNo1y+oVLZbUkYLhFqQBd6XD/lbOXT6qRh
         VHw1a2Sv/cYUMBDYnr406p0m80fmX6eKJCMkWLchlKU7VFkA20U28YdggzhZp8Tlolpn
         7uIf5aizgXxIE8Hvup8hN62hOpqnzHnM1v1fyBqx/EWb6GTJSrF74oxXCvTQ8+34r7aU
         B46g==
X-Gm-Message-State: ACrzQf0hjM48xz2/ixFcyEhtwgfVhUCbU613+DiKmqw91AzQZd3Wehiv
        OCUNopM8YfjO3uHa9bsfPQ==
X-Google-Smtp-Source: AMsMyM5uI5qcnh4ZkcNOCX8kxN3upY5M61WbvqR4W6U8P6mgzfD71aGVQ1+C94drZG57R5BM77aAkA==
X-Received: by 2002:a05:6870:738d:b0:131:f040:fb49 with SMTP id z13-20020a056870738d00b00131f040fb49mr2520243oam.253.1664975922025;
        Wed, 05 Oct 2022 06:18:42 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870424e00b0011e73536301sm2486442oac.52.2022.10.05.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:18:41 -0700 (PDT)
Received: (nullmailer pid 3261036 invoked by uid 1000);
        Wed, 05 Oct 2022 13:18:40 -0000
Date:   Wed, 5 Oct 2022 08:18:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Chia-Wei Wang --cc=linux-kernel @ vger . kernel . org" 
        <chiawei_wang@aspeedtech.com>, linux-crypto@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Message-ID: <20221005131840.GA3256371-robh@kernel.org>
References: <20221004032841.3714928-1-neal_liu@aspeedtech.com>
 <20221004032841.3714928-5-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004032841.3714928-5-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:28:41AM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> Advanced High-Performance Bus (AHB) Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> new file mode 100644
> index 000000000000..c42a350d30a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device Tree Bindings
> +
> +maintainers:
> +  - Neal Liu <neal_liu@aspeedtech.com>
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description: |
> +  Advanced High-performance Bus Controller (AHBC) supports plenty of mechanisms
> +  including a priority arbiter, an address decoder and a data multiplexer
> +  to control the overall operations of Advanced High-performance
> +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate with the
> +  related peripherals.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-ahbc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        compatible = "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        ahbc: bus@1e600000 {
> +            compatible = "aspeed,ast2600-ahbc";
> +            reg = <0x1e600000 0x100>;

Devices on the AHB bus should be child nodes here. Unless this is just 
for device master interface to memory, but that's not what the 
description says.

Rob
