Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEA62F572
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiKRM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiKRM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:59:53 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6740901
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:59:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z24so6690279ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcfffeNobYumFZ5ZCIp1bfA2NEySH/JJP9I2Y02WKAg=;
        b=DanRDUkQJA3Pp0DUuiQCTYGcEvGmUBzHyudLzr6IWwD0BRVpDgtGu5Fk05XNz0wIVA
         ZYfSbOKePpOhIJ3Ra0UzO/oTOBmMrH/LXS8ZjzbjcYAsOoN85brjLvExCkdpGouOzIX7
         hdqiqpunfOnR1zcLWZEk2eaqZfcZ8k6WG01nHlaa8rfk3ojTjkdxekUV5pTtYtxeTlYw
         rROJ40TqGUITwTH0RavDV7S9qcv+lkirPjItLlUxTJEfII9FAppvKMCX9bvgX634Emmj
         mn2lTr2JakW766v5Z/VWK6yYlPap2bWFXU75BiAaTEdRy7dN4+JhZFKB7g8crZUTBpVW
         3pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcfffeNobYumFZ5ZCIp1bfA2NEySH/JJP9I2Y02WKAg=;
        b=hvCQXCIoaJ7aDVRYEqZCQx/OcQ+SQYi4gFMmHHCoZ38MGJopZfPReA1xv0irYyiPQ9
         lQnEzG1sP9lbnNUNUQ6FneoK9HLl/S5EWMmlwHsF6YshqqNC3RPkSntlfFbXyeSHPxaS
         4UUOpgdIMtMjedoQ8X8J+69h9HtFqs9FVY/kWYhK8UGDzQM9cx/kqM/9MmRkYo1Ywndv
         4mEG+cWjyfiDaJUrO68g98hwukA1OjzX8LV2PGGRKHt0b0uS2k0lY3uug6WsGQVh33mS
         fGYFLcPDYfagxuBjerQ2u7/12/jBcdRpN/KN52n2FFSMCatFkI1hCcqHAj/38H0GGAum
         YxqQ==
X-Gm-Message-State: ANoB5pka6zcqLy4CDZw1yQSeL3aKaQBaPkeovrrsAOST0d9g/LwliTl3
        hsIaCTElbzp3wMbNTiURo33Szg==
X-Google-Smtp-Source: AA0mqf4tCKi7EZy6zDA12sMMRvEtUlQDmz88jJfTmxV9ptcDJhJ0Qq18Jj85xPAyp7dsM7hw1aKasw==
X-Received: by 2002:a05:651c:160b:b0:276:4462:2d20 with SMTP id f11-20020a05651c160b00b0027644622d20mr2330611ljq.19.1668776390703;
        Fri, 18 Nov 2022 04:59:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id dt27-20020a0565122a9b00b00492e3c8a986sm644905lfb.264.2022.11.18.04.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:59:50 -0800 (PST)
Message-ID: <c55e26fe-b884-e4e8-525e-f69f408410cd@linaro.org>
Date:   Fri, 18 Nov 2022 13:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/5] dt-bindings: ti, sci: Add lpm region and
 firmware-name
Content-Language: en-US
To:     Georgi Vlaev <g-vlaev@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20221116181307.198209-1-g-vlaev@ti.com>
 <20221116181307.198209-2-g-vlaev@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116181307.198209-2-g-vlaev@ti.com>
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

On 16/11/2022 19:13, Georgi Vlaev wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add documentation for the lpm region which tells the ti-sci driver where
> to load the FS Stub low power mode firmware and also the firmware-name
> which tells the driver which binary to load. Both of these are optional
> for normal system operation but required to enabled suspend-to-mem usage
> of Deep Sleep state.
> 

I think you got here Rob's tag after sending v4.

Reviewed-by: Rob Herring <robh@kernel.org>

Best regards,
Krzysztof

