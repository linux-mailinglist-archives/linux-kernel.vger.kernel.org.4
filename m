Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A189B658DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiL2OIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiL2OIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:08:37 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30024D13C;
        Thu, 29 Dec 2022 06:08:36 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r130so17246550oih.2;
        Thu, 29 Dec 2022 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke7StXTwXQ2hVrjMRliGLMG0bCAKmCvlu1qj8Ppc7ck=;
        b=L3guNH9dvXatTPRNPk20RBmq7TnpcjG9djNbKXmSuKura7H8i2w4QFn+Xu5jVXL+Yv
         iYQ3/5GB2mB3AQVgKRk0HgPb2DCm2j7xc5H8eiRQ4SF50zdWWwNh6sQWPVKyUuKY8wpO
         z3FAC3wqpkbaDRFKnqoj06xaRKqRNcWTJo70HK3Qi8Q+KwCMg1fmLxeR7vDBizgDt20d
         qtdfLoXQ+lslVRiGngCjL9CJFkNFkFUHhCY3VZmGCe0fbiJXg2l8x3tjuLZ+PoplVZSG
         DKGL+7ipceV7CkW7heYB2uindV097AGNnA51RT+rHdZdZ0iM5oCZwoTcU3bP/HYsN7bp
         2SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke7StXTwXQ2hVrjMRliGLMG0bCAKmCvlu1qj8Ppc7ck=;
        b=xUrpAB5fNjSKNKeRMMVrc/GKHJaIJJIKj9RicGanrs0cmFew5ua9S0Fj29d9VI3il5
         A61s+sKJsyofSsmQI7cpmwDP7vzBculAw3BfNT3vNSIMcR+EnJZdb2OpWklQLevBOKwj
         g83J7iNBjiAhP3rJ96sMgosGynhOQs7cUvTG9LB4p6z+/5XsB71yz95x/26ZLQ7Pj/57
         gnW2pZq/5nh2M2CeoWCMBajXXTvYMt9aC6FAYomwtmO+F8WPWPFSWHd1C9Ig+ROvy3iD
         g3iRYx44B1HGVpNLGmSYjlxs4BJJMEXMKeqNizklbI5dLSnQOms4ii4RJuqoUlxKWUu+
         FWgg==
X-Gm-Message-State: AFqh2krS8o2NK2bTJget1b+grpVcijFSxPxXKrSlAJKBC6dQ1W0LKDyL
        ZGD/qhaSMMClouD0IN8UmME=
X-Google-Smtp-Source: AMrXdXusbWGskS9q/0SDAxfvziuHmzaF+xYuvGyYi5uLMAQ1zZlcAK+zr363gezafa/LZ1PRMIIlgg==
X-Received: by 2002:a05:6808:13d6:b0:361:12d7:c15c with SMTP id d22-20020a05680813d600b0036112d7c15cmr16455997oiw.4.1672322915493;
        Thu, 29 Dec 2022 06:08:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s83-20020acac256000000b003509cc4ad4esm8069734oif.39.2022.12.29.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:08:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:08:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: Add mps,mpq7932
 power-management IC
Message-ID: <20221229140833.GA18009@roeck-us.net>
References: <20221207173716.123223-1-saravanan@linumiz.com>
 <20221207173716.123223-3-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207173716.123223-3-saravanan@linumiz.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 06:37:14PM +0100, Saravanan Sekar wrote:
> Document mpq7932 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Since this is in the regulator subsystem domain, I can not apply the
patch through hwmon without Acked-by: or Reviewed-by: from a regulator
maintainer.

Acked-by: Guenter Roeck <linux@roeck-us.net>

assuming that it will be applied through the regulator subsystem.

Turns out you did not actually copy a a regulator subsystem maintainer
or the regulator mailing list, so you'll have to re-send this patch for
inclusion there.

Guenter

> ---
>  .../bindings/regulator/mps,mpq7932.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
> new file mode 100644
> index 000000000000..2185cd011c46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mpq7932.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7932 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mps,mpq7932
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-6]
> +
> +    patternProperties:
> +      "^buck[1-6]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@3 {
> +            compatible = "mps,mpq7932";
> +            reg = <0x3>;
> +
> +            regulators {
> +                buck1 {
> +                    regulator-name = "buck1";
> +                    regulator-min-microvolt = <1600000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                };
> +
> +                buck2 {
> +                    regulator-name = "buck2";
> +                    regulator-min-microvolt = <1700000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                };
> +            };
> +        };
> +    };
> +...
