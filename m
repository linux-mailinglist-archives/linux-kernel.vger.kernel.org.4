Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150686C0F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjCTKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjCTKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095D136F4;
        Mon, 20 Mar 2023 03:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B85361381;
        Mon, 20 Mar 2023 10:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31B4C433D2;
        Mon, 20 Mar 2023 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679308850;
        bh=hty8Tn856K11peonll6sLiSPE/aLUDCSZBHJjJne0I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh0mE/7bVwTvAyMRpw46lgJJKcsdizYzTkzRiF/Ysn/mhUCYpnDq0aC2j0WCU8qGp
         9Fx8O+LoZi+CfE251z63yPk8id55+Uiz3iQGjEuX4VIiprO0wUZj+9VaGG/lckflNZ
         iUBNeB/HI0mD3tfBh78YpwOThNkOwDS3vrLDLmBUWBuKikIgfRx/eHI3QOikt1fTgX
         xtcmSuWsaUnFQBg4aL4WgHDbzdoQIXCDAAb6yvtCEg32A9hoTeSHkcEBa1PnSr+W38
         65LlikG1Pb7L27xq9h2GqxwnkyDnMFxul8vHRpxKfCKo1JFsPIou6s20drI53iDfM7
         kFON59CUA2Jxw==
Date:   Mon, 20 Mar 2023 16:10:42 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 fix SDX55 'if' match
Message-ID: <20230320104042.GF4564@thinkpad>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314080917.68246-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:09:06AM +0100, Krzysztof Kozlowski wrote:
> The qcom,sdx55-apcs-gcc is followed by another compatible (syscon), thus
> the 'if' clause must match by contains.
> 
> Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 2992227631c4..4d2f408a5efb 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -91,8 +91,9 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          enum:
> -            - qcom,sdx55-apcs-gcc
> +          contains:
> +            enum:
> +              - qcom,sdx55-apcs-gcc
>      then:
>        properties:
>          clocks:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
