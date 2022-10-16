Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413A6002FA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJPTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJPTCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 15:02:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C12AE3F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 12:02:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so14477561lfu.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tT8kCb/WVUuH+lBmBzSowO1khzyce9k0uFdBJXQAY0=;
        b=Wn022JhbSiAKl2X8PK/0dLLvnA2KYx59VyBDcpMKkslDxq1gmTavUweTw7TSpfsy29
         ZQNm5d5Kud9NAMBx2DWE4ATZlqZ+7v4VQY6jnBU0w/Jly+Ji2YJygQ2d2aE5SvnPOuBc
         LUaIek3ag9tos1DYUCuOXC4mBkjA654+4/vseW2aGFGg4V9Q4tOwIoveXTgC6nBCvoix
         WqKvIjohOpkxN+5vEWW2J/wJ5Bt6x6aSYTqCGGxEtIxf30EL8n0PHVh8GQ0KmrQyXays
         jsKB/0dkT524iaTd2N3LvRFONyV2QpPt9l6M6dD70TbInNsqcmnQjjZX7ML1lQcEx5+N
         Xt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tT8kCb/WVUuH+lBmBzSowO1khzyce9k0uFdBJXQAY0=;
        b=vFW5pkLvhHLrr9cqBsmy0w38nQmsm+kbNxCErh5XpeQjsoLxqeNLEMilqzDZ4p8xxZ
         JyHKS4dXojIXEEFXM1B3ot5A2vkTPBpPgd77NOfnaesXyPnUMtyNDsJrZn/ikorUbPa9
         6H39d8Uih/XJwuAQhbT+kkYA0ffzsNFPfdggMXAjUJzEgUBmns3/gO9OWQ1y0vE8c4Cp
         UkPdKETadrTNBe5R0ThQ4NjcNXG50yWzw9mA5cANtCZvZ4qN3d/8e1R6QAXkOBOKlZTP
         PFZ7NxsOhmU0QDnfy4iitok4+nWnrvZONixn+HuGSYihhINYHvT6dBgF7qmDYHy62XWs
         I9mA==
X-Gm-Message-State: ACrzQf0UvFbWiZ+9kTKTnvi0wHNPVpqvAldyco4/FLzEuN67GVMc+Fs3
        9psTNtlYeTFrkrWq74FeRMo=
X-Google-Smtp-Source: AMsMyM7y2QYkuboXP2v70rAENTc5DitWTlWhre5mOH5uFbdJJu3TsghZ/Z8+nuj9UYyZBokwz7Tq+Q==
X-Received: by 2002:a05:6512:32ab:b0:4a2:2e49:94c with SMTP id q11-20020a05651232ab00b004a22e49094cmr2839114lfe.351.1665946939657;
        Sun, 16 Oct 2022 12:02:19 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:64bb:87df:aad7:a9f0? ([2a02:a31a:a240:1700:64bb:87df:aad7:a9f0])
        by smtp.googlemail.com with ESMTPSA id p10-20020a2eb7ca000000b0026dc57ee439sm1235527ljo.71.2022.10.16.12.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 12:02:18 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <e0867d71-37c7-777f-0df2-0cd74909caaf@gmail.com>
Date:   Sun, 16 Oct 2022 21:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Reply-To: kfyatek+publicgit@gmail.com
Subject: Re: [PATCH v5 21/22] drm/vc4: vec: Add support for more analog TV
 standards
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-21-d841cc64fe4b@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-21-d841cc64fe4b@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

W dniu 13.10.2022 o 15:19, Maxime Ripard pisze:
> From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
>
> Add support for the following composite output modes (all of them are
> somewhat more obscure than the previously defined ones):
>
> - NTSC_443 - NTSC-style signal with the chroma subcarrier shifted to
>   4.43361875 MHz (the PAL subcarrier frequency). Never used for
>   broadcasting, but sometimes used as a hack to play NTSC content in PAL
>   regions (e.g. on VCRs).
> - PAL_N - PAL with alternative chroma subcarrier frequency,
>   3.58205625 MHz. Used as a broadcast standard in Argentina, Paraguay
>   and Uruguay to fit 576i50 with colour in 6 MHz channel raster.
> - PAL60 - 480i60 signal with PAL-style color at normal European PAL
>   frequency. Another non-standard, non-broadcast mode, used in similar
>   contexts as NTSC_443. Some displays support one but not the other.

The current version actually does not support PAL-60. Proper PAL-60 output from
VEC requires configuring it differently than for regular PAL. We have unified
the PAL and PAL-60 modes for the "TV mode" property, but the code here has not
been adjusted appropriately.

I'll try to submit an additional patch that fixes this shortly.

> - SECAM - French frequency-modulated analog color standard; also have
>   been broadcast in Eastern Europe and various parts of Africa and Asia.
>   Uses the same 576i50 timings as PAL.
>
> Also added some comments explaining color subcarrier frequency
> registers.
>
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
(snip)

Best regards,
Mateusz Kwiatkowski
