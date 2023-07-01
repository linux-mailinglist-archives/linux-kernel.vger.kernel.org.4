Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FE7447F2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGAIJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGAIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:09:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB02E51
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:09:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51de841a727so2153613a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688198948; x=1690790948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSlAwdCySIPpHmXGLs2pWw86cvP+2Eq0vNW9mrLLkJQ=;
        b=hwS6HIFRBhIjc+RulU2qKaHPWsKm8iIpLpWKEScv9k3KM0liFWO5gnpfPMiiPVzuKI
         A4H+8aeBMAz5J6NZt64SLbmVItWC3f7WhJJomHJa3Zl5M73pB2E1u1TD7dAJopIsqYqq
         Pgk53D6bCQG7sWKtMCmF2FU7DKKF/yR8tM/6rkP4nprQD2KWZInDVcYVbT3RPSXJ2CPn
         uhUtQBRylO4DksYiQ8fvbapSndRs7CKaHx43OfzWDkQiGldDuCN6gax1ErqRiIlSQHnA
         ytfIKZqzWRG+eF+C/6GaRiAzjupWuZP4x1ni9PZ4NL1j2m0r61UnFKLo1Asf9J9OCj77
         jxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688198948; x=1690790948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSlAwdCySIPpHmXGLs2pWw86cvP+2Eq0vNW9mrLLkJQ=;
        b=iNHxfntLCEAWo/evu380voNOOR5tSXi7dXGoQXBD+JqTPvENofFIbuq2Frd3h0LxXa
         O4q4kff0aT7LVcjLMKXDaSJO4s+0UAwgeHDWrwAcTAoahYBe3BcsJCWtnUoYthDn/8cu
         b1bXStpIHV/uAzGqLWe9rDG+9fhGbVilvXUZKS313M414AjFxkm1B1ROPKKdcZwtIuzj
         N4E40j9IaIjlvQIosmEm/zxbDT8LL7LItuo/2oR4V6Xxq6CSCpvyol4MMy9J3BFtcsBT
         Z9w7VuvjPxnM4fhNW3hTsPKQ0e7M6RKyhxyEOb+6QgmKYExeaC8MFVEs8S7Kb1UCCMP6
         VkKw==
X-Gm-Message-State: ABy/qLbXGtVWmJ3HWDK9pcmyykAZpMSaMxxnI3Nb92ZpdULnSw6bfVFJ
        /8t1dYplYc0woWI8Aao8aQrmAQ==
X-Google-Smtp-Source: APBJJlHWma/hbAV/dZaNLVa+XpQhQptQYCvZa1XvPDcNYiQmDsijOwydkrgNp1l53POy1A76v4YzgA==
X-Received: by 2002:a50:ec8c:0:b0:51d:9dd1:29d0 with SMTP id e12-20020a50ec8c000000b0051d9dd129d0mr3229450edr.23.1688198947677;
        Sat, 01 Jul 2023 01:09:07 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402032b00b0051de2455041sm2292444edw.24.2023.07.01.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:09:07 -0700 (PDT)
Message-ID: <79505e19-c5ee-36ee-c8ae-344c15f8b108@linaro.org>
Date:   Sat, 1 Jul 2023 10:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
Content-Language: en-US
To:     Valentin CARON <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230627123906.147029-1-valentin.caron@foss.st.com>
 <0815474b-a8fa-f486-fc6e-a85df88ed9b9@linaro.org>
 <c232e3f1-b703-d8d2-7e2d-19ed3f5fc3ad@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c232e3f1-b703-d8d2-7e2d-19ed3f5fc3ad@foss.st.com>
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

On 28/06/2023 18:21, Valentin CARON wrote:
> Hi,
> 
> On 6/27/23 15:39, Krzysztof Kozlowski wrote:
>> On 27/06/2023 14:39, Valentin Caron wrote:
>>> STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
>>> Stop probing if this case happens, and print an error with involved
>>> compatible.
>>>
>> ...
>>
>>>   
>>>   static const struct of_device_id stm32_spi_of_match[] = {
>>> @@ -1798,8 +1802,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
>>>   	struct device_node *np = pdev->dev.of_node;
>>>   	bool device_mode;
>>>   	int ret;
>>> +	const char *compatible =
>>> +		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev)->compatible;
>> The goal was to replace it, so drop it.
> Is is still needed for dev_err, so I can't

Why do you need it for dev_err? Isn't it entirely redundant?

Best regards,
Krzysztof

