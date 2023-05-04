Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829066F6ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEDMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjEDMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:04:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13986597
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:03:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so740122a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683201827; x=1685793827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtOBib/LO80L4A/TFz53ysy2RHlTFVeZ4/6La/AK+N4=;
        b=d6zvW30kI5WPUl27avgrW582mSb0oXv832ZMBe4j362m6aZbU5siJWP3SjUBTBpjYL
         5jOAkcRzdvsw/zkjxHeIldDx6Zek0pdSQpild2jvllvnKUYvVGq82/jBO0Y23buLMqVQ
         5YtQsd6+Jl6XY7Fl8PY8GB+ynyaMAFzgjNm9E0Rv0As2E/i1J4AkOxy6b/2FXKpQr51x
         EZfk28zC/MD6VFFH9sUVe3zAmwg1H9s+opBotn2kTPCfjcB9p+fl0o8L2pu7/ExWDtZg
         EMmSpu9MxJo5pBha4ZOhWMUqhsT7P4oJQoS9kotRyjg3ldnYjJ1MvnoguEBUqNWgThXG
         NItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201827; x=1685793827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtOBib/LO80L4A/TFz53ysy2RHlTFVeZ4/6La/AK+N4=;
        b=FW448LMFHwQkUkqDONUDyabP1+cvcu75y1PYjhbq0+Il0PZ4EG1WHZExvQNK0QtugE
         ToqS+vIhb4+tzBs44ELZa0S9zcMIWuTrjRcnKTn7MJQDPR2XipeGpvvQUco+pVCIF/ji
         lItD6/V4bQ5qQSRR7oflyLC26pHzhVRV+ENzHONefi5gMzuMIdkcPG1OWzpH8L3uE9PI
         ViZ0GCEq0v/PdzJZe+t2txiD9kRRzqaOIRbALXzmKgMtQRUtkU9g+uv5UIq5Zo/WdwpB
         1yOt5xQRqyg5r7ElG4fFLISZnv/uKStprAFtnQSA68Yq3tvJpxxOBf2iAFtNjoJR24Qh
         lw4g==
X-Gm-Message-State: AC+VfDwHLee509RsAaa4P7phURl2S/7yiv8mzjvpNx4/S11QYpgWYpLd
        rwGNF3MxqR2RI1U7cxk3JAMnuQ==
X-Google-Smtp-Source: ACHHUZ4KRRpklijX2Zaq3uJKOtqrMPldFa1Qkn6fVQO7TYiwnqNmvXFsGkAPCUIWlBVW6PTNB6+H9g==
X-Received: by 2002:a17:907:2ce4:b0:94e:dd68:aba1 with SMTP id hz4-20020a1709072ce400b0094edd68aba1mr6055038ejc.67.1683201826906;
        Thu, 04 May 2023 05:03:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id n20-20020a1709065db400b00965b439027csm512321ejv.195.2023.05.04.05.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:03:46 -0700 (PDT)
Message-ID: <99bfc63d-3b3d-1ae0-e2d3-f967e059f01e@linaro.org>
Date:   Thu, 4 May 2023 14:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 1/3] dt-bindings: misc: esm: Add ESM support for TI K3
 devices
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vigneshr@ti.com, kristo@kernel.org, u-kumar1@ti.com
References: <20230504080526.133149-1-n-francis@ti.com>
 <20230504080526.133149-2-n-francis@ti.com>
 <84a345aa-1426-2d1a-f7d6-df3cfc10ae3a@linaro.org>
 <20230504115103.gxr5cebv5jaljywj@gondola>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504115103.gxr5cebv5jaljywj@gondola>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 13:51, Nishanth Menon wrote:
> On 10:11-20230504, Krzysztof Kozlowski wrote:
>> On 04/05/2023 10:05, Neha Malcom Francis wrote:
>>> Document the binding for TI K3 ESM (Error Signaling Module) block.
>>>
>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> To make sure we are'nt stepping on toes:
> Krzysztof: is it OK to pick this up via SoC tree?

Yes, please go ahead.

Best regards,
Krzysztof

