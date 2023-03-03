Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3436A9F78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjCCSqi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 13:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjCCSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:46:29 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE6E39B;
        Fri,  3 Mar 2023 10:46:06 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id cf14so3906380qtb.10;
        Fri, 03 Mar 2023 10:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677869146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWmPtqpsfnXhGWlFwwoAcJ6STy2NAdkcAIAhL++JN5U=;
        b=spDHLcCwwSe1Wj1WmG2+4kZEXI3SqklkLiOINIC+alL218SYyuWsvG4Ra1zzuTDskk
         2DPQA+5+IFLr4yThZyck+AVrCbRj/oQfPv/O5LDAAxNOwhTZC91Pv/fv+RTU9SmBNeN0
         GNYSkmkRG32WL4Zv1fjl1jf9qi8kDGog3tvzIVWvHcq2aHf+39LIcNDB2McVzc8GTGcg
         zSBaJdLfc4z8d9nBCMYkhQXQsLVqhXVWuDZB22T89JYhPJMRE/8ocK6rzH1i2lqGt/ma
         CNySyQP36Jex1Q6t81pt3qOblkuPuTMurwckCjW93EewpLFDN7LrQdTSJpUA+41BG7Yp
         /qow==
X-Gm-Message-State: AO0yUKW7Kq+iqGbJrUV3mPNrr/lYXmfL+QwjEmevTZdwFuUNoEWI8Avw
        o6fmRLKpwvnzr3NWLy/m6wQhp3uCuI+c1g==
X-Google-Smtp-Source: AK7set+mNN4iAyuZpTx2s7L4+5n5PCoBZG/lfUo+nTBkjK9RAJtyn20c5jrYOre4M8GC5x6eXAynPQ==
X-Received: by 2002:a05:622a:1992:b0:3bf:e408:6c91 with SMTP id u18-20020a05622a199200b003bfe4086c91mr5114286qtc.51.1677869145863;
        Fri, 03 Mar 2023 10:45:45 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b007426ec97253sm2165893qkb.111.2023.03.03.10.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:45:45 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id k23so2826596ybk.13;
        Fri, 03 Mar 2023 10:45:45 -0800 (PST)
X-Received: by 2002:a05:6902:208:b0:acd:7374:f154 with SMTP id
 j8-20020a056902020800b00acd7374f154mr1526090ybs.7.1677869144942; Fri, 03 Mar
 2023 10:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20230303182922.3903229-1-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20230303182922.3903229-1-kumaravel.thiagarajan@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Mar 2023 19:45:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvwGzyDTUA=E5=pvGhR4xaBj75OkeU7jr651j6B7kBzA@mail.gmail.com>
Message-ID: <CAMuHMdXvwGzyDTUA=E5=pvGhR4xaBj75OkeU7jr651j6B7kBzA@mail.gmail.com>
Subject: Re: [PATCH v1 tty-next] serial: 8250_pci1xxxx: Disable
 SERIAL_8250_PCI1XXXX config by default
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        geert+renesas@glider.be, matthew.gerlach@linux.intel.com,
        phil.edworthy@renesas.com, UNGLinuxDriver@microchip.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 7:29 PM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
> Commit 32bb477fa7bf ("serial: 8250_pci1xxxx: Add driver for quad-uart
> support") made the SERIAL_8250_PCI1XXXX driver enabled when SERIAL_8250
> is enabled, disable it as this driver need not be enabled by default

does not need to be enabled

>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/lkml/CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com/
> Fixes: 32bb477fa7bf ("serial: 8250_pci1xxxx: Add driver for quad-uart support")
>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> v0 -> v1:
> - Add proper commit description

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
