Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF65616EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiKBU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiKBU1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FA7626A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:27:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x15so39198qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIjZ3J5xeVmLQdMnQeTKwtayA5JvoM/NM+r28ILFbQY=;
        b=cT3WOuv1N7Fg7sUjGZiektBObj9jIfXtE32VruazBwa1XlhePndHEuElchYVsjxWSl
         /4SrL06jo94LkKT2PEufLp1cPjRsKm75vaQrxnfw1tdU2l0mb3FD/7NQMRYtwh0y6IUV
         ZVefYLHMJY0lIF1/ROfoltdOpkOn7pvmH0tgX0gKGE0U5XM0UETjJLW9FGuYyAbc9/UJ
         vTGpCHV9hxN6HlbIkSeiWW2GvARcAGp87/kV16VzNONkw2o7xZoPUQyfp0of4ae7hiPv
         fO+x0+n/KPzXGuuByZFNgBD9P0u1tF74gXcjzuG7ZRxbWsGu2DLQ7K63rjL0sAeyXo7F
         0K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIjZ3J5xeVmLQdMnQeTKwtayA5JvoM/NM+r28ILFbQY=;
        b=YhZHs03X0jj+Kiw3Wxzyf6jxRA6vWFgd4f6FhMoJ/DyzfStBlIXHyCQg6ubLqFqelK
         yJv8I9diy8qgAdmvMseNicY7WkPXVe6EgkKF8VTWUWUJOi1tSHN4Wa+Gcm3Ye4NnSTCs
         4fS6fvIdGyyhESV5TC8EBqJRXQUSvTiwEx0tFFQpdpLKbTpMLHdwIDXaN+e0wKldxIFR
         YV1CCctvcnd/PqjaQYSlL/t9JwKvDK2OdTKH2vJZYOyYUCav9CLVyZPkf4KFWa2Rd9St
         824USQyfxbPmqzmus1i3Ngs554synOXenroMzMSHwBn/rYYXI58+3LigsRxxRc1ypyiw
         OUWg==
X-Gm-Message-State: ACrzQf1CLmqqRJHXqrEy0Bi2yuPyLVRn5l/vbWQ0a3uS71/98E4dGCb9
        LnkbxRRKURYbVqgkMUaqNwewPQ==
X-Google-Smtp-Source: AMsMyM4ejC+/+6SPW/EzVJ7N+md7hUx/4px+irzyPLqe0sisRbKp24Rwa1stBfwznuy1fR5Am+3GXA==
X-Received: by 2002:ac8:5d8d:0:b0:3a4:e2af:8cd4 with SMTP id d13-20020ac85d8d000000b003a4e2af8cd4mr22185922qtx.385.1667420838319;
        Wed, 02 Nov 2022 13:27:18 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006ed138e89f2sm9195468qkb.123.2022.11.02.13.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:27:18 -0700 (PDT)
Message-ID: <fbd52c74-4b25-79b0-07f9-e58d96002ac4@linaro.org>
Date:   Wed, 2 Nov 2022 16:27:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221102085737.599100-1-Naresh.Solanki@9elements.com>
 <20221102085737.599100-2-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102085737.599100-2-Naresh.Solanki@9elements.com>
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

On 02/11/2022 04:57, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/mfd/max5970.yaml      | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
> 

It seems I reviewed v4. Apply my comments from that one.

Best regards,
Krzysztof

