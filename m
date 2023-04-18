Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEE6E5DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDRJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:44:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A21729
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:44:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso19000931fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681811038; x=1684403038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2LMbqz6wH8w60oclmV6uXVVb8iyR/SHLVOrQfQu5n4=;
        b=wG+IKMn0J81Q85iLIDHTC0YAFhqDdS8tsiOF75ljf6BHnjZsDbafzV3nSJXp0PC56O
         hpDuwbm2sJgSBouOkRHbvM7xfqxRMm0k3GiVipJa9QK7QUG5Rt+0gV226P/QtO/oOuu0
         22JEwj0Eh8tCPdc8LAMh1MeCYYmAVWDRhahWTR/SWJCvHRfI7pwu5MP43pQxqkBs4l0k
         4SWXa8GLepongw7rSaoLtbiINSDxQnztcS3l7z8CusPC1q9q/SVzibU7lSb6DkKpCK96
         2+QFKROWuG+aMTSrYv2OGZAIIOSwutcTTWldBKLJ/eDDnnxd58e7sqFj1AFdmqWF5uw4
         nbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681811038; x=1684403038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2LMbqz6wH8w60oclmV6uXVVb8iyR/SHLVOrQfQu5n4=;
        b=ihF7JOQBW+QcMAUjZHZ8RI0b2Usn/jDhDSZG1uI3ktkNaxbhWP8xy4gdXYk2lXeCSs
         HuxwxVOjwtStveilhey8NR59bTDin+i4IGkhofcJam6pw19Uw/3NBhaQSVx5iPp2E4Y9
         PEMiAkY+ai3BO6axKhEP4cTY1eJiWKhD082pVVa/LK3PONwjDUPlXvbl3EocsTL/RvZR
         NV7/nOVLsy7hBrMnyErASTTNw+dEhVPzWtwRYD/7vrrG9A47882fhkUe2vORIa36z54q
         C8nSFGakKD/8lavrmmvVB2g3ddvutzR8LzeKdSSezK0F3ZbYrmq8nWfKdtkdTbJpKhHC
         cCCA==
X-Gm-Message-State: AAQBX9cEv8bDbNrrNBjxvJBgsiNpbdMlPHSL8iBz88ZvelOlTAH5WRV3
        YA1z0MRgFegFk6Rzv1sq4PstPA==
X-Google-Smtp-Source: AKy350bMMt96DgjDZhelJgwdeH91GqmXc2epqbLnaBdJ6rmoJqtReem1n9MIx8T5neOs4RY5uDia5Q==
X-Received: by 2002:ac2:5ec2:0:b0:4ed:b9b6:fc46 with SMTP id d2-20020ac25ec2000000b004edb9b6fc46mr2509904lfq.41.1681811038405;
        Tue, 18 Apr 2023 02:43:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id n3-20020ac242c3000000b004eb09081d77sm2319615lfl.91.2023.04.18.02.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:43:58 -0700 (PDT)
Message-ID: <a17c21b7-9c0a-2458-735c-ac3b16ed337f@linaro.org>
Date:   Tue, 18 Apr 2023 11:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: pmic: remove the PON modes
Content-Language: en-US
To:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <792e1f22-c3eb-80c7-0600-b478b3764f7c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 06:39, Shazad Hussain wrote:
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
> 
Does that imply all PMICs following the PMK8350 scheme (separate HLOS and
PBS) should direct reboot mode writes to SDAM?

Konrad
>>>
>>> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>
>> Best regards,
>> Krzysztof
>>
> 
> -Shazad
