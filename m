Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24E720F28
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjFCKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFCKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 06:20:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF616BB;
        Sat,  3 Jun 2023 03:20:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078cc99232so2728964f8f.3;
        Sat, 03 Jun 2023 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685787612; x=1688379612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiyEzTB76d51V4yyJkufi8HLIk7ZWcK0vs+TVmZ8HT4=;
        b=AJ7gci2EWVpp70ajhdJ3QJ6xAv3nQL5YuZ4bHDZ//uc+x87g78koUZlCSKKvEiMZRO
         d5//72GoLPQR/iHBbN/MeAzPWZNXH+PbGlj2YnC0Y7fRXtABbtu3qRulzOq/10YQXhyX
         +FkEjnFdcvhkKNGyHYTc7i9g6EfJeDXtUR+dZsJoRu6C+2FJt2qc+ZPqCdBTVM9Uw1Re
         drgBGSd8+r7Dq69/Nt9fnLH66ZMmLI+3PnAoa2IDvTmHkqGTheB4hgK2l96YxBMoYHmQ
         YFePNc3L0kOkAJWP2YOM4gseEKopHQ5I8lQgV3aoQ7Ys0hGO5yhML0P2UgeRMWMEym75
         01nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685787612; x=1688379612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiyEzTB76d51V4yyJkufi8HLIk7ZWcK0vs+TVmZ8HT4=;
        b=EVwSH6AstYqJZkzSAuZBIWASD0abwdeBnHuflYPQ2hmkj1t8j9bpOeyUGbAEYQ4AFe
         GzEnSK/5u7dae9ABB6NOF4E2b+EuyjPG3sXZPvNUALfXk+vj80oqBgwjxJxPVRoT6mC4
         PNHamX07BaArgUYxDfX5sgl/8lx4+ic0nIUa8rJJuuNSw2mOi+64DUOjg6lX/0Scjm2D
         AP+BK4jPaXlRgr5ftZdFJhAazrBfqdYlNpl1JUpDf9lArCviVfI1q9UAPG6AG5Hhgo11
         XrTYKFY/gFmJsAeU6nxNGj5ajvnAdLr7x8DXnjmvEKvOMEkZtwYGD7LWmW+tJdsDUI4u
         3+6w==
X-Gm-Message-State: AC+VfDzAe/N//IZN1+sUSNKDMUpn2KD57MLXcpqtERHmSN0hVge+Jzys
        Lcn6/iQeA3JDi47Mij8VYiUA13ZRX7G3lsrRcEE=
X-Google-Smtp-Source: ACHHUZ5Al2tHisbt7qIrU5MUZ5CmcUjy6JTHvp1qO5H49bwETMbflHI6IvsQHd/Fd58ki71ubfosqZn236HSA2PesW8=
X-Received: by 2002:a05:6000:885:b0:30a:b4e1:a89f with SMTP id
 cs5-20020a056000088500b0030ab4e1a89fmr2180137wrb.58.1685787612229; Sat, 03
 Jun 2023 03:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230601221151.670-1-mario.limonciello@amd.com>
In-Reply-To: <20230601221151.670-1-mario.limonciello@amd.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 3 Jun 2023 18:19:59 +0800
Message-ID: <CAJsYDVKoB1AEL47Ud+8jbxMrbZedM0i9p44-PLQTFR9PKLfy6A@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, ofenfisch@googlemail.com,
        wse@tuxedocomputers.com, adam.niederer@gmail.com, adrian@freund.io,
        jirislaby@kernel.org, Renjith.Pananchikkal@amd.com,
        anson.tsao@amd.com, Richard.Gong@amd.com, evilsnoo@proton.me,
        ruinairas1992@gmail.com, nmschulte@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Jun 2, 2023 at 6:12=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors
> add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Furthermore some vendors have used ActiveHigh for IRQ1.
> To solve this problem revert the following commits:
> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7"=
)
> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad=
")
> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> platforms")
>
> Cc: ofenfisch@googlemail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Cc: Renjith.Pananchikkal@amd.com
> Cc: anson.tsao@amd.com
> Cc: Richard.Gong@amd.com
> Cc: Chuanhong Guo <gch981213@gmail.com>
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217406
> Reported-by: nmschulte@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217336
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Adjust to drop heuristics entirely
>  * Drop tested tags
>  * Add more links and people to Cc
>  * Drop Fixes tag as this got a lot more risky
> v1->v2:
>  * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG=
 UltraPC 17U70P")
>  * Pick up tag
>
> Rafael,
> Please hold off on picking this up until the majority of those on CC
> have tested it on hardware they have and reported results.
>
> Everyone else,
> Please test. If you have problems with this applied, please share
> an acpidump and dmesg either on a bug or to me privately.

I was expecting this patch to break my keyboard again but
that didn't happen. I'm on the latest UEFI from Lenovo.
By dumping ACPI APIC I found that there's this:

[0C4h 0196   1]                Subtable Type : 02 [Interrupt Source Overrid=
e]
[0C5h 0197   1]                       Length : 0A
[0C6h 0198   1]                          Bus : 00
[0C7h 0199   1]                       Source : 01
[0C8h 0200   4]                    Interrupt : 00000001
[0CCh 0204   2]        Flags (decoded below) : 0007
                                    Polarity : 3
                                Trigger Mode : 1

I don't have a dump of the ACPI table from older UEFIs anymore.

Tested on Lenovo Thinkbook 14G4+ ARA with the latest
UEFI (J6CN45WW).

Tested-by: Chuanhong Guo <gch981213@gmail.com>

--=20
Regards,
Chuanhong Guo
