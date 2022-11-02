Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6560615F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiKBJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKBJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:11:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8936C27CDE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:11:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f37so27167049lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epokCIiVNHGQ8fB3wg3FYwtGcEW+rWSyf21faKheRAI=;
        b=juvIj5xOyOZA5nYwp/qGUTDwqBrtyAa7ARbpZcO3+I6Z9nI5LHF6TvZQvUpEkYctIb
         0UeJXHtn/+oJaoJlM60N2nS6018jVI69MTD6u8RBJOKohbIxd5YQNK4ualeZ/vQYu7kD
         C6ELe8M8+8HW9S5fuhyojh7gmMTfQcMcb1JbVdk/WFxn3c9zJM5Zu8QbOwFx6RShBpPS
         h5VbcKFvCkTPq0QKU3fyJwDYwzaz8qPQP8wKJnwpwE3u5P7W63SAP2iwO0JClJp+a0el
         BqxWIjFIl6N/Bd0+QK3eBc68x4WF3fOMANY5MbPQA1NMSnp2zsl7ZOTpyvTl7KaaiR3C
         raVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epokCIiVNHGQ8fB3wg3FYwtGcEW+rWSyf21faKheRAI=;
        b=j09QqxQieamRaDEWBfpnhOFVlDg+9qzBdCO7BkMUx2emH8Ep5eNpMxtJ0kzD1rLNBX
         UobJDBKv5UQsCE62j/fNfr6T+O1ul4SVfDvKR1p2j/h53/9WQEh9pfjjG26NQdrl/4aH
         +J5yh8o+e2+gwyU79E7gOuHOuZx1A6oZT34yufIcO+QjOU8sOEv7BLchowAeRD72ONKm
         KfRiKbY6FDgPZrMwcVsMIKC0Xk0GwdhLGdUNzcIVwzXLlTimRXq6L21E/W/RhnaBK0CZ
         SA4xiH062ysD4lvC+pmUX9lokICWb51daUghVWqqN290406vPOmjvwFZOJFBrTVHvKQa
         LdjA==
X-Gm-Message-State: ACrzQf2sLrfF2QODm+ZxixwTy50LQMcyAvR9sMQhnU0T79hG5morWnDu
        rI1Shxx2h/KsgP+H1k83ZmbaFg==
X-Google-Smtp-Source: AMsMyM5aw5oQ++WfXSz0qCxYQjVAmVhKmoo6hFujepwRTAbqFYrX3iatCFwE+HJHm4xUQOD1wGJT6g==
X-Received: by 2002:a05:6512:3159:b0:492:d660:4dd7 with SMTP id s25-20020a056512315900b00492d6604dd7mr8157040lfi.204.1667380261947;
        Wed, 02 Nov 2022 02:11:01 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e7e06000000b0026bca725cd0sm2075632ljc.39.2022.11.02.02.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:11:01 -0700 (PDT)
Message-ID: <73a5f42a-232f-c543-1490-fcf3f4f84307@linaro.org>
Date:   Wed, 2 Nov 2022 12:11:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 5/5] clk: qcom: dispcc-sm8250: Disable link_div_clk_src
 for sm8150
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>
References: <20221102090140.965450-1-robert.foss@linaro.org>
 <20221102090140.965450-6-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221102090140.965450-6-robert.foss@linaro.org>
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

On 02/11/2022 12:01, Robert Foss wrote:
> SM8150 does not have any of the link_div_clk_src clocks, so
> let's disable them for this SoC.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8250.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

