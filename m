Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A056C64DABD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLOL6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLOL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:58:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F2D2ED59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:58:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 65so6526925pfx.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZOfOCT1uqUyQOZ3Q6ejDEihZSzQYrZucgCadknyvEo=;
        b=TaTybFJOhH5EPK/eBhO184gTI9rZ6NpPjNfPTGQmv+4pde+ovnS4o3OcSTPB07hU3j
         u8Gyneh47OfOatEVMn3wPktBWSiEx17Hm2qO/9QkhlOpPHF4cESHo62ysUOcZjFY1UgW
         46qjT3Wvo4pE17HeOcATjOBvTJdy3LzoYMors5zHe7mX7B3BLz3LEP6fnNuGiKxaXZZY
         KsH/VLtse+zcMYOJ2Mwrbu4HzaTUx12stdo25n1fyi4kfyjqVV/KGeFtufPgS4e4ZoQu
         94kCq1g/b7CCX8aW/1AaQk1I6DccFrnHOdxDBPOTDmYJi1rAlE3T2tMbtlW2BhxhuP21
         4Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZOfOCT1uqUyQOZ3Q6ejDEihZSzQYrZucgCadknyvEo=;
        b=AVsrsUVf8gy1PQDaqNpR+q+pXnnVYL3bPujp4Ip/JgvTLMaBKRBl6lO9+VUgT3BbeR
         Sa56/KolTX0xEPhPoFR/uLMkk2qJWhIlFlxg2GLR1OLbmS1Rwa0WQMaHq2n5XoZUj3i5
         4vSGjR5Mxy9lhCk0vl95XbDgAf0pXfuAYYFmMVh2S7zlQpCFBfyIwIlncrnhst0Yj+6+
         jT5Vs1qDVM0hhmYFcrJXuRnc8AGIFCIvgEd53RlS9eBBxGELdbPW1lJgXiVWg9hLVtHO
         J3ftvHDsS1O5MP2zyIHu9dWYi772yKwLXB2N99+qyY4KaP+z181YxcucOAeXg8J+FCxX
         qXgQ==
X-Gm-Message-State: ANoB5pnb6DBad2sLleyUGdJlk5eviOzA5rzMUy0z6cVW2Xxsmxg0gTRH
        7kPloSXLd2JJRyKHlca43iui5g==
X-Google-Smtp-Source: AA0mqf6zAOBI8FNjjz3fd3sqz5D+xV3IlJL7UUHXxCKfMPTOyHmWW9qt9YBU98dbCUcKtQgdAWvb4g==
X-Received: by 2002:a62:e814:0:b0:577:271e:e66f with SMTP id c20-20020a62e814000000b00577271ee66fmr28704053pfi.27.1671105487018;
        Thu, 15 Dec 2022 03:58:07 -0800 (PST)
Received: from ?IPV6:2401:4900:1c5f:4e45:ae49:8018:6d22:e5b4? ([2401:4900:1c5f:4e45:ae49:8018:6d22:e5b4])
        by smtp.gmail.com with ESMTPSA id h66-20020a62de45000000b00576145a9bd0sm1554392pfg.127.2022.12.15.03.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 03:58:06 -0800 (PST)
Message-ID: <1d3d8169-1011-cdfd-f9f7-b7828acdc1ac@linaro.org>
Date:   Thu, 15 Dec 2022 17:27:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 1/8] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-2-iskren.chernev@gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20221030094258.486428-2-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/30/22 3:12 PM, Iskren Chernev wrote:
> Add SM6115 UFS to DT schema.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index f2d6298d926c..b517d76215e3 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -28,6 +28,7 @@ properties:
>             - qcom,msm8998-ufshc
>             - qcom,sc8280xp-ufshc
>             - qcom,sdm845-ufshc
> +          - qcom,sm6115-ufshc
>             - qcom,sm6350-ufshc
>             - qcom,sm8150-ufshc
>             - qcom,sm8250-ufshc
> @@ -178,6 +179,31 @@ allOf:
>             minItems: 1
>             maxItems: 1
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm6115-ufshc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: core_clk
> +            - const: bus_aggr_clk
> +            - const: iface_clk
> +            - const: core_clk_unipro
> +            - const: ref_clk
> +            - const: tx_lane0_sync_clk
> +            - const: rx_lane0_sync_clk
> +            - const: ice_core_clk
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
>       # TODO: define clock bindings for qcom,msm8994-ufshc
>   
>   unevaluatedProperties: false

Seems this hasn't made way to linux-next yet. Hence we get the following 
error with $ make dtbs_check:

arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: ufs@4804000: 
compatible:0: 'qcom,sm6115-ufshc' is not one of ['qcom,msm8994-ufshc', 
'qcom,msm8996-ufshc', 'qcom,msm8998-ufshc', 'qcom,sc8280xp-ufshc', 
'qcom,sdm845-ufshc', 'qcom,sm6350-ufshc', 'qcom,sm8150-ufshc', 
'qcom,sm8250-ufshc', 'qcom,sm8350-ufshc', 'qcom,sm8450-ufshc']
	From schema: Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: ufs@4804000: 
Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

If, it helps to get the review / merge happen:

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

@Rob, @Krzysztof: Please help merge this.

Thanks.
