Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A161747D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGEGdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGEGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:33:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964710CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:33:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992ca792065so665549966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688538781; x=1691130781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lCoKmln4WuI/lt9cbFISAsB5RRGuEG6xwKWMEIrA/0=;
        b=GSTPFRMIiregd8994uXCU/ps7YmgrfBQlkeGkTe5dmR/tL0uslA5HRNx5u0en7yNtx
         7EBjtv04Yucp+bEQoICW/zO6J7JuBuU0mrAo3SCgWkX9SMoQ7cUPREaHTRsPPLhXASsK
         ue2U54t5spFp8lQ7ODW5K9dPXIF2/2i31ZkEvLtOso2fpm/C99SuC4DrS2eDn0SfB4Tl
         nJVUqhJ9MocMsdvsqHINLqARTKkfJ8LuHY0Zn+KnjmJtIh591UAxeRrGj/3cvVM3vK2Y
         mpatdrd6/51+X74OwKYSKuj60qduSpeMuhu+2zWVpqYZdcE+M/0uqcbgSwcgS/H+KB1o
         cJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688538781; x=1691130781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lCoKmln4WuI/lt9cbFISAsB5RRGuEG6xwKWMEIrA/0=;
        b=Tz0JQtR+TiR+24KSZTR3oXzu41BSDl8vvrWU7CtvtzCAFNEcP4RyAotEPqEYeZ3BrE
         e5VNa3AgRJ24lV1yhVikB6FCz2qqh+C21YoJekx1nAd1/ZuvWNsslAvacmP/E5Rjfh+d
         IleAgZFTDNH91AarL/j3wVicpoHkSox9ss7K2XiLhcmAiDNiqSKkUZcYkMIUvs6qR+bD
         I6ryEBhCaE2WgUPwhdahG9I1pu+NoKPoVPw+bs6TZ7tyDVmvTYJHsKtYlatTTl4ti8FL
         TXtvSLhSIeXUWQfPpV8Xstj9GTcmUwIODAC1M93gM609q4ZzHMypqeXEHvBSDLi67gJc
         TiwA==
X-Gm-Message-State: ABy/qLZTUbBzXqRvB8SU7C7qY8ABGoskcvO/0bcXUROUUulXLTWpx2Yi
        7ph7ercC1/oZMVYsYl0TUKzohg==
X-Google-Smtp-Source: APBJJlGsadBiPVigTMaE5rljF1uJJTj29+Kym1A+vLFCCYI2BUjNKUKvCrCTBWCD+rZ+TVw+Lxn7WQ==
X-Received: by 2002:a17:906:b7c7:b0:98c:df38:517b with SMTP id fy7-20020a170906b7c700b0098cdf38517bmr11027580ejb.33.1688538780832;
        Tue, 04 Jul 2023 23:33:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709065a9000b0098884f86e41sm14056844ejq.123.2023.07.04.23.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:33:00 -0700 (PDT)
Message-ID: <4adb975e-bbd0-9a53-372a-404ec857a632@linaro.org>
Date:   Wed, 5 Jul 2023 08:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Read max-brightness from
 devicetree
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     kernel@axis.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230703130313.548519-1-astrid.rost@axis.com>
 <20230703130313.548519-2-astrid.rost@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703130313.548519-2-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 15:03, Astrid Rost wrote:
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.
> Note that this flag is mainly used for PWM-LEDs, where it is not possible
> to map brightness to current. Drivers for other controllers should use
> led-max-microamp.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

