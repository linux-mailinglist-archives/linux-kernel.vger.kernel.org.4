Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1806DF591
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjDLMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjDLMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:38:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879DD8A45;
        Wed, 12 Apr 2023 05:38:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so4304429wmb.3;
        Wed, 12 Apr 2023 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303088; x=1683895088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6wXzbihncvcxRC0lYLMU3KUwnKB3HO+StuX3H8os6c=;
        b=arIcxUv7A0B1RO+picV/yuY6t7RmRY6+5qH4Ts1uJHrZCltOnQkN//6EEcVVeuNoyd
         s2CalZ62oQ0lhT9948PMDOTCc7VfANNrKnEXKDnmTt5Y8WaOXH/Ah6z2wZ3PkhSp4qSk
         u8QJa1Q2erqT0t5MG53kb3upBZo4BNlTsti79f/hqvJxTtvCa1c7Wr2Euuke/tkd7Iaa
         X+Y4HEKJNyc3uhbjzPEWxLz8tldOJH9QBiV8iYTbVucNWkiLRAwnslwDsF/02sdXIKxK
         XPGWP+a5BxkJknwCFV1EIZzBYi0/Xa2j3vbcbtz5mmSWyOKN0dBgmnn0SL89+cxzLM+R
         DiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303088; x=1683895088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6wXzbihncvcxRC0lYLMU3KUwnKB3HO+StuX3H8os6c=;
        b=5s0gXFhaC9CWsQcztLvtv4NutoLN8cecBkAqYZRacm0DCBCLc2Ptpn+ye+HWjHU69J
         ygPIEVogl4j87KkYae2m2DjZ3+t7F7dC6fk2KHkxqzacxdk0TmqQm4alQ/voOW3buq3U
         i3uhvGUeESUvBxFXxKmonQTPx/UubpY1ZwzeJgOhL20sRlVY4x1SjXBYNoYXO96qySFd
         ahrzCGlDo46v6XywaTzdQP4HyzOo/obUb0kz3lsBpPTjlVqiYS5GZO00DekAoFMAdDyr
         CYoqApGG349F6U7WNWGfRx3MtliRlfCpmdcJHzHbyqpmykvjVsjtzGHe5SjlXvA0LURX
         avOA==
X-Gm-Message-State: AAQBX9cciPjQsKZgXvPK0TL3Tj+QonVI4WBUlhPtuMKxJZpaSuTc4Kl1
        M0p9jVOKAf+0HknX3NoGkQw=
X-Google-Smtp-Source: AKy350bhfRzY5aSzG4wwinpVBd7GLK8Egpwb3dH450L2hyjxKWMM4P3MVEj7kxheu5R0ei+xUrknrg==
X-Received: by 2002:a1c:f613:0:b0:3e2:201a:5bcc with SMTP id w19-20020a1cf613000000b003e2201a5bccmr1804437wmc.33.1681303088188;
        Wed, 12 Apr 2023 05:38:08 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm2333476wmo.48.2023.04.12.05.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:38:07 -0700 (PDT)
Message-ID: <32ed4eca-106e-8c05-31de-881f7119f954@gmail.com>
Date:   Wed, 12 Apr 2023 14:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 13/27] dt-bindings: display: mediatek: ufoe: Add
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
 <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's UFOE block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,ufoe.yaml    | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> index b8bb135fe96b..282925a73804 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ufoe.yaml
> @@ -24,6 +24,9 @@ properties:
>       oneOf:
>         - items:
>             - const: mediatek,mt8173-disp-ufoe
> +      - items:
> +          - const: mediatek,mt6795-disp-ufoe
> +          - const: mediatek,mt8173-disp-ufoe

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   
>     reg:
>       maxItems: 1
