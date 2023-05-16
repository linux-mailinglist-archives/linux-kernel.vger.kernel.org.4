Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E869170490B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjEPJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjEPJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:21:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573E30CB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:21:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so21174404a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228877; x=1686820877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIxKr3aX2BYjnoWfUPAEf66ji9uTTT0hy2kkalP7tEo=;
        b=z2ocyro2qH97P1SExYDO0aZUDuVW2RYJH99+aT0lMGrRSNCAAMT7aH47X6trbdCej+
         0/gvFtvV3lw8YzkvRKgrtmvxrvbCh868VlGHvRMVzdlHNZ5/x/lGHZvK04XR7C+BbrRv
         VESyB/VVG2qES+iiv9YWTiDEHTA4N15GpS9K7eTCLR+1WSAflIJtqwtgqicnMt7Y0faF
         rsDxU3AZiGxmBtYal+wqdUHvxqe8YjkrbHR0gYqXcouIECcDhRkZtXt3Gwz9L63CpF6C
         eIOGQOhIw02s2mlM3xzQd+etEMvLEdXyu+QdAoYPfKYQ+aCyIuBnR04uWUI/hS8M5bfO
         jEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228877; x=1686820877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIxKr3aX2BYjnoWfUPAEf66ji9uTTT0hy2kkalP7tEo=;
        b=J4QinzkBDFPO1Fivl8P1kTJRuR532xWoxAGPRxfBluXhSJygzNAZ2npG3WfBdb0PmO
         bBnKN0UR4ir0asfD3wPgMwRKu0OjrrVX1aeXq5T7jg8rWpX0Rj++sHjjCfDcPPocCO01
         TwDA3E8OvKm59AWnhowTqmFO4vzgxzqiPrVC2Q/6wdpaspZDWQxqunNS7esRX/q1wxiM
         +zojbTdMlihtr86mi+2KEeyiZKy0v0ptWCyOD4kBWWxMo5JTqA0lnuNEs3j8RnfGjE5y
         rjWOamaleeY21rwz5JcZlJkcfQ2dfS0AhmKT9V4ll4D16oYVZUHuJxpdmthBO5GKbN4s
         8LgA==
X-Gm-Message-State: AC+VfDwsP3csqzHBnr/oyLX2asovvDRDfZdtu7ChMMWOsKfh6QWU2Jym
        p6hAfiQ3ckg/frahkrpYKBqC3Q==
X-Google-Smtp-Source: ACHHUZ7dzFmPjJCKif5jB1+N0nHY21kGqLzOZEPILSuue896Kpc4Nn7f7bqfkz3TWcmxSoNINxsYNw==
X-Received: by 2002:a17:907:7251:b0:96a:1ab:b4a2 with SMTP id ds17-20020a170907725100b0096a01abb4a2mr26409591ejc.25.1684228877779;
        Tue, 16 May 2023 02:21:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id tl14-20020a170907c30e00b00961277a426dsm10532335ejc.205.2023.05.16.02.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 02:21:17 -0700 (PDT)
Message-ID: <0efd549a-6caf-aa92-f78d-3dd0dbb12b0f@linaro.org>
Date:   Tue, 16 May 2023 11:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V8 RESEND 1/4] dt-bindings: clock: document Amlogic S4 SoC
 PLL clock controller
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
References: <20230516064736.10270-1-yu.tu@amlogic.com>
 <20230516064736.10270-2-yu.tu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516064736.10270-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 08:47, Yu Tu wrote:
> Add the S4 PLL clock controller dt-bindings in the s4 SoC family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---

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

