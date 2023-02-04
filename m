Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29568A7B6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBDB4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDB4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:56:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89180113C8;
        Fri,  3 Feb 2023 17:56:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so5944888pjp.0;
        Fri, 03 Feb 2023 17:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAWQVltchINdESu1keirl+Juwz9kMSkbmqmPLABnVbo=;
        b=QTuOo3d0ewbioZYf6mnFIAlDpeSCJHTbUuksJIgSc6sVTD/qzHLKCQAj5xBdOM2bmO
         Soo707EBxlJBabfYQwsYxXbrjFzpIxEqeVQPd5sLdmlTvcuBcIi9QE4l1HwQAO+k7bjc
         boc2GIDowt/ri8sHZRd0uJXZN4qE9R6FUeZwvG0VTWCr229rh3THEWu+0uVg20392Win
         Im6B9qUX8zWdMoD2w4ivMDJqXf3614CjuknmLhcVurQCzn6AcCFrHDStbLJ3ET1rRjhf
         XcFEzstYVHWA7dbx2kCTawoGgAjJ3HyKzMNuZ7/wCCcox6ptbGOjmB6fXVCFhq9AoXr/
         TsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAWQVltchINdESu1keirl+Juwz9kMSkbmqmPLABnVbo=;
        b=sfTF80694XOut3g1MEbJCX+qXWAXYeb462CUFwnqg6WO0Th19h/8/nshqavg52Cv8g
         4H+DJpqGw7oMrVhX8BFwoVa/9Yhs8jmINVJEOTehdkLdDKrRLXth6s8eTx8wt0KDICPS
         39y2uqurAsjgqZbiO3Zg/NRsjS/3QuuMd6eAUMcqzLOqfpvq4GA2iBnpUJHDD+OaSzFm
         5YKGfd7HRBdrdtn+4oclh4iitq9wFU5EPbi3CCWjBuSyF7WB0DUTCyScH1J3uTT5/eEk
         7PVtViBwbi12CBX+X3Jg4we6eGOT/QwObcXK4lPHER0KT5bS7eJ9LhS95zAW+CG01IA4
         Okyg==
X-Gm-Message-State: AO0yUKWYgJ+lM+QG+2J5Bbukgg1YLL76cbt4TDIA9eO9uGbWlcX24Eo/
        grZpngQ2B1wjale7Ulepeq0=
X-Google-Smtp-Source: AK7set8sBWWRuULWZIPZU3d4F7wNKydipPZKkOR5r2H8zeah5I958RN7LP7qBe8E0SYh9UqoNtYrQA==
X-Received: by 2002:a17:902:c944:b0:196:4652:7cff with SMTP id i4-20020a170902c94400b0019646527cffmr13150025pla.11.1675475798893;
        Fri, 03 Feb 2023 17:56:38 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b00189e1522982sm2265553plb.168.2023.02.03.17.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 17:56:38 -0800 (PST)
Message-ID: <6a5592a8-10f9-9c08-0a4b-fcf49d8acc1f@gmail.com>
Date:   Sat, 4 Feb 2023 08:56:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] drm/scheduler: Fix elapsed_ns kernel-doc error
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Intel Graphics Development List 
        <intel-gfx@lists.freedesktop.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Srinivasan Shanmugam <srinivasan.s@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230203100215.31852-1-bagasdotme@gmail.com>
 <20230203100215.31852-3-bagasdotme@gmail.com>
 <99c4db33a1966bd1979817277facb4a42ba2333f.camel@pengutronix.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <99c4db33a1966bd1979817277facb4a42ba2333f.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/23 18:27, Lucas Stach wrote:
> Thanks, I've added this to the etnaviv tree.
> 
> Since the commit is only in -next and not a non-rebase tree yet, I
> might be tempted to squash the fix into the offending commit. What
> would be the right way to credit you for the fix in that case?
> 

On SoB area, you can add:

[Bagas: Append missing colon to @elapsed_ns]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

