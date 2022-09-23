Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401715E7744
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIWJd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiIWJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:33:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D075FE3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:33:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so18852161lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AD0vTTxMT9RyIohVOxhCfhEFX/pSVlOoEyWGLFMykLs=;
        b=UhkveveyGMsC3fXDaMiw6HTgR5Zv+DbiE61b4ocxMG3/U8cuKdD2iW7i5Yp31yRIug
         QopqNYn25G8AvUp3dsrrwngLRlX/To+TOvIAji4gRf/yIz2Kdc1MOIgN8vLUgBVt+lHm
         cQO80P447qb3+hFff+intrPsHiB14c/0itSyHqIwD4OWn5hamdkRWZusiimZN/b3Xwrh
         iYGQsnjSC8YqCEjq5dtj7wqu+7nP5kfQ9eFe3XcfqSjm7eDvc2lbgQfOja66ySEnSuqr
         N1zckqBM1DuLaI6D9A6Pr1oTdeHId9lk3HPYWxBpeDKihykWbTWrdIRpnO+yEd78UhJe
         xnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AD0vTTxMT9RyIohVOxhCfhEFX/pSVlOoEyWGLFMykLs=;
        b=NAiMFaolLcqi2y4vzj38UKaMGLcg02Cqeu0SWsSYtivrPU6L4IbCia2zy/pUv9/j6o
         LuZB58T0e/8ZJVyZsGhSW1CKRwkM4MsiEO5yn6+KuJEOdsg+v8YA2O73CFyvcPDQ042n
         faieRXzpN27q+x+i5FXRR3FhUOzHZ2711mVWRXktIwZykf4ZfdiOY0mbH9PcIgQNnfMf
         VA7UlF7v7MV6TrRYvFwOAV+cwOUJkW9HUbZeTuY3j4p47ymx9IJ/2M0P+Ec78RbSCNZy
         7Xu+JKX2aOxLXzAYy7UkCy9+nwVG4HI95Ub9GUX02UrfA2spmMI6ft8XXqaBFps6r1yD
         MSmw==
X-Gm-Message-State: ACrzQf3k4nYB1MyD/7D4ESQ/UcFOSqbBbh0vOSB6t6O3rZgd63/aQ22K
        EqYZZHjQWKP6xxGx/Kmq6XLt9g==
X-Google-Smtp-Source: AMsMyM5ItBtaNE5LqPfrqHn/2dI0USL2WWX+6SJ0p7rlNnSh/9j/Nh1IbeRKKJtADpAcudz6OcL6dg==
X-Received: by 2002:a05:6512:6c9:b0:49a:51d4:d517 with SMTP id u9-20020a05651206c900b0049a51d4d517mr2977807lff.329.1663925610119;
        Fri, 23 Sep 2022 02:33:30 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q2-20020a2e5c02000000b0025e4c49969fsm1282517ljb.98.2022.09.23.02.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:33:29 -0700 (PDT)
Message-ID: <2d4f3740-88cd-c3c4-70f5-69c0a040d268@linaro.org>
Date:   Fri, 23 Sep 2022 11:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH,v2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@list.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1663915394-30091-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 08:43, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

