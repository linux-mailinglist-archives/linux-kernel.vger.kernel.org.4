Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5B63A358
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiK1IpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiK1IpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:45:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8E11C12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:45:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d6so16235822lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nenci7t4rhCZdpWVoRxbMnQAdlppXCobPbi7wEBQtJY=;
        b=THlpyONNZdQgCWbS1nPUbGlrjy7aLrSQSgr5nxOn94srvrNVV1E9iiBaMWwkdvVPjP
         wfeIT1KR0qdEGzKORsWz4uV/skULyk14PVaH99PblmmW1b2+M7SxwGLl2+FgwvR3XQpw
         Mb6MjJ7rIGPkwbo1ZL99Ah6MJhMFe4qNtEEMkVeWdorV5JFgVIi4Qbqomo7VH5eWWCoi
         tx32qaw0sjUH4cQJuxavrKpOP+Imm4rpTaFAR7YZzqUQBHp5pnZUwwfSjrcSGLBobBdU
         KbWQdBQh+XpT4OItk5xOlklNH17Ln+GSrmxYO4JgOTdkxHz/4pA6MLrr1RVaIO3eL0GY
         sAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nenci7t4rhCZdpWVoRxbMnQAdlppXCobPbi7wEBQtJY=;
        b=J8m6X8YFRUGwIpVZcdCyg7D1/LjDxjsuhGFO1Du1uQapJwB1QgUgFSO4zowvxPh7hI
         hChdpSYh07saWmsJcmLh9KvkgzaQFhfK5d7v/ioh8jnzQuxW49xBYvo8MIjF6gS2VJNy
         EdjuHQbUrn3xHHgYBeAI61/n/4XK6wTBG6tb1TVdKOIhEglUbSOJspxRuXx8ZuO5s9LH
         VG8FN0xml6ZcI/oOHixitJhS5Kd57MnfEP+wqWaXEyMrANhM3WMF6Wf+ay3vZdO1dE+q
         VEl5z8sJ6Q29/sFwCqCGdEYh30u3NPFdqOZ9RhboV1srUlPiPNZHD7jEceqQNKHFIwLq
         HMTg==
X-Gm-Message-State: ANoB5plDygiETrBWoa9r2VsguyGK0V9yVRiM50uGHFxmosXxCeMvGvC2
        JxYUmU+CpYTIUyQIz+KN2FYN+Q==
X-Google-Smtp-Source: AA0mqf5n4p6pcFE0b6JaosOzLcEa0TroXRfYPjChVw+bV7Typ63sv24F7H3QKzd6B6431QojswjUFw==
X-Received: by 2002:ac2:4bd0:0:b0:4af:ad36:7a85 with SMTP id o16-20020ac24bd0000000b004afad367a85mr16358692lfq.617.1669625098004;
        Mon, 28 Nov 2022 00:44:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c35c4720esm1158464ljb.24.2022.11.28.00.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:44:57 -0800 (PST)
Message-ID: <26577515-0681-60be-17ff-dbceb7b9a083@linaro.org>
Date:   Mon, 28 Nov 2022 09:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/6] dt-bindings: vendor-prefixes: add Genesys Logic
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221127073140.2093897-1-uwu@icenowy.me>
 <20221127073140.2093897-2-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127073140.2093897-2-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 08:31, Icenowy Zheng wrote:
> Genesys Logic, Inc. is a manufacturer for interface chips, especially
> USB hubs.
> 
> https://www.genesyslogic.com.tw/


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

