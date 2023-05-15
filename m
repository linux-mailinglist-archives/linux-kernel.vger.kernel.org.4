Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7097024C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239849AbjEOGcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbjEOGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:32:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36D139
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:32:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so108299723a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684132349; x=1686724349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/hYvCcBf6b2cvUWeK/Zz7sqw40AaKUPJTT2dMrut/Q=;
        b=anAg46r3ItG7TxcWPmGuHeXhHGLKN+nwU5I/BaIYPU4UiOscHUTadRL+pNRbf/gYVb
         8MREHFIQAa9kjGLnQykkQe9c5bLgg85EQVXWPsJzjJuPq3DoMcwDL4Z/Yk6Y4MCBqbMt
         FiM0re6eTy6RayocX6uDWemmtmLxfNWKTItPkbHpmfnqULHK/EelaOr1KnkkS8J8zG4S
         gHSAu4G6iBMwAxFc1Zn+tfOkxaFSXUkn3fYvPljK4aMNzLROLTTAMniixl1XB3p6+fg3
         XrnDDUWkx4JnxaGcmA/1h3oC0bfflrFgXikACk6tTT6ReFWajycMuQaWkMi7r1A35Wui
         qrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684132349; x=1686724349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/hYvCcBf6b2cvUWeK/Zz7sqw40AaKUPJTT2dMrut/Q=;
        b=bb3UbST8wLcaiawvOrmBo4c6H6PRaqXYS8N4QlMLGU4R0x34Q+hDCLlw5Ic/B3o5o+
         mdUcpnpHDs0pLE1Mf+75OrsPuGr6+S2cDBrP2p1zBeqO7fI1GzT3aQ7Ml48C5hW6XY0Y
         qRZG4RQuoBs5o0Nly9XXdyg9g0MimEad9KJ/DDjbUGQhueLZi8BthKOIV8ZQdp8fbTTx
         4Yz1oney4H/hH96VXrMu+mzAOq/ebJqYp4HzIwzvyDEUL5IIljz0loyGD5hCYQocrtB2
         71PmS/PHEmiMc3tvrgv5L/so+Jx2vDurOH1zWj/Vm0o1iADfMPlaIwRUQPiztzlVRWgT
         QoHQ==
X-Gm-Message-State: AC+VfDyXQAsicQSUeYQzYcm3zTo8XwC9XT9Z8LAyyNdXLOoiab7Y9uVz
        KwLfN5hCeDrNDKwT2xxHwcUCIQ==
X-Google-Smtp-Source: ACHHUZ5G5Kk8YwVeXUzhpeXKMrTcjuQZ9G2Q+2fbGgBS0iUKQ7ma65pjl4f7B8m21PO/4Bg2keLvVg==
X-Received: by 2002:a17:907:3d89:b0:94e:4285:390c with SMTP id he9-20020a1709073d8900b0094e4285390cmr31602369ejc.10.1684132349638;
        Sun, 14 May 2023 23:32:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm9129015ejb.142.2023.05.14.23.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 23:32:29 -0700 (PDT)
Message-ID: <0ff4b9fb-c56d-b896-e2de-c2f189a5e6d0@linaro.org>
Date:   Mon, 15 May 2023 08:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
References: <20230515031557.31143-1-yu.tu@amlogic.com>
 <20230515031557.31143-3-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515031557.31143-3-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 05:15, Yu Tu wrote:
> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
> family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

