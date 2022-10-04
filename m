Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2A5F4630
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJDPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJDPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:09:33 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3EE5AC70;
        Tue,  4 Oct 2022 08:09:32 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131ea99262dso14503712fac.9;
        Tue, 04 Oct 2022 08:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1/SfhmEZO2JzUCSYSQdFtcYRPEgPC0CoBH/8raGMDh8=;
        b=AwLGT+48IEx2H1uxYJr0yGe0z4u/9ObUSr2C10aG4TVQfkDEErQHD60Xi5DTqg69EK
         H7epmk2/rKI3BSsdplrAtkeKHZV+ENHXQLylzh7Nrbj7ZT4jTvmJuRhhjncN8JWX1g/M
         ZmOryKqEIUPZgqPnS4e6bGDvqIxGdW1XnnXLWOb20yBXqELgShF+htNTdVAR/5m7srif
         LvsnF1x2GyoiyF8yvmUEvz9nr9jclWOHtCBG72HeawN3PbyDYms8Q0OmmBB+Vno9as/5
         eOV5plsn+5WX8ZnjMohpkckZrr/FQd4JwXzNh2xcIieqY7ieDyFznSPCXPR4xt1xxqnp
         jQHQ==
X-Gm-Message-State: ACrzQf0wfr2a6SzLimoAZtrsNcTPmtUftHmSuZ3wKNyx+l47lbrwKtYI
        fTR7mOtxlLyYt8Cbh7pYIw==
X-Google-Smtp-Source: AMsMyM7jLjnl+O35aTbkfKDjVHvR3//Sg2sceoBCi4M/ndmVZF8lzWetnP5LNWSYt4i5fyF+WtyZkA==
X-Received: by 2002:a05:6870:b39e:b0:10d:8d5d:a9b with SMTP id w30-20020a056870b39e00b0010d8d5d0a9bmr133280oap.144.1664896171203;
        Tue, 04 Oct 2022 08:09:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r35-20020a056870582300b0011f22e74d5fsm3756563oap.20.2022.10.04.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:09:30 -0700 (PDT)
Received: (nullmailer pid 1507385 invoked by uid 1000);
        Tue, 04 Oct 2022 15:09:29 -0000
Date:   Tue, 4 Oct 2022 10:09:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Message-ID: <20221004150929.GA1506199-robh@kernel.org>
References: <20220825193836.54262-1-linux@fw-web.de>
 <20220825193836.54262-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825193836.54262-2-linux@fw-web.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 09:38:32PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add a new binding file for Rockchip PCIe v3 phy driver.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v4:
> - add reviewed-by
> - remove minitems for clock-names as i have static list to fix error
> - fix reg error by using 32-bit adressing in binding example
> - change lane-map to u32 data-lanes
> - tried to move data-lanes to phy-provider
>   https://github.com/frank-w/dt-schema/blob/main/dtschema/schemas/phy/phy-provider.yaml#L17
>   cloned and installed via pip install -e <local path>
>   verified with pip show, but phy-privider seems not to be applied
> 
> v3:
> - drop quotes
> - drop rk3588
> - make clockcount fixed to 3
> - full path for binding header file
> - drop phy-mode and its header and add lane-map
> 
> v2:
> dt-bindings: rename yaml for PCIe v3
> rockchip-pcie3-phy.yaml => rockchip,pcie3-phy.yaml
> 
> changes in pcie3 phy yaml
> - change clock names to ordered const list
> - extend pcie30-phymode description
> - add phy-cells to required properties
> - drop unevaluatedProperties
> - example with 1 clock each line
> - use default property instead of text describing it
> - update license
> ---
>  .../bindings/phy/rockchip,pcie3-phy.yaml      | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> new file mode 100644
> index 000000000000..9f2d8d2cc7a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip PCIe v3 phy
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-pcie3-phy

The driver also has 'rockchip,rk3588-pcie3-phy'. Please send a fix 
adding it here or removing from the driver. Are they not compatible with 
each other?

Rob
