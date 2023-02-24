Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6C6A17EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBXI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:26:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19315179
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:26:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r7so12897402wrz.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20HSJ4cZiz1ZFE5KUxXCoL1/F63Z40FI6i46iunMviM=;
        b=NTqbSe62Go6viyiO4ZwzUupAPiCjLsExc9KZXKxsqqfjtDrrf6zadY1feivikLSuSm
         xdsU6hkB0q4Wwj76G4hU5XbsIHZASz98ukFuWjPit+GV4tVoNsfKKssx5MQhDn108HMB
         1sDeS5XyDpuAeNrYPCA5GBOIvYzBLuorNjejhJo6iOXoikwWQWWqXbKF0ub0MT4oYIu5
         U4lBkXJgZs8f/65SC4mylOQIsi/Zuh6Wz8PD7CmaPjk8QNlcP/0ulrgefkqPkrehVwxc
         MsGwz9+DztmmJPgiFz/JE6jenjifR1Ih3HgveTC4NmmrJ3eVpg3tDGJVmrwDqyspyuop
         cbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20HSJ4cZiz1ZFE5KUxXCoL1/F63Z40FI6i46iunMviM=;
        b=Sl0xLTNWXFGfsOMQOY8JMZ/WSeWrWB89t1XP4U0XofaS407fKUKn9OMxkYvpxO3+uw
         nCeId/1Zwl/PeWBZ6h/EBPHUlUiYr8klBHJUhnwLMBra9TMFLApALXEktbRAg/lcLc/D
         qObj6Souj5FA5H1w3Xs3IiHjZKSlRpivmSxzF/97fvmZ/4TkRA6yk9qsqzAoBW782atU
         AI2kl5efLrEeKC/1dYJsL/eMsJJk3/KgdIjL0yc5N0J+hoTTvgLpL/YZtN/uGbEUic1h
         6Hpg58UK/i2YR6t2eSowLwXETjhtB1yWy5pm9t/i9RFRKleWF83FXPSQPh492u0FPA+U
         SekA==
X-Gm-Message-State: AO0yUKWcDM4zFbWNpuRLfAfK5W5oZYM7ePEeEehLjHBn7+50KLtlD8Eb
        QosOywLGeoq8gBPG/hViHdySMP4nr9+/2mnJ
X-Google-Smtp-Source: AK7set9rHT6bdvWZ9cPUv6MiyXkEMic0nOwTw04SmYHBplCQQmMCTlSsZFClsEGBFOxYyzlXefcX8w==
X-Received: by 2002:adf:ce0b:0:b0:2c6:e827:21c1 with SMTP id p11-20020adfce0b000000b002c6e82721c1mr11334525wrn.50.1677227209333;
        Fri, 24 Feb 2023 00:26:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4111000000b002c558869934sm3438615wrp.81.2023.02.24.00.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 00:26:48 -0800 (PST)
Message-ID: <29db87ce-94b4-7106-aae6-a122c979d5d6@linaro.org>
Date:   Fri, 24 Feb 2023 09:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 RFC 1/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for G12A
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>
References: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
 <20230222210425.626474-2-martin.blumenstingl@googlemail.com>
 <319cb654-51f6-6241-802b-22ee0d5b0aab@linaro.org>
 <CAFBinCCzXb2Ty3TaZatEKQyxJmYPhHDL7SeLfF5-3PsDKBznWw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFBinCCzXb2Ty3TaZatEKQyxJmYPhHDL7SeLfF5-3PsDKBznWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 21:14, Martin Blumenstingl wrote:
> 
>> The question is whether the devices can be made compatible thus keeping
>> DTS working on older kernel. This commit suggests they are. Your DTS
>> commit is written in different tone - something was broken and is being
>> fixed.
> If we keep "amlogic,meson-gx-uart" as fallback compatible string then
> old kernels (or other .dtb consumers - like u-boot) would still work.
> Without the new "amlogic,meson-g12a-uart" compatible string we're
> unable to make use of a newly added clock divider within the UART IP
> block which allows baud rates such as 1500000 to work without (a lot
> of) jitter. Old kernels - with the new .dtb - would still be able to
> use serial (thanks to the "amlogic,meson-gx-uart" fallback compatible
> string) albeit with limited divider support (so not all baud rates can
> be used).
> Is this a valid plan?

Yes.

Best regards,
Krzysztof

