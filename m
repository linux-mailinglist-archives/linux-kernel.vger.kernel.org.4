Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6DD6E1E36
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDNI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDNI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:26:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C38A65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:26:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rp27so6719271ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460799; x=1684052799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc3XhoVrKsfuWOuFNSb6VleyMIegrRaVdqtu2PiBP6Y=;
        b=bt73naGw+ZXi4dc8Cmhv0FLtGUbeOgrPuV1QMF4QPK4DWhqcDIiQyq2SXqDshVY58+
         9i5EZRohDL67399mm6hHhCeQV/EJor+rJ8VeOerrE+yvaisOQ2EXVIzVKEzSqBMW6Bsj
         /QStpG4ys+runlabZaXcTBjIl7IH/NVwijX7kgLZam1r0Xs+zSdWpyc9iow1Bl3P9Zr6
         qTEXFqfz9+7uepReMSv77u28y+M74JLZY3/yfgzdzoLj7xro2lSoL8qMvur81rANjaL9
         4QuNXgOvOjBgmIoG5TjRbKELD2WjLfk+HiPP6p9vqHmpim7DFpm87T/BjxLYHqgQTBqD
         uyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460799; x=1684052799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc3XhoVrKsfuWOuFNSb6VleyMIegrRaVdqtu2PiBP6Y=;
        b=C2FAeIGnmr/8P1FEu0aRY+NxDIvIcdkUJudJA42QnNZowY0sYM5aaLCS10AWRVs4qn
         yKIvUzbgDtS0AvVJO7g4M91xhp/cEks6dBOkQeOTgLqhLpTZkvsbjuY/d3rYoiUNsx6X
         1BqLQ/lWUi4PHT8G3IpZ0vYSTnrF1MAwiKVmh4NWn1ppNQ0LX7zkZCReCcfJIlR2fVNr
         hgSMSZAP4VaR9Dw419fPNeImfxkwn34ve2NSFkeoEtPe58jxKr+rjD2/ZPjIuUZ9kwuy
         Q9vNg0CgNbaxYBN/MFZvpXjXGlOhI247uKXm8K2IrGwu/+ggN8kHibwciOtgCLgvgjID
         RLVQ==
X-Gm-Message-State: AAQBX9cWguqVziiLyYXHX3T0xkKsll+k7gU9AsYlam4fzfmQlaRpVLza
        EvziAABGgreyaRc2pva49i9kag==
X-Google-Smtp-Source: AKy350ZHB0iX4SpIl6nSdBkIW18ThkfNLzwYurPIDtNAv4p6SmGfIue6rSdxEw2SmolXbx+cb6/kbQ==
X-Received: by 2002:a17:906:b2d4:b0:94e:d17f:eacf with SMTP id cf20-20020a170906b2d400b0094ed17feacfmr2364045ejb.23.1681460799195;
        Fri, 14 Apr 2023 01:26:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709064a4a00b0094a4e970508sm2117803ejv.57.2023.04.14.01.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:26:38 -0700 (PDT)
Message-ID: <d5580870-a440-a3b7-1c67-26db193a7f8f@linaro.org>
Date:   Fri, 14 Apr 2023 10:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 09/27] dt-bindings: display: mediatek: color: Add
 compatible for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
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
 <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's COLOR block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

