Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50296F2F06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjEAHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEAHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:14:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25CE62
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:14:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so444945066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 00:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682925274; x=1685517274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOIEOJwuj8TEMRgeiaU4r+H9yeZtqNC0bcB1IKwq4kE=;
        b=KaCBOZy7LEgRlOe0HwTpG9hakIxTnOph05EL1M6UI9kqs3oG2e/l9MopbSwHn0THEc
         8GXcajKjcPlqxhnao5QI8w+rVhznZuBurT3lZbFlT4Nm4H+LziBbKf9ZuJ1FvqJ1YZNh
         BWYIaX/gLZ4kJGG11Hk7uuBNU+wY9TjFMXyY1vwNIz/JyQi5AGCO3YftonakEzIpuTzb
         Jhc+7TID/mFr7nECm1WNyPEey6zWFXCgLfsZknLn0/btMmfBPlhylKkrY4oe//ECn5gE
         lEs6Y5uqduOdDTpPwDHd9jlX2YF8SN0erfwC/m2NOSPYDkePFh6+IGpy0oGTOnQ+ZdFQ
         jaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682925274; x=1685517274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOIEOJwuj8TEMRgeiaU4r+H9yeZtqNC0bcB1IKwq4kE=;
        b=ExeLPtErCgUoVcvYzit0Psse9RGpPHbuDXInEnqgbJEfnrAT5yfRqp6YGq5wMuO0zQ
         IkkSHYCRMhCpO464GukKKpOvFiD3k0uB1FPpLYLnFPJcvVVrsxVffrWkbNx7XTDKBSrZ
         yH3Cvx7m50f/ETlnYISeTSczS7urhZlRGRzDjT0wYCBlvHOmwBMeBJOvKpX9z32r4BL7
         57zMlAhGsVovb9C2ASIEJ8IZIFgWzzODB2QCXQkF5dO7KbPMKutwGujfv7mfGMtY4OvR
         Fg0pwuG4DT+4bPjPFxDQQ7mSy/k3ebSHhZyw5/Gyjkjb126y+uuvLB5qVl3FhCmio458
         d4Ow==
X-Gm-Message-State: AC+VfDxTSAyL2Y+z0J4TgFKTu2hGV4RYrbaFkW95HqO4l9MYLN59yKKs
        kTWYCeILEAqt5Nxavno57lQ4rA==
X-Google-Smtp-Source: ACHHUZ5WoGI/FJ2sX8tq8Y8KioKjeUqed/v9qHagAiQbmJP7XHEag4uekCPI/9iKh5WlZkmmzqn9Dw==
X-Received: by 2002:a17:906:dc92:b0:94e:ec0f:455 with SMTP id cs18-20020a170906dc9200b0094eec0f0455mr15220138ejc.54.1682925274356;
        Mon, 01 May 2023 00:14:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id ia10-20020a170907a06a00b00961277a426dsm3287444ejc.205.2023.05.01.00.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 00:14:33 -0700 (PDT)
Message-ID: <f449aa76-b3df-5a30-2b82-eaf3faeb1072@linaro.org>
Date:   Mon, 1 May 2023 09:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 16:52, Varadarajan Narayanan wrote:
> This patch adds thermal zone nodes for the various
> sensors present in IPQ9574
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7cd5bdb..a7cb2b4c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -947,6 +947,214 @@
>  		};
>  	};
>  
> +	thermal_zones: thermal-zones {
> +		tsens_tz_sensor3 {

No underscores in node names.

Don't invent your own names, use the ones we already have everywhere.


Best regards,
Krzysztof

