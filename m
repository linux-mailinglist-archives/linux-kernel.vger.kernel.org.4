Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4C6A27E8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBYIho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYIhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:37:42 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D781716E;
        Sat, 25 Feb 2023 00:37:40 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5384ff97993so43147117b3.2;
        Sat, 25 Feb 2023 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz98R7Ca78KCbduT2+9H7VwReVgB2OnNZzHlXdg3vPg=;
        b=LslJvRDEXLo8YVQdMr+NYNiAU+2KWc+5HoLP4elf+87SnngnzsWjSRG3ZP1v2tH1Vc
         ddgHtrk8mJCTJzMgbZ2BDxvt3sY5a75hxfx3qcqc/1WEUGJvZbYJnpDRFoeR2DEKm0L5
         Tzb+OfXPYDgsLg2+4/K3Hz2vWBFMJ3LHj2ND+65Q6g+uSnn2eYN0Swb/k6kYCnON/D8Y
         cW+cZyRn+cEVHWBsxQZQrYbsva1lI9AhJN6C6aB9wLPgdBtBNIXxMdcfdhONhY5HkI8X
         pgDjKPr6YL6jopKLbCsYCzj0yxEY9juoLF/FG8v21O/vhddsBND+QmTbxxW3hvPz5tVl
         3pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz98R7Ca78KCbduT2+9H7VwReVgB2OnNZzHlXdg3vPg=;
        b=YtDqLYbArzpxmilnDUGqV2nNqWxn/eTeST/rouEbR6rhEPfAQyLxLxQrjR74JRUOPX
         2YYmJuHnHqu67+E4am0h2XeQ1Lt4IJOGOx2oydOuuNS7vSt1vSUsQidmEsrrLRfK5eoS
         6otoGcbmze358fpRBtKoOh6Hn6/cIePDFoClJobNQuHWZqNb7UaSjrsyrbKlKVb5auBn
         cquTbJZ7mfgX2idQLniqTwAv/aaKLHpbn8pFdcEVMnf6iuEl/NzMRrPGjj8zqcBGqN/u
         D+ThPcZ8Ti+I0VC2zjOxD8IMvmkcnzXEcqRIx2hqQwnLgbWW6ZduhKGpzTIbbCmIcYBe
         JrnQ==
X-Gm-Message-State: AO0yUKX/8WvVwGQroZdVdbdQ5TicV36GBOGG/UAq49EyXymjZ1ThIzZJ
        CmXzD/zs3cFncFzr97XZ9l4PDtGIRGRzlQT9i1E=
X-Google-Smtp-Source: AK7set+hqtmF+D+rwbu85iQ+EPP3JZXUmywWfrmNyRB+ZMfHnjDwseewKGZ/t0grf+BbEU4WY0+ueRg+zQ4rY2MteRw=
X-Received: by 2002:a81:af50:0:b0:533:9ffb:cb12 with SMTP id
 x16-20020a81af50000000b005339ffbcb12mr6270206ywj.10.1677314260110; Sat, 25
 Feb 2023 00:37:40 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72nfGfqnk4QyKsf3kmjgBVPG3WFLQqd7_+jLcYh9jG+fQw@mail.gmail.com>
 <mhng-b792c358-a678-4ab3-aba4-4bc38da55744@palmer-ri-x1c9a>
In-Reply-To: <mhng-b792c358-a678-4ab3-aba4-4bc38da55744@palmer-ri-x1c9a>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 25 Feb 2023 09:37:29 +0100
Message-ID: <CANiq72ndkF0JM1kV=ewnO4uGirDowHDGLkhvjQgtLnuPEk_hTQ@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: enable rust
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 12:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> Works for me.
>
> I've got a few other things in the pipeline for this merge window so
> this probably won't make it, but I'll dig in after that.  We've got a
> bunch of Rust-types floating around Rivos as well, so with any luck
> someone else will have some time to poke around.  Having a full cycle in
> linux-next is probably the right way to go for this sort of thing
> anyway, as it's likely to shake out some long-tail issues.

Thanks a lot! That would be great.

At least from our side, no rush. In fact, we are letting users (or
arch maintainers) to request/submit the architectures themselves as
they need/want them.

Cheers,
Miguel
