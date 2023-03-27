Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFE6CADB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjC0Spt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC0Spn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41E3C13;
        Mon, 27 Mar 2023 11:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72FE261472;
        Mon, 27 Mar 2023 18:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA0C433D2;
        Mon, 27 Mar 2023 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679942740;
        bh=cPADjkmRo6v7PQmzp77eeshIMF05/BF4SyAuwPUuVEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j619G8NZJ0oX4nI/xT6v6vdbKwKT7JDOgw+dd+x9ra774uad3q9XX1AeUSY5Bl93B
         oCyAcvQPXL6yVaAV1QRG1Giy1vSa6zKUU+3cMz0Az7u841R696GhbcnciLswrIl9jT
         V9wz+BVmMqEjdLDb0lERcli3bVZHYMNonH/ytC+lTZV5LnfPi0bQY/Kkgv6bZRMYKI
         V8r3xZhsFP/aNrjePLTB3aXMjBWkyi8OQGqULCSVOmFvpM0AzHxl2veq0cmZB7/+/C
         t6AsnfO1cSQa0wYNKY3M3gU7dHm6Z0Iq3X8zYuW2eP1DqJKXneO63exKBjGrvek+IA
         8zS+M93AWzywQ==
Date:   Mon, 27 Mar 2023 11:45:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: ufs: qcom: Add reg-names property
 for ICE
Message-ID: <20230327184538.GB73752@sol.localdomain>
References: <20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com>
 <20221209-dt-binding-ufs-v3-2-499dff23a03c@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209-dt-binding-ufs-v3-2-499dff23a03c@fairphone.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:41:29AM +0100, Luca Weiss wrote:
> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
> in the bindings so the existing dts can validate successfully.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index 23447281deec..ebc8e1adbc6f 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -75,6 +75,10 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +
>    required-opps:
>      maxItems: 1
>  
> @@ -129,6 +133,8 @@ allOf:
>          reg:
>            minItems: 1
>            maxItems: 1
> +        reg-names:
> +          maxItems: 1
>  
>    - if:
>        properties:
> @@ -157,6 +163,12 @@ allOf:
>          reg:
>            minItems: 2
>            maxItems: 2
> +        reg-names:
> +          items:
> +            - const: std
> +            - const: ice
> +      required:
> +        - reg-names
>  
>    - if:
>        properties:
> @@ -185,6 +197,8 @@ allOf:
>          reg:
>            minItems: 1
>            maxItems: 1
> +        reg-names:
> +          maxItems: 1
>  
>    - if:
>        properties:
> @@ -210,6 +224,12 @@ allOf:
>          reg:
>            minItems: 2
>            maxItems: 2
> +        reg-names:
> +          items:
> +            - const: std
> +            - const: ice
> +      required:
> +        - reg-names
>  
>      # TODO: define clock bindings for qcom,msm8994-ufshc
>  

Looks good to me, though I'm not an expert in device tree bindings.  It's
unfortunate that whether ICE is present needs to be explicitly declared for each
SoC here (I would have expected that to only be done in the device tree files
themselves), and that the order of the regs and clocks is fixed (I would have
expected them to act as maps keyed by name).  But it seems that's the way it is.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
