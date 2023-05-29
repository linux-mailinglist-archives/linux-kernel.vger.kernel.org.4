Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42979714D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjE2P5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE2P5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:57:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11750A3;
        Mon, 29 May 2023 08:57:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso35651055e9.0;
        Mon, 29 May 2023 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685375864; x=1687967864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk5w1ZF9WZxiTvHaoko6XuzTV0f3ptf0Wt5suaeuZhw=;
        b=D3FMDcuu8vM0YPWs4oaKpsco1HoEOxJnviREkZfLdB7g3AQ8cEKJIhGkXQxnTOVYpn
         a0O3mC4EQUCaPnwVfViJRw7RtcS8Nu3dN3w/xqFLkJ6QRaHTPOFO8LuJO+fCmZz1929/
         V1tFSBn3MmjmXWd/tYJgx0rcm/nJikwQRCW5k1j8Rffss4ZQ/DagBcJuoHfVlvXBu2xE
         Bqmkpwb5Kz3iOqHkdondwhscBmw3KK1auAvvtoWixscLpOlmbFsm739169ERChFZpY2Y
         F/vYH/UjmLbCI0hhbFCJs7PT80tt0+IT95vsDy6mGfhjUzdNgqGkj0tXocu+I5/IjTX2
         XsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375864; x=1687967864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk5w1ZF9WZxiTvHaoko6XuzTV0f3ptf0Wt5suaeuZhw=;
        b=Mn5QGMzSr6jXQkuhLZFWZ0tI2i362bKn5QMR6xA0ETbPe4rG2PcASuAqX0Q1Bb5sMN
         0Z7CkgzkuTcDeDQwOVPqnWudqmM3uGWnL0+J7iNzMBHais6MAX7uSOLKhIV+sm8wLLA6
         YtQhY23Qotfg4+zYaSfmXfOedp2LTyKKogrqL54wzgfSrC1VTswO7oLPBpKvrN9Rq3Pf
         nzp3CrYcr0UjXQ1nXkwSvb8RSgg0H3uRC3Lk+9QRF+EVz2yMgP72HsHeXSqN1pGFXabv
         d24mqz8Ts22HWardWR2a/DQ0WZKnCkbjL05N1L9yo6S8S3U0j+aT8vWLx0gn9L9LoHEP
         iqRw==
X-Gm-Message-State: AC+VfDz/dxRtV484w7gtVtb+OoXAg39Qs77ZunrEr//1dqx46ZxT8NRw
        K72PYq/w6IpZY81mVY5Gu7k=
X-Google-Smtp-Source: ACHHUZ4ktgXjLFeIrVQoIdPmozklvLl4NMdrl8nqpHdXz2q5dwcyJpHYEba+bseNdZZtQ0DQAIatzw==
X-Received: by 2002:a1c:7206:0:b0:3f6:e6e3:3da7 with SMTP id n6-20020a1c7206000000b003f6e6e33da7mr10618901wmc.24.1685375864464;
        Mon, 29 May 2023 08:57:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c7413000000b003f60e143d38sm14673008wmc.11.2023.05.29.08.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:57:43 -0700 (PDT)
Message-ID: <c2cfaae3-5f5e-60e1-b8e4-9584dd20550b@gmail.com>
Date:   Mon, 29 May 2023 17:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/7] dt-bindings: nvmem: mediatek: efuse: add support
 for mt7986
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230421132047.42166-1-linux@fw-web.de>
 <20230421132047.42166-2-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230421132047.42166-2-linux@fw-web.de>
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

+Srinivas as he is the maintainer

On 21/04/2023 15:20, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7986 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 75e0a516e59a..e3894f9d566e 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -27,6 +27,7 @@ properties:
>             - enum:
>                 - mediatek,mt7622-efuse
>                 - mediatek,mt7623-efuse
> +              - mediatek,mt7986-efuse

Srinivas, will you take this patch through your tree or would you prefer that I 
take it through the my MediaTek arm-soc tree? It's a trivial patch.

Best regards,
Matthias

>                 - mediatek,mt8173-efuse
>                 - mediatek,mt8183-efuse
>                 - mediatek,mt8186-efuse
