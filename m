Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B973D55A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 02:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjFZAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFZAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 20:05:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDE1A1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:05:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so1786675e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687737924; x=1690329924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2ettOAspbQorf4bn+Ia/eRHWKdTUci+Mt3+wF2Edk0=;
        b=EcMZw+YStZkBam9UpgQFHyULnJoGfBUBAgq8i0pyVWw1X3pN7ydpTacri6beZVAJ4q
         y+ev3c51Re2ro3YT/tuoyejUC5FDfbdhtz91EDMwtlG/GkW4SBJO7vXMcWijJc3+895m
         huXxuZOFztBkMKrqeQlxTYSfkCQoyAF6zPvuzTFtBAQ2zqz+sQUYWZC7CdRxeIvM+Sj0
         JE9Ieh1E6av/KRwR1H6+0IbMYZT56xf/AbPxu//7HOOwEgeLux2yOAaZ90oN/crrJcQs
         2xOPFHAescTDrOrjFONG/Lyh21DHrVXNo8WdV/HPtD2GLSt6Bq7fRiW6hJrVGbWUaQB5
         H6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687737924; x=1690329924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2ettOAspbQorf4bn+Ia/eRHWKdTUci+Mt3+wF2Edk0=;
        b=i+WWPNq62rhgewDAkA3leI0us/uUqVt4L9u92957pYG2zpK+FAtrDZr4/mDdPhtWpJ
         GnYSyMb8T/1r8LvfXNm0V5A923em24MUiuhrsqok5JJzz9QS91bKv21TYGdSpos5C9vy
         dgIRCPM69t9fwYic35kI9026THStv5E7mt+jxgut6K4W3QdT6zTo0vmH+lm98VRYZv3H
         Iw5h0WfbIj4UamUAfUz1HlXE3dRTagqfrBg4hW4GX2dj7inajXPXvUOvoWfOrP7itIQc
         GRYRKxMdxF+jJxYcNJCOGhyjKTl4nya4nFLQpByUpFClztTZD0szyZ88VTGbNvZHp+o2
         13/Q==
X-Gm-Message-State: AC+VfDy/CLZoUveyEJnIZ7B0gXHRLuDOtSAQI8yfouiFMWeCm0B8pcUu
        vkeYtDvVkRzdjMMt4lUF4J6ikw==
X-Google-Smtp-Source: ACHHUZ47HRHZzNsG/QxT99vQVwwhxIXWh23ZM1VJgUJPwxOVpoGgc6uorN/ypD6nGsQFMjvnwr/bZA==
X-Received: by 2002:a05:600c:a3a9:b0:3fa:79e4:600f with SMTP id hn41-20020a05600ca3a900b003fa79e4600fmr5409487wmb.4.1687737924391;
        Sun, 25 Jun 2023 17:05:24 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c2c5000b003f78fd2cf5esm5922562wmg.40.2023.06.25.17.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 17:05:23 -0700 (PDT)
Message-ID: <2e7b0647-b108-5364-a7cf-955cacf9b322@linaro.org>
Date:   Mon, 26 Jun 2023 01:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8939-samsung-a7: Add initial
 dts
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita@trvn.ru, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230623100135.5269-1-linmengbo0689@protonmail.com>
 <20230623100237.5299-1-linmengbo0689@protonmail.com>
 <5fbba4e8-a8d9-0e99-e112-31b5781c1648@linaro.org>
 <20230623104647.5501-1-linmengbo0689@protonmail.com>
 <71ae3799-4668-891c-c32d-d36da655d56d@linaro.org>
 <ZJiY1PYtfeIN13ZG@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZJiY1PYtfeIN13ZG@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2023 20:43, Stephan Gerhold wrote:
> Is it really worth it to support a half-working bootloader though?

> No one will ever be able to use this properly without fixing the
> bootloader. SMP doesn't work with the stock bootloader, many devices
> need display panel selection in the bootloader and on some Samsung
> devices there is not even USB and UART without special fixes in the
> bootloader.

Why set the bar higher than necessary to boot a kernel though ?

Its two lines in a dts.

---
bod
