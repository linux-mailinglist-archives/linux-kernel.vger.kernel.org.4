Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED96FDF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjEJN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbjEJN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:57:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99551DD95
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:57:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so13825738a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683727042; x=1686319042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+DF7OGInPZyCUnAUInyj/96xWmp/Hi9F+tKcsy2ORw=;
        b=yJzOXYE/xy9fBn2DYuONeh/AOt6srNw9UTcYYwrZFhNRHuJkq0RHSMvptFQWXo5jc6
         T0fjwG0asLvxOWooylILrfY/9DBbpKrT9mlIvNbW1zF6efoTObdQ1C/2yPwIHag96cIm
         s+j/c8MQUzc/ikPNmaG9TiAIlWtjVOGubjjP52AFxBNhdVbOf794MGyJJO1Dj5MeDCgy
         wZuNXRDXjOZnK8xxm7l17/euaxbMLSvBguUSmkuBh+VBXJXVXl5BB/YmNxeqk9LB679i
         Fyb23eZYXQn/VxPnwdvnzIkged7DN/Xbvd3TTHiAki/CmhPgGwH3Rid+BVGId3C50top
         U1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727042; x=1686319042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+DF7OGInPZyCUnAUInyj/96xWmp/Hi9F+tKcsy2ORw=;
        b=T8dWl2WYJ+B064LyOAVuLgFltuX0teiexF8rBnVDjzu4g38NFU4hDws/ErxM0zGxCe
         YI9A1G1qtgt6SrB68U7rProZ8h04gLxukTpqG4AHG0KM6ZyjcTzEGm0NqMqevmYas65u
         9rFmBuWmUoryTpar6ZRd3wuQjI39EbEQBubNumBVkcegI3POVe4XQvr2NaSt+DHCbHji
         dQTcpKRxPwVuR1Fo4Ki+M8dOwjFeP0NHinIQjo0CBr8qGLIm6VBlva7WlRvKNyII6zl5
         TINAUWkT4TNGDEEVEDNQAmWf5M5k3o5pvVFBSw/07OSyVDtYFAnX3zbcOm2PoHDy5aJy
         IKtQ==
X-Gm-Message-State: AC+VfDxiGf4t3jqWTy3jvPrf2DO2ZZDgyIUFANg35Icnnm4psvJenEpd
        vTY6vRnPnVhMdGDSrQztxcyo6g==
X-Google-Smtp-Source: ACHHUZ6cmdtzc/F8QJ+OVdwn7vxhY07H9LADiEK1jviTuemzNY34HdNTeZ62G10wpthFVG/7PaB39g==
X-Received: by 2002:a17:906:4792:b0:96a:138:c1a0 with SMTP id cw18-20020a170906479200b0096a0138c1a0mr4895575ejc.9.1683727041764;
        Wed, 10 May 2023 06:57:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id wi21-20020a170906fd5500b0094edbe5c7ddsm2739068ejb.38.2023.05.10.06.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 06:57:20 -0700 (PDT)
Message-ID: <0023c59a-1538-9a6b-ff74-9e26ad1f4308@linaro.org>
Date:   Wed, 10 May 2023 15:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: qfprom: Add compatible for
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-2-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507201225.89694-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 22:12, Matti Lehtimäki wrote:
> Document QFPROM compatible for MSM8226.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bot's errors can be ignored.

Best regards,
Krzysztof

