Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0744603466
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJRU5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJRU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:57:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B98753A54
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:57:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b1so24734632lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4q8+ZZXGKoh6iTQurAmJvf03RKoxifLtlwxrMQru1hE=;
        b=kt8lC+lO4gSY3YG0906oJiNdGLU7GhkVYc9H88KhNuvwjumuuchbdPapkO7dxBf/Qy
         BoDMNcubA39QyDexTULFTiZaU7aDUsPZdwQojRw+xlCeZ2FP/rlSY9fvBGCEeu5NgYE1
         zVoh9LYbcej1ow4N6cLbaE+lDZeOB1v/1BSRHabYjz6zOJf2NcUenT+Ap/6lzQwSiK/I
         mlfYogp/zJo5VBiA1eANhCvnKdKTUeB/E4rMC8r+poPJuWlQldvWIkta/4sPXBwuMnDH
         8xdUvhBvP4s3zBZV8Ig0pbp7QaiLgQRGGd2Qn8+rLaxzbul2vaXrnjy/QMa5jir9u/45
         pCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q8+ZZXGKoh6iTQurAmJvf03RKoxifLtlwxrMQru1hE=;
        b=P8xD4douMLHElShootJh2Z/15SmUEUTdPW0SnH0+bF4eCA61o8BQ4XGVtdryal53io
         DESZs1kIpCZ4/7olpvuIcb5CDODWC4ByecEQEGY1DGNav7BaSY3oYl/k0WWqdpatGmn5
         OzADI/pOT65ftCMW7EUBooQkIuWLQ/Fq0tTdR6vTQnia1mypKbYNqIILiIruipEImpL7
         sHVjpXviwhIdFvdy1zraPI3t848/EM+wqPUciazJOcFcmcMZ8sRlg1mxgNgHHjfdXaCM
         KqOMr0yorDQ1tvtSSOosVJr/D8UdNR/KXQSJV9SwKwtAeU5D8c0WQFqtXikOfKKAawtY
         axyA==
X-Gm-Message-State: ACrzQf3ebhtImj9IOTOvGU1fKYdIScCpsyOdkS3xo6Vbc2yAiPClM+Yy
        gSx8UG4xOWHx4szcI/7H/RA=
X-Google-Smtp-Source: AMsMyM43gEnq7ci5pkLxJm4400YhMYoE1+4aaJJ/DU7cyGERdBh2fCJRUyqe3H9D3aDzTea6EsoYiQ==
X-Received: by 2002:a05:6512:114a:b0:4a2:58a3:95f2 with SMTP id m10-20020a056512114a00b004a258a395f2mr1687359lfg.7.1666126629466;
        Tue, 18 Oct 2022 13:57:09 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:ade4:dc4:81f3:286b? ([2a02:a31a:a240:1700:ade4:dc4:81f3:286b])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05651220cd00b0049d83646ce7sm2002435lfr.110.2022.10.18.13.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 13:57:08 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <0afdeda7-558e-647f-ef28-1fcd80807c1b@gmail.com>
Date:   Tue, 18 Oct 2022 22:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Reply-To: kfyatek+publicgit@gmail.com
Subject: Re: [PATCH] drm/vc4: vec: Add support for PAL-60
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Emma Anholt <emma@anholt.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
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
 <93bf9fcc-c645-b042-011f-8f1fc957af48@gmail.com>
 <20221018083153.okkqpd5ccfrnwdj3@houat>
In-Reply-To: <20221018083153.okkqpd5ccfrnwdj3@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

W dniu 18.10.2022 o 10:31, Maxime Ripard pisze:
> Hi,
>
> On Sun, Oct 16, 2022 at 09:46:49PM +0200, Mateusz Kwiatkowski wrote:
>> @@ -308,14 +324,15 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] = {
>>  };
>>  
>>  static inline const struct vc4_vec_tv_mode *
>> -vc4_vec_tv_mode_lookup(unsigned int mode)
>> +vc4_vec_tv_mode_lookup(unsigned int mode, u16 htotal)
>>  {
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(vc4_vec_tv_modes); i++) {
>>  		const struct vc4_vec_tv_mode *tv_mode = &vc4_vec_tv_modes[i];
>>  
>> -		if (tv_mode->mode == mode)
>> +		if (tv_mode->mode == mode &&
>> +		    tv_mode->expected_htotal == htotal)
>>  			return tv_mode;
>
> Is there any reason we're not using the refresh rate to filter this? It
> seems more natural to me.

Let me give you an example first.

There are actually two ways to configure PAL-60-ish mode on VC4/VEC:

a) Modeline 13.5 720 734 798 858 480 487 493 525 Interlace, standard registers
   set to VEC_CONFIG0_PAL_M_STD, custom frequency enabled and set to 0x2a098acb;
   Setting the standard registers to "PAL-M" puts the VEC in true 59.94 Hz mode,
   so the video timings are identical as for NTSC (or PAL-M), and the custom
   frequency makes the color subcarrier compatible with regular PAL receivers.
   This is the "true" PAL-60, thanks to the true System M timings.

a) Modeline 13.5 720 740 804 864 480 486 492 525 Interlace, standards registers
   set to VEC_CONFIG0_PAL with standard frequency; This is a "fake" PAL-60 mode,
   the refresh rate is actually ~59.524 Hz. Most "NTSC" sets will be able to
   sync with this mode no problem, but the VEC is actually operating in its
   50 Hz mode - it's just the "premature" vertical sync signal causes it to
   output something that is similar to the 525-line system, however strictly
   speaking non-standard due to lower horizontal sync frequency.

This comes down to the fact that:

- When VEC's standard registers are set to VEC_CONFIG0_NTSC_STD or
  VEC_CONFIG0_PAL_M_STD, it operates in the "CCIR System M" mode, expects htotal
  to be exactly 858 pixels (and it will generate horizontal sync pulse every 858
  pixels on its own regardless of what comes out of the PV - so there will be
  garbage on screen if you set it to anything else), and vtotal to be 525 lines.
  It will not accept vtotal that's any higher (it will generate its own vertical
  sync as demanded by System M if not triggered by the PV), but it can be lower
  - resulting in modes that are non-standard, but otherwise valid.

- Likewise, when the registers are set to VEC_CONFIG0_PAL_BDGHI_STD,
  VEC_CONFIG0_PAL_N_STD or VEC_CONFIG0_SECAM_STD (SECAM is a bit special, but
  that's irrelevant here), it operates in the "CCIR System B/D/G/H/I/N" mode,
  and likewise, expects htotal to be exactly 864 pixels (garbage on screen
  otherwise), vtotal limit is 625 lines, etc.

Checking for the refresh rate would only work for standard-compliant modes and
have the potential of completely breaking on any custom modes. Conversely,
checking for htotal aligns perfectly with the limitations of the hardware, and
allows the user to set any modeline that the hardware is able to output with
any level of sanity.

Footnote: all this information on VEC's behavior comes from my own
experimentation, messing around with its registers and seeing what happens
(both on screen and on an oscilloscope). I've never seen any Broadcom docs on
this chip, so it's by no means official.

Best regards,
Mateusz Kwiatkowski

