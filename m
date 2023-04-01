Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCB6D2F86
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDAJxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjDAJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:53:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D58EB54
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 02:53:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i9so24735487wrp.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680342812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOhA43LmOrt8qpSaW/te4zffJ9QGZH2fj5kj0zYlFHQ=;
        b=aV9fJxI8HVKJHfqCRSmsB9pzLwNDj78SV+1sF/RdFom0TmCGg1D6C4piyaIP+CQlFj
         VY0LBD1dDk+/Xla/udoffg4SS+LjBTOb1GLmTqYdUKwhk50p1YSi40/wldJkLPviZUiV
         vAQJj6CmkuA4NiNaLmTjYjzYL5PHcUZlP13dMnQK34qAOokUXrgnanE8jXMuSJKi0k7n
         i8JiM2VUEZA7xmINNz0rOpgemjCAA/S+y6FGShUA0x7hWUcpgGLRFaqXqlsoRDdtME8Q
         0PscSrdrgv+F37isys+eBaQ2uuV3Ie/rgA4QfYY2mkFGo35nQQ7INBaURS8RvNnz5mk8
         9BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOhA43LmOrt8qpSaW/te4zffJ9QGZH2fj5kj0zYlFHQ=;
        b=IyH7RTz/DbVWnsa4XxypCVFOMSsaIgPPQrpLMXqwFY/R4RAfzBfGwZTHZLFrT2D4ZB
         IslXPHuJWlvk9/nUGacPytQRUqdgylKbL3YlLfC1epRX7zHjw6kkk29hcTtqU4kKUBPK
         ZyWC/2XrxSA96FTmzSOHkfDeweE5y2/whbzpLync3SDEDwpf8y5evINQNPFwRxjqLDm9
         U8eh9+9kL2B8XGWgQSz7xcRW/Qlp2kIsJwUkiVTZ8bU4DYrAI/IcID8dgYoZH31xhthg
         qbadq1KqZTKeg3+34R0d2Cd11w2BiHnGorFvr4WMGn4I4An+QyCd3a2hPTlY5D9a8mwP
         DDfQ==
X-Gm-Message-State: AAQBX9d1Q4u8Ef/5+zj6CFo4i9ki6QW6gL4qfNK0pNXeYC6IqtC5ceQh
        zaW8S6bx66KwtOArdiPeYwBOwaeVXYruU+i4SAY=
X-Google-Smtp-Source: AKy350befYly/lSC5kDrLJqEFpU6KISleaqO8PETRRTz0P/MBUQizsolm9NPaMHLFin3D8iORHoYfA==
X-Received: by 2002:adf:e391:0:b0:2d9:10e7:57e8 with SMTP id e17-20020adfe391000000b002d910e757e8mr9128945wrm.16.1680342811799;
        Sat, 01 Apr 2023 02:53:31 -0700 (PDT)
Received: from [172.50.14.32] (5-226-109-132.static.ip.netia.com.pl. [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id g6-20020adfe406000000b002d743eeab39sm4470590wrm.58.2023.04.01.02.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 02:53:31 -0700 (PDT)
Message-ID: <5a8a5cfb-6b56-42e9-8e75-14a936de2c4f@linaro.org>
Date:   Sat, 1 Apr 2023 11:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: arm: nvidia: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230331182159.1900674-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331182159.1900674-1-robh@kernel.org>
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

On 31/03/2023 20:21, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

