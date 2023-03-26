Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D26C9332
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjCZIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCZIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:53:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2062D56
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:53:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so24077507edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9l4JG0jB8L5lnEnjjTm1GgDn+X8VhsreqRhQBiqr0A=;
        b=qoWu95l+hp+iuVd5NrArIwy22CkrJS7NFYJSBmFoLSmyVJRhg/kLhZZF440sXGnAr4
         XkXIU/wRw9+ta9wBOWptmxqspvWpDQZXymfwIzTNVFWzaqT0rO4tXfDUnbn12MrOGv7R
         ATP6/XjEDjDWBLmS8/wLnHMPjP0aTCAbMnptwlv5XBmoC8h/uah6uyoKFWaR0o8P+yVq
         lMq6zU+k/b0uUN0fUo6Wn6OSczlGrGXKC8Jykabww2t+RlUGwHmRLg8sp5D2rle0hZfn
         dH26UrcczD/yqxzpIXznbXTngDw9qsPD+F7BUqdGivnRoRqjaoAD+zyJ5Px0FxLVpgrZ
         ybOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9l4JG0jB8L5lnEnjjTm1GgDn+X8VhsreqRhQBiqr0A=;
        b=yxd9r5RMboL0t0hWoYMYd3RR4ISYNokmukO11s+IUi+lbm62wXg2QSMzFZxjXWO/w/
         W303k5Z7Ai0TZ9wxzwSD6tPfY6v0ghDu3P80ey02+I785YTZ7Q45P+uG3Q5z6ve5K7t/
         fOYke4mGFVpkzDkyAlJFAt4W72O2N051mosZ32AHU/z9nZRKul8KzLd1xNXctX34V8+R
         VIIAryX6ICJ3SheQ11r1mRZE/4dulvdv/rQvBcJY1U6dnGf0LBzI+wMcaepEAMf9VpHx
         0J9xzpTMdWQ4+EShjaPGuiDztNJ3iSiG/0TALSvTx4eqv07EjJ60ef2+bOTi55vpu94T
         N5AA==
X-Gm-Message-State: AAQBX9fx0bl1uC3ZhTA3HR6ceFWni0ZP9zhz6thCJ/+fHQ/Z1KHlUJcN
        5zcbQGWfdOYsMJXa/G4S0hzTPA==
X-Google-Smtp-Source: AKy350Yzdh3LrxuHVgV4rLFo9iMeONGkUKJeqNKzMm/w+brGzvkE8UQ3rLeLIg45zubE/v1V++5L+w==
X-Received: by 2002:a17:906:33d2:b0:92c:6fbf:4d with SMTP id w18-20020a17090633d200b0092c6fbf004dmr8348892eja.40.1679820818136;
        Sun, 26 Mar 2023 01:53:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709064e1500b00930de1da701sm12992572eju.10.2023.03.26.01.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:53:37 -0700 (PDT)
Message-ID: <8ab9d0c3-89f7-90f3-58d6-d2994d372518@linaro.org>
Date:   Sun, 26 Mar 2023 10:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: adsp: add
 qcom,sdm845-slpi-pas compatible
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325132117.19733-1-me@dylanvanassche.be>
 <20230325132117.19733-2-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325132117.19733-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:21, Dylan Van Assche wrote:
> SLPI DSP remoteproc on DSP is defined by the 'qcom,sdm845-slpi-pas'
> compatible in the qcom_q6v5_pas driver. Add this compatible to the
> devicetree bindings.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index 643ee787a81f..175be01ecd1c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -26,6 +26,7 @@ properties:
>        - qcom,sdm660-adsp-pas
>        - qcom,sdm845-adsp-pas
>        - qcom,sdm845-cdsp-pas
> +      - qcom,sdm845-slpi-pas
>  
>    reg:
>      maxItems: 1
> @@ -63,6 +64,7 @@ allOf:
>                - qcom,msm8998-adsp-pas
>                - qcom,sdm845-adsp-pas
>                - qcom,sdm845-cdsp-pas
> +              - qcom,sdm845-slpi-pas
>      then:
>        properties:
>          clocks:
> @@ -104,6 +106,7 @@ allOf:


You miss also if:then: for power-domains.

Best regards,
Krzysztof

