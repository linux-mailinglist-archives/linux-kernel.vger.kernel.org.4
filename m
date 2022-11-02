Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87F46168C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiKBQ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKBQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:28:16 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006242CDE8;
        Wed,  2 Nov 2022 09:23:43 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id s206so19735024oie.3;
        Wed, 02 Nov 2022 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArImpJZNyMuqB41SlvrWbpD1C1fAYza6cCSGrdURoHQ=;
        b=1SK+navsNYN5SKtd+I3ENB8dTBN6CKhDUFd4Tuwkv1bzRrZHjwmGhRcaRl7PcLm4ru
         m9yKYNkpaSwPsAds4zPrMxqsJCQI4suLGmbh8AP7C6EaIIYEyA50AXoT16ml+27wlZKF
         b2yBf2eegb5zepFsinCOVnCf1MoBrj0VTTztLYHcdJcKzQa7WTmYKQe4rDHRVxuGX9HU
         JDEPaAV+rukgNFHb5jxn7B8bB2bclKL8Mj1/t4NGQmcVEBzWYcUiNLyF5Wi5XBp101RA
         8I+Fw0b+IGbGT04IG80QdJDlbpye94AnFwyxziE326ZESxNZJt3tQrUunAliFDfoLItv
         pBuw==
X-Gm-Message-State: ACrzQf3kseozTO7ZMsALDD/NOHtzVulJow7f4voUviCHZKY82bSARqJ2
        PPWunySncVsaHGPjZ28p2A==
X-Google-Smtp-Source: AMsMyM4x7Ze5gmyrwMejMf5OYTUdwzld0GDFsHu6nva22uV0UXFmTGNXQ/gF7bSrV5yC0cuzzrGVSw==
X-Received: by 2002:aca:db45:0:b0:354:b943:9e5b with SMTP id s66-20020acadb45000000b00354b9439e5bmr13918471oig.277.1667406223095;
        Wed, 02 Nov 2022 09:23:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl8-20020a056808308800b0035028730c90sm4664594oib.1.2022.11.02.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:23:42 -0700 (PDT)
Received: (nullmailer pid 3997053 invoked by uid 1000);
        Wed, 02 Nov 2022 16:23:44 -0000
Date:   Wed, 2 Nov 2022 11:23:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: document Odroid Go Ultra
 power-off
Message-ID: <20221102162344.GA3993882-robh@kernel.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:47:25PM +0100, Neil Armstrong wrote:
> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
> to its two PMICs in order, this represents the poweroff scheme needed to complet
> a clean poeroff of the system.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../reset/hardkernel,odroid-go-ultra-poweroff.yaml | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
> new file mode 100644
> index 000000000000..65e42258717c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/hardkernel,odroid-go-ultra-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hardkernel Odroid Go Ultra poweroff
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
> +  to its two PMICs in order, this represents the poweroff scheme needed to complete
> +  a clean poeroff of the system.

You don't really need a node for this. Test against the top level 
compatible and then find the PMIC nodes by their compatible strings.

> +
> +properties:
> +  compatible:
> +    const: hardkernel,odroid-go-ultra-poweroff
> +
> +  hardkernel,rk817-pmic:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the RK817 PMIC node
> +
> +  hardkernel,rk818-pmic:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the RK818 PMIC node
> +
> +required:
> +  - compatible
> +  - hardkernel,rk817-pmic
> +  - hardkernel,rk818-pmic
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    poweroff {
> +        compatible = "hardkernel,odroid-go-ultra-poweroff";
> +        hardkernel,rk817-pmic = <&rk817>;
> +        hardkernel,rk818-pmic = <&rk818>;
> +    };
> 
> -- 
> b4 0.10.1
> 
