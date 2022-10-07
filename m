Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC05F756B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJGInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJGInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:43:09 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B8A4B93
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:43:08 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 126so4330012vsi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wRN9Yv2CfNxcf9YBqx89gFKM99uDrGF0BzMeFd+YFU=;
        b=RC4QKAxEKz4CTRbnr2wi1YEIbcXXzvIs++ooUV0OXRGR9jX6ETreM5yyblTbOATPFl
         scH8L0JgjTL6qJXBGXDNlZqNhssTLF6yGtVwP3EvnrOSSVmeFAyUhcbBTUSeeQQZxnEk
         nDumFDgu7ISQiHdHcpJhNPnfuK0z8nSIKewSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wRN9Yv2CfNxcf9YBqx89gFKM99uDrGF0BzMeFd+YFU=;
        b=eZBEZO+MKl0xYn5gWJlaJW6ha0nonGwFSLruet+wlrZUv5Df+IA3LJZ8FtIoQpj3HZ
         uUQEAK+cpoCtyyg+JQwjGKje2M5GlI06ODi5hhAS8SesI3UIGQt7zFQMEYm/rjxH4gqO
         2iXiyLy5YFl2IcGkpS5pnIaM5AN64o1ZuGxAewmzTiPmNBQQNwSjg/wMf/Kt9UfBLotY
         eHe9GKKRqJdz3UBg6cKr1AmXNqFQ0+MtyivCk83/HBb2zfw6FRtJiuIvxN+noN3ldz4M
         CnxsnU95kI+2OZ6IT6YlCL+k5NR0Dds/4Uv2nMAeIreOiQgO8e3+yMhEOyTJdQqUn2R7
         Y/mg==
X-Gm-Message-State: ACrzQf3PIQ+4C3LNKH/HRdm705vBDxTGLPNM3KhRsPOhuX6vN4nkGT48
        2NNDGC4e+PczGljk5ppREpEWzJbBIFnbDNb63NXdWQ==
X-Google-Smtp-Source: AMsMyM5T2pR3gJ6oy1XnmNARB6l9+7aO3arQUP8stoBiyG9epg+dwG5j2SQGcmkRKHxu2I0GuhcX1JiF0CFNH357KNs=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr1999587vse.9.1665132187627; Fri, 07 Oct
 2022 01:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220922094908.41623-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Oct 2022 16:42:56 +0800
Message-ID: <CAGXv+5EzD_CvZHv_HOd4cRB_3qzUDUYwvOBN1qkkdP4ygo862w@mail.gmail.com>
Subject: Re: [PATCH 0/4] MT8195 Acer Tomato - Audio support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 5:49 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series enables full support for audio, with DSP, on the Cherry
> Chromebooks.
> Related ALSA UCM2 configuration was already merged in its upstream
> repository [1]: this is fully tested and working as-is since all of
> the required fixes for MT8195 SOF drivers were picked and are present
> since `next-20220908`.
>
> [1]: https://github.com/alsa-project/alsa-ucm-conf/commit/a59c3b1a57de8eb424c4f754bb031265e856260e

While trying this patch, I get the following error:

# modprobe mt8195-mt6359
[   44.985107] mt6359-sound mt6359-sound: ASoC: sink widget AIF1TX overwritten
[   44.994393] dmic-codec dmic-codec: GPIO lookup for consumer dmicen
[   45.000636] dmic-codec dmic-codec: using device tree for GPIO lookup
[   45.007165] of_get_named_gpiod_flags: can't parse 'dmicen-gpios'
property of node '/dmic-codec[0]'
[   45.016177] of_get_named_gpiod_flags: can't parse 'dmicen-gpio'
property of node '/dmic-codec[0]'
[   45.025084] dmic-codec dmic-codec: using lookup tables for GPIO lookup
[   45.031666] dmic-codec dmic-codec: No GPIO consumer dmicen found
[   45.041434] sof-audio-of-mt8195 10803000.dsp: Topology: ABI 3:22:1
Kernel ABI 3:23:0
[   45.050185] mt8195_mt6359 mt8195-sound: ASoC: Parent card not yet
available, widget card binding deferred
[   45.060566] sof-audio-of-mt8195 10803000.dsp: ipc tx error for
0x30010000 (msg/reply size: 96/20): -22
[   45.069965] sof-audio-of-mt8195 10803000.dsp: Failed to setup widget AFE3.IN
[   45.077575] sof-audio-of-mt8195 10803000.dsp: error: tplg component
load failed -22
[   45.085291] sof-audio-of-mt8195 10803000.dsp: error: failed to load
DSP topology -22
[   45.093062] sof-audio-of-mt8195 10803000.dsp: ASoC: error at
snd_soc_component_probe on 10803000.dsp: -22
[   45.102880] mt8195_mt6359 mt8195-sound: ASoC: failed to instantiate card -22
[   45.123915] mt8195_mt6359: probe of mt8195-sound failed with error -22

Any ideas?
