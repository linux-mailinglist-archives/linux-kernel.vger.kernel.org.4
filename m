Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34106673649
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjASLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjASLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:02:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136D717AC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:02:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so981166wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7Ol9rCnAF6ffZkBYSXfSkjpYt9CnOA8DDizD+B55mg=;
        b=xhposcoNRVB17HSEkoO5zs6qYUDvnLF1ZUp3KgXmo8A5auoaWs/Sp5WrEPNVqsxeWw
         jHpIreNyjNchvUaI9Nt9OBDlmWGqrvehsIFM5BAhoWhdPiHAnGqXSf/yvAgFOTlklDgy
         yhZMl2UgAeasQOSqBve8wHI7PxoixMFegpR4ooUllZ7BbTSFq0SoeS/9h/XzYUZ5EwG/
         clPaYvteI91zU8ReX/8+HbU6soI5X5FXLXynDKxE8QsEoetLm+bafXiuSrdq8HNHbcKV
         3Hqo3HOKy+TlNEhre2i9kWteefPJPV22VFheGoIEjxXTZTclSKw4EZW0h0a3ublCC0dR
         kQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7Ol9rCnAF6ffZkBYSXfSkjpYt9CnOA8DDizD+B55mg=;
        b=ce9+AUdvWVaP1fFb+5tuxBq2wQWOff48sZSzn6rpqeL27/6+e89OOrHJNdlo/Y+Y2e
         OFBM2N2kEPmgCwcNx+KSfEbvrLhbEFoPGv6797fQEYMsuZXYiP2E/9V0UiGw4nxjY3nl
         M1OCjfRg4EWFaFecHjeKXavHaoEJqs3CFDsI8wfFwlr702MnWYWGDZd8YUkTttnDHyw8
         0ghqpGcEkyf98TLRmJxrz2xEHCk7ta6+VEg0fmrY76YLTbAqUaZeMD1tXw8nu9iBDKRu
         dNgdkF90bfOdXbbK4Eea0Ayzp4XBgTNZLFPGdj7bNRknJ00wzRR4UhQvXi1L1bgJNPL0
         PaBw==
X-Gm-Message-State: AFqh2krgLmL1FPS1ZJ2Od+7oLCTp/T4bo/5TJJkDzbP1mHePOHW1Q9fg
        vEg4oCNs++/XJRiMRfpppFUZdg==
X-Google-Smtp-Source: AMrXdXsf3DKYNRwt8johbJXv5bxiD05FcOvIFuFYCF4OLTetYrtvDkBiKe7eAW6er3JVsd15i4Fyfw==
X-Received: by 2002:a05:600c:1d85:b0:3db:1bc5:bbe7 with SMTP id p5-20020a05600c1d8500b003db1bc5bbe7mr3408010wms.0.1674126124501;
        Thu, 19 Jan 2023 03:02:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm6886636wms.2.2023.01.19.03.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:02:04 -0800 (PST)
Message-ID: <93ddf52a-2356-926e-0aa2-48d60d9f1a8e@linaro.org>
Date:   Thu, 19 Jan 2023 12:02:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: fixup SDHCI interconnect
 arguments
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119105434.51635-1-krzysztof.kozlowski@linaro.org>
 <c2dbe186-f338-5b76-b263-4c83c205089e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c2dbe186-f338-5b76-b263-4c83c205089e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 11:59, Konrad Dybcio wrote:
> 
> 
> On 19.01.2023 11:54, Krzysztof Kozlowski wrote:
>> After switching interconnects to 2 cells, the SDHCI interconnects need
>> to get one more argument.
>>
>> Fixes: 4f287e31ff5f ("arm64: dts: qcom: sm8350: Use 2 interconnect cells")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> I think it may be worth including
> 
> include/dt-bindings/interconnect/qcom,icc.h
> 
> to get QCOM_ICC_TAG_ALWAYS (which is the default
> one set when the tag is 0) which is more telling..

This should be done in fixed commit 4f287e31ff5f, not here. I am just
finishing that change.

> 
> But for the change, of course:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Sure.

Best regards,
Krzysztof

