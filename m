Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D5A614312
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKACME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKACMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:12:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3570D2D5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:12:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k22so12279484pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLIgCkgfgn5iTxPM1gVk+h8esf5par019LyioMO/CLQ=;
        b=gU2fp1alF/CfGOz27zUV1tjPYcplNa+O+KfQ2mlTKNBOYkbaz2YHEWSbyw9BTJ1iB9
         CXJmh50YXtArdV/k5JEmRpQT7DHUB13lbMbIEtMBtOo+wtF6Y1gfdeeoGWJBl62TkAzQ
         BEfh7yEbZSKS008pEA1eFifU/N7E7UzTdJM7X4nRvegykLKHnXQ+jVyGFPsgg0Ulhl9Q
         ox24q4Ks2nKRUU2/XPksxf2/D9e6nIWtubBmOjYa3dURJXgXRmFaIpH8cglg/K2hIxIl
         xX9QGIkiqZjks4prwAhu1OqO7bIYQ0E0+sIiXC75Mn9QhPJTVFgtkV1g77gONuYDTja9
         vpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLIgCkgfgn5iTxPM1gVk+h8esf5par019LyioMO/CLQ=;
        b=n345LyFnwrTm7DMfFrDm1Bqe4eP9m/9zeJUD6XDczis73d0GoFICWqhzpKqGR7ZDPN
         0sX7sdh3kVInlW3/4gZ/8toHR+u5jrPNgJJEfdumO7hY/sUc41Bj7efneHSTZcTp6ohh
         E8aNGIJW+mdOVeep2BJSo3z4Uts4Sg7iqO/ywRZYA4CQ50S6Nl4ATngqSvM43xurrg00
         1tmo5dtlLh/rBVqneUjfmbleJjLDdle1TYYAygxX02l1Cs3FozPibJ4YBq9yHkhdbVxA
         Vvozxu/iYM0y779XeiJ1CS+vmlAXW1UyID2d8jDxatZSOVtJCTGZzH9/uCBWuVtHqsZf
         ELlQ==
X-Gm-Message-State: ACrzQf07BbFM1qet4+0srdRe1IpBEUQTznbY4/L6vQykFMAUGCP/FtFU
        VvHNOOfWDRVuIFAQF6ci484=
X-Google-Smtp-Source: AMsMyM4mI22oj7nqThjTGVGTfQDqYJrZXRbzCHmvjp5TFLMaXojFrrR1id5r7IJQp6VGKrbltoxdnw==
X-Received: by 2002:a05:6a02:186:b0:431:25fb:f1fe with SMTP id bj6-20020a056a02018600b0043125fbf1femr15584524pgb.130.1667268721265;
        Mon, 31 Oct 2022 19:12:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-90.three.co.id. [180.214.232.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a63134b000000b0043ae1797e2bsm4744655pgt.63.2022.10.31.19.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 19:12:00 -0700 (PDT)
Message-ID: <5a61ae6a-8a16-8abb-e718-895c41e2e7a8@gmail.com>
Date:   Tue, 1 Nov 2022 09:11:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] drm/nouveau: Add support to control backlight using
 bl_power for nva3.
To:     antoniospg <antoniospg100@gmail.com>, linux-kernel@vger.kernel.org
Cc:     sam@ravnborg.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
References: <20221029184851.25340-1-antoniospg100@gmail.com>
 <20221031163211.13228-1-antoniospg100@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221031163211.13228-1-antoniospg100@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 23:32, antoniospg wrote:
> Summary:
> 
> * Add support to turn on/off backlight when changing values in bl_power
>   file. This is achieved by using function backlight_get_brightness()
>   in nva3_set_intensity to get current brightness.
> 

This is [PATCH v2], right? If so, next time please pass -v <version
number> to git-format-patch(1).

Also, just say the prose without using bullet list. "Summary:" line
is also redundant. And again, please describe why this change be made.

> Test plan:
> 
> * Turn off:
> echo 1 > /sys/class/backlight/nv_backlight/bl_power
> 
> * Turn on:
> echo 0 > /sys/class/backlight/nv_backlight/bl_power
> 

Shouldn't "test plan" above be documented in Documentation/ instead?

Last but not least, is "antoniospg" your real, legal name?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

