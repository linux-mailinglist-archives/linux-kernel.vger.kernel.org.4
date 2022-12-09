Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064AE647EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiLIIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:04:26 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F05AE1F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:04:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id g14so155312ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTLraVCW2+yq4yH7aq+Ix50RknoV/LoBc1AGTJJK5cw=;
        b=A3AsGw2XT+w5SWlTLYvwfRD1wHSdO8O0JDyKh18jGNzuCK4AnFZl6cyNL3bFmnv6Nv
         mpQ2/hMwx3M9TXkz/hBqE3D6T3WKbjxbQKYZp+ShBpqdmb9rDIefIximFKAVKEP29crb
         5iKa/wA2tpr8Jl5/5fWEnwEpkOMRCDtGqa73uQDK8QerEPREebrO80kJykoDZbBLUf85
         aZ/tJorHgkXFyB28eTooXiphagesbqpzhZZrlbaOXhE93AtzMnIumLkdF9hfMvCcMi+E
         EA9oLH9jzOpAGwR/yXS3OL3kOi4y5JhhtmKRnvkqAl3CQu01RoeXzYqu6+bsDB18Dkis
         n+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTLraVCW2+yq4yH7aq+Ix50RknoV/LoBc1AGTJJK5cw=;
        b=hRGoOL9HGy34PzV2DWpSdIgq7SymrJQ29F/6yAAJBrGYwJyNEhjyMy0xpZmjiz/vlT
         yjdKVBFRfzbxGI9oCXOpw/XsCf9uNA+quVeYPCD2YOSy05eAxMd93agjkk5SFAgaCGDE
         9lwgr25fIeVx0BzOPaLn9KMk/B+EaAs6hQRxnMqfqiZTvi6QQnn2/i3ZGdWfu5EK3rSJ
         R/ZGpeiHzq4b9qNBCCVaemb30EKyCiqxA4F6p9It26z/4+BYMCGlhFSAlApmYAL3C2XU
         JSMdwrDRuuIJznEt3YPK0BP/gXHo1jDlNftTWfL/4btC2PpTHcUizkyRICAJCz/+fTM3
         tE+Q==
X-Gm-Message-State: ANoB5plfzkpISKzf1HmI5C9B8Z89gkjxjj+UvwWKe8UWctM0Ogow5Dpl
        d6E+z+ZfQORzsONS8QaQ/TxN9g==
X-Google-Smtp-Source: AA0mqf6U+cJ7mLtJ30Q9BL1pN1jGQzIzm+3FHYTR5SAC9qTGyhS38TrtEta+6S2yRis/6dlhQN02Yg==
X-Received: by 2002:a2e:ab0d:0:b0:279:e1ba:8c6a with SMTP id ce13-20020a2eab0d000000b00279e1ba8c6amr1312691ljb.44.1670573063639;
        Fri, 09 Dec 2022 00:04:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o25-20020a2e7319000000b002770e6c620bsm116238ljc.106.2022.12.09.00.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 00:04:23 -0800 (PST)
Message-ID: <713fb813-cd4d-aac7-5532-131207529bce@linaro.org>
Date:   Fri, 9 Dec 2022 09:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/5] dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab
 P11
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221208201401.530555-1-konrad.dybcio@linaro.org>
 <20221208201401.530555-4-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208201401.530555-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 21:14, Konrad Dybcio wrote:
> Document SM6115P, an APQ version of SM6115, which in turn is more or
> less a beefier version of SM4250.
> 
> Document Lenovo Tab P11 (J606F) as a SM6115P device.
> 
> Add SM6115 to the msm-id list of shame.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

