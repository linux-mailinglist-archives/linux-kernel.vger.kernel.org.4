Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69C6E5A06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDRHFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjDRHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:04:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B40173F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:04:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so18582113ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681801494; x=1684393494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WhHYJYuhXskgCt8P+rWi6MuOTcoPNUz8qBRPdqCUvo=;
        b=kfEJdGpu4mcY9/ND1iACqI3ApTNBoJQgxiYe4R8Bt0ggC5waO4AOTmqsksRsiIl69z
         WkOmFKzjWW+M6QEnLPLY5GPtfwclJVQQEGpwIicK0i29UWm3KUF8w7dYqnaBehQSWfBO
         rcczfJ7SUQ7LxoiNsWQ+4X0LwnztqHRN9JuQeZsEpk7IeEYDfwWgouW7GLL9+MEV0kZj
         VE122snZI2xMLFfHPNZcSVOoh3qlJ4+JN7QziFK6eWCw+SU/7yUnWDni7yyv+6XnxwMk
         tltoMjBhRmOndobU5tChMPE7XsKLnjR+odVvpt1vuR9GQ1rSX/b6vL2TXFiPSe0omv5q
         NsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801494; x=1684393494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WhHYJYuhXskgCt8P+rWi6MuOTcoPNUz8qBRPdqCUvo=;
        b=OeeWtGgSHm2Sslnw3iA/NLk5bHqwh3cPBZPHGitdc4B4DgFTZZKIuG9uVz9TcaM7u2
         +9HtVs4M62oLURngeU56/uNxH265nmV3WurbKCs/Bh/vFkW4fhkSrEBQAbWFdMn4/SUh
         NYhq8TTzJmHTH8cwvK+Mx+MPIWYLrDJvYuvEDYzXa6UtIu4hBuzld1siEq+vQilKaOp8
         4zl9Su5BhYJ5xQ9vRq3bhRAjTsFbkuwmvBld3DZ0NtLROhY8n2xyGLoBA2dJdbuCM7H2
         sjWDqoRkGFt6zeTZ3sE27DKIn95tNtFFQCt5jVCBXFjpAiI91tvcjJYxHF3T1uHW0JLC
         BltA==
X-Gm-Message-State: AAQBX9cLLEGJyiTWKo5xTFWi8vETljtk82ccKVJHTL7lifAGDkTRbUt+
        vhIkwnc8q86hc+ULH+0q1wYN8Q==
X-Google-Smtp-Source: AKy350bvvxWv0MaXOCX/mRjN7rgY+3X62SrGNyVxmEt7DdeR0qfPOUZz9zMNRmA6wBR9oNJjW7Xbtg==
X-Received: by 2002:a17:907:1701:b0:933:3a22:8513 with SMTP id le1-20020a170907170100b009333a228513mr11209930ejc.53.1681801494526;
        Tue, 18 Apr 2023 00:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id gb32-20020a170907962000b0094f34fe27c6sm4122421ejc.170.2023.04.18.00.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:04:54 -0700 (PDT)
Message-ID: <6d24511a-69dd-e99c-09d2-53cc3e80bd5e@linaro.org>
Date:   Tue, 18 Apr 2023 09:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
 <20230413131705.3073911-2-brgl@bgdev.pl>
 <3e361a73-797f-41c7-1ead-ecafee3928e4@linaro.org>
 <792e1f22-c3eb-80c7-0600-b478b3764f7c@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <792e1f22-c3eb-80c7-0600-b478b3764f7c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 06:39, Shazad Hussain wrote:
> 
> 
> On 4/13/2023 9:42 PM, Krzysztof Kozlowski wrote:
>> On 13/04/2023 15:17, Bartosz Golaszewski wrote:
>>> From: Parikshit Pareek <quic_ppareek@quicinc.com>
>>>
>>> Remove the power on reasons with reboot from the pmm8654au_0_pon.
>>> Instead, the PoN reaons should be part of different sdam_0 mode, to
>>
>> typo: reasons
>>
>>> be interoduced.
>>
>> introduced
>>
>> Anyway it does not say why. Are these power reasons not correct?
>>
> 
> Hi Krzysztof,
> Since sm8350 the PMIC PON peripheral was split into PON_HLOS and PON_PBS
> to avoid security concerns with HLOS APPS being able to trigger a PMIC
> WARM_RESET unilaterally. When the split occurred, the spare registers
> ended up in PON_PBS, not PON_HLOS. Thus at that time, we moved to using
> an SDAM register for Linux “reboot reason” configuration. And bootloader
> also SDAM register to get these reboot region data to get into
> bootloader/edl, so to have this working we need to use SDAM.

The explanation of their correctness should be in commit msg.

Best regards,
Krzysztof

