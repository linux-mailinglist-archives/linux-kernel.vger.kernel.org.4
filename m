Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC15F7331
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGDRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJGDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:17:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D6C513A;
        Thu,  6 Oct 2022 20:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EFD7B821FE;
        Fri,  7 Oct 2022 03:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1C6C433D6;
        Fri,  7 Oct 2022 03:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112654;
        bh=yJn3965pphyURtiQeShKNWUDw4sZ2SzH+L8WiApurxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y27TUp0PFp3+7mo2yiZMVKDGD2inz/vEPDEkMp+0a/Ynn/OAc4N9rpk7DXrX2Y+vu
         TNQ8qGuvqdmGs1Nsd4D3eyz3VP+5rBevMbAfbjVYSAHF6R880R4E0VBxWNcmcrxq0E
         61lDgvDufOcsWw6ICOj0AzFdVaa1GjZf+lLm36k/zp6SKnLnay/9iMHRW4gx1XGlSU
         Nfl7owjniobMasH/FWyS1iH1XUrWoC5vG4zwYqfpcZiZEBamGQFl8KGYSv4vSBPcc3
         GVRakKiSEKJ4LZNDd54h1gvNYmR2lcqMHkbP6/7IiCZMNDp8OArRW8zCqdL6pggQv4
         r6b519G664NvQ==
Date:   Thu, 6 Oct 2022 22:17:31 -0500
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
Subject: Re: [PATCH v2 14/16] dt-bindings: pinctrl: qcom,sm8250: add
 input-enable
Message-ID: <20221007031731.2okgwtr67jghzzfh@builder.lan>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
 <20220930192954.242546-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930192954.242546-15-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:29:52PM +0200, Krzysztof Kozlowski wrote:
> The SM8250 pinctrl driver supports input-enable and DTS already use it
> (sm8250-sony-xperia-edo-pdx203).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> index 131eb8c981f8..fb753fd8bbee 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> @@ -119,6 +119,7 @@ $defs:
>        bias-pull-down: true
>        bias-pull-up: true
>        bias-disable: true
> +      input-enable: true
>        output-high: true
>        output-low: true
>  
> -- 
> 2.34.1
> 
