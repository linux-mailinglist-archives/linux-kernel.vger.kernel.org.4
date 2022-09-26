Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AB5E9B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiIZIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiIZH7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6AAE47;
        Mon, 26 Sep 2022 00:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C59B8191D;
        Mon, 26 Sep 2022 07:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7912C433C1;
        Mon, 26 Sep 2022 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664179053;
        bh=QTLA3YF9AiEQybUyFdQhFkFoVISeKnQ7EdbSa++0Axs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRmyuA3Q9PagzbLzSRoZTo+wXGCJ1DiipDin0Wnu1TOstTjft4Rz9a9Iz311J1WLg
         9H9qaTXpS6vm6pWnDmsLP5r8KtGUcwtNt3OWUKDIPuf1pYLbkV1sc5ZPWLuCSNL3cz
         y4V43NHxoWikICnqNazKmdHmqAKuPD4bTrvUT7dEqoRXkHD3PSWD+jmRF8FuwgMtP8
         m7EOSg4h1JoCC8zaAulKtAFiXk+9A1y1fW2QmCHNZQE7F7sKPcUOaVPGWc5MoGRwq7
         RlB0NWgjx6/o74BtmBTo+lK6MYKOvEPwQqXkiLo3XBaWgbDzQbtu+H8frDkOF0+7lt
         Lo9giEsSGfGXg==
Date:   Mon, 26 Sep 2022 08:57:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: qcom-spmi-pmic: Add pm6125
 compatible
Message-ID: <YzFbZkN8gSjJm9nS@google.com>
References: <20220919204826.215845-1-marijn.suijten@somainline.org>
 <20220919204826.215845-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919204826.215845-2-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022, Marijn Suijten wrote:

> Document support for the pm6125, typically paired with the sm6125 SoC.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Doesn't apply cleanly.  Please rebase.

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 65cbc6dee545..a6ee8c7f7738 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -35,6 +35,7 @@ properties:
>        - enum:
>            - qcom,pm660
>            - qcom,pm660l
> +          - qcom,pm6125
>            - qcom,pm6150
>            - qcom,pm6150l
>            - qcom,pm6350

-- 
Lee Jones [李琼斯]
