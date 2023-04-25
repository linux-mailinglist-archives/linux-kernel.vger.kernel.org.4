Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE96EE7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjDYS6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjDYS6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:58:51 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69916F3D;
        Tue, 25 Apr 2023 11:58:38 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-187b70ab997so32816765fac.0;
        Tue, 25 Apr 2023 11:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449118; x=1685041118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCPUjU42PRIffLcz9TbBJOAbKvwZwWa3dQczE6gwtwg=;
        b=eJdqcNUp33TIJmAvNSods4wLBgPZBN7e/mJPOEMnT4ao8fyQcSvcU5LXUAOLh7/1Rr
         GvwD1Y0l/GyNt5MNInNeCaHOw58gI0oQcwMDk05rLBhehZiqhLG8R5kFWJLO/cZrFwb3
         MW1Av+GynVfOcxomXow5LTeyral1S9/DJxBNXTtzyclvflVKCVUVBwuclWHEsZjQ9ktX
         ZFS7GHwriCxMEHiosT4xcFDdhcWCmtPtHSjWS/zOECNtk5E+VgqHGwVRuRcq7Dv8grqf
         yQSSi9LklGfLaRTfo8Se04Qpl6ypouaFApcG4zoyqjlp4H/lodvg0ByRQGFmSxJi2gG4
         rCXw==
X-Gm-Message-State: AAQBX9cEFX/La0ITbadoTM8e3fnaq4TAbqWJ+FMtKJ1T0VC4oxyOCgp1
        V9ORljWMbsXdItevTkCv1YpujKiWnw==
X-Google-Smtp-Source: AKy350bVDkDMdeLblHdVNzD9BQfck4ZUsL4yNpzgQj1n/n4pupILFLzx+5zjoco+7TdvhHSqedp9LA==
X-Received: by 2002:a05:6870:e416:b0:187:fc1c:c1a9 with SMTP id n22-20020a056870e41600b00187fc1cc1a9mr9584459oag.6.1682449117979;
        Tue, 25 Apr 2023 11:58:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a056870864400b0018e996a507esm2629684oal.31.2023.04.25.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:58:37 -0700 (PDT)
Received: (nullmailer pid 2083974 invoked by uid 1000);
        Tue, 25 Apr 2023 18:58:36 -0000
Date:   Tue, 25 Apr 2023 13:58:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 ports and orientation-switch
Message-ID: <20230425185836.GA2081377-robh@kernel.org>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-2-quic_bjorande@quicinc.com>
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

On Mon, Apr 24, 2023 at 08:40:04PM -0700, Bjorn Andersson wrote:
> The QMP combo phy can be connected to a TCPM, a USB controller and a
> DisplayPort controller for handling USB Type-C orientation switching
> and propagating HPD signals.
> 
> Extend the binding to allow these connections to be described.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 3cd5fc3e8fab..c037ac90ce7f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -60,6 +60,26 @@ properties:
>      description:
>        See include/dt-bindings/dt-bindings/phy/phy-qcom-qmp.h
>  
> +  orientation-switch:
> +    description:
> +      Flag the PHY as possible handler of USB Type-C orientation switching
> +    type: boolean
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output endpoint of the PHY
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base

'port-base' means you have extra properties to add. Where are they? It 
also needs 'unevaluatedProperties: false'.

> +        description: Incoming endpoint from the USB controller
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Incoming endpoint from the DisplayPort controller
> +
>  required:
>    - compatible
>    - reg
> @@ -98,6 +118,37 @@ examples:
>        vdda-phy-supply = <&vreg_l9d>;
>        vdda-pll-supply = <&vreg_l4d>;
>  
> +      orientation-switch;
> +
>        #clock-cells = <1>;
>        #phy-cells = <1>;
> +
> +      ports {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          port@0 {
> +              reg = <0>;
> +
> +              endpoint {
> +                  remote-endpoint = <&typec_connector_ss>;
> +              };
> +          };
> +
> +          port@1 {
> +              reg = <1>;
> +
> +              endpoint {
> +                  remote-endpoint = <&dwc3_ss_out>;
> +              };
> +          };
> +
> +          port@2 {
> +              reg = <2>;
> +
> +              endpoint {
> +                  remote-endpoint = <&mdss_dp_out>;
> +              };
> +          };
> +      };
>      };
> -- 
> 2.39.2
> 
