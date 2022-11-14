Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E03627791
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiKNI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiKNI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:27:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79211B1EB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:27:09 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so18061535lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pznb3lss62kp/9vpUF2n3Y8c2L5VYI1cmHItIlXQI5k=;
        b=GfrZvPIeQkw3jwj3+UnqAFyWIJa6jMLbZF/c8P3I6CyoKIoI8nbAJTAvhCI0YulAAP
         OfpBnd5TWXJEqy25N0Mh53pZxPReS1H8fC75nnEnkoL26Zh1ce/pgTGRrR96yQpb/m0K
         Wbkd9k3HZSwKUrFFutthonM6Yb5ImnLjI0U17idQ4WySuVHW9IJABp0vtyJ4Ji6auVTo
         f6O6sg9Bv3diPkNPAmFzBW4nVG2mMze3ZcXcpK1FD7KPYrYiwCCcOXW7t3dvSk/romKE
         nuRoeM67wXd2aBr2sAO+9q8Guk7LXsDLv4GyfVqOhdjd6MDKfJmt2MC04C1WsaBPwKor
         y6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pznb3lss62kp/9vpUF2n3Y8c2L5VYI1cmHItIlXQI5k=;
        b=J3Bqkbl5NTQlr8uZadmy1wSXOgkltdzObC6bsts9xf1rkHSGHSGQSMQkLlpRd3zmrz
         0lDOz+QjwHwEmTwt0GpIAf2ypYFeCkTq43gCwfNY1Q8XmhJ/Vcopk1GV12d+3072Z20o
         MSyr6wKRLkofjL7k1+BG72F2xW1Vc330il5moDwm4Guc15pKoT4hiiX6f7VVZC/+FCsG
         JKj0pjuZAvJhhDAS1cwwm/cdhiuoQ7lJ+eNB+h8z8DeaRgK//k0DxCnh8oKOe83eI1U3
         DzCWivQfuq3AUWpia+SG6cpMU0g+Oyxz5e6JhitLUDwnokGzAYTSunDKy9tKNrmBXS8K
         TiLQ==
X-Gm-Message-State: ANoB5pk8ZdKfFs0Rd9EYF/f8tMOyd8zxZifGYCHpXZ9USTe4nwd2Dovr
        caXwaOl4Ba+teF+AE4kAwDCzkw==
X-Google-Smtp-Source: AA0mqf7JFrSrorupEiXIioajIGbVvrEDVY+QmgIKM+OyCbKymY/6aj6BHtSbJsfCSRgPrPCGKEYkzg==
X-Received: by 2002:ac2:5093:0:b0:4b1:753b:e66f with SMTP id f19-20020ac25093000000b004b1753be66fmr4272220lfm.276.1668414428327;
        Mon, 14 Nov 2022 00:27:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c14-20020a056512074e00b004afeacffb84sm1740872lfs.98.2022.11.14.00.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:27:07 -0800 (PST)
Message-ID: <78fb82c7-df70-4a94-b57e-6e94ac9e8d14@linaro.org>
Date:   Mon, 14 Nov 2022 09:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/5] dt-bindings: net: ipq4019-mdio: add IPQ8074
 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221113184727.44923-1-robimarko@gmail.com>
 <20221113184727.44923-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221113184727.44923-2-robimarko@gmail.com>
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

On 13/11/2022 19:47, Robert Marko wrote:
> Allow using IPQ8074 specific compatible along with the fallback IPQ4019
> one in order to be able to specify which compatibles require clocks to
> be able to validate them via schema.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

