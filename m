Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DBA5F1213
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiI3THJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3THH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:07:07 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693430F40;
        Fri, 30 Sep 2022 12:07:05 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id l5so5659007oif.7;
        Fri, 30 Sep 2022 12:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lbkbCBX5qiptsKPuD7ofnI+kwIIikXEjEFfIdyuhodk=;
        b=2unFTiPJ8npqOVyALh7pCtuZ2kh5rN9XqwcCcqn+b4DETKLdOavDwzGTy7t9iDKG8b
         EVgxAMvRSgOk/QMoLFuKw6acbBHbPKCWBNjBvb0PZuqzWidqkOt8j57M+U2wWYMHr7LD
         L7XnpMHvelZoMkWx8BJPnu2w1zFxfm8YHEIvgJqojxYf5ZdPGD0wObjDicfks329eayA
         6J4tzR6gvJrUSYCqK3B2DVomIsccstK6U4isbBuwWzRSy+Ve8DVpgIGBt5U77fH+JW/f
         Io3ljGsdQ9qzIkQxzuD/VjBaNKgZnoqpR9QmHBVpzOZJIRsZ0aARE13oFMLLzwAX5hyj
         vMGA==
X-Gm-Message-State: ACrzQf39DfuC2+vIWo7j/qzK+3jr3orPl3XOGo9BQuCtJpkUPWNHbfkX
        tq2JeMhuLnrwOtS0A/BB+w==
X-Google-Smtp-Source: AMsMyM4by+DiFSSmhyZnJykHeNEQHgTg1raTX3hQcjvnazl1Cm8fmz9jDXP3QHvNJr8TJkL1A01tdQ==
X-Received: by 2002:aca:1912:0:b0:350:504b:ee13 with SMTP id l18-20020aca1912000000b00350504bee13mr9677907oii.256.1664564824871;
        Fri, 30 Sep 2022 12:07:04 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c130-20020aca3588000000b00344a22e71a9sm699006oia.9.2022.09.30.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:07:04 -0700 (PDT)
Received: (nullmailer pid 688099 invoked by uid 1000);
        Fri, 30 Sep 2022 19:07:03 -0000
Date:   Fri, 30 Sep 2022 14:07:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Johnson Wang <johnson.wang@mediatek.com>,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        kuan-hsin.lee@mediatek.com, yu-chang.wang@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Message-ID: <20220930190703.GA657929-robh@kernel.org>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
 <20220929114624.16809-3-johnson.wang@mediatek.com>
 <ed723cb2-ba79-55d7-7869-abf153e4af0a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed723cb2-ba79-55d7-7869-abf153e4af0a@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:07:49PM +0200, AngeloGioacchino Del Regno wrote:
> Il 29/09/22 13:46, Johnson Wang ha scritto:
> > Add the new binding documentation for MediaTek frequency hopping
> > and spread spectrum clocking control.
> > 
> > Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >   .../arm/mediatek/mediatek,mt8186-fhctl.yaml   | 53 +++++++++++++++++++
> >   1 file changed, 53 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml
> > new file mode 100644
> > index 000000000000..258dff7ce6bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-fhctl.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-fhctl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek frequency hopping and spread spectrum clocking control
> > +
> > +maintainers:
> > +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> > +
> > +description: |
> > +  Frequency hopping control (FHCTL) is a piece of hardware that control
> > +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
> > +  Spread spectrum clocking (SSC) is another function provided by this hardware.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8186-fhctl
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: Phandles of the PLL with FHCTL hardware capability.
> > +    minItems: 1
> > +    maxItems: 30
> > +
> > +  mediatek,hopping-ssc-percent:
> > +    description: The percentage of spread spectrum clocking for one PLL.
> > +    minItems: 1
> > +    maxItems: 30
> > +    items:
> > +      default: 0
> > +      minimum: 0
> > +      maximum: 8
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8186-clk.h>
> > +    fhctl: fhctl@1000ce00 {
> > +        compatible = "mediatek,mt8186-fhctl";
> > +        reg = <0x1000c000 0xe00>;
> > +        clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
> > +        mediatek,hopping-ssc-percent = <3>;
> > +    };
> 
> 
> .... a more realistic example:

One or 2 cells is really outside the scope of the binding as either is 
valid. If the parent bus only has 32-bits of address space, there's 
little reason to use 2 cells.

> 
>     #include <dt-bindings/clock/mt8186-clk.h>
> 
>     soc {
>         #address-cells = <2>;
>         #size-cells = <2>;
> 
>         fhctl: fhctl@1000ce00 {
>             compatible = "mediatek,mt8186-fhctl";
>             reg = <0 0x1000c000 0 0xe00>;
>             clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
>             mediatek,hopping-ssc-percent = <3>;
>         };
>     };
> 
> After which...
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
