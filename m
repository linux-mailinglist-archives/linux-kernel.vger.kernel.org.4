Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0BA6AC904
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCFRCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCFRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:02:06 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAE4615F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:01:38 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PVlGS2kNgz1S5Jx
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:01:20 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:subject:from
        :references:to:content-language:user-agent:mime-version:date
        :message-id; s=dkim; t=1678122079; x=1678986080; bh=bI8Q9ZobF/m/
        5zL0TsX0t3zOLtFDXF74jdm5TmV+sTA=; b=lpxCcPVNSQsn8dJBRjkyDQ1UdPaf
        VaX/X+bTeGV7/cqy814VOAUxrhgnRQETMJzMA/TFoGeaEyZoEsadDeO1vQepfriP
        1aYShJZZtxowD72iVqkjCNYSGG08KsvkVb0Ci4uWXRrlc75dtwNSOzGUNXBRuPJM
        u/gtxHoOlLIaGOWoebhoNLbFboZZRdvRAHlK1vgQS/EbemYjvp6dkJJ+Rajhli51
        zZz2c9XuEhcVYpJ7GAbQhQG2EBAHsid1iQ6IndRf1KaQK7keEIHd5P1UxOZcMdWl
        24hzwbv09h9kkCTEnd1MfpAG6fMvgqoXJ2/ud9Ak1Pq5TzygC6J2NRUaiw==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kb1EhKe3ZvHh for <linux-kernel@vger.kernel.org>;
        Mon,  6 Mar 2023 12:01:19 -0500 (EST)
Received: from [192.168.1.90] (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PVlGC5d4jz1S5Fp;
        Mon,  6 Mar 2023 12:01:07 -0500 (EST)
Message-ID: <4670ddae-6b01-1e5c-b0ed-1f2f498a4f66@mint.lgbt>
Date:   Mon, 6 Mar 2023 14:01:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230306165246.14782-1-they@mint.lgbt>
 <20230306165246.14782-2-they@mint.lgbt>
From:   Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH v7 1/6] dt-bindings: ufs: qcom: Add SM6125 compatible
 string
In-Reply-To: <20230306165246.14782-2-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/03/2023 13:52, Lux Aliaga wrote:
> Document the compatible for UFS found on the SM6125.
>
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index b517d76215e3..42422f3471b3 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -29,6 +29,7 @@ properties:
>             - qcom,sc8280xp-ufshc
>             - qcom,sdm845-ufshc
>             - qcom,sm6115-ufshc
> +          - qcom,sm6125-ufshc
>             - qcom,sm6350-ufshc
>             - qcom,sm8150-ufshc
>             - qcom,sm8250-ufshc
> @@ -185,6 +186,7 @@ allOf:
>             contains:
>               enum:
>                 - qcom,sm6115-ufshc
> +              - qcom,sm6125-ufshc
>       then:
>         properties:
>           clocks:
I have to apologize. I worked on a changelog for this patchset but I 
skipped the subject header, therefore it didn't send, and as I realized 
this I interrupted the process, leaving the patchset incomplete. I'll 
retry sending it, this time correctly.

-- 
Lux Aliaga
https://nixgoat.me/

