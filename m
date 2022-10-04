Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B025F3F60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJDJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJDJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:21:50 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5018F;
        Tue,  4 Oct 2022 02:20:47 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id o7so8005613qkj.10;
        Tue, 04 Oct 2022 02:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y+//hU1Yc4LQ2dGbJVOgmvwKDPAT2yhj8ciBdV7pT7o=;
        b=TOsVM/mpYx+Vq5Lbc3mQA940s2ppqhs/utdk0iDamm9JYQnGcu/bGDCs1PgtRV19zf
         essfbvp+qnhn4fZ7gqNF6+Bla9pUci2M53nrURoBQXvbQ9r5I/zqgwrvWC9ylOMD8lqP
         6B75GuX7FOM9EzoKD8NQdOrlBznKpuUxPeTWeS0l+vXRutU3b6V+rHK4fcLMKGfeSz6P
         lFe6wMyU2H+dy6GST7LBbQPM2924Cu6tIAXtbpcStyZEummXSUEfJhEa2zvOfoNQUfJ7
         fLLUBsVk8g5446gC84S99oFa62tCq6rNcKtUL5o5LoaSGXbVO+d8qLM5hEY2ERkkvo57
         tLVg==
X-Gm-Message-State: ACrzQf0fKnVWYso0kUuPevQuxxkVwcMMuU+/st2ugitt8VFGsLHu+6Pz
        YGGfobdXjMvTZJXAxMnhz4n1M98V55jH7A==
X-Google-Smtp-Source: AMsMyM76ppye0mxvW1iqbiw9wbGkaPq0OTdjFE+dXnEdkp5i1Q+eRRDN1uCOhd5siTKxZ5idSDpVcQ==
X-Received: by 2002:a05:620a:b88:b0:6ce:ec98:e7f8 with SMTP id k8-20020a05620a0b8800b006ceec98e7f8mr16462931qkh.338.1664875245906;
        Tue, 04 Oct 2022 02:20:45 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 132-20020a37038a000000b006ceb933a9fesm13100349qkd.81.2022.10.04.02.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:20:45 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y205so1812247yby.13;
        Tue, 04 Oct 2022 02:20:44 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr24063004ybx.543.1664875244639;
 Tue, 04 Oct 2022 02:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <63a8403d-b937-f870-3a9e-f92232d5306c@leemhuis.info>
 <534EB870-3AAE-4986-95F3-0E9AD9FCE45B@sladewatkins.net> <e9dd6af0-37ef-1195-0d3b-95601d1ab902@leemhuis.info>
 <20221003112605.4d5ec4e9@gandalf.local.home> <eb935178-995b-84f1-6cbe-3492ba74f85b@leemhuis.info>
In-Reply-To: <eb935178-995b-84f1-6cbe-3492ba74f85b@leemhuis.info>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 11:20:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWq+NntrPqMHzP3XEvKZgjEwSHW80vwWkZnaTORRrhpHA@mail.gmail.com>
Message-ID: <CAMuHMdWq+NntrPqMHzP3XEvKZgjEwSHW80vwWkZnaTORRrhpHA@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Slade Watkins <srw@sladewatkins.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
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

Hi Thorsten,

On Tue, Oct 4, 2022 at 10:41 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> But I consider explaining things like bisection and localmodconfig in
> the documentation as also important, as that's likely something the tool
> won't be able to automate any time soon (or never, as realizing that is
> likely hard and better left to a separate tool anyway).

Creating a simple Linux-specific wrapper around git bisect under
scripts/ might be useful?
The wrapper could copy .config to
$(srctree)/arch/$(ARCH)/config/bisect_defconfig, automatically run
"make bisect_defconfig" in each step, and show not only the bisected
commit, but also the impact on .config.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
