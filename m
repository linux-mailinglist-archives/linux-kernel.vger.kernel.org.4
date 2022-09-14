Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44F5B8A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiINOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiINOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BB1EAFC;
        Wed, 14 Sep 2022 07:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2352561D93;
        Wed, 14 Sep 2022 14:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6C8C433D7;
        Wed, 14 Sep 2022 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663164684;
        bh=0BQtMOqfuwcRhZDwaTLdlh2kfu34FusybTj1iXVbtPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoCSG/FDLWCQC2l1VzPLrzSfHSEc+Ip5g3jmUe8gTiCR4IAP8F0vkjwZklCCtm4YN
         nyxZbRxWZrRDVfQpjYnU+G9NkoFxMQkfP3wbwtNEzzVQvAql4hXOjjA2Kdu3ewgB9U
         uNoFbVvQ3wQx5VQGs2Wo0Ps0UOpLqoU64ob38oDFW3vQeTSZv8aMV2Fry4n4PXeP+G
         dhfdJooBWuOfz/n3+AoKEnuIWxBSdxhiJDl459+UDA7Mm+KR0mVcwKsf9jfuGqDz8u
         hfVCMfPL6/Y/6+G0vJvUYqhl13SC4R/2WHsBMKUGQ6ewMWCYsGHf3Luv8UZz2wBoNP
         KTsLqHxItJWJA==
Date:   Wed, 14 Sep 2022 09:11:22 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: spmi: Add qcom,bus-id
Message-ID: <20220914141122.td5y4dzp5ercuvpj@builder.lan>
References: <20220914112139.3680354-1-vkoul@kernel.org>
 <20220914112139.3680354-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914112139.3680354-2-vkoul@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:51:38PM +0530, Vinod Koul wrote:
> For PMIC arbiter version 7 and beyond we need to define if we are using
> primary or secondary bus, so add a new property of qcom,bus-id
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml  | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> index fee4f0eb4665..aa8e891b2bb4 100644
> --- a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> @@ -85,6 +85,14 @@ properties:
>      description: >
>        which of the PMIC Arb provided channels to use for accesses
>  
> +  qcom,bus-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 1
> +    description: >
> +      SPMI bus instance. only applicable to PMIC arbiter version 7 and beyond.
> +      Supported values, 0 = primary bus, 1 = secondary bus
> +
>  required:
>    - compatible
>    - reg-names
> @@ -113,5 +121,8 @@ examples:
>  
>          interrupt-controller;
>          #interrupt-cells = <4>;
> +
> +        qcom,bus-id = <0>;
> +

As you correct the author on patch 2/2, please drop this last empty
line.

Thanks,
Bjorn

>      };
>  
> -- 
> 2.37.3
> 
