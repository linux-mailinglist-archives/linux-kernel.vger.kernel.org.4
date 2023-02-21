Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6234B69D841
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBUCBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBUCB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:01:29 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199E1DBA1;
        Mon, 20 Feb 2023 18:01:28 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1720600a5f0so3651679fac.11;
        Mon, 20 Feb 2023 18:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jYXquKsgZIFAoZjrn3r51f5Nrmgo9YGfeaRxylpkY0=;
        b=rPLajTMuLAzrMw8uO3UntI9Im6eGJcCXgNWgJ1yjHVnnJMZn0mcsZMHk0M/FbcyvOJ
         /c12HxH64uCirjIJcAM4QtWyBehr8xO6qSOle6U9BgiUHBXgDMusfibuOodacebOUSDH
         o1OFgf5yyejX3YavvVdzxfuW3mSS5uRSBCcW9pJO9yCMB1FVqyxTgVx+fe1UhxIe/Yvu
         oOZOFX7Z+V4PWAUNaz+FYdt7QVMcAFY5iIAwNQMzrPCFglTsLZqtrDaMaIXXoko22rRp
         lEpPIlxmY0g9Wqz+rH5Nor6BmlX/Rqe171jwgDbOEutNg6o75zp3ndwLaXq9+/OgZehr
         z4yg==
X-Gm-Message-State: AO0yUKVaS/sX+XTZXgZSQzReXtC3I+yty0FuGK014y6fYpWhvZVR9t7t
        hYdi3gCOBM/5IWfPcKUieg==
X-Google-Smtp-Source: AK7set9d0zjKNMsdi8TCvYfsVpTCo9aao00Vu6+Asj/xnVj0OI/05cUknCxmTm4mIs3fDkKxERnruw==
X-Received: by 2002:a05:6870:fba9:b0:172:2d00:9a4c with SMTP id kv41-20020a056870fba900b001722d009a4cmr140644oab.34.1676944888035;
        Mon, 20 Feb 2023 18:01:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i3-20020a056870864300b001631c92e8b6sm4935988oal.4.2023.02.20.18.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:01:27 -0800 (PST)
Received: (nullmailer pid 810154 invoked by uid 1000);
        Tue, 21 Feb 2023 02:01:26 -0000
Date:   Mon, 20 Feb 2023 20:01:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gene Chen <gene_chen@richtek.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings usb: typec: rt1711h: Use a generic node
 name
Message-ID: <20230221020126.GA797846-robh@kernel.org>
References: <20230216121211.3964433-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216121211.3964433-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:12:10PM +0100, Konrad Dybcio wrote:
> Node names should be generic. Use typec-portc@ instead of rt1711h@.

What's generic? Others use just 'typec' IIRC. We must first define the 
generic name for everyone, then do this. It doesn't really work defining 
this in each binding either as there's no checking a generic name is in 
fact used. We either need a class type schema (which don't work when 
devices support multiple classes) or a meta-schema checking $nodename 
patterns match a set of known node names.

> 
> Fixes: a72095ed8e65 ("dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> index 1999f614c89b..7431c25d82ce 100644
> --- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> @@ -17,6 +17,9 @@ description: |
>    support for alternative interfaces of the Type-C specification.
>  
>  properties:
> +  $nodename:
> +    pattern: "^typec-portc@[0-9a-f]+$"
> +
>    compatible:
>      enum:
>        - richtek,rt1711h
> @@ -55,7 +58,7 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> -      rt1711h@4e {
> +      typec-portc@4e {
>          compatible = "richtek,rt1711h";
>          reg = <0x4e>;
>          interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> -- 
> 2.39.1
> 
