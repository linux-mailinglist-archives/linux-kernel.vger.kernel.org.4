Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F36C6C9C02
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjC0Hah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC0Hae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:30:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2FA1705
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:30:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so31741840edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTfaKKskPdyIPMxQE6a/OZWVaFKrOdK1xEfW52CBCmM=;
        b=Y9GsxCv7G6E0p6ZvWk21C73fKAs9IBGpMh/FZN6ZSAJ7D1/Me94re24lqWoczuW+KN
         X9YW++uh7j7DBBxGWHbn1JSvcZlwmucYoIsMkI6NCl/Y4cC0IRfFcShS7cEI5IrQ4Z0v
         Uc/cRIPuPnetg1MUX2dnHtaGYv42uR/G4YTasBVIgZ/MjmRZc+1VydR4Mdl8m4S1N54p
         JcAl1GzIND3r4bG4wxLdBZ2VA6WLOKc5KJoCXHWQXrgR6M9enYzxwqPFS0r2vx79BBJ0
         v/E8sQjV3dVddrnyy+fu5W1+lT06VkOaVyaB4HPXzo4Zw/ADExuPzpOG48LmabvljdTh
         89tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTfaKKskPdyIPMxQE6a/OZWVaFKrOdK1xEfW52CBCmM=;
        b=FSnRjSmCnDSUukC4yFL2gsnQs+xnBa8N0wewC/SlE5hlIx8tEdl/5saSTcsG7O3pt1
         p/bRxj9UKAYLO5aWiyIwRV5g7SEEnZvZ7Tvbrr3eQdG6Mgt8ZF/BVqXwXMr2SgpHkbdA
         35odOSysM6JkwjhyCuV5C21VnXPASX4i8gchKmfpwMQR1r3IwrUsDF/T0KiYuEcbnClY
         /ST78VolpqgqmTSfd/eHRUhfAAqQh6WTydEixYHLFmEaSTtOd+m9hRzYmQabt5qWWfYU
         9nfe8fnjmMYb0R8bqaHnkNiEsJ113w/Mw+gYLnnBggWsqhZ7URYCUCdcMak7cyZonoZy
         kSaA==
X-Gm-Message-State: AAQBX9d4+ET+jwUHXd50HszhmwpqsGL5B1xE8iNnXz/Wsv87huvoX4Of
        prjNGLKaXkzswzkt7lhbwEaKDQ==
X-Google-Smtp-Source: AKy350Yvk9Mfe+tV1ogObK7tgapZ69mC+Nui/Iefyic1/6+fRuWcWMqgZeHzROZdMnS4Sb/micJxnQ==
X-Received: by 2002:a17:906:2ecd:b0:931:636e:de5a with SMTP id s13-20020a1709062ecd00b00931636ede5amr11164773eji.31.1679902231990;
        Mon, 27 Mar 2023 00:30:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id ia9-20020a170907a06900b00932b3e2c015sm12887688ejc.51.2023.03.27.00.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:30:31 -0700 (PDT)
Message-ID: <e27b4c0f-0cde-ecbd-c387-6098c39d0f02@linaro.org>
Date:   Mon, 27 Mar 2023 09:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 RESEND 1/2] dt-bindings: gpu: mali-bifrost: Document
 nvmem for speedbin support
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
 <20230323090822.61766-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323090822.61766-2-angelogioacchino.delregno@collabora.com>
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

On 23/03/2023 10:08, AngeloGioacchino Del Regno wrote:
> Some SoCs implementing ARM Mali GPUs may be subject to speed binning
> and the usable bin is read from nvmem: document the addition of nvmem
> and nvmem-cells for 'speed-bin'.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

