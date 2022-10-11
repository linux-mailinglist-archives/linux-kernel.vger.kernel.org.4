Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFF5FBC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJKU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJKU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70297A765;
        Tue, 11 Oct 2022 13:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49302B8161C;
        Tue, 11 Oct 2022 20:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2D4C43470;
        Tue, 11 Oct 2022 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665520037;
        bh=q/KD5DS2KZABpOmhHRh64Qn23gHZS9wNG5vavr9JdEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UeQJWZRLZgEU4QpeFr8PTC2nWaFG6R+h552XQV9dzEcyqQXkof/8dtonlYizkA/b/
         hEgZMRYJ1bO5xjEt0V+TuR4dNN9bzvpSPB7+DkX2BqkJr3ZrVxh2XXcZkLsojVw35T
         2/BKBnarA/6tjEX9Rtjc/ADLymt3jp+krZJU2oFZ3T6ONXz6uSX0TJfoSlxRnx3h15
         Mbhq/pIQsh4gVYnNhDAwtE2MOTpT1LcQjDE0DaIIhHTpnFb/LC1rNK4J2t1wloqlNl
         DpqSgGm3wIetPVFJj1WoI0hfWRvRSoBTEjhAVcYr2JLqK17q1yVnqgvB6coBh3h6E4
         LzyVOWbvlf7TQ==
Received: by mail-vs1-f51.google.com with SMTP id h3so7699721vsa.4;
        Tue, 11 Oct 2022 13:27:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf1h42oPupUCHyFVyL7jG1HcVyLHALhz7W9Ag8N5Nn9ZeAEcqB8d
        qJrsV5CKB92h7aJEFLO6WHpUIzgaGIF/acgAGg==
X-Google-Smtp-Source: AMsMyM5y6Ov8cNy9hDEvP/9q2HKaDkW+19lvSfwhHT0x4VJJ5RGH3IgjLi5SnA8timHooXskXro3qlEUTv749b/71gw=
X-Received: by 2002:a67:c088:0:b0:39b:1bb3:bdd1 with SMTP id
 x8-20020a67c088000000b0039b1bb3bdd1mr11524081vsi.85.1665520035958; Tue, 11
 Oct 2022 13:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221011185525.94210-1-nick.hawkins@hpe.com> <20221011185525.94210-3-nick.hawkins@hpe.com>
In-Reply-To: <20221011185525.94210-3-nick.hawkins@hpe.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Oct 2022 15:27:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
Message-ID: <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 1:56 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The hpe,gxp-plreg binding provides access to the board i/o through the
> Programmable logic interface. The binding provides information to enable
> use of the same driver across the HPE portfolio.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/soc/hpe/hpe,gxp-plreg.yaml       | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
>
> diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
> new file mode 100644
> index 000000000000..cdc54e66d9a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-plreg.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/hpe/hpe,gxp-plreg.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: HPE GXP Programmable Logic Registers Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hpe,gxp-plreg
> +      - const: simple-mfd
> +      - const: syscon
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    cpld@1e789000 {
> +      compatible = "hpe,gxp-plreg", "simple-mfd", "syscon";
> +      reg = <0x1e789000 0x1000>;
> +      fan1 {
> +        bit = <0x01>;
> +        inst = <0x27>;
> +        id = <0x2B>;

These property names are way too generic for device specific
properties. There is zero description of what the h/w does and any of
these child nodes to give any advice on direction. However, a node per
register or register field is generally the wrong direction.

Rob
