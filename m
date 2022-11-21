Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981BF631C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiKUJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKUJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:16:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024248EB62
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:15:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a29so17825534lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ED+4pFnm4r1myo082q8s2RiXAUBBce2NzIjaMvHPOhY=;
        b=Yc60WvrnfhC71Z0ceHwo7MLEzxAaEGTK56NppJPGtPRVUVY6yJYDGrpvow+iv5BHbI
         EMnrppKfMi7mQxlyQa6guhd3d7GYOmQThaL0OA9owIQZdkztw5RPWFx05/y0yYk1XDEY
         eAj9RXFVZm+7LOQG3XwJ+NouoFQ4/De27BRN+LTqG9TPHEqtkM+L//CfXnFdEHTZhw+k
         nP1AhnL3G++x9Eefzl++PemM5vWk+CQzQQCMo1rCYwGRMYWS1PhD7R1ugtJE93btXQui
         tOv8x0lVu/pCfseg43fKdU9YtN8sypOc/U/2/zd3OOakZ2qsFsPKvAvQF+LaA7WZDmUP
         Ckhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ED+4pFnm4r1myo082q8s2RiXAUBBce2NzIjaMvHPOhY=;
        b=pSJ9eYeF5qVBMbcD78JSRFBJ3ucJuQkCJN0WsLwAFu+SVjKmeWbbTr2n1R8e5Z9pb6
         vZTsJAuaG0ErO6HzMhv/SmuHCDO4Aj0iklKLw+5yWFx+Bytwi2gNegw75WLvit2Mpptc
         bsycE95YCXMHvxeFFGpLVma2e51EqDuplE8D4I6pUQlQ2S0QOmITdjdL2FPGYF4NbHA+
         cBM5mG9jJ0XwFLximiPXZ7JFyY+BZHxq8jSZvABfPzF82yGPWkhqYa3jOzoECZ9bilMy
         SNKZu4WjFhQVV/TeOsmW1IEZp23WJH3r/vQaEJx3ShB/Ijg4FtXiokjaADyvECsCQTN0
         MLLA==
X-Gm-Message-State: ANoB5pnMm0sb4PO7Z16kSTJ/Tv8EK6ifpb7n2GME8bJ37XamYqLlptbB
        qyiF3x1vx9vMIg67WkhBs4RCbg==
X-Google-Smtp-Source: AA0mqf4gL4Cl+NTvzZBmZRmEDhKwxEG0X+kqBBvlCBNMKG5gCBdruiqYFv0LFRCqtQ5V2uKYDDmomw==
X-Received: by 2002:a05:6512:49a:b0:4aa:da5d:dfd8 with SMTP id v26-20020a056512049a00b004aada5ddfd8mr6247739lfq.677.1669022154330;
        Mon, 21 Nov 2022 01:15:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m13-20020a056512014d00b0048ad4c718f3sm1947324lfo.30.2022.11.21.01.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:15:53 -0800 (PST)
Message-ID: <640b934d-75f7-9ca4-d6bb-ebc792fa97d5@linaro.org>
Date:   Mon, 21 Nov 2022 10:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/5] dt-bindings: vendor-prefixes: Add GPLUS
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221119202316.93142-1-linmengbo0689@protonmail.com>
 <20221119202618.93451-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221119202618.93451-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 21:27, Lin, Meng-Bo wrote:
> Add vendor prefix for GPLUS.
> https://www.gplus.com.tw
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

