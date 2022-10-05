Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D75F5086
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJEH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJEH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:58:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC675CD7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:58:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g1so24414831lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KUsLX/hWASy12r6kYppLjzYWaxoDQvN3XOBwDMKiNOs=;
        b=XoO3jDPWWS4/Pndkc6qxbPbxflHYBqq8Xtdl+9T3JA7WXPzxf9Xr8qAN3L+ExOlG6l
         vB2OJB7h6jxQXiZwug0EhespStT9RcAFVPOKOGo6QT7v7LKes9sqjaSRzxKd3f2jq2DF
         L8wiBEpFJaztuO8faVSGNcev5Rb5rz0WmPia5PoyqXOjHsAitcLCex+Qu5XQo2yH+GvA
         vIN53mRFYyJ3mmdEhh0SbMQ0avzgdPLiMPl4LgPLrLmmP1GmJkoa8Z5lUKE76VtVEtKx
         4yEWuy0QrUpdTCHB2F6I4Wh/As+oj8ZlWkEEg49sXfzQwzSeBoHYmjpJuHUnyVRMaouD
         nngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KUsLX/hWASy12r6kYppLjzYWaxoDQvN3XOBwDMKiNOs=;
        b=77cst1JIoAxqqz1Xt2LWOQZu1l6g2mfwcveHdNsBvk8byGsQ/7fBQ/NDkO2jgHnEJP
         SnmBBgH7kox4n2YHt7U9SOdo5qvD0o0dnxqIJ41vtz8TkVbvKiMto5+r39Dp4MnlH0pp
         KK82jt4FbOvW7ZdThjpcxhF7uFpCCm7s0L8HfIBIIcn0pW0YSA66sWJocxSQEalNQE3j
         xixKRkGBYs6cD94RCeBJUQbgJypcwUPAp3c1xuivThfWMAFmARyGaUn1Y/UnuX2WitE0
         x7SQD7Ow9mVW0RF2l3ZtRomTfQfN6RaxxgoGWFh16MNilLQooRN0yVOYVVW4QEujbJ9o
         OlbA==
X-Gm-Message-State: ACrzQf0KYtFSu2TQAv+FOLh7mS51ZEM/Ol3RudzQ5sdDKCT+0F3gA1Nf
        hI3Rzgz8l3lfAUOI1C2zGt6Q/w==
X-Google-Smtp-Source: AMsMyM4+3dxfgnnUtl02AminNqeaOjFbPBjmac3Mhxv8glQtFW/MU/jdxOlIiFf6p4bAoKKNG5KGpQ==
X-Received: by 2002:ac2:4d28:0:b0:4a2:40ef:2996 with SMTP id h8-20020ac24d28000000b004a240ef2996mr4025845lfk.425.1664956708094;
        Wed, 05 Oct 2022 00:58:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0026befa96249sm1527520ljc.8.2022.10.05.00.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:58:27 -0700 (PDT)
Message-ID: <c352896a-0e12-a946-d018-764fa0f2a95d@linaro.org>
Date:   Wed, 5 Oct 2022 09:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/6] dt-bindings: soc: mediatek: Add support for MT8195
 VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
 <20221004093319.5069-2-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004093319.5069-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 11:33, Moudy Ho wrote:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Add compatible for MT8195 VPPSYS.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>

Missing SoB.

Best regards,
Krzysztof

