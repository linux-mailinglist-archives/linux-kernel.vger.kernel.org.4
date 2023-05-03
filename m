Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03DC6F6024
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjECUhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjECUhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:37:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFD6E95
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:37:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f315735514so39932295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683146253; x=1685738253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg8Ct+w2MDSoMdUqUQHFAAraG1RpJh11C6Vi9b5JEbI=;
        b=A/r9bnz32AcAuY9RxBWTrKfy5MmAarE543F5s7pE57UxnVvBV5lDzvroYBT1aVoa0m
         kl9XzrqnL61onFNK0R3vzF6/iTNH0P15wk7VfNTFaC/W52FBAJqMl6ktTPGQi6JQpxxN
         dOXXVDpExxNowDuWvn13gjcxc9MGXcw6x8zBG7eaRHSVqH+sjVlNSykleKgOCkNfAW/e
         bkm/TJgmQkN79N3oTsuSzRN/1cTm/KSBasaa1Hr/1bQxXEM/ToIfAaXvFuRAh9oMWo8P
         AvYkDa1gha15tz6A9wUaLASPIDC0/muAGC+o6o5fzgKl8TlPfxa0kUvEwezvbdZVDadf
         MuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146253; x=1685738253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zg8Ct+w2MDSoMdUqUQHFAAraG1RpJh11C6Vi9b5JEbI=;
        b=Cr/66xOXZpmscovQ0bGV8/OlLCiOatcEf3iuAWSzZ/4ySF8VaFzX29L41hLkfdnAX8
         ewm0hXDWq6vTna5VsyTtOWiidVmHckgxEc2XQ666ieo+A6zmQrTboQoZg2Pz4gs9fJQX
         YT1U4yVzZz/Nnac3eF7xR2TDC0R28DeT0TrcwXMD7SjE8xD9RY7wwDszSRHjkzOZnQFk
         aBcph0AIdlY/7LMRN06tcIzUJwup2SPAuM1Rj0a3m9p9iXO/gECXGO/d+RWLeC4epIXQ
         eljkqiow6Fsn5hwtz4kcz6UgaiIi++F4kiKTS9k+AoLb46UP+u1wZ1aeC+d3JpLUsfcH
         Dhbw==
X-Gm-Message-State: AC+VfDxQcXEnb4OOTnZbA63slbk89AUy276Hli85r7ljCOC9OIqUJ1zO
        JyKZqR4SmIq5wdjo/T7J32jRwQ==
X-Google-Smtp-Source: ACHHUZ48XOLx59K75gywAU2ORGIJyOLheg4445dpEi80FdfCXFGfwKXjCU7OUB3x0e9V+xUZyyGD5A==
X-Received: by 2002:a5d:6dc3:0:b0:306:31a5:75a5 with SMTP id d3-20020a5d6dc3000000b0030631a575a5mr704512wrz.8.1683146252869;
        Wed, 03 May 2023 13:37:32 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6607000000b003063176ef09sm7736899wru.6.2023.05.03.13.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 13:37:32 -0700 (PDT)
Message-ID: <a7387c64-5ede-6e7c-dafb-95630b550645@linaro.org>
Date:   Wed, 3 May 2023 21:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add
 ports and orientation-switch
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-2-quic_bjorande@quicinc.com>
 <CAJB8c06H+3pxoUGXWOXyCgtbOj6y0OhSxb9dvoTo1b6iChy7ng@mail.gmail.com>
 <20230427195232.GB870858@hu-bjorande-lv.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230427195232.GB870858@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 20:52, Bjorn Andersson wrote:
> Do you have a concern with keeping it around in the DT (the
> implementation doesn't need to care)?

Nope, its fine with me.
