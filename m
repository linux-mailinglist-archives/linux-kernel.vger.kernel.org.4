Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806D26EE794
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjDYShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjDYShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:37:42 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9B26A8;
        Tue, 25 Apr 2023 11:37:41 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6a5dd070aa1so2414047a34.3;
        Tue, 25 Apr 2023 11:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682447860; x=1685039860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRaUadFCSKE/QoppZMed0RxSBw/AjnCOvErTwInNFFk=;
        b=CJxqLtzYgWX7ha9EhX5hbkG5iwhRcymhYi/fuUarhw1nGEnSJE/u82sX1aNr/zUZ5l
         atRsiZyVrQJ1K4riSfRI4ybC1Kt3+BzFZoLSB4C3Zr1cOICn38EKESGhk1b1vEt7ePqG
         WrETsCvrQNo8QR2dIeEJYsWGFg7iWw3LQs37K2X3fCwqKo1Sx7bPSYq11eP9ptjZaP5S
         3whA4cWn3X8yR1GlEdgCBEy3oaI64Sc4FMxuEk8pmGqi3lfhZO2Upi8mn68SLoReDRFm
         fO14p1gVl43NDUPUc+rTjvtY9uwuP9++1hmvd3F0Pgok5Whl53+psdaBvU5QmWP7/+Xg
         mt9A==
X-Gm-Message-State: AAQBX9ehCpGbD0GntFk3lELlnp/kQKpvpn3bkTF1+yTn5HwWvCyjpFH7
        H+MiZSd5gVKmny4mS8Qa3w==
X-Google-Smtp-Source: AKy350Zkmeo+/KqUAL8RCuMQa36bWUyJkm9hsLv/I+bgaWDPIGEFpGOsdVC2hJi0uLO21uhFBLH8IQ==
X-Received: by 2002:a05:6830:3a93:b0:6a4:4286:e7da with SMTP id dj19-20020a0568303a9300b006a44286e7damr8808493otb.37.1682447860386;
        Tue, 25 Apr 2023 11:37:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d2-20020a0568301b6200b0069f0794861asm5964175ote.63.2023.04.25.11.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:37:40 -0700 (PDT)
Received: (nullmailer pid 2060265 invoked by uid 1000);
        Tue, 25 Apr 2023 18:37:39 -0000
Date:   Tue, 25 Apr 2023 13:37:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v9 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Message-ID: <20230425183739.GA2032053-robh@kernel.org>
References: <cover.1682092324.git.quic_varada@quicinc.com>
 <b00042df41420ac337703ca99ac7876c46552946.1682092324.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00042df41420ac337703ca99ac7876c46552946.1682092324.git.quic_varada@quicinc.com>
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

On Fri, Apr 21, 2023 at 09:24:44PM +0530, Varadarajan Narayanan wrote:
> * Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
> 
> * Making power-domains as optional since IPQ9574 doesn't have GDSCs
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> ---
>  Changes in v9:
> 	- Move 'allOf' to the correct position
> 
>  Changes in v8:
> 	- Update clock names for ipq9574
> 
>  Changes in v6:
> 	- Made power-domains optional
> 
> Note: In the earlier patch sets, had used the (legacy)
> specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
> to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> ---
>  .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index 16fce10..b9dcda2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,ipq9574-qmp-usb3-phy
>        - qcom,sc8280xp-qmp-usb3-uni-phy
>  
>    reg:
> @@ -25,11 +26,7 @@ properties:
>      maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: aux
> -      - const: ref
> -      - const: com_aux
> -      - const: pipe
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1
> @@ -60,7 +57,6 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - power-domains
>    - resets
>    - reset-names
>    - vdda-phy-supply
> @@ -69,6 +65,41 @@ required:
>    - clock-output-names
>    - "#phy-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4

Doesn't the top-level already say this?

> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: cfg_ahb
> +            - const: pipe
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-qmp-usb3-uni-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: ref
> +            - const: com_aux
> +            - const: pipe
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.7.4
> 
