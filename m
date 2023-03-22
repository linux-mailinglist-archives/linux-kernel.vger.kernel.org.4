Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEF6C52B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCVRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCVRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:40:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DE124C88;
        Wed, 22 Mar 2023 10:40:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id cu12so6373741pfb.13;
        Wed, 22 Mar 2023 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679506821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/g1h+qqzGP0ximTM8vLifW2flklbu34LUXD3lH6yA9E=;
        b=BAsQNSnbUVjbeyI7cQSPAqV/ee8QmZK/d/w1GXqaKDEv58eWDxDc2pEoQr1zfkHBum
         4kMFFkxM1hFdV4qG/0Q75+GiUqFd0vw3tNN91hjfJP/d1B5ZZ9CfbFYr3xmfptwibG9p
         ssT0bt1KQo6IZIA9ine3Uz8zuFt9+Zsb4Ku0zdSL4mFD66HxGqJMwAI7DDaPg+3EX8Gw
         qa/ZxuTUAG+qeUKCgz73ueAFnXFoZeAEey4glrjatkWIDCThJ99nMMxUKhNF0k8zHh0O
         o9wYy0BjT8dzikZKtgGR10UsaO0QfrYqTo83+dcKv3NiE8aI7xl37AD3mqHsU7KbdE2Z
         At2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g1h+qqzGP0ximTM8vLifW2flklbu34LUXD3lH6yA9E=;
        b=nu1NAixfKFKyHGdPTGLp7FEHaDBZdP+Eikng5gpJm4V6Oq3EOoywlZuHrAq3jYNjjh
         ryGgiPHCQOsKOu5V7mdFDEu87JZ1pCTa+i5kW6rNwNJfRCiefAd6eZYRv5nKNfW9TYe7
         kSGtR0/o6/EiON8niZ7oqvfID78dZrkHRr69fg0DpzInIdo12s+B2i0i+49NMYCgF30Z
         8OBLwST85zDEjvum0GxUm6qHjJPmyTw4T2lMWBKup8Fxdx3rXM9HQuXD9n57vusSHFpV
         Pph3BP73Ot13AJkyEyHVgkoYikHfA61ILpACnQT+rRMQJWq37XIREjE1m6z4Ssh+L1M4
         mJRQ==
X-Gm-Message-State: AO0yUKUdPCwuPdLreAraqIyOQzl7nDCx7R1Pib92Wbdcwg1SP5Nrygpv
        Xx0SyXOxU64oRfNimSoHIWc=
X-Google-Smtp-Source: AK7set+kNSqLUYN+luuoe+CONYSfbZhP0I9LswkqRYf0oELysG/zkCAFYpjlXjs8Gs6TsQBPHgh00A==
X-Received: by 2002:a62:7b05:0:b0:625:c7ca:d82f with SMTP id w5-20020a627b05000000b00625c7cad82fmr3785420pfc.18.1679506820823;
        Wed, 22 Mar 2023 10:40:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b1-20020a6567c1000000b005023496e339sm10118407pgs.63.2023.03.22.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 10:40:20 -0700 (PDT)
Message-ID: <586ef13d-4ec8-c5e3-25a9-8c5eb350faa7@gmail.com>
Date:   Wed, 22 Mar 2023 10:40:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: reset: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Qin Jian <qinjian@cqplus1.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230322173508.3971182-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230322173508.3971182-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 10:35, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/reset/amlogic,meson-axg-audio-arb.yaml         | 4 ++--
>   .../devicetree/bindings/reset/amlogic,meson-reset.yaml      | 4 ++--
>   .../devicetree/bindings/reset/bitmain,bm1880-reset.yaml     | 4 ++--
>   .../devicetree/bindings/reset/brcm,bcm6345-reset.yaml       | 4 ++--
>   .../devicetree/bindings/reset/brcm,brcmstb-reset.yaml       | 4 ++--

Acked-by: Florian Fainelli <f.fainelli@gmail.com> # Broadcom
-- 
Florian

