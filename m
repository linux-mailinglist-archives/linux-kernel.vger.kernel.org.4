Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691716C9BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjC0HYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0HX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:23:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D4CDD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:23:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so31982634eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679901834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjdPO/oq4IIE0hFyHigrECYsxChLPPYgESz7B/pDYOI=;
        b=kEhpgaB0+FpNDi/WR7iPM+81mqXbh4tx5ISPPA1oSU6dY97FK8aUp9yDlZvoyl8xjD
         tbdmmIazwmIue7n7Z8EYtw58KkMRx0qDa81z+PvmsVGpNRhcouOmJqWi4qYkFwjKe1L1
         R22JIaoaRhQJkEPtmehBpE/5AwLPEKjjn8ujez8CuBIIZIzl1ZmStzbFDGkjnTDz4DEj
         vaZFbfYZDgrhO5gntDqIGjcXjYHKW9JAjiIGLDxQTsFvCtgo3y8KGSGp5R86QE8Z8Qef
         /5/Bn+BLqvmjVTwhEn6yMIRRu7AqxkXU764qg25bs7Ndn+IcHxJ75/McKUoPxReqhmUa
         qZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679901834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjdPO/oq4IIE0hFyHigrECYsxChLPPYgESz7B/pDYOI=;
        b=VcZ1U5gCj/hIlEd3bgtvLdk00ggm+DkzetpDpaY3JpJd4QoWGz5cODWXEwmwEzRkeb
         g0YfViLXtrnoZY6BSHXpAgdrpXNII5qX9EQlpr2yv//FXbeFzfrD2skHCeijM6Py16f+
         yglsyOfsFrw3p8NAurdc61w7CxSk25XiN+6pSEdrsv77SRZm1oL4HJqwrAmw0MCj4j7O
         9JLvpSI0ZT3h89C/WatH2+IrjJaQE82P5Ese2vfMpVtFCyZZPuq7mHDNtd5D5SDz0nRU
         bJH+UqGsyPKnF5IPv3gZrVOCcLu6vkBDdgsyteUvIWSGttdnhPZDL5Kh6iVtvlgKWmPu
         +qUg==
X-Gm-Message-State: AAQBX9cS6Oa97+81BZuJ5kOKbGgXFI2Ho6fbFe4nEdgaTPVS6YyK83on
        Jxqk3bf/PGIP4s9l5+QlBND2cA==
X-Google-Smtp-Source: AKy350azTNMcDvP3N7zgcsBq8oWHYm5j1ZDrSetdKr7bGj0XWY8nqN78nx3uN23pI6zOfMxTy1BUQw==
X-Received: by 2002:a17:906:6dd7:b0:931:c99c:480 with SMTP id j23-20020a1709066dd700b00931c99c0480mr11619450ejt.69.1679901834032;
        Mon, 27 Mar 2023 00:23:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id hy14-20020a1709068a6e00b009351546fb54sm10151855ejc.28.2023.03.27.00.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:23:53 -0700 (PDT)
Message-ID: <8d5cefae-e10e-52c1-b070-4a1d15a5ef93@linaro.org>
Date:   Mon, 27 Mar 2023 09:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/6] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT6795 Helio X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        amergnat@baylibre.com, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
 <20230324094205.33266-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324094205.33266-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 10:42, AngeloGioacchino Del Regno wrote:
> Add a compatible for the PMIC Wrapper found on the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

