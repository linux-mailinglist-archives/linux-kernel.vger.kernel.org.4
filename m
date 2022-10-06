Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C124D5F6241
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJFIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJFIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:05:19 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683333A3C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:05:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p5so1283256ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aQgLDXbifM0rqp5u4DrjFvn4pd5ZSxqJ7lQA2KzRsRM=;
        b=nl346wPBz2+HsobbRx3iQ6LR29S6myMXMumDS5sYHXz9p43T+o9hd5fQu+RaAgYz0i
         1aBUgoNG5LAXoJxu8SX3e1qJAO/F0SOLDRSKaJaZIVCGkmzGTnXXWOOWshx47n9N/wrl
         QtJOCmq4XYN3DuKZhtamBUTztnozPdrshNvSGbXIGnckVO0Z8mct52GLxUqXoxmua84E
         5ZpqwnJ5XwnQD64InAYCSnYB06bN1UCqOn0VJacJRPatbYBWugEqOMa+Av11wocj+OsX
         h/KmS28HXbXOIipksROVro2kjIDNv8cspihYiLg/y2ge+LMo1M2PNhB6JOpcciV2RQGZ
         DdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aQgLDXbifM0rqp5u4DrjFvn4pd5ZSxqJ7lQA2KzRsRM=;
        b=CDlqeeuofUTQwJP2QThwWyugzqYxSsYmzwRsRBmHt3NU9VV9DjUZHRftGppf3uOtsL
         YIRWLoV/dRj6ElfFLhtW4XXcmzElxxYAjIBAZlgnO/XL/o/kQN6pteuxbslXOr2dZcu6
         RyalNH9atBp5GGC/jxSXQuvkgRpIEn3kNwFH+ZwgyFJPqbeSqD+sv9pwszY047nBkndS
         hbXPlOv5vrIJH+A/mPEbdcqIIBiN3wmBE5mmkeKFb0JnXbOcNRXU1Xe6y3p69nyR7Skx
         wFg+dQS5DO/TIpFauH0PHeafFRi75Ov63ULh/+N/YSBfnFSvkVUG0Q5RTWoLCcVqqvDC
         ZtrA==
X-Gm-Message-State: ACrzQf3RbUyXwhsxWuYt600qtMnqA4I961LMvz8U8cFUelJoWUVP1IgK
        AC0sNY6hkKoX4KNs6G43CnI6yMyBPk8arA==
X-Google-Smtp-Source: AMsMyM66BFjYxr3ivdx8GpkEc0toNMv635YO4cwYw2Vl8QNCfDoonAVvuantTB0QAWaMkiNDHKmZtw==
X-Received: by 2002:a2e:b046:0:b0:26e:2a8:df8 with SMTP id d6-20020a2eb046000000b0026e02a80df8mr661441ljl.241.1665043516344;
        Thu, 06 Oct 2022 01:05:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b00497a1f92a72sm2614650lfe.221.2022.10.06.01.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 01:05:15 -0700 (PDT)
Message-ID: <ba4a2a81-b3fd-d000-48f4-ec2270e2810d@linaro.org>
Date:   Thu, 6 Oct 2022 10:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: add xiaomi,sagit board based on
 msm8998 chip
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221006075125.1056605-1-dsankouski@gmail.com>
 <20221006075125.1056605-2-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006075125.1056605-2-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 09:51, Dzmitry Sankouski wrote:
> Add xiaomi,sagit board (Xiaomi Mi 6) binding.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

