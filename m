Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAF640231
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiLBIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiLBIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:32:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B3C0568
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:30:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so560482lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRzGhbLWq/EVeiZHGstPvpADlY6Gw7yqGMWIECivDNo=;
        b=xoj8AZ6d1kfLfbrh/1nP+oAlaN/s8oPmYwYT/hB6egk/w+lJdPUxsqJ46XJM3kbu0v
         WNUMr6WXob3ixTtB51PWsOXZzSlyrJcZLyRzbcgZi78Y1oJwINnDLMJM4a2ueJBeKMuK
         CyVOsxw/RuNXwGigC3yJ2I7cBnky9KWiIXQJw3IWO1Z+mXd2PsMZtANOSftFTuhJvKv6
         cE+CMjZzK4Fice7ltOPWuQshHPwSPh6MvI7X3NPzrj2Kv0mh/ji2pFO/HwpUPwvSTNZP
         SBSeEph/wNbB/wspk+QfqCy5GVMHP8NQ4JoQl0gKzql0icb+jMFLtHd+S0MY0fBxkzmh
         LT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRzGhbLWq/EVeiZHGstPvpADlY6Gw7yqGMWIECivDNo=;
        b=IG+BjzjqmiGR+a9UIFunP60lQ73zSUvuSe9qOMsMCi/rWleq2OxK53Wyr7Sr23gjD8
         4CmaS6zZGjBVbxyLjEpnU4WGCnmoW1resuE9STx04EW+j7fCBRo8M+Xqh0Bg8AbVT5bq
         7rTbrpKZ+95/iO7ibeRuFkp2PsN47bZRFq8JdQKkg0Owe2SuOKm7x6v5Mg+zRev7ybUn
         nIFJU8gkI5y2wZliValHKkiMfKcHk12pTSJSewmddYbeSIMQhML+6IAIFuKzXBls2aFt
         bJHmIUvtZCXFit+EuM4tbxmziF+Q89SivYCll9WDIpzQbpBpd2kAcRnBEvvGw1jVwCbZ
         MSgw==
X-Gm-Message-State: ANoB5pnZLbK4Phlk38ikx5qL7jtQnrersdeWg+zoByqHLYlm6D8jppkh
        yCxZ0jqZn7ZORdKJWeuo63YrTg==
X-Google-Smtp-Source: AA0mqf5cRBXi+/1IoddLYtVQ1uiytPbiTqxIIwwNl5HC3xS8mRSFxfzJjaxjqWgC+iIbow0ml/Z0Bg==
X-Received: by 2002:ac2:51a2:0:b0:4b5:3d3:224d with SMTP id f2-20020ac251a2000000b004b503d3224dmr11000207lfk.69.1669969833654;
        Fri, 02 Dec 2022 00:30:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k26-20020ac2457a000000b0049462af8614sm941669lfm.145.2022.12.02.00.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 00:30:32 -0800 (PST)
Message-ID: <bdfb93b6-76de-e047-abeb-b36f79ee8f23@linaro.org>
Date:   Fri, 2 Dec 2022 09:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] leds: qcom,pm8058-led: Convert to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221201131505.42292-1-krzysztof.kozlowski@linaro.org>
 <20221202000858.GA1737135-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202000858.GA1737135-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 01:08, Rob Herring wrote:
> On Thu, Dec 01, 2022 at 02:15:05PM +0100, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm PM8058 PMIC LED bindings to DT schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/leds/leds-pm8058.txt  | 67 -------------------
>>  .../bindings/leds/qcom,pm8058-led.yaml        | 57 ++++++++++++++++
>>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml  |  4 ++
>>  3 files changed, 61 insertions(+), 67 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
>>  create mode 100644 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Or should I apply it?

There will be conflicts with:
https://lore.kernel.org/all/20221201202144.448694-4-dmitry.baryshkov@linaro.org/

So both patches could go via same tree to avoid it.

Best regards,
Krzysztof

