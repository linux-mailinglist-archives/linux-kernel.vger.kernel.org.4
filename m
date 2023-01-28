Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA35C67F6FC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjA1KN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjA1KNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:13:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7F34315
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:13:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y1so7059071wru.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJSBwK9SQa6K0RPspYHbr2bluY+Lrzx+sZgBeB8MRdA=;
        b=QSNZ34wfqD/7XqeSscaFiN7udGKWhiNxy6wbML1opwCgViHzPx0VA1vlHWdknoDPLm
         xX5l6PaBF6qML+K4qNLiMzANRsirRmMel61B5IQVmOl5/0j+LkQZ0VA82CQyI5aHkkdu
         7v0r86iXJMFpbJ9l5BHqfbS6yTZbpQLXRnWZjPwQoRrrlrwW2/zBmML9mUo6A3FRilGk
         ipWZqiyEmyvzueDgWBftlA6hR0PVuSTHG598QgkHg7ayazhJdH2k9+2W8Y75n4zO7j5s
         i6qvGskHGRonV8CvVN42fnxSyTsKk+wOi/tDWidMu5Tvllx8xebwAf2dtuJrFA4yAEuN
         5BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJSBwK9SQa6K0RPspYHbr2bluY+Lrzx+sZgBeB8MRdA=;
        b=Xwj3b24ZFoyJC7vb8ZZMndlKxoAcrCShQ1pWCBule1MC0r86oSq1mOwTlTFhMeq/LG
         WmV2RRKh7liXkfFOdSmAo25+Paq1DeRV1RJYd2lZ8h46e5DKdoB0hpbGtI1RwVOqb86s
         Eqc75x0y0zxwXk0FGkcpI1oozH/G0Z2RR+n0n2BKDbATiaSJoksCd2nvCyA5nogSZQoZ
         9ReQPk+arIkKIN4ECUGi5dOiopSFVq5kpYfEp9aez+2WkfoK2VeVVeWb16iwVExNGGr3
         dVwuX50XQlPm6aL3FrbXAszQm+v/NAlnCyhaT0k2uPirxz/GtZ/ej9nHSQn2pHnFmPhb
         zEXA==
X-Gm-Message-State: AFqh2kpFhtcZlgqSB9fMLt8KxgPuqS1UDAkLNN9q+ke1sH1v8kM8B6jF
        qHmilqVY0A8ZPGyuBdyETQjG2g==
X-Google-Smtp-Source: AMrXdXsEsui23EcTaW38Hgx2ZxQHGHuFvmOaNKhJCO4MCes4OTMpw8f/rv8of8xPhN9r7wZJKJH0Kw==
X-Received: by 2002:adf:f2cb:0:b0:2be:4fbe:42e1 with SMTP id d11-20020adff2cb000000b002be4fbe42e1mr30334593wrp.5.1674900827581;
        Sat, 28 Jan 2023 02:13:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x13-20020adfdccd000000b002bbddb89c71sm6228624wrm.67.2023.01.28.02.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:13:47 -0800 (PST)
Message-ID: <8dba267b-62b4-1085-c307-3d2608ae5857@linaro.org>
Date:   Sat, 28 Jan 2023 11:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p
 compatible
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127192139.299228-1-brgl@bgdev.pl>
 <52508584-47c5-2497-68c8-2c0044911aca@linaro.org>
 <CACMJSevqcaqjLQJ6_5Xn=hMbrsjdxGVM=9RYwYQ8hW_Uy-tRzA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSevqcaqjLQJ6_5Xn=hMbrsjdxGVM=9RYwYQ8hW_Uy-tRzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 22:22, Bartosz Golaszewski wrote:
> On Fri, 27 Jan 2023 at 20:56, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/01/2023 20:21, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add a compatible for the sa8775p platform's Secure Channel Manager
>>> firmware interface.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> If you send bindings separately from DTS (which is fine), please provide
>> the link to the user - either DTS or driver for this compatible. Driver
>> does not use it, thus to the DTS.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> 
> Can you specify what kind of link you're expecting? I'm looking at
> previous commits for this file and not seeing anything. There's no
> upstream user of this compatible in any DTS yet.


I expect lore link to the patchset you sent using this binding, so we
can verify whether you used it correctly or not. If people were testing
their DTS against bindings they write, this would not be needed.
Unfortunately people do not do that...

Best regards,
Krzysztof

