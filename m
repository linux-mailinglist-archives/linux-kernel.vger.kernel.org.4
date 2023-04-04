Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5406D6D35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjDDTcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjDDTcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA6F2111;
        Tue,  4 Apr 2023 12:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AAA63405;
        Tue,  4 Apr 2023 19:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF072C433EF;
        Tue,  4 Apr 2023 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680636759;
        bh=LFfoWA2YzEbR4+/VlIXveggoWRzbSy4IHBA/bJtEvF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAPJRfmwpFK6q/ahMzFfl+eDQKnzlut4U0+b2sbFnlO9Fj9GeCCbLehQoYnMTPibV
         5JApelUYvhCSQZYOqB6vwV8d7DreI2mDH1W1/4TtKxZrBic5Y5AxeztHRHPdq/pJbb
         KuucJQUFLuGbqCqKEkj3ypQ8bHDm64xBDEvlqYschwzxNjuw63Bx27IlbSvCXPtBdV
         qTapQClE363T4gewywieMzoykbSwYItyGcbWi/oUFlmDyWYwYNDAhtveHPBsUbeq/8
         LbU3WBUVfdwM2XV3Ggpi+WJ6QmNbochhuD+pT2gVTbdQXT2A9rzOzBicuGjTPbBx1t
         qUOzI++N0DVzQ==
Date:   Tue, 4 Apr 2023 12:35:33 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Resolve MSM8998 support
Message-ID: <20230404193533.5dnjjr4ilhhqd4t5@ripper>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
 <20230304-topic-ddr_bwmon-v3-1-77a050c2fbda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304-topic-ddr_bwmon-v3-1-77a050c2fbda@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 03:11:19PM +0100, Konrad Dybcio wrote:
> BWMONv4 has two sets of registers: one for handling the monitor itself
> and one called "global" which hosts some sort of a headswitch and an
> interrupt control register. We did not handle that one before, as on
> SoCs starting with SDM845 they have been merged into a single contiguous
> range.
> 
> To make the qcom,msm8998-bwmon less confusing and in preparation for
> actual MSM8998 support, describe the global register space and introduce
> new "qcom,sdm845-cpu-bwmon" compatible while keeping the
> "qcom,sdm845-bwmon" as a fallback for SoCs with this merged register space
> scheme.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Georgi, can you please pick this patch through your tree?

Regards,
Bjorn

> ---
>  .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 41 ++++++++++++++++++----
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 12a0d3ecbabb..5d17bdcfdf70 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -22,14 +22,14 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - const: qcom,msm8998-bwmon       # BWMON v4
>        - items:
>            - enum:
>                - qcom,sc7280-cpu-bwmon
>                - qcom,sc8280xp-cpu-bwmon
> -              - qcom,sdm845-bwmon
> +              - qcom,sdm845-cpu-bwmon
>                - qcom,sm8550-cpu-bwmon
> -          - const: qcom,msm8998-bwmon
> -      - const: qcom,msm8998-bwmon       # BWMON v4
> +          - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
>        - items:
>            - enum:
>                - qcom,sc8280xp-llcc-bwmon
> @@ -49,9 +49,13 @@ properties:
>      type: object
>  
>    reg:
> -    # BWMON v4 (currently described) and BWMON v5 use one register address
> -    # space.  BWMON v2 uses two register spaces - not yet described.
> -    maxItems: 1
> +    # BWMON v5 uses one register address space, v1-v4 use one or two.
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
>  
>  required:
>    - compatible
> @@ -63,13 +67,36 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,msm8998-bwmon
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: monitor
> +            - const: global
> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          maxItems: 1
> +
>  examples:
>    - |
>      #include <dt-bindings/interconnect/qcom,sdm845.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>      pmu@1436400 {
> -        compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
> +        compatible = "qcom,sdm845-cpu-bwmon", "qcom,sdm845-bwmon";
>          reg = <0x01436400 0x600>;
>          interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>          interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
> 
> -- 
> 2.39.2
> 
