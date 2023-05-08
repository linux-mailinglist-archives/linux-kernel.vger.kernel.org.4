Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0E6FAFAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjEHMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjEHMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:09:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A123386D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:09:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so47981300a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683547774; x=1686139774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0alkWdBHpvuiC9Qxq/F1Ql5MKlVBxIAuVvzD2Jw9WRk=;
        b=Xpz5r9zhImBkKOl1mNSvMbCNeY4fNc1JERaitXtZF6UXbXvYwLVqZXbZ5yTDibYxHz
         9blTvhc8KX0zyQtibXyiTYMVk3leIO7/iQ4wZGTBi4P0RrLkOG+8580n3GNJIUCMkICU
         X28cprlWpdqUxgx2Ob6J36fFjom+BWeNicNQgh1Mrp5YtWOTARRM6cy3sehZm5XWCCse
         biZD20B1lLqsBcdqkfY2vIJumq8IvnmWThaKQxCJAh/+qB3wYMZ00u9R1pNw+jITjMwF
         Ugg4mnnzQaoo+J7qp1fEEmuq3zJhoaVcv3uUR1kLOemfwuiAdNUYVYAN/MegEznGJzOe
         uAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547774; x=1686139774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0alkWdBHpvuiC9Qxq/F1Ql5MKlVBxIAuVvzD2Jw9WRk=;
        b=VfkE5Vy85rfxGGvO2Yh2TIty7RFV2kfnv6FOZ00nn/7YaQnBNUd8B6sBKcS3oNWfwk
         z0VHkjIQ1Q57+Gio5QQIcgtj4GH+pwAEgeWpaRzyR9v7Vr9tR1z08v8CLE3FWCqZ1LVM
         yv0RwN9unDWSDSe8zKwK5VgfTXa085YljFx/xvVr20GSJII4XOGVSRunv2ZyUTI9G7bH
         JFVwOH9FLOTwOhRrufMMj2OfGf07R8qx1h+rXvHZ8s4MZ2FaSFWNx03gbBgW/n7JLm50
         8lT5IJXvGL+atmR9fPO6OvfH5Kv4CkaHssDlZ8L5mlLrBcDnHhMRTyNJxRtxSziisrQG
         1NYg==
X-Gm-Message-State: AC+VfDxMwl7bAmzzaP4EIDrvvHTQvp0JbZif1EnBAd6MrWaF9y04eIgH
        sk5qvidLTNkN3kdQ/A6bTsGGig==
X-Google-Smtp-Source: ACHHUZ72DIJDzCwB3xOfPapdXG0m7opeBNqYsVjPfp+h14zjFTtPhf3b/2Nk+cULmjglkugE8Q2S/g==
X-Received: by 2002:aa7:d29a:0:b0:504:81d4:118d with SMTP id w26-20020aa7d29a000000b0050481d4118dmr8585292edq.3.1683547773819;
        Mon, 08 May 2023 05:09:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id o10-20020aa7c50a000000b0050bce352dc5sm6096680edq.85.2023.05.08.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 05:09:33 -0700 (PDT)
Message-ID: <ec1b7e1a-0b25-524e-a41f-0c2ad7dcb8a3@linaro.org>
Date:   Mon, 8 May 2023 14:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: pwm: brcm,kona-pwm: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508110231.GA19395@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508110231.GA19395@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 13:02, Stanislav Jakubek wrote:
> Convert Broadcom Kona family PWM controller bindings to DT schema.
> 
> Change during conversion:
>   - add used, but previously undocumented brcm,bcm11351-pwm compatible
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

