Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E226014AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJQRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:22:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB071714
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:22:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z18so7807861qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQlsXPG+b/ivmTTpsGhpnAcJEtCBNzn8M5P3pvqQhSs=;
        b=dX5kUxlKjD7RhLO2sY7XEDAry/0JjXW+PYd8LJNyx6uFUBbEmjgG9ImOa5jTXzU4Jb
         W+Sy9+SEaBoObXZAWCSTIpbzXKODnyoYtWOW3O8/SK49D/uxYr0EhNGKN0c6G1bVivNd
         Wv4XGV75oHWfJbCYZwgzi7woEKN+yshKzzbbheqUflYj3s/Yty1s1WJnHWuJ6Rw9/j8K
         5taPt9RC9WhefbAO4L6Mgo3WfJyRtmJyIdCLPPRCr3EQpiRdi6JOlYQ52Q0lmiX8MXMo
         RWCNP3rtM7K0cXzdlGGB3745l2iJj+NwpCSkdfEjMEpQMPXnWUOyahUS458NOGo5pGoH
         lO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQlsXPG+b/ivmTTpsGhpnAcJEtCBNzn8M5P3pvqQhSs=;
        b=h04L5zIrIf6+O/ScCWpMzo9mjrWlcVWUaUnVQHj39C1BN6yYSUZq/D8l/rZVOPW48N
         OWctQp578MxhGmiXgKH0d1u8Rq+mnimCrGcbHcwYR5CTVD8tJ2lODPx/eQ8aQrhoPYo9
         bxeUJLx3SERk1WERhYP8ihWYMDPuKKwjQ8HQDpyaPwLFkUYhbjj5n96GqO1LSedkdXqf
         j5mGXYXMpTiAmYQu3djRqEdtEErA0a0uHKnWW3wh4EO7ojcQPe5DFYQnqdolS7oTxDiC
         4laf5gvZI7+5YptRpffCb0qFR4FFYqF2pUHsb+nHoz6TiWt8X0ho+oQ6CewYMzuMFXeq
         EaJw==
X-Gm-Message-State: ACrzQf19rN4ZnJdAYja7gUGYB1v+yjo5R0FcWREXyvl2x3JSCvkbZTYL
        ZJ2vtaKSn141DNSAvnYO3qnn3g==
X-Google-Smtp-Source: AMsMyM7F9zGFYDYD754st0ujJyV3rD1idxlFxOrrfeWDYWev/I49SdrGpCJUI2tnB/ugL8hZ8uw5iw==
X-Received: by 2002:a05:6214:21ab:b0:4b4:6dc:b94e with SMTP id t11-20020a05621421ab00b004b406dcb94emr8980096qvc.107.1666027351200;
        Mon, 17 Oct 2022 10:22:31 -0700 (PDT)
Received: from [10.101.5.247] ([148.59.24.28])
        by smtp.gmail.com with ESMTPSA id dm54-20020a05620a1d7600b006eeb185c209sm244330qkb.50.2022.10.17.10.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:22:30 -0700 (PDT)
Message-ID: <73651055-2a1b-75b9-3483-b180afa6f7bd@linaro.org>
Date:   Mon, 17 Oct 2022 13:22:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/5] arm64: dts: qcom: pmi8998: add rradc node
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20221016180330.1912214-1-caleb.connolly@linaro.org>
 <20221016180330.1912214-2-caleb.connolly@linaro.org>
 <5929051d-d2be-5b51-0cf9-294affa51df2@linaro.org>
 <1f6d8eb9-8e6e-a201-50c6-a9fa6f25b3d6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f6d8eb9-8e6e-a201-50c6-a9fa6f25b3d6@linaro.org>
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

On 17/10/2022 11:29, Caleb Connolly wrote:

>>> +		pmi8998_rradc: adc@4500 {
>>> +			compatible = "qcom,pmi8998-rradc";
>>> +			reg = <0x4500>;
>>> +			#io-channel-cells = <1>;
>>> +
>>> +			status = "disabled";
>>
>> Why disabling it? It does not need any external/board resources, so
>> maybe it should be just like other adcs - enabled by default? What does
>> it measure? What is its input?
> 
> The RRADC mostly reports values which only make sense on mobile devices, battery 
> ID and temperature, USB and DC input voltage/current as well as a (duplicate?) 
> die temperature of the PMIC - I guess closer to the SMB/FG block.
> 
> When I last tested the DC input readings didn't work on db845c, as it just 
> produces the 4.2v you'd get from a battery.

If it is connected to some line - e.g. to the battery - then it is
operational and there is no reason to disable it.


Best regards,
Krzysztof

