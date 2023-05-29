Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BCE714AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjE2Nvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjE2Nva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:51:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B5A0;
        Mon, 29 May 2023 06:51:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30789a4c537so1934291f8f.0;
        Mon, 29 May 2023 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368287; x=1687960287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78pcypVpN3CxF4Efbw66eNAU7KdZVo7I7D8DwmPSSNY=;
        b=RGnHahrqAMOmuuk/E4fXSa9iPqk72Omn6f6aqeKHPz/0xSpC4bL3nJsEoyKF8COt0x
         cQ3xzsVZvg9pOC5MXDFpHrCyv6GxVACQvk54AJZMptR3Blktf7ReftSc5WdHGJEjLO46
         R+TdZ9Ttjs20yAV4AzMzN0eq/7XY5ypMuZDM/7zu2vM3vJNwoPRVRq6JnLU7iaIF7Nxm
         0gq5+8qUOXOJacb+phUkDb3i1PJCpVDKzhF9i0WfvWX35z9I6g4SNDNRR86GnloatUmQ
         0uFZsI4mjH74yYXx0rbsxNM5VN2lATjny7VRQnXjFX9KACBz7zzQR8Wj0NcO6PaYBtHd
         J2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368287; x=1687960287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78pcypVpN3CxF4Efbw66eNAU7KdZVo7I7D8DwmPSSNY=;
        b=ftgZogs06yqoSEcfjcb/VpvUq7J+WIxVGw9vSNGDBlWOedRLORZvPH1OrdMnz2RwYX
         mD3cwqJMqGRpocM56+KoJqju9mGkFZWB5JhD6f9q4UOm/TwW4WUNfkwAe6r/YVy1n3vg
         E4rpuGIL+9C/kiRhLp+rxIK0gp256Ol9GOAfoA6kpCtrbRgXH+L9Lk+vJFW7yaajXsQh
         hz/2n9neBH99lfQ2SKKEgMGm2Lt3Z6bxUMGwddwg3q9r1+ilFo74Oi3qk0+p4fcHHog3
         3ISWl1oTRRmUFG1I5W2e5SWJRe6MZZjaVSrTIBabcyX2yjzxmi/0Q8cNEMsV9lB0y5yV
         UibQ==
X-Gm-Message-State: AC+VfDxt86JEgbW3LpIbL0TddxMQ7H6xyIcYkzHHL6HdimLi1/VcKhuH
        37/SohjM61UoqxmaxNDZ2To=
X-Google-Smtp-Source: ACHHUZ7XNS0Ka4Zavjp9uZSaETZlKXum4Ox8t6LlTxg+Hui9Jl0m6ncdtdAfQq6dIti7SzAdeGbFiQ==
X-Received: by 2002:adf:e345:0:b0:309:4f23:e52e with SMTP id n5-20020adfe345000000b003094f23e52emr8944522wrj.15.1685368287334;
        Mon, 29 May 2023 06:51:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d6ac3000000b003062ad45243sm53692wrw.14.2023.05.29.06.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:51:26 -0700 (PDT)
Message-ID: <7b39f7ba-7e29-bf4c-e165-130cd3539d45@gmail.com>
Date:   Mon, 29 May 2023 15:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
> block: this is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 0088bc8e7c54..153e146df7d4 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -22,7 +22,9 @@ properties:
>             - mediatek,mt8173-disp-pwm
>             - mediatek,mt8183-disp-pwm
>         - items:
> -          - const: mediatek,mt8167-disp-pwm
> +          - enum:
> +              - mediatek,mt6795-disp-pwm
> +              - mediatek,mt8167-disp-pwm
>             - const: mediatek,mt8173-disp-pwm
>         - items:
>             - enum:
