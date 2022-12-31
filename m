Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEC65A77B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiLaW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiLaW3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:29:20 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE02639D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:29:18 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4Nkxcs0Pkxz1S5Ds
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:29:17 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1672525756; x=1673389757; bh=EuMauIr
        6fyRDWGpCOzAisjazQJOJH33TcXmNRA+3XxM=; b=3yUsKOfKVzpta7Qb05vMfjU
        ShXD/kR9kzUDD8ep3GaDOfGNkNHJnwTHVlI/CkKRnaWMR76PIwrqM2LcC/v7VbiZ
        xGP1liB/vjeSCrne9W736m3SKpPdbM067/WyLoODWGpgVIwZ3aYDV1cJVZVJiU1D
        6Ssjk3rJ7X+SgMnM0AFwyPew9ToWKMRfHWTddPH8Ns7JqNYtPq/DYd/yu9VPGC2E
        jfKLDHr14mM3hs2voDd3A9xr+reQpgntWS8yQSng2Z93Dh53FgsfYGlTVJ4jckNF
        45IeVWGIVsWgsEca+mO0yT098FrSjc8AkB9dQmlYgjrLKPIskCBuqv8ZwOtK68Q=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z1UqZkMhry2D for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:29:16 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4Nkxck3QV2z1S56h;
        Sat, 31 Dec 2022 17:29:10 -0500 (EST)
Message-ID: <efbeaabe-c1ca-88a2-798d-a617025f7148@mint.lgbt>
Date:   Sat, 31 Dec 2022 19:29:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/6] dt-bindings: ufs: qcom: Add SM6125 compatible
 string
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-2-they@mint.lgbt>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <20221231222420.75233-2-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 19:24, Lux Aliaga wrote:

> Document the compatible for UFS found on the SM6125.
>
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
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
Ok. So git-send-email, despite indicating I was sending composing a part 
0 for this patchset, decided to only send it to the people I explicitly 
CC'd. My deepest apologies. I will resend it to the mailing list now.

-- 
Lux Aliaga
https://nixgoat.me/

