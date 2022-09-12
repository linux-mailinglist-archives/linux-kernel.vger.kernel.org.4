Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9065B6190
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiILTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiILTUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:20:43 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4658940BF5;
        Mon, 12 Sep 2022 12:20:41 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so6538596oth.8;
        Mon, 12 Sep 2022 12:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3AP/8H6lNUJxt0e4xcmzSjTGN2LrpryaMTGu/8MaPTE=;
        b=ZbLO/SQ42CahYnGvYwX+wqjgPx9KsurMrUQEwF59S7pbdB8cgNOrAixKUGOkDV5sJ9
         v2xEr3seWQ3bOWhYieyVRX5hRUPM2tr/5EpVV30IruxQpnSx0aadCdSdjnX7XiWkgh4c
         AQe82Sn984j8+8UOv9JaxWp9UKHIizE5uUF1gGoVnKFgkMCgZoikWCw/sJN9sKEOROyO
         DchfAmZ/B4OigGww3ihcgJe0ncZ+ioqxRzdpgRdI/SbMyg0dM0lhoGBzppSvkybMMi0M
         T6gs+cN3wiftMBZrG6s1dMH1CPB5z7Dm3iZVAjMs9BwdJCBU+P0eDWIDcHEhRV9NAT1P
         Ozxg==
X-Gm-Message-State: ACgBeo2Dt1pAghHuoEKqPSzdHTufCsUtxHLiHN52O8Kb6ODje0AGeOwZ
        yOS1W7XPjuF96V5kKCZPbkl0rIZ1CQ==
X-Google-Smtp-Source: AA6agR7xawQGM5WeoMEXiFMiRQalX4BDsabwBsBRE57tKwigga13hjnnPHVUevtOi6lJDbcfUCqFBA==
X-Received: by 2002:a05:6830:1d89:b0:655:d851:365f with SMTP id y9-20020a0568301d8900b00655d851365fmr3412786oti.293.1663010440379;
        Mon, 12 Sep 2022 12:20:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s22-20020a4ac816000000b0044b47bb023fsm4449106ooq.37.2022.09.12.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:20:39 -0700 (PDT)
Received: (nullmailer pid 1680895 invoked by uid 1000);
        Mon, 12 Sep 2022 19:20:38 -0000
Date:   Mon, 12 Sep 2022 14:20:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the
 sl28 vpd layout
Message-ID: <20220912192038.GA1661550-robh@kernel.org>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-16-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221857.2600340-16-michael@walle.cc>
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

On Fri, Sep 02, 2022 at 12:18:52AM +0200, Michael Walle wrote:
> Add a schema for the NVMEM layout on Kontron's sl28 boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - add custom select
>  - add description
>  - add "additionalProperties: false", I wasn't sure if all the
>    subnodes needs it. I'd say yes, but the brcm,nvram binding
>    doesn't have them neither.
> 
>  .../nvmem/layouts/kontron,sl28-vpd.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> new file mode 100644
> index 000000000000..0c180f29e880
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
> @@ -0,0 +1,67 @@
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
> +# We need a select here so we don't match all nodes with 'user-otp'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: kontron,sl28-vpd
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: kontron,sl28-vpd
> +      - const: user-otp
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

You can't just add a new #.*-cells buried in a device binding. I'm fine 
with the concept though having more than 1 user would be nice.

Any case that doesn't match foos->#foo-cells or has a default # of 
cells if missing (as this does) has to be added to dtschema to decode it 
properly. It won't really matter until there's a user with 2 or more 
entries. I'm happy to do update the dtschema part, but I'd prefer to see 
the schema in dtschema rather than the kernel.

Rob
