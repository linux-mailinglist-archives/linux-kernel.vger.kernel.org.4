Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94DF631D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKUJu1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKUJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:49:53 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D521BE;
        Mon, 21 Nov 2022 01:49:52 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id 8so7646541qka.1;
        Mon, 21 Nov 2022 01:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0R1vOZGcAf8Lvk2UJS4/+BOsl0EtdkISIAg53t67S3g=;
        b=QmQHUSodWT2s3q2lKWJDwFeJ2PCF5mlYmPQR2JOPTth4WJsgKmiy8eJRqmgiht/3Ez
         fBjtQYW189vr+CCIXKvcQ1l2d+XvpDW3kWRS6CdHehMQ3yMrbxbNosKRPLiY5HF2gVBx
         YwsoPzFFkSJ2gZfzIryELraJfPNn3yV2w5FaRNdyeGj+3JLKB6mvXXbjH6UsNY9BzjHd
         RIR73UMVoOgcM1SeX2Lz/MyZrYuK2IA9HtU+HAPR2ANKbWbzq4Mb20NvL7ShGR5X/H/8
         QAP7AmlfAhEyJuaJxXwTUYAHK3JVbxynTNklFkJ0nXwp7o2MqSXEOW/dP1pyLHhXQgKJ
         gP2w==
X-Gm-Message-State: ANoB5pnN02wW9T5w7dX3mDH8JJSLB0VZ2ZZen3cx0d/KGAdbLH/Wbz1y
        JrgLSdvTjyDv5ZvIpssIFApwgfWjos5q+A==
X-Google-Smtp-Source: AA0mqf7SU5Pv90/JOgltt564LKXgrFtJCacA3C0FstQkxkhyYbSwPGtn2pVbvS2+usdYNyroSM7BEw==
X-Received: by 2002:a05:620a:ce7:b0:6f8:3f8f:e629 with SMTP id c7-20020a05620a0ce700b006f83f8fe629mr15002439qkj.684.1669024191610;
        Mon, 21 Nov 2022 01:49:51 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003a50c9993e1sm6393056qtm.16.2022.11.21.01.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:49:50 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id y83so4837604yby.6;
        Mon, 21 Nov 2022 01:49:50 -0800 (PST)
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr15801367yba.543.1669024189748; Mon, 21
 Nov 2022 01:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-4-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-4-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:49:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRZQbZH45KCB0ntmdKiACZ7m=V=dkv6hdLCzHqiq0fyA@mail.gmail.com>
Message-ID: <CAMuHMdXRZQbZH45KCB0ntmdKiACZ7m=V=dkv6hdLCzHqiq0fyA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] serial: liteuart: remove unused uart_ops stubs
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

On Fri, Nov 18, 2022 at 3:55 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Remove stub uart_ops methods that are not called unconditionally
> from serial_core.
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
