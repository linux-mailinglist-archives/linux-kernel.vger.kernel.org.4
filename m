Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED505B4BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 06:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIKEas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 00:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKEaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 00:30:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23277F2E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 21:30:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bt10so9616316lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=X5ivUekAN0+fAD88EJc1Tp5DfK9ShiN7PGoVIvmWHTk=;
        b=SF/F1NBTXeQZpKTxuzqq+tzmA/zefvP30kNFislPl/c21AQRl4fJEH3HHcLXeTofDx
         XeBgWrxCcjqp5N6EYuLpo3kslaSSphTvHrBdczZdE1upRdzx+eG57jBBVCmYMWsRkeTf
         onEDW8r5Rq0IyjslPTZsa1gjK0p2pOmrnxiOtsglzaey7ibbUcELBUw87WzQ62q10xz+
         iG/Ad9FZM+tguD8ga3HjuYqWAJbVDCLyygmqdK6iS8lzYlk3Th9tGQZEXN4T/567pNlk
         EyDl8mBGa4UJONrrP1xzVP1XyQRN2fnDJdhvXqa5oJxQUOXkOZdMEDG5Fz6RWQMtMuNZ
         ldYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X5ivUekAN0+fAD88EJc1Tp5DfK9ShiN7PGoVIvmWHTk=;
        b=412hoYuiYYUNG4c4GRwklqWjSd5lIMxgegvGh6iG83aPnZn1LuWABv7mKN11NlZTD+
         1pRUqsYMT0MTGN9COWSTtbH2PKkwQMFyR9N5Q/fBe7rpWNI8Y4LzSzCihiwkVM5lQBmV
         jI8nahf5/NL0zUjxHuKiPsmZPdz6ULW8pMfFC6RMrwuA43mWDgQn4VZUkTvMAbRFMStb
         /i3+8/LZx7OkQ3wOZtMz/rhlqau4QeSs0kBomBgDeST6rk37iaS2UR9Th36XWbQ2FnWY
         GT8s5oxB7lirJDMpEI4/oh1XDKoDdan8Q+yr5AklJ9jdBTw3x2v1RCXA3p3IW/wNAB/P
         LXIA==
X-Gm-Message-State: ACgBeo3vmlN5StNeoYRf55FLST3stz9AQm2YpBMg/SUVk1STK2uxL72C
        sLVDdAqHogRdnMCpcKLpdDA=
X-Google-Smtp-Source: AA6agR4m72NSpZUn84imwDHKRYzYRKLuQBQ6rXVyBoLNtNkd1+J2xkRaAdKeYuiamtfa6MC1c9xbKg==
X-Received: by 2002:a05:6512:1586:b0:498:fa29:35ec with SMTP id bp6-20020a056512158600b00498fa2935ecmr3763479lfb.641.1662870643243;
        Sat, 10 Sep 2022 21:30:43 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:e929:c054:a46d:3844? ([2a02:a31a:a240:1700:e929:c054:a46d:3844])
        by smtp.googlemail.com with ESMTPSA id o18-20020a056512051200b00497adccecddsm469940lfb.170.2022.09.10.21.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 21:30:42 -0700 (PDT)
Message-ID: <411ebe0f-f398-8e32-ad0e-b42732aa880f@gmail.com>
Date:   Sun, 11 Sep 2022 06:30:39 +0200
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
 <20220909140059.g57oihcmhuym62ei@houat>
From:   kFYatek <kfyatek@gmail.com>
In-Reply-To: <20220909140059.g57oihcmhuym62ei@houat>
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

Hi Maxime,

W dniu 9.09.2022 o 16:00, Maxime Ripard pisze:
> On Wed, Sep 07, 2022 at 11:31:21PM +0200, Mateusz Kwiatkowski wrote:
>> The "canonical" modelines (at least for vc4's VEC, see the notes below):
>>
>> - (vfp==4, vsync==6, vbp==39) for 576i
>> - (vfp==7, vsync==6, vbp==32) for 480i
>> - (vfp==5, vsync==6, vbp==28) for 486i (full frame NTSC as originally specified)
>
> It's not clear to me either how you come up with those timings?

Well, experimentally ;)

The values for 480i and 576i are the values currently used by the downstream
kernel, and those in turn has been copied from the firmware (or more precisely,
I chose them so that the PV registers end up the same as the values set by the
firmware).

I also checked with an oscilloscope that the waveforms look as they should.
VEC doesn't exactly handle the half-lines at the start and end of the odd field
right, but otherwise, the blanking and sync pulses are where they should be.

The 486i values has been constructed from the 480i ones according to the
calculations from cross-referencing SMPTE documents, see my previous e-mail.

I know this is perhaps unsatisfactory ;) I don't have access to the VC4
documentation, so this was _almost_ reverse engineering for me.

Best regards,
Mateusz Kwiatkowski
