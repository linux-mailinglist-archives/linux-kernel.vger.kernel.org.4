Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27EF631E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiKUK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKUK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:27:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE5220DA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:27:21 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id r12so18171056lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjUcElOeg6s4BhAahfWcSgjdD/FETbWteqP3XVCn1qo=;
        b=ISsfDxDJ+MbjHntyXmF6RyfNELhSJLS/4IbVuTaRp0HzY1Nd4tMFW35kaCvkpNWAzj
         FfRBF2q2AZbYaLkeiW/SoEu9PcixvG4/9oYhG4i4eSFIF0QCpYfXj9GOQqLW6W95NBTK
         Oe2T4V2vc/RPJMU9hPodDpZ7LtJYLCfOIcNU47nSwWCm/OvRx9O7D8Kp7HJwvJASPBcb
         RoWVvUHe5A/U1nsJMA8OiOF80EfDj2d3ryJXA7qr9v06EfofyopzoLNolQGMllsaaQmJ
         N1nuXpsjU3yqQR6qE8EG83/VycIc7FHKHXqampNrreHiJjKvA3Oldt84KQEX6bD5gE4W
         yshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjUcElOeg6s4BhAahfWcSgjdD/FETbWteqP3XVCn1qo=;
        b=SYQs/HURQ19BL448WUr6E6+rzLNQGg9gXYRSS1q8JovIxHIs/5N2VvhQhVCgmEYkGE
         yUo/gNcLUXdeW03ngBLMdw33NWL/5TmkgnrBMzjGaJVotUlAUtDqZw5ZX6WF+tpZllzX
         P9gbFvc0kw2tpzuynS5ibOlQv0OmnYAfYQ+sgfHw5NvIN2GfckeDJzy6Tqp+k2X/+aGg
         CMXPUFr71eZY/sViLvgySMux1Lk3omGV8SDSEPW6tAiOqX6+UXlXEiXEUtGPTIL4i8D6
         iWSbS7pQE/7aR1+qRLf5hcQ79CwW8z0pjaU1BvXSOHihoTkNgF8js0lLuwny2Wse0YLq
         op4g==
X-Gm-Message-State: ANoB5pnRIeENSb0BmetWcH9Z/CANgikZwkmAV6OjT+9V8euRMhBknzCV
        YoxWshh6YxfIbZWHiON+hCExvw==
X-Google-Smtp-Source: AA0mqf7LEUrtU9ELSt5k4h9THmPbWafr4En4+BLiF+LdSNcaAPZ5yfqf3hq53qI00YO+732m0+GzNA==
X-Received: by 2002:a19:7111:0:b0:499:b4b3:2f68 with SMTP id m17-20020a197111000000b00499b4b32f68mr5506824lfc.203.1669026440220;
        Mon, 21 Nov 2022 02:27:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v27-20020ac258fb000000b004979ec19387sm1951534lfo.305.2022.11.21.02.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:27:19 -0800 (PST)
Message-ID: <5353c1d0-37f7-fe89-f6e5-ce9d5904e142@linaro.org>
Date:   Mon, 21 Nov 2022 11:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add QDU1000/QRU1000
 gpi device
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221118182439.10670-1-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182439.10670-1-quic_molvera@quicinc.com>
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

On 18/11/2022 19:24, Melody Olvera wrote:
> Add compatible for gpi on QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> This patch comes from discussion on


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

