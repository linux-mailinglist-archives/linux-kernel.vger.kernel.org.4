Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46B5F2267
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJBJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJBJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:54:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C34C601
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:54:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k10so12843316lfm.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9D/v1iQUh0ooMqPhNBkoFRvVRHxHogSQdEWPpN5Jveg=;
        b=abp6LlJfR8XGpzHJa7WU7vfitgblEy5OzcxuhOc6GYNCw3Dwlpplj1vB8LtE8gyEEf
         OiwP9nL+sia2KcNBSs0VLPeHy7sy9ONA8vXKIr6bNmTU83MbSMmQcJ3c3k3xMp45T67D
         eTAMTHsyZsoNB3VDF/rYfKHj4ojoVWqCbJzUKsZ13hMfidVC5aYrw9zx3Kk7moOVaIva
         h86Td7tbxj70bDjt8mhtf4c3GzRFAMJ7nn1509tcrP//MXrggTwEBebP3uLIHXMlObNO
         CWCXqL7v9E3cj1u3I20qFtPdIRI5BlXBpXdFtrdfurs4UeG/v62O0Pzzwn0UQC55vTLq
         JtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9D/v1iQUh0ooMqPhNBkoFRvVRHxHogSQdEWPpN5Jveg=;
        b=lCXCDbknP5Q0GHekOgoBcE4gjcPPIOodGbh1LKsOjPU14GY4l72EVR6RjbfLKXrzZo
         AMlbcDz4d4pWYkfu3GSasen3NpmOFoabxu+AyAYodAOUKgFFTebjLeKhUpv7wdi6eYaD
         6a/Sw+Hk669VUAg/g1Qbq8458pfQFwdyzPr6/M9iVgH6rY8VEDoht0ALuXeGuUJF5Fsd
         JstzTFTkn6Ez/NKXQ8jPEHAcWKyHcmC01qrhTT50l0fiB+yYsoA4uhncEWbAMSFpTuQg
         TP+1SxFEIuwg8K/Ps3etLw/Hh+mlXvleIQk5iaM9UggmahvvSXXE2w2pdcZi2S4DLgEY
         RzYw==
X-Gm-Message-State: ACrzQf16yiVRVJTBUH9k1cbY+ZDFsvR7ocvfcuCy9QUFLgWfX4ZMCUq1
        ggHj2puzrTFIE09A5FQ+nSmltQ==
X-Google-Smtp-Source: AMsMyM5REZ14b/0IRTo1CUYbHIPHIbthp0cClLpq6doOtBk8cdSr8bLkfLil09f5LdiXYQntcKFNzA==
X-Received: by 2002:a19:5f4b:0:b0:49f:a4b7:3f1c with SMTP id a11-20020a195f4b000000b0049fa4b73f1cmr5488979lfj.333.1664704453094;
        Sun, 02 Oct 2022 02:54:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g12-20020a05651222cc00b00492b0d23d24sm1030969lfu.247.2022.10.02.02.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 02:54:12 -0700 (PDT)
Message-ID: <1a1e68c7-9314-0096-b069-78a9532c44ac@linaro.org>
Date:   Sun, 2 Oct 2022 11:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display/panel: Add Sony Tama TD4353
 JDI display panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220930180812.32210-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930180812.32210-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 20:08, Konrad Dybcio wrote:
> Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
> Compact smartphones.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

