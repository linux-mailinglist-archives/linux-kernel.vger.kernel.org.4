Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39666CF92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjAPTdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjAPTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:33:05 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D35227BD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:33:04 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id cf18so63964447ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ug3TuHPkO+KIpG8JXNG5RG+m82gr69xH0lG8Jt6Gbo8=;
        b=jOxclq+nQL67Hm+oetmxpr0VG1kI2kkIjW8rCej+YkPrt3XwoudPg3Ai3WmT68NnpM
         Pzu6OP2/ivBELEOYlHSR6VeX2XbGTH7nnaXhCmH9ReRb/SA3Q9U1XP12Ekjh0gvxgknR
         6jP8cRKMewEiu5ymSNCYUbtbBApBIeCtgwgArDG/JiMSsmI14JY8cKHEqyDVGBC1uGDL
         L4VJm9FTYoqZwvnyQb22vMfGR4cRCHLIu8kQLZPnXcbPMZnAbX1Y5iESU1xR7ijpsxAh
         fbpFyU4UBThe5QXg7nQIyL0CiMqoAv1px5uTCpCivLwBMFfzYdO8wOGAn1BHdwAoW8Xh
         bGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3TuHPkO+KIpG8JXNG5RG+m82gr69xH0lG8Jt6Gbo8=;
        b=b926InZ6TdjjtqGKxajHnZEyz5b1v0oMx3/IKYketu48MWJwOWMRa5WJzJaNoqLg1i
         guQTzQu8rNROPi6gbilkGC9AEi0y0aobaEZnhwZq+1sVufHAWZqf1DaegvZ4dZ/7TimZ
         Tt9vcT+dCd2VcuFMTiZfu0hv1nIWn2gkGssNrblLQYT6HKFmq6iypTbZGjPZUWPhdV4v
         4aQWUjY5hkYpiQJUL37+r1A1K3Uzf/e6VOOdEXWuHkqQNvmBDebXCeXARGHLzJhkI7YP
         R3ViwWFfYTMInxe6JAoNTk8sbDuZ5DJSNjB/w0Xl4wwmE6tWzmEhl3qmcDB8yqt8e8r2
         vlTg==
X-Gm-Message-State: AFqh2krcfAT+Y0YGLdhOkjGAO45A7Otvr61PC47OYFuskxIBmkreqYk2
        PSpPcVXHhQfV32ihuw+KR5Dr+ngn0Ow=
X-Google-Smtp-Source: AMrXdXuA6XoMVTibmB+ROe0ZlfEDwOQ5K+en01sIIlmIvkMXBZwj+9qeJ+MzRenwB2Ps4nw4eUz8Fw==
X-Received: by 2002:a17:907:8c07:b0:86e:2dd4:6656 with SMTP id ta7-20020a1709078c0700b0086e2dd46656mr29651ejc.6.1673897583015;
        Mon, 16 Jan 2023 11:33:03 -0800 (PST)
Received: from [192.168.1.100] (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0048ebf8a5736sm11771799eds.21.2023.01.16.11.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 11:33:02 -0800 (PST)
Message-ID: <1940bef1-4140-7430-48a4-e1a54068dde6@gmail.com>
Date:   Mon, 16 Jan 2023 20:33:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] staging: r8188eu: some error logic cleanups
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230115210734.18610-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230115210734.18610-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/23 22:07, Michael Straube wrote:
> This series converts some more functions away from returning _SUCCESS
> and _FAIL.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (4):
>    staging: r8188eu: convert PHY_MACConfig8188E() to common error logic
>    staging: r8188eu: convert phy_RF6052_Config_ParaFile() to common error
>      logic
>    staging: r8188eu: convert phy_BB8188E_Config_ParaFile() to common
>      error logic
>    staging: r8188eu: convert PHY_BBConfig8188E() to common error logic
> 
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 35 ++++++++++---------
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  7 ++--
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 15 ++++----
>   3 files changed, 27 insertions(+), 30 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
