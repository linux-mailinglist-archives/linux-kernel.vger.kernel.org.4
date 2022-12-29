Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A721658DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiL2Oat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2Oap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:30:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6F1F65
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:30:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id y25so27724248lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LYwz1qn2s4qGACWQSbmDxApuR34DufDaU+RI2+KuWw=;
        b=mj43JvvnNhnzPQWDcjUsze/7KP4my9MvlGNV/5XAq+lZG0jQoEUNa1pA7JHE887LQ6
         pf/cjAsrruHdJmb8PF429FMp9YVt4537mCMyhs49NjPU5Y3oeOFCNqusuaNe9JK7Di/9
         iVawCvmIfcTO1jVIzf2bP5ivo5+UqfbXroiuRi8jDlFBNLLQ+N0egPquQWpTKOxhfmUW
         35quWEA1YohxXpwL8MfLWflaFu2jH2cOGgkzwIikOUf8ZXsG+Hs6+6qbIeGtX15DHB+D
         DdRbFArJjxEiee6VKt3F8Chjjs2t1OBRMnE5g/3OCDsAvdesjJm4r8nw+bQB2JSf2Amf
         FZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LYwz1qn2s4qGACWQSbmDxApuR34DufDaU+RI2+KuWw=;
        b=1CNjEsCCQ24/oXM6e9i4Xw07S0poGLAUxxpO+rM4+3ObYu8iKb9gghGiFpQARZV1i0
         nk7YgQTt4WNUPsA+Vzd+mPKXgsCGxIrSgCTEkYa1IFj2aHNAZzPbf4ku6leLa5PT2Mpy
         SC8CiIk7wNBG5rb5A1Stlr8zAOlCQOgOXXHFsOYdM390BY2s9vPHXaGPjB2hGSej/Ajx
         h+++wyPeF7ryDLw2M4TBE7wYpv9UAs+tgik5c0B9ui4h6bsguIuEMmunlWHNYFqMs8Su
         2Hnf0v80imcOeoyY9yLJA3h30RGc837rp3kJ67ZAaFGXrj7F/y81M0BK6ormY+cvpDZZ
         xOHQ==
X-Gm-Message-State: AFqh2kq5MFYq7c7pr/iO5KjjFTUOk0LMQ6zy+HygA+e7iWtRsQYubzzH
        vgdVHDnOiH6MTtepQFFoZnRrtg==
X-Google-Smtp-Source: AMrXdXu2zPB5WYahfzU5Fq/+bVmDyKwKnc/QAR56Pj2pBAq5GrS/LujfLws576bX6jz3LMymtbLfAQ==
X-Received: by 2002:ac2:430c:0:b0:4cb:10ad:76bd with SMTP id l12-20020ac2430c000000b004cb10ad76bdmr2438382lfh.64.1672324242748;
        Thu, 29 Dec 2022 06:30:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d16-20020a193850000000b004cb14fa604csm844364lfj.262.2022.12.29.06.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 06:30:42 -0800 (PST)
Message-ID: <8e4ec6b0-63cf-c086-c00e-5b4e8a2b2d25@linaro.org>
Date:   Thu, 29 Dec 2022 15:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] dt-bindings: net: marvell,orion-mdio: Fix examples
Content-Language: en-US
To:     =?UTF-8?Q?Micha=c5=82_Grzelak?= <mig@semihalf.com>,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        chris.packham@alliedtelesis.co.nz, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, upstream@semihalf.com, mw@semihalf.com,
        mchl.grzlk@gmail.com
References: <20221229142219.93427-1-mig@semihalf.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229142219.93427-1-mig@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 15:22, Michał Grzelak wrote:
> As stated in marvell-orion-mdio.txt deleted in commit 0781434af811f
> ("dt-bindings: net: orion-mdio: Convert to JSON schema") if
> 'interrupts' property is present, width of 'reg' should be 0x84.
> Otherwise, width of 'reg' should be 0x4. Fix 'examples:' and add
> constraints checking whether 'interrupts' property is present
> and validate it against fixed values in reg.
> 
> Signed-off-by: Michał Grzelak <mig@semihalf.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

