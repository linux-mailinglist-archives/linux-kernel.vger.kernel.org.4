Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A31629ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiKOQTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiKOQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:19:02 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B7FC0B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:18:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d3so18200055ljl.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+CzAkDFHmdMgl4j2DtvxmhnqVrVZWAc9Wn/m7gqc2E=;
        b=X0c/8PFj10auVUGpFbGxu7DN+PI9HmL9eHBPdbSwb0V1VYE/8FWQ0hxchocw8Rp9fN
         HBH2cYvgcIxXfMOx4Dis6k1YMlrnsUI/gL487IzJc+nMS3r+FEg/qq1oFSWawTvoNjL/
         FLLubKfHwBo/nNBDwSRrpskjcurzGREIrvO4Zj5qVwkUPni2PW4MVD7CwiqHf+urMyJ1
         THqhrfjcIrAIyLL1DmVnAVLNegKCcwLPeW3F129XfhgOMzC4oPLeiXoDHqBtmIW7d3bs
         blYHjh/vkpmyblTPrVr/lICaEqBda0pOs8GcTy+OeFa2eiTPmrDp/TluSyN0r/kDTErK
         E5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+CzAkDFHmdMgl4j2DtvxmhnqVrVZWAc9Wn/m7gqc2E=;
        b=oboMzAXMxGHfuPw6bjMZ9jeZeZeuQvm/4ZtgeLcd2k/vmClF7l44Ne/8MdbTF4i403
         aZ2AVbDoj4Tr1YJapSYO4pn4cfpBpRT51PIeqf9whyBdNeVtuUcrjOhuZbPxJxnEJepz
         MFfDmX5PWX3U55apCDBT/jnnrJfEo/oOWE9bv8u82PX5zDndd+Y9jzn7ONdDvhjLxbZT
         zhgwnthlnKdlxnlH3AAwmFvJYjata6LjK57bn5dM2n8o42Tdim7N10xl+xPT47cN32VT
         9DvdLjyRbMx6I+Jg9096O6flXhAFjZ2C6tbyzjO68mk+VTEGTr+GOMQ9XT61yzxnDfmm
         YGcQ==
X-Gm-Message-State: ANoB5pl/zyxXBMtMEhPH4w/ChVSnZkYpddwSIsUExVrWQ6NWORedrnrD
        9yElbnaUmxxv/8VWvWTqoyKYeg==
X-Google-Smtp-Source: AA0mqf5AqaaZmA92crIbJFDiqqgI+iCSQJ4Z/1LSWLrXQ0IglXC99waP1UTkiIZAWVKU/ECdp/xBYw==
X-Received: by 2002:a2e:b0cd:0:b0:277:14bc:50f9 with SMTP id g13-20020a2eb0cd000000b0027714bc50f9mr6800122ljl.359.1668529106271;
        Tue, 15 Nov 2022 08:18:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512070b00b004a46a9cebe2sm2250332lfs.289.2022.11.15.08.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:18:25 -0800 (PST)
Message-ID: <68ed4cb6-3c8b-e0a4-8a41-2cf7321e46ab@linaro.org>
Date:   Tue, 15 Nov 2022 17:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: add QCOM SM6375 display clock
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221115155808.10899-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115155808.10899-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 16:58, Konrad Dybcio wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6375 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Switch to dual licensing in both files
> - Adjust the wording with the recent refactoring
> - use qcom,gcc.yaml for common properties

If there is going to be a resend, please drop second "bindings" word
from subject (the trailing one). It's redundant.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

