Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61547640529
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiLBKvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiLBKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:51:20 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058CAD039E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:50:53 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b9so4988301ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUa/VqnmfOXM9528l3SlSKgYGZjywEB8U8BxliATOOw=;
        b=VFw82rS8XMajD7JLPjZ+OrY2yzep2Gk0Guq0onC/auwfDMFkEMBSJJx0LP3b4ROEyM
         2x3u8HkPtMufM29Iq9RK8weMrGcVDy/xOxXIpnO5gchMRnIkz9XuuvErWhRoxKUkLKVb
         iZ8pqsFFDI13GWdDwYvRk/NinjvRI7NcQoS88pEGR1eiHd+jOPwSuxn434tG0RgAtWo5
         2QpjE8VMyjSbugZmbk4n7RCYbqKN9dr0LBsqTKnbTzspVVZ4nSA3PsLaM5T3X5/PEiel
         Ymb4nUB3J5/loHSM/+OQieYDX2c6bUPKBYsnYIucB+ujPfnCgTFJRRYKGrqYfkVR7yDk
         SWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUa/VqnmfOXM9528l3SlSKgYGZjywEB8U8BxliATOOw=;
        b=LeXvR6ogYFGupUkW0AFC5VOKF/uj/WSXQ+bcDMmPMEUwy+rX+tXDhVvnKktjNRX+ub
         C5kQUU8arKfuzHTC7/fqiiweXOzDBWm1xQbkItGEQTOUVFJ5p4gtujjOunnuGFimSv1i
         FynlIZ6z/euoO7QPWpU/hZN12RtrsR1ZsCMvy1QKxXj95IaXWvx0I6tNWnw09bRsmest
         LLoV0Y7X/yCYuZU4Bo7XHYSMQ4UdtM0QGmWag8FU1gqBtx2nrfRxeI29wURgmFZcvTUa
         h182Srq8A5GGwHOMM2q0kpqiokcwCrPFP5vSFreq+f4mpUYcgb7qBVFuTdVSgXQGzbCp
         JJNw==
X-Gm-Message-State: ANoB5pkWa7jEevHRfBnUcSXD5cqd5kc7gJRJQE9DzUN5m083Z12zN5Mm
        nUlENCZ2PCSgVCwTOtPmfpR3lg==
X-Google-Smtp-Source: AA0mqf69Td280s1XXMPVErEzICrOPlatkrfekwHdq7BevjGZeeR2/YEfCma2e9rB3r0TZ9CLNv+Ehw==
X-Received: by 2002:a05:651c:1070:b0:276:ac05:b821 with SMTP id y16-20020a05651c107000b00276ac05b821mr24330666ljm.84.1669978251393;
        Fri, 02 Dec 2022 02:50:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b004a25bb4494fsm974799lfs.178.2022.12.02.02.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:50:51 -0800 (PST)
Message-ID: <1b2ae3ef-a27e-accf-4533-66916fe59773@linaro.org>
Date:   Fri, 2 Dec 2022 11:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: =?UTF-8?Q?Re=3a_Re=ef=bc=9aRe=3a_=5bPATCH=5d_arm64/boot/dts_and_arm?=
 =?UTF-8?Q?=5fscpi=3a_add_to_support_Phytium_FT2004_CPU?=
Content-Language: en-US
To:     =?UTF-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <tencent_12CFBB7717187D6F2B9A3246@qq.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <tencent_12CFBB7717187D6F2B9A3246@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 10:23, 王洪辉 wrote:
> The approach is passed the test and verification on FT2004 DEV board.

I don't know what does it mean but for sure you did not run dtbs_check.
Whether it works on your board is different story.

Please also do not top-post and respond to comments inline.

Best regards,
Krzysztof

