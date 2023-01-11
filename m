Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A8665E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjAKOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjAKOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:48:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0E1B1D8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:48:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so9708132wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvObII5YQ4FXmxmOVeeeMaMnF8JdHID1tpzax6xmi/M=;
        b=e4Vv2cnUyPnn1Or9IpdU4GsedtxQNQFV+vFXC6V3uetfhJFOGqFS4+LvpTvochvN6Q
         ddittu7ezF5ebp/RVJ3vy0RLH4RyGkKEawkIL2CG/s9I6oVrRExuOR3kkJN14d1gEoSR
         3CVJajO403brsryQanVfl5/PoPZpMclG2Zh7TGBdfh4va7Cyq3Fs8UFZrcaNh5aJUXkf
         XxcXZwctenTiK4EaMB4igobr6XcSv0ubyrtJOmLuecJVxY0HXbWwGacC59PDyZABKF0/
         buwudvtmkCcGM/OLezRERKyHbvO2Q1NWGBj9oe0MWnaATW8PS3zdazFW3uALbsdI+hOU
         VpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvObII5YQ4FXmxmOVeeeMaMnF8JdHID1tpzax6xmi/M=;
        b=1cX565hx8G3ZIPv5uXfWEP47ZJkodI0OBe1WJaV6eVSsdPr70SoCNDUYveGzIE5W4a
         7jiJX6LgTxo1Y84wKAXB4FcL2ylQAn5S52b8LmlR/hJ2UzD6UM8AYiPluqJBYDKDBEmu
         ia6XZAGVPIaZ7ACU7qLRSD+r0beYcW+XTMrrG2FxFSjG6/k2rFHewz+9ggXAOgslE4qg
         V1WKcYX0WcbDh66gGRO7R78ohjE5c6ohAHGox9jCR+Ht7w3cT9aCmXGQjuOogtnUlYPQ
         lhEuvT/V24wE1TS4B20k6uGI6wox1bl/zTlpbdQO0WHDE9M2iHrLm2LS/g4E6NUJSZ89
         FruA==
X-Gm-Message-State: AFqh2krnj+hlw/YIEiwv9XpLam1cPUrIr7YX+a+s2OwFK0zCtqZyyw8r
        T8DM++MQ9LxaO1k/euQEhuNOvQ==
X-Google-Smtp-Source: AMrXdXv/thk3aoxTFCGJ6i6zN9q9sCeVIkuAXVMVUxnDo8TNV6PXSVMFKLcltR8/IYto2oTFzkCjpw==
X-Received: by 2002:a05:600c:3495:b0:3c6:e62e:2e74 with SMTP id a21-20020a05600c349500b003c6e62e2e74mr53355478wmq.15.1673448507637;
        Wed, 11 Jan 2023 06:48:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm17969231wmc.24.2023.01.11.06.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:48:27 -0800 (PST)
Message-ID: <8fc06bc8-0d46-1254-f553-377292e0407b@linaro.org>
Date:   Wed, 11 Jan 2023 15:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] dt-bindings: qcom: Document msm8916-thwc-uf896 and
 ufi001c
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230111141311.14682-1-forbidden405@foxmail.com>
 <tencent_CBBB183FDF1C6134607850ED023A2930AE06@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_CBBB183FDF1C6134607850ED023A2930AE06@qq.com>
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

On 11/01/2023 15:13, Yang Xiwen wrote:
> Document the new thwc,uf896/ufi001c device tree bindings used in their device
> trees.
> 
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

