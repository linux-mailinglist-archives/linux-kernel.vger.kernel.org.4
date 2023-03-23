Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610936C5E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCWFG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCWFG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:06:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B41815A;
        Wed, 22 Mar 2023 22:06:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so807806pjv.5;
        Wed, 22 Mar 2023 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679547981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uslu0ZwIdbBAB9DtRFNhbaFYYXQ5l/7Bay9LuhkFhWA=;
        b=J8vXcQBi+56tXwzVdXHJT55bP1SfM6Cn6M25eb3QpZqiR6eZA0xVJbUx8P+RebeZmS
         azK2SPBLvNo6mA6M/GydZCzPD4dmqUjaftnwfjF0dqvzqajN94mxGTQZlZTiB1qlXWI6
         d19TaZE+TX3RTzhStG1H7CjsmTZmh54WblXKh6q0PHxH1TAIJFZM5doQ8br5COPNJyPO
         96lG9UN08nNpK9/5Z8x1nk5VcAAk+JcmuefXRf4D/OZ8PIwL3OwSVPBoauPCl2YHt4Gc
         TBnTjzerYodxGbxxsoQDWAEs63/8tNtCxvnfjtgAnqETfpmeM2mSgt0EGygJ36FcTvaR
         HkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679547981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uslu0ZwIdbBAB9DtRFNhbaFYYXQ5l/7Bay9LuhkFhWA=;
        b=yT0bRAXsOMyUnwc09pIWmAlDlDfg1iKzrVTmnxDbOlEhF+ok7CBgoOKx/cnFqfW5OI
         WILx3WZewS11p3fnx1zszN70b5jdM8leQGYWWHpgT2aD9zsgDrY0/XQx/pGD5x09PguK
         CozkwA7go+kHoNTau2GlDNdv9hhtXBindFipgccSsaZyc2Ozy/JsuKbnKCrL+dKarXWm
         mgajbHTPOPcCu5XgiEpNYzRlb4I7aAQ1YS4KAo5Tj1S1Agdq1ryEdX7Q7goS8jEW0LtF
         rLte+wPmecl26ZG0FALyFppq1eN5sduu6wlXB1MAXT+zzFeiBjLF1Sgt727ZLg9Px1+p
         5MPA==
X-Gm-Message-State: AO0yUKXM4tBQsMBksaVFBiuNOuj4rvDnU49up10Q1iptB3/3OWCFIrYv
        ksPcT2agPSdXf5Av3r4HTkklTHI6RKM=
X-Google-Smtp-Source: AK7set8pmIF3SpB2VlHJjep6SwQTSbIVUIZGhIu/mR5Peoy8RYSak9CpuzCZsgIi1ozBpqpqMySaMA==
X-Received: by 2002:a17:902:d50d:b0:1a1:cc0c:a5c0 with SMTP id b13-20020a170902d50d00b001a1cc0ca5c0mr6797000plg.63.1679547981613;
        Wed, 22 Mar 2023 22:06:21 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902760200b001991e4e0bdcsm11444168pll.233.2023.03.22.22.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 22:06:21 -0700 (PDT)
Message-ID: <2b8667b5-ea54-2ef4-f069-a86acd28ecea@gmail.com>
Date:   Thu, 23 Mar 2023 12:06:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] Documentation fixes for MT6370 RGB
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230319074903.13075-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 3/19/23 14:49, Bagas Sanjaya wrote:
> kernel test robot recently reported htmldocs warnings on documentation
> for MT6370 RGB LED. So here are the fixes.
> 
> Bagas Sanjaya (3):
>   Documentation: leds: Add MT6370 doc to the toctree
>   Documentation: leds: MT6370: Properly wrap hw_pattern chart
>   Documentation: leds: MT6370: Use bullet lists for timing variables
> 
>  Documentation/leds/index.rst           |  1 +
>  Documentation/leds/leds-mt6370-rgb.rst | 42 +++++++++++++-------------
>  2 files changed, 22 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 4ba9df04b7ac66d2d000ed7ae2d8136302d99a57

ping

-- 
An old man doll... just what I always wanted! - Clara

