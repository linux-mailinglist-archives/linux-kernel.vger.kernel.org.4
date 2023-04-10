Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21196DC9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDJRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDJRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:16:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA62116
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:15:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a34d3812dso138502066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681146957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZBwROgmH+IIoR2e80mjys2puwLn2VLfdxb+lUUb7Ns=;
        b=AWDtQXdtolm6bzh8d/0vEpts3R9V+XWz4wzHsws02PVWgdRm6Yhy3T2ofpT9Ec6Jo3
         Lr63EcATLhkMRmlPSpi3p66urvA/nQbgpHsWi08EmVkGY5e3OVavSmQMDAuc6TpNI0wL
         JD/zWAbVd1qKL65YH92rBUTQW56VS2P8/LqF2p6eWPWedFhOhadcQhsdWZJ68YXc2MVM
         HUhi9bZe7FvGQmHD2pjRqz89tBJAoMrLrGZCz7z3mm2cW/lEcleHdrI3pMSE4yJ0Rd+t
         UlUc67CE1ZfsfhF7qVRqoHlIlIq4Rq5qlthfQqrvbQWWfN3HmDAvZfW9THyBiRXZdSmD
         XT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZBwROgmH+IIoR2e80mjys2puwLn2VLfdxb+lUUb7Ns=;
        b=cRu1V57v8s05kPFKzRvjYj4vSuyvsdmiCDiliwU2Yj2/VwAgvwc+U5dCzcjmgTacly
         PUPX0ipgaWxK4bJi/rVOzW8NVmuPGChrEnIWLXWC1lVRlLsCzD6H4WjV7fljz/NZ/hev
         W/E6ybNVZtt5W4GcdppX3GJCibZwnx8kJKansHKvioObrpAd/xL9qf65xcKKVVNQdf4l
         qistGPpOfP0xBfy5dgT8Ltybe7vEgw82vEK4udQl/8taKssKqkNoPEOXgADnb9wM2C5P
         m5PxXbP/Z8deZlSzWbvmc+Chi21fa+ni3s7GZv8sUW1Wc6fXtUsiDP9O+C26K22doT0a
         EVQQ==
X-Gm-Message-State: AAQBX9cyheBmDhJgL1DSt+fLDwmPrZmlmaDQ5Uki9TQSitzJpMkFRbFI
        8B3bSrLmF3spUm3cd2x1dOBigA==
X-Google-Smtp-Source: AKy350YHh7+m0NHz2RF0Mt5Yx4+JzR6JqTkCN2ODbe4N+VMyC92RAkUxhQBc5rNeT2Gz2HTTsI5PDw==
X-Received: by 2002:aa7:d944:0:b0:504:8bff:8285 with SMTP id l4-20020aa7d944000000b005048bff8285mr6884700eds.14.1681146957349;
        Mon, 10 Apr 2023 10:15:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id k18-20020a50c092000000b005024459f431sm4953542edf.70.2023.04.10.10.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:15:56 -0700 (PDT)
Message-ID: <b297d980-686a-70ba-da64-44b3ff76a666@linaro.org>
Date:   Mon, 10 Apr 2023 19:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: Add t1023-sfp efuse support
To:     Richard Alpe <richard@bit42.se>, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        niklas.soderlund+renesas@ragnatech.se
References: <20230410082051.2948510-1-richard@bit42.se>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410082051.2948510-1-richard@bit42.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 10:20, Richard Alpe wrote:
> Add a schema for the NVMEM eFuse (SFP) layout on the NXP QorIQ SOC.
> 
> Signed-off-by: Richard Alpe <richard@bit42.se>
> ---
> v3: Introduce this patch.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

