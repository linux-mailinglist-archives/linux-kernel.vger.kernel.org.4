Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8A6A33B7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBZTnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBZTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:42:58 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158EA903A;
        Sun, 26 Feb 2023 11:42:57 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id 4so2905838ilz.6;
        Sun, 26 Feb 2023 11:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtT+Z3pFPpOEqZmngNc+yA6W219QO8If0bra67yUF28=;
        b=r7l6vfLimc5RYp0uEe1Defeknd3I21oK8sAWoaN9rKIJ0sihEtF+8/xgNN6aGq6rm/
         lLrwzHuEdCUfSS4Kd+g7PWNePnn+w1lWAuu6RGRZOLmn5CJ8BahGEcvQa9AlMN40Mhod
         l/t7oHikkYLZw2Rb93W1qxiBU2kyZw7jQc90Iy71bqbp0VbLAuKruIhWw9K6MusH6ORd
         0PDQdWzFwx+TYcQyYV8cy8iisvDQbuxTuoLrCbzv9KEX12OVlz7AmKYbx65HfAMTUJBX
         ESXq4RO8TCkYhUyBwX12T543buG7yKGlVd7gy6JOJBbiKjhTGZ9jvoveVk8pJTsSKEAV
         eypw==
X-Gm-Message-State: AO0yUKXEsYO9vAGHyk2AKRRUrBcccUXL/d7Q/Ozd4oxGd6hM5YoJGLHA
        chX3f/bZyBnJgv6JyNng3w==
X-Google-Smtp-Source: AK7set+Mmdqra371m8aWNR9Mf1y+Mo8dbFVW+d9I13ug2maKvRB/Jd3LigcdwUGIRXdeDS8Xw4aJRQ==
X-Received: by 2002:a05:6e02:1445:b0:316:e54a:828f with SMTP id p5-20020a056e02144500b00316e54a828fmr16022653ilo.6.1677440576320;
        Sun, 26 Feb 2023 11:42:56 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id k6-20020a02a706000000b003c48d97bea7sm1495927jam.147.2023.02.26.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:42:55 -0800 (PST)
Received: (nullmailer pid 197344 invoked by uid 1000);
        Sun, 26 Feb 2023 19:42:51 -0000
Date:   Sun, 26 Feb 2023 13:42:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 08/10] dt-bindings: dsp: add Fortemedia FM34 DSP
Message-ID: <20230226194251.GA192429-robh@kernel.org>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-9-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-9-clamor95@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:32:09PM +0200, Svyatoslav Ryhel wrote:
> Add dt-binding for Fortemedia FM34NE DSP.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/dsp/fortemedia,dsp.yaml          | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml b/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
> new file mode 100644
> index 000000000000..78f30969d9bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/fortemedia,dsp.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/fortemedia,dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fortemedia DSP core
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description: |

Don't need '|'

> +  Asus Transformer T20/T30 tablet family contains a DSP core
> +  used for advanced noise cancellation.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - asus,tf101-dsp
> +          - asus,tf201-dsp
> +          - asus,tf300t-dsp
> +          - asus,tf700t-dsp
> +          - pegatron,chagall-dsp
> +

Drop blank line.

> +      - const: fortemedia,fm34
> +
> +  reg:
> +    maxItems: 1
> +
> +  bypass-gpios:

Needs a description what this is.

> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
> +  assigned-clock-rates:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra30-car.h>
> +    #include <dt-bindings/soc/tegra-pmc.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dsp@60 {
> +            compatible = "asus,tf201-dsp", "fortemedia,fm34";
> +            reg = <0x60>;
> +
> +            bypass-gpios = <&gpio 222 0>;
> +            reset-gpios = <&gpio 115 1>;
> +
> +            vdd-supply = <&vdd_1v8_dsp>;
> +
> +            clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
> +            clock-names = "mclk";
> +
> +            assigned-clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
> +            assigned-clock-parents = <&tegra_car TEGRA30_CLK_EXTERN1>;
> +        };
> +    };
> +
> +    vdd_1v8_dsp: regulator-dsp {
> +        compatible = "regulator-fixed";
> +        regulator-name = "vdd_1v8_dsp";
> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <1800000>;
> +        gpio = <&gpio 165 0>;
> +        enable-active-high;
> +    };

Drop this node. No need to show providers in consumer examples.

Rob
