Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA946F6DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjEDOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:39:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E1129
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:39:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so926519a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683211169; x=1685803169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RtHFIOyHUHDm6OwF3/rRw5NdicRws7FTGgdEZwPjkL0=;
        b=B2ywh6muaT5cNRLxTdpb3TEH/PiIrCqdXYixzvXno5GZTT0ZscAElKb2bmGGt2PxHR
         /OudDMGAa+SYwMxo5fUixcqCVy1/Malqex3Hr8MCOIX3wHyzpLbAXr2kovOg6hdJqacT
         W8CjMqQZMpaV1oSgry9csxJq6ob8N+tHo9oNEqVJ1Fff8skrMNxBl/rZcVK5MDTOi/TO
         /ZjkXUFVBynZE2GU7NA4iNZ/iFfAJlEhz7hCm1xOYo/DdETSzbBaFgS2oAroY0CtX0ry
         17lAR5bXcJmJK1qpPq/p7NaN8h8NZ8vi5flVyaEx6ACgn9Z0apLJ1a2+GFHftIjAHWTh
         br4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211169; x=1685803169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtHFIOyHUHDm6OwF3/rRw5NdicRws7FTGgdEZwPjkL0=;
        b=dD27hGrt43vO3TMkgEYwRD8uMRxvxpPf+xgE+Fpd53ylkAxh4IH2WEFqX2ruv/ppaH
         xzBJv/3pT6A4VBpfNXNuUU2uYcboLzXRj6V9kJivTruEkDnaJ5nLa3rxFlxgw4OiT5eu
         E4x2ravY4dp1E/2Om+ShyyJLPbPrxSnUOiQ7/Q6z4Lxpm1GVKoaWXaD684Wol227FE0s
         LyRZaPWg7CJ7Gcl2NkjlEK0/t49iexBKO7bsKb8U8BYqIZZ/JpGNX/5Iy/s2THTUe5Q2
         DFy6kSv/jdj8RDnohZ/MhP4/CASqZrTVQCqnBjhaT5UYp2M111vFNXZBSonq+04l2NR5
         Tvog==
X-Gm-Message-State: AC+VfDyyui8qioxL0tP8z34hyL6ZbEwNQ4rUNR0jn9ysK5Le61lop4VG
        PRw8vZiiSdw/NF4tlCczHBrhaA==
X-Google-Smtp-Source: ACHHUZ7Z3L26zZEhzBRypzDcsBcd1kRVAs82E/aA2e4syMmGyPokB7NYew5voOG/UPvwcxk9Hlq1gA==
X-Received: by 2002:a17:907:9693:b0:953:9b27:8f00 with SMTP id hd19-20020a170907969300b009539b278f00mr6645560ejc.74.1683211169112;
        Thu, 04 May 2023 07:39:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id d1-20020a170907272100b00965bf86c00asm302384ejl.143.2023.05.04.07.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:39:28 -0700 (PDT)
Message-ID: <2490f7dd-9b6b-2865-4e44-37808b167c11@linaro.org>
Date:   Thu, 4 May 2023 16:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for
 RK3588
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
 <0678c24c-33ae-7e99-7bb6-d15dc5a7ed76@linaro.org>
 <a5d4a5be-b658-d9fe-59b8-69199329446d@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a5d4a5be-b658-d9fe-59b8-69199329446d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 16:14, Cristian Ciocaltea wrote:
>>> +        reset-names:
>>> +          items:
>>> +            - const: phy
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - rockchip,rk3588-otp
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 4
>>> +          maxItems: 4
>>> +        clock-names:
>>> +          items:
>>> +            - const: otpc
>>> +            - const: apb
>>> +            - const: arb
>>> +            - const: phy
>>
>> Keep the same order of clocks as in older variants, so you can keep the
>> list in top-level place and here only minItems: 4.
>>
>>> +        resets:
>>> +          minItems: 1
>>> +          maxItems: 3
>>> +        reset-names:
>>> +          items:
>>> +            - const: otpc
>>
>> Shouldn't this be phy?
> 
> It seems there is no reset for PHY, or at least I couldn't find any
> reference in the RK3588 TRM, nor in the downstream driver implementation.

OK, just to be sure that this is not the same reset as rk3308 just
differently named in consumer.

Best regards,
Krzysztof

