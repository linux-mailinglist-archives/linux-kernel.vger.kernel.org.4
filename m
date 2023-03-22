Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E306C5311
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCVRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCVRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:52:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770667028
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:52:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so76299177edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679507534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wh4Z1xlqDztZUH1w7IbXNlkUYB0pflLL3OVprobSnZc=;
        b=WcgQoZMSV/a0eQ9pzfFJS6PJOkUq4BOxRnUsYi1tODvQhCM6XAVIzZ656d7dRAo45m
         jkaqVR41zmD3Evi/JdVzZeSvpsycq/g8HfPdXGdmzr9IHdZ4ZYUYgWDA35WIKSb8qs3K
         4GBwCIqYJvd3cfwJ5x7LEfjiVp+qyWH9wtr6wChbhNsNKvXjgYhh4zcK+vRgLQR26xTM
         vlUm34N7H5q/KUnatolWI/y9cmvYTiN/H/0GTnQrgx0ot2jx13y5wzrOogaDdd4VVVD4
         g0zGgYhpbxRwUZOUoELIh4LuhRgOf63m18hB+Av+4hLt4x54//xRNZQqSjygqbRAADne
         KPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh4Z1xlqDztZUH1w7IbXNlkUYB0pflLL3OVprobSnZc=;
        b=ZQs+XtjN6SZ0Tzaw2R2c4rcrlMJyREgCLiisoxLdSPtcRDkMWuA12XAdyW2shQwHCP
         Gky5DmqB8oRaIfeMCeWkvadm1KR7c4bKr1F7h+5Vva2aQZ1nFuF8WECKiA0xZ980IIyP
         mO++Tr6HVVCR4kROZL97RT/nA0UcvqpbZkC5V5K+Bxsr1CSxevXd7vvt2jCI4b1pucU5
         TorDwUDvRO+Nhd+JmKStnxpyX4LYB8YpQTx+iiC9yK4mIosDm2K1nJWQ1oEnjtpG1Tdb
         2uXev9WtdFk6930iLf/y9WCcosqbD8hdo8IZBdyWvbWkq53m4WTor8OqrWN7u5lGdge1
         jb3w==
X-Gm-Message-State: AO0yUKXpALp4uHlJxpevYXejW5Y+MyDK8ax7nkMEC3AZwhRpS/gqQLwO
        QDH55cY6lh38xFsY92Dw7ZuMWw==
X-Google-Smtp-Source: AK7set/w/Af4r7ZkWY5/EYuLO7gRu4DNAGQ4mEA4NNMEcc/QIJ5nDOUWk6vdiJaM+ZJYjQJK7+8P1Q==
X-Received: by 2002:aa7:c053:0:b0:4fc:6475:d249 with SMTP id k19-20020aa7c053000000b004fc6475d249mr6466295edo.3.1679507534645;
        Wed, 22 Mar 2023 10:52:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id t22-20020a50d716000000b004af6163f845sm8115519edi.28.2023.03.22.10.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:52:14 -0700 (PDT)
Message-ID: <2087e394-afa6-f1c0-cfc1-df382b2d13d3@linaro.org>
Date:   Wed, 22 Mar 2023 18:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: clock: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230322173549.3972106-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322173549.3972106-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 18:35, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

