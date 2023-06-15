Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E1473123B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbjFOIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbjFOIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:34:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBDA2974
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:33:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9829a5ae978so95108966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686818033; x=1689410033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/StSIz3LXrXYAfMsT7Wswjumrx4wcVhOOtwie2lMMA=;
        b=fuPHxuUq0Cj30MyfQDJJ0hIE+whQ2fHLghFhoB0URfQHWxPQQ1aGu2ZNiunlVUcZUU
         x4H8oN+UEH4g830hLeTNiIJIghUwLxMrwHz+4zVL0FY5CK2uVuc6BIZ2dnshG6yt5J3a
         neu2szd7JPYziz/iiznJz6KhjYz35loNUZa/b+zW3pykPN62XAVN44fL8Ql1oEW7VwGT
         Zr7fHfWLo4degztRBkFiZIHhEi1pWZl58OcZAQ8j6cyLqz07AYNv2ywmUMZJ/nFycHZ0
         RWtlyWQy2Z7EvFyUpggJ5eLsmCibBt6JdCVhiEx1Slbcg+i/KbyxXv+Wkz+2N49jMwmR
         Fm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818033; x=1689410033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/StSIz3LXrXYAfMsT7Wswjumrx4wcVhOOtwie2lMMA=;
        b=Iu5+TAGYF1Ai20wpgn7Yu+soKnEjDGrk08KYFssln+2AaapkkMGKlFm/aqj36uWzsD
         bvHukuVpfGOor56Dt35cov9CLXeyLkP84BGUrrfO2bGtcymdQQ7Kjdvsrgb6Q3Dp1Sgl
         UIhZLMrQ7QFgfgYhsfc2RGAh8FpJybcmMo6gk/Fa21PYXOuimGy3/0A5OhCofC3K7Kqx
         ncRNGRB8AuKRRs+e2VwNuPNBQuTKZekezt0CGoZO5YmYOJbznYJnH84zCCAe/cbtDStE
         P9/v7o9f3YL3dosPWHpuDihC22vbkw3MUORlbP9obOr7U2GWB5Wqo1J1lGnPMHkO6q/P
         Ur1Q==
X-Gm-Message-State: AC+VfDxOdk3/Hi5yf7K/uLnu1XqChuDTecFzttqZ2dCNRkumMFXJoF+D
        9N/OZNpsDK3mxjq6io51GT+etA==
X-Google-Smtp-Source: ACHHUZ6XygTQe+173jC6Dbrzs3cDFrS4Eu1utaBhyditYM/6Rlt3mhL4/xdJwmN5jDzW35u0BhoKhA==
X-Received: by 2002:a17:907:16a0:b0:978:4027:57eb with SMTP id hc32-20020a17090716a000b00978402757ebmr19588392ejc.47.1686818033089;
        Thu, 15 Jun 2023 01:33:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906471400b009663115c8f8sm9050162ejq.152.2023.06.15.01.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:33:52 -0700 (PDT)
Message-ID: <3f43bda4-023b-3536-a9e8-318659a1f0cc@linaro.org>
Date:   Thu, 15 Jun 2023 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/15] dt-bindings: display: mediatek: mdp-rdma: Add
 compatible for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-3-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614073125.17958-3-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 09:31, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 MDP-RDMA.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(Apologies if it comes twice)

Best regards,
Krzysztof

