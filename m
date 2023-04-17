Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3138F6E40CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQH0Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDQH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:26:12 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FD44A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:08 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-54fbee98814so159772847b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716367; x=1684308367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lk2TzBxvy3H2YxFAlaJgwEBlJno+8HhyM3z0zVaEQA=;
        b=I3kSGVCkQCUusxvCjeXzyRtlkQh5GXefErBNTaCbsvM6giRvS164JDMcAdJU7P0fpe
         UWv6QDsan1IBl5cs6FmLlKrsmkOh//vMFF6MOA0iy6PV/Kny4xTjcjOqLXqAiobcYz8T
         aWNQn9P8i/IesCyT16r8n9T3ao19UlERJXKkT+ZP5O66kgbrv64/yTdgCX5oWVP8dWaU
         hrtVt6DiXCSL/u8csPFi6I4bvfkJY38qoSdaXrm4oY+lNpQJeU9bfvkCZJhiFTR4Ug3+
         KHhtVDFplLgKuQIcj99+0hK5+bw+kxNPliGUkMaHe5SeJ5wlQjDHmN3S4stzUMfI7Vbp
         m7VQ==
X-Gm-Message-State: AAQBX9cXYLmaZ10Ww12ImD8dVB2sjENDA+rgpjuVp9gLsXUjnXg+lYOY
        nOc5RXUdMoluwuJJUVk780JUzAl68MCupw==
X-Google-Smtp-Source: AKy350ax9c4wEuZZpxreu8BNpoxQXbNFhv3bQjyP4TCU4acvX0tuFhY7gYgR3FBiduuuhET1aRBgVw==
X-Received: by 2002:a0d:d4c8:0:b0:536:cb48:9059 with SMTP id w191-20020a0dd4c8000000b00536cb489059mr15418579ywd.50.1681716367115;
        Mon, 17 Apr 2023 00:26:07 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id be18-20020a05690c009200b0054fcbf35b94sm2764181ywb.87.2023.04.17.00.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:26:06 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id k39so2943088ybj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:26:06 -0700 (PDT)
X-Received: by 2002:a25:d8d7:0:b0:b92:2c78:1481 with SMTP id
 p206-20020a25d8d7000000b00b922c781481mr4579095ybg.12.1681716366734; Mon, 17
 Apr 2023 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230412183834.3769519-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 09:25:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdJooFiLfttxeRVZO_0doWiurwg3ZkxEbyO7D8eaDeKw@mail.gmail.com>
Message-ID: <CAMuHMdVdJooFiLfttxeRVZO_0doWiurwg3ZkxEbyO7D8eaDeKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 8:38 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
> SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
> driver when configuring a kernel without support for Nuvoton SoCs.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> v3:
> - Split the commit into two
> - Reword the commit messages a bit

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
