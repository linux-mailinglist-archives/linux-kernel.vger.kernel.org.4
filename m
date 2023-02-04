Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F968AAB3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjBDO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:56:34 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBEA11151
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:56:33 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id a1so9568266ybj.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf4kEQFqYpGqwepDe2k0BFPly4fiPwxUV1tm7XECwi0=;
        b=QVAtIRChIxCR6P+PwZ2WuX3It0zLbkAtOl9s/GmJE8LI8RDPdtyd9dINy3uKAghklE
         TUOEqv53B1G7zPUBMKNrreD0viJKTiF/0R/iQlyNF9zdggwQIJG5Plu9fZpBCgwwNsyU
         u7NmbrzZdhCdyY6B3ZDWxlOu/4K+/nF4iG/rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf4kEQFqYpGqwepDe2k0BFPly4fiPwxUV1tm7XECwi0=;
        b=xiHUrHGFIWBnnDCQkGvV0XpE/OsAkce481rkvT03dkT1GbuR+yC3BrtfvheO8iRqt6
         tusr1CW31KyUsLBXz06MBR2FoS+W+xd+RV4d2WtdqRaHUtk3eAGCVSjTTyt1ARjaYvWJ
         Oobew8qnRLe726DUUebSXWYw9E6l26C7FtrYB7ZA5ndK6z+l7KVeQBNvsW8leaUoTySK
         8O5yAgHCeTPCEMKboL3xrjDuCjMEyj5B8vzVPq7U7vjddd4HdCteqEGiPfHog6raEweq
         ztiOA8ujYw+1pfWCMqLSSf7T0/Z4uV7xu8qnpp2bBYQ49EKV/v6GX5nQB259laHsoFxR
         ZeUg==
X-Gm-Message-State: AO0yUKXpZkmO+nzVZWh5hLEQ9U8TAs91AhcWMDB1ZXonSJYfGle6ZFrK
        GKMOaWCvCKDYwkUWj0QXJRWgeqTt0g9UOThTgqcQou+yPZyXJ7+S
X-Google-Smtp-Source: AK7set+7/WVmtVsk/6QM0tDldE11JjcDa7zEEnRm08L8icJZF0CNC6jPLtrG12yq4ka6KvR5kaMoAP/bFBGW9fXwR1M=
X-Received: by 2002:a05:6902:49:b0:880:3ca9:736a with SMTP id
 m9-20020a056902004900b008803ca9736amr165394ybh.462.1675522592847; Sat, 04 Feb
 2023 06:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20200403140616.19505-1-jagan@amarulasolutions.com> <CAMty3ZDBdry965H1VvC8E+cZC07qY-9ZM53BmZSstGhtpxWnEw@mail.gmail.com>
In-Reply-To: <CAMty3ZDBdry965H1VvC8E+cZC07qY-9ZM53BmZSstGhtpxWnEw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 4 Feb 2023 20:26:21 +0530
Message-ID: <CAMty3ZCTVvkkq0LgDnHTnm_h1L5fDicsBPFPWtha9KujSqed7w@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable GPIO_SYSCON
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Levin Du <djw@t-chip.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heko,

On Mon, Jul 6, 2020 at 7:49 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Heiko,
>
> On Fri, Apr 3, 2020 at 7:36 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > roc-rk3328-cc board has vcc_sdio regulator controlled
> > by a special output only gpio pin. This special pin can
> > now be reference as <&grf_gpio 0> via gpio-syscon driver,
> > as mentioned in below commit.
> >
> > commit <99165b93dafe4f2a821b5dae106f2ef6b4ceff7e> "arm64: dts: rockchip:
> > add sdmmc UHS support for roc-rk3328-cc"
> >
> > So, enable bydefault on the defconfig.
> >
> > Cc: Levin Du <djw@t-chip.com.cn>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
>
> Any update on this?

Can you apply this patch?

Jagan.
