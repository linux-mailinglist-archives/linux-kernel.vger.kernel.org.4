Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8574D567
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGJM30 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJM3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:29:25 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57063B1;
        Mon, 10 Jul 2023 05:29:24 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-57a4a476bbfso48946707b3.2;
        Mon, 10 Jul 2023 05:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992163; x=1691584163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or6rkwZciDsGs8AiN7LjUfjmq1Ctoaqk6zMA59vRMOg=;
        b=CYdSyYRdRR0In0lITNa3S5QLixZ5gKFLx0HmAQ4re1HA1xHHQDy9xrnYD77mH7u1on
         YkD3hiSTe6nsilLscJegvgRNvZXDM2K9EtNWQ4Q2Q4YFZoAOaatCsW+ZCqWp1pfz8SdH
         BPVWsSCzTPXrfj/VeSi48LezdNXHERaMXJLm7YvnD/4URjEy6gLrWBFfu+4Xsa8EKCdk
         mBU5tasOB2Ick87xancqUl5uY0xKNfNIj3B1ydW2w6PY1RP9CI21JAU4Qnp7KWTpl2xX
         1Yec6hFGFKrFeg2NKnhOHin1VNcVVGjoJ+yU6+DFD5f22CwJSs3Mqpy03lqulVqCyV9V
         yEjw==
X-Gm-Message-State: ABy/qLYbCp71ImrbqFi16NOkqrGwLkAQoNr22cB/IWfgTLonfhjSUbf/
        rXcOgx2kB+ZR78HVyJqM4t/7Qha5PG2xtw==
X-Google-Smtp-Source: APBJJlFrWUCqHQ1xzy0QHUf4v/CguahtRTvSB2Llw6Kx+lGuhu7TBujPCdUedy9k9JxqlrNpJuK4tg==
X-Received: by 2002:a81:5a08:0:b0:565:3749:c24d with SMTP id o8-20020a815a08000000b005653749c24dmr12827396ywb.14.1688992163416;
        Mon, 10 Jul 2023 05:29:23 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i194-20020a816dcb000000b0057726fce046sm2985593ywc.26.2023.07.10.05.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:29:23 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso4001061276.1;
        Mon, 10 Jul 2023 05:29:23 -0700 (PDT)
X-Received: by 2002:a25:a063:0:b0:c83:27d4:c0d6 with SMTP id
 x90-20020a25a063000000b00c8327d4c0d6mr2502200ybh.37.1688992162968; Mon, 10
 Jul 2023 05:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230710024550.59544-1-frank.li@vivo.com> <20230710024550.59544-6-frank.li@vivo.com>
In-Reply-To: <20230710024550.59544-6-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 14:29:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7GGPW2a57a9xme5bi56gOX79e7VRvbCJKNck+Bbiofg@mail.gmail.com>
Message-ID: <CAMuHMdX7GGPW2a57a9xme5bi56gOX79e7VRvbCJKNck+Bbiofg@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] ata: sata_rcar: Remove unnecessary return value check
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
> As commit ce753ad1549c ("platform: finally disallow IRQ0 in
> platform_get_irq() and its ilk") says, there is no need to
> check if the platform_get_irq return value is 0. Let's remove it.
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
