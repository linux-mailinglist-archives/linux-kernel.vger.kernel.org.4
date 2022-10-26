Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3060E168
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiJZNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiJZNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:03:15 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6FDFC18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:03:14 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id s17so10380190qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03y6t+YKs/wRE9nSRW/h4fPn8pJSXetuChZYCPZewYM=;
        b=1Y1bdRE+eiE6mQdxe95Lk+6Hv1d2JaKR5NUToKDRZXvrYWK6O4Uw5OFFIGbzQ7I5OD
         ObDpnBZBSKF3NaYiQNY1tziq8GCcFyQWpoAGL87VRKUlVhg/50BaRJfotFDHYbEQp1Di
         U8SSgoKs5XulJobazggydFC2EHpo2069X1KYPbb6BvwqkBionWf7Twz+QwSzltrycwZW
         nlukW9hqqYDJmPngyphzYQCM7c01bnL3B8/DEkCB4dm0Act0+KGM7rcZHRqF6bf7AloY
         H1o+Yy0xxCanCixgA1sUHARfRPmG7bVXWF3P58PbFO/uCrbdjxFB1J5nZR2kjVHJ2vJ5
         RUSA==
X-Gm-Message-State: ACrzQf22UYh/RiLbj76xZuftR5ycc40AWSMnYjljbjy2EDkd+1RpqI87
        pXEYYpV5N7nUC3b//8LPpub8iBO0ezvguA==
X-Google-Smtp-Source: AMsMyM508/d9srPed/QO+Nbv02x53SeWlPvWqWr0u18PgNYN2UeFCsqTMOi68c0yjQPps2VxwWygRw==
X-Received: by 2002:a37:6084:0:b0:6f7:65e7:23f7 with SMTP id u126-20020a376084000000b006f765e723f7mr5978224qkb.223.1666789393461;
        Wed, 26 Oct 2022 06:03:13 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006eea4b5abcesm3885492qkp.89.2022.10.26.06.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:03:13 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-369426664f9so146167597b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:03:13 -0700 (PDT)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr38941301ywa.384.1666789392975;
 Wed, 26 Oct 2022 06:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221026130051.1577286-1-Jason@zx2c4.com>
In-Reply-To: <20221026130051.1577286-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 15:03:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1733OFFc1P1oGKD5Nef9GyiR0XYL0u+2XhMS5aNAGyA@mail.gmail.com>
Message-ID: <CAMuHMdX1733OFFc1P1oGKD5Nef9GyiR0XYL0u+2XhMS5aNAGyA@mail.gmail.com>
Subject: Re: [PATCH] m68k: mac_via: remove unused rbv_set_video_bpp()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 26, 2022 at 3:01 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> In examining rbv_set_video_bpp()'s improper usage of a non-explictly
> signed char type, it turns out that the function is actually unused. So
> remove it.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.2 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
