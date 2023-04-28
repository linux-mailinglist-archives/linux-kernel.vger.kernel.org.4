Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF16F14F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjD1KGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbjD1KGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432CD1735;
        Fri, 28 Apr 2023 03:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF8B261610;
        Fri, 28 Apr 2023 10:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD47C433EF;
        Fri, 28 Apr 2023 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682676399;
        bh=81OkaQlfi3CrgD0EqbtFoJUkJdZFa1rVghoCulNspY8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZximVBIuPdOi+pwiva8zkP48wBNEhFzkukIzxqilzyieetx0RRa9fwflJLXosbXdw
         DlZfWsL10oOzaGxnWfee8x40HA9Y9zz4vZT7+R8WgcGy4+DOVH6Iw/SSibm4hFURzP
         NAUDm0Wy+GBXPhxnVsGhRhsRftRKVyTQWbQZs950F6S50Astnfp3ENuVchmgx78F8p
         luk8Ti+6xo1xF6ilCNV/Uf9a1dVTo3QcB2V4thlQ328UfJaWxu7mMbQcLy104wXMNJ
         U5/9IzOIbRSGHmfPOkowr/kswengIZN7zgcrQzetjioPLIgb1zTSnG3pQKt/flvAbh
         QxQfRtNTgaHHQ==
Message-ID: <9eda664b-e2ce-1f95-a112-1a808c95e011@kernel.org>
Date:   Fri, 28 Apr 2023 12:06:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 15:26, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed several entries, including DT list, so this won't be tested.
I won't be doing full review, no point if patch is not tested.

> ---
>  .../bindings/firmware/arm,scmi.yaml           | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 2f7c51c75e85..41ba5b8d8151 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -212,6 +212,63 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@19:
> +    $ref: '#/$defs/protocol-node'
> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':
> +        const: 0
> +
> +    allOf:
> +      - $ref: "/schemas/pinctrl/pinctrl.yaml#"

Drop quotes.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties:
> +      anyOf:
> +        - type: object
> +          allOf:
> +            - $ref: /schemas/pinctrl/pincfg-node.yaml#
> +            - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +
> +          description:
> +            A pin multiplexing sub-node describe how to configure a
> +            set of pins is some desired function.
> +            A single sub-node may define several pin configurations.
> +            This sub-node is using default pinctrl bindings to configure
> +            pin multiplexing and using SCMI protocol to apply specified
> +            configuration using SCMI protocol.
> +
> +          properties:
> +            phandle: true

What's this?

> +            function: true
> +            groups: true
> +            pins: true
> +            bias-bus-hold: true
> +            bias-disable: true
> +            bias-high-impedance: true
> +            bias-pull-up: true
> +            bias-pull-default: true
> +            bias-pull-down: true
> +            drive-open-drain: true
> +            drive-open-source: true
> +            drive-push-pull: true
> +            drive-strength: true
> +            input-debounce: true
> +            input-value: true
> +            input-schmitt: true
> +            low-power-mode: true
> +            output-mode: true
> +            output-value: true
> +            power-source: true
> +            skew-rate: true
> +
> +          additionalProperties: true

This should be false... but if it is true, then listing all properties
does not make sense. And anyway usual way is to make it instead
unevaluatedProperties:false. I have troubles understanding your goal here.

Best regards,
Krzysztof

