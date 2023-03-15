Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03CD6BA9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:48:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806E5DEFF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:48:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so20272052edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gax8MvMg1DOUlwwBrZgEG/es7RLF7q+oSLYyGkeXTSE=;
        b=wNhuw6XTpZRwi1j2IZDsYiHLaJlvyVqVb+YVKggO80ujxo21a08ckuCaEHkeAu8l0s
         hjYIxNbyO2SLTGrhyYN1eWQtS7CTl/w1+ch8vn+hUl2mgY9HuWj/RDw3a3uXjGTipskW
         RM4dj4HIOQ8B3J0IqvmnJiEjVrcm0Q0GaO5vesU0moaRwcm05M1j/2V+y2SXivhJJbeY
         m3QD5yznf+adpDGiRHp0xk1DfA+RmDg/2H+RFp/a/ZI4VVTdKnImkgq3Q7EM5JH6HNmh
         S1ZkYuiJdvi+ipQfx6bbe5PHxUHfUj66IJ8+0GXPcJ4SR/VbSwD83szcrmgeo+R02ak8
         E3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gax8MvMg1DOUlwwBrZgEG/es7RLF7q+oSLYyGkeXTSE=;
        b=CFhV4tKEGt4A2ycEZxwZfpOJvHtCfF+KXxO2vWskL9TmMtFRRWT3hDeqiL4TXDoNqG
         +na2bZLJHDV+g0M31XH4ShdFDch8+o2IVr3z5SK5aYV1r+s3hwvri1kggNC7QfFf4+VG
         2wmQTC2O22nGPPaJf/ZY8jK3EtnvR00Eokr0enw3unTiO5xSrL+X+Vv1eGpy0wQGlbk1
         9ko9HXEWYMWhKSFOzhC27agt/S6RTlom+2T0KiWWHT615oxrJrFvECC0Ew76n23lr+U7
         Wshpa8DdmoGBdPI49ATph2M/LKSqvkxh2wXaPJ6fDPvN9u6FAjQ2CrzA3DpG10l9S1Pl
         PrQQ==
X-Gm-Message-State: AO0yUKXl1++tnb/jir2fZz6BmI+HpV1rYuSSeWF/io5j/8XHKDXY3CmB
        Q78bvEHxGMq4HHveJBKcs/ZsIw==
X-Google-Smtp-Source: AK7set+k+9Tx/CniZwmIAeyGG5f35OIuLnJpJsP7aEFaKL95FjaIjo+jaKR6pE9Awkyp0rI/5wHiXQ==
X-Received: by 2002:a17:906:2d4a:b0:920:254c:1e2d with SMTP id e10-20020a1709062d4a00b00920254c1e2dmr4812821eji.39.1678866498461;
        Wed, 15 Mar 2023 00:48:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709061e1100b00922547486f9sm2140778ejj.146.2023.03.15.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:48:18 -0700 (PDT)
Message-ID: <45ba1417-4b98-91d1-cadb-5cccdc0a261d@linaro.org>
Date:   Wed, 15 Mar 2023 08:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] dt-bindings: watchdog: qcom-wdt: add QCM2290
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-1-47e26c3c0365@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 13:52, Konrad Dybcio wrote:
> Document the QCM2290 KPSS watchdog.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

