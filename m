Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602C5B4C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 06:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIKEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiIKEvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 00:51:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4496B29CB3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 21:51:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so9610818lfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 21:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=XIY+68P3U22mQGsLLoSSFcg2zg1iq6nyQPz8fLaQ0oE=;
        b=KMFPIZg72ybP/U7EjC2ScfiAUimjnENQw0GEyTYJzmkUU52crQ6OHlLskmExR7NsSs
         eMY9SN0NOGAqyKnlGcCLLgdOs6Zjmj+OE9PviAhQdducKwbYV9wzHgn/rbq+7bGUx559
         NodqqgwDI1U8LSxxaSKvzGyevZmw4d85G43k+/QUsDCmQzdS/01OO6nGrrgv4o8ywLAS
         oZGLMbfaTaDk8ekJkgsUnobyUQLa71UK+15ACp1hxK9r8APUX/VCok+93Z33A1EZsq93
         n9631zSD2uMvomFLsW6aMIbP145LN5a+TL/DXeuW565iBiQ7pgoEkG9EPtVOin1SV0ul
         8gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=XIY+68P3U22mQGsLLoSSFcg2zg1iq6nyQPz8fLaQ0oE=;
        b=hxznyOdxal9WtUqEOb47Hx4H+gAYbihHHvxikoO0+iKneeykzZJg+Y8LseKisrWwOW
         XzuO7XaYmBP+SgOSBkSiEPPhrOuBtZjUVvGPcKgc7yR6SZip186pJVwcoi6hanPCL4Xk
         OJ4hjPHhroFfHyJYTG19KhdYV5VFxC72a/+qG5cvLZHur/V4pNOLNT+UR0ceYj/6hEjV
         GTKjD6rHbZvWjsoeBMZK4QTQWZcCnRcc4fTnbxYRi2zwlMjjAdJQM93KGH2Z1d2wdfsm
         PShNevaz01RHpJVXMmjWAKrUlxabakv9kYYtJtryKLi91QInLpMzZknLp8v6ZeY9MOL/
         TDqw==
X-Gm-Message-State: ACgBeo2EOpSmtDGKPU5seU/W3g5xrIf6jRUNcFzqIwM4lFeFrxQsAvX+
        Q5SsCFi3MttAYn3FhzQ5Fzw=
X-Google-Smtp-Source: AA6agR4HaTIFXR95Cv35IjLjzgwZoQn9BgzbhDxW7IP1eMizctu6PfCBylwC524DiMtSVr18MWoAFw==
X-Received: by 2002:a05:6512:281a:b0:49a:4e46:34ff with SMTP id cf26-20020a056512281a00b0049a4e4634ffmr411587lfb.72.1662871880581;
        Sat, 10 Sep 2022 21:51:20 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:e929:c054:a46d:3844? ([2a02:a31a:a240:1700:e929:c054:a46d:3844])
        by smtp.googlemail.com with ESMTPSA id 7-20020a2eb947000000b00268cfcf841asm46332ljs.56.2022.09.10.21.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 21:51:20 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <c1d7ac5a-90bf-d6ea-ec77-ec7662482d2e@gmail.com>
Date:   Sun, 11 Sep 2022 06:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech>
 <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
 <20220905133755.gcmmntg3wnecyqjq@houat>
 <10ce686a-d7c8-9ce4-3979-735ad8eab3b5@gmail.com>
 <20220907143421.4iopqwhp3yfircsh@houat>
 <dc1d9499-d4d5-1032-f39f-d4ac4cbb8412@gmail.com>
 <20220909135444.5oi6oh6nqwuke3jl@houat>
 <79ab3fef-fdaa-e191-d839-4af88191e672@gmail.com>
In-Reply-To: <79ab3fef-fdaa-e191-d839-4af88191e672@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, lines 0-23 is the entire blanking area. And the "back porch" in this
> context is everything from the start of the sync pulse to the start of active
> video. It's not just the equalizing pulses.

I meant "from the end of the sync pulse", obviously. Sorry about the slipup.
