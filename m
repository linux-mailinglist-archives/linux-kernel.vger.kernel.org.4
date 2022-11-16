Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE662CEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiKPXjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiKPXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:39:07 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D5686B9;
        Wed, 16 Nov 2022 15:39:06 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id b124so136333oia.4;
        Wed, 16 Nov 2022 15:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6s4tcWtAUFsjBroYlDd5s5GJKQQ4LPC5QVVgj8A4GM=;
        b=61ocBYGJheDSkzwtDRw71g0Ogtkj8JijAeBhbIcHTJSx51iosnQVhlfdMwL2SAmtL6
         lH9cCH6SZ91jIhCa81YKxZzV90rBNaMx1oZJ8qsnhsC3ekOq3cMew3br/3qkQMTOiZuk
         whxQZ4miNrUZIBBt8GOI7GUzyH0alOoPEBoF9WAxuvSOeuoSEw9aqakZRl3YSxx09Bk6
         0gKgOz2OZdISae2//bjkMG5Xvv962qXTEqjTD7WDQGMU2dW8hqs9fq9WUNnMo/LC1pek
         mpeGovpycum/BfQhKAPkZ5l35wsQy0N6M/8mz+RICJnIFMhCNQ3JK66HKwa3j5y9JMQv
         ALZw==
X-Gm-Message-State: ANoB5pl/BDdBb9jxSaovSJHnVluJUb8VFqYsphXv7VHB4qai01lKhxXX
        aluPYXwmJiFBpgdyLCKTQw==
X-Google-Smtp-Source: AA0mqf43xzoJ1xe+xrzJTvE2+mSfCD0TR8MqUBpy7LYxQ5OW20eQB64dUgBVeHO3fzRjLq2NPU751g==
X-Received: by 2002:a05:6808:688:b0:35a:2de8:70b1 with SMTP id k8-20020a056808068800b0035a2de870b1mr41051oig.94.1668641945606;
        Wed, 16 Nov 2022 15:39:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a4aad41000000b004968311a31asm6616574oon.39.2022.11.16.15.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:39:04 -0800 (PST)
Received: (nullmailer pid 1231200 invoked by uid 1000);
        Wed, 16 Nov 2022 23:39:07 -0000
Date:   Wed, 16 Nov 2022 17:39:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: adsp: document sm8550
 adsp, cdsp & mpss compatible
Message-ID: <20221116233907.GA1227164-robh@kernel.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v1-0-104c34cb3b91@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v1-1-104c34cb3b91@linaro.org>
 <b6eac577-f3a7-d1a4-f492-74782c2e5ff1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6eac577-f3a7-d1a4-f492-74782c2e5ff1@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:28:11PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:20, Neil Armstrong wrote:
> > This documents the compatible for the component used to boot the
> > aDSP, cDSP and MPSS on the SM8550 SoC.
> > 
> > The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
> > firmware to be passed along the main Firmware, and the cDSP a new power
> > domain named "NSP".
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 60 +++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > index db9e0f0c2bea..678cb73f10de 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > @@ -55,6 +55,9 @@ properties:
> >        - qcom,sm8450-cdsp-pas
> >        - qcom,sm8450-mpss-pas
> >        - qcom,sm8450-slpi-pas
> > +      - qcom,sm8550-adsp-pas
> > +      - qcom,sm8550-cdsp-pas
> > +      - qcom,sm8550-mpss-pas
> >  
> >    reg:
> >      maxItems: 1
> > @@ -116,8 +119,13 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/string
> >      description: Firmware name for the Hexagon core
> >  
> > +  qcom,dtb-firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: Devicetree Firmware name for the Hexagon core
> 
> Not sure about this one.
> 
> Rob,
> Don't we want rather to have multiple items in firmware-name?

Yes, I think we already have that for some users. Should have been 
'firmware-names' I guess but I don't think it's worth dealing with 
another case of handling both (forever).

Rob
