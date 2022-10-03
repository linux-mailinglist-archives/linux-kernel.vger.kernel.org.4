Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD95F2974
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJCHTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJCHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:17:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA73474CD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:14:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d26so2511457ljl.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wYR4NfV8b6uyYjkuS4ioBsPmvXID6qlbvYaMpLrsWeo=;
        b=M5IEXsDyin6ySOcRWawZaJmNk+565XVGaj7rLmvlyBrXacUxV643XlZ7s41y2KgMDK
         5+/fS2rtB0F0eeiAOwBQ1wGhm52uJXweQzs5cbyQjf22hWmMA5V50a4Z/Z63SlsNGtQR
         4pPk0k4Dazr+sk0255eBtOMxj1K7aK5cRSdUhO1KVn0vxMfBlAO73AF0buE1vrfQXmUN
         5sEsw7/Zdehoj6BucczvV0RUn6kyEmAjz//wvT5nWVYl9GP0XKoN/XDu577O0IXGFeKx
         YrhJzyc97g2sFikC++1pwf7xhu6ilH/VdfrJRjY5SjvA/yxOrWbwA4VMj7cIYmzfl+Km
         JIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wYR4NfV8b6uyYjkuS4ioBsPmvXID6qlbvYaMpLrsWeo=;
        b=Ev6hiIK+78wY7/qC4YRgq8kIVQgWeerONpzAMk3DQgVeRpVcYpBMgcrCvKoiGr3unh
         TkSQX2Tv8krtZXftMJKIMip2Dr4Rjz29ycThQg7GGMsEd/u3KAaKdbUG6ONCDWXMgxo8
         4fajxZzoSiVN8hpQMmMSre+ycp1Aigz43XBjrdUsZrnb+Y4+6RJBFXXPfTh+i1rT9MRA
         AnsIFluR5sh6OWfCzUCD6InUUy3+0dTw5roAWYyfpWzxpVwMcxTve/Lrs5qd1XGM0KOB
         N7YN2rj+buaUkp+YojHsdtIuA0Hwexby1ZBIxX6vdfdum5SPYe8BtcwnrBM0NVzCnUTz
         qcjQ==
X-Gm-Message-State: ACrzQf3cmr0T3GQtiXqSxkgJWNZOnuYe8PSNO2Ui8yE8ZtRb40ouk5sr
        QAymFAs6chfioIzcWVFVoCHKnA==
X-Google-Smtp-Source: AMsMyM4hqeB1DIMt8vJl2VZ3nxsQtjBqiz9YIXnZZtgsKSq91gR1uL9j7f2Z9PlVU83e5X+CYjtz/Q==
X-Received: by 2002:a2e:8e62:0:b0:26d:e470:3973 with SMTP id t2-20020a2e8e62000000b0026de4703973mr209145ljk.71.1664781262835;
        Mon, 03 Oct 2022 00:14:22 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651210d000b0049468f9e697sm1334586lfg.236.2022.10.03.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:14:22 -0700 (PDT)
Message-ID: <fe399fb3-a8b1-14d4-3460-4c4ef36a0dc6@linaro.org>
Date:   Mon, 3 Oct 2022 09:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: mfd: mt6370: fix the interrupt order of the
 charger in the example
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cc89d749eba56c5f2489d1707f7711733561b757.1664792418.git.chiaen_wu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cc89d749eba56c5f2489d1707f7711733561b757.1664792418.git.chiaen_wu@richtek.com>
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

On 03/10/2022 04:52, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Fix the interrupt order of the charger in the binding example.
> Due to this patch modifiacation
> (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),

This is already a commit, so use commit syntax.

> there will get some warnings in linux-next when compiling the dts.
> 
> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

With fixes in commit msg:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

