Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC9618B64
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiKCW0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiKCW0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:26:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE0220C6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:26:39 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g10so2108912qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO7s0i2uEU8+qaNh+JodROQHc5HADEbVF5h4O06CWHw=;
        b=cKcf//yh1V/T/ywLkF1zEngQRr3ppn6dj2NBtXOFjRm+lQ7a8sJ6jAW33Rdf/iIncr
         uu2qGEfMuVrsXk9M8ZcTx18XgUYsLH8BcDEoVDAzs9jGdXVU3Bm/gcAvjP3AFZU2BD/y
         C4Ze3ROWFAOHuX3i2ryS8e+p8pFYNvqTj7jwTTH9FY/nlgFsbG/c1446LMfgVlqx0gPU
         arWKxNi4SCRjNPlnTz1Cb9j0R1nzQ8pUqYN1BF8jkSAsoMGashaQQQ+E6j6MCmqj2gsv
         zrfp0WrsIHLu6G4KUCFSgzR9lcDvXDQyL7itU0Micq5PdWqMQAZ5hQPS2kIaTnb+MCgT
         oVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO7s0i2uEU8+qaNh+JodROQHc5HADEbVF5h4O06CWHw=;
        b=0VslhkHnRbqwvz1P/62admyViEsDwJZwTWE6MOATH4VtD1vB0qwYdemUC2MuezZ8aC
         ZEWJX+lWjH8LWXYK6QivRUn1dbaO67zG9GVx6LHPfMoLYEK+v1iYLT/xBH8QzoW0oQw8
         e88EtROFwIZ+9b/XmbeILlkqO1zwm8uosMpil9JFZz4ufGqKtM65rlE+Ga2v5exEm7GX
         EjX8ib27Z+ZaetH8YwdrPUPNRkMpWu6MSZfQQflAtjdx9l4fI6FfNfBQbiWwdpK0iGmQ
         pt3+pmtY3uTq5nQ/DpzCFYiKR/lCq9Oo9EIjCnqjvtzkjKKOPeBCzjkvcunmerqE4Vf+
         PPdg==
X-Gm-Message-State: ACrzQf1NCYH1RznZsFetmBhSfHrQv1HLSoHryaTME+PJCW0TPcq3mhBR
        e/Pdf8blP712hCcGw9D4bVcGGQ==
X-Google-Smtp-Source: AMsMyM77C1DqfRbu6vRLTUrod9jv4Im/moSq726rE2rF0ojoeCAjYeAkahi+yHNYnD20GPa933MOkQ==
X-Received: by 2002:ae9:e70b:0:b0:6fa:509f:cb2d with SMTP id m11-20020ae9e70b000000b006fa509fcb2dmr11597364qka.181.1667514398509;
        Thu, 03 Nov 2022 15:26:38 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id cx26-20020a05620a51da00b006fa12a74c53sm1590308qkb.61.2022.11.03.15.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:26:37 -0700 (PDT)
Message-ID: <f523b400-e007-0fc1-7977-345b007ac91a@linaro.org>
Date:   Thu, 3 Nov 2022 18:26:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 4/8] ASoC: dt-bindings: rt5682: Add dbvdd and ldo1-in
 supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-5-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028205540.3197304-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 16:55, Nícolas F. R. A. Prado wrote:
> The rt5682 codec has two additional power supply pins, DBVDD and
> LDO1_IN, that aren't currently described in the binding. Add them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

