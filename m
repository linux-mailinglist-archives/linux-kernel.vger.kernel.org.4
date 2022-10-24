Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7820F60BBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiJXVR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJXVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9FF17F998;
        Mon, 24 Oct 2022 12:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDDA0B819A6;
        Mon, 24 Oct 2022 12:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6164C433D7;
        Mon, 24 Oct 2022 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666616004;
        bh=BuDzI/RcBVB6ggLiJtNs6vgK6SYiYVAFxoGoEpVsspY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTjbYGIq9l0+ld78/G0/9LiP1+VNLS5Cw8kV4zplkgQM1ecF3JM1TXguXbJhLmxz2
         Bma/BmmTj2gxmAg+LiR6jDecPhNY5j39LqLFbOZOj4GLfQLSUzGtwX+M6BvSvA/335
         IM4s54HYDROpY6XTN+wU30ALBI3bos+Iuy5w8o3zX8/ja+kaG+9XNmx6AzwRaXmeqJ
         UxN6+njv/VkV7PzkRClt8djcIXKYkPW6WYwrzMLRk/uyEstXxukefeHGRJokfnyMnh
         CnToeq4LxSSAwSRAEW6DOt171VbY4YjY/lqReEg8usP5V4r59srXqI5k5ToxfxL9UV
         Gq2mB9hqii/nw==
Date:   Mon, 24 Oct 2022 13:53:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Message-ID: <Y1aKvvk4UQ/Ho8Hl@google.com>
References: <20221019122253.19669-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019122253.19669-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, Johan Hovold wrote:

> Add a binding for the SC8280XP TCSR.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes in v2
>  - rebase on 6.1-rc1 and a328ae8504db ("dt-bindings: mfd: qcom,tcsr:
>    Drop simple-mfd from IPQ6018")

I think I just fixed-up and merged v1 of this patch.

Please ensure I did the right thing.

> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index b12809b5cc22..cb0ae38a777f 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,qcs404-tcsr
>            - qcom,sc7180-tcsr
>            - qcom,sc7280-tcsr
> +          - qcom,sc8280xp-tcsr
>            - qcom,sdm630-tcsr
>            - qcom,sdm845-tcsr
>            - qcom,sm8150-tcsr

-- 
Lee Jones [李琼斯]
