Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DF6601DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjAFOO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjAFOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:14:38 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203C7817A;
        Fri,  6 Jan 2023 06:14:37 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id x11so1996603qtv.13;
        Fri, 06 Jan 2023 06:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zv1Rgmsb1MJ9Jrpa6ymGv5F7lWDhY6tjyOu+VskdE1o=;
        b=UtgUN55GXNoQhQ5Rch0gY9gXHyVgrxCD12YvhsC8bYAqgXLFguFA0nLUvbGaxKJXaP
         QtDGOthLmQoapSBmrqhFuw6aoY2Fpttr50N/enFWjScINYh69qMXhWFmWWCVwkwZfnon
         BW2Sj+zCX0eppbZtWls8fSeQKp+P9ZzRSczdTJ23vudsl17ajYxJ7tPs/GTPq46Wnfn2
         JJ8TroE8WITPapRbfwnD1EZujMV/AACHv7mSSQR7Of/weBf/SNo6cuviwBk6CHqQg3JO
         Wrf6ap4cI0dWIuYeBtJHRwRWUhhFgIUgf3d90Gb2b7NSw9dB5tBn093K0STODjS02kRc
         DEiQ==
X-Gm-Message-State: AFqh2krcm10oQPe5MH0/9QENTo0D02OeuHO7L04AQDUu+GuQT/TlFHpN
        1QCb2j2Eh+4oEgq2jysL4eSW7HEq//Fp7w==
X-Google-Smtp-Source: AMrXdXvuLokb9HcUzopl0gzK7L1DrLP+QGQAunNJCIL4Z3ZWpAsvjYV84LGqmiWsQpoRneQLKHtIdA==
X-Received: by 2002:ac8:748f:0:b0:3a5:1001:2057 with SMTP id v15-20020ac8748f000000b003a510012057mr81153129qtq.30.1673014475888;
        Fri, 06 Jan 2023 06:14:35 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a240c00b006fcc3858044sm572335qkn.86.2023.01.06.06.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:14:35 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id e76so1936858ybh.11;
        Fri, 06 Jan 2023 06:14:35 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr3571099ybx.202.1673014475415; Fri, 06
 Jan 2023 06:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <20230104141245.8407-3-aford173@gmail.com>
In-Reply-To: <20230104141245.8407-3-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jan 2023 15:14:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUECsuW2BC_AxjBpvqEfLF3wpk6xXnrma=--s65vX99_g@mail.gmail.com>
Message-ID: <CAMuHMdUECsuW2BC_AxjBpvqEfLF3wpk6xXnrma=--s65vX99_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r8a774[a/b/e]1-beacon: Update
 corporate name
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

CC GregKH

On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> At the end of 2021, Beacon EmbeddedWorks was sold off from Compass.
> Its legal name is now 'Logic PD, Inc. dba Beacon EmbeddedWorks" and
> as far as I know Compass Electronics doesn't exist anymore.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright 2020, Compass Electronics Group, LLC
> + * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks

IANAL, but I don't think this change is appropriate: the copyright date
is 2020, which is the year when the file was created, and the copyright
owner at that time was Compass.  The current copyright owner is the
current owner of the assets of Compass, which may change again in
the future.

I'm also not aware of people changing copyright headers for code owned
by now defunct companies, see the existence of code still copyrighted
by e.g. Motorola Inc., Digital Equipment Corporation, and Compaq
Computer Corporation.

If/when you make (substantial) changes to these files, you can add a
"Copyright 2023, Logic PD, Inc. dba Beacon EmbeddedWorks" line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
