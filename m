Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE85B6FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiIMOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiIMOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:14:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86961710
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:10:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so9580222wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Te8k9s87unrEgkHcqd5vPRmIiJKPic6o0P3DO6oru9I=;
        b=QoJLC3BR8wDCo0dQ4CZeGh+M7CkQEibwhsg+xXmtc17UNjkMc3FijrZZ8W+wCgcV+w
         ySkg74u3AxilkIEmjGc0Xx2e962mqazZ6/UQrt9W4by/BzG0qwzstX9ZKjqqCjfB2nG6
         xKtWNmPImF3XS5vF751fxviMKRoxE35J5eE7uVUQlNpnYARhoVqIn47L1yCG7phXHSWN
         orojVXRqGtTSJ0dbiWgPf25SzujNYA3IwAgLUlt6ZjrlDUGbYLeC6ofk8L02Q8oPymWU
         8A9ZrAiZdpk1mpxk5OEz39GpXFHlf3DJQ1VhQPXhATxU/S3gCOC8fPyDC0BcYjGZUGhs
         FOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Te8k9s87unrEgkHcqd5vPRmIiJKPic6o0P3DO6oru9I=;
        b=AZ1mFSQjagTmNlbtzHD5mhBNp1qydacQJQdmpnosnp4+OCy3Fvhjm/cHVY1MK6H6WI
         isC4rDp1Kbs61nscxH/6zFu3hy6o+uqlJWoW21W1a78exIFLuPPFjJNp7qYP71pIGtZQ
         MXmWFVdztwHE510GUrm3wEbist/1o6tC/rjPMGM5UqGgWdpbfd8YD31xWtAouLNsr46h
         k0rWvULdSWvexBHcNAbOqOMZOuHuZGF7QTp6V3QhgmrEbXdrFWxIs5o4tfWui8/aMkOd
         50k/+CgCSkzdUeUFgUNup4S6AVwgHC8pDPZfSEh7h+SKrmr9ome6kmquaRHOlXxIk2aE
         7eaw==
X-Gm-Message-State: ACgBeo0A1/rWe9eMOcI0cU0Cj2YzEwdsP93aOwWgkK+RhWmHK73hUaVT
        MeCSwNk/cCfpfHAv4zglr59LhQ==
X-Google-Smtp-Source: AA6agR7fg9Yc5sCrG6pv+2JK5BauOdoRWdSdVeWZ38mpN9v3VOy/zNf3eVr4hucIAuIPexefzL+VVQ==
X-Received: by 2002:a05:600c:4a9a:b0:3b4:78ab:bae5 with SMTP id b26-20020a05600c4a9a00b003b478abbae5mr2681954wmp.114.1663078246057;
        Tue, 13 Sep 2022 07:10:46 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm13050983wrq.81.2022.09.13.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:10:45 -0700 (PDT)
Message-ID: <6ab84de3-acbd-066f-1e19-4be556d3f4d9@linaro.org>
Date:   Tue, 13 Sep 2022 16:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] gpio: pca953x: Introduce support for nxp,pcal6408
Content-Language: en-US
To:     Nate Drude <nate.d@variscite.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com
References: <20220912171347.4167372-1-nate.d@variscite.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220912171347.4167372-1-nate.d@variscite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 19:13, Nate Drude wrote:
> Signed-off-by: Nate Drude <nate.d@variscite.com>

Missing commit msg.

> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +

Split bindings to separate patch.



Best regards,
Krzysztof
