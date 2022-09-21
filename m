Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912C5BFA96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIUJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIUJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:16:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366528FD74
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:16:12 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so6168189ljr.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IT6JEcqJI3DFzEaVJ8dSJBsLw90K5SbYBxlXjJR590E=;
        b=kMnkMAlTVSRXaxa1CyAz/HMUDwRyD9U4BpEaaKikw6N4NJ1iFTDxrhjw7uboupkrL0
         zLAqxDJlYkGjgglZI03IiCsv0IyUxo7phFVT84BzvEn7iKOn074+lxXiUkazAat0oow/
         EONLl5dEsYjdj60KoZc/QV9RxDwW3/iLExNf5b8hecUY6iubCGG2mnYeTSZXSs0uastY
         cR37koVvUkLR0gya6DMODh5PiGYFox50OEWzy+cmdeK2jmK6kBewt2aOucXg21o+NfBR
         VFKoLyZvhZH9dqwmMF6jAT3sdXE2rBpN3iz0dl+WvfECQmYyjw98SGdzyPedHFawH7Xk
         C/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IT6JEcqJI3DFzEaVJ8dSJBsLw90K5SbYBxlXjJR590E=;
        b=OZUWJ/xrNCFT5/qcoZ4rIpQxvPTszAWOA6zMpGUx76pSK5XdEX/f3da/lIkcVdQ6pa
         Ol4QhwvrgaSLAyjgttJixmm4UfxrwYjaLBhbSut55PAQk12GtgOvSdG1Uj6yv+dk8NFt
         rHvJhPHlv9KOgUcE7Rms3N3SgvInD1w8+CrKcE+sWwBHaM3iABhJ6iwqwLMaMCUFmrm7
         Oi9gN5jRojX2oBrnF7+BG9WQDQiEL8BjMezLFlLJTVH7wMol7JQizcnuvuCyOAq1jiI/
         zCVHzhuaZMGnFOM0qUT9IhB2AEoEKoOaEN2yb4XFihQhpgbs+MWBFyVE6LVe3AkRKbOR
         +KhA==
X-Gm-Message-State: ACrzQf3YYBRwjJaKQbjBVRk4HcuwfpAV0XtW1Un5/yuMwIVE7n17duhZ
        0cktrDXIhe5zdNMsvsdujl5r+g==
X-Google-Smtp-Source: AMsMyM6fQd5NKg7ykrHov7EGyXfZT0dNc0fXfDekipf+Hm9POrmEODvkwmJcIv4qRiu8KBlM0SsfVQ==
X-Received: by 2002:a2e:bd12:0:b0:264:7373:3668 with SMTP id n18-20020a2ebd12000000b0026473733668mr7903000ljq.18.1663751766971;
        Wed, 21 Sep 2022 02:16:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i26-20020a056512007a00b00498f570aef2sm344276lfo.209.2022.09.21.02.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:16:06 -0700 (PDT)
Message-ID: <c5f1b3dc-e407-a7b9-f55b-0683b0e63a62@linaro.org>
Date:   Wed, 21 Sep 2022 11:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/1] arm64: dts: mediatek: mt8183: disable thermal
 zones without trips.
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org
References: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 11:05, Amjad Ouled-Ameur wrote:
> Thermal zones without trip point are not registered by thermal core.
> 
> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose

No need for cover letter for single patch.

Best regards,
Krzysztof

