Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CED62DE23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbiKQObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiKQObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:31:45 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3012A940;
        Thu, 17 Nov 2022 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668695315;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=w+x7AFEzmypSUrxRznSvHQYfvNLPiaPgfXtyx9kN1pU=;
    b=PYJUaDwP87PMnWIGgwgw5R/VaqBgRy36dmcnCdw2JvS4aBZH1GLNaTqcxvGMmLNcsB
    9ksQ/6/abEF0hw81PfNyS09MZoFBlqR/+8hsOu+HITd+WKsJfpvrEoAUT737whQuklWM
    L9ZAVUplngu1wSR1i6Mtkb+Cv1IDdu0OES8YAkUIdl6Ck8THcOMxXd1CrSfDBzI70t8n
    jle4Gp9u6xIRe3r2hFsFyNlWxSeqxoWSRJJ2y0ZP5ZQ2GSOd28TnuaJAq7QGgglnmWD2
    a75lfd8gdbpwoVmT4U548/znRAhldSkY/ABLo4nDMdU1nGHKeVBOh39pNDxbQWPr+tlJ
    ssTA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWyvDI"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.1 DYNA|AUTH)
    with ESMTPSA id Yce349yAHESZKMF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 17 Nov 2022 15:28:35 +0100 (CET)
Date:   Thu, 17 Nov 2022 15:28:29 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: simplify if:then:
 clauses
Message-ID: <Y3ZFDRI6ypg18S27@gerhold.net>
References: <20221117130254.378109-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117130254.378109-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:02:54PM +0100, Krzysztof Kozlowski wrote:
> Most of the device-specific compatibles have generic fallbacks like
> qcom,tsens-v1 or qcom,tsens-v2.  The if:then: block mentions these
> fallbacks, so drop redundant entries for specific compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml  | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index f0bd4b979e28..c9949713f714 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -118,12 +118,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,ipq8064-tsens
> -              - qcom,mdm9607-tsens
> -              - qcom,msm8916-tsens
>                - qcom,msm8960-tsens
> -              - qcom,msm8974-tsens
> -              - qcom,msm8976-tsens
> -              - qcom,qcs404-tsens
>                - qcom,tsens-v0_1
>                - qcom,tsens-v1
>      then:

FWIW: I submitted the same patch for this part a couple of months ago,
it was never applied for some reason:
https://lore.kernel.org/linux-arm-msm/20220627131415.2868938-2-stephan.gerhold@kernkonzept.com/

> @@ -140,17 +135,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,msm8953-tsens
> -              - qcom,msm8996-tsens
> -              - qcom,msm8998-tsens
> -              - qcom,sc7180-tsens
> -              - qcom,sc7280-tsens
> -              - qcom,sc8180x-tsens
> -              - qcom,sdm630-tsens
> -              - qcom,sdm845-tsens
> -              - qcom,sm8150-tsens
> -              - qcom,sm8250-tsens
> -              - qcom,sm8350-tsens
>                - qcom,tsens-v2
>      then:
>        properties:
> 

This part was not present back then though. Looks like this was
introduced recently in "dt-bindings: thermal: tsens: Add ipq8074
compatible".

I don't mind if you take this patch instead of mine. Feel free to add my

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks,
Stephan
