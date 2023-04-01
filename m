Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393066D32C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDARMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjDARMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:12:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9441B368
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 10:12:34 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id d3so2724097ybu.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680369154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzinr61gkqQVj/W+MLCrIR0rQPJjwHzlJ53pM+qR/qY=;
        b=lORR5ofSL12+q/pODIZT3BwNKacn94rAeUqwicvbwygYW8l978MxkMkhVxLV8AUKAg
         3DHr+TA7P2HkJcaMsnYZ2+DVqONc/8oy1ku1eAqI/sdSg85uzVWshGq5ufKqWIEs6J+t
         KMk1zwT8xWr5b01GFZ1GQK9UxHVoUo1X7rKUax1dFhU5FtqEwkcn68TF5Hwg6M3xM88/
         z3wmb7u+/kXQA45pmE3YkiiF/KaXESxkUM+WA8fIbMudKxHeF6++nD9FDlAe59nwub4C
         xyqjXUyRRftYR+uggQAUA94t6LC3StX6Lh5Kp3yKN2swMUvAHIJ15XwSnV/LNp/4jDS6
         AnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680369154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzinr61gkqQVj/W+MLCrIR0rQPJjwHzlJ53pM+qR/qY=;
        b=Qv3NW18jSuvwSBBhEMmKVMeztAZjDTDQlJpvC/oqhFi3Iq4ukMpcVDSXvSa39NIjFU
         m4t1Ou9Ycrl5bxAfwXTvHRBPuFDu4SDWzoTBmaRwjXj8pRK22IpQMAFZkZLJjI7en04b
         ISDmWrcW6mSAPJven2MpPkcSqkAPlx+Q3JmapHWdbf+yZXfbJe4e1Myo43h77F12c9vp
         Oi4+j80/d8xDCS+rIlWqIVSMtkU2qhnTZvORKIuIMxpy1xTJBYWtbFYsVdIOPB5mcMyk
         SESRw7sboGuFAKWrjkCsR/2cQx4unrw1TRPcUxWPmKWUEomhFQ309bT4RhmeAxEJ1+Sp
         YQWg==
X-Gm-Message-State: AAQBX9fak9SX7nPBP/BdE67EZqUs/0L/+iwPdt6dmIu40uqkvAoYP+8t
        4InEnSYVi8BTJK2DItYGrN4VkCu9VmNQoG8oR7ggzw==
X-Google-Smtp-Source: AKy350YNO55hg2vsUt75b//aUQl8nvOrOh018Eoad6owL/4yinM8uXHXCRbVtx2kwydoVn0s0PEwQYh0RcJqkUQnA/A=
X-Received: by 2002:a05:6902:102b:b0:b46:4a5e:3651 with SMTP id
 x11-20020a056902102b00b00b464a5e3651mr19946085ybt.9.1680369154022; Sat, 01
 Apr 2023 10:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230401154725.1059563-1-bhupesh.sharma@linaro.org> <20230401154725.1059563-2-bhupesh.sharma@linaro.org>
In-Reply-To: <20230401154725.1059563-2-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Apr 2023 20:12:23 +0300
Message-ID: <CAA8EJpruSDvsr7hsheeOHHF2EXshq8wM_HCiV8Cx3i5zVOweDQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: qcom,qmp-usb: Fix phy subnode
 for SM6115 & QCM2290 USB3 PHY
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 at 18:49, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> The USB3 SS (QMP) PHY found on Qualcomm SM6115 & QCM2290 SoCs is
> similar to sm8150 QMP PHY in the sense that the phy subnode supports

sm8150 has 5 QMP PHYs. Which one is mentioned here?

> 6 regs, namely TX lane 1, RX lane 1, PCS, TX lane 2, RX lane 2 and
> PCS_MISC.
>
> Update the dt-bindings document to reflect the same.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> index e81a38281f8c..1575dc70bcf2 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> @@ -276,7 +276,9 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcm2290-qmp-usb3-phy
>                - qcom,sdm845-qmp-usb3-phy
> +              - qcom,sm6115-qmp-usb3-phy
>                - qcom,sm8150-qmp-usb3-phy
>                - qcom,sm8350-qmp-usb3-phy
>                - qcom,sm8450-qmp-usb3-phy
> @@ -318,12 +320,10 @@ allOf:
>              enum:
>                - qcom,ipq6018-qmp-usb3-phy
>                - qcom,ipq8074-qmp-usb3-phy
> -              - qcom,qcm2290-qmp-usb3-phy
>                - qcom,sc7180-qmp-usb3-phy
>                - qcom,sc8180x-qmp-usb3-phy
>                - qcom,sdx55-qmp-usb3-uni-phy
>                - qcom,sdx65-qmp-usb3-uni-phy
> -              - qcom,sm6115-qmp-usb3-phy
>                - qcom,sm8150-qmp-usb3-uni-phy
>                - qcom,sm8250-qmp-usb3-phy
>      then:
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
