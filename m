Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B37078A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjERDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjERDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:54:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F1114;
        Wed, 17 May 2023 20:54:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30935d343f7so1436037f8f.1;
        Wed, 17 May 2023 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684382063; x=1686974063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+6bngIPlRaxvFBxjFkhMReUFJu6ef/0Etf19kPyE0E=;
        b=IgnIIiSCFX+sAE06Nn8WotOSa1XJDLsJCfNRWlsnMaGEI+3t3ZY+xjxOeup8LHhw9d
         TPlrOzu1emcDMSBDyY2vWb7z2/Y5xWdi23emJCU3GjQqtIVxiYsHzRLiOJYq2DJceXDq
         8EP/OUts7+NQaN8LAI9TC+HMNRTND+BKqI8lBQgECn7zxXwXE+1++ncp7j2Y0O6SqfqR
         qh9VIlIEnc0+gQOW2l0yvCf4UhPIWpz5Yrj3ONBIzBgx/8D0fzTzOOq+fHBrXitYDQAT
         V/wU9j2FvIc+xqeRvdanY8TZLFQk0Y++FzDe41cN10vyyZ0H/A3WRHqLJTklX3p0rGBU
         gxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684382063; x=1686974063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+6bngIPlRaxvFBxjFkhMReUFJu6ef/0Etf19kPyE0E=;
        b=WnCEfSjE054piD7cYOR5EBagwo8LSVJFKLCXDEkjERqMatqLSmnJnVIs+1z6dpK1tA
         5qqDk+AoByxE7OH1YweRUN+Man/wLoPqBWaidA37+4CglVesHLdI5O0RmFSHCzCqR/iD
         oqCKgW0tjSjbfgzI/gb+l+V6oPorBYYibehk1ggi/RefPMuHy8vrkb337fr+QGAuWlzL
         inw2qB/lsc2hVN2gY4KWY8uELs93ttiPP4kYQCtnAxuH3plYJR58Yh8vmaZxFwEamVNX
         AYeZ8Yaq6unS+infN+4vj5veuJ2YK3a4F1MsEq4+qRx/7Y2KXPQD73ehJL8v9aB3TptW
         mpTQ==
X-Gm-Message-State: AC+VfDxQVREuvqWSpZae51/K9wzOl7rSx9crJkqa5cgwNJ3MOb+39LSU
        yS+3Stmsb5jfmy013VHGsTrTMZol2KmsEBoMlpM=
X-Google-Smtp-Source: ACHHUZ7leEjBPH9XcWIslAMGd2eimLbWCb7exyHpdSn9QCq5Ld6ewU7VrQHTmYk//wBrpCB+feNcdw11RGyWhonwIvA=
X-Received: by 2002:adf:fc12:0:b0:309:3b4a:cdf4 with SMTP id
 i18-20020adffc12000000b003093b4acdf4mr274930wrr.67.1684382062853; Wed, 17 May
 2023 20:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230515213822.1277-1-mario.limonciello@amd.com>
In-Reply-To: <20230515213822.1277-1-mario.limonciello@amd.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 18 May 2023 11:54:10 +0800
Message-ID: <CAJsYDVKsZyKR_EcgfqV=sptnFmWawY5uy27KtTK3ZrjGWGYygw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        ofenfisch@googlemail.com, wse@tuxedocomputers.com,
        adam.niederer@gmail.com, adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, evilsnoo@proton.me, ruinairas1992@gmail.com
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

On Tue, May 16, 2023 at 5:38=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which use ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors seem
> to add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Adjust the logic so that only IRQ1 is overridden in Ryzen 6000 case.
>
> This effectively reverts the following commits:
> commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
>
> Cc: ofenfisch@googlemail.com
> Cc: gch981213@gmail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Tested-by: Renjith.Pananchikkal@amd.com
> Tested-by: anson.tsao@amd.com
> Tested-by: Richard.Gong@amd.com
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217406
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platfo=
rms")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Tested on Lenovo Thinkbook 14G4+ ARA with Ryzen 7 6800H.
The keyboard still works with this patch applied.

Tested-by: Chuanhong Guo <gch981213@gmail.com>

--=20
Regards,
Chuanhong Guo
