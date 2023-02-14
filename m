Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1A6961E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjBNLGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBNLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:05:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A48A274A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:05:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso13365441wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNBhJ0tOhfi/vHNTcvJXw08dO+3KSrahBNfcSUxMtoc=;
        b=AzynnouBDnUGerZIkvLHlXoq0VZkFyG0YBE/jACjBlUZ8En8vkUF7Aa9AMML3ewl5J
         49zYz0QxyUU1PrjvTA37g/WQa6ocbPL6q2EWWcIAK92+eq+KXMiJ+G8mmR0p2m3WGPtx
         Puz7DIXNHM0PoDR5okibCZ74cHzPhSJBRKLgsnQfyq3oGjzIPo5R/Xw4jHujdvlyTKnT
         4b51q/lGHQU7nCQaPRjSeJ9/oELfiUEK0+hzp1oGcTw9fVcOeAESGnuM2SNtiBwwkEBg
         TS0BOD8zkmnTaEAr7EFFnwtpoxH7mZwTX3a+x48v6TqPXv9hK2bmjStqXZHhjSb3NIaD
         B8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNBhJ0tOhfi/vHNTcvJXw08dO+3KSrahBNfcSUxMtoc=;
        b=wSWUy2tlUOEtaYigbMZyK0T288GEkKEPN5l10N270iGJhTQP75yc2WAoiYgLUo0a9F
         d7/EGzryMS9TA9uIzZHuSCa6WEpGwbZPJXbRCHCje+MgnZNmj1GTmOnPVk9xz/jq0jMB
         5Wa8V/xQv0yUfRhEDiiOH1aWAZ3aFLFGSQSg4gIsI0XBD0P9JVM6Ddts89Z6S4zCS76Y
         l6dVZewhxT039d63yc+B2M8AmegXkNcqZafE5qRID/iNRzPRHjDGBfPGKRsXBgM6OWHx
         DKZdmw+Npwpt/FtTAdFq+v4HVR7z58m53NlZ/83NuKnWPFOw+v2cZ7HOyRoHKHfPyuM/
         7f/Q==
X-Gm-Message-State: AO0yUKWCdaZ+WBxEluWyo0PkxInjbK8s+NzL4F5l3Nx5ZzQgYTKaG0YC
        1QSirZzUCihwZB6o+S3aYcB+o2seRYmnWXDH
X-Google-Smtp-Source: AK7set9o1NajK3wOegZGGAnKe1bRI96qHdhuWZYcWWmn/Xhf1p/yhYU6O2ERJUojXAD+ReolOfv5Fg==
X-Received: by 2002:a05:600c:554f:b0:3db:1f68:28f with SMTP id iz15-20020a05600c554f00b003db1f68028fmr1637801wmb.24.1676372712664;
        Tue, 14 Feb 2023 03:05:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm15922668wmb.27.2023.02.14.03.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:05:12 -0800 (PST)
Message-ID: <71f39f45-c649-f497-c913-eb4c183febc5@linaro.org>
Date:   Tue, 14 Feb 2023 12:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 01/16] dt-bindings: power: apple,pmgr-pwrstate: Add
 t8112 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-1-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-1-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.
> 
> This goes after t8103. The sort order logic here is having SoC numeric


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

