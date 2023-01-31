Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB1683655
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAaTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAaTUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:20:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98F599B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:20:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q10so15219250wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rO9xEG/bOZY4cntCd84nSns1hK9qjk1PYziJfq/4dVk=;
        b=QbtfJ9Ha9lzoJnEIfv2/ezR7wPbZ1BWSN2gUV2+GdrC4tnyq0VnF7ZwiuNd5t7haIY
         eYV388lsPF926Yo1sEgPtL3g8chTqIfHxBZd0B0nkBbs2ecCdXlZi+mCG8KPfGvg90pz
         ramdFFTUps1n0RMzyAtZ/hE9WwEm3veep+ozVW6+DG0Cr1FkhCNe+R3BFLN2pAvkEL+4
         XiI7/7zTi9MyMo/nVyUWtc++OJu46/vh8j0JXjltVSNi7IrmVAUJwHyqTfVMHRcyG7Pj
         Ipil3jceEXLE2+opB0OQhjEJVExF3EFA7fDHTzsX2bPxCSWXpmE4Dp+QO1/MPoh0gTHr
         Hrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rO9xEG/bOZY4cntCd84nSns1hK9qjk1PYziJfq/4dVk=;
        b=Df1oThaUKsEh9S+sZlRXr+E8+DZkgh30lzY4kLdBh7tZCpXATTyVz1YQmHv2cxyFOy
         Q8p/YhRVtT1ITJo5BEFK+QBrBrhdAKEUBiapnNESjJBAwyiGcq3oFz1nbdpwSq9BXAzc
         PkY3qBwYSwiytR/Vd1R5fPCJwi85NjUhTjrTWoBB4fndrjBat2NA8P3nEG/dp73OMLuM
         zVYE98otxAZbh47+bp7XoGQF3T92le+eCfZpJbsCa69ZjvsO9Bzw3hZMX9cRLqCBN+M0
         L+ESQSjO4s52VgNSULFC/RcZ7N0kzfEfpRyabfEV0WwXOMq/P9wWGQXnix9QWvoiEGXm
         RxAg==
X-Gm-Message-State: AO0yUKXDOBz/0X06u1BqkrErAl9Gbbz6Gr0ZZ/zoTOTRVbsqr0S52339
        JfCRQQIZDvkkGXQiaxw98ou2lw==
X-Google-Smtp-Source: AK7set8ADBTVfpachmf5xkFo7QhRIxXekiyZNrp0kIaeTqdI3Y+sezADMRk2NRE4tAQ9oe3HoojItA==
X-Received: by 2002:a5d:64e6:0:b0:2bf:da34:2b37 with SMTP id g6-20020a5d64e6000000b002bfda342b37mr195874wri.3.1675192847526;
        Tue, 31 Jan 2023 11:20:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm15600252wrx.115.2023.01.31.11.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:20:46 -0800 (PST)
Message-ID: <0551b34f-5c69-528a-5e26-482e697c793f@linaro.org>
Date:   Tue, 31 Jan 2023 20:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-sa8775p compatible
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230130130756.144160-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130130756.144160-1-brgl@bgdev.pl>
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

On 30/01/2023 14:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the sa8775p platform's KPSS watchdog.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

