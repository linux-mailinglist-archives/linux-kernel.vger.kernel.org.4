Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE34967BA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjAYTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAYTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:05:45 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57080C665;
        Wed, 25 Jan 2023 11:05:44 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15ff0a1f735so14319247fac.5;
        Wed, 25 Jan 2023 11:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhr1Snnnfv3Lio+Z/H9CduUQNrxN5G15yH6OHJ4yvHM=;
        b=W7/2QE8jq91Sjaon3GoIN+Yp9OploIUnfVEBrIRrA7Z4HE65FRikJ2De/Pgpfth4wA
         /CV3FgvsD5nEEeyBvk8yHSG53yNTBfLAylwJp4FjMrna7o/9lVf5QTgXwkwpL+BtpP6x
         utwhBasjzDHoaw1jIfNKbpWIKKgCmQuVAON4rWh7jxCAsuJfxxi1cjq2cQSo/97Cjix7
         90OoLDhItp90u4xA2rNswAGT3UEHBj9huQUANXWSOTB6R4+60sQy+L0YTEeTiL5nIWa/
         FVRGg9kL54Z6ECPp0pubVod0B43TaZJP/gisAKj8BDN4E7Cn0xbybR1bmUK+Hc6d1pAi
         0cTQ==
X-Gm-Message-State: AFqh2koSW3efCAmxeS7rUhOqFQaw8oc0dsr+9nZr32raBBjnt56C1Cbb
        Q/QurRqbepEluebiCgWG7A==
X-Google-Smtp-Source: AMrXdXsWj1xQcwnmtT18eTlSoYpv3JQC0KDpfuKbQAUsGlJZ7i1zq7QLTwf2BT+qCsfMea1enMhlpQ==
X-Received: by 2002:a05:6870:494b:b0:143:e045:7082 with SMTP id fl11-20020a056870494b00b00143e0457082mr16657899oab.58.1674673543521;
        Wed, 25 Jan 2023 11:05:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pd19-20020a0568701f1300b0014fd25bd3b5sm2305427oab.0.2023.01.25.11.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:05:42 -0800 (PST)
Received: (nullmailer pid 2693269 invoked by uid 1000);
        Wed, 25 Jan 2023 19:05:42 -0000
Date:   Wed, 25 Jan 2023 13:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v7 2/6] dt-bindings: display: ti,am65x-dss: Add support
 for am625 dss
Message-ID: <20230125190542.GA2690295-robh@kernel.org>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
 <20230125113529.13952-3-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125113529.13952-3-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 05:05:25PM +0530, Aradhya Bhatia wrote:
> The DSS controller on TI's AM625 SoC is an update from that on TI's
> AM65X SoC. The former has an additional OLDI TX on its first video port
> (VP0) that helps output cloned video or WUXGA (1920x1200@60fps)
> resolution video output over a dual-link mode to reduce the required
> OLDI clock output.
> 
> Add the new controller's compatible and a port property for the 2nd OLDI
> TX (OLDI TX 1).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/display/ti/ti,am65x-dss.yaml     | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 5c7d2cbc4aac..55ec91f11577 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -19,7 +19,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: ti,am65x-dss
> +    enum:
> +      - ti,am625-dss
> +      - ti,am65x-dss
>  
>    reg:
>      description:
> @@ -80,13 +82,18 @@ properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
> -          The DSS OLDI output port node form video port 1
> +          The DSS OLDI output port node form video port 1 (OLDI TX 0).

s/form/from/

>  
>        port@1:
>          $ref: /schemas/graph.yaml#/properties/port
>          description:
>            The DSS DPI output port node from video port 2
>  
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          The DSS OLDI output port node form video port 1 (OLDI TX 1).

s/form/from/


> +
>    ti,am65x-oldi-io-ctrl:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description:
> @@ -102,6 +109,18 @@ properties:
>        Input memory (from main memory to dispc) bandwidth limit in
>        bytes per second
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,am65x-dss
> +    then:
> +      properties:
> +        ports:
> +          properties:
> +            port@2: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.39.0
> 
