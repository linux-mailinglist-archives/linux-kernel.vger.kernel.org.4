Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6C686367
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBAKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBAKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:07:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79E56227F;
        Wed,  1 Feb 2023 02:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A99FB81F2D;
        Wed,  1 Feb 2023 10:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07F3C433D2;
        Wed,  1 Feb 2023 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675245996;
        bh=SLnoyaEacnsPS2Yh3z9JeolmCwJoPt310N3QnpHVhJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J79rcS/6tptKFy0f4jXmE8h08JGZFSxobTZ+PxvUt7DYMAhXeI124TFzwLzcAwZR5
         nuzCvRasfYhbsbf5jRRQpOlx8C5L6/fA2NWMFlaC/xJcNTUGX3zUJnXye10gfD6XQa
         vAvin56Ypbci1HV034pM8qQxbNsJmzEn9komIf/IZD1sbJzxhnAKe9pixxioust39W
         ksGqRErrBPdNno4rjOa8sy6kjFR9+Gqcdpx5GHm3tAEtfpz0BqgBGJs3XlfxAnKfs0
         Zlq4QH7/M4KGVYqKxx1uhloomaG18a2WuMoTxmwdm4jb7xswcMW3qJCz85BkXXTLL9
         PDFuAuG4SL3hQ==
Date:   Wed, 1 Feb 2023 10:06:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: [PATCH V2 5/5] dt-bindings: tcsr: Add compatible for IPQ9574
Message-ID: <Y9o5onFcETRUmqGt@google.com>
References: <20230201090529.30446-1-quic_poovendh@quicinc.com>
 <20230201090529.30446-6-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201090529.30446-6-quic_poovendh@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2023, Poovendhan Selvaraj wrote:

> Add the tcsr compatible string for IPQ9574 SoC
> 
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Nit: Subject should be "dt-bindings: mfd: ..."

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index d463fb47278f..8cd0005fc8c7 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -30,6 +30,7 @@ properties:
>            - qcom,tcsr-apq8084
>            - qcom,tcsr-ipq6018
>            - qcom,tcsr-ipq8064
> +          - qcom,tcsr-ipq9574
>            - qcom,tcsr-mdm9615
>            - qcom,tcsr-msm8226
>            - qcom,tcsr-msm8660
> -- 
> 2.17.1
> 

-- 
Lee Jones [李琼斯]
