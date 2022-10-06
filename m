Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3045F6EDE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJFUVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJFUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:21:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C19B489D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:21:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y5so4397189lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=v14VcMWCpMI9EAr+1tPnKmC3n5xnws8GNTWCzmKsRug=;
        b=F/dpLSj0BF/XtPU+zcGNBPzEv3P9OsdC8HyGhg4kDoKL1vxoh3SIVFgLzTqkf0EuIu
         8AXp9vidgCQJyHZckA57xKCZrGKE0Yz9mLGV58OqsCCQbBTSvr8jC9c4qWrkjDho3Vt4
         YhAexpdfSJ9p1SWLrhpprQDM2LoPt0KafbknRhrNKj8ywgenVZ36/QVVZIb6ixKDB6S1
         wG0nOYnRdMAfWZj2o1awAZMQfu+xaTUc0cO774KJkIp/oWW1ur7GKz0mk06NgaTD8zP4
         /i3lUcTq3ttrbUU8DLvzMpmpOZOgXdnIPFL/cWhB4I5DM29LKimqzmSt0mq+FFbwcJKW
         cyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=v14VcMWCpMI9EAr+1tPnKmC3n5xnws8GNTWCzmKsRug=;
        b=WVmsLp32PctotTrcZOI2tkpe/TrNCQynYMXIXeAhlRT1j9982znmfh/Zs0weFCcQNx
         ukP+9IGwRiC4Ks7jQK91TB97Pdo0m2wHxqphBk0terClkX86x6mYx3b3VMoEFj4xqjuR
         D2QwyVEX9/FEw38OsvfJDgmm3doXJU4ibG13+Zy1ExvD0rtBeEE4fmqAHVkrHpCl2zot
         ezttVIHjCL4rwvudlwjp+komZc2n66hpiMz6paUwM2AH9hXIe9AMlWi5h6CI53jfuc9S
         OvAuYrv+NYmVoMS3gOcZSzsE7n3hk75dsYTLNkaY6Ervoiy9YlhwOk4u6nTMvabSQTRP
         yjRQ==
X-Gm-Message-State: ACrzQf3k6Bjl6x6XyXZGFLk5enEYFf1SIfsfifaF/g+eY68LDGFEPF3y
        Lk/LkbwuvXQAPgGzHc0Y6YYX7Q==
X-Google-Smtp-Source: AMsMyM7mONzSeI+/IkeSV1+W1JYGBirCWpTnzVqCzlkOIi4W5z5C/c5nH7kl/AoPDaTlWk9yra5+hA==
X-Received: by 2002:ac2:4c8e:0:b0:4a2:4745:a63d with SMTP id d14-20020ac24c8e000000b004a24745a63dmr591062lfl.605.1665087697349;
        Thu, 06 Oct 2022 13:21:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b3-20020a056512070300b004a2386b8ce8sm21100lfs.211.2022.10.06.13.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 13:21:37 -0700 (PDT)
Message-ID: <52d2b67a-5f5b-0c71-a455-f30b0b7afd57@linaro.org>
Date:   Thu, 6 Oct 2022 22:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/34] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM
 pinctrl schema warnings (5th set)
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <Yz75DAmjI1GbwQpI@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yz75DAmjI1GbwQpI@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 17:49, Stephan Gerhold wrote:
>>  .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 13 ++--
>>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml | 22 ++----
> 
> Just a random thought since you are already doing minor style cleanups
> here: Some of these files are named incorrectly, e.g. qcom,sm8450-pinctrl.yaml
> actually documents "qcom,sm8450-tlmm". I noticed this while adding
> qcom,msm8909-tlmm but I have to admit that it did not bother me enough
> to actually prepare a patch for this (and now it would just conflict
> with all your patches). :)
> 
> No need to change anything here, just thought I'd mention it.

Sure, I can change this as well. Thanks for sharing!

Best regards,
Krzysztof

