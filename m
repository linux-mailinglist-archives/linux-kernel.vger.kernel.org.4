Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB1688310
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjBBPtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjBBPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:48:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A662312A;
        Thu,  2 Feb 2023 07:48:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u5so1479298pfm.10;
        Thu, 02 Feb 2023 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBRKU9ePr2Z6fcG6an6gYpt7CqLb0XsF4lYBsix8b8U=;
        b=FSnBEMxJIPecU08W0GFfZwy05AgsLIHW9cJN+1f7niVTxMoU5iQ02+i2e9C5bUQXGE
         kQg8IIcSdDi6PvjV4lU7TsqNpM9wVTbeSrbFtt4HIC9Uy6y9p2AHQ8ztK+ZZc+SSpM8s
         2UFSM16bJRxbzhsFozSajcqqGildUFM5tN/ueGo5iXULxeuCiavDw9GNfQvGGPPbrBvV
         JIY+uyGcHBAvvWymjKtEFny2Q0zFcksVExnPGHSI1XgJDrTehCTioNLtj7YGysDUeM2z
         QqZ+QB0Jby+5l6sY0fP/C39SRLVu/G/tzcUxb+gAHwLazk63smIm+7UJ9xdiUT1MH1Rt
         SZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBRKU9ePr2Z6fcG6an6gYpt7CqLb0XsF4lYBsix8b8U=;
        b=Rh2ZZPoxoiXwSb4H7haUTIJut+rtEOgbsPKbERWX1bifD8LQxy2RcHnhnFyFTvfyG1
         KP+dXewu6Kej0BX8VxNCiu1h284N6E2pmmgZjXqzsQCoKEdemgdBVEW7/exSm1j0pNMx
         irltd9LVH4QeYyFs0tGPUd7nMMs6ggvpn+OEArvtXtgcVDxyy15ikBeDnhKAhUCeScVN
         GIdABhv8Dz8A7k8hdwJ8hGaeRKhEYZwfGSst4I4our3ZX/NKB8KQEdtYuPX0MfHu1NUF
         lUTqkqufBzweZ59h12KiSDUjyiRM1rD8VqrGBfkJtqA8PyV1fWn2DTLqFqhgNVJhcF4M
         3Bxw==
X-Gm-Message-State: AO0yUKWy129cYzQqL483GbIrroU2zUnf6wjtwv7nJxQu3Ky6RCGt9Fk/
        ES5vNHeMicAV2WquaQu9a36hdDgXu5R+i4G7ANT+r04pr2M=
X-Google-Smtp-Source: AK7set/h3mMM2F+0vXAwb5oGQKg4EXoZwqxMzEYgicmwV2/Yp3EUZNPcF7SYcLSIaAtf887iYnHtLn1b78c7GBIj7ps=
X-Received: by 2002:aa7:8d16:0:b0:591:4b17:22b5 with SMTP id
 j22-20020aa78d16000000b005914b1722b5mr1344241pfe.14.1675352894050; Thu, 02
 Feb 2023 07:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
 <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
 <20230202084953.3035c6e3@gmail.com> <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
 <CAJZ5v0hbFNGugDJ3PGLzfNm7h7f8vTesUOZ0R_vkYGaxBWFCdQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hbFNGugDJ3PGLzfNm7h7f8vTesUOZ0R_vkYGaxBWFCdQ@mail.gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Thu, 2 Feb 2023 15:48:02 +0000
Message-ID: <CAKbZUD3UPMuH-NHXL093FaaFtEaeC295RemSeVMC8jLr6zbghA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Marty E. Plummer" <hanetzer@startmail.com>,
        Sebastian Grzywna <swiftgeek@gmail.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Hang Zhang <zh.nvgt@gmail.com>
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

On Thu, Feb 2, 2023 at 10:45 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Thu, Feb 2, 2023 at 11:03 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Thu, Feb 2, 2023 at 8:50 AM Sebastian Grzywna <swiftgeek@gmail.com> =
wrote:
> > >
> > > Dnia 2023-02-01, o godz. 19:34:48
> > > "Rafael J. Wysocki" <rafael@kernel.org> napisa=C5=82(a):
> > >
> > > > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> > > > <pedro.falcato@gmail.com> wrote:
> > > > >
> > > > > Make custom_method keep its own per-file-open state instead of
> > > > > global state in order to avoid race conditions[1] and other
> > > > > possible conflicts with other concurrent users.
> > > > >
> > > > > Link:
> > > > > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt=
@gmail.com/
> > > > > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Geek
> > > > > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > > > > <pedro.falcato@gmail.com> ---
> > > > >  This patch addresses Hang's problems plus the ones raised by
> > > > > Rafael in his review (see link above).
> > > > > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > > > > submitted but since there were still people that wanted this
> > > > > feature, I took my time to write up a patch that should fix the
> > > > > issues. Hopefully the linux-acpi maintainers have not decided to
> > > > > remove custom_method just yet.
> > > >
> > > > Well, thanks for the patch, but yes, they have.  Sorry.
> > >
> > > Hi Rafael,
> > > Can you please explain why you don't want to keep it, given there's a
> > > patch?
> >
> > Because this interface was a bad idea to start with and its
> > implementation is questionable at the design level.
> >
> > Granted, at the time it was introduced, there was no alternative, but
> > there is the AML debugger in the kernel now and as far as debugging is
> > concerned, it is actually more powerful than custom_metod AFAICS.  See
> > Documentation/firmware-guide/acpi/aml-debugger.rst.
> >
> > If the AML debugger has problems, I would very much prefer fixing them
> > to the perpetual maintenance of custom_method.
> >
> > > I find it really useful in my day-to-day as a firmware engineer.
> > > I don't see much happening in git history of
> > > drivers/acpi/custom_method.c , and I don't see anything that was
> > > specifically changed in it in past 10 years to keep it being
> > > functional. Without your more detailed explanation I have hard time
> > > understanding your decision to remove it, since I'm not a kernel
> > > developer myself.
> >
> > It's been always conceptually questionable, problematic from the
> > security standpoint and implemented poorly.  Also its documentation is
> > outdated.
> >
> > The patches fixing its most apparent functional issues don't actually
> > address much of the above.
> >
> > The AML debugger should really be used for debug rather than
> > custom_method and honestly, what's the purpose of it beyond debug?
>
> The above said, if people really do care about custom_method, it can
> be retained, but its documentation needs to be updated to cover the
> current requirements (according to Rui, they have changed after some
> upstream ACPICA changes).
>
> Also note that the upstream ACPICA may not be guaranteed to avoid
> breaking this interface in the future, as it depends on
> acpi_install_method() that is provided by ACPICA specifically for the
> use in the AML debugger.

Just to be clear, I have no stake in this matter and wrote this patch becau=
se
someone complained on #coreboot about the removal. This patch was mostly
trivial to write and if you decide there really is no value in keeping
this, I'm a-OK.

From a maintainers' PoV, if the AML debugger completely encompasses this
from a functional PoV with a good UX, I would probably encourage you to
remove this once and for all (what's the value in having 2 of the same
functionality?).

Hopefully the FW folks can give more context and feedback.

--=20
Pedro
