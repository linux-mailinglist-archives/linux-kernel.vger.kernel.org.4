Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3971238E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbjEZJ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbjEZJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:27:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9161BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:27:16 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f122ff663eso501057e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685093235; x=1687685235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWY6DpPavWVM1/OV1R8NKim5vOgtapaTjgty3qjQSRk=;
        b=sKPpbV3i/F+WXcUkFLlNIXGaLW0Ro8KTEkTLW5HjsV1Aymj3soXrG2/LScpefhNikD
         9EuJsDyLIcGhsaya5NvrKKYfIurUbGVxYLjni1DqmFumcps31LRNQYRg4PnXiD5OiMA/
         0m7+7+4tK831HUt68QNgjLQLEWLevnJigZnlBPLttxttRDdd2TeEOpTwh/mgYW5yqstC
         Jo0cuXc0EEIGXcODbgR4o3s+HL7BCc+hkRPRsrEvJqCYxSD5RHQOYYgS8Az4+bZ2tftR
         10dCppKsa0a6g6SHd2FnImg3ds/snfIFKGjR7NxlFiUkQzGt9Hn/T+H29bQ7gDFUGB96
         D6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093235; x=1687685235;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWY6DpPavWVM1/OV1R8NKim5vOgtapaTjgty3qjQSRk=;
        b=Da7Q6p7lrN4lF74lv3qjp3+/p1g/RQz5Y0d/GIebZSJkYmawv2Zf+Xr3rmQh9Xa5Uc
         BUSf/fGHL0+kLl8Kq4Niq/marFG2j8iyFAYg1XQHngbuq6p64g6jSwj+B/Vrg2U/qBec
         NJL/EcZxakrizy4jyAtycRhR5oFaueEwbqsgpaV7dyLrDlRcT3GrJiixGwGLSymqSZSr
         Po+HN775N7VFoylaxfa4hqledtrfdNeXyg1VQK0eBu8fLXgd9QFfaEptVnnSp0JNfvbo
         g3DKpRDcalGa8iCzM03lcojKhE2FFkr24Jp7qYXImwebT9mETjW40J6Y+tukGmxhQNvN
         a3bA==
X-Gm-Message-State: AC+VfDyZ2tLjB19mUxjUQOD2mlyhMauY5hGtz0n9g0etHaB4HA5Oiy1/
        8jBAtQdDWr6ob93LBg6tGH4a7g==
X-Google-Smtp-Source: ACHHUZ6ltL32f+pELojB+JCGwt/0k+SKroDtrl5xjXEHrWHnBK2DNAtZmefxNCZAqo5wLN7qGyUxWg==
X-Received: by 2002:a19:f816:0:b0:4f3:a812:5ae with SMTP id a22-20020a19f816000000b004f3a81205aemr375578lff.37.1685093234954;
        Fri, 26 May 2023 02:27:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b004f138ecab11sm543964lfe.24.2023.05.26.02.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:27:14 -0700 (PDT)
Message-ID: <a1d60d67-49cc-4936-4b89-394c8fbdddf3@linaro.org>
Date:   Fri, 26 May 2023 11:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
 <a5891478-bf4a-8389-e1c9-00244c5b406e@linaro.org>
 <ZHB7Gy7RMGa41KI9@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZHB7Gy7RMGa41KI9@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 11:25, Johan Hovold wrote:
> On Fri, May 26, 2023 at 11:22:27AM +0200, Konrad Dybcio wrote:
>> On 26.05.2023 11:16, Johan Hovold wrote:
>>> Add the missing module device table alias to that the driver can be
>>> autoloaded when built as a module.
>>>
>>> Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
>>> Cc: stable@vger.kernel.org      # 5.14
> 
>> Looks like the commit referenced in Fixes is from 5.13-rc1, perhaps
>> 5.13 would be more fitting here?
> 
> No, I just double checked. This driver was not present 5.13.
Odd, I see the same thing.

Anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Johan
