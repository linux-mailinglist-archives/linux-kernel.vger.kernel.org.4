Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E26D53F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjDCVtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjDCVsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:48:52 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2541FDC;
        Mon,  3 Apr 2023 14:48:39 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id m6-20020a4ae846000000b0053b9059edd5so4864604oom.3;
        Mon, 03 Apr 2023 14:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680558519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wrphn2RbQxhqb4KnvKWMrPJ8i5lbLoF9mCmsVowmwkg=;
        b=dQ5nS698k9OhHk0Tvx2SpY/D+cCpd5/J3pfIF7O9NliTzHuk6sbG25fYnjyM5bgVIi
         oiZ58+OyR+UIc/AWdsQSDVxN6nXjZtlN7AMk4f5O41Hr9GMjCwTJ2zvc0/hEV9fe3sKf
         Zc7gulW+WJyxhqkk0W6XflCvtaUN3gs3ohJ9q4WJ3/EfIhn9po8R0AT092k9STaVfoHj
         4gLoNTn5r5wts6YQaCrjM6molAbyIT/OhW2MtnG1xfk/ZjIn9V8/ngUMAajvQm2UBVh3
         hanaSAat6cwxKGRkeHs1ljPyKt0B7iX0tpnTpI5G5YoTWH3DtHPDJeDoObj51PY2Dt9x
         pGIQ==
X-Gm-Message-State: AAQBX9euhph1sCwHpyToYrHoqmdeQogtWrZXrb9caBD/v8Zi39TKJXyI
        Jqs/KZJEkE4QDRy825hi4g==
X-Google-Smtp-Source: AKy350bjK0iTokfHBX3EJX8gHNogmylb/8/qT4XjwPfgChu7PTa1Yi9Ja5tOQ1XLB74XQSBBBWF+Mw==
X-Received: by 2002:a4a:2c0e:0:b0:537:f9d4:a44c with SMTP id o14-20020a4a2c0e000000b00537f9d4a44cmr420692ooo.5.1680558518842;
        Mon, 03 Apr 2023 14:48:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w129-20020a4a5d87000000b005414543377asm1113130ooa.20.2023.04.03.14.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:48:38 -0700 (PDT)
Received: (nullmailer pid 1932535 invoked by uid 1000);
        Mon, 03 Apr 2023 21:48:37 -0000
Date:   Mon, 3 Apr 2023 16:48:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v3 1/9] media: dt-bindings: Add bindings for JH7110
 Camera Subsystem
Message-ID: <20230403214837.GA1925690-robh@kernel.org>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-2-jack.zhu@starfivetech.com>
 <91874e63-553f-ced5-ce32-309ac2ebf6e5@linaro.org>
 <b8d25a66-6464-78fe-b39b-ebb8a7f1a99c@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d25a66-6464-78fe-b39b-ebb8a7f1a99c@starfivetech.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 05:14:25PM +0800, Jack Zhu wrote:
> 
> 
> On 2023/4/1 4:09, Krzysztof Kozlowski wrote:
> > On 31/03/2023 14:18, Jack Zhu wrote:
> >> Add the bindings documentation for Starfive JH7110 Camera Subsystem
> >> which is used for handing image sensor data.
> >> 
> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> >> ---
> >>  .../bindings/media/starfive,jh7110-camss.yaml | 159 ++++++++++++++++++
> >>  MAINTAINERS                                   |   7 +
> >>  2 files changed, 166 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> >> 
> >> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> >> new file mode 100644
> >> index 000000000000..0235c70e7793
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> >> @@ -0,0 +1,159 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Starfive SoC CAMSS ISP
> >> +
> >> +maintainers:
> >> +  - Jack Zhu <jack.zhu@starfivetech.com>
> >> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> >> +
> >> +description:
> >> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
> >> +  consists of a VIN controller (Video In Controller, a top-level control until)
> >> +  and an ISP.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: starfive,jh7110-camss
> >> +
> >> +  reg:
> >> +    maxItems: 2
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: syscon
> >> +      - const: isp
> >> +
> >> +  clocks:
> >> +    maxItems: 7
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: apb_func
> >> +      - const: wrapper_clk_c
> >> +      - const: dvp_inv
> >> +      - const: axiwr
> >> +      - const: mipi_rx0_pxl
> >> +      - const: ispcore_2x
> >> +      - const: isp_axi
> >> +
> >> +  resets:
> >> +    maxItems: 6
> >> +
> >> +  reset-names:
> >> +    items:
> >> +      - const: wrapper_p
> >> +      - const: wrapper_c
> >> +      - const: axird
> >> +      - const: axiwr
> >> +      - const: isp_top_n
> >> +      - const: isp_top_axi
> >> +
> >> +  power-domains:
> >> +    items:
> >> +      - description: JH7110 ISP Power Domain Switch Controller.
> >> +
> >> +  interrupts:
> >> +    maxItems: 4
> >> +
> >> +  ports:
> >> +    $ref: /schemas/graph.yaml#/properties/ports
> >> +
> >> +    properties:
> >> +      port@0:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        unevaluatedProperties: false
> >> +        description:
> >> +          Input port for receiving DVP data.
> >> +
> >> +        properties:
> >> +          endpoint:
> >> +            $ref: video-interfaces.yaml#
> > 
> > I don't think we use video-interfaces with port. Are you sure this works
> > fine? Please extend the example with appropriate properties to check...
> > 
> Thank you for your review.
> the following change, is it OK?

What Krzysztof meant is port@0 needs to $ref '$defs/port-base' rather 
then 'properties/port' to work with video-interfaces.yaml. If you made 
that change, then this is fine.

> 
> endpoint:
>             $ref: video-interfaces.yaml#
>             unevaluatedProperties: false
>             
>             properties:
>               bus-width:
>                 const: 8
> 
>               data-shift:
>                 const: 2
> 
> in example:
> 	port@0 {
>                 reg = <0>;
>                 vin_from_sc2235: endpoint {
>                     remote-endpoint = <&sc2235_to_vin>;
>                     bus-width = <8>;
>                     data-shift = <2>;
>                     hsync-active = <1>;
>                     vsync-active = <0>;
>                     pclk-sample = <1>;
>                 };
> 	};
> 
> 
> >> +            unevaluatedProperties: false
> >> +
> >> +      port@1:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        unevaluatedProperties: false
> >> +        description:
> >> +          Input port for receiving CSI data.
> >> +
> >> +        properties:
> >> +          endpoint:
> >> +            $ref: video-interfaces.yaml#
> >> +            unevaluatedProperties: false
> > 
> > Same concerns here.
> > 
> for port@1, We don't use any properties as the allwinner,sun6i-a31-isp.yaml file.
> Use the following modification, I don't know if it is ok?

Yes.
 
> port@1:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: Input port for receiving CSI data.

Rob
