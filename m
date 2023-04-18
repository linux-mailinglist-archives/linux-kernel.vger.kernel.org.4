Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B36E5B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDRIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:07:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A3F7689
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:06:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so18938327ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681805135; x=1684397135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N9kSZFUdqVn+fsWq+VvKAfZ+uj4xzdN3B+p6/q/UjQ=;
        b=Tv+KanZVpgnRBxYFRSV0C5aRxudrtcZwRIbreeVBjVBGLi/RXaKCMjMuNbhX/UroSk
         DonS2r5+kUhZhhM7sQVHY56XF32iyOQnzrhrMgV84HkdHMe72Gl/ROv9vECDayag1Up+
         5vtDyHKUvlUOpb6xJPbLwaAmHt46emxCahhMJo92wL0527euGqnBrIYJ4ztYn55R6xm8
         +UV6jLAsg+KkKq7qJCb8oflB2cgvd31x2+Zv+CkQBrlEb0Y8yXKXMxDx5yXaYYhAm0pI
         W+ppq40X+wZVHylw506aToztTd1JEEFCyKp8AGQqqV2xcgCehs1nyYkumWUjeZ9MfXjO
         0i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681805135; x=1684397135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4N9kSZFUdqVn+fsWq+VvKAfZ+uj4xzdN3B+p6/q/UjQ=;
        b=E5fE6YBaJ1y0AClSj+1sUmt3aUuK1NEr1cbVG8UO6VTkEZOnWwIZkfx9vMYRyOQVyY
         nVkmWaumiH76mtnK6GfiIiCftFzL5Qx9ifp1RzUvTnWEl/R0B4mQmRwMQjej34r38rGX
         63JJzFDdK5qA18DeffqsuX1E8rW0mVnMTS3A1P69yHKpi4jl167tGRjq5Io5LNKcekG/
         uuVoEjRptMtmUZwq3P061qyRxdBwauQ1U3IBsEFIy+O3+v/5lhc5JI2WaOduLEOn4G3A
         i+JIps4BucBmFXfJ/tC2E5qDvxcijqgkxNjGErML6r0VlRwB5MswEvu0lqVwoPBVw1P+
         xS5Q==
X-Gm-Message-State: AAQBX9fa6cOPz2cGTUUB5gECmmvoB0EjLBlxx0brztkrzPlHfDOWJ1qL
        j+xN6/Dw4KYwYI/G5QrJZjHY2fmhx1XwoT6xEpcc7g==
X-Google-Smtp-Source: AKy350Z6UAe3ZYEUrfOoC7QxsajYdkEAU27+TgGnrkh3HWSw87/wciyaHKs4todI/C0TyAJp4wxLqQ==
X-Received: by 2002:a17:906:4bc5:b0:94f:24d:ef6f with SMTP id x5-20020a1709064bc500b0094f024def6fmr9967915ejv.52.1681805135480;
        Tue, 18 Apr 2023 01:05:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906ef0400b0094f969e877bsm1921497ejs.43.2023.04.18.01.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 01:05:35 -0700 (PDT)
Message-ID: <c332a4de-8bd9-a0e5-5da1-74bcce284f34@linaro.org>
Date:   Tue, 18 Apr 2023 10:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Add SoC
 chip ID
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20230418010019.1222431-1-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418010019.1222431-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 03:00, Nishanth Menon wrote:
> The system-controller node also contains the chip-id node that is used
> to identify the SoC specific properties. Add a pattern property to
> match to the same, and add to the example.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

