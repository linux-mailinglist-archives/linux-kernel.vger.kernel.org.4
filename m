Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B764EA5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLPL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiLPL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:26:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC755A8D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:26:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id cf42so3057218lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijWttUWVsbhHZn4LhbIQN7vTGHeglSXzhGTgjwKCHrs=;
        b=BApY2HUYX5jfRg/ED+D6Dvt4oqpujq+73E9c54TdioVyZf26smlPHX3+8j1sKBCCik
         uKJ0I6nXju93Wm1xT11UvJJqwwYYScq2MnWuypWb1ZOgDR9nEsogoJEyj7iMPIlWRF6P
         K6P9mmsrFT4WoyDabgdMMGYiww3VxyO3d6dcjwAonV6r2/c7Ip4LgHGjipfaFu/sq2YD
         2sYII1iFNmpISpIpwVA2JX/dsxv+4w6wKpTsJcIcvqr3MN11OCswvr2fik+UIBNHB33s
         Wh37wO1lbPARQRSbJrYuk2ZfKTquKmSMhw4aCinCWwo0PA+LfOkDhyLumDrKbmFSmPih
         1Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijWttUWVsbhHZn4LhbIQN7vTGHeglSXzhGTgjwKCHrs=;
        b=KSmvTQgJtD1tSBbD6SYvuzacwlhKuOOQnKVjgrz/P1eehCY6ORpnRXjYqHq9YG0c+A
         F9Nca1gPG4odY8R5Yvr0fn9gVfrl3M2M5QZU4ZU0gRSUmwReweUSmYrwtBEVZipw2hUH
         2C2FFaKpeXFiBd+9mx80/HqsjK80LRShhrmmu/V5W7CBqZn9Oi3gT5BPgEZ8xY2Ao0Wr
         aR9E0TbZKEQSq8C6ejfEf+U6dghQm6dEKJXVHafnnYmq9GgVA9yXMlZEpMKrwtEiZvWF
         d6hI3gKdVi5nr/T0OFjYu9HSyzSfmyytESFHLpHT7i6EzmNgDSONv6P8dZJWHkAzOViz
         dzFg==
X-Gm-Message-State: ANoB5pnI6JvM80L8WVRR4PQ7dLjWFfrOFwdOedUvp5zcIT61xo4eaU8p
        FJcpTu0d42MwwKZnEpkR2oQagA==
X-Google-Smtp-Source: AA0mqf7kDhXi1vitDJl/sEJHs5hMVXC2c0ZScWKbCnxyQnShcZR/Q29dejmivVTVisYrz2IjnIXvhg==
X-Received: by 2002:a05:6512:1296:b0:4b4:8bc3:21f9 with SMTP id u22-20020a056512129600b004b48bc321f9mr13076525lfs.36.1671190006641;
        Fri, 16 Dec 2022 03:26:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm194810lfs.37.2022.12.16.03.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:26:46 -0800 (PST)
Message-ID: <ea6acf8b-bf83-391f-d235-0aff111d4dfa@linaro.org>
Date:   Fri, 16 Dec 2022 12:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 3/4] dt-bindings: arm: qcom: Document
 xiaomi,laurel-sprout board
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221215190404.398788-1-they@mint.lgbt>
 <20221215190404.398788-3-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215190404.398788-3-they@mint.lgbt>
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

On 15/12/2022 20:04, Lux Aliaga wrote:
> Document the Xiaomi Mi A3 (xiaomi-laurel-sprout) smartphone which is
> based on the Snapdragon 665 SoC.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

