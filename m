Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295E723C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjFFJKJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjFFJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:10:06 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE934100;
        Tue,  6 Jun 2023 02:10:05 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-33b0bfb76cfso24356305ab.2;
        Tue, 06 Jun 2023 02:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042605; x=1688634605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsblPXknZ5GIdBcvT6axVzmA1IISIV/7YdlNXuNCOIg=;
        b=aXftCyN5vDj6Yk+E/L3vX1CmRx1jVHRWP0GWPUaxZ3qxKNS+JLTHs7GOAriMI/kilj
         akvPfHM0L/O/ezCAkaKRA3TExqGYWQxi7dZFNnc6R3Fg/6VU+Xw40p5k4BSx/dFC84xh
         XBG99gRsZ+UOgthiVWF9HCWR56HtTZ3OJqPzDjJy6v3gu3a8Q2eZuj4hXlSHmWtLr9hd
         IjONJBQ2b0UF72PQU6t1SdfkXZxaFALX9EUE1GGxSfINY9EyhWZ8j7vWMX8jibzjwASX
         C2jT8qzTXghJ/3cZ3tRW/upG8OZ84/+HvkKxGAfcQwtZVE/vqfiI2bXhkmLF8blBxBM4
         9JMg==
X-Gm-Message-State: AC+VfDyfaBCzAhHEOVX2mzvtbDTaUhoNDrNRpL3Bk4VC1vPcvQ08CIlo
        9TryqlEPASyRpTJlGynOszmn2NWtv2/MTQ==
X-Google-Smtp-Source: ACHHUZ5wh3jLQizgP0cwlJNWSdX88FVpA2JFJ/P2XluCzNQUJglNSRg+QbKrnfRGScboTFf92K5Aeg==
X-Received: by 2002:a92:ce46:0:b0:33c:b395:a898 with SMTP id a6-20020a92ce46000000b0033cb395a898mr1460748ilr.18.1686042604901;
        Tue, 06 Jun 2023 02:10:04 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b0033aa769d1a9sm2962156ilo.72.2023.06.06.02.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:10:04 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77499bf8e8bso228187139f.0;
        Tue, 06 Jun 2023 02:10:04 -0700 (PDT)
X-Received: by 2002:a0d:df90:0:b0:55a:26cf:33e with SMTP id
 i138-20020a0ddf90000000b0055a26cf033emr1300837ywe.42.1686042115920; Tue, 06
 Jun 2023 02:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv0a-XxXfG6bNuPZGT=fzjtEfRGEYwk3n6M1WhEHUPo9g@mail.gmail.com>
 <CA+G9fYueN0xti1SDtYVZstPt104sUj06GfOzyqDNrd3s3xXBkA@mail.gmail.com>
In-Reply-To: <CA+G9fYueN0xti1SDtYVZstPt104sUj06GfOzyqDNrd3s3xXBkA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jun 2023 11:01:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7hqipiMCF9uxpU+_RbLmzyHeo-D0tCE_Hx8eTqQ7Pig@mail.gmail.com>
Message-ID: <CAMuHMdX7hqipiMCF9uxpU+_RbLmzyHeo-D0tCE_Hx8eTqQ7Pig@mail.gmail.com>
Subject: Re: arm: shmobile_defconfig: ld.lld: error: undefined symbol: lynx_pcs_destroy
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        maxime.chevallier@bootlin.com
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

Hi Naresh,

On Tue, Jun 6, 2023 at 10:53 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On Tue, 6 Jun 2023 at 14:17, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Following build regressions found while building arm shmobile_defconfig on
> > Linux next-20230606.
> >
> > Regressions found on arm:
> >
> >  - build/clang-16-shmobile_defconfig
> >  - build/gcc-8-shmobile_defconfig
> >  - build/gcc-12-shmobile_defconfig
> >  - build/clang-nightly-shmobile_defconfig
>
> And mips defconfig builds failed.
> Regressions found on mips:
>
>   - build/clang-16-defconfig
>   - build/gcc-12-defconfig
>   - build/gcc-8-defconfig
>   - build/clang-nightly-defconfig

Please give my fix a try:
https://lore.kernel.org/linux-renesas-soc/7b36ac43778b41831debd5c30b5b37d268512195.1686039915.git.geert+renesas@glider.be

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
