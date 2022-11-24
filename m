Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E16375BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKXJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKXJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:58:47 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234113FA5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:58:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a29so1765202lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5o3FkNY8E0wztQYNBZRDzwjQr1E5Q19getolsDpnSU=;
        b=Y934NnptpsehpxYHFL3pQF/dgaVwoFVWsx9OzvvfwiVx6n7ZNjm86+8rGqDonjDEBd
         w25N0OtgP9OS8EK826za6PrLotYlaOgqihSrSyzTD7xcGESrJ3F7Jcc60C14Q1nxdioV
         8ZV27AG8zxSyUyUmlnovsrnIMoOnLVi7rsrNI1iDRhG/0wFvdoXa8GhGRpm+VXwU/RAF
         F0gb51yhah0YtM6mb4z6ALs2hWTklWTFabGgpniAceLh6ZqMQqIqlBhnvuMK9tHq5kTh
         7K0Yl40akmCDoSxvWvGjV85oFhNR9NIXj5uF/261TzvzFWjYl2aG87I5S7aoo1uAXDK8
         IpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5o3FkNY8E0wztQYNBZRDzwjQr1E5Q19getolsDpnSU=;
        b=el6DjwAbzW0TOQir645s7p5Z+mvTNC1f1vKKNHd70CSn9EA9AK/WPowai5+jPAV29o
         rN33eYtZjZbeP9wm3RqJ1YMN/lUPPggR1AHgjXd1o3cLu9Gk6IJkIof8sx+YGGe3PtXw
         YS5TexNMB2/Lj7ls4AZzSwJyV+ZYXbYdlsDBx7TpMPzk8E4k67T2IKmCLKCcT8cgEpdM
         Wzz7hF44Ho/SSwgif9VknDPhsh2S+ll4vPX6+kOsQ4sOMkG1vbUeZRoF7Qdz20s4Mb94
         jUHFCgpe0XNRaa9dM4BYu8GtEhE6XlPYh/GKqJXExDjbngtE9VmqVngVGAU0E2VL8qz8
         NbJw==
X-Gm-Message-State: ANoB5pmkvBElZR6gmo/DNWbUs0Ey4+EFRuuoB9zytV66B5kwNSqKtVnn
        ZByl0osE2/149K8zRjGClWKopg==
X-Google-Smtp-Source: AA0mqf6yZsY50XGMjaHJft3ciqKK1avD6cWOrjsOc3GiriSIFlUjB6SAtDUzIA8iKHvDjwst8GEz2Q==
X-Received: by 2002:a05:6512:3ac:b0:4a9:f099:144e with SMTP id v12-20020a05651203ac00b004a9f099144emr5689849lfp.659.1669283924193;
        Thu, 24 Nov 2022 01:58:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24e83000000b00494935ddb88sm70838lfr.240.2022.11.24.01.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:58:43 -0800 (PST)
Message-ID: <ae7bb980-89ee-c55b-fb79-2af417b6bdff@linaro.org>
Date:   Thu, 24 Nov 2022 10:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,tlmm-common: document
 i2c pull property
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
 <20221123152001.694546-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123152001.694546-3-abel.vesa@linaro.org>
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

On 23/11/2022 16:19, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Document the new i2c_pull property introduced for SM8550 setting
> an I2C specific pull mode on I2C able pins.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

