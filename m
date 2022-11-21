Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A49631E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiKUKRr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKUKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:17:43 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61212092;
        Mon, 21 Nov 2022 02:17:38 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id z1so7660966qkl.9;
        Mon, 21 Nov 2022 02:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tQj4S/iKIQ/NxULtK0zpJiAfSFXnwF4EZ6vKDJSo1c=;
        b=zoGNBwM/YDAMXWIK81MYYAZXQcZnvEH2FuwmKHJwJNjqB+PZ9Dhrov+nnyPYxZ7Gz5
         XS5/f5EO/dO9kNxSYiqdWKs1cdT5M8A0BWm1i1sjyR4BFV7n0CaNpoERNu8Cha8JJLmG
         /KlSGrCH3Mo/fNRm1ICu6p+1YjV7mgpppIqfIJz0mE8sk759kbb+8sGRRg3cFnKsTZN5
         frrBK0LFehZ/UlwM4XwPUdv+fnF38ifeuGqsf323LnZaAI0AaSTomq2xuwtjEXI86ogA
         x0dzayoRXfEZtMxisJlbAJFQEYnWlwpfn7pG8Ro1jV9qSRndAN3EzwyAsqL5OavsHt5C
         i75Q==
X-Gm-Message-State: ANoB5pmnLmP1Qnpq3UFvxrDQm7j6XluSyS6CWzEH/hi/rEGUXvdop6ET
        dYdSCX8NwBUf9VVdVDkMZoyHnjSvlzv3lw==
X-Google-Smtp-Source: AA0mqf5l4AJkTy0W/0OcWNgEjluONw7Za4RGqHuQh0vlTjC8jdvvZIgy/aWrByZjViE9vuaabUHyIg==
X-Received: by 2002:a05:620a:8081:b0:6fa:19c4:a6c7 with SMTP id ef1-20020a05620a808100b006fa19c4a6c7mr7476018qkb.51.1669025857664;
        Mon, 21 Nov 2022 02:17:37 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id fx9-20020a05622a4ac900b0039a610a04b1sm6505153qtb.37.2022.11.21.02.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:17:37 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id f201so13005261yba.12;
        Mon, 21 Nov 2022 02:17:36 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr16441811ybp.202.1669025856529; Mon, 21
 Nov 2022 02:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-12-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-12-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 11:17:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKEOZXdZx3i+546DUAXt9DYD87BxKC3XN9XUomLMN5hg@mail.gmail.com>
Message-ID: <CAMuHMdXKEOZXdZx3i+546DUAXt9DYD87BxKC3XN9XUomLMN5hg@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] serial: liteuart: move function definitions
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:57 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Move definitions for liteuart_[stop|start]_tx(), liteuart_stop_rx(),
> and liteuart_putchar() to a more convenient location in preparation
> for adding IRQ support. This patch contains no functional changes.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
