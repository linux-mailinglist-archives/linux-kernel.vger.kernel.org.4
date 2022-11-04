Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165B9619FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKDSbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKDSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:31:34 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BF4047E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:31:32 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e15so3762861qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcCeZbCZONv5bo4yWcz2t2jsaGs0p8r1KPV0A814kw4=;
        b=K6Sg70bygax8c9CeIXFwpHXXHMA8oc0qoquZtdNOsjvHhAFtbxqM/5RNzkRmswFUp6
         fWYJQRITCcpdVSde7j3L84RQP4angW7Dn1N/B5bT5UMVQExslDlGxffZxRc9mD9ISFa1
         js6nF9SZzYj9lyEmK27vqpiTfQtZVViJ+2Qc+fLtw8drZ2H8dKcQ2LmNbSJcuYrl+JK6
         jJ0mVbQCRZS+Q0Ta96tclZGOPNAgdhD6eqY8SnZC1xtABQmS3Pke6BBEd36d4WwKTLHy
         NFn/hG2tK4QWSZ1TEexidNl3zQLK7fEw33Ekiae61jY9Qsy0ZIk2e53FbS4itOTPCmII
         DPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcCeZbCZONv5bo4yWcz2t2jsaGs0p8r1KPV0A814kw4=;
        b=HzqaQFmg+L6aUi4EpGxtAFEcvMjB9P6aTaWsqOflPzGxRXHhrTMHG7BmL3RqBEl3nW
         L0w6nwIW0pmpfRZOUc8u72wpldZpj8e5vZI0uTRnRAs/LoHc6TO45buMiKKCdlxyme1W
         /zGAM6HeyNrhTwylOe9IJcrJUr2PhsoaAwpvpPhe3ceMy6f9eAdYv3wSIbiN/ASvA73y
         PZSBjYbldWVdo/ARwgDU9vm6dsjbkKFKCUf+oniyCB86PLvN9mTYSfI0nIUNfTEtupCt
         sjD5HcllGFDeiIxPT5uUuRGT29GpIB4ljVyqhz6ZRA0YC4EWfXRk+e/JmV389l80sXSz
         faJA==
X-Gm-Message-State: ACrzQf2gKcLcCvp8FTs7ZRjwrrA4/+QRifNkJQcSTyouhlaNsuMuUUn2
        7Osyt2OvLRG12Nk+jF2vo2j29w==
X-Google-Smtp-Source: AMsMyM5Fyf8Z84UkAGcXhla+1HigqJlJ5thhMSjzjsbREVdtJR3YMc4CNNlUjb8k4E4HZflXQu+aqQ==
X-Received: by 2002:a05:6214:21a8:b0:4bc:5c9:30a9 with SMTP id t8-20020a05621421a800b004bc05c930a9mr24389347qvc.79.1667586691833;
        Fri, 04 Nov 2022 11:31:31 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bn35-20020a05620a2ae300b006bb2cd2f6d1sm3262635qkb.127.2022.11.04.11.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:31:31 -0700 (PDT)
Message-ID: <908ea990-2a12-0680-b6f2-3671b3a2abfa@linaro.org>
Date:   Fri, 4 Nov 2022 14:31:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-msm: Document compatible for
 MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> Document the compatible for the SDHCI controller(s) found on MSM8976.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

