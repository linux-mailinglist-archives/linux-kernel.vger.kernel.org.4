Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85C6F2EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjEAGu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 02:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjEAGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 02:50:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39510E7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:50:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so376515066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682923849; x=1685515849;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmfakJyJ085CMD4GQLofByV7lrpo3TGBA2eksmYMx+A=;
        b=kBlfr5LUgtNX7eQfKbJiRZZKZQFZE0kZSUyXUf/KZ63mhPPLYl/Ip8Gz/G0spsLMeB
         rsfyJPMoH6gU404ptKj33Kgm1zglcqMmaHTVOHbv5b/yRYxNhunJ+CwrHImNLtD9TxE9
         4xQTONR4UUvLB8EPlKZ5k+J/rsbRKVTbh9+tROjYg1SXDBBvlOEM4huDz7V68cv6eSKD
         S40skqSGMXQ4D7gAeGfQVlu19jPx37R3ET2UFeT2kS4UyhSY1lhDAldvhRDKhuq1XzlH
         Omjk9ujh1VYqIjXM091yQ59wSZVHPHRc33F2K/8iQRFErZi8uEqmskEFgW2KMwbO3X23
         0CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682923849; x=1685515849;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmfakJyJ085CMD4GQLofByV7lrpo3TGBA2eksmYMx+A=;
        b=N72iQPsGr/oyGAE5v7tc3cxwRc099XHKyB9DTip/aVRAiWOxMLgWLRgIEMeSQQaimW
         iyoiuPwF6lzKErJYoXBun0BANF+LQomnTq6JhCl5hj98Of4IgFMFP8CMfs0/6/P7Uky3
         4u/k5+KCbYnw3tWufN9FuX5P+/sQZv80J06/98xtQ5eLx0RxnXt58p0uK85XOCFaRL2o
         dZDBrHgcghIMI6jcB0YBtrVWAKD1pIBkbesdZZoji97tpVKOyz2hU+dGF1i+S5ENCCrY
         E5MGj4ugi5ah+kOekFSORKK67jOp9MNGKhYTlR/GuQJM6rtcFS2GYEzQP5WvYsd8upc+
         9MIw==
X-Gm-Message-State: AC+VfDwKsoQngKhFehjNK7NeWykud9nL6zd4sk1VQ7koawd3o4Gs5Ac6
        FR8TZPtIDGmlZeomCrae4OwlKPpPG5Kdbc84ZjPP2A==
X-Google-Smtp-Source: ACHHUZ4UN/tWi2v8svN31Md4TgO+qZrnt5qSzqelqsmcIksJksKKWMdy7INeSt2NMjYwK8H7cB+s3Q==
X-Received: by 2002:a17:907:6ea3:b0:960:7643:c970 with SMTP id sh35-20020a1709076ea300b009607643c970mr13921091ejc.26.1682923849284;
        Sun, 30 Apr 2023 23:50:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906844700b0094f7b713e40sm14271740ejy.126.2023.04.30.23.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 23:50:48 -0700 (PDT)
Message-ID: <d619469b-93e0-fcb1-162c-affad9b4bb3d@linaro.org>
Date:   Mon, 1 May 2023 08:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018
 family
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230429193336.600629-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230429193336.600629-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 21:33, Robert Marko wrote:
> Add SOC IDs for the IPQ5018 family.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

