Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ECE5F7344
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJGDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJGDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CF115C35;
        Thu,  6 Oct 2022 20:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB2DB821FE;
        Fri,  7 Oct 2022 03:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA012C433D6;
        Fri,  7 Oct 2022 03:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112678;
        bh=h1blTJr+JpQGieoE+GfzLHaegoCpTolhkU+YqBTdIxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMNd+ZdL2rZ/81SkDZRQKha2X+HA7DK3QvKi+We2FpJTqE2nLvjsAvT3J7+cLCUSI
         UM2ZxfmEHK+Ji3VGnGxg3BvOHfbQS4OPUvqqO/rCIeBR5d7oeDCuFKEKKbPe2gaQcd
         UtbrFm7rjE43ZMLXOph0/W3oE31ghiNEe5tRdRoItgbsEPvVYmCGwP+Njf6AHJdB35
         T+wrVhsjY9SiH16r4/CzFpKhAwvN6MjGgDk2+60WoeyKakl6mbNPXGk6/9aU1LU38R
         sxeI7G+QZd8iwWunVdHr0cncfryC+NTM69N3PkLb/kp1V3OCta7EDo+dE1bMKvkvnu
         0nEkwTpNhl1zw==
Date:   Thu, 6 Oct 2022 22:17:55 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 15/16] dt-bindings: pinctrl: qcom,sc7280: add
 bias-bus-hold and input-enable
Message-ID: <20221007031755.p6lng3ib27thz4ip@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-16-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:53PM +0200, Krzysztof Kozlowski wrote:
> The SC7280 pinctrl driver supports bias-bus-hold and input-enable, and
> DTS already use it (sc7280-idp).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> index 4606ca980dc4..1db05c43d58c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> @@ -117,13 +117,11 @@ $defs:
>            Selects the drive strength for the specified pins, in mA.
>  
>        bias-pull-down: true
> -
>        bias-pull-up: true
> -
> +      bias-bus-hold: true
>        bias-disable: true
> -
> +      input-enable: true
>        output-high: true
> -
>        output-low: true
>  
>      required:
> -- 
> 2.34.1
> 
