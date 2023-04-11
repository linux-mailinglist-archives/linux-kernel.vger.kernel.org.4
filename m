Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD86DDBED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDKNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjDKNRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:17:44 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43740C5;
        Tue, 11 Apr 2023 06:17:43 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1845f865452so4452753fac.12;
        Tue, 11 Apr 2023 06:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219062; x=1683811062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMLSRWyO7youDUneN+C7njAPNFs3dU8flMJ2s0JdZA0=;
        b=DFYLCQ2dAwIP15nfgTkurS5lmSAJqs33lkONFJ8+VFpKc7BYwZk9w3qGbB1wiUPSxB
         AJj67DCr1ZN4h5G+Asthu+kY4ZKgLb20d6oDuwdkrhuKx7tZczW+qPuLiHZUveEOxNuu
         HxvhDFHgxuQ0J7qtbtrSzCouKumi4zqlM6SQkzuEPk+8GIqdR11PISOl/IngOuUg7sXg
         P9as961j06SzHyDKLtZgDV/nHB/j5g3jOFkX6tqu6JCH5WMG+ffIcFeXgJpR3hd9tPzQ
         CJCgHJHJKsiTfFE5PlQYrMZ1PE+y+T7f+MBqWrXEcoBReLowW20mB+rJibWzgOliigK0
         pTFA==
X-Gm-Message-State: AAQBX9ccDY4dzTSxm/baewm5brz+awsqtCFpCg2YLaSXLNPDrGd0CrF7
        V6eZ1EbFALTbJqjymc0oJg==
X-Google-Smtp-Source: AKy350YA//UYYJ8sXvuwCAQ8mbEa46N6fYC1rhOajj2sQmniVNMtERZmWIhA2Bf01C2K7AO7TFp7lQ==
X-Received: by 2002:a05:6870:8a1e:b0:17a:c83d:8f9d with SMTP id p30-20020a0568708a1e00b0017ac83d8f9dmr6442101oaq.19.1681219061723;
        Tue, 11 Apr 2023 06:17:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zp2-20020a0568718e0200b0017ae909afe8sm5024441oab.34.2023.04.11.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:17:41 -0700 (PDT)
Received: (nullmailer pid 2915066 invoked by uid 1000);
        Tue, 11 Apr 2023 13:17:40 -0000
Date:   Tue, 11 Apr 2023 08:17:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: qmp-ufs: describe the UFS PHY
 for sa8775p
Message-ID: <20230411131740.GA2913234-robh@kernel.org>
References: <20230406194703.495836-1-brgl@bgdev.pl>
 <20230406194703.495836-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406194703.495836-3-brgl@bgdev.pl>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:47:00PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new compatible for the QMP UFS PHY found on sa8775p platforms and
> update the clocks property to accommodate three clocks.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index cd0fbbd3593d..5bc93acccbad 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,sa8775p-qmp-ufs-phy
>        - qcom,sc8280xp-qmp-ufs-phy
>        - qcom,sm6125-qmp-ufs-phy
>        - qcom,sm7150-qmp-ufs-phy
> @@ -25,12 +26,15 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 3
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: ref
>        - const: ref_aux
> +      - const: qref
>  
>    power-domains:
>      maxItems: 1
> @@ -52,6 +56,26 @@ properties:
>    "#phy-cells":
>      const: 0
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-qmp-ufs-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          maxItems: 3

The max is already 3. Did you mean 'minItems: 3' or 2 or 3 clocks are 
valid?

> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          maxItems: 2
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.37.2
> 
