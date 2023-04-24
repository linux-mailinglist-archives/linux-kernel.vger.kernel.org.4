Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793336EC6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjDXHWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjDXHWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:22:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68A3590
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso5988768a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682320907; x=1684912907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww2Rb2ZYTNoPsDX72jxf82dsZ3zHW1B7HQ9wKwSxxmQ=;
        b=HjDUL90x3Q25a2KB+D2nRqlChkDveT7RSsZN/F2dg0/rdnkoUWq7tKRoayXsnI2eX/
         l6ck3ka/VNV+nEVOgn69gy06ITf83qM7y0MQ0xSbzkZrCsb94chgNHKYhRKVnjUuj91w
         DR5vjB2FBsibOlPMkeoSsOCJ/5sTsppXWdRwnZHokufihQZdnyKoWVco8B75k3/V2pog
         ng54svibGcWyJPtF3DbESCuibaDhNBUf1szeSbhfvxG+rs7K0rudWpYoxJkeJK5Za36u
         wl47h8v7jGs/qxVWeeg+QHIRU6zHguhAa7yDa3F3cuaoHrkeqA7vQ+ovFR73zsR8xM0N
         sl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320907; x=1684912907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww2Rb2ZYTNoPsDX72jxf82dsZ3zHW1B7HQ9wKwSxxmQ=;
        b=D+xmsIUXaF7k6uOjiBNdtzeDQmh69iEST503wpwlxSKp0vLt51sD9CByw1/rshIs+7
         ZDX0IDL8uDwgg+2Y7cA94ABM47EV7gu6zDmIORTIBB/HAgM1YqZIuUVQrZJPSa3GSax4
         MTOwK32twSbYgKhgthglo9dbrfICN5WXPLnPnryL4XZg1jIw2kVGUrUPJfHw8oR6awfq
         dkLmL2Nsj7X1sc8WJWgKQyVyISa9r+OsINxMo9fawJiVEjsMAdeduTSq3n6PVxlrS4t1
         BKT4WEim60humPIUNWgXhypd74RnPxP5smKB7S+IcM1NqQCWv+T00njjF9J2lJzkpwfj
         aBDA==
X-Gm-Message-State: AAQBX9dFlhkDVaJrzqgfxfkwcktbkFAL2N2+xvZJ6CtuukGexOZQVNZL
        IgeU0OsiCEfFXmbaW95TFi6gnw==
X-Google-Smtp-Source: AKy350aUJyBwBhZmp9D9e3H/8ISMoktPB0uAxONtS4tlF5F4Zu71qTXhfJNl3i+dxjGKZh3z2HDZ4g==
X-Received: by 2002:a05:6402:12c5:b0:504:80d8:a034 with SMTP id k5-20020a05640212c500b0050480d8a034mr9436284edx.40.1682320907691;
        Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:fcdb:bf53:d053:3a52? ([2a02:810d:15c0:828:fcdb:bf53:d053:3a52])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c74d000000b00501d39f1d2dsm4398166eds.41.2023.04.24.00.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
Message-ID: <abd106b1-6650-6a7c-1c8b-3609e47b0161@linaro.org>
Date:   Mon, 24 Apr 2023 09:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/4] arm64: dts: qcom: sa8155p-adp: Make -cells decimal
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230421205512.339850-1-ahalaney@redhat.com>
 <20230421205512.339850-2-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421205512.339850-2-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 22:55, Andrew Halaney wrote:
> The property logically makes sense in decimal, and is the standard used
> elsewhere.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> Changes since v2:
>     * Collect tags
> Changes since v1:
>     * New patch (Konrad)

Doing such changes per one board will be a lot of churn...

Best regards,
Krzysztof

