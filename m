Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAB68B747
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBFI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBFI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:26:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE51166EB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:26:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ba1so5496478wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVGqi9m2rAiNQCeKFtex+LBXvSiHKS7nTvOue98dVrQ=;
        b=d78ut68WxhA+C0B5mbubNkrv5PMCl7c+JhCqyLZJ/nLJR8mGMGcya2I3wsvMPK8Je+
         zxl4vXtghMc9jz06/M2OFel2La22se7Me0QtAeFyRCieeuesWKr77s3oMQoHK69aDcx8
         44r2Soa3wPPqU3w3xXZNvGdbm3pwIH4kLnyu6itH06nluGipf90tddERsIHhapB3mxvB
         GHokYSdLtD4UEpU6syqPfDiR7yE1539GiWgzt5xWbtzHYclpeaQ9qbkR+YIWhbvj7bWN
         xbyPkis+glX7Mb6/jOgyiacGHbWuCXGHZc1pufoRSJyYmTdVfM6+WtPBNebA5FTMJwJc
         7QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVGqi9m2rAiNQCeKFtex+LBXvSiHKS7nTvOue98dVrQ=;
        b=VzP3JIImVL44nEyMVmgF1vpDr6MRt6vkzlz4FWUtnEkrHo/vW02UK1RKPw5TyXmVCA
         6xZyoa4DjqGobz3daAL9BOrEf/ePDpHalXEx/6WrmYqEN6Auzdf0BSZcWP4KRl/Rpr4k
         8Um13PjmhFD5YEFXWYCEzI63WwWpV+8jECC84I5+7jOf01Hkj1min9U9qe9XbpV31jdw
         cvBegoSNkqra79B3tG0cWoIbJMj+NaYdT3LGzyagCikvYrm7YTzBSGbKAntkw8DpASdA
         AgMlSB1Hu+btKfJlzSEayD6OlUED2m2NZWkuDwNOB48Z9j88BCW9DF5+6u2DkfN1jiNr
         Zhww==
X-Gm-Message-State: AO0yUKUfdgWzOKzicurvRhqy5jPTtF4EZIaVhxs7MiHZg9qX7cN8rc6F
        dq9Y5vPuAIUB3KQ7s3sFdfcrbA==
X-Google-Smtp-Source: AK7set8elb6X64BDRQbQ2i9AxLmyMFdO5ZrXRWdLqsem12xKIi2ZrTQWwCRrdMTdfeHl0gnLpkVdeg==
X-Received: by 2002:a05:6000:110d:b0:2bf:c0f2:4b0 with SMTP id z13-20020a056000110d00b002bfc0f204b0mr18620755wrw.19.1675671965315;
        Mon, 06 Feb 2023 00:26:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b002c3b2afae00sm8134906wrq.41.2023.02.06.00.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 00:26:04 -0800 (PST)
Message-ID: <214f4fa1-4239-73f3-812c-bd9b093cb38f@linaro.org>
Date:   Mon, 6 Feb 2023 09:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 1/9] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206071217.29313-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 08:12, Kathiravan T wrote:
> Add device tree bindings for IPQ5332 TLMM block.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

