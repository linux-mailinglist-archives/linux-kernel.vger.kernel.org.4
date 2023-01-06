Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD31865FBFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjAFHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjAFHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:32:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235A6A0F6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:32:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so509559wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 23:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpLSm6CuKDS6yh1V9OvmrxhxF+Wx/408Npf/SDOYlgc=;
        b=XUmyNwMsSi1igSUA6OyZ8APYUipjp4oPFJZlJhVNqsDOwr6oqlbHTRGcvpUixUnlMk
         EhCmLAq5WdQJnP4FB0qZ/96nb9/CstBsU2UpfQDHs7uqxMqiZq4+xJoJLLMIJwcOCnRW
         l6yL9Q9YNE6thamc5I5pWXQ+GP/fpdxuh8+V6rfD/luO5tmy5vzCSvBmQ2F19FD2oUxF
         Wf95+jc8zqBg9fnS42BQMOBFKjXZ39Qjy3ujEYHkTT8jAoSYUT9budfiDQitDG49iexJ
         ILUZcjltGL0x5LHPv+mw3NrNhEwe2v01oZKPDMj2YPM4UnP4B2cZJufIYbMauN5Ykspt
         LMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpLSm6CuKDS6yh1V9OvmrxhxF+Wx/408Npf/SDOYlgc=;
        b=PUTz8eVaJnMfHkz20OtLUr2aln4rEXXpfHomgsZZcQ9jrAAToIFuZzDW4HofEqNyBS
         /kdb8vY1XM7S4iC/2NDOCwUoXsyVMGHe9XzTeVNBFlgdQfHIFPmjKEYZ6D0LFG/yJKP4
         w8e78QGU/qJzP6xuTSNkaRSM9kJM3+j/NPe76SnF0vrJ6/C/9PfyStC+RDFAUgnVqCdB
         /G13QhmihLsXky36ZjgH6AGfxRWd46DbwYlDHe5nofXqzL6Td+RlihmgCeHFNttlocDL
         ohN0OxVncS7BbE6Ta+7M3OUKZqVqjW8PkDH/tZszlS7HjZKuXQ7DKjxUxfPr4gJXJgE2
         py+g==
X-Gm-Message-State: AFqh2kozCk0DnEG8hmvUg8a+dsbHlyTB7HOKi9qH58DIL884IYc1qX0X
        tcegYrnsD21N5Zw0JRGJIkPGtg==
X-Google-Smtp-Source: AMrXdXsPrLpJuWu5vWsJ9FCOE0dsyQg2/VcnP2li8WxEguxBxOZYC/+M9y71/sz3HWtjlzFjceOTjw==
X-Received: by 2002:a05:600c:500a:b0:3d3:5b56:b834 with SMTP id n10-20020a05600c500a00b003d35b56b834mr38440614wmr.5.1672990351634;
        Thu, 05 Jan 2023 23:32:31 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b003d9b351de26sm694803wmi.9.2023.01.05.23.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 23:32:30 -0800 (PST)
Message-ID: <8b1f8f2c-c8ea-c987-4860-e3be3bf312f1@linaro.org>
Date:   Fri, 6 Jan 2023 08:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom: add MSM8998 specific
 compatible
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103203915.GA1020424@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103203915.GA1020424@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 21:39, Bjorn Helgaas wrote:
> On Tue, Nov 15, 2022 at 01:53:07PM +0100, Krzysztof Kozlowski wrote:
>> Add new compatible for MSM8998 (compatible with MSM8996) to allow
>> further customizing if needed and to accurately describe the hardware.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi Krzysztof,
> 
> Would you mind splitting this into two patches?
> 
>   - Convert "compatible:" from enum: to oneOf:
>   - Add MSM8998
> 
> Having them combined makes the history a little bit harder to follow.
> 

Sure.


Best regards,
Krzysztof

