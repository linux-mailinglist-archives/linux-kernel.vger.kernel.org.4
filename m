Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18925705F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjEQFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326A12C;
        Tue, 16 May 2023 22:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6EA64210;
        Wed, 17 May 2023 05:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA49C433D2;
        Wed, 17 May 2023 05:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684302276;
        bh=y0d8c7JHw2wpy/qWzjtP6uVBTXCtCjSwgfLQ0ts2oxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+D1YgcWPSQdgt+/MbZxEAEKNX4M3rWfwmeRL5J/WkKppz1UjfcqImSad4JZVqbLo
         l4fizq6B08eU/nBQr1MSOqlICrM12tpPUSlhiTVKtvCwpRIkIbSTMWpLDISaDT5S5k
         3PtYAaD9ZY3Ry/EOre+sdoFrp0A0scK+ejvyB5bNQfcRRTCLPUvRyXlQRyYPs2s2+U
         8GJb8EEfT6Av11IV44By6GM7M1vLuyF2AA7wy90r9hgQT+YX8wHdL6SWZfNC4pZvlv
         uTEBowPbEadt+wIIuHWIraybEbUIi8qvZFULLSH78w51VC++q2tV1ByC9q30nlyQQz
         FeMuKZka1MavQ==
Date:   Wed, 17 May 2023 11:14:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cache: qcom,llcc: Fix SM8550 description
Message-ID: <20230517054428.GH4868@thinkpad>
References: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
 <20230517-topic-kailua-llcc-v1-1-d57bd860c43e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517-topic-kailua-llcc-v1-1-d57bd860c43e@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:18:49AM +0200, Konrad Dybcio wrote:
> SM8550 (LLCCv4.1) has 4 register regions, this was not described
> between its addition and the restructurization that happened in
> the commit referenced in the fixes tag.
> 
> Fix it.
> 
> Fixes: 43aa006e074c ("dt-bindings: arm: msm: Fix register regions used for LLCC banks")

I'm not sure if the Fixes tag should point to the patch adding SM8550 support or
the restructuring patch.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

But the change LGTM!

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> index d8b91944180a..44892aa589fd 100644
> --- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> +++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> @@ -129,6 +129,7 @@ allOf:
>                - qcom,sm8250-llcc
>                - qcom,sm8350-llcc
>                - qcom,sm8450-llcc
> +              - qcom,sm8550-llcc
>      then:
>        properties:
>          reg:
> 
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்
