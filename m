Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9A74D564
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGJM2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:28:48 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD18B1;
        Mon, 10 Jul 2023 05:28:46 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-579de633419so49838557b3.3;
        Mon, 10 Jul 2023 05:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992125; x=1691584125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT9CKdoaGzp+O12vl3GuigdiF8zJ9pYS+HKgANR0KzU=;
        b=TPfMAC0NDY5yXle1ZFfO7jGh+5HBt2DgxBrWTsnPLzSIVuFet4i2tt1X9X5EpQcbzN
         1gKzzzji3fdoXemDhqaGApm1cISpWU4kaerbiOp+FC/HxqcjCnQMEuWLJnzw41OlrSsb
         f2LIFxrwRrK468JFDHUoxIOU4XE5yvDP77Lhro+/y5aUOyIu3/Y5Fw6a9zOg9261fUj+
         h5Mj3wzUYg2v1gvcPmXG/an8SrBkX6uW1n4B+HauJcojcBvxG7vV/ydb1GWXTbnbCMzN
         OIrMSGaKekzgiPshz+N8cc17V8ui7d8JKQL2EZPvgI4cBTjhr154dTA+KZ+ub3hqC7tV
         xP4A==
X-Gm-Message-State: ABy/qLa0Xgrb11Dz2sPPk49QZb6vBUCWcJlb6R27ygCqzbpdX2IAsu3Y
        PzFvQHtB1B6cypG7yZxeXHncYMGk3Q2ing==
X-Google-Smtp-Source: APBJJlFmyUDslYw4bsisARYLp9dhoGFNYdphCyVP2HVXRku7labrNNjh+lZcfMjqoIQ+Za7op5jivg==
X-Received: by 2002:a81:d554:0:b0:570:899f:3a52 with SMTP id l20-20020a81d554000000b00570899f3a52mr11482022ywj.35.1688992125440;
        Mon, 10 Jul 2023 05:28:45 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s185-20020a0de9c2000000b0056d2a19ad91sm3005837ywe.103.2023.07.10.05.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:28:44 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso4000294276.1;
        Mon, 10 Jul 2023 05:28:44 -0700 (PDT)
X-Received: by 2002:a5b:90:0:b0:c8f:cf3e:20c4 with SMTP id b16-20020a5b0090000000b00c8fcf3e20c4mr453872ybp.52.1688992124098;
 Mon, 10 Jul 2023 05:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230710024550.59544-1-frank.li@vivo.com> <20230710024550.59544-5-frank.li@vivo.com>
In-Reply-To: <20230710024550.59544-5-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:28:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVajhN1LhmkTNDNMHO=nCEWQNt91+tgsTz6yBnu4KXd7g@mail.gmail.com>
Message-ID: <CAMuHMdVajhN1LhmkTNDNMHO=nCEWQNt91+tgsTz6yBnu4KXd7g@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] ata: sata_rcar: drop useless initializer
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
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

On Mon, Jul 10, 2023 at 4:47 AM Yangtao Li <frank.li@vivo.com> wrote:
> There is no need to initialize the variable ret.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
