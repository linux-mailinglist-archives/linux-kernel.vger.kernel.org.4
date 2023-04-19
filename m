Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086206E78D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjDSLnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjDSLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:43:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2800118CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:43:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f7c4cso747427466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681904621; x=1684496621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7qkpoQ8OJU53FLfeOLWfZR335FdmCeupcypvuWDG7E=;
        b=z1g3GUpccO0jK8+eEoXERxUVo2G2iTysb2LWYEoDxZteaZZRtP8n2NQSMyAtA3nzYw
         bD+uYiXu6x3g12j8GKEXYx9BD4/pZaYv47S1j9heizsZOvdrovGDeayZsWoEM0rAxJX0
         dsr5qTUB8PBtuvWjf+AK8hjpIM55Ya1jtOfv/jHngc+YJ1qZZHNQvCkTA30kBTDWVo+P
         p6gGJgGiILZNsMkn9rfJ7FSMHkpgZX2O1pC+xNwjIyr3q1iFhChtxeUXK9fa3IbMplot
         CBYLwIEeK0vIt4PUW3dQ0CtJ1ZF2ISf8TyxWeWdmD4SWu4UAQW5beF4c3C26rL9ct+xh
         edXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681904621; x=1684496621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7qkpoQ8OJU53FLfeOLWfZR335FdmCeupcypvuWDG7E=;
        b=b4g3F1O4+X0/WzRaKBsQQFe+3JpuEedqiDa+AWxoKkint1Imq5qHzK4QPyKKMkVvI6
         wkAvGB863rxT1mnsMv2/qhFNFHnntr4u/Q1eWtLkEjfU6sCcuR508oXRpBWUdkMPUMHG
         9ylUNCt3qY7N2m5CDZibsqXY5Pd9ZvvD50oPOyJ4M/EOwZUra4FVHb+aKlODBqw/G9oO
         nMPT3Kxq3s+czEgpeEgIehX4rKNQsh2+Bul53vGNR3V4//NG2St8zCykwOT/8b/F42oX
         x+Fk4TVl7lRqIuFxo18uWYEYoHWpHq7CaLgJzLYbCS5FMe1s2xqlxsZwf+2V8WKR2/k7
         9jZQ==
X-Gm-Message-State: AAQBX9djcd59SA51SWknzzZ/d+NyN8Tn5qdCpU4mgt128YBRY1JNv7C6
        xVOJ5bU93Pncn+iF+HLT5jaS25W4dLlTyqEVnhpSfQ==
X-Google-Smtp-Source: AKy350Yptnx7kRfQsWEmcEnug3fgPHfaw4MIsiW4TpgZOyGo9JRp3DfFj4mUlPhPi4cnqttaenXSug==
X-Received: by 2002:a05:6402:31e8:b0:504:9393:18b1 with SMTP id dy8-20020a05640231e800b00504939318b1mr5382162edb.9.1681904621353;
        Wed, 19 Apr 2023 04:43:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d98b000000b004ad601533a3sm7972045eds.55.2023.04.19.04.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:43:40 -0700 (PDT)
Message-ID: <70b6f997-d420-0e59-0be5-6ae9db7aed66@linaro.org>
Date:   Wed, 19 Apr 2023 13:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: defconfig: enable TI K3 R5 and DSP remote proc
 drivers
To:     Hari Nagalla <hnagalla@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, arnd@arndb.de, treding@nvidia.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl
References: <20230419113958.17141-1-hnagalla@ti.com>
 <20230419113958.17141-3-hnagalla@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419113958.17141-3-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 13:39, Hari Nagalla wrote:
> Enable Cortex R5 and TI DSP (C66x,C71x) remote proc drivers as modules
> for K3 platforms.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Why two separate patches for simple defconfig change?

Best regards,
Krzysztof

