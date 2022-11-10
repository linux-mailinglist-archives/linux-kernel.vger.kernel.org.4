Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6C624398
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKJNt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKJNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:49:19 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E91F2E1;
        Thu, 10 Nov 2022 05:49:18 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13c569e5ff5so2191426fac.6;
        Thu, 10 Nov 2022 05:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNqJFWW1l/RwQMBOBINJbE+k5PGilLqiAp/MdKz97eQ=;
        b=Elq/D3qJeO5eMpd+0X88AnoPzYiPXvDObGBGLYorYd0n4FgoqzElx71js0raC+9IAA
         Y5kL5grFiNe5DxAEFf2Dwhib8IXqTMsE5hdbAkl3YvTJcAM3vHC47ZurapKdYXV1n9YJ
         ybrHBIFLAKD7KkJebH4/7D028Ed5/Lc8kF1McvDHliDzlmYG73vEDDiBnh3tYWaAGRPA
         XELuQJUgvIjEht0E5wPZvr2073k1LtwZJVwxKnkRHmv1bLqvfhjOlWDyiAtpmufwKzMe
         QOpen+WuGwnjXTp/dBMFbOGtQ6+QwfG9lpLyaac38HCsq5QaO4T1mkeaP1LrtYTAs4qo
         MIHQ==
X-Gm-Message-State: ACrzQf2Diou/Wh8M+eysCnJ2itrSFe6qMOpLVYcrKVD2WsvEMfBWlsco
        XgXQ9csBJFMtHauljwP9aQ==
X-Google-Smtp-Source: AMsMyM5uF7ern7BL/3lKtN7O7XEt5ACzXfcdLIxfjhpgOjP+LI8pn3YJSIWJ48iw4kzzXWrQMBh+3Q==
X-Received: by 2002:a05:6870:3488:b0:12c:19b0:f4bc with SMTP id n8-20020a056870348800b0012c19b0f4bcmr46679794oah.238.1668088157470;
        Thu, 10 Nov 2022 05:49:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x51-20020a9d37b6000000b00666a5b5d20fsm6348482otb.32.2022.11.10.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:49:16 -0800 (PST)
Received: (nullmailer pid 220983 invoked by uid 1000);
        Thu, 10 Nov 2022 13:49:18 -0000
Date:   Thu, 10 Nov 2022 07:49:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: nvmem: add YAML schema for the sl28
 vpd layout
Message-ID: <20221110134918.GB3436769-robh@kernel.org>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
 <20221104163833.1289857-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104163833.1289857-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 05:38:31PM +0100, Miquel Raynal wrote:
> From: Michael Walle <michael@walle.cc>
> 
> Add a schema for the NVMEM layout on Kontron's sl28 boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 60 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  3 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> new file mode 100644
> index 000000000000..44088c8b4153
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/kontron,sl28-vpd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM layout of the Kontron SMARC-sAL28 vital product data
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description:
> +  The vital product data (VPD) of the sl28 boards contains a serial
> +  number and a base MAC address. The actual MAC addresses for the
> +  on-board ethernet devices are derived from this base MAC address by
> +  adding an offset.
> +
> +properties:
> +  compatible:
> +    const: kontron,sl28-vpd
> +
> +  serial-number:
> +    type: object
> +    description: The board's serial number
> +
> +  base-mac-address:
> +    type: object
> +    description:
> +      Base MAC address for all on-module network interfaces. The first
> +      argument of the phandle will be treated as an offset.
> +
> +    properties:
> +      "#nvmem-cell-cells":
> +        const: 1
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      otp-1 {
> +          compatible = "user-otp";
> +
> +          nvmem-layout {
> +              compatible = "kontron,sl28-vpd";
> +
> +              serial_number: serial-number {
> +              };
> +
> +              base_mac_address: base-mac-address {
> +                  #nvmem-cell-cells = <1>;
> +              };
> +          };
> +      };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index ecc7c37cbc1f..f64ea2fa362d 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -17,6 +17,9 @@ description: |
>    define and might require dynamic reading of the NVMEM device in order to
>    perform their parsing. The nvmem-layout container is here to describe these.
>  
> +oneOf:
> +  - $ref: kontron,sl28-vpd.yaml

This is the other way around from how we normally structure things. 
Normally, the specific schema would reference the common/base schema. 
This works, though you will be applying the schema twice. Once here and 
then by matching on compatible string. Not a big deal as that happens 
fairly often, but a 'select: false' in kontron,sl28-vpd.yaml would 
prevent that. This way does more to enforce the overall structure of 
nodes.

The one downside I see with it this way is nvmem-layout can't ever have 
common properties defined without listing them in each layout schema.

In the end, I'm okay with either way.

Rob
