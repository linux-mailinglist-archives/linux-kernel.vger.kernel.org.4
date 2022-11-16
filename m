Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD062B58E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiKPIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiKPIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:50:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72A1A05D;
        Wed, 16 Nov 2022 00:50:41 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3AFB16602A81;
        Wed, 16 Nov 2022 08:50:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668588640;
        bh=UGw+5yUczjb2PkEG6B9/HaNrOcAqFKLMrvc6BAUVOP8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ketnzDti5gZW6WM7CNR0kWaRb7Q2Vy0mwisMLM49ofYe4ouHUz6q87GclgQr4HtPx
         MPfcf5kwp1e0tk3kWE7q7TyNe8oxbadG0VDSgJ/aCvUEbZT7D/MayaXPAsL4Af4s/H
         +Z0vjZ0/r68nbFU8lTeWNSACjwxRfqjSZLjd3F0vZ99twJE6G5nkiYV8I3qLcha62O
         TpBiS+5ct101WFbr+Ah34I18N31WBni9kGpHHz4VMc0Wg1fJv/yd6dmG9p/wswZw54
         p+DYkELOcQPs6jM97vbFZ9+FHLszsmEu15NXb7yHrx99GdmKgi8DIIz28+ss4EY79Q
         PITEQUf5lBHvA==
Message-ID: <1fac581e-ef02-4576-0dbf-67662a29f724@collabora.com>
Date:   Wed, 16 Nov 2022 09:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles
 enum ordering
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
 <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 17:42, Krzysztof Kozlowski ha scritto:
> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>> Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
>> alphabetical ordering.
>>
>> Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible strings")
> 
> It's a style, code readability, but not a bug. I propose to drop the tag.
> 
> With that:
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 

Should I send a v3, or is it possible to drop the tag while applying it?

Thanks,
Angelo

