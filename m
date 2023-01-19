Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AD67358E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjASKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:33:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13595EF8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:32:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so1364104wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9k2ZCvXwJCt6LMPn3Qm6skL5MW78g6QFwWzJJkZLtZk=;
        b=RmhHiXoeA97MjfWH1RB8qm6wclb9aooX22GME4ePw6MMjpZhZBdNhBXAc5XZL5sBL0
         6EgZ4av2GKr+mk2Yrr1MavRpsn9P5hcxax0a7S6c5fd0O0o34YJG8T9anZ35qGB/OmU4
         7V0yp/nvMcuFhHF8QysdjUpxtUil5tlGd1FRmMWc2kLw+Ydeyswp3hbvFtkinNrQdeoF
         9eJHN9FRRh4EtiCLfXbKFh90V3HEuTkKi+vaFqoOjHtHXvqoW2CWDAuogQ6z+9C40SkT
         cjhQc3o5fQ+BlqyrOTZJ+YdafDiwRkxkjchN+hWTBkyaxJC5GmxrQzIfhzMhbUnJHSKb
         UCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2ZCvXwJCt6LMPn3Qm6skL5MW78g6QFwWzJJkZLtZk=;
        b=oj+htaYlUKrvY/ZrRu1/6VpyTvf/Nd2M9rYGn3paPqoX6KPmXXgtf0vH4JK5kmFP84
         HRXK+m51GLL3WJzNzada/F9bKeSdnNLFrnt2752YJsplHNA58QUN0nijKYB3NFzlBTJj
         oazJ3xqxMOWw5N3pEv80uwZyaB0RurBkFjQEqo2qneIZ2CA+puC21ThJtlsw5TtSi5nv
         xBaJruiIZyEfmQ8blr6vqjxki+KlCCv8AAzYHsUnGj5QowGzhw+e0DU+KbrEKBNVOlKT
         nOedEsRK5HXDqARGfdRTZaDm5taRYv5BfhObJL6oiqLOv3RW/p72UOC2xrIHhLqeHJNd
         9Dhg==
X-Gm-Message-State: AFqh2kph50H4GzvecmSgQ2ynu70Nj9mwmSZ+u4XAaw5U6P0TYooVBR5s
        YwMwjpuWmzTaqKgoPyqehrvGFQ==
X-Google-Smtp-Source: AMrXdXuYd2TH1VffEdv9EbMiawuBaGDqOQv4dyU1JIm4zVGy84yqlClhcPpAsfLs75moxtlYA6unqw==
X-Received: by 2002:a5d:6f15:0:b0:2bd:fdd8:2d0a with SMTP id ay21-20020a5d6f15000000b002bdfdd82d0amr10699155wrb.40.1674124372952;
        Thu, 19 Jan 2023 02:32:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm12541420wrb.13.2023.01.19.02.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:32:52 -0800 (PST)
Message-ID: <038c7f64-c003-08e2-0489-3a78411bee31@linaro.org>
Date:   Thu, 19 Jan 2023 11:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RESEND PATCH v1 2/2] dt-bindings: imx8ulp: clock: no spaces
 before tabs
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230119085421.102804-1-marcel@ziswiler.com>
 <20230119085421.102804-3-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119085421.102804-3-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 09:54, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following warnings:
> 
> include/dt-bindings/clock/imx8ulp-clock.h:204: warning: please, no space
>  before tabs
> include/dt-bindings/clock/imx8ulp-clock.h:215: warning: please, no space
>  before tabs
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

