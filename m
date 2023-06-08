Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F457284A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjFHQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFHQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:11:49 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D111A;
        Thu,  8 Jun 2023 09:11:48 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777a78739ccso28795639f.3;
        Thu, 08 Jun 2023 09:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240707; x=1688832707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26KBilvVs6afu542i83fb+lijdLGAn06fS/N0hyLp/w=;
        b=fQR5o5PMMCkkaLojBudmJVYmXZhCO+OvF4+FWlEUBJvXRslXcNt37HtL8N2GQFa6Lu
         g5+TfvayktCRbvt6kOI0SsQOBEN6roFxmjaeWxhG7tpQySTHm6Uhtjto6h+SWS8deNa2
         IHFN5rmK1UzFUDnxGuVJZdyOFXZpNQ064ECLvdnq2GZAFNczGEW/FyWwoPB4fkNlvGOk
         sYqFnPekS7VFtEIbkEic+mXk8lzdSNdWlIkgmIXu2iZcaKLBs4388oGtqR8v4kHXkvUC
         isRZ6HQ6e2C1JjjbOpbOEPFn0OiyjM4W+cA80q+q2R25XhcWv4/y75Lq2b8dTDR4O9hU
         8aXg==
X-Gm-Message-State: AC+VfDzP5c+LTrWUUc7Hj0X5qu84S+Rno1/NXInKEwppRKe9YmVWyIDy
        R9IffdlCmduOHKB1QsriqQ==
X-Google-Smtp-Source: ACHHUZ5R8vQwbGmWpa2QNkof6Mcj9aGaspTYPsYuRTUeIeyy4S0WNvH+R3d1ip3MXLsHjEgR0qVO3g==
X-Received: by 2002:a6b:e312:0:b0:774:9b75:b463 with SMTP id u18-20020a6be312000000b007749b75b463mr13934604ioc.7.1686240707415;
        Thu, 08 Jun 2023 09:11:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g22-20020a02cd16000000b00418996053edsm368032jaq.23.2023.06.08.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:11:46 -0700 (PDT)
Received: (nullmailer pid 2790234 invoked by uid 1000);
        Thu, 08 Jun 2023 16:11:44 -0000
Date:   Thu, 8 Jun 2023 10:11:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded
 address/size-cells and children
Message-ID: <20230608161144.GA2788922-robh@kernel.org>
References: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
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

On Sat, May 06, 2023 at 08:41:28AM +0200, Krzysztof Kozlowski wrote:
> Referenced nvmem.yaml schema already defines address/size-cells and its
> children, so remove redundant entries.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 21 -------------------
>  1 file changed, 21 deletions(-)

Srinivas, going to pick this up?

> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> index 9876243ff1e8..0784d71ae8f9 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
> @@ -46,12 +46,6 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  "#address-cells":
> -    const: 1
> -
> -  "#size-cells":
> -    const: 1
> -
>    clocks:
>      maxItems: 1
>  
> @@ -61,21 +55,6 @@ required:
>    - compatible
>    - reg
>  
> -patternProperties:
> -  "^.*@[0-9a-f]+$":
> -    type: object
> -
> -    properties:
> -      reg:
> -        maxItems: 1
> -        description:
> -          Offset and size in bytes within the storage device.
> -
> -    required:
> -      - reg
> -
> -    additionalProperties: false
> -
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 
