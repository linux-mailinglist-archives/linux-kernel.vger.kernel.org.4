Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625C8655A58
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 15:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiLXOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 09:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 09:40:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7581E039
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:40:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so1050101lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 06:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4y1v/6kGhsB43W5lYaREV5k7vVErtV06ABJyLGw3E=;
        b=lVPZBYKatl1jb0EDXy5sPKMfxCQjGR5rk4JhOUSJyAz+lMGw4vYWdFEpyNJPHdmDIP
         8O1LsSJfpkpESOKMJSn4QGDA27Z4xjagR/HbiiqiEqbldN32b+MgohZ9xgBMljvelWwr
         JbII+QbxL+LDlg0gKaJWKcamYq4uWM/+/37t0TyVMHGUD1ltucEQtQ3yTxvsLZ4blpZL
         gAYUP16Hitp5U/T88SzM0DcjbyvR2UrQkJeTMWFfZZaer+FQAaaWFWCz5CPeeIbAbA7n
         w6YhlMpND98RphOBPx9UoaCgWEUq77yf6zBcjEi33aJh3jzxBnian8Ga4R724+RZM6D3
         bgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4y1v/6kGhsB43W5lYaREV5k7vVErtV06ABJyLGw3E=;
        b=TQzyLeKOn3bbZMLG3Nr4mNHc1ggYJY9pz5OKkH+GrnOH3jbWPU9GCfASuFEhBPI1iP
         CKM1xiVFhcVB33dUSwMkh62IXrHhzHVDEgTNbg/f05s4O+LR/IdrpSIzKs2MVRVS4o0H
         gm23hcHiaMcVK50lftfMile6ehNsD9ts8xLa8hV0NiIFfUS1fdpFIIJacr+WPYtRW/z9
         jJmpf9Gnd6NuMqNm5SvJZog8+F8a7ZTZarkna5+fBDwN/w+TnHR8FCAzxZEQBghYj4Fv
         gKqTM6iGe7+scEB/FUz3FjC1iZEXF/YnbBHiVU8eHB/KeQtRoJmK8mgtJpW7f/bjgv3o
         8iFw==
X-Gm-Message-State: AFqh2kowniBj8Nbl6z1CdX2f7eRqKJbL4kDLJLOe4UY9HTXOqZ3QR+yP
        BcmfscLsFx5XrAJ00Dz2eUOPLg==
X-Google-Smtp-Source: AMrXdXvJGiHSbaP745Kpqugib5NXtxgXQBl1bFHWh9CyQRBuB7Fir6p3+hlgpoKSVVVVR+ygW956OQ==
X-Received: by 2002:a05:6512:168d:b0:4ca:fd5f:ce82 with SMTP id bu13-20020a056512168d00b004cafd5fce82mr530060lfb.49.1671892825195;
        Sat, 24 Dec 2022 06:40:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c18-20020ac244b2000000b004cb018ad4dfsm15286lfm.135.2022.12.24.06.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 06:40:24 -0800 (PST)
Message-ID: <838e7657-817c-e5bd-5a45-d852560c7fe1@linaro.org>
Date:   Sat, 24 Dec 2022 15:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new
 VA macro
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
 <20221118071849.25506-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118071849.25506-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 08:18, Srinivas Kandagatla wrote:
> LPASS VA Macro now has soundwire master to deal with access to
> analog mic in low power island use cases. This also means that VA macro
> now needs to get hold of the npl clock too. Add clock bindings required
> for this.
> 
> As part of adding this bindings, also update bindings to be able to
> specific and associate the clock names specific to the SoC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-va-macro.yaml   | 63 ++++++++++++++++---
>  1 file changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> index c36caf90b837..288a1d5ad585 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
> @@ -27,16 +27,12 @@ properties:
>      const: 0
>  
>    clocks:
> -    maxItems: 3
> +    minItems: 1
> +    maxItems: 4
>  
>    clock-names:
> -    oneOf:
> -      - items:   #for ADSP based platforms
> -          - const: mclk
> -          - const: core
> -          - const: dcodec
> -      - items:   #for ADSP bypass based platforms
> -          - const: mclk
> +    minItems: 1
> +    maxItems: 4
>  
>    clock-output-names:
>      maxItems: 1
> @@ -60,6 +56,57 @@ required:
>    - compatible
>    - reg
>    - "#sound-dai-cells"
> +  - clock-names
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sc7280-lpass-va-macro
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: mclk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sm8250-lpass-va-macro
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: mclk
> +            - const: core

There was no follow up on this patch and I just hit the warning here, so
let me bring this back - that's not correct name. DTS and drivers use macro.

Best regards,
Krzysztof

