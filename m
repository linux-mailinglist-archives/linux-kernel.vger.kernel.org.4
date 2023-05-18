Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E4707C57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjERIss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjERIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A3172D;
        Thu, 18 May 2023 01:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C7964D92;
        Thu, 18 May 2023 08:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073EFC4339C;
        Thu, 18 May 2023 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684399723;
        bh=SXA942ESpbNtA6sHwpw+PwUXgclY607/7gMLX0DUBVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6YyKW/bTXPrsy4U+SUU/Oynl+bctcUlKA25oY/rsAYmj0Jt1Kf54HG3C9qrHzgmv
         uy6/SuUef5qufMDF6zqsfILiQZ2QRh3V4b1MvtMuNyTpxLQ38QAqL+QoIU+h3CNZiS
         V4nV48kCqaap8tH2eMreu4sse4KjM3J1n8QU62Aha+10cJ+rzaAw7JM5OfFJ9wB/XO
         GsW0K4ampv3KfXff9NuX/4lJJ6gOBi6ektaHLEyelHW1pJhIvDhf04hWGOxmtBARUo
         HamRgnet8Agus/xuppnitZBrQnpv/yvGQ5SN+TyStxZPh7jZunvn08JiqmH41Jef75
         UkCMhRSxaGj9A==
Date:   Thu, 18 May 2023 09:48:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: leds: qcom,spmi-flash-led: add PM8550
Message-ID: <20230518084836.GA404509@google.com>
References: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
 <4c11be9a-796f-79f1-2828-d3367f978785@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c11be9a-796f-79f1-2828-d3367f978785@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023, Konrad Dybcio wrote:

> 
> 
> On 16.05.2023 17:02, Krzysztof Kozlowski wrote:
> > Document compatible for PM8550 Torch and Flash LED controller.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

This should be a Reviewed-by.

Other maintainers might get confused by this and apply the patch via
their own repositories which I'm assuming was not the intention.

> >  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> > index ffacf703d9f9..074ef7e63c49 100644
> > --- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> > +++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
> > @@ -26,6 +26,7 @@ properties:
> >            - qcom,pm8150c-flash-led
> >            - qcom,pm8150l-flash-led
> >            - qcom,pm8350c-flash-led
> > +          - qcom,pm8550-flash-led
> >        - const: qcom,spmi-flash-led
> >  
> >    reg:

-- 
Lee Jones [李琼斯]
