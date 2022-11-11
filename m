Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90B625DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiKKPIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiKKPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:06:50 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DDDFFB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:04:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id l12so8711716lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/YFrV1kBf6OoJ9QJHaOI7UgluOwxEfvultD35diTm0=;
        b=PYNKGCcRwQ8JKNIomECqNjJ9PlAmuq456EbaMTmZWnukeCv4vl3tndCOw3x/RNGSRE
         S1X6aeimbGv09WOC0u9oucVvdm4iA/oEwZGLq3rhQ8QWGI3YajEgPCb+ocLVJg5klyBo
         8jmbR0pGtSbvGj4BSzmtJhYdGx8ASX+2WsX394eF6w/svSuwSYxugj9Ada+iseq1TnSX
         JA04y1CGv90YfxqWb2RlrIdjNXgM5OsEKxief9+sJymvE0HCHy+dzATb47uZOjS/IPnc
         nX/Of9wQiVoJBqEvtU7ArNZmbwPqB78NJcHpcZoF1gGpAwTLFRUGM/dSXL87EmitP8jo
         Fv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/YFrV1kBf6OoJ9QJHaOI7UgluOwxEfvultD35diTm0=;
        b=Yi9KiMcPD+x1DcaK4mRY3rAjxhrsRZKtRkDlfKBja7yWpP+InIWnHmQcXllZJtBVF2
         QLOHC94aRP4DLgckXHetH6vAkoTcB3LfuCX4z1YlEpX6/l9mRcYNUOz83C6ARZ6gadw2
         LeMgnuEp8O8qUub+5FlMFY4mJh2c1a0wEWmNFNn25JCqQOFE3rBGZ3d1CfaVo0oDudi3
         RM/9mRsLjeDx7RxrXzzRXbGn1MhXleynFL61no/eR+O/QqvYiIREtOxRBL4QsZ/JfgYm
         hrD9DAqiKlzZvCCOb0Q+k9H9Try/NqSq3ofZ3cEouBtUjVRlT2jToMhlRfKrOpMgMou8
         /DPQ==
X-Gm-Message-State: ANoB5pl1WKLV4wk5lTQXEVr0pLclcCXJB3g4cw0Bd5BOdmVppOzlJtW1
        ahdXIRJK0pP+iL0E1AFZvLNeRjkT4U1B+Q==
X-Google-Smtp-Source: AA0mqf6lPmNns9AWE0FT4psuTPCk4ijDCUFKxDS7b3YszsK7Cs93QLl9bRkYM/PahH7eKyYVw6r3cw==
X-Received: by 2002:a05:6512:2305:b0:4b1:8698:9f3e with SMTP id o5-20020a056512230500b004b186989f3emr807725lfu.421.1668179076505;
        Fri, 11 Nov 2022 07:04:36 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a22-20020a056512201600b004b48cc444ccsm243090lfb.100.2022.11.11.07.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:04:35 -0800 (PST)
Message-ID: <e84ab69b-dea8-f201-219e-78cc1ef29a94@linaro.org>
Date:   Fri, 11 Nov 2022 16:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/10] arm64: dts: qcom: sm6375: Add pin configs for some
 QUP configurations
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-6-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109111236.46003-6-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 12:12, Konrad Dybcio wrote:
> Add the pin setup for SPI/I2C configurations that are supported
> downstream. I can guesstimate the correct settings for other buses,
> but:
> 
> - I have no hardware to test it on
> - Some QUPs are straight up missing pin funcs in TLMM
> - Vendors probably didn't really care and used whatever was there in
> the reference design and BSP - should any other be used, they can be
> configured at a later time
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6375.dtsi | 43 ++++++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

