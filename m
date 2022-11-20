Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6263136E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKTKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKTKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:46:53 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED997EBFD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:46:51 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so11722597ljl.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDdOcvax+kaSVupODZDqCFBFNGPZbM4m6La4Ab5xI8w=;
        b=IwKfYYMu6h9ilgr1Og+8aDIlga1t35Q1iVVyLEmdBM0o4QCLNtyvwn3pRTycyB/6Ne
         QNY37mOmGSC+W9xBO4hB/5+A5VifQcpuRQpdQpfnT5L9dNpsLJVr5LAkAeoBT5f+1ov6
         iyhIy4EG5eHDdgoo6fEcN25+NhKcxXQzIfxP/F3VZSBrvLv/TQn92tu2MW2EnQ6kS06l
         i987BlfHVB2zLT/U9rEwAVBe1UFHwb/9w3IsuPLH1LKD7Wgb8zkBiFvNCsd7kMvB9LrW
         HN7ut7PRBElsXPFiGphTbIgGlYe5me3aSettGoqq5QNihpwPtj3BPSR15f3dx3s4xLvi
         TfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDdOcvax+kaSVupODZDqCFBFNGPZbM4m6La4Ab5xI8w=;
        b=clUg/hoqx7HqspX6dioJ0iho9lQBXxCWzOnC6MCoqTFjI0B1Hbs1U1glwJBABj4icV
         GxPWvuTeIM8M/siPHoQ+SZnb7OPx0iX0y5tpEVF0UOij/ox5emIt8DqhTCW3ofBo870P
         SaXHo9u8pji0h/x6lEhtglI6201R45oEzw+Ul0diCt4kQAvWl2cFJwaWpmkah3RX/anm
         BHW5Bc8O2LjsMUO8Yb71at/N/oyDdOXDuI9VFmpuhY4yHsgx88jV5oiR0KujafhPIOs6
         27H6V3tRcOOHvcbSKlxlO2rKJFOE+X/xCQ0f3FyeqnfF/QR4EIisOzVlVYxqRaqMGxNo
         2VTg==
X-Gm-Message-State: ANoB5pmi26B9bBBMs7rNQybvHoj6xIS88Mas/5mhwmt4uLy+40V1CENf
        Zpf143pnlQnE6ADjYmUP7H93KeJCtoYCwFP1
X-Google-Smtp-Source: AA0mqf42FPxY4QeXojDLve6EJMpvTlOJkvVBa1o1rvziubqCGrVqK8AKJe/7UGCrtxGYnye9LcMKtg==
X-Received: by 2002:a2e:97cf:0:b0:277:515b:3dae with SMTP id m15-20020a2e97cf000000b00277515b3daemr4546009ljj.487.1668941209755;
        Sun, 20 Nov 2022 02:46:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b0049480c8e7bcsm1496715lfl.176.2022.11.20.02.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:46:49 -0800 (PST)
Message-ID: <e0affe06-1bb6-65d3-8dff-59e6b6fd7107@linaro.org>
Date:   Sun, 20 Nov 2022 11:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: qcom,pdc: Add pdc for QDU1000 and QRU1000
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221118182512.10916-1-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182512.10916-1-quic_molvera@quicinc.com>
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

On 18/11/2022 19:25, Melody Olvera wrote:
> Add compatible for QDU1000 and QRU1000 pdc.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> This patch is separated into its own patch from
> https://lore.kernel.org/all/20221026190441.4002212-1-quic_molvera@quicinc.com/

Missing changelog.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

