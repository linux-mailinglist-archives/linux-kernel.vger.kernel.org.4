Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE976AD21C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCFW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:56:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B28053292
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:56:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so10448911wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678143388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMs91jBxp5byb1ls4+Bz7qIbLmtcQaw3+WDyooyO6aI=;
        b=ahEoQS5Wx3GBfvytSnMgrENh8dM/erW4qaKb76kVo+qwJQgfaeLyrFyAgIAxWMeF5X
         t20iaGq0illSzXjwPx4k4s36ghi0qFqU/8UZK14rIdppH+seuThXB8OhoQihMwklwO6D
         1wg0r/HYrqRCLv9THbJaFN2cLxAar1u/3jMvNPO477v8mnlvlQHzvPRvaT8w/gVHmHEm
         GVQlG3qGeMC5kTSLlNgaPZM+ZCD2dEwpy5FhafrqtZreHg6p5Mhjhau0hOyCSnL0xTbP
         8ms2gKXXdaV5FYJ52lSWPHU6mLgyP8a5oIhqsaRzl53ayiZ6G2DpZLmNZxSEVqlwEmF1
         gDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMs91jBxp5byb1ls4+Bz7qIbLmtcQaw3+WDyooyO6aI=;
        b=MGw3f/YL4amEIKcNCIsoOXuypDgspJKe33ktPgpdLUYGVFWlRIfKncy2rGAINXwRsi
         UtzQKOl/d7qv+1XLLFg3TjN2C6Y+SJHW4gC1j1RThsLaMIMuALyLz4C97JurwdeIdM+Y
         gJgx7UFF8IiVHvuCGpZXZpjtCtzaXt3hiBuhGJJUhnth8s1N0yegCY4VPnwxxfKzWcjo
         vmsVZxtVHg8jHPtBuJuOZdgg4LP/66axn/6naXcbEz6q1bKoG1AIJX+jFUpt9w8xzfpc
         RypTj2azPQVq1klmiXF+W6L7Yts+Jojca+RXvSEiuaXXclQGfdTnKsXEQb9+oTvAszOh
         UoXA==
X-Gm-Message-State: AO0yUKWTN7/BxPUnm4/fPIfHV/nJMsuiCGk19YS6xsu6Sx8Y7qjNFh3e
        4zqCJrpKBSJufOMol85r24YilA==
X-Google-Smtp-Source: AK7set89+YfS8ddABA3YzaCxy8e8Cn5D9/WQNPz7W4DLSM17JrpGTTUhJPc4kvKltthEjn/ySDgwXA==
X-Received: by 2002:a5d:56c9:0:b0:2c7:6ce2:bb37 with SMTP id m9-20020a5d56c9000000b002c76ce2bb37mr7701595wrw.29.1678143388534;
        Mon, 06 Mar 2023 14:56:28 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r22-20020a05600c435600b003eae73ee4a1sm11293813wme.17.2023.03.06.14.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 14:56:28 -0800 (PST)
Message-ID: <f4b3d8b1-bbe5-2c47-46a9-a33ebec2492f@linaro.org>
Date:   Mon, 6 Mar 2023 22:56:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 5/5] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
 <20230223153655.262783-6-bryan.odonoghue@linaro.org>
 <ZAYRUIg0SwKOnBGx@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZAYRUIg0SwKOnBGx@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 16:14, Stephan Gerhold wrote:
> There are*a lot*  of unused pinctrl entries here. If you don't reference
> them anywhere (by referencing them via label) they just waste space in
> the device tree. The GPIOs will still remain unconfigured.
> 
> Please save them locally for later usage and only keep the used entries.
> This will ease review of upcoming patches since these are better
> understandable together with the actual device node making use of them.

TBH, I really would have rather received this comment @ version 1, 
before doing all the work to sanitise the incoming downstream DTS.

But sure, no problem, I'll drop.

---
bod
