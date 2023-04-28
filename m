Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994656F2035
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbjD1VmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbjD1VmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:42:06 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0B40CB;
        Fri, 28 Apr 2023 14:41:59 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-18f16a2c329so14129707fac.0;
        Fri, 28 Apr 2023 14:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718119; x=1685310119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxtZnuIy0A7kqLFx2X9sGSOUm6gtVrEopxo0uafl4ms=;
        b=TC2FAGgk8oNSwSyic1J0ZVw10Avcvd9lLjACZZ9o3oJEsACh1uFwbynF9MvYNQs+gj
         UiM0jGexdKwkH5aCg44WVu+54uuLVLWpcj/heLzFR6hDMelqkIKcBE1D1lpmUWu87OcH
         lsxAjjHzhgN0Sl7dp4sEDdAboEQu0ll9FLZbUfYOppoYC6d30gbOKjeN2WuuhCEIKgCz
         Y6rVfeIbLLwYGnj9ROykmU30LIrcUnIBFcu8koD/UqrVaMb3PDhY2ElgOFcMAyidACYf
         SP4l1pUkfKqdRxNqhCg5l7MqdVIsSaI9nzI+bA42HiSrurpFay9aaYR+i/9opWY7e4Tq
         hZbQ==
X-Gm-Message-State: AC+VfDysJf0FrD/h54OpFrqMwNhn99aIUHIObenXfUngYZGcqskrUozD
        YW2vrI6WPBGmbttw7m+Lzu1umdsPEg==
X-Google-Smtp-Source: ACHHUZ7ig/kRGrr3EBDJFMjrS7DQC209jAzc9ANKsoMDyT4ZiCAvOl0+vyGPxIeVYeEzqvF/Kp/Ovw==
X-Received: by 2002:aca:3257:0:b0:38e:32b5:cfba with SMTP id y84-20020aca3257000000b0038e32b5cfbamr4878446oiy.10.1682718118679;
        Fri, 28 Apr 2023 14:41:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e131-20020acab589000000b00383d9700294sm9272371oif.40.2023.04.28.14.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:41:58 -0700 (PDT)
Received: (nullmailer pid 326660 invoked by uid 1000);
        Fri, 28 Apr 2023 21:41:57 -0000
Date:   Fri, 28 Apr 2023 16:41:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: spi: stm32: add address-cells and
 size-cells into yaml
Message-ID: <20230428214157.GA322525-robh@kernel.org>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-2-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428121524.2125832-2-valentin.caron@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:15:18PM +0200, Valentin Caron wrote:
> Theses properties need to be described to satisfy dtbs_check.

No, they are defined in spi-controller.yaml, so they should not be 
needed here.

> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index 9ca1a843c820..c599eb359d56 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -29,6 +29,9 @@ allOf:
>          st,spi-midi-ns: false
>  
>  properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
>    compatible:
>      enum:
>        - st,stm32f4-spi
> -- 
> 2.25.1
> 
