Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABF5FF43B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJNTpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiJNTpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:45:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8931382E9;
        Fri, 14 Oct 2022 12:45:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hh9so4335330qtb.13;
        Fri, 14 Oct 2022 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U555cJ7oEdcMNPdYOmtxquYWZkPSsvlm43vBiYFKjFY=;
        b=CdFCrSGnPb39F/CIvynt9LAkFxUyTv4a7VuY3XVngkJj9X1jjjNV08qKes2/58FZMp
         1GQn9IIfIj7BAJLqmzKqDsxrPsc2LzwOdiftR7Zd7YCfVJ694NlgI2C0AVag1XYfcBih
         Im58IfhTl0zNsHfcoa1BddM73lkdldug7xFxgrOpP9SoEgOCwT9uQ35cackwPL952K6X
         sYE9YCovERBHAZGgvFXdod0wjCtipAtB2lcgWgqW9hUU4kTMYvDIGysF/M+/oj/UrRBR
         gQNZDEt2/cbcnOrJwXNhKsE3pTLmMlw+G9t7PhGYE6oKUJoNXRG2zTdcy7Q1JmjcKNP6
         ZUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U555cJ7oEdcMNPdYOmtxquYWZkPSsvlm43vBiYFKjFY=;
        b=7BnNIksr1W/Pc5tetcnerfG7ZpnKZEnU161j1KVukMZNoBQPlLygD/mpAQy3ELeM8q
         W8114K5G/cbVdf5zNYa0pEopMXevs5+BKIcst4JTiUuImt5qjXt132b0ttOtz+gHlgdm
         64cgomyZsD7oTBsW5maPdUDuMIhx41TTmPEKXevQK9EwN1fhlN4F5xcPKm3EFafwrx3M
         9WSzU2FxNt4zt5y1T0ijMHu4I2WT+nvd5L1jdDqHUBLtiF8t7sJ5iwnRK7T1Nqw/fVaG
         pA9mXfg4rCcTaRwPi/x6tYTNNO6i4gFYv7kHlV0NujSCJ1slwihxYiukiXIpOjoYvPZF
         aHjg==
X-Gm-Message-State: ACrzQf2KgEqlLPvtpzfkgwEggdyY2rz55UpeJ1KaAUq5Ooe1EaH3NBjG
        sxu1uawiuTqVojQI+boADLo=
X-Google-Smtp-Source: AMsMyM5YwovOdmOixZxoCjVDQ3U5mtCE1JsPE8AHNwdOKu781m6RHftPl9Vq+OUrVZz+2BWZWmsacw==
X-Received: by 2002:a05:622a:83:b0:35d:44c1:e026 with SMTP id o3-20020a05622a008300b0035d44c1e026mr5718168qtw.298.1665776732330;
        Fri, 14 Oct 2022 12:45:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u3-20020a05620a454300b006eed094dcdasm1548628qkp.70.2022.10.14.12.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 12:45:31 -0700 (PDT)
Message-ID: <d8921e07-7444-33df-5d64-e5940f2665f8@gmail.com>
Date:   Fri, 14 Oct 2022 12:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/7] firmware: raspberrypi: Provide a helper to query a
 clock max rate
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Emma Anholt <emma@anholt.net>, Stephen Boyd <sboyd@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech>
 <20220815-rpi-fix-4k-60-v3-3-fc56729d11fe@cerno.tech>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220815-rpi-fix-4k-60-v3-3-fc56729d11fe@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 02:13, Maxime Ripard wrote:
> The firmware allows to query for its clocks the operating range of a
> given clock. We'll need this for some drivers (KMS, in particular) to
> infer the state of some configuration options, so let's create a
> function to do so.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
