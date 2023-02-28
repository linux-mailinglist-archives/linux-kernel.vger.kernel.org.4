Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419FA6A5399
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjB1HM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjB1HM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:12:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBE2B619;
        Mon, 27 Feb 2023 23:12:23 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s22so11858133lfi.9;
        Mon, 27 Feb 2023 23:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677568341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2el8epI4ehY4PQhzCIaQmBUYq/tD84LZ7fZuHKl00o=;
        b=OogPw/DeSprgfA45tucixhanu1pqk4JujFYhoxxBMC/vl2iAoBga9+G3Pu/pq9n6o7
         ztmvezIRFcEG2RSBLU2vIZPHB2hPPQ2Nbire1D2KdUiTWfpCgNaYRmgozx1y0k38yIlQ
         zgLemtdhlCTC4gUWaPT0xCpO6tAioJnDr+IBXdQSqY7OEPGUMPtFKGFXa9KkR6qzDSiy
         Ap+QSgf452caujUPME3M3ACeUyaErwZ+1rZM3HthMeQ2wIEz19bgoH9Q8oSD3DECxZ9d
         NHyJHnWkHHZLt7wFVEKrxbNubIe+Ki1v0v/frQRrLW5T3LZgOIuXtIN5QSCgpM6YvOwM
         20Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677568341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2el8epI4ehY4PQhzCIaQmBUYq/tD84LZ7fZuHKl00o=;
        b=ZmBFwAl1c6X718LWD8Zemoz7wLIwATnHGz7s0EmLiPmWdpddA27nVD6a4hhHWFlggv
         RYODdihwPEjAVB+Gabrktjyz+bWAuXMYsbPADDQPMy4kFwFhUuA9n4tO/6ZZvUT2pY6C
         CAhYOM+d2Yimm1C9wgUzummhjccnZ+kvuVg+hcdHVHcEeIjLKHo4U9Nms3kcrrV1AUo/
         dKANQpiGLdWQNwqt6p3XZ7XpLsWhgDMUS3se+qFZaDxtc1SSAH7DaPiZokZ3XnmHUOAt
         9XOAwqAI3xsOYNxkUT9sRp+p5AZQTeQf2vAybJ5ltY1MEGVugdg2BkWnJNLRDn+boRNB
         F2mw==
X-Gm-Message-State: AO0yUKVRSw2KCgvAHHQxaKP4IDACCubUcCZkwXyJGEIae+SuwU36q1jA
        Up/ogMKFNuC5DnoeHE0scd+h+QlPjZ2ISFVyFms=
X-Google-Smtp-Source: AK7set85nhQ9g8yz02zH57y/oTI0WP0o9k1NFfgZU2Uz9PbtXdmMvCjK/p4NyEDFKJMgEHfHvgJnVUYXT02rDuEFI5Q=
X-Received: by 2002:ac2:4432:0:b0:4db:38ba:618d with SMTP id
 w18-20020ac24432000000b004db38ba618dmr382693lfl.12.1677568340985; Mon, 27 Feb
 2023 23:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20230227105941.2749193-1-suagrfillet@gmail.com>
In-Reply-To: <20230227105941.2749193-1-suagrfillet@gmail.com>
From:   Alex Shi <seakeel@gmail.com>
Date:   Tue, 28 Feb 2023 15:11:44 +0800
Message-ID: <CAJy-AmnZmeTEwG9xTevhCzB2t9y0nb2yYsyWPMLn8R1V4XonQw@mail.gmail.com>
Subject: Re: [PATCH] sched/doc: supplement CPU capacity with RISC-V
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        robh@kernel.org, conor.dooley@microchip.com, palmer@rivosinc.com,
        leyfoon.tan@starfivetech.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Mon, Feb 27, 2023 at 6:59 PM Song Shuai <suagrfillet@gmail.com> wrote:
>
> This commit 7d2078310cbf ("dt-bindings: arm: move cpu-capacity to a
> shared loation") updates some references about capacity-dmips-mhz
> property in this document.
>
> The list of architectures using capacity-dmips-mhz omits RISC-V, so
> supplements it here.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  Documentation/scheduler/sched-capacity.rst                    | 2 +-
>  Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/s=
cheduler/sched-capacity.rst
> index 8e2b8538bc2b..e2c1cf743158 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -258,7 +258,7 @@ Linux cannot currently figure out CPU capacity on its=
 own, this information thus
>  needs to be handed to it. Architectures must define arch_scale_cpu_capac=
ity()
>  for that purpose.
>
> -The arm and arm64 architectures directly map this to the arch_topology d=
river
> +The arm, arm64, and RISC-V architectures directly map this to the arch_t=
opology driver
>  CPU scaling data, which is derived from the capacity-dmips-mhz CPU bindi=
ng; see
>  Documentation/devicetree/bindings/cpu/cpu-capacity.txt.
>
> diff --git a/Documentation/translations/zh_CN/scheduler/sched-capacity.rs=
t b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> index e07ffdd391d3..8cba135dcd1a 100644
> --- a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> +++ b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> @@ -231,7 +231,7 @@ CFS=E8=B0=83=E5=BA=A6=E7=B1=BB=E5=9F=BA=E4=BA=8E=E5=
=AE=9E=E4=BD=93=E8=B4=9F=E8=BD=BD=E8=B7=9F=E8=B8=AA=E6=9C=BA=E5=88=B6=EF=BC=
=88Per-Entity Load Tracking, PELT=EF=BC=89
>  =E5=BD=93=E5=89=8D=EF=BC=8CLinux=E6=97=A0=E6=B3=95=E5=87=AD=E8=87=AA=E8=
=BA=AB=E7=AE=97=E5=87=BACPU=E7=AE=97=E5=8A=9B=EF=BC=8C=E5=9B=A0=E6=AD=A4=E5=
=BF=85=E9=A1=BB=E8=A6=81=E6=9C=89=E6=8A=8A=E8=BF=99=E4=B8=AA=E4=BF=A1=E6=81=
=AF=E4=BC=A0=E9=80=92=E7=BB=99Linux=E7=9A=84=E6=96=B9=E5=BC=8F=E3=80=82=E6=
=AF=8F=E4=B8=AA=E6=9E=B6=E6=9E=84=E5=BF=85=E9=A1=BB=E4=B8=BA=E6=AD=A4
>  =E5=AE=9A=E4=B9=89arch_scale_cpu_capacity()=E5=87=BD=E6=95=B0=E3=80=82
>
> -arm=E5=92=8Carm64=E6=9E=B6=E6=9E=84=E7=9B=B4=E6=8E=A5=E6=8A=8A=E8=BF=99=
=E4=B8=AA=E4=BF=A1=E6=81=AF=E6=98=A0=E5=B0=84=E5=88=B0arch_topology=E9=A9=
=B1=E5=8A=A8=E7=9A=84CPU scaling=E6=95=B0=E6=8D=AE=E4=B8=AD=EF=BC=88=E8=AF=
=91=E6=B3=A8=EF=BC=9A=E5=8F=82=E8=80=83
> +arm=E3=80=81arm64=E5=92=8CRISC-V=E6=9E=B6=E6=9E=84=E7=9B=B4=E6=8E=A5=E6=
=8A=8A=E8=BF=99=E4=B8=AA=E4=BF=A1=E6=81=AF=E6=98=A0=E5=B0=84=E5=88=B0arch_t=
opology=E9=A9=B1=E5=8A=A8=E7=9A=84CPU scaling=E6=95=B0=E6=8D=AE=E4=B8=AD=EF=
=BC=88=E8=AF=91=E6=B3=A8=EF=BC=9A=E5=8F=82=E8=80=83
>  arch_topology.h=E7=9A=84percpu=E5=8F=98=E9=87=8Fcpu_scale=EF=BC=89=EF=BC=
=8C=E5=AE=83=E6=98=AF=E4=BB=8Ecapacity-dmips-mhz CPU binding=E4=B8=AD=E8=A1=
=8D=E7=94=9F=E8=AE=A1=E7=AE=97
>  =E5=87=BA=E6=9D=A5=E7=9A=84=E3=80=82=E5=8F=82=E8=A7=81Documentation/devi=
cetree/bindings/cpu/cpu-capacity.txt=E3=80=82

LGTM,
Reviewed-by: Alex Shi <alexs@kernel.org>

>
> --
> 2.20.1
>
