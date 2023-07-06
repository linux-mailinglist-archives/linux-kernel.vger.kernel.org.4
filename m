Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F074A05C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjGFPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjGFPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:04:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0284E72
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:04:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba86f069bso1178405e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688655888; x=1691247888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzZTyQELvGdSpy14DjgPG2NP0SwpZgrcG5XHyVclktw=;
        b=OJiYE1tYvQpLRZ3LgBXqd3ZQc5ozlNXS+iQmPuTMCk6Q0089mAjnRX0dtGb/vYM8Mv
         r5vs9exCfKRzdNXfhDLp9QC46MfMJJJfVBl00C0y6rRk+0MMAoesGrMDBkGquQRI+XuC
         P22ILenBEDCBNFML4t84/4OVf1mLbCfabCYA8Nnoc8Ou+k65kGEW8Hlxuo+1QnYNmQAY
         7gRma7t9ud7rCNMrcPYAAtlr24u/SrUWaFeyEXJi3GOpSQL4kqC9oI71LldHVY2B4yBI
         VvVKX9ccy9co0YwRhzH3ysF9FMUnY1NPh/ySZZ6z1ktYGYX1cefSrV92DAWH9fLkhDHl
         XuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655888; x=1691247888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzZTyQELvGdSpy14DjgPG2NP0SwpZgrcG5XHyVclktw=;
        b=cNJb2rjVcPjD86Rf/rJMXbgAQXrewxMxD99+mUUyKhYmLUx0PsVW8pxhY7E7hXlYXs
         Hcytwt4Sk2CCzrxaVJPa9dfufN+3pHMXMUKw54ywBxsmOyU+ahOHKfghKPWlWTmrNY6C
         vJe9oNSYK/yCyimNk3RiMbwwG9CCFf7ptXealVzy0ekukXjP8V+TRXZxxjKfQ3a9GWl3
         UqyCoeTb00626/udZwDU2EE2r3kD1g6aAQ57HtaGgRGERRqzXVOUkqJRJPJXJTSmYqWN
         OFrQ5/x8jO1DwVQasTWSaXi8MBZ6hnp96rnSKCrqtXdJ1ZyfdMAqtFfO9RpJd5dr7CVN
         JElQ==
X-Gm-Message-State: ABy/qLa1/zusU7fMdLC6+bSfgbfpg/w6UmFFj91693zEZL6GxfCqbB05
        KaHGokp4WDuGjmwRevo9HlJv7Q==
X-Google-Smtp-Source: APBJJlElgxRkPN5QzPUVZWv6e/fSrondYtiwpKf0EPdL3rk5bBFL9gyftPTepDnTxTqwlaQlVUUAeg==
X-Received: by 2002:a05:6512:3ba6:b0:4f8:7772:3dfd with SMTP id g38-20020a0565123ba600b004f877723dfdmr2062849lfv.11.1688655887869;
        Thu, 06 Jul 2023 08:04:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y16-20020ac24e70000000b004f87893ce21sm295344lfs.3.2023.07.06.08.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:04:47 -0700 (PDT)
Message-ID: <8b04d830-4710-7f26-09e8-326b69d72396@linaro.org>
Date:   Thu, 6 Jul 2023 17:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688650209-25119-2-git-send-email-quic_rohiagar@quicinc.com>
 <4042fa22-8948-49c9-6e5c-dc8926ed5f99@linaro.org>
 <6d067262-d8af-f6f3-4ef7-870eafa15f46@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6d067262-d8af-f6f3-4ef7-870eafa15f46@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 16:45, Rohit Agarwal wrote:
> 
> On 7/6/2023 8:05 PM, Krzysztof Kozlowski wrote:
>> On 06/07/2023 15:30, Rohit Agarwal wrote:
>>> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
>>> binding.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>> I doubt that all your patches here and other patchsets are v1. Otherwise
>> how did you get my Acks and Rbs? Please use proper versioning and
>> provide changelog.
>>
>> What changed here?
> 
> Actually this is part of the original bigger series [1] that as per Bjorn's suggestion need to be broken
> down according to the subsystem/maintainer.
> Since it got broken down into multiple smaller series, I didnt include the versioning.
All of that information should be included in the cover letter, to
limit confusion both for maintainers and patch workflow tools.

Since these patches all come from a separate series, it would be
good for you to version this one as v(BIG_SERIES_REVISION)+1 because
they've already been on LKML at least once. That would especially hold
true if this revision included any changes.

Konrad
> 
> [1] https://lore.kernel.org/all/9de424ca-271a-8ed2-5550-658a828c4ea5@quicinc.com/
> 
>>
>> Best regards,
>> Krzysztof
>>
