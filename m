Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB0C6E8242
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDST7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDST7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:59:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A835FCF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:59:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dx24so1087437ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681934339; x=1684526339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVpt9sYJTPat9HTzksp4fUGvUNXr5TZYMpJLvWLAs48=;
        b=UCchYZWwyaAxmNQRMnL0/yxZ4z+iMuPi6CvIcH8er9PdAg/MY/Ta2EGvOtwShkRx0u
         ztigkRUqYt+pSm06PJzEss29M8wUYvermAmsruFrJR3QGp2rUxKC4iMwpk2BRKRSTzDo
         KgR2FXxx0uCJJbLH7jOtSfF/h9w6koKEP0m5Yvo34dHQhULhwcTech/NZ+vTt8TpfWV7
         DRoegta9ydAvXEMUGfwMARk2bzcrhYDY88NlQWxxk0Sl1S/lunNKjarvgWJNVz5IaQ3J
         AdfvwkqqMV0/fL0UMdfOKZXyHI3kyE/9krrzlUzuzJPKO2CPmQVvoX0zI0UywoT/JGlO
         Am0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934339; x=1684526339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVpt9sYJTPat9HTzksp4fUGvUNXr5TZYMpJLvWLAs48=;
        b=N21xG0cxcM7CrXPfDJ7AGlaTwQsIP5RUMoFHsRFNkeRJgc2LV4vc0xK0miw2aaK0+y
         HbNZxJFARrv56Tc/STdBpED718G40JSbCQ0qzhGT+MpxjLsDJrJ95ZHcaawvcz3ZH77W
         YmoUxcRuOImTDqpys+FWjEVMjyCxpEn12sSdOfNtdz8HoyrQohb5aEkrR5rWRaH/M+7I
         0x9MvmfHyGidfrZ/J9ylx4Ti2TB3U7Gnq8Wz+kGfXgq9RXvHGmX685DNhqjwdyvMmEjE
         4Bim2l2TJzJ1d9/APPHv/BHNm5lI+O3F9E/eDsLJDs5299AwPY8FlxLwZJ1WqO+zODcQ
         9otw==
X-Gm-Message-State: AAQBX9ch+q/lkewDjW0KMw8P1mLTk9Di13g92ttUuziatMG5PsPHPIQk
        vuoO0NrGY9SPO8HxEs6wJBeR2Q==
X-Google-Smtp-Source: AKy350YIYDJYSouUVSRt5Wq71UJfzT4ew+7n169i9LaxUWTLVoQm33LkHdjA2Il2yYY1OBlwS6F3NQ==
X-Received: by 2002:a17:907:8d13:b0:953:7d80:c40e with SMTP id tc19-20020a1709078d1300b009537d80c40emr600186ejc.0.1681934338819;
        Wed, 19 Apr 2023 12:58:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:976c:1d6c:6ed0:8935? ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id rk1-20020a170907214100b0094f0a56e33esm7130721ejb.47.2023.04.19.12.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 12:58:58 -0700 (PDT)
Message-ID: <9d233482-b2e1-3fc6-0806-1d777779f104@linaro.org>
Date:   Wed, 19 Apr 2023 21:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] arm64: dts: meson-gxl: add support for Xiaomi Mi
 box 3
Content-Language: en-US
To:     Karl Chan <exkcmailist@inbox.lv>, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Karl Chan <exxxxkc@getgoogleoff.me>
References: <20230418145515.19547-1-exkcmailist@inbox.lv>
 <20230418145515.19547-3-exkcmailist@inbox.lv>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418145515.19547-3-exkcmailist@inbox.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 16:55, Karl Chan wrote:
> From: "Karl Chan"  <exkcmailist@inbox.lv>
> 
> The Xiaomi Mi box 3 is a TV box based on the Amlogic S905X chipset.
> There are two variants:
> - 2 GiB/8GIB
> - 1 GiB/4GIB
> 
> Both variants come with:
> - 802.11a/b/g/n/ac wifi (BCM4345)
> - HDMI , AV (CVBS) and S/PDIF optical output
> - 1x USB (utilizing both USB ports provided by the SoC)
> 
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>

Still broken chain.

Also, drop stray blank lines from end of files.

Best regards,
Krzysztof

