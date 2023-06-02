Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73871FAA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjFBHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjFBHFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:05:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D47E67
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:04:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so2427655a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685689498; x=1688281498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTldhXkJo+cnlPsMiyCFVYTORfO665ew2Q6qnXi/yLo=;
        b=sBMXqZHZXSDjAfm8mLeFJV1iN23CaLp6LqXrHrsVFpwfGt+CIvw/C0ByuyIQeZwbmJ
         /L7K5OnKtwAx1Jygl17TPQs4leiyOOw9Q9x8rWPiiSfCRxmMiO6BkZ0Zc0X3wRD77NWl
         WBQxLJJ5oHBAkrbOO7rdf4jHHwCO0u5TwKIx3/NrjTU7p0hCLD3PuOazo+QoEFIU6adV
         vKeeqHerSGh1b+gSRdnwlAaeQM0lE85Jg7yetfDPv+2DCFLHz7PFFCftELaU2JfvQK6y
         jjVEfDd1USAdDz/m1qS/X+4aunh+P8wWembNpw8IyEjc/NPW5YXen6zi86Vs+Pjdaejf
         UhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689498; x=1688281498;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTldhXkJo+cnlPsMiyCFVYTORfO665ew2Q6qnXi/yLo=;
        b=Uu9EGjmMYViDa1OjMTICurElF5uxqEHrF+gi9xVsRTmst3K4Ec6UMN28A26LxsAXwE
         BU0EfF/XgPim2haWe0lOCzsW8dIqvTSgHSHXioAiEq7rhayGSegszkxKE2N9sLQouGvH
         r1YdbpDW8KDcj6j3lTB7jco4jeekFCfKBKRbkDA8wyHOt4Eeih9OYRVTKUcWCyXa3ojJ
         NiYq3kWK0BiqE0qH7UJx1o9Tg5dH/7q1V+poirfLVr42t67ilVgG1uUiokDEa6o1hTIB
         agp4y8psq1QkNPDvJUMofiMOoR6QbGqzVczpIEU5t9UWdKd8hA9H763gly5X2i/Vulej
         UYvA==
X-Gm-Message-State: AC+VfDwXDv3gRnZKdCf690jjgrXrD1wvR05ZYzMjhYaYlPUakL+cm2FH
        32cQZq3tVvXBUuGI99lLfKTgUQ==
X-Google-Smtp-Source: ACHHUZ6JiA9aoo407geZBJrdz30BszRHsc7rn452xdM9ZiQQBPOavzi55F4oX+jPMfGjaWILCx/iWA==
X-Received: by 2002:aa7:ccd2:0:b0:514:9eae:b099 with SMTP id y18-20020aa7ccd2000000b005149eaeb099mr1404008edt.17.1685689498442;
        Fri, 02 Jun 2023 00:04:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709066b8a00b00974556e50a6sm389290ejr.114.2023.06.02.00.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 00:04:58 -0700 (PDT)
Message-ID: <3ca449ae-6e7b-6e3c-df4c-8ae92c20f77f@linaro.org>
Date:   Fri, 2 Jun 2023 09:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND 3/4] dt-bindings: arm: qcom: document MI01.9 board
 based on IPQ5332 family
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601042054.29075-1-quic_kathirav@quicinc.com>
 <20230601042054.29075-4-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601042054.29075-4-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 06:20, Kathiravan T wrote:
> Document the MI01.9 (Reference Design Platform 474) board based on IPQ5332
> family of SoCs.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

