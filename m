Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038F6B8640
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCMXpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:45:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EA769A;
        Mon, 13 Mar 2023 16:45:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n16so3116163pfu.11;
        Mon, 13 Mar 2023 16:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678751142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Fe5Pwx7lLQSBtvwu7hq+59lSw7HlUXNYKb3cccaveQ=;
        b=dZvHI7uV5UoUWjPBavEH4TJGjMPGleN7PZjo0pL25t07w+VTOULqnKE97W1HGp2kx8
         j/HKijQ12CX2fzAHEoJVqbxcu9aQmoQ7E2lCsBBrJ/b+18vg7pYN3YftUD9L5CkGvag4
         gnSbBOOhlwInwL5R0lv24Kf+r8GAYeNF5Hx3k8fhjKyRJbJ+stOaAEsGycw5/je6pmdY
         0lDLMKFkZHl9f3xNCWahvO3mqowDK3jTaPZHI5ZRqHgVX8sNjKbytlm45dFaKWaxAJ2h
         6bTuu8lPmLUWCtjUQuvHXVl7o7HycbxCFpQ4tRqaoqxQzbk8ojb/jxQ42KTUelfu2/0X
         BaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678751142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Fe5Pwx7lLQSBtvwu7hq+59lSw7HlUXNYKb3cccaveQ=;
        b=pSf8HVDBnuvnTzCmZsNLwWtVR8Tz5Dtbb3W5ZyU+XSLW+DXt2NQl9Yb3j1D5hgvSrO
         ix8ppCkchu03c91CLwnapEX3E3BYCWrGF7oRcPwzYmrjCnv2hMJD5Ah8ieS4wGOJX14y
         tZayD4ipMHBiTEYzI/1tya70XJlJtw72eyx6j1GyRAWclOYVmcFvyBnm5T9n8ySR91IW
         ytfLfPLy2qcgpOWlFhmv5SqF11Sn4tBzdetrSbUgkhZOnhGOyUoFu+TWRqRC8Ol8xrOS
         eEsVbxdkPQrP82wXo0g88kDOmtDs2I3jGim7P73lYTLVAy6K9uDRnz0sn2nmQs8IrKR6
         pv8g==
X-Gm-Message-State: AO0yUKXPb3RiJkssDFNa9Im0CcK1DLJrH+hqlMCpnOpJ5dW4KqPhJsMm
        XUO51iAdSSQJ/t/WYFgcBXeUNiMfq9DwwoTi7UU=
X-Google-Smtp-Source: AK7set+ta9Tl2/jEngRsTXRTa1LA649SS7H+lmN2ADlgcot88aUMlHJS+kCSvm9joid5DOjzucrI0WY7pf4WvwMdDwA=
X-Received: by 2002:a62:1a95:0:b0:625:df7:1557 with SMTP id
 a143-20020a621a95000000b006250df71557mr1340565pfa.5.1678751141692; Mon, 13
 Mar 2023 16:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
 <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
 <20230202084953.3035c6e3@gmail.com> <CAJZ5v0iwO=xJ8A=vv4Khm6Z+Lb9hpZsZmyCjMeSHutMWRcp78g@mail.gmail.com>
 <CAJZ5v0hbFNGugDJ3PGLzfNm7h7f8vTesUOZ0R_vkYGaxBWFCdQ@mail.gmail.com> <CAKbZUD3UPMuH-NHXL093FaaFtEaeC295RemSeVMC8jLr6zbghA@mail.gmail.com>
In-Reply-To: <CAKbZUD3UPMuH-NHXL093FaaFtEaeC295RemSeVMC8jLr6zbghA@mail.gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Mon, 13 Mar 2023 23:45:30 +0000
Message-ID: <CAKbZUD0AmxKhMkaO1MwkV_0TAna=Vq2oapxG5QTCwrUeOhzXwQ@mail.gmail.com>
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

On Thu, Feb 2, 2023 at 3:48=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Thu, Feb 2, 2023 at 10:45 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Thu, Feb 2, 2023 at 11:03 AM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > >
> > > On Thu, Feb 2, 2023 at 8:50 AM Sebastian Grzywna <swiftgeek@gmail.com=
> wrote:
> > > >
> > > > Dnia 2023-02-01, o godz. 19:34:48
> > > > "Rafael J. Wysocki" <rafael@kernel.org> napisa=C5=82(a):
> > > >
> > > > > On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> > > > > <pedro.falcato@gmail.com> wrote:
> > > > > >
> > > > > > Make custom_method keep its own per-file-open state instead of
> > > > > > global state in order to avoid race conditions[1] and other
> > > > > > possible conflicts with other concurrent users.
> > > > > >
> > > > > > Link:
> > > > > > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nv=
gt@gmail.com/
> > > > > > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Gee=
k
> > > > > > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > > > > > <pedro.falcato@gmail.com> ---
> > > > > >  This patch addresses Hang's problems plus the ones raised by
> > > > > > Rafael in his review (see link above).
> > > > > > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > > > > > submitted but since there were still people that wanted this
> > > > > > feature, I took my time to write up a patch that should fix the
> > > > > > issues. Hopefully the linux-acpi maintainers have not decided t=
o
> > > > > > remove custom_method just yet.
> > > > >
> > > > > Well, thanks for the patch, but yes, they have.  Sorry.
> > > >
> > > > Hi Rafael,
> > > > Can you please explain why you don't want to keep it, given there's=
 a
> > > > patch?
> > >
> > > Because this interface was a bad idea to start with and its
> > > implementation is questionable at the design level.
> > >
> > > Granted, at the time it was introduced, there was no alternative, but
> > > there is the AML debugger in the kernel now and as far as debugging i=
s
> > > concerned, it is actually more powerful than custom_metod AFAICS.  Se=
e
> > > Documentation/firmware-guide/acpi/aml-debugger.rst.
> > >
> > > If the AML debugger has problems, I would very much prefer fixing the=
m
> > > to the perpetual maintenance of custom_method.
> > >
> > > > I find it really useful in my day-to-day as a firmware engineer.
> > > > I don't see much happening in git history of
> > > > drivers/acpi/custom_method.c , and I don't see anything that was
> > > > specifically changed in it in past 10 years to keep it being
> > > > functional. Without your more detailed explanation I have hard time
> > > > understanding your decision to remove it, since I'm not a kernel
> > > > developer myself.
> > >
> > > It's been always conceptually questionable, problematic from the
> > > security standpoint and implemented poorly.  Also its documentation i=
s
> > > outdated.
> > >
> > > The patches fixing its most apparent functional issues don't actually
> > > address much of the above.
> > >
> > > The AML debugger should really be used for debug rather than
> > > custom_method and honestly, what's the purpose of it beyond debug?
> >
> > The above said, if people really do care about custom_method, it can
> > be retained, but its documentation needs to be updated to cover the
> > current requirements (according to Rui, they have changed after some
> > upstream ACPICA changes).
> >
> > Also note that the upstream ACPICA may not be guaranteed to avoid
> > breaking this interface in the future, as it depends on
> > acpi_install_method() that is provided by ACPICA specifically for the
> > use in the AML debugger.
>
> Just to be clear, I have no stake in this matter and wrote this patch bec=
ause
> someone complained on #coreboot about the removal. This patch was mostly
> trivial to write and if you decide there really is no value in keeping
> this, I'm a-OK.
>
> From a maintainers' PoV, if the AML debugger completely encompasses this
> from a functional PoV with a good UX, I would probably encourage you to
> remove this once and for all (what's the value in having 2 of the same
> functionality?).
>
> Hopefully the FW folks can give more context and feedback.
>
> --
> Pedro

Hi Rafael and other stakeholders,

Gentle ping. Are we axing the feature? Are we reviewing/merging this patch?

Having a straight up racy/broken feature in the kernel (even if only
under debugfs) is not ideal.

--=20
Pedro
