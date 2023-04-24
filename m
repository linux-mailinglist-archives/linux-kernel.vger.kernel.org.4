Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15226ED266
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjDXQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDXQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:25:52 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674399008;
        Mon, 24 Apr 2023 09:25:50 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-187fc21f6acso1621934fac.2;
        Mon, 24 Apr 2023 09:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353549; x=1684945549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYc7VTBHaoCcnGKGN3LHqqJbrueJDpL55HrA0KKEtPA=;
        b=hxYE3bZhVJmFkAulSQbyrQlPogxO9iln+wQpma1IjVSCpee3/DruKjETI3FhNjK21D
         9SKm4c4OgfQzyx7f9ByeTYHO+K7xGv5V3jQQrzHvGCEMuefEcw46jUXlG5OpJDUIFX2u
         ckOKdhT+XGlENm8A6eyX3WiGB2AgXshB5GtGcYm2QCYrIyYM5w98MZDYtqpke8ADTVV3
         EttngL6LEo21CsToFBFifd+NQipSvNzqxRx1PqZrCAK9rc2EJBnotaWf7Jxbgi5Jx7pf
         gbTDabZePoUJSRm/WdXv3BLN74XJWjDH0Cyx/MBkTyu0FArvNltgzBwZFoXfJH81dppy
         uMLA==
X-Gm-Message-State: AAQBX9dXIbOpsJFNtG6s2SNpynPZ5PAuj+D/eFiKWTD+G7KhJBGZjtbM
        X/3LLfb5By78geUZSN96Eg==
X-Google-Smtp-Source: AKy350Yfaz+VuSxsA/jla5dgW+ksuw/am73QFaYWILnHxGr7pfffiqli1vQtsVp5llqNffj1A0VhZw==
X-Received: by 2002:a05:6870:eca7:b0:184:37a:41f5 with SMTP id eo39-20020a056870eca700b00184037a41f5mr10084299oab.30.1682353549506;
        Mon, 24 Apr 2023 09:25:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm5028167ooa.36.2023.04.24.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:25:49 -0700 (PDT)
Received: (nullmailer pid 2777356 invoked by uid 1000);
        Mon, 24 Apr 2023 16:25:48 -0000
Date:   Mon, 24 Apr 2023 11:25:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/43] dt-bindings: rtc: Add DT binding m48t86 rtc
Message-ID: <20230424162548.GI2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-29-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-29-nikita.shubin@maquefel.me>
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

On Mon, Apr 24, 2023 at 03:34:44PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/rtc/dallas,rtc-m48t86.yaml       | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> new file mode 100644
> index 000000000000..51f98bdbc385
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/dallas,rtc-m48t86.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST M48T86 / Dallas DS12887 RTC bindings
> +
> +maintainers:
> +  - Alessandro Zummo <a.zummo@towertech.it>
> +
> +properties:
> +  compatible:
> +    const: dallas,rtc-m48t86

'rtc-' is redundant. And haven't you mixed up the vendor and part 
number? It should be dallas,ds12887 and/or st,m48t86?

This can probably go in the trivial rtc binding.

> +
> +  reg:
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc1: rtc@10800000 {

Drop unused labels.

> +        compatible = "dallas,rtc-m48t86";
> +        reg = <0x10800000 0x1>, <0x11700000 0x1>;
> +    };
> +
> +...
> +
> -- 
> 2.39.2
> 
