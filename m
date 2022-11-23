Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7AE635224
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiKWISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiKWISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:18:39 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FDF72C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:18:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u2so20561869ljl.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q69gDnyivpymFGK0Sd4Z0oFYEil0+SQlh0vDf2ji4M=;
        b=XtMrpoWyvn3cnzL27g22jgXDVQ04ezHV5Jv6xIZYgEY/2N9Hsw9aXIPZbUtLkiqLRj
         UU6tSufpFQsR+FZiAQKrVH8qGyOg8UuGWz0MPKjRGz6HuzgvVoc+txyBkscWSh+DG6S7
         KP1wiUjOxcgj6ud9wpEF/ekxThrIiLyJZ8gLhWGSFdDE0kPDT6Nlcp/bJwWjDxrNwxQR
         YmrizrHQR+hNOa82phbI1MXa5PTx90gqoArGByVIvXEb4PuMHKed8hKtGVzRNAa0H3um
         v3KeIT070EcWVACvPooH8KEF468Wn5sO8WnoroLm1B29uEF7gWYWJyI3QL4XJZK99O0G
         e0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q69gDnyivpymFGK0Sd4Z0oFYEil0+SQlh0vDf2ji4M=;
        b=PddRlR7zbmARCI0BWXkUqcWYU2d08p8XhoDUtJ2MxnSHrX5acvIh8bdyYCp1xMULHT
         drlVzDUcC8Lsg0xGrK72n49naztJ+7nCPGyjOlDkb7v/6I9x8vvy/6UwzXCed+SnIxJk
         BQQe5uqdXIBt/IIhwSFCnFcBHBDrAJ5lRnBF7w+WjoAd6fhQkt9SUPRm6ID2k2Fp8B03
         SmptY2JKilPsolLBOknOXLaDgR0qx4FKUOj0WKOkVcRKG9isrM4pxeNkZGVoBqi2fIIx
         jrjtLSvtafzc5DHzYTXC9N5W/F9oMwqvmU9FxSgIlcAcevYX4A17LI34sI3I/elxBNa6
         u/gA==
X-Gm-Message-State: ANoB5pk2eYB/HZIBdNfCNnXW9IniDsWEHdIsHv0rQx8jCSxNncyKWW+3
        H1h+E3S+/Fs03hTeGfTImZYWnA==
X-Google-Smtp-Source: AA0mqf4Cv6SWGcVth3Vs6EVyMwqJvulw8RX9FsThcyK0W0bvw/KrzybZNWjmXpwJ855YvfP9H0sPwQ==
X-Received: by 2002:a2e:824e:0:b0:26f:be8e:5298 with SMTP id j14-20020a2e824e000000b0026fbe8e5298mr4042117ljh.418.1669191511108;
        Wed, 23 Nov 2022 00:18:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512202600b0047f7722b73csm2784810lfs.142.2022.11.23.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:18:30 -0800 (PST)
Message-ID: <3e7d045d-7416-d26f-1578-be83a82cc124@linaro.org>
Date:   Wed, 23 Nov 2022 09:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] dt-bindings: pinctrl: st,stm32: Deprecate
 pins-are-numbered
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        khilman@baylibre.com
References: <20221122010753.3126828-1-bero@baylibre.com>
 <20221122010753.3126828-5-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122010753.3126828-5-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 02:07, Bernhard Rosenkränzer wrote:
> Deprecate the pins-are-numbered property
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

