Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9836386D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKYJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiKYJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:53:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96AD4386B;
        Fri, 25 Nov 2022 01:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD592B82A00;
        Fri, 25 Nov 2022 09:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E3EC433C1;
        Fri, 25 Nov 2022 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669369870;
        bh=EIs+1tSl2se+1S6jtiJO/zNYFoaJRPtl7dW2rnAh200=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ca2Sde3jfuFoOKzqrt0YRLMRyn1/QRJn9ASVpvW/Ldql5wYfi/HteTffTD79Xz5je
         A9sKYTMudYBZhT3nPS+3TRUrKOkpHWoUeUBmvqfJeA7T1+FWrcbChVi6qfHoecpXsc
         XtCmnlHmS3G4kqvZhKOQOyabasIQe4j9gzJqf4yqlsdz3alw1fna2qNV8MRvgDFKCi
         6j/g7vJtl5mzCsSN3pzOpivdhgVDfyKFgW32LuyH5BrCJgxL1Valo/vBxOHf96KPNw
         xwjUbSW0PgFGqujHJna+RFp4mftZcut9OGv7ZgFe9EqS+t49eRJkDJK9GyKgybcAQz
         5DpRcJsj/jpQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oyVM5-00027x-2U; Fri, 25 Nov 2022 10:50:45 +0100
Date:   Fri, 25 Nov 2022 10:50:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add
 sm6350 compatible
Message-ID: <Y4CP9fwhDXsLu57Q@hovoldconsulting.com>
References: <20221125092749.46073-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125092749.46073-1-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:27:47AM +0100, Luca Weiss wrote:
> Add the compatible describing the combo phy found on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> @Johan Hovold, I've sent this v2 as RFC because there are several things
> where I have questions on how it should be done.
> 
> In this patch, you can see there's cfg_ahb (&xo_board) and power-domains
> is not set. In msm-4.19 &gcc_usb30_prim_gdsc is only used in the
> ssusb@a600000 node, or should I also add it to qmpphy?

Yeah, you may need to add a platform specific section of the clocks,
which appear to be different, even if I'm not sure they are currently
described correctly (xo_board as cfg_ahb and "QLINK" as ref). How are
they named in the vendor's dts?

It should be OK to include the power-domain also for the PHY node.

>  .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 6f31693d9868..3e39e3e0504d 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -17,16 +17,18 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc8280xp-qmp-usb43dp-phy
> +      - qcom,sm6350-qmp-usb3-dp-phy
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 4
> +    maxItems: 5
>  
>    clock-names:
>      items:
>        - const: aux
> +      - const: cfg_ahb
>        - const: ref
>        - const: com_aux
>        - const: usb3_pipe

So this would need to be moved to an allOf: construct at the end with
one section each for sc8280xp and sm6350.

> @@ -61,7 +63,6 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - power-domains
>    - resets
>    - reset-names
>    - vdda-phy-supply

Johan
