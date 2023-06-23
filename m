Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752B573B841
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjFWMyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjFWMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:54:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD22129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:53:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9c88ac077so7796665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524829; x=1690116829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANudvaWzKociGmeQc/Hjbj55D7g4D5N/1vRViCm6qwo=;
        b=iM15FSmBc4l2w2InncDGMQZLLlCk4y4CdgRqe/uD2EFb3FAwHLjz+ELDCjYY+CGXEz
         HYtPLq+B9P0Ak4dzVlaZF+vlGaIYfjT6X504bk98lm8qaMR0cpfWISyJHvmd1mGx3TN7
         Tedvr5AqajDzl9xCtHCZXWji1vTVRZP7GKs4JuPB5ZQF7x0OsSnASCOyA3tHS8lO6nqq
         yqRbx8RBvy3zuaGN8xhhB7zD+lxUqcmngQOpiopHYAXOWR1YJtdtdGNvL2BrdfMR1LwI
         e/1gTThgnItFYfKdL4q65cuMXRBolKgpt5NYvwCLzCMbA+9y1vrUeOQjZsAYb1m6cM4V
         yyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524829; x=1690116829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANudvaWzKociGmeQc/Hjbj55D7g4D5N/1vRViCm6qwo=;
        b=jfZa4jxHM2cfQTJKzdwZIM+7+EMT6UqFIC2GzdHRfHRjB/RyW0RX4gDuqm4jlLgIE9
         nnfHHVokV3t8SFzjy04N2Zsts47Gb6Yn05k7tipoHv/rC6jlJo3UmS5pA5cep5HWMT+P
         wKb/Inbtn6f0GqWmhwjjr39ZPdQwS4b05O2uQSAN0ifNJZ1unuViAjqgqp2VmCH//F8l
         du+o4DdmcUvoMfNCW5UxuW/rFe/5LiGQR4INKgTMl3+kxVC+FNQq1v59sINWswVYEzZb
         kKkT6NIabqcAcelVY1hjsN85ztC13asSbJASake5oPH2KHZLKmGssg1mxsFbwllktuwe
         sa3A==
X-Gm-Message-State: AC+VfDwkttwcKzZHkK2TnAKnhEOzy/Dhk0NuDh1O+wXKuUzDcy4T4eh5
        RvOgQ4PgYRsuteaMvyfOKxVoYQ==
X-Google-Smtp-Source: ACHHUZ4lM0hS9LoQWbVrzEU7Ux8cRPL7TId8Ngjq8cDakd+c79pbBTpR63tRY6dauxYKb6u9GfM32g==
X-Received: by 2002:a05:600c:231a:b0:3f9:b430:199b with SMTP id 26-20020a05600c231a00b003f9b430199bmr10028918wmo.15.1687524828997;
        Fri, 23 Jun 2023 05:53:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003f80946116dsm2219346wmi.45.2023.06.23.05.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:53:48 -0700 (PDT)
Message-ID: <7ceba3df-bee8-9f1d-a27d-85e0b5f35d83@linaro.org>
Date:   Fri, 23 Jun 2023 14:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 3/4] dt-bindings: qcom-qce: add SoC compatible string
 for ipq9574
Content-Language: en-US
To:     Anusha Rao <quic_anusha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, bhupesh.sharma@linaro.org,
        conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, herbert@gondor.apana.org.au,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        quic_arajkuma@quicinc.com, quic_gokulsri@quicinc.com,
        quic_kathirav@quicinc.com, quic_poovendh@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        robh+dt@kernel.org, sboyd@kernel.org, thara.gopinath@gmail.com
References: <20230526161129.1454-4-quic_anusha@quicinc.com>
 <20230623115525.7300-1-quic_anusha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623115525.7300-1-quic_anusha@quicinc.com>
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

On 23/06/2023 13:55, Anusha Rao wrote:
>> Document the compatible string for ipq9574.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
>>  Changes in V4:
>> 	- Picked up Reviewed-by tag.
> 
> A gentle reminder to pick the dt-binding patch.
> As the dts change is picked, this patch is required to resolve dt-bindings check issues.

One patchset with four patches targeting three different subsystems, so
no wonder it gets missed. You will usually receive better results with
splitting such patchsets per subsystems.

One more thing is lack of proper subject prefix which indicates the
subsystem. Without it why anyone would pick it up? For example me, I
would just ignore it for my subsystem...

Best regards,
Krzysztof

