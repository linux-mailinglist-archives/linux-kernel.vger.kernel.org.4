Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58115663E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAJKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAJKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:50:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595C5F933
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:50:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so11258350wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDhRoFdk/wz4YhwEvYGPmWAa3bEESv7lEX1Sf3y+vY8=;
        b=kpYMzbwl2nK/SPNdPdAb1kZsm+a7mjYsJ1MZpv6SWly5g8fmzZYjcdcWLvigOPfmQu
         3Zb4Op3qMqqukyIzZ+6vLG122XnmeNv4XvO/uLCyR+cKqmQR///bjqOpKmxCiUznEbNU
         yEmdgRYtC7FArbUBoTSCo8LfIp9NvOZ+nvlkJE31ZT2Ca3ImGeqsgIOcjl8y8HqL74/Y
         vv/Psp3u6lLBjghTsu4Y3X0jRzNjyzH1VFKQRpyLoKgzm2mWE4HsaYTuMqoONsEEov6t
         RzsweWVzdZ89nJZfTkaPBt1yz77XMAhIUdDTYsWebrZbvCS2KfBVdcUCUPVDMGEE0wfg
         1HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDhRoFdk/wz4YhwEvYGPmWAa3bEESv7lEX1Sf3y+vY8=;
        b=XTYllAi7fO/zRpV4BHGPyTAJZMgpRlYTQtCxHdBceg/nOqEv2TrG3WdAUrbAsuzshI
         /Zc5hXCtz5WGiQlk0lFlk5Dc9eZDrpIX4DWHQG7crwLAiAacDKkU2d5+HXpI/YJcn50r
         4BnLDajOX+SDnNA5B1/CfAsJhqO5d3xeA3i8QIzgnN9u3FrAG31CVJmeetwLqMne87OY
         bkvKbEhES64yfQVNImEKa3vMQ2Zef0224hBSEQFJ76RD/w+3KWRWif1o2rjKBQBbSCz0
         O/RvS1UrnyxjUKeJaO5It9pgbQ8uWMdNZiCHhRlMy9EYop48xD+aLRkw5QXepqHOn5Se
         Td6A==
X-Gm-Message-State: AFqh2kqfljnTA+ZrSREEtB2zbRmyOLnGWg5KbZUV046T+xNXspXpnLo0
        v+MuSdjp8KEKMhX0YGeF3hgsaw==
X-Google-Smtp-Source: AMrXdXvHkDs0uBSrWlkrTbnY061a7BH/0P0k+wTuGOhU7UgZir+7gDxhqgcb9+QKEahb+t3EUaVHnA==
X-Received: by 2002:a5d:4f05:0:b0:28c:6430:c1bc with SMTP id c5-20020a5d4f05000000b0028c6430c1bcmr25775139wru.3.1673347832948;
        Tue, 10 Jan 2023 02:50:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d6b0c000000b002366553eca7sm10853383wrw.83.2023.01.10.02.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:50:32 -0800 (PST)
Message-ID: <cbd6ff49-a31b-00ad-c5bb-9a185391132d@linaro.org>
Date:   Tue, 10 Jan 2023 11:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v29 01/11] dt-bindings: arm: mediatek: mmsys: add vdosys1
 compatible for MT8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, wim@linux-watchdog.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
References: <20221227080443.6273-1-nancy.lin@mediatek.com>
 <20221227080443.6273-2-nancy.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221227080443.6273-2-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 09:04, Nancy.Lin wrote:
> Add vdosys1 mmsys compatible for MT8195 platform.
> 
> For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
> 2 different power domains, different clock drivers and different
> mediatek-drm drivers.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> index 0711f1834fbd..242ce5a69432 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> @@ -52,6 +52,10 @@ properties:
>            - const: mediatek,mt8195-mmsys
>            - const: syscon
>  
> +      - items:
> +          - const: mediatek,mt8195-vdosys1

This should be part of first enum. Don't create redundant entries.

Best regards,
Krzysztof

