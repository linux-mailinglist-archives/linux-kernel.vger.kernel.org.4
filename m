Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82716E98C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjDTPw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjDTPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:52:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021010C0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:52:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a34d3812cso86850866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005974; x=1684597974;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iWHDIdcxmRtBeoS4vbcXHNgCDUZ9mrNN4CpZaerEDtw=;
        b=bZJ618le2ELw5ph78JjrUu5vL10YhthrZv+82TUTyWvPI8n9EGNfQBVgb5D2g0dcWx
         u1oh9w4mpLpFJQflmlNuz8fsklVXvj10KcnsVKhll+TzMxAYf58Jr7bL7MtTN8CQpWPL
         i/IlZM70psKrM8urMyBS0lV4Y9pvc/HrzTw+swEho+jF9D3PLH19JXlAu1r51RODrjhU
         LBjTDzv7rUl/tZDLYGXhkePidU2BF7ewrajiKMNaN0ZlDUAYQXdUivC5HGnNy4EUNGPN
         NwsPqt7t7P2yOuJNTl9evXWMMFNj2hEDbl62J8LpnPLcjgRMNiX8R9+O9AVpvQ6zg7Z7
         HrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005974; x=1684597974;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWHDIdcxmRtBeoS4vbcXHNgCDUZ9mrNN4CpZaerEDtw=;
        b=JKnv804H6cCmzd0w3QW5RV4CnnqZio9RR6iqy9JzXJ9qL/4HkC27x6qiAKi77zYank
         mbY/UAzA00v5WA0plbeDywwe4zdSUMi+4IWW0+dji9K7xRSrSj6JJEY5XGpLTSSoOiue
         BxzeTOLmba2BAEXEvid62JZmXD/kFLOVULOb/Nt+OVHoWxVbdzd5ICjwH6Kxcp0qaxNj
         6AJKm8K89uLqSUV7kFzw6hiJkIz213OA0Iokem3/LA1eoNCd76JKc8HPfxPY8kCb2ACP
         75cXtCBTPADPtSYArBo3/d9LKgXlrJffTWrLygEWJyvJ3t/iP4TLfJ0PUG17hFKoqoWA
         3Mpw==
X-Gm-Message-State: AAQBX9emGaNUP1ipqWdNSe7VzIn3PjLsKLo6kG37mfhVG2s4P1uc9pyJ
        kCnRLVYDsf8wcgGPRrgwe8l3tF3MwWspRdK1wjwxNw==
X-Google-Smtp-Source: AKy350ZPNoJjAsHQnrgBtcWjAkVjOybxjn4aKwAelHOmXaeNNRU9fsNDAzKgv2Ix3OECExzWGt3nyw==
X-Received: by 2002:aa7:d858:0:b0:4fe:97a2:4b86 with SMTP id f24-20020aa7d858000000b004fe97a24b86mr2374559eds.8.1682005974175;
        Thu, 20 Apr 2023 08:52:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm888594edo.31.2023.04.20.08.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:52:53 -0700 (PDT)
Message-ID: <4bd883fd-91b1-5284-cc95-c4917f837be9@linaro.org>
Date:   Thu, 20 Apr 2023 17:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981
 compatible
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
References: <cover.1681992038.git.daniel@makrotopia.org>
 <2662c29ec80458852bb8c9041656bca46e2662dd.1681992038.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2662c29ec80458852bb8c9041656bca46e2662dd.1681992038.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 14:35, Daniel Golle wrote:
> Add compatible string for the PWM unit found of the MediaTek MT7981 SoC.
> This is in preparation to adding support in the pwm-mediatek.c driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> No changes since v1.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

