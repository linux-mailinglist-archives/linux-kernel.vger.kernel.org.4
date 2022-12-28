Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CF65768B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiL1Miu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiL1MiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:38:15 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D961211447
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:38:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s22so16419424ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulQdzi20zd2U46RZKsWGGdfViyIJCsOcS9mGLZlm5yU=;
        b=ROZy35wsYl1/tNFkRh0mrMmTpcQIU+41TeXZI6z23pccDhF71JS3vFW0I6QBK5tqCG
         +yx3MG8YeeqfNyuyH7Kpxj6/ehUia8GTAq20UcCyksilXnkN3b8iIR4FvbHUTj6HoRlc
         UX9USikFDumDonaVnDgl137WIqjLQbBc/fPog42FT0vQ7d309epTunt9B50/0C05XE9I
         uGlEyErjaGvgamWLdzaMz9sooxtCug8QlctG6G9wRYUc1ppb1wJe7FcszmlUPfo18oTy
         yl6MWffhxj5pH9E4EuI4w+m0DRGYnOHcZwrAo34GHU9EjqrJ7I/out4nSyeUwEsT7wvg
         FUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulQdzi20zd2U46RZKsWGGdfViyIJCsOcS9mGLZlm5yU=;
        b=CDWHWLCZ1xc0asLoJcyfB4hITy37mU0lKlbBOn/Z5L7RdxePVIHkWSiNSG7WCtqVAH
         BLt4R2aSRWRcaA15eW6IDSI1WTUVIMWa+V+5sBpb5F/adQ5ZNoStcdK2w5sIloZs7XGM
         j9ivvozWL1SxN5KpTyQ4CQzv93a1BzdIAcBc4N4adsOZdUJXGaeRQ5QMiffgnATCwfoK
         aN06nUyuK0SHuXcAAePh3oFTa4Tc69x0s1Vq5+DRoFrsylAUn7LSCsJyOo2njGmAHdgx
         Td8yufInv9REbMhFOufGVIDa6wjZEwsKhRcg2hUQ7riIiwm1sJ3Ug1tNssNZ7KDw4+0D
         k3ZA==
X-Gm-Message-State: AFqh2kpjRFV6tnb318XakZrkADuBZ4uy4AXRaNQ8CPKWcOT2wYVDoD4L
        euzzwl2Hr21X9ePk40oXwbzKBA==
X-Google-Smtp-Source: AMrXdXsoIJZhKKDkqEp/ZqcNn9QOtQzkUwBxJWwRPesEC5Q4Kb3HlmbuhYhJDQ+aKdj8EeXGi7O2/w==
X-Received: by 2002:a05:651c:90:b0:27f:b833:c50a with SMTP id 16-20020a05651c009000b0027fb833c50amr3893384ljq.14.1672231087829;
        Wed, 28 Dec 2022 04:38:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f1-20020a05651c03c100b0027d75b38fd6sm1940734ljp.43.2022.12.28.04.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:38:06 -0800 (PST)
Message-ID: <76a34e02-ec76-10c8-5cea-681a7477a026@linaro.org>
Date:   Wed, 28 Dec 2022 13:38:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: mt8186-mt6366: add new compatible
 for max98360a
Content-Language: en-US
To:     tongjian <tongjian@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        jiaxin.yu@mediatek.com, chunxu.li@mediatek.com,
        ajye_huang@compal.corp-partner.google.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228122230.3818533-1-tongjian@huaqin.corp-partner.google.com>
 <20221228122230.3818533-3-tongjian@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228122230.3818533-3-tongjian@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 13:22, tongjian wrote:
> Adds new compatible string "mt8186-mt6366-rt5682s-max98360-sound" for machines
> with max98360a and rt5682s.
> 
> Signed-off-by: tongjian <tongjian@huaqin.corp-partner.google.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

