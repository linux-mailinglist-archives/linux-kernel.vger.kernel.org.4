Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1762BFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKPNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKPNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539F47321;
        Wed, 16 Nov 2022 05:47:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EBD4B81D8B;
        Wed, 16 Nov 2022 13:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB2DC433D6;
        Wed, 16 Nov 2022 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606443;
        bh=bavOCPpVZflXom3L9vcP5a3uEurFEDRZ8UR6FNwwCmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXif7wxmNT79tjEng+ImaLf/4H1bkm1YD8QpwPUPC6xO8b+K6NW4Os4jhX69CLVRP
         +I6//JUaDwv6BPzM/Y89q3BmzgkpVg332u/FxC1M7MvMnY2YT1h8uRQOtyo6ADJe/6
         lM7/WfhzIqEsDDfXSguCfEXlea5P47Z3mRnPkhhReByrI1IO09wmqqEbkIPZHp3fWi
         ye1mBzuZ8MGjw1moEImnyQkKbl7zuqNxP+QsPVOLl3cdW6g4crDBlKB1dYDvsfegE/
         ozPpeeQNe76B+lMXDdT8Ac4bQSWZZQD2r/bM8njLEZHe9udoxpuCRTWmD4gSsBOXRS
         uWM6CE4UXsxDw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovIkg-0002js-6x; Wed, 16 Nov 2022 14:46:54 +0100
Date:   Wed, 16 Nov 2022 14:46:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 04/10] dt-bindings: phy: qcom,qmp-usb: Document SM8550
 compatible
Message-ID: <Y3TpzgQ1JaFs5sNk@hovoldconsulting.com>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
 <20221116120157.2706810-5-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116120157.2706810-5-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:01:51PM +0200, Abel Vesa wrote:
> Add the SM8550 compatible to the list.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> index 0c6b3ba7346b..cba2a252baf8 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
> @@ -37,6 +37,7 @@ properties:
>        - qcom,sm8350-qmp-usb3-phy
>        - qcom,sm8350-qmp-usb3-uni-phy
>        - qcom,sm8450-qmp-usb3-phy
> +      - qcom,sm8550-qmp-usb3-phy

This one too should be based on sc8280xp rather than the legacy binding
scheme.

Johan
