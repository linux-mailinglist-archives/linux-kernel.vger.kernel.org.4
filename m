Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC2632B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKURfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKURfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:35:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C48CEB98;
        Mon, 21 Nov 2022 09:35:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l14so2051009wrw.13;
        Mon, 21 Nov 2022 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H739gohkJQiXvKefWiLyqitYzOD/5OYfD2uRzWxJMv0=;
        b=Sw4vUrpV+2ZKerURpiiaRPbic/zppeNW8NcdRE+SOtCQaKWeI7Z9q6CLWu9trUZVX0
         dOBHa2KaSZV9zAL9fOGSNVWmAyEmP5pBTfbUFA3Z6/SlswhOql+H3ZPXezC9oKFC8Ckw
         HffyxJS3QDcqeJM7CFeNaVIFlWHCEEthmCXJ2PeL9qAt4BjS0e+gfd7/XDJy68WlnYeS
         W44A6uI+xi0e77dXoiRLxzlGsBM2JbtLVr3w9WD6z4Sy/+e9JhPsiVUzutWxv2MA1oXq
         dvbvHUUfW1aFUpOZAwFZZ4KaRgF+Mk39DfSO5njA/EmDr3vdoVecxTtm82RlS+tV12v/
         aonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H739gohkJQiXvKefWiLyqitYzOD/5OYfD2uRzWxJMv0=;
        b=rMVbmcsOiogxWY7byttYlaerbKrv1xZfugcmlXGKV16gSza2KU1nugvxBEBWN2auu+
         JaStwv/whSBctYOaRZmYyx3qnT+SOmOWNEOb6YOLJ0K74EatmH7jscu1PCs2hfGwJBDv
         AFMQxeYs+uT4DcsFqkqfTdxoPLm4fLPTpjKG8eqQyjzJrKsPWEzYNlNaOFlkHs4VnTPD
         wJUY41IOPjnyA1DAeLNqChca0n7LssG/xTJvy4H5Bn0i161cxsNYgiBP1qGl6G0TUMoM
         Em4ltXk423YZIjRnyMkh0EoDmhsOM9ZLteDeIyOkhVdUrcj0J1JhPpsGGicDqf0hw8If
         3Jqg==
X-Gm-Message-State: ANoB5pkQm1Bp7J5Iv5a/EaVWl05sfIMqPIizmiRvVYF4AK+LXXE9W+Fk
        Zp0Pxv+luK5xq85/qNo8tn4=
X-Google-Smtp-Source: AA0mqf6s5UrB6KSQzIfGircalN42vcOhoXNt66f+1gAnQqi9w65qZfja19jeAbwazXHd+sfm6fd/Aw==
X-Received: by 2002:a5d:538b:0:b0:241:c3c2:24cf with SMTP id d11-20020a5d538b000000b00241c3c224cfmr3225033wrv.587.1669052103907;
        Mon, 21 Nov 2022 09:35:03 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm20780645wmq.26.2022.11.21.09.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:35:02 -0800 (PST)
Message-ID: <1c33cf07-900a-7acf-92d9-ad40f8543db8@gmail.com>
Date:   Mon, 21 Nov 2022 18:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: mediatek: hdmi-phy: Add mt8195
 compatible
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jitao shi <jitao.shi@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stuart.lee@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20220919-v4-0-bdc21e1307e9@baylibre.com>
 <20220919-v4-1-bdc21e1307e9@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220919-v4-1-bdc21e1307e9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/11/2022 15:19, Guillaume Ranquet wrote:
> Add a compatible for the HDMI PHY on MT8195
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> index 0d94950b84ca..71c75a11e189 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> @@ -28,6 +28,7 @@ properties:
>             - const: mediatek,mt2701-hdmi-phy
>         - const: mediatek,mt2701-hdmi-phy
>         - const: mediatek,mt8173-hdmi-phy
> +      - const: mediatek,mt8195-hdmi-phy
>   
>     reg:
>       maxItems: 1
> 
