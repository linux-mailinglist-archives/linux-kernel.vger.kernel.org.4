Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A3629F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiKOQmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiKOQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:33 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479E2DA8C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so25326672lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ez8EoWu/H3aBC/+f0SycFl5mR03TQOT0SmdEbSc3iLE=;
        b=Yiv+8qxNnofTjNee/iGZggh3HuIlXjcbiKludGlJMfFjLX2qAJgr0Dboi1Gezma/tQ
         hc2F/an4GK5Q098TEDZFhJI+0gm5cGgvlL2fuZZv0/YI8/CDdhl4LxC0BDduiBU17YXG
         zw9eA7mdO+YoAWKN32sC/WdnCpBnvqNt4Kd4ll+956VG1vUMqTIXYgBKb3Ccz+C3chQN
         Y/YyyoEc1GmaiWh8x73kHKsDh08yiilmaL1p/NJ460Pii71Rka7WziFCiaNmVgqxQsUw
         NHHJxv0gdADQrZqn6H873iSQGRrRAJCFOnU5tiLx36xid/fu9ZJwTBvF6ZAwtj8YDxKM
         93fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez8EoWu/H3aBC/+f0SycFl5mR03TQOT0SmdEbSc3iLE=;
        b=Kv3s61iaqu0mNKWrW3KPDuzl8Taclc0HFr9PyM5MigCMRtdkrOKEz3mGNhFrjVSGSx
         ZoPrc3WQgJZa3H8vaFAaJ+H90IVVrWOmg9l6vTRZQNqAm5suhjeK86l3R7zgC8Stl9lv
         SVzhbdhIlbausitmiWn7X4hRqqtY5aHmnkrzDqv6/Xd21dR4WbHllyKIZLj7nRqANUWO
         RM/JhsBWKROWXsu4VEcGSaAnhyLNvDK2IJPL/1rQClLD5kpYzgSYJsGtdb+YdXrcCy4m
         b1G7yO5LDo+VsKR6TSb4Mt3M0wX/DDnlrdzhRfFvLK2IPHgPBGq0s/RtWnbPcLwyJ+EU
         zg4g==
X-Gm-Message-State: ANoB5pk0Z9Oe+k2TqHfIfcBl7Y98tJaJJI+HPSHh7t6qXxHujLk18ziK
        vhYCdpSurjtkscSDI+aeUy1x+w==
X-Google-Smtp-Source: AA0mqf5/v7OHUzi/dX9wNFMXaB7HgjO2RCOgWbcKjzkVZo/epnQZheAcEdEkVcEWSZD4P4uWnuJiiQ==
X-Received: by 2002:a05:6512:1087:b0:4b4:a5b5:1a04 with SMTP id j7-20020a056512108700b004b4a5b51a04mr1043710lfg.142.1668530549096;
        Tue, 15 Nov 2022 08:42:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b004b1a5086485sm2267355lfr.2.2022.11.15.08.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:42:28 -0800 (PST)
Message-ID: <d1aa5cdc-757b-b54f-0d1c-5f823ea5d81e@linaro.org>
Date:   Tue, 15 Nov 2022 17:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 04/11] dt-bindings: sram: qcom,imem: Document MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
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
 <20221111120156.48040-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-5-angelogioacchino.delregno@collabora.com>
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

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Add compatible for MSM8976 IMEM.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

