Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1C63FC4B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiLAXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:49:57 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB1C510C;
        Thu,  1 Dec 2022 15:49:56 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id h132so3772850oif.2;
        Thu, 01 Dec 2022 15:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+HjyG60puvlrURBNHopMfOrvdeMFci5vVt0oykR5tc=;
        b=qylbzBA5hVi82YVQPOffKXd01o8ogJRY7s3g8iFccBFObfaKQHA5/8ZM70hDV4AmrI
         COyqUWhz6pzprFxXzS9PAm+cqZWl7dJTRZPQiJmTpG5dK6WPP1VCldSF2eMjSh7X2T33
         u6HCxrv5CCq5EYgufBopozZb1PLPXBtZPPgUkKtVrAGoeB+AJntOjYcu/m2uUAPXXAzT
         f8MmT/dbgBSxGdn06sBJJlMnnpGOYsPiHPTS1gvQ46Kr8l5wlME9o9/5YgtVshEBHz51
         gK1P7m0ZiI/8+88j3cHn/sVuxa42CHixkbIO+Lcz8NUX70N2RDtpJLJVumIW+P3W3Dsz
         tjag==
X-Gm-Message-State: ANoB5pll6dJg84CGNeAVYrmjpgutJU7OwECoMRBx2k/wYm0SuU8jfdH/
        JW/xdZu1gSzg1WQzUpEoRQ==
X-Google-Smtp-Source: AA0mqf5bJr0Z/sHBoXak624BdBzYGGLAuHfYECUlI0mZIj1EYsWA3ZeDo7bemwuHtU+yAdY/jKae8A==
X-Received: by 2002:aca:44c4:0:b0:35a:6147:c6a5 with SMTP id r187-20020aca44c4000000b0035a6147c6a5mr24461259oia.149.1669938595865;
        Thu, 01 Dec 2022 15:49:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a544f8e000000b0035437f4deefsm2392807oiy.26.2022.12.01.15.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:49:55 -0800 (PST)
Received: (nullmailer pid 1708582 invoked by uid 1000);
        Thu, 01 Dec 2022 23:49:54 -0000
Date:   Thu, 1 Dec 2022 17:49:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, andy.shevchenko@gmail.com,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI
 controller
Message-ID: <20221201234954.GA1704219-robh@kernel.org>
References: <20221130150857.67113-1-tmaimon77@gmail.com>
 <20221130150857.67113-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130150857.67113-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:08:56PM +0200, Tomer Maimon wrote:
> Add binding for Nuvoton NPCM SDHCI controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> new file mode 100644
> index 000000000000..38409272807a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/npcm,sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NPCM SDHCI Controller
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-sdhci
> +      - nuvoton,npcm845-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^sdhci@[0-9a-f]+$":
> +    type: object

sdhci is a child node of the nuvoton,npcm750-sdhci node?

> +    $ref: mmc-controller.yaml

I think you want:

allOf:
  - $ref: mmc-controller.yaml#

And then you will have some errors in the example to fix.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sdhci0: sdhci@f0840000 {

Drop unused labels.

Node name should be 'mmc'

> +      compatible = "nuvoton,npcm750-sdhci";

Indent by 4 spaces.

> +      reg = <0xf0840000 0x200>;
> +      interrupts = <0 27 4>;
> +      clocks = <&clk 4>;
> +    };
> -- 
> 2.33.0
> 
> 
