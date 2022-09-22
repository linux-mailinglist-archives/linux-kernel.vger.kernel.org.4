Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8F5E667E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiIVPJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiIVPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:08:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C4E11AB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:08:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p5so11308726ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=XMagaWj+qsBFjnLrI8sBIja14veXFKrlDQYG7XtfNWE=;
        b=DzHeHLFn//JTk6UMm4OPpr3veynEUt1p2tLF3kaAVSP7dhi51cuhKTE8BKS/jNHgju
         G77Ldz5TYdPY4501O0mvoOWrjRKHaDvf79vQr9UAcGAnaVmYZe1+c4oze5GJnMLO3sdb
         0ocnadIuQIcTB6XmIkT0xruxTHb/LUYjvXN248PkKjx2QUKIIT6yrM2t26YxVV+MVr0S
         J5BHjtdYX935OrxlaGMSJbHRcy4SdJgoZfAoyv3rkJ/QLqHXVz0WiNtLts7slfYBfsRk
         YTJALdwyX/ACqmJUvQiUoJZ/FgKzGR/9V3WMDAH7rxTR5RsMc0SQRrobCJ4bTrlcHdSL
         NkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XMagaWj+qsBFjnLrI8sBIja14veXFKrlDQYG7XtfNWE=;
        b=yqVtbkw9qwJxQpUP4IlF3wENjGhwDARjd0dH4SWer6dRtXVgLQA9rkiRnAoGJkFW1I
         ibxt2oLrKnETz2EXaI1yq5c7STQx5Pbe3a6WYKL6EaafowUewnRydS1CKyPtBGp/QEuF
         3+kM+zrnS5/+WWdUcgYUBSoWoBpy4jOwrSF8k0prBylFTPa865f6BLqN8KQxoq11Lzga
         wAEqOYOIcNZHL3UnkV5qCmbAsp7AWARlw87hEGw2qpg7lE+VPHFLACvHyoff+BV/bO3E
         2U4ImEVHOEebGweMOwTD0L4ew+V658zewuEdJFH3mg+N++6UidL6dwQCKZgDln5n0VJN
         wmHA==
X-Gm-Message-State: ACrzQf1tWwuXG+JPE8/T2CYm2wWV1Ig2Vt/ZDf0LENGZv0QxaKzy5VkU
        X104Sry3FmO/PrjARzpagcutbw==
X-Google-Smtp-Source: AMsMyM6Edu7WLfsqQrPewr8KMaHpm8Q9cLMq8zru4YXuHBvZo74OAhVg37Deu8WkRBA+V2L3rckbCA==
X-Received: by 2002:a2e:a7c7:0:b0:26c:4fa4:47f6 with SMTP id x7-20020a2ea7c7000000b0026c4fa447f6mr1266324ljp.171.1663859334226;
        Thu, 22 Sep 2022 08:08:54 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b22-20020a05651c033600b00268bfa6ffacsm919565ljp.108.2022.09.22.08.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:08:53 -0700 (PDT)
Message-ID: <29d54940-997a-865a-b9d0-c043a8c9ce99@linaro.org>
Date:   Thu, 22 Sep 2022 17:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] dt-bindings: rng: nuvoton,npcm-rng: Add npcm845
 compatible string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, olivia@selenic.com,
        herbert@gondor.apana.org.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220922142216.17581-1-tmaimon77@gmail.com>
 <20220922142216.17581-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922142216.17581-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 16:22, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 RNG.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  Documentation/devicetree/bindings/rng/nuvoton,npcm-rng.yaml | 4 +++-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

