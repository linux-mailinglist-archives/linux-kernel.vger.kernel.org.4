Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592264CE38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbiLNQjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiLNQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:39:13 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D225FD4;
        Wed, 14 Dec 2022 08:39:11 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id o127so370396yba.5;
        Wed, 14 Dec 2022 08:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rucNSLUsydWgfk/P8pUCnWpatC2o+4115FIoshrngFc=;
        b=CZTuvD9Dyj0DMxl/nxGYoaeOU1cFsARxlgi82QVVa26dnVoTZvvRM4MX4HKqA4gzrK
         0ueg2J04svT+fMBmoOen9p2H7x9icRhLh8xV8p/+L/TvazZjvJg980MPAFpoGoy6G0Sy
         9VM0LbX44qSfFjHBpHUnHo+ngeFvju3rbTJi53hAnpwEjMNO6ovDALkEAg//yY8Dajbx
         RCJ8j9ePvcv4JnxkSTPhhl0gHz79j6c/wzpJa9xl2pJpEqgHsMbcKU3LCa9e44hUq13Q
         mIRpQahgGrIRgZsjd5z58gKnHen/2yiSMqsTBSh7FiETrz8a2QF4AlJu4336XNhcOMQg
         YYCQ==
X-Gm-Message-State: ANoB5pmE8IMjBsxXrTG56dW1EKw780NKz75knlmEYt7crBd8Q0rx0MYz
        Pk0y4SKqGZ0Ym9E8nJGW8PnKNN6RbqBCkA==
X-Google-Smtp-Source: AA0mqf7VPTWBaHcttjYxRxqaNMd/24mmAEzw/R0+Ax4d1dlss3jJbdGri+G8eyTpsT3e9jiCW364ZQ==
X-Received: by 2002:a25:2681:0:b0:724:2eb3:2 with SMTP id m123-20020a252681000000b007242eb30002mr13598245ybm.1.1671035949963;
        Wed, 14 Dec 2022 08:39:09 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006feea093006sm10329318qko.124.2022.12.14.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:39:09 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3b48b139b46so4006837b3.12;
        Wed, 14 Dec 2022 08:39:09 -0800 (PST)
X-Received: by 2002:a81:a8a:0:b0:37e:6806:a5f9 with SMTP id
 132-20020a810a8a000000b0037e6806a5f9mr12549148ywk.47.1671035949256; Wed, 14
 Dec 2022 08:39:09 -0800 (PST)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Dec 2022 17:38:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpPX2mpqFEWjjbjsQvDBQOXyjjdpKnQu9qURAuVZXmMw@mail.gmail.com>
Message-ID: <CAMuHMdWpPX2mpqFEWjjbjsQvDBQOXyjjdpKnQu9qURAuVZXmMw@mail.gmail.com>
Subject: media: imx-jpeg: array subscript 2 is above array bounds (was: Re:
 kisskb: FAILED linus/m68k-allmodconfig/m68k-gcc8 Wed Dec 14, 11:09)
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 1:16 AM <noreply@ellerman.id.au> wrote:
> FAILED linus/m68k-allmodconfig/m68k-gcc8 Wed Dec 14, 11:09
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/14846569/
>
> Commit:   Merge tag 'drm-next-2022-12-13' of git://anongit.freedesktop.org/drm/drm
>           a594533df0f6ca391da003f43d53b336a2d23ffa
> Compiler: m68k-linux-gcc (GCC) 8.5.0 / GNU ld (GNU Binutils) 2.36.1
>
> Possible errors
> ---------------
>
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 2 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]
> drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c:641:28: error: array subscript 3 is above array bounds of 'u32[2]' {aka 'unsigned int[2]'} [-Werror=array-bounds]
> cc1: all warnings being treated as errors
> make[7]: *** [scripts/Makefile.build:250: drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.o] Error 1
> make[6]: *** [scripts/Makefile.build:502: drivers/media/platform/nxp/imx-jpeg] Error 2
> make[5]: *** [scripts/Makefile.build:502: drivers/media/platform/nxp] Error 2
> make[4]: *** [scripts/Makefile.build:502: drivers/media/platform] Error 2
> make[3]: *** [scripts/Makefile.build:502: drivers/media] Error 2
> make[2]: *** [scripts/Makefile.build:502: drivers] Error 2
> make[1]: *** [Makefile:1994: .] Error 2
> make: *** [Makefile:231: __sub-make] Error 2
>
> No warnings found in log.

I am seeing the same with m68k/allmodconfig and gcc version 9.4.0
(Ubuntu 9.4.0-1ubuntu1~20.04).

It is triggered by the second call to mxc_jpeg_get_plane_size()
in mxc_jpeg_dec_irq():

                if (q_data->fmt->mem_planes == 2) {
                        payload = mxc_jpeg_get_plane_size(q_data, 1);
                        vb2_set_plane_payload(&dst_buf->vb2_buf, 1, payload);
                }

However, I am not seeing the issue with x86-64/allmodconfig and gcc
version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1).

Bisected to commit ccc9f1db9c6b0620 ("media: imx-jpeg: Support
contiguous and non contiguous format").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
