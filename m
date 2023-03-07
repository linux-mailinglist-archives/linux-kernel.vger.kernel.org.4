Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D806AD8F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCGIQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCGIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:16:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203A5072D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:16:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec29so18150391edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678176982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nDYeNViOfggxIfzDROShYRUgmdfTcb/BnnR2M5KEIc=;
        b=w8llI7QPcpMyUTDXYAZJGp1+kvh1rlpFLMjH8wbFFDZww7zjI+hLF3l0py/pym6MY+
         9cQAvW2mQjavd2f/CXHyyk1bGlydLLpHrz7RdnmV+HxkdBx77YoqhVUog+iBKCE4AjHm
         e9etJqugxqb3EEaDRF0LNlr+GsmIdkLLhLnPezid7kcj3lGI0g8YHFmeis9nEDeNlNPX
         JgTXzDmZIfR6Mrp6YXdD1CWaToVyoHMRHIFRXLqPvqX6kct1VQGPDgv5X/pdbahI8yyj
         Vo3glMnWIRVqSIXYXW7jRIsim2WlegveWdkCOeM+fZ4hrzb42ehfmxa8V8KSomzkVPa6
         yXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nDYeNViOfggxIfzDROShYRUgmdfTcb/BnnR2M5KEIc=;
        b=crB0+1iGQkh/2vrxhMBZ99XgfxWbKDR1etAfNM6Yq5q5mGRrLNZkSJXMR9wyTgqVKd
         0xUrviUvXDmeYZ3mIWvTFBtOQNmQd58RrkebXZ+E/pcpn4N/8ML1UHW0mU+/dc6g3dx+
         oKqfHbshyx7yZv2xk5h9b7ZXh4xsII/E0Yu2kazAzxsDDhERMFSjzRL1tac1BW4jp/BX
         AVxNwvkz6DsIcPvCeoodQdN6b7SubU+OeOrwKpRC4ULOu9OsQCGvdyzOn98GC3/th2P3
         ZjH+Xq9SrPqhLNez0CD1ymsmUCFzXJeDtRXr2JL+aeiI6MZl17BwbihU1kPr+fwbJdTS
         dAnQ==
X-Gm-Message-State: AO0yUKXmlPtRCWwGGPtZkF0NKhJuDD/MKS9O/GGxM9LpJU1lRbFMkttC
        3Ar3qad/rKzYIDCaYIwWFv++8A==
X-Google-Smtp-Source: AK7set9pStbAm3PmBs5vLzhyt+fZdTXRfRWPgXBTYQeJjhU+7VkWzt64OghaTAQEV09Vb5icRVNAlA==
X-Received: by 2002:a17:906:6a1e:b0:8b1:fc58:a4ad with SMTP id qw30-20020a1709066a1e00b008b1fc58a4admr18504773ejc.11.1678176982155;
        Tue, 07 Mar 2023 00:16:22 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm5788324ejb.142.2023.03.07.00.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:16:21 -0800 (PST)
Message-ID: <e8c0f0db-fe2a-52b6-ac8c-7810b348af8c@linaro.org>
Date:   Tue, 7 Mar 2023 09:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] dt-bindings: display: mediatek: Fix the duplicated
 fallback
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org
References: <20230306-ccorr-binding-fix-v3-0-7877613a35cb@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306-ccorr-binding-fix-v3-0-7877613a35cb@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 17:20, Alexandre Mergnat wrote:
> The item which have the mediatek,mt8192-disp-ccorr const compatible already
> exist above. Remove duplicated fallback.

Your commit msg is really misleading - I was looking for duplicated
compatible, but could not find it. You just have there unnecessary one
more list in oneOf, so this could be written simpler, but no compatibles
are duplicated...

> 
> Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback for mediatek,mt8186-disp-ccorr")

Style issue, not a fix, because nothing is duplicated.

> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
> Fix MTK color correction binding
> 
> The fallback compatible has been duplicated in the 137272ef1b0f commit.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof

