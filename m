Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90D46294B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiKOJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiKOJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:46:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938441FFA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so23566850lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1JeqX5odSdiE9z+C7xfGPHj1H7CFKFZd62JsMUYziw=;
        b=MJrc8NbiTdlLDGD2cQVlGwIJq1WMjvYF5NiLIIBqeL8kYw8rVh858vB5aEDpVfxVLs
         MZM978vFS89anAMKLhhThPII8gebNMTJ2OW/FLlo5XA1F76euMs5PEgz38F69xqA5bZK
         NOZOCazl6hao1uSdHoZebPFO8L/NdHjpCk9zHxcU7IIuAizAQw/oJ6rFom6gswehkAJR
         dRUjCyGCC4T0W/0T7gdSS1LrJhulckqFwR78KtOKdzcHdO83tZOVDGlPrYkMpO+pa8Uj
         p3VjwEdqGF3QV09RM89Gx3bZXbXzkGttHPPhu66Cp1RZPQsL1sYyB0jf08+Y6cYlgoqW
         wx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1JeqX5odSdiE9z+C7xfGPHj1H7CFKFZd62JsMUYziw=;
        b=KOQ6M0PZNLD17kJjIjOrzj0bFAh5Nex0WrtC2n5uzXvKZAE/Larj/roqN2vwP6E2Do
         hXz6GSiod3zJAIJRB5NDLCglW0jq0k1FWtKVzzCG6zgXavYBl4U86WFQDDJ2aT3QvbA8
         pDEzeFrKhkMQzAa61ix1ywdlBtG4SsqeUDYicqQ613Inoxv/IqB6YC7My1FKA1aHncad
         mAf7hOA7n5Ae/jTIdJnJHmu1FQ5y5MFky3qJ/FIr/9Ye9RJl2YBTanUrTPWQxne43ZQI
         gepFnmO3Tov9tt0P29A2LcMB28R1U/YbR8/qEiEJB5b/IpYRSLjHaHR0PZ354VOiMsiB
         sfbQ==
X-Gm-Message-State: ANoB5pmS20EDK4Q9G3mn6HhxiLILZoFIPhvdBtPpxdtji/tiM2UQIiew
        M27VkUdU34WhinXmEjbGU82PNg==
X-Google-Smtp-Source: AA0mqf4YOnEtNhH9OjeHwVCGPWZiIhF5Y7O+6X5Fm09KD2pOC0mh50rSsWImI6hnrZ5cDgrqD/wv1g==
X-Received: by 2002:a05:6512:1115:b0:494:7055:b085 with SMTP id l21-20020a056512111500b004947055b085mr4910808lfg.109.1668505564078;
        Tue, 15 Nov 2022 01:46:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u3-20020ac25183000000b004ae394b6a6fsm2129960lfi.246.2022.11.15.01.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:46:03 -0800 (PST)
Message-ID: <817f4249-cc98-d3f2-dd55-4e26b2326884@linaro.org>
Date:   Tue, 15 Nov 2022 10:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/15] dt-bindings: timer: Add compatible for Mediatek
 MT8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-11-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-11-bero@baylibre.com>
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

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> Add dt-binding documentation of timer for Mediatek MT8365 SoC
> platform.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

I am not going to review this - please go through comments you received.

Best regards,
Krzysztof

