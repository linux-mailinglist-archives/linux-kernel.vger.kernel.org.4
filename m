Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A06DF588
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjDLMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjDLMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:38:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204B900E;
        Wed, 12 Apr 2023 05:37:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v6so10726809wrv.8;
        Wed, 12 Apr 2023 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303061; x=1683895061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMlPXBM3hd9jIHL9hgd0wOc31UORXSj4RilM3kqo964=;
        b=Z6aVvxumaepTR1WGJnrlhUfUxQORULeGEFRjMblfGS9rRIUBbD1guL+66kDoGL4L2F
         EJNPI2WnR9X/nptHy2HVSvB3cX5oQs2CyIUCjceXuWD8mg/12SB0Xgi1bhlRX1O+L45k
         Pr1WQeTvwalajQQlbo3kJdwwY+yxm75ZIQB+9XceHwL8B0Y0wk12WQo5Kv7wL1J8lN24
         9B+aPa0TI9AwPoVCBDSJbKqeJWCF0o0zg7OxvKe9irQ+syXvy2jlZ9til4kd3dINP/15
         Ayuo+c9aKnzXnlf8nMEGcNEl0ErehlBR/mi1ZpBBS0m5k5tdcRZtDadBe9P5jMsgHGj4
         CMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303061; x=1683895061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMlPXBM3hd9jIHL9hgd0wOc31UORXSj4RilM3kqo964=;
        b=WxYyBXZ+kRSLs0N1JfsuYqi9poSK+w5LboG+e3Tr5rXmUu9PJn5YuuzhIzZZuYN4pT
         8QkJNnu+BOuXo7TWF190FjhzHpVfF0ahZg6EUiDNGzO2xuB8wxenTQTSKGMzaSr4KXTW
         lgKs9cznxiIFEgGuLHnx/QWQFB4MMbI6QKHEcjUaSQNlGgufPkHKwE/rWRDzdi22p8ex
         0UkMf15d50KVqB4upvCA02lfPNgFsKh+z5Sc5r2OsLqFqJz+3alozYHtcE+KNAdUhwEV
         24Srg16VXI2EWNjJdLHHvgSh3TY/vy701vPg/Ki4BSDsspPPanekzakfMgW7U777RM53
         jQYQ==
X-Gm-Message-State: AAQBX9elIlC/x6XamxHYnrOjUDeM7dRDB6GgQfX2Wih5OnzwCNGM6Yk2
        cw5mVvZg7Z0eTJk7r12irkU=
X-Google-Smtp-Source: AKy350ZArefRK2km5RNJgiCd8KzO9LsFvtICtB+2FMvxRJx3OiTP5Hvi3HzbZ3HgKraJfWt5r3+hXA==
X-Received: by 2002:a5d:6e8d:0:b0:2d8:81a9:4d75 with SMTP id k13-20020a5d6e8d000000b002d881a94d75mr12073306wrz.32.1681303061489;
        Wed, 12 Apr 2023 05:37:41 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e18-20020adfe392000000b002c56013c07fsm17037899wrm.109.2023.04.12.05.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:37:40 -0700 (PDT)
Message-ID: <cd2906d3-5490-b3e0-b02a-39b201a65bb1@gmail.com>
Date:   Wed, 12 Apr 2023 14:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 11/27] dt-bindings: display: mediatek: merge: Add
 compatible for MediaTek MT6795
Content-Language: en-US
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
 <20230412112739.160376-12-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's MERGE block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,merge.yaml   | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> index 69ba75777dac..be330be1399a 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.yaml
> @@ -25,6 +25,9 @@ properties:
>             - const: mediatek,mt8173-disp-merge
>         - items:
>             - const: mediatek,mt8195-disp-merge
> +      - items:
> +          - const: mediatek,mt6795-disp-merge
> +          - const: mediatek,mt8173-disp-merge

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   
>     reg:
>       maxItems: 1
