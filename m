Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938526DC888
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDJPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:31:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9967524C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:31:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f26so7195795ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681140666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBdfhAiuCEqD7RtTx8Ci52s2HURcnZu6d3ip+Anq2OE=;
        b=P0GdGNeiMWHlHtdDH9sRbF6cNkJ2IzbEXTzFv5b2eukJiSBZjwCwyQgrTq8JYy+zaz
         znD8Vl8cn3JY/F+scx1nzPxlm7RJU7ekeKesAD3i2b2JzVAFX2EnirPq/84SZ9gppmHd
         SiC0OZQyrjilj32CPrINCHCIA7DhcmQu7uPD9Yi9N79gaBmWSydNmwyXfs+590vnZVOR
         ftSTylYI0NNSG+CdT5BViFTJ1tLvhypAH6T1tXivxJq6D4nlFXlDRQL2v1BnmFXLDdR6
         f2GG1uT5pT9RODLOblIitxoM+5m57LULhegr31dfxYf9QHBMEc1xMEQiwd9HsKyfvo+2
         b/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBdfhAiuCEqD7RtTx8Ci52s2HURcnZu6d3ip+Anq2OE=;
        b=rpZ9P6QRFDONZIiPtDO1TANdivkwdTTL3xyCFN7DcCSLkrQmze3YhaU0vhYF91N060
         LsKvJAwtzVbfEIbGskmuHwN9OTg09yxsOV0blIdwIUkMigTKqAyz1hDrE52VsfeVGc4g
         dpgwUr6rgKmWYWtWvQh4UlWfeffkYPq/n+qcH7Kg6TO6het1Awp2mMi9nwxL/KJJiciB
         W4DuF0nutNU64/FGpoM78/f0tiMg0nay0PDpVJ0unY1+hN0lTxcEvEy830SDEmYM6fDQ
         HVERBo2Acy1mmmjkfpOBLzG6JLaUYmEaXLYov52zhF3nmA/gHvMyflheb9I9Jq3w3icE
         D57Q==
X-Gm-Message-State: AAQBX9eQWvTJxxITfxRIHHfoJMpRnwa6n0bFx3XVKBO3vCYxYa6mEDAV
        p45kMTz7jGYFR9Y1DH3GifsUNQ==
X-Google-Smtp-Source: AKy350YzJjMIz0pn/8a10YREbTWl5he8HuqP0ckjnl5NSVi0xhbBIimcqLpyUlXGQva5k5cG3pl/Iw==
X-Received: by 2002:a17:906:2a48:b0:93b:1c78:5796 with SMTP id k8-20020a1709062a4800b0093b1c785796mr6165570eje.43.1681140666219;
        Mon, 10 Apr 2023 08:31:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eacd:ffa4:1df7:3870? ([2a02:810d:15c0:828:eacd:ffa4:1df7:3870])
        by smtp.gmail.com with ESMTPSA id rk18-20020a170907215200b0094a77168584sm1474667ejb.125.2023.04.10.08.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 08:31:05 -0700 (PDT)
Message-ID: <874277fe-92a6-2bed-eccf-15fc90d8574a@linaro.org>
Date:   Mon, 10 Apr 2023 17:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mtk-xhci: add an optional frame
 count clock
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230407062406.12575-1-chunfeng.yun@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407062406.12575-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 08:24, Chunfeng Yun wrote:
> Add optional clock 'frmcnt_ck' used on 4nm or advanced process SoC
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: based the patch:
>     https://patchwork.kernel.org/project/linux-mediatek/patch/20230403191850.374839-1-krzysztof.kozlowski@linaro.org/
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

