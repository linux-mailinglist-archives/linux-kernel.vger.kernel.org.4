Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7076F98CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEGOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEGOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:06:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C917FD1
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 07:06:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so3424605a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683468416; x=1686060416;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ+Zv9iPIV5c5mEEYmPeczvWpn9ZYRYUNQh2mIfufVo=;
        b=rGCvSB7GU9uY+fxg4bXAR7aJ6m+HZcQEKHMVdurBrI+e6BgDtUb24072N2haXoKelu
         SJhkBnyKxjc1Q9JqIBsiLM26N2tVjqImYVBIuZFmsngGuNk0O5RA+maWkmiORuO2RbzF
         Z/HHfruvjtBL26lzW0H6n4wAXK7bGunJZiT9Iffs/jLxAlzzRBw++bz5O/gNYSHEMpT5
         2qDO/fDGSoX2d8LuuAld9P94hPvTK//xJ8x9jkuZaVLg4loOPhA/yD8AE5TI4jCxZDJd
         4R+BG0jcgYz6RIglz/Mxt2mNqwVUnocZ4najE0tLJ8o44xVFiFH+KLU5EVE+vvLsEYu9
         SXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683468416; x=1686060416;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQ+Zv9iPIV5c5mEEYmPeczvWpn9ZYRYUNQh2mIfufVo=;
        b=gvSIi5sGOzmHfAtcsF1GRRoBUOk33ZQEJWvgPFvK4xdtvSJ2wR34wv9/lr9YLTSaei
         t1xgRoFqaGrf3JgjWNrSd/DF1t5LVxXjJxBOo/nJhr5O4FBSsM0T7M5lD+VLap6+uPOj
         hIhMameUOAJSmBqekFSuHwNnP7qbTQNP8KRTZYtFTW/QvlCHJ3nZUK3QVgJICHCLSQlb
         1/YAd5IDnrgksDWxKBAaObdcbIIjGoN964pS//PW7yFulr6sKhoJlfwvPWAQzF6zm/7q
         q8TuqSu2ItFYWgOWQJier0XznZbfc9BBymdUrUKgR4ZTFLljpXJAeYps9OJhocyWjiIc
         UVyg==
X-Gm-Message-State: AC+VfDwlnXtw/su0ibVC4dprXStVtHlPsw21V37fR1uBWBRTK2RzAQEP
        fbDL7bZ2NdsykgsNSxs53rm6bZJVc90=
X-Google-Smtp-Source: ACHHUZ5Zlrg01Q0siCjZqE7g7AXqHbKhr+8KfA/FK7msmbTd/DMW6fvxOFtUzSXxcOIEaEEHpV/YIQ==
X-Received: by 2002:a17:90a:508:b0:24b:be0c:6134 with SMTP id h8-20020a17090a050800b0024bbe0c6134mr8029580pjh.33.1683468415684;
        Sun, 07 May 2023 07:06:55 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b001a6a53c3b04sm5205302plb.306.2023.05.07.07.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 07:06:55 -0700 (PDT)
Message-ID: <466c0d68-5fac-74cc-c32e-23174f48add7@gmail.com>
Date:   Sun, 7 May 2023 21:06:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Asus ROG Zephyrus GX701L sound problem
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a year-old bug report on bugzilla [1]. As many developers
don't take a look on it, I decided to forward it by email. You will
need to log in to bugzilla in order to contact the reporter.

Quoting from the bug report:

> Hello,
> 
> I must mention right at the beginning that I tried all the solutions I found on the forums, but without success.
> 
> The problem exists only with the speakers on the laptop, the microphone works, as do the headphones.
> 
> I extracted the audio dump from windows and compared it with the dump from Linux and thus created this pinfcg below.
> 
> Please, can someone add a kernel fix for ROG Zephyrus S17 GX701LWS_GX701LWS, Subsystem Id: 0x10431f01?
> 
> ```
> 
> [codec]
> 
> 0x10ec0294 0x10431f01 0
> 
> [pincfg]
> 
> 0x19 0x03A11050
> 
> 0x1a 0x03A11C30
> 
> ```
> 
> This is what a quirk should look like:
> 
> +SND_PCI_QUIRK(0x1043, 0x1f01, “ASUS GX701L”, ALC294_FIXUP_ASUS_SPK)
> 
> [ 2.396344] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC294: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> [ 2.396348] snd_hda_codec_realtek hdaudioC0D0: speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [ 2.396349] snd_hda_codec_realtek hdaudioC0D0: hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [ 2.396350] snd_hda_codec_realtek hdaudioC0D0: mono: mono_out=0x0
> [ 2.396351] snd_hda_codec_realtek hdaudioC0D0: inputs:
> [ 2.396352] snd_hda_codec_realtek hdaudioC0D0: Headset Mic=0x19
> [ 2.396353] snd_hda_codec_realtek hdaudioC0D0: Internal Mic=0x12
> 
> 
> 
> 
>     hwinfo --sound  :heavy_check_mark:
>     22: PCI 1f.3: 0403 Audio device
>     [Created at pci.386]
>     Unique ID: nS1_.Qb7ky1jjQRD
>     SysFS ID: /devices/pci0000:00/0000:00:1f.3
>     SysFS BusID: 0000:00:1f.3
>     Hardware Class: sound
>     Model: “Intel Comet Lake PCH cAVS”
>     Vendor: pci 0x8086 “Intel Corporation”
>     Device: pci 0x06c8 “Comet Lake PCH cAVS”
>     SubVendor: pci 0x1043 “ASUSTeK Computer Inc.”
>     SubDevice: pci 0x1f01
>     Driver: “snd_hda_intel”
>     Driver Modules: “snd_hda_intel”
>     Memory Range: 0x94300000-0x94303fff (rw,non-prefetchable)
>     Memory Range: 0x94100000-0x941fffff (rw,non-prefetchable)
>     IRQ: 157 (817 events)
>     Module Alias: “pci:v00008086d000006C8sv00001043sd00001F01bc04sc03i80”
>     Driver Info #0:
>     Driver Status: snd_hda_intel is active
>     Driver Activation Cmd: “modprobe snd_hda_intel”
>     Driver Info #1:
>     Driver Status: snd_soc_skl is active
>     Driver Activation Cmd: “modprobe snd_soc_skl”
>     Driver Info #2:
>     Driver Status: snd_sof_pci_intel_cnl is active
>     Driver Activation Cmd: “modprobe snd_sof_pci_intel_cnl”
>     Config Status: cfg=new, avail=yes, need=no, active=unknown
> 
>     29: PCI 100.1: 0403 Audio device
>     [Created at pci.386]
>     Unique ID: NXNs.SkelvpPm387
>     Parent ID: vSkL.ZFPYIgTFUyC
>     SysFS ID: /devices/pci0000:00/0000:00:01.0/0000:01:00.1
>     SysFS BusID: 0000:01:00.1
>     Hardware Class: sound
>     Model: “nVidia TU104 HD Audio Controller”
>     Vendor: pci 0x10de “nVidia Corporation”
>     Device: pci 0x10f8 “TU104 HD Audio Controller”
>     SubVendor: pci 0x1043 “ASUSTeK Computer Inc.”
>     SubDevice: pci 0x186f
>     Revision: 0xa1
>     Driver: “snd_hda_intel”
>     Driver Modules: “snd_hda_intel”
>     Memory Range: 0x94080000-0x94083fff (rw,non-prefetchable)
>     IRQ: 17 (1698 events)
>     Module Alias: “pci:v000010DEd000010F8sv00001043sd0000186Fbc04sc03i00”
>     Driver Info #0:
>     Driver Status: snd_hda_intel is active
>     Driver Activation Cmd: “modprobe snd_hda_intel”
>     Config Status: cfg=new, avail=yes, need=no, active=unknown
>     Attached to: #13 (PCI bridge)
> 
> 
> If you need any more data, or smth just say so.

To the reporter: It seems like the hardware problem, right? If so, can
you test on different laptop?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=216392

-- 
An old man doll... just what I always wanted! - Clara
