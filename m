Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE269F785
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBVPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBVPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:16:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50582360B8;
        Wed, 22 Feb 2023 07:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1E2FB815B4;
        Wed, 22 Feb 2023 15:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3DAC433EF;
        Wed, 22 Feb 2023 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078974;
        bh=wUslbHkWZIpoEVNM5LtQHHbJ94IyutGQuJabE24DqWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAT8rKh33CtVSEYanh8svT89vw8xxLp9ZiBkoGZrikdmQLTe1jJy9FibMbJZ/8dj5
         J6iZWIDep2t0g79YX2tw+/gt6pZUCsaFwu811Tcjx+06elEPRcCX0eB3BTYAH0413V
         s/EBlcteHGkrOw/znNzb7Ssv0/JauJsEsfeYscm3NrXOawlIPB70mlqDdpCKLB5axt
         E1WlAvsj/fM2HmAGcaY6XFvHAh57MdHOGgDuXHgG01IYWpYZ39nq+c2QYmHKJAzwEn
         B0q5fbmUJOyuaj9ZqvH4XHF1FfRphGRMaGC+7Qc4m6Ee0hnFKGVwVRtIkeykeDcR9l
         6zT9tkRgBV4PA==
Date:   Wed, 22 Feb 2023 15:16:08 +0000
From:   Lee Jones <lee@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern
 property for phy
Message-ID: <Y/YxuM67on1X9NUA@google.com>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
 <20230208190200.2966723-3-abel.vesa@linaro.org>
 <Y+uqcb+CZUy/8GYh@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+uqcb+CZUy/8GYh@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023, Vinod Koul wrote:

> On 08-02-23, 21:01, Abel Vesa wrote:
> > The phy pattern property will be used for providing eUSB2 repeater
> > functionality. This will be modelled as a Qualcomm PHY driver.
> 
> Lee,
> 
> Can I get your ack and merge this thru phy tree

Acked-by: Lee Jones <lee@kernel.org>

> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > The v4 is here:
> > https://lore.kernel.org/all/20230207135551.1418637-3-abel.vesa@linaro.org/
> > 
> > Changes since v4:
> >  * none
> > 
> > Changes since v3:
> >  * made this the second patch rather than the first in the series
> > 
> >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > index adf88245c409..1e6fadec1301 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > @@ -135,6 +135,10 @@ patternProperties:
> >      type: object
> >      $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
> >  
> > +  "phy@[0-9a-f]+$":
> > +    type: object
> > +    $ref: /schemas/phy/qcom,snps-eusb2-repeater.yaml#
> > +
> >    "pon@[0-9a-f]+$":
> >      type: object
> >      $ref: /schemas/power/reset/qcom,pon.yaml#
> > -- 
> > 2.34.1
> 
> -- 
> ~Vinod

-- 
Lee Jones [李琼斯]
