Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129926A41D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB0Ml2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 07:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0Ml1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:41:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD91E286;
        Mon, 27 Feb 2023 04:41:22 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s17so3452291pgv.4;
        Mon, 27 Feb 2023 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8051CX7GPwWvxqPme+h1NtjPhHXl6yhdGNxnSFiTIOA=;
        b=DkVsZ7W6sLSIbxXqO3RoUSQbMxy+34TToWoKm83zULMAtyl1ogv9SxlV5LzIqI0lyP
         69NKWYIwkNWmBdOaWfGR4/pZ1TXJL273lB9247VA8pD50IIdZcQHJHCAGyDlBvuToTJq
         6tRcO44j60Agew8QWEjJUbShHfFjIkZnpEP4oX+UclT1W5vprZPTfsUucuLoCIh75Yyl
         6XUfq3vPoPlDtbrELgyTjeWySVIBbfhO0P5YgwqvzYLdCkVg1KbB7nf/U+iza0TLhIvQ
         /8iUib+n0EolvYMXtODbhqDZMOUaZEwp/R1qtbZbDSdOfvxAh5x2SPZNbzs+w+3MjpRw
         R3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8051CX7GPwWvxqPme+h1NtjPhHXl6yhdGNxnSFiTIOA=;
        b=AgGJECPrWshvuMaD4KvFo4seEtyh8ysejvZ+f7z1Cj5C4btbJKMp/5HRKDxBY/yjge
         FOEDQWKAjO/HYxJ9laVpR0KDDAzvMeWVN6F3MF/fPnr3MxfOsJ6OXXGjlvrJANSrSYJv
         1oxtZCBkB7PXV4gEUCBgB//OIXlfvlgm3vimydX7RIP2oWflMaBcCBaMJVVBDrTmPRxd
         IgWwCmH9Rt8CowUzSlYmvaC1rIuI+SuniNUDbpUPPWPev/bJ45VZDBeFadDG0q3LEp9N
         uYSUGvvE5rvh+uegtGX/567sFr3lgBmKreK1J6bgWvUgKCiuLpDoCOjb+l+SwtzQPiLy
         ak6w==
X-Gm-Message-State: AO0yUKWb1sdcyDmhbMHZK5MqMvycapGDB3PwuIqd1irtpLRuFSPfhZc3
        l6jCdt6LQQySscsrCFJ1bU6LCgZ4+ZcqTtjjRrY=
X-Google-Smtp-Source: AK7set+VPHNc0Uj3lGJtVWGyyyOmXD3p+bICegEcbCtoyyDOa/JLV6ZlwR96+FshBmRFyL71aTMFUEuoS6vHb1bDNu8=
X-Received: by 2002:a63:7556:0:b0:4fb:9902:fc4a with SMTP id
 f22-20020a637556000000b004fb9902fc4amr5794446pgn.10.1677501682153; Mon, 27
 Feb 2023 04:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20230227105941.2749193-1-suagrfillet@gmail.com> <Y/yagE7jfRGo1FgY@wendy>
In-Reply-To: <Y/yagE7jfRGo1FgY@wendy>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 27 Feb 2023 12:40:45 +0000
Message-ID: <CAAYs2=jSt9=d=N98DCVvtNA9FE6KcVYVdHPG-wpuDPknBFUndQ@mail.gmail.com>
Subject: Re: [PATCH] sched/doc: supplement CPU capacity with RISC-V
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        robh@kernel.org, palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=882=
7=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Feb 27, 2023 at 06:59:41PM +0800, Song Shuai wrote:
> > This commit 7d2078310cbf ("dt-bindings: arm: move cpu-capacity to a
> > shared loation") updates some references about capacity-dmips-mhz
>
> Not requesting a respin for this, but mentioning commit 991994509ee9
> ("dt-bindings: riscv: add a capacity-dmips-mhz cpu property") is
> probably more relevant as a justification for this change.
>
Thanks for your correction, I'll pay attention next time.

I have a question about the patch you mentioned:
The patch uses cpu_scale per_cpu variable to store the CPU capacity
through arch_topology,
But arch_scale_cpu_capacity() interface seems not defined to deliver
the cpu_scale to the scheduler
In contrast, arm64 defines it as the topology_get_cpu_scale() in its
arch/arm64/include/asm/topology.h.
Is this an oversight or a particular purpose?

> > property in this document.
> >
> > The list of architectures using capacity-dmips-mhz omits RISC-V, so
> > supplements it here.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  Documentation/scheduler/sched-capacity.rst                    | 2 +-
> >  Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation=
/scheduler/sched-capacity.rst
> > index 8e2b8538bc2b..e2c1cf743158 100644
> > --- a/Documentation/scheduler/sched-capacity.rst
> > +++ b/Documentation/scheduler/sched-capacity.rst
> > @@ -258,7 +258,7 @@ Linux cannot currently figure out CPU capacity on i=
ts own, this information thus
> >  needs to be handed to it. Architectures must define arch_scale_cpu_cap=
acity()
> >  for that purpose.
> >
> > -The arm and arm64 architectures directly map this to the arch_topology=
 driver
> > +The arm, arm64, and RISC-V architectures directly map this to the arch=
_topology driver
>
> My grep clearly missed this change, thanks.
> For the only part of the patch I understand:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>


--=20
Thanks,
Song
