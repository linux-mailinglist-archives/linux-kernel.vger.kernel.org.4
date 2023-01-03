Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99365BF7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbjACL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjACL7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:59:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B79FCFC;
        Tue,  3 Jan 2023 03:59:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74AE26602CE7;
        Tue,  3 Jan 2023 11:59:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672747170;
        bh=/EzXblkT2s5G5iuzR271kOa2ZyEevP0o+iEY8c1rpe8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=itL6o8LGmxDL9Oy7vbVGRMKQvWDJ0eI+dcG23HJmKFr930dykN71/l431hib7336n
         F9ZNoqref0+FflC/XHm/pPg1VKAlCew/6hsqitS9Oc4BAL0QziH3I6mGLQOKAzElIB
         Gt8dMCvT27ETO5yXQ2NnP2wJoggwk1OybcKEbgPeIA8/3GimIFdPJ/uBppptGgUxlC
         ooFWgbPTNfccjTgudYnKlBcT+iQ2Nu8sNCddw3Gj6IRO+XYjzwExIa1QSLGNp5W3bH
         9OT7eLFX58ti681qp2FvBR8ScYe0J4oKVkcb3AyWIfBFARzd5GUZUaMWVi6cDwINSc
         oHIi+IAqiDq8Q==
Message-ID: <d3688dc6-d869-b313-3849-b07043a3c064@collabora.com>
Date:   Tue, 3 Jan 2023 12:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles
 enum ordering
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        jic23@kernel.org, lars@metafoo.de, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, evgreen@chromium.org,
        gregkh@linuxfoundation.org, a39.skl@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
 <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
 <1fac581e-ef02-4576-0dbf-67662a29f724@collabora.com>
 <c5ef569d-0f36-19ac-da53-3a5acdca4165@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c5ef569d-0f36-19ac-da53-3a5acdca4165@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/01/23 12:58, Srinivas Kandagatla ha scritto:
> 
> 
> On 16/11/2022 08:50, AngeloGioacchino Del Regno wrote:
>> Il 15/11/22 17:42, Krzysztof Kozlowski ha scritto:
>>> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>>>> Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
>>>> alphabetical ordering.
>>>>
>>>> Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible strings")
>>>
>>> It's a style, code readability, but not a bug. I propose to drop the tag.
>>>
>>> With that:
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>>
>>
>> Should I send a v3, or is it possible to drop the tag while applying it?
> 
> Applied after dropping fixes tag..
> 

Thanks for that!

Cheers,
Angelo


