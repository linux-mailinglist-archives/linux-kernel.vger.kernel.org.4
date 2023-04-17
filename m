Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F76E3E07
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDQD3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDQD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:28:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD1335A6;
        Sun, 16 Apr 2023 20:28:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so4328326a12.3;
        Sun, 16 Apr 2023 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681702114; x=1684294114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sclm3NiSyjGTXJ3EM8GpKC+H9zqtpnRJNhokYQ4pWxE=;
        b=aIVLzpwLDgH7PSXcKuXcxG9qleJgPVUvyy8XHPJb3V3zYFW2Nw1x6Bi/9WBnT90WrC
         sx0yrMThm4aNO1vXphTas5n+gc1DEnWBFd7BnLFGEs61x1yk3NfPJaBW18ffRYREvbR3
         HFoVkHaN2St1yHEHmXuOa1nn7o9CISGFQcZpltxpyNE+T5BfC+4gWCAju0qWIjvCl4sN
         oUD8v3oI9HJYKdIP0NVwjGdMXg3/3AWfaKcxoQVWDZi8cEM2ouomNaEh8S0a8Tqz2acV
         /YyvFWZZO2d0EucaEw0cImxRVY9iVJKZpESUWQaEmp6PfszJg30KZ0fJZkTyERazAH8v
         F50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681702114; x=1684294114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sclm3NiSyjGTXJ3EM8GpKC+H9zqtpnRJNhokYQ4pWxE=;
        b=Fc+AAEbSJj7uEDb5XH4gpAVz/W7B7h5QrSlAFPVlQrir5CPU+0skpTtFJivfvCgG7p
         B0wg2kGxL/wPpF7meu/tBroD2eDs6MYEB4tFDdPtLbiaCi5tArF9q0sUNRY/mDIH+lgT
         7kdojEbD+CdP6gscySiRYAgIZi1KmXwrjbTZ6bUko630qzkz+bz3xcXjkjoqwOc5JH2F
         WJ+HdtPIb0wpsnp5bErnN9WOIurBnuRfoBltLdEXCsyH7JJbvAQfl+2qXvcRpKk64KOJ
         gh2cM12wvPva50c/CR0ZXQuPW4zd6mQZZr/0UQEHplWrgI1nL0tHYuNOs8YmL2gnkSqg
         MaVg==
X-Gm-Message-State: AAQBX9dZ1/TssMpP0runGV0MWWzhUitAfRqunUB6d7iInp9FbZdodO4C
        AuA133Gvtjo/pqqf+QdcrXKYsEQ6GkC7PgpWGP8=
X-Google-Smtp-Source: AKy350ZfFbhqSvOEG2EDXFS8/j14sozOTQatjzxzULmwFxka8Bp5GN1htoY0hzrqGoYZYR9aZ2slsRSvUUu8hdG7JSM=
X-Received: by 2002:a50:cd55:0:b0:504:fcf5:63ee with SMTP id
 d21-20020a50cd55000000b00504fcf563eemr6393394edj.0.1681702113958; Sun, 16 Apr
 2023 20:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230330102013.545588-1-keguang.zhang@gmail.com>
 <20230330102013.545588-2-keguang.zhang@gmail.com> <20230330113053.GB9674@alpha.franken.de>
In-Reply-To: <20230330113053.GB9674@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 17 Apr 2023 11:28:17 +0800
Message-ID: <CAJhJPsWDP1Wvef2HGhAqiL77bDRMzz37XkXkVWgzW7Ca54p5XA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson32: Remove reset.c
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yang Ling <gnaygnil@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 7:33=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Thu, Mar 30, 2023 at 06:20:12PM +0800, Keguang Zhang wrote:
> > The Loongson-1 restart handler will be moved to watchdog driver,
> > then _machine_restart is no longer needed.
> > The _machine_halt and pm_power_off are also unnecessary,
> > which contain no hardware operations.
> >
> > Therefore, remove the entire reset.c and related header file.
> > Update the Makefile accordingly.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
> >  arch/mips/loongson32/common/Makefile          |  2 +-
> >  arch/mips/loongson32/common/reset.c           | 51 -------------------
> >  3 files changed, 1 insertion(+), 67 deletions(-)
> >  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
> >  delete mode 100644 arch/mips/loongson32/common/reset.c
>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
Thomas,
Sorry! I forgot to remove the reference to regs-wdt.h, which will
cause a build error.
Could you please review v2:
https://lore.kernel.org/all/20230330112051.551648-2-keguang.zhang@gmail.com=
/
Thanks very much!

> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--
Best regards,

Keguang Zhang
