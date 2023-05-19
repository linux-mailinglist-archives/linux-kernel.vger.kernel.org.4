Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A0709477
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjESKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjESKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:07:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6667212B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:07:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae54b623c2so27540475ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684490835; x=1687082835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnbeQCKRZQ1oVV3aSgGqxAoaIE3PNvSwf7Z9BVloxcA=;
        b=T7CPrN+4s5uBE5e3tFiT/gAVTm+XDVUlfwLAQnJMvReUd1KrhuTA/5cuU8I8vbCw3N
         d8ZKQZykUctX3N6m4RAgiluMX62iLMghEHVlshYLQ720rPm9x6VfJgHy5s9jQJ3voQ1I
         8EXPAV6nrCxtmaAXDouNEW8L9XY7MzBki6ExeNgjmRRmVM2hEP+my2gXP38YZgTcJLFF
         oUeeFrl3EkK3dt4niwOYl8HgnTPKqSZWMOtmn7pioOFVmLcgz3T6Sq2vLd/kEjpVRMeu
         JaFVO8FMKQ0vRaMnv6ABgLYQg4zz/UHmuyZz5aPW+4vjrHgg/vk3I8K5WZ94LMdMmGjz
         REoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490835; x=1687082835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PnbeQCKRZQ1oVV3aSgGqxAoaIE3PNvSwf7Z9BVloxcA=;
        b=SNnXCfKhKds/tTBKNKJJX51DsSrTY6wn2zBaZ9zUxdenB12d8d+uvzmNBJ8dk1DrIn
         b4f7kryIg9f8zGuM8ZQOiIlYWE1E1+8z0L2RsmOCHdVdncbLQxEULdZXmFTK78+fOQ7P
         oorgtU6Hy5ArVYp2aPi4nNfg8493T+lX3v8sfYZQFvpo6x1j5lCSt7Q61XwyrcXse/La
         bGg0LE9jEBhRUyUDuV3uG8Ik4fHV6/xgyh57zCKEyaEsXNj0ud4VHGVAmKnOd7u9JHqc
         bdtJBoWfZVkVieurReYVKWpLpkpgCFw3SYMzf9Di+EFvj4IgjF/9w+Slaje/78nrwAis
         MJAQ==
X-Gm-Message-State: AC+VfDwBYiPOz8PGa5hzr1jJy+aLYeo0B8KoUDmRBH9/rGnsU9pFw0CT
        HdaAVaMp4JixryB/40TjCg2kxQ==
X-Google-Smtp-Source: ACHHUZ7QcLQIIL2qrjhVKBw8fOYJtVm3POoYBswuGh6hyMI670oYUJkue8G1M6neaNsKEO0v5m6gPg==
X-Received: by 2002:a17:902:7683:b0:1a6:82ac:f277 with SMTP id m3-20020a170902768300b001a682acf277mr2234879pll.14.1684490834817;
        Fri, 19 May 2023 03:07:14 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id bf7-20020a170902b90700b001a64851087bsm2998993plb.272.2023.05.19.03.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:07:14 -0700 (PDT)
Message-ID: <94e1e91d-e36a-215e-2395-6212c1694dd3@linaro.org>
Date:   Fri, 19 May 2023 15:37:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-2-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230519085122.15758-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 2:21 PM, Komal Bajaj wrote:
> Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 4f2d9e8127dd..f51a38b12d6f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -55,6 +55,7 @@ properties:
>                 - qcom,sm8350-sdhci
>                 - qcom,sm8450-sdhci
>                 - qcom,sm8550-sdhci
> +              - qcom,qdu1000-sdhci

Please add new entries in alphabetical order.

Thanks,
Bhupesh

>             - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
> 
>     reg:
> --
> 2.17.1
> 
