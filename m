Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64EE660F4D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAGOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjAGOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:05:08 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC06E428
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 06:05:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id az7so3700674wrb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOJ9jBAr8EM/qZhGcPKg/28tNVL1EhgfIU/MStrLkiA=;
        b=zOKFtZTrZcPCFOYIns7I8L63CLCFHBOM38x3xZULXs6Xi253rPRUOFLtUi/WfA3yFE
         cXPQnSrEK4SKnIhoKyR3Yh7LbF+d8Zq6IoRIWhvABerGxyMQx5d4GLj+sbCXjikQIeS1
         0T53ZXBhUSVmMCgMGs2Q5cftMtAkm9D6XnUsywL4tMnNg9Gw4KTbCRTRUjCe25q6mlXW
         nk5M6dz7GQ3UpU9rpmEfm644LJH1K5Wu0Sd2QDZqKZLtZjWSTBfELCDCbfhE6w+F2b/i
         wWuaWibDF9i+xSqJsS6nRhdc8z74r2lRCdhUyJD78zMCb7zSi34hacSDI+HRxvl3qP3x
         YmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOJ9jBAr8EM/qZhGcPKg/28tNVL1EhgfIU/MStrLkiA=;
        b=cv3z0lbuUXZ1iDzlD46dw2mGLMElE6zWkw7rSrIPUOFvgIBUyUm3LyhNMLMb2oUIh4
         0JqxYlOMG95tMEf8htN2ZzGnDyIDmZcaF4M57vIPkLBT6NyTz494qIDguwI/lLXHl7Al
         GdN7ebSSwy64Dn0TTd+cy6p8ZXa8pBkmhXYB7pEVKNU9PGti5Cc0UAXxxSY0lGFGmHSd
         X1SQjHIBjpEVgy9No9oJjsgwCScqOVLTvYX54XcU0L5D9u90/t/JsBaPBRENm1r3/weZ
         cc6A3BuEP4j+z25Qbq1I806DRmd3QLd0nyR5PZWCF5Egj7tL7KNiDaJEp8o384tbofYX
         HNMA==
X-Gm-Message-State: AFqh2kra6JDdTsR7fR10BDrYrpQFMGaUMyXP5IUjGeA7GkLcrmiY7XEF
        zDCU/jBIsEZa/QnERK0EUZj/Xg==
X-Google-Smtp-Source: AMrXdXsX1CocpfHnrpgfFQseDjTvezF1FvpnDpBU0nSsT6ASpWYxMn5As7IOsikN961m0WRp4/ZCgA==
X-Received: by 2002:adf:e34e:0:b0:242:ac3:87f4 with SMTP id n14-20020adfe34e000000b002420ac387f4mr39038652wrj.50.1673100305445;
        Sat, 07 Jan 2023 06:05:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g1-20020a056000118100b002755e301eeasm3877973wrx.100.2023.01.07.06.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 06:05:04 -0800 (PST)
Message-ID: <61f05268-6b7a-0884-c885-1b737d3ec5b9@linaro.org>
Date:   Sat, 7 Jan 2023 15:05:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] dt-bindings: remoteproc: qcom,sm8150-pas: Add
 SM6375 CDSP
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230107120623.1903056-1-konrad.dybcio@linaro.org>
 <20230107120623.1903056-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107120623.1903056-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2023 13:06, Konrad Dybcio wrote:
> Add entries for SM6375 CDSP, as it's essentially identical to the one
> on SM8150.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Rebase on top of recent changes, move to 8150 pas yaml
> 
>  .../devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> index b934252cf02b..082ae70a3fcb 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,sm6375-cdsp-pas
>        - qcom,sm8150-adsp-pas
>        - qcom,sm8150-cdsp-pas
>        - qcom,sm8150-mpss-pas

I don't think it is maintainable to keep sm6375 once here and once in
sm6350 file. If it does not fit one family, then probably it deserves
its own file.

Best regards,
Krzysztof

