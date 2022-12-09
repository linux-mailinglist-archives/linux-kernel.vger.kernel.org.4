Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F6647F14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLIIPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLIIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:15:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882B5CD1C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:15:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x28so5863768lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TU3iTOgUKCrTzkxasHDvYAEVuyaSKUnPm4hRffDvfg0=;
        b=aUBEkLHMG2a1aqywjROvKDCIe9ylxqURVXAp8duIfrydYO/Faf9AThcdockIisPXdC
         qxFezRTBRK8LHAlZx+trl6j8CpOkjldoIzNt0QKbrbUcNlpj2Q4j5/VUbRHoxeY5F1OY
         G0ZSG4thKqKkkEjRsoHIgYUfSLZA1H6jUgp7ObtGzIB3rjKjnOHRfnlvW5qO+MjGKc3d
         hXJs6sv5h8XQhLlevPcxk2i9M2+9F/IN2tzGlbUweA88xW0cAzvbGobLwNS6oI4nHd/B
         N1RqeF10Psn7QtA+jH/l5BkgKLoRrmrz2oX+lsg44+bkinouLR8v4mOgaW/5O/II4bVr
         p4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU3iTOgUKCrTzkxasHDvYAEVuyaSKUnPm4hRffDvfg0=;
        b=EG+U5A5Vp3cPleR22Et0pQEin2kQYFuyriFPikbjUW3nNBvcbjpjHGbO+M2IpwQNnN
         g1OwsYgHC6gkm89ZS4pMbdyHk96Wc9WLzo2ERz+4dfUzhmhB0J9kdNnVpo0dOp345buO
         lucfixVak5/icCdZ86nvo1F1rmAiKBhT45cW+kGR8Brc+lNbsJfaOziNuCg5Pe8LpcP8
         rc99NguhokqJoioBQ0luZW0t9wrRKt88JZdGsw81bwZB9AXUfWmCP00wuo3WRl+LUUKI
         8xJNcQ7K7QE3k6RTTAlWDquKdqRX0lquGbUQJyclZBVI4rUNkhmotCc3J0foHNWPzFfj
         EdqA==
X-Gm-Message-State: ANoB5pnu80ahVan/8Zrz6dwsaDVSsAc1He/axESFS45uLBTqaV4ZK/q+
        awf1GsjXgXG8ZNyHfnksSZ+GlQ==
X-Google-Smtp-Source: AA0mqf5LH0oaXBX2oMln8F2dI/6wLckfhiUbmEX2RUMeqW67bVLpSEOEn0X/W+YSDlUTzAcknDlmew==
X-Received: by 2002:ac2:59c9:0:b0:4b5:6d7f:8cb3 with SMTP id x9-20020ac259c9000000b004b56d7f8cb3mr1162314lfn.11.1670573706925;
        Fri, 09 Dec 2022 00:15:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u27-20020ac258db000000b00494603953b6sm164105lfo.6.2022.12.09.00.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 00:15:06 -0800 (PST)
Message-ID: <6e5a2d2a-6d97-a84e-97c2-819053f1dd59@linaro.org>
Date:   Fri, 9 Dec 2022 09:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/7] dt-bindings: arm64: dts: mediatek: Add mt8365-evk
 board
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221208153041.3965378-1-bero@baylibre.com>
 <20221208153041.3965378-2-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208153041.3965378-2-bero@baylibre.com>
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

On 08/12/2022 16:30, Bernhard Rosenkränzer wrote:
> Add bindings for the Mediatek mt8365-evk board.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

