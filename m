Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EA6CB9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC1IoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjC1IoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DF46B7;
        Tue, 28 Mar 2023 01:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A31B4615E8;
        Tue, 28 Mar 2023 08:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C9DC433EF;
        Tue, 28 Mar 2023 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679993039;
        bh=AlNQBO+6ZRz6UYSPWubZy6WiSLJFBORuZaf7fG3oWe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0qS0MrS+ITx2XHH32iBaoDei8A9+eMFKPZGdqi0fFCCJuOWLrSZZ0IK6rRJjDQR/
         orqheWjd7YS2iqyK8C0JQzVUluWjsMSYh1KizoVRd2SgQxsHOH8jXd7SiFbFlUYGik
         nLYEyUBtWuym9jtT7aH2X7wJVqomFKnYV72ZHTw41MggksME9N9Yx+dGHCMqPFIW83
         wQ+FwP/1oM/wPSIxpnOeyPu4O+YqKqB3yCN1YMv4Q228/RB7zz0fKwC1fjGPVVh8D5
         0EFob/EBKGbGevR6RJ2vddXeKV0Cpq9ewMztOFE2WEychAwppVTgo5ZHQbQBxrddF6
         sFzQt9g92KPlg==
Date:   Tue, 28 Mar 2023 14:13:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Message-ID: <ZCKoysdcEZ2arUUS@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-5-vkoul@kernel.org>
 <76b5c861-708f-c2ff-4eb8-9a868237b333@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b5c861-708f-c2ff-4eb8-9a868237b333@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-03-23, 09:55, Krzysztof Kozlowski wrote:
> On 25/03/2023 13:24, Vinod Koul wrote:
> > Document the USB dwc3 controller for SC8180x SoC
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > index 4875c5b7d5b5..54e24c3abd29 100644
> > --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > @@ -24,6 +24,7 @@ properties:
> >            - qcom,qcs404-dwc3
> >            - qcom,sc7180-dwc3
> >            - qcom,sc7280-dwc3
> > +          - qcom,sc8180x-dwc3
> >            - qcom,sc8280xp-dwc3
> >            - qcom,sdm660-dwc3
> >            - qcom,sdm670-dwc3
> > @@ -324,6 +325,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,sc8180x-dwc3
> >                - qcom,sm8350-dwc3
> 
> You need to update/add also block for interrupts.

Thanks for spotting that, updated now

-- 
~Vinod
