Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04614729F7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbjFIQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbjFIQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:00:13 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53495;
        Fri,  9 Jun 2023 09:00:12 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33d31ab00bdso8125075ab.3;
        Fri, 09 Jun 2023 09:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686326411; x=1688918411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo6pQQz/UcpKzu+A/oD9rYPc78cI4TMDsCJ+p2y8fSM=;
        b=lHEICqTh3xi06R1t+1JvQ8HKFopUJ/ODRiKqu+WaboZQMfRAnj+PnU1aDOsP1jvlAH
         R3aC/Ws3VuNiAKAJSTxsh+d0a95zfFF/gmI6gFqWbkhOJXmalOdjOqOGA0YVt54OEls+
         vqY1ucYwRG/AQjovySU0dsPYT722UaRGefNz8zWqxP9NeR55GPWxMdG1FBhFVU7Br3Ta
         HFeBbJQstLoiIPynU1I//VqDwGFIafj+xhVqqu0oFB0aY2SmVnwbSm/LC1LNO74EhLOn
         IWb/s7g0QCtTTYKOC2twXWhHndV16YJsi/nbkB/qHC9SnirwESZgspYQg/8xH5izYvR+
         Od0A==
X-Gm-Message-State: AC+VfDxhWBCSVQalZD7fCJKqlqlcXzfeXZjINilPs/nXl5eAW/60kAlD
        cthZo3Ue+1y2xO+M/gcv9A==
X-Google-Smtp-Source: ACHHUZ7Rd2jsilSxCBZZUMMDilUOPcReyXqGBLxY1gsq3rBmEkUqJq9D61+W8XkS3BSNrDKSXBytjw==
X-Received: by 2002:a92:da87:0:b0:331:cd3:90a7 with SMTP id u7-20020a92da87000000b003310cd390a7mr1836991iln.17.1686326411170;
        Fri, 09 Jun 2023 09:00:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cf28000000b003e9e5e1aacasm1061145jar.143.2023.06.09.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:00:10 -0700 (PDT)
Received: (nullmailer pid 1133062 invoked by uid 1000);
        Fri, 09 Jun 2023 16:00:08 -0000
Date:   Fri, 9 Jun 2023 10:00:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: gateworks-gsc: remove
 unnecessary fan-controller nodes
Message-ID: <20230609160008.GA1132019-robh@kernel.org>
References: <20230522193219.1477158-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522193219.1477158-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:32:16PM -0700, Tim Harvey wrote:
> Remove the unnecessary #address-cells and #size-cells nodes from
> the fan-controller. These are not needed as the fan controller does not
> have any children.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v2:
>  - udpated commit log to explain why the nodes are unnessesary
>  - added Krzysztof's rb tag
>  - added Connor's ab tag
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml         | 10 ----------
>  1 file changed, 10 deletions(-)

This is not going to get applied if you don't send it to Lee.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> index acb9c54942d9..dc379f3ebf24 100644
> --- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -122,12 +122,6 @@ patternProperties:
>        compatible:
>          const: gw,gsc-fan
>  
> -      "#address-cells":
> -        const: 1
> -
> -      "#size-cells":
> -        const: 0
> -
>        reg:
>          description: The fan controller base address
>          maxItems: 1
> @@ -135,8 +129,6 @@ patternProperties:
>      required:
>        - compatible
>        - reg
> -      - "#address-cells"
> -      - "#size-cells"
>  
>  required:
>    - compatible
> @@ -194,8 +186,6 @@ examples:
>              };
>  
>              fan-controller@2c {
> -                #address-cells = <1>;
> -                #size-cells = <0>;
>                  compatible = "gw,gsc-fan";
>                  reg = <0x2c>;
>              };
> -- 
> 2.25.1
> 
