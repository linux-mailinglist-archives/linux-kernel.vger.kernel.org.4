Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28676B25F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCINzX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 08:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCINzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:55:00 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BF56177;
        Thu,  9 Mar 2023 05:54:26 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id o3so1441003qvr.1;
        Thu, 09 Mar 2023 05:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOWEd+TQYThqGxUlQtcX5WNVUCTIKBkMv4b+L1Yl+U=;
        b=DE9l+/c5M0ltSF9JlR25MckadBC6KAFPht2NnNw7wLZ5il3B1N9Ai/90HLeFJ3aGbB
         AswIYaGlww9/B6GuEnfteczwlNs8v9R70jGHM94lEHShYRiVn8U/vl1DXmVvoKuzOEQv
         HU1hoFPyAgYtrWMlHkC+/Q42/3kSKthmfbK53/xEQiRUVkCKA4UH2AXqc1iKu4G4bVm0
         7LVZPzkkbRFghUyBYcnwMyMF29l/8nP1D+bx48slkvgS6urId5lZ1EnaUkoqJufpWl1V
         dOfZYxjHdjdmiU0iw5D7EexpApvlWrZ53uznf+9fcS38eJCI1SIu4ynMrvuX9bjGLg2Y
         IFdw==
X-Gm-Message-State: AO0yUKUv2NVy/G3dStUhS+UyCGX2KJFWBnmqyKxB/pduuUB0l+QJRhsx
        jPLVMOaWPb4dkcK5pvjDbGGDdcGTAg+rnA==
X-Google-Smtp-Source: AK7set8mRKKrW2Ok+1dgeXyegGnPcm3RxMyKEoNLg7tq1RkKBSvu+T6Lf5CQfIFLdAHeJ6bnNO/WvA==
X-Received: by 2002:a05:6214:23c9:b0:56f:47f:bbe3 with SMTP id hr9-20020a05621423c900b0056f047fbbe3mr36615925qvb.4.1678370062961;
        Thu, 09 Mar 2023 05:54:22 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id p188-20020a3742c5000000b006fed58fc1a3sm13555380qka.119.2023.03.09.05.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 05:54:21 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-536cb25982eso35682117b3.13;
        Thu, 09 Mar 2023 05:54:20 -0800 (PST)
X-Received: by 2002:a81:ae1d:0:b0:52f:23f5:4079 with SMTP id
 m29-20020a81ae1d000000b0052f23f54079mr14283619ywh.4.1678370060445; Thu, 09
 Mar 2023 05:54:20 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com>
In-Reply-To: <CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Mar 2023 14:54:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHQUiYfhLibRq8G=yStxGvWD8Y=WBBrGHGX5PQZ_pq7w@mail.gmail.com>
Message-ID: <CAMuHMdXHQUiYfhLibRq8G=yStxGvWD8Y=WBBrGHGX5PQZ_pq7w@mail.gmail.com>
Subject: Re: sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of
 undefined type 'struct gpio_chip'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Thu, Mar 9, 2023 at 12:50 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> Following build error reported on sh shx3_defconfig on Linux next-20230309
> and started from next-20230307.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> --------
> arch/sh/boards/mach-x3proto/setup.c: In function 'x3proto_devices_setup':
> arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of
> undefined type 'struct gpio_chip'
>   246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
>       |                                                              ^
> make[3]: *** [scripts/Makefile.build:252:
> arch/sh/boards/mach-x3proto/setup.o] Error 1
> make[3]: Target 'arch/sh/boards/mach-x3proto/' not remade because of errors.
> make[2]: *** [scripts/Makefile.build:494: arch/sh/boards/mach-x3proto] Error 2

Thanks, I've bisected, and sent a fix
https://lore.kernel.org/r/20230309135255.3861308-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
