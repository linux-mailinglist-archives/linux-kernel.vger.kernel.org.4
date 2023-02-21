Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA369D84C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBUCJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBUCJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:09:02 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55589BDFB;
        Mon, 20 Feb 2023 18:09:01 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id dm12-20020a0568303b8c00b0068db1940216so573419otb.5;
        Mon, 20 Feb 2023 18:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaCzmLIAtbUc4HRmFdAW9ZA8YQ/UqNUlZVInqvCf2qc=;
        b=O+FEOOeeig9Nu5fFhinJqOl8/GAmw8flPVdLz4eyJM/HpQ0t2DGvKGQlBtCoxSqhIc
         yGELmiAM5BnoIaIEUeU5DVoFuOsok5+Uni9wOmJC6E4jNBXpw4+moKPN1LZ5mA/sOzb1
         VyNlj7ig33HOjeXODJ3G7+9T5Vh41f9hAtnUxbyFuaEwhjiaBFQtIeEnI2tWHhsORweL
         zhnTqi4k8HfEAPjX4RrulU8Wjc7ME16EDMAxQ4aUiGhibO0UwXUW2AujjnmO9MQdBrc1
         ehYWmBJmcC7Gy4uTVltM0OU3z1NctJ8iNYjFZblW8GBZD2M5sgKhR7EN/+UHXrDWmz0P
         Nyhw==
X-Gm-Message-State: AO0yUKUgFPygF1z1rcHgLTG67Ofl7HOWBuhLoFMfzyiQ5pG9Cced7M92
        /cBTzgQBEbnK8wQIYt4fhooaQfw4Bg==
X-Google-Smtp-Source: AK7set+VLFjFR/wylXJ3C/AGCZbei58NSvFlX1oxhbZJrowNRO18L2PfRsf7pchZc2BdmGGxgq1h9g==
X-Received: by 2002:a9d:6c7:0:b0:68b:e2bb:8027 with SMTP id 65-20020a9d06c7000000b0068be2bb8027mr989444otx.14.1676945340511;
        Mon, 20 Feb 2023 18:09:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i2-20020a9d4a82000000b0068d542f630fsm68790otf.76.2023.02.20.18.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:08:59 -0800 (PST)
Received: (nullmailer pid 822010 invoked by uid 1000);
        Tue, 21 Feb 2023 02:08:59 -0000
Date:   Mon, 20 Feb 2023 20:08:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Lenovo NT36523W BOE
 panel
Message-ID: <20230221020859.GA818929-robh@kernel.org>
References: <20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org>
 <20230217-topic-lenovo-panel-v1-1-9d7ee1602089@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-lenovo-panel-v1-1-9d7ee1602089@linaro.org>
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

On Fri, Feb 17, 2023 at 12:29:07PM +0100, Konrad Dybcio wrote:
> Add bindings for the 2000x1200px IPS panel found on Lenovo Tab P11/
> XiaoXin Pad devices.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../display/panel/lenovo,nt36523w-boe-j606.yaml    | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
> new file mode 100644
> index 000000000000..43dcbe3f9f30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lenovo,nt36523w-boe-j606.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NT36523W BOE panel found on Lenovo J606 devices
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lenovo,nt36523w-boe-j606
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  vddio-supply: true

If only one supply, why not use panel-simple-dsi.yaml? Though probably 
there's more than just an IO supply?

Rob
