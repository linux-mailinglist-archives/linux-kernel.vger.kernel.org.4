Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1248A71FAA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjFBHFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFBHFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:05:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2C1BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:04:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso2523711a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685689487; x=1688281487;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1d9DD10q4AGlk7MmO9oJ82DC3m4s3pLFpDFQj0JQ9g=;
        b=XkPv8H3u1C3h5x50F2jBCg1cDvAQSm/uKEUAOlGwe5kiLeH7DfKYfR5bh3/ykBCMSw
         7MJDdfIDSgGVDhLQvqoH2KcEafsh78zInlSb0ASytHq4jUHyu5UdwuEmR9GSSlcqMmaM
         IF41VNoGRPa8itPzW1ZahujSW2+r5+k57oWawH0NmRteJWzuLn8CoYJBdPZck0PcSxqN
         w6ZgAZx9Q3A4iGVs2VzTF/2wsDobdt2XxQzp6hneP0JkIEgP4Ob2BuzB0ZY9w8oFfrgG
         0rP9sFBHhiHpnzNdjE1rQaxVTG7wUzY6JfjJp4bgQ0+4X97N2lVjPHJ4zlcSnINbnD1u
         pnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689487; x=1688281487;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1d9DD10q4AGlk7MmO9oJ82DC3m4s3pLFpDFQj0JQ9g=;
        b=iw5c7HrwLxIkwlX34RiXCE2Yo2e4BBnA7f4tL+kJQv6B/iRngxljD8ngPD7ItPjrb2
         Tt/u6TI/LosMjnuBZcB5ref7YRn5SlsZ7zRyDO2gIAXisgXbshMmGwuu/W39R2318scG
         BR2E5E4B8VhrVLLmduhhbcURg21O2wONlQVEbvkFr8dkveW1+DITD9zAzfHZS1JlX5jH
         AYBYoS51MXZsasocyKbrLEKuZTZ5nuXQt45pgBJCUVHIdQBh7Jvb1WxRafADy0IOqWvT
         HC/yH6bLsWThO+f64rv7QQaWH0oIUVcjRHlmncHN2wKNl2zfV3ZWGgSp3z/torU1FQ3Z
         UCVg==
X-Gm-Message-State: AC+VfDxHO0mp1nMKx6vISx888E78I2EJVW0R+Gn5wgTIsGKVfl8qu8j4
        keDsuSUEA6599LkGeuGg5MiJ6A==
X-Google-Smtp-Source: ACHHUZ54Aa/2X1I6zgJBwKrcqiCN3K+p4gMYWSb0zSpvLbFJ0Wi7SQcQl0L8UPgGnZ7ebjD+dcfCZg==
X-Received: by 2002:a05:6402:2027:b0:514:9934:de96 with SMTP id ay7-20020a056402202700b005149934de96mr1218078edb.26.1685689487347;
        Fri, 02 Jun 2023 00:04:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r9-20020a056402018900b0051056dc47e0sm338506edv.8.2023.06.02.00.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 00:04:46 -0700 (PDT)
Message-ID: <a3101b56-867d-4c95-b6a2-de63a85ee64b@linaro.org>
Date:   Fri, 2 Jun 2023 09:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND 1/4] dt-bindings: arm: qcom,ids: add SoC ID for
 IPQ5300
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
 <20230601042054.29075-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601042054.29075-2-quic_kathirav@quicinc.com>
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
> Add the SoC ID for IPQ5300, which belong to the family of IPQ5332 SoC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

