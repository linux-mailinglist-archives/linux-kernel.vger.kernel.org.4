Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45506EA53D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjDUHuh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 03:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDUHuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:50:35 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD53C22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:50:27 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54fbee69fc4so14963707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063426; x=1684655426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkpYhZmr123XoZwxeuyT9/faeSkMZw8H0JzS3L2I10s=;
        b=D3hX64S3EYwITsOXQwNJFxsSstdJxzsS0tnaxakW/nhNPL8Yr2l8WEkUZyhleTYFDu
         WEIfQoj0n9gdX8mU2S5I9xjsjvHjHca6tucYGKm6wiMtWrg48ZRL1maLn2uaeexNccl6
         MspixBgDrVWuv6X6sZUGLSr8gjWub1REODlQwmLN4deV5dWdDZ6SCPhH99ruXi+E75i1
         YVbCu0TVGcUpgwgtOHht8OIFpp61t+QIk+DY+4Ho8jrQEr+sU7ZE8gFrsI8T/5pO6HiC
         Tlvw4568ApRFVv4B4h5O9dins7trAU6WSLHLin5Pqj2jhKka8PuM6PtAXlMeI0as7asp
         P95Q==
X-Gm-Message-State: AAQBX9dqD1ZDM0099+1ylpAjSPxeVcI6hfEhZayt/IkoFDEwoaTgE90P
        T40effalXX5oCtGxRjeriA+AIZeGrcARrmGS
X-Google-Smtp-Source: AKy350Y/w0DO54C5nKkt3zj2R/Hz2dfxvDQrvYbPuJlKgLj+3efpTYJhmJXN6/xesvubdEF0ZrgFhg==
X-Received: by 2002:a0d:c206:0:b0:54f:ae60:867e with SMTP id e6-20020a0dc206000000b0054fae60867emr1179964ywd.7.1682063426396;
        Fri, 21 Apr 2023 00:50:26 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id u185-20020a8184c2000000b0054640a352f2sm816356ywf.20.2023.04.21.00.50.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:50:25 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-b991e510fbcso563114276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:50:25 -0700 (PDT)
X-Received: by 2002:a25:4d8:0:b0:b98:c9af:b9c7 with SMTP id
 207-20020a2504d8000000b00b98c9afb9c7mr1724109ybe.26.1682063425192; Fri, 21
 Apr 2023 00:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
In-Reply-To: <20230421-m68k-kexec-include-reboot-v1-1-7552963a0f25@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 09:50:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuV=JmoLoEOL1TfBBmFAMbqOGz0oHn3kz1QN_7s_uObQ@mail.gmail.com>
Message-ID: <CAMuHMdUuV=JmoLoEOL1TfBBmFAMbqOGz0oHn3kz1QN_7s_uObQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: kexec: include reboot.h
To:     Simon Horman <horms@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 9:11 AM Simon Horman <horms@kernel.org> wrote:
> Include reboot.h in machine_kexec.c for declaration of
> machine_crash_shutdown and machine_shutdown.
>
> gcc-12 with W=1 reports:
>
>  arch/m68k/kernel/machine_kexec.c:26:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
>     26 | void machine_shutdown(void)
>        |      ^~~~~~~~~~~~~~~~
>  arch/m68k/kernel/machine_kexec.c:30:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
>     30 | void machine_crash_shutdown(struct pt_regs *regs)
>        |      ^~~~~~~~~~~~~~~~~~~~~~
>
> No functional changes intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.4 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
