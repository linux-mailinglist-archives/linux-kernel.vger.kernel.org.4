Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F856C932D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCZIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCZIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:52:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548E7EF9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:52:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so24115651ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679820735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1G5XuG2O44rhuRS+cdtjXkMOG1YaLkvmFPo9d6ePeQ=;
        b=kt9fmK2m0EiBdcWA/bhdn34lSYAf9VIEFlhYgE1guZ9rrBz7zO8tOE0YsSuDxaXLsd
         AystX85dhnq9pPaS7QQuGJMwhiuROindN2L2dpc4nO42bq5kRAxoxRDK/3N0i+vG4tm1
         zbrr4ToalhuObWk3ViDoIXBekoMpMcXhohlEStpxktqu9111oPyW3tv7ASk2ZUZz0M1j
         TeHqYdi2W7gCNoa6xMu6oxFYzVgv2yU2xY0Di7UT3SLKdYq8+MTnqZe0524j/vJN/PSJ
         GL3Av5csVCx8cCCK40uWMI5k002k6P4y+ZQb0sM4CHKWKghWwW+jIG7dVpwrV5ELIv/0
         k+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679820735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1G5XuG2O44rhuRS+cdtjXkMOG1YaLkvmFPo9d6ePeQ=;
        b=IROlMq9DcNkExRhtA7+1MrJBpoAP+Go4nM520oLD5IkHt2yPSdLvmuYxjlGcCRVLqC
         m+YPujcdMpz104BixpRH5/3lnu7ekLe8eRqkARMT+PWgoq7Vyb/9Njj5VsvnWK1IVbwG
         vCH9wMuYDEW1fnNXGJ6shMQ0UxpvkP6xWzaLIegHR45tVJCbmUUepPyub9niq/L0URxl
         MEfJxZsX1AOAof7Var6SeO4jYyAxg5XsldhUOOPzRGSqCl1YL3+unNfSXXnI5ji3Gdgo
         tk6eKZ0w/VCv6A3TAn2ZwDWQVLwxX74x9yka5hlrgjNYovwX864Pd3aaXjhOdAx2serF
         /q5A==
X-Gm-Message-State: AAQBX9e3/XcgPedXURTOgLBPHn9lgjOAw8UtuM1rDNztFp/36FyjZub8
        8Mv8Rlu2hwPXfN9nm9c2HGTcuwM2i0EKmCAFpYY=
X-Google-Smtp-Source: AKy350a4Hf2pni90dnhLjgH1jLAjpW5maFCPJFgbsuds0EDN8CGprK37+v/57FDrATumfl8wg8VLiw==
X-Received: by 2002:a05:6402:1390:b0:502:2382:5c24 with SMTP id b16-20020a056402139000b0050223825c24mr7067869edv.39.1679820735349;
        Sun, 26 Mar 2023 01:52:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id z17-20020a5096d1000000b004aee4e2a56esm13223831eda.0.2023.03.26.01.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:52:14 -0700 (PDT)
Message-ID: <d827dafb-5b97-7ba3-542c-e3f60d4fb468@linaro.org>
Date:   Sun, 26 Mar 2023 10:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Qualcomm SDM845 SLPI DSP driver support
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325132117.19733-1-me@dylanvanassche.be>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325132117.19733-1-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:21, Dylan Van Assche wrote:
> The Qualcomm SDM845 SoC has a separate SLPI (Sensor Low Power Island)
> DSP for sensors connected to the SoC which is responsible for exposing
> sensors to userspace, power saving, and other features. 
> While sensors are connected to GPIOs of the SoC, they cannot be used
> because the hypervisor blocks direct access to the sensors, thus the 
> DSP must be used to access any sensor on this SoC. The SLPI DSP uses a
> GLink edge (dsps) to communicate with the host and has a FastRPC interface
> to load files from the host filesystem such as sensor configuration files.
> The FastRPC interface does not use regular FastRPC Compute Banks
> but instead uses an allocated CMA region through which communication happens.
> 
> This set of patches adds support to drivers for the SLPI DSP:
> 1. Configure the permissions of assigned DSP memory through the hypervisor.
> 2. Allocate a remote heap when the FastRPC session ID is 0 instead of using 
> a Compute Bank directly.
> 3. Add the SLPI remoteproc resource to the q6v5_pas driver to enable support
> for it in the driver.
> over QRTR.
> 
> DTS changes to enable the SLPI DSP in the SDM845 DTS and hardware
> e.g. Oneplus 6 and SHIFTPHONES SHIFT6mq will be send once the driver changes
> are applied.

No, as we explained on IRC, we expect DTS to be sent the same time.

Best regards,
Krzysztof

