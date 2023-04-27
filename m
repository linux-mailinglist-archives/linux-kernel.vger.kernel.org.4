Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117AF6F073A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244018AbjD0OXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244014AbjD0OWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:22:44 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA54C24;
        Thu, 27 Apr 2023 07:22:14 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-187af4a5453so3227351fac.1;
        Thu, 27 Apr 2023 07:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605326; x=1685197326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uNuPX9j/yoNVZcLdhFFButCZsuO2r4zsFdcSvMmbBk=;
        b=Qo3MLuGHQ3HQUaIgUY+e3UKif++mRPZJNT/2tt2GXs46GddO+TOBTKPQq8sI/08cXn
         do3N00/a9jt/ztMCyeauH1AGwXRF7OlftVB2mgcFDonCjfbLImMvVwNGkyhNQqbiNsK0
         ypsaVjcNZEI1E8qxaKYa5ccAGtjVKNsbJXa2qqMNTNx9ojKUfwtkq1GvmzDlgvrzdbCp
         Mp5nfQqf1OIUHcV5HcpPUEqz+S5xWIfxQhuDmRnG+IDoEVcoEFERVkDGqhvqLhSDMjnF
         P5BBpwrADKkc16t1cs9To86fUHU6rkRfcHonotts2/IgCr0ifghouFc4nN6jbNmdVbnd
         4MDA==
X-Gm-Message-State: AC+VfDxKoCvNnZReZivEat5LW+l+lx1PaTJg23CSUfPW68ZVVFR+W1hD
        Z5VIX5IcXFE7S/MWJJqxEw==
X-Google-Smtp-Source: ACHHUZ4CFW+3aUpv2Gg8lfnGV/FuJC7CWrOe8fE8e37VwwGCL5yIS19C5JgRYyZkhI4eSfurt5Zw7A==
X-Received: by 2002:a05:6870:42d4:b0:188:77b:7c59 with SMTP id z20-20020a05687042d400b00188077b7c59mr1091719oah.19.1682605326276;
        Thu, 27 Apr 2023 07:22:06 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m41-20020a4a952c000000b005251e3f92ecsm8440186ooi.47.2023.04.27.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:22:05 -0700 (PDT)
Received: (nullmailer pid 2989656 invoked by uid 1000);
        Thu, 27 Apr 2023 14:22:05 -0000
Date:   Thu, 27 Apr 2023 09:22:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 1/6] dt-bindings: usb: qcom,dwc3: Add bindings for
 SA8775P
Message-ID: <20230427142205.GA2979206-robh@kernel.org>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <20230421133922.8520-2-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421133922.8520-2-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:09:16PM +0530, Shazad Hussain wrote:
> Add the compatible string for SA8775P SoC from Qualcomm.
> 
> Set minItems to 3 for interrupts as usb2 i.e third usb port supports
> only high speed mode and does not require ss_phy_irq.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index d84281926f10..3ae02cffae49 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -23,6 +23,7 @@ properties:
>            - qcom,msm8998-dwc3
>            - qcom,qcm2290-dwc3
>            - qcom,qcs404-dwc3
> +          - qcom,sa8775p-dwc3
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
>            - qcom,sc8280xp-dwc3
> @@ -180,6 +181,7 @@ allOf:
>                - qcom,msm8953-dwc3
>                - qcom,msm8996-dwc3
>                - qcom,msm8998-dwc3
> +              - qcom,sa8775p-dwc3
>                - qcom,sc7180-dwc3
>                - qcom,sc7280-dwc3
>                - qcom,sdm670-dwc3
> @@ -443,12 +445,15 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sa8775p-dwc3
>                - qcom,sc8280xp-dwc3
>      then:
>        properties:
>          interrupts:
> +          minItems: 3

Now 3 interrupts is valid for qcom,sc8280xp-dwc3?

>            maxItems: 4
>          interrupt-names:
> +          minItems: 3
>            items:
>              - const: pwr_event
>              - const: dp_hs_phy_irq
> -- 
> 2.17.1
> 
