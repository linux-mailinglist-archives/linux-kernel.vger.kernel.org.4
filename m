Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1173CB2F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjFXN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFXN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:56:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33781E62
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:56:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b45b6adffbso25049961fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687614989; x=1690206989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGvLUc16Lc7z7JPHc6BytUM1hxQYmYHaK9WFMQYko8c=;
        b=M2NtPk96+vwTXP7huFIp9PeoIwNHAIQOi+8heAZWuJkTczvawpE5NEirOOEFvehJTe
         XFyBM+KaYmNNQQJoKJXAfx2w4I9mJmIZS59kY+zugRSdKjQM1uzobixwH7oQzKNGpJ4e
         B1w5VdhFqPIFYugJvxysAuUy8VI/eb/P76XyC6t7a959hZl7nlzUL0I0o3+rOHBuwQ6O
         EwQZruB0RkbCMagYr0N9S4d1YKl00LdjPfS14F6v43etayrsTd2pIYBz9707VKNRt7HH
         8AKeS2RW9JvkFrnJOsh5YUCa2E9GraqZbY5zjFqCztugjW9aeDtsrQg5XWLiUuHvqyLn
         EFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687614989; x=1690206989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGvLUc16Lc7z7JPHc6BytUM1hxQYmYHaK9WFMQYko8c=;
        b=anJvF0b/JpnnSOtxzXePHpJrx8xXGudI5Z98PzBFyjZVohXtWOwOGVuEJZ5ieScfKj
         dmgijMITSanAKcohZdMvAwFZQtsz1Y6zXiN2G5+z5B2v7s6DTYJEuDHu/YWH7zUUEnnw
         b0FpYwolrHQCKsiYKTV/hGbZKvmYPn0bJH3n2GXneAN+uGR4SdpOXaORbIqg8Niu/lS+
         /zlpMUFF0fv7vcHGoSLbkXaRxP1ikyYAnGm8y76SHEO7Lb5yFE/U80+sVfRmBHTfKSVO
         S3YRaN8VpehU6RSE96BJXhfYRQ4eN74tSFFkgYx4lbxxQ+9F57UQN+gsbofun8xDZ/42
         q1DA==
X-Gm-Message-State: AC+VfDwZzO2zIs/Z+Qz/k3O8NBXGf9rYGSoyvkBI8uiqYnwrZ5nzz3ZH
        PK4K4Vldc/02JATQXVWSnZXY3Q==
X-Google-Smtp-Source: ACHHUZ5JDsxY9Ml7hquxmv4vE8mpl7234U8KZ5CytEKB1Qb+RLm/V2adXZ+S1s4PM+LLvLBWIvw2kg==
X-Received: by 2002:a19:6558:0:b0:4f8:6abe:5249 with SMTP id c24-20020a196558000000b004f86abe5249mr12029382lfj.3.1687614989334;
        Sat, 24 Jun 2023 06:56:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512390600b004f1383d57ecsm280827lfu.202.2023.06.24.06.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 06:56:28 -0700 (PDT)
Message-ID: <1c80bac1-0168-b260-e4dd-651e229b8fdf@linaro.org>
Date:   Sat, 24 Jun 2023 16:56:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5 3/5] clk: qcom: camcc-sm8550: Add camera clock
 controller driver for SM8550
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230623164619.11464-1-quic_jkona@quicinc.com>
 <20230623164619.11464-4-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230623164619.11464-4-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 19:46, Jagadeesh Kona wrote:
> Add support for the camera clock controller for camera clients to be
> able to request for camcc clocks on SM8550 platform.
> 
> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since v4:
>   - Removed overloading .l config with CAL_L and RINGOSC_CAL_L fields
>   - Used clk_lucid_ole_pll_configure() to configure lucid ole pll's
>   - Used module_platform_driver() instead of subsys_initcall()
> Changes since v3:
>   - No changes
> Changes since v2:
>   - No changes
> Changes since v1:
>   - Sorted the PLL names in proper order
>   - Updated all PLL configurations to lower case hex
>   - Reused evo ops instead of adding new ops for ole pll
>   - Moved few clocks to separate patch to fix patch too long error
> 
>   drivers/clk/qcom/Kconfig        |    7 +
>   drivers/clk/qcom/Makefile       |    1 +
>   drivers/clk/qcom/camcc-sm8550.c | 3383 +++++++++++++++++++++++++++++++
>   3 files changed, 3391 insertions(+)
>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

