Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62768D2B9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjBGJZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBGJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:25:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66CDE4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:25:29 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso12658381wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYusMbl4fPMxM/IKPt2am1tzqQgaerR0Ur0r/xK18/I=;
        b=MiSrqfDP4AXpDQZWjexnq2es14hv39SBstg8R7kpgPbvP4njoxbKyFTOtQP9RHhX6v
         +WOKgBrbjgbHI/lFE52Bc83rWXMbt1bgUoQ/907obkavPBCALyKroyHMBUMj3vWL1TAZ
         UzRx4hdvwpQc84/5eBZ9xiKzYKzcm8FBd6zBA8qA2oVH4Hg/2ta+Wgtx+3ek9YHJuV0M
         0uMPGZunVaLiceS7ex2edNgC5VL7LGmDiP6tYImIu7yJf/E37dWBx2oIPaFSHcYhb397
         bW2IYOFksBYfMIqy8Hjy4T0gm4O2r31E9BeDZyau6zo4sxsJjq/1c/KcnfZwMgAE5lsG
         IRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYusMbl4fPMxM/IKPt2am1tzqQgaerR0Ur0r/xK18/I=;
        b=kAdiJaKOItsgdIW7VVT4l8VeTdjw7HbaZh1tcZI2dbKyZNj7oV68o+DTci9v4KGhsg
         KdmJ+IF0FtxyEY3+qZvIkjc/Jec2iFLcEPor3i/gKwZt91soyg6VyoZw7+gheV33OApj
         OhdQuhORYywzNmHuFEQjpXFzJN5hBJ8uluR68eVyCmgtgH84iooIi14xGazkEJuNFC+v
         5W3wKdOf7idKXWi3K8UV8Wd/ZVDsMo7nVKvUY33O98+1f5V7BkJU5fc4qT5Z+rZzEHmb
         S8XzDa20XYU2+Zpc0twWjkSIlSN4GvZ0U52ktRM5TUrnvFc9qEQM0LZEKoLGLBEA85Sl
         sxiA==
X-Gm-Message-State: AO0yUKVmW7oVZgBvcRYhEHkYw/A2mNyiS99xXu4FPKoS2nRJQ7VAJ5Hk
        8+yGgw8kmoopv+qhBPFmkRHy5A==
X-Google-Smtp-Source: AK7set/5Z/b8RWodGcLgLWd6kSGxnia8d6FmyleaY9eBDSe4mJ5CmR7vigaOaje5M7SWwdkRMMBWYA==
X-Received: by 2002:a05:600c:5112:b0:3da:2a59:8a4f with SMTP id o18-20020a05600c511200b003da2a598a4fmr2336503wms.38.1675761929304;
        Tue, 07 Feb 2023 01:25:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003e00c453447sm2979693wmo.48.2023.02.07.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 01:25:28 -0800 (PST)
Message-ID: <867ec517-ef29-e8ac-8e0c-6f7ca440cf3d@linaro.org>
Date:   Tue, 7 Feb 2023 10:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v11 3/7] dt-bindings: arm: nuvoton: Add NPCM GFXI
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20230207091902.2512905-1-milkfafa@gmail.com>
 <20230207091902.2512905-4-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207091902.2512905-4-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 10:18, Marvin Lin wrote:
> Add dt-bindings document for Graphics Core Information (GFXI) node. It
> is used by NPCM video driver to retrieve Graphics core information.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++

This is still wrong location. arm is only for top-level pieces. You
wanted to put it in soc.

Best regards,
Krzysztof

