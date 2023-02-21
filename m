Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE669DB72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjBUHuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:50:17 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967631C7FF;
        Mon, 20 Feb 2023 23:50:16 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id y3so3818614qvn.4;
        Mon, 20 Feb 2023 23:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72BbxXH9r6ZaV+Z3o0wggC7oh2JqeBASrvlOQHb29P8=;
        b=kXp8LcGpgDqRoQEEPzlMqENl0VKJRiLPvrD6WNuila+R9wRsfe8haPGT6//rNXvn8j
         JfAUIVrOSyThgjirX/cdKfKm8XPQp0+Igiwl1ybiU1ThEGzb42U17CHInSlR0SUxz6eK
         rdi2BOI/MX4/hBbC3hYAxwYpJf7JtBmdEmDPKkNmqI5X0T6xWjGoQJBe8PMjyj5iDRYS
         mZJ5oayXZKxmGDkjoFvMce7YCn7sDl4AodZoD1M8Cb5h88wYVQVBbqsGQXdv1kFpTdQR
         gAJwaG9gBqtTJoqzNcsKSzXoKMxBArMUffINIcHQAUJV33VAU7CZkDXEYE2JxOY6dbkI
         z/KA==
X-Gm-Message-State: AO0yUKUjCmHpVsIF44eTJLLn+5gKoiWu4H3+QSIUc+MseRJquzWIlXIB
        sKjtxX26ZjvcTNodsARYFH3AFb3cqZq56Q==
X-Google-Smtp-Source: AK7set/M897JumuS5a49usxHVIHjusAqEICwTJdwt3boOOrlIgsRSGA2KBeB+O2fOlCcphUwhFNkeg==
X-Received: by 2002:a05:6214:2021:b0:56f:8a99:1a82 with SMTP id 1-20020a056214202100b0056f8a991a82mr7314494qvf.27.1676965815442;
        Mon, 20 Feb 2023 23:50:15 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r196-20020a37a8cd000000b00729a26e836esm7940309qke.84.2023.02.20.23.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 23:50:14 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id i7so4292264ybu.6;
        Mon, 20 Feb 2023 23:50:14 -0800 (PST)
X-Received: by 2002:a05:6902:2d0:b0:920:2b79:84b4 with SMTP id
 w16-20020a05690202d000b009202b7984b4mr1006883ybh.386.1676965814482; Mon, 20
 Feb 2023 23:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20230221031004.18910-1-rdunlap@infradead.org>
In-Reply-To: <20230221031004.18910-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 08:50:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcEL7vkiH8wTOH1R6vvyce9MXVg3X52UzB5sXj4RydJA@mail.gmail.com>
Message-ID: <CAMuHMdVcEL7vkiH8wTOH1R6vvyce9MXVg3X52UzB5sXj4RydJA@mail.gmail.com>
Subject: Re: [PATCH] sh: SH2007: drop the bad URL info
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 4:10 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> This URL provided is no longer functional, so drop it.
>
> Fixes: 3a598264436e ("sh: SH-2007 board support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
