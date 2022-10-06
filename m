Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC4D5F6B07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiJFPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJFPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:49:42 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CEBE30;
        Thu,  6 Oct 2022 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665071374;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=j7eZp38BjlfdBQLJ5AigHo4JPaCzVu//8rXSvPqwO+Q=;
    b=DufJXJo8+Fxml6ZIVTresxo4wvbz5GkuHUz19/pI3PuBzFHpccCnZ/y54ymtijn9dB
    J1Zir4ad/BnyeKwrswqBDo1l+tv98p/OxHWq34YZ91eqINGhiyqIzFPZ5cZsbaRPOoZ3
    BlQP1CPUqKJUvgQLmTMmSmu51l5InPhbEAjbig2hN13meAsmkzh1wAXmV9grNt+79k2n
    6l0ACOVOzLndxEmgGTMibVM1bRP4IDIEt791t14glyFswNBAIq3Wjj0Z4QQCPzywtrNh
    L1onGadREaCQq6MuI8zyOEmrL4m2g/NteKnVUDpNH8V9be58OTpSgJtzDOFgdtA7LjLf
    fD3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwvWmtQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 DYNA|AUTH)
    with ESMTPSA id 06b848y96FnXQ22
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Oct 2022 17:49:33 +0200 (CEST)
Date:   Thu, 6 Oct 2022 17:49:32 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM
 pinctrl schema warnings (5th set)
Message-ID: <Yz75DAmjI1GbwQpI@gerhold.net>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Oct 06, 2022 at 04:06:03PM +0200, Krzysztof Kozlowski wrote:
> [...]
> Krzysztof Kozlowski (34):
>   dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sc7280: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
>   dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common
>     TLMM
>   dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
>   dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
>   dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
>   dt-bindings: pinctrl: qcom,mdm9607: minor style cleanups
>   dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
>   dt-bindings: pinctrl: qcom,qcm2290: minor style cleanups
>   dt-bindings: pinctrl: qcom,sdx65: minor style cleanups
>   dt-bindings: pinctrl: qcom,sc8180x: minor style cleanups
>   dt-bindings: pinctrl: qcom,sc8280xp: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm6115: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm6125: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm6350: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm6375: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm8350: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm8450: minor style cleanups
>   dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
>   dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
>   dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
>   dt-bindings: pinctrl: qcom: adjust description
> 
>  .../pinctrl/qcom,ipq6018-pinctrl.yaml         |  5 +-
>  .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 16 ++---
>  .../pinctrl/qcom,msm8226-pinctrl.yaml         |  5 +-
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 11 ++-
>  .../pinctrl/qcom,msm8953-pinctrl.yaml         |  5 +-
>  .../pinctrl/qcom,qcm2290-pinctrl.yaml         | 10 ++-
>  .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 13 ++--
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 16 +----
>  .../pinctrl/qcom,sc8180x-pinctrl.yaml         | 27 +++----
>  .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 13 ++--
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 22 ++----
>  .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml  |  5 +-
>  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 10 ++-
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 53 +++-----------
>  .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml | 30 +++-----
>  .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml | 23 ++----
>  .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 23 ++----
>  .../qcom,sm8250-lpass-lpi-pinctrl.yaml        | 16 ++---
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 70 ++++++-------------
>  .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml | 23 ++----
>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 13 ++--
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 22 ++----

Just a random thought since you are already doing minor style cleanups
here: Some of these files are named incorrectly, e.g. qcom,sm8450-pinctrl.yaml
actually documents "qcom,sm8450-tlmm". I noticed this while adding
qcom,msm8909-tlmm but I have to admit that it did not bother me enough
to actually prepare a patch for this (and now it would just conflict
with all your patches). :)

No need to change anything here, just thought I'd mention it.

Thanks!
Stephan
