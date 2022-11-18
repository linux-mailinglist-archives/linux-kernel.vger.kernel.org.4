Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A262EF09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiKRIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiKRIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:16:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E06455B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:16:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so7038161lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grZJ4NICXdF2G/wQCy1rfpvzfnXZMazCRtlS3FxP9/A=;
        b=EiPsSo7100XsJMn/i35fEOUPjM57DMGuvZ3ztM6Hx+B95MV3Desk1upPCrJh06+uO/
         4vXRoIlxpDh1GjmCN3F8fMN/HwSA6OOFuTSfNGXntqSEUl9JplrO6uYrCuwLSqJyWZkE
         CPHjkOHCbt3ym5bfsxgJKzCIZ/JvQ/C6cYCGNYiCIhud2Knn1RqBwV+Wch1AiNHCjssU
         5GgsvzSXnFsCHKpm3wuU3FBfeZrMYN4O/8gr2wCpupytPffOuzXIqRK/tLkthm55Qinr
         s1BPMSBuYW8mhOIMlijIpKAFRnL0eVLdiEuIuUa6JFzrvW3PxvZ1YymosFw9OrTCGP82
         44Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grZJ4NICXdF2G/wQCy1rfpvzfnXZMazCRtlS3FxP9/A=;
        b=v/ooAmF4FKBy2ZbmguxlNyinSdj4IoRqgMCj9X1rFKvdjDtGYWHZE1wjVbSbOq8ghv
         N60G4qnfgk5ljuaYsZvrGOSjdEP/LNQP55Zw5IImQql6EmQ+7PB2nnbKN9kT8J35W4AK
         qZzT71W/b/eS4B6ocXxFNKCLpFPplmD5GRjL013I2eduROEmZauCepQb3fDuuNwcDaNt
         xkAY9NZnhjXJNhJ2bRMLa0VF/vk/Q/ZspK8o43hdCgUADBO4mMzRuMuXQPj58zohE/5P
         DU0U13GJ5BNR6wdYQT+k1angb+zbOsHt4DQwvPjUHfxWKUelitrqp0izyswH8W/PbB+T
         yeAA==
X-Gm-Message-State: ANoB5plRae3sxayD99pUUqdoc3Ju89gqkGdReVjJYi1bl5lAEa/5UkAQ
        h9AKBmQj24DSOfayWkH777tTgQ==
X-Google-Smtp-Source: AA0mqf6/sVDu+xO/1Gr2MEKrR0lfheX0m1lS07JqLuTzmvLJ/Unpd1ycv0YbyaOSR9XYI/g4LuYgiQ==
X-Received: by 2002:a19:4f15:0:b0:4b2:af4:65b2 with SMTP id d21-20020a194f15000000b004b20af465b2mr1913266lfb.189.1668759386499;
        Fri, 18 Nov 2022 00:16:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p8-20020a19f008000000b004ac980a1ba1sm566372lfc.24.2022.11.18.00.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:16:25 -0800 (PST)
Message-ID: <128a0b84-0ae2-5c79-ba2c-bfe26712a4a5@linaro.org>
Date:   Fri, 18 Nov 2022 09:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/7] dt-bindings: irq: mtk, sysirq: add support for
 mt8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
References: <20221117210356.3178578-1-bero@baylibre.com>
 <20221117210356.3178578-3-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117210356.3178578-3-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 22:03, Bernhard Rosenkränzer wrote:
> Add binding documentation of mediatek,sysirq for mt8365 SoC.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

