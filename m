Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF25E9D11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiIZJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbiIZJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:12:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A93BC7C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:12:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a3so9788236lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gXp2XSFH9nI+TRzva2yyooESgDMFmA40A1Xccpwvptw=;
        b=baUe6JLWI1qiy0Xdq5523JgbDa+cLR2vle1cV8NxAxeM4NaKPOTQUeKpQyZyayVtPh
         M8OLpSaLh/R4trMInu4ZLLVq2alr+gVCejO1ckCPYch+vGYCKEdOx2SnK+xF9OvsrmAO
         EycZ4sCjgCqgwDk/rq4PHmgiAJcOWo2MnyWZrCI/g9mY8c78Vay3y04eyWnvtGXXpNgb
         MkaSONwarsDkey0gHd7KPHlF1EryAXQsRU+2qZ+Q8sSSOOM01c4kHgo8usmSAU7PuRZL
         KqRhQxVHlXuE+/AKE3gJhkpMcQ60QzgcVzSXoaYlkYNyfPImZQad0TFstozUN4tSdJNZ
         hKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gXp2XSFH9nI+TRzva2yyooESgDMFmA40A1Xccpwvptw=;
        b=gmyCdR3Y45f9Z0JpNFQ9lEqxtZvL8tXxoeKeHcQTYOPx+XpBuRa92fn1NwJGd+NB0l
         CAttVTdXWf5U6StoO7VbxMCMeYII7LPVax+VbJ9HNvqpa9NSallu0IkYVRM9bo6BVe0P
         /0YdNUVQPyyVNjA7BoM5NFxaxZOIYu5CwebcOO5xh1ThV2YSBYMS03h/nC6iPZqfZ1Ye
         mXzv1QYrrSDnokPEeYYwkvGU/5cUsxQyvCmXsVElgWhmg39GH3z6UWhRA4HQlWMZktbX
         cWsAMQ3AQaU433xQuZ2pfaMmN+yXuNhszBjZEHZ6BYqrXK+U3GzSIkcZznNglp9ZTFQr
         ggNg==
X-Gm-Message-State: ACrzQf0in2IEwIuwnzvkBVHUOs4C52Bk0wtpdLdzgR93VCwQ0+6AUoFb
        gxaDquNvrEkvBsfmZqAOidlLQw==
X-Google-Smtp-Source: AMsMyM7HYKJgJ/yyEvcDGpDqSPODIPQAfJaDArBSJKXj2rgebLpNJMi7oFCggfT5ONZRsJ35uB3WnQ==
X-Received: by 2002:a05:6512:2621:b0:47f:d228:bdeb with SMTP id bt33-20020a056512262100b0047fd228bdebmr7818540lfb.121.1664183541673;
        Mon, 26 Sep 2022 02:12:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t3-20020a056512208300b00492e16b7ab3sm2481634lfr.94.2022.09.26.02.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 02:12:21 -0700 (PDT)
Message-ID: <7996c93c-b74b-2e28-7f64-10001ba17326@linaro.org>
Date:   Mon, 26 Sep 2022 11:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: pm8226: fix regulators node name
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925210229.128462-1-luca@z3ntu.xyz>
 <bc5983fd-7d5d-427e-e9d2-a800dee0dc3c@linaro.org>
In-Reply-To: <bc5983fd-7d5d-427e-e9d2-a800dee0dc3c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 11:05, Krzysztof Kozlowski wrote:
> On 25/09/2022 23:02, Luca Weiss wrote:
>> Adjust the node name to match bindings and fix the validation warning.
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>>  arch/arm/boot/dts/qcom-pm8226.dtsi | 2 +-
> 
> Thanks, I missed it in my last cleanups.

No, this should be rather squashed with my cleanups:
https://lore.kernel.org/all/20220901093401.134473-3-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

