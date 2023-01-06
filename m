Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A146601EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjAFORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjAFORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:17:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1711F204;
        Fri,  6 Jan 2023 06:17:50 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1801385pjd.0;
        Fri, 06 Jan 2023 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SpYtqdexoOn7vFsrOUZd864+MNnlIa5g6erRp4Mt8I=;
        b=E2OrihHz7cE9adZTMdMxBYDRUj+CeqBn8RhEkH9MyuiN4CgrtMH7lNFj28naP7FNEQ
         HofEjS8ZRLLtppn4WlrjCSsvM+qZLX+EGLra+zBJlaywM+lrj/n5j50cWIWRIIGYyV8j
         JSRcezxOJO1bpqW/mZXRRGyqqH/RQsmM5hSTe0kuZuyuaG2zlLh4yG4dWNRAsXksGV8S
         b+bwkN0UQbuamuWL8lsboo8t6FYmfgvjT+0Jy2KtchcPZY/k0kg1uGO5lvOoH8utNYpM
         sr6kxFf1YuB2awE1FiW4Jk/XbY/dNZZxKq8D6d0zxZDyZfQc0JsIfUUBM/tFKFzjrDaf
         fxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SpYtqdexoOn7vFsrOUZd864+MNnlIa5g6erRp4Mt8I=;
        b=JRUIM/HydpOaHwltLqW2K6AFnRfQt7rDrc0RhzTNCyT8tMovCn2NscQy7TL5M1bVjn
         qIrJ0uW4Ice6zsRCNjz5I7uH4p4zIC0OTnh7vGWTy0fPmJIGBlw0CVwho4mRn8897uoz
         Q+h8mr9WuqXm3AiXlrtUvNwCvrjy8ebZQpjYqV+m5VwFkjhZqnfofwNE+vB7kBkYwDau
         Pt6gvMU72Y1wcZWLLjOiXMvfMbOowEBfVxaPCNGxMCUoB/zVa/pBZIi7Av5pxSGdsmMx
         oB4s7p7fAZ/Cp9XTRjO6AqBSno4mSKX7RsOJEkOuX0HlfcDTHbPEnQ76NKSk3YCH1ExH
         otWg==
X-Gm-Message-State: AFqh2kop9+J+uVDYa6UZf/WoxidsJgk1CNXmYmOHYt5LAkwKRVhGT34m
        OEJkdFDb72umW+RpLCe/f3sLnzRlcIBd2CYdLfw=
X-Google-Smtp-Source: AMrXdXuQBaB6JkkEFS+6iuB6JXqLAcCO5pgNhfbKsDBTh2Zne+JNYyYKobT2sQdG09bb2GqU2hWYsTcZs6QLdGYltPQ=
X-Received: by 2002:a17:903:1c4:b0:190:dced:6319 with SMTP id
 e4-20020a17090301c400b00190dced6319mr4462769plh.16.1673014669266; Fri, 06 Jan
 2023 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <20230104141245.8407-3-aford173@gmail.com>
 <CAMuHMdUECsuW2BC_AxjBpvqEfLF3wpk6xXnrma=--s65vX99_g@mail.gmail.com>
In-Reply-To: <CAMuHMdUECsuW2BC_AxjBpvqEfLF3wpk6xXnrma=--s65vX99_g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 6 Jan 2023 08:17:37 -0600
Message-ID: <CAHCN7xJhHXTmf+rVf9JsMyT0ZdLGGpMktMXO4Gwc5BCHoitp6w@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r8a774[a/b/e]1-beacon: Update
 corporate name
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 8:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Adam,
>
> CC GregKH
>
> On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> > At the end of 2021, Beacon EmbeddedWorks was sold off from Compass.
> > Its legal name is now 'Logic PD, Inc. dba Beacon EmbeddedWorks" and
> > as far as I know Compass Electronics doesn't exist anymore.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright 2020, Compass Electronics Group, LLC
> > + * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
>
> IANAL, but I don't think this change is appropriate: the copyright date
> is 2020, which is the year when the file was created, and the copyright
> owner at that time was Compass.  The current copyright owner is the
> current owner of the assets of Compass, which may change again in
> the future.
>
> I'm also not aware of people changing copyright headers for code owned
> by now defunct companies, see the existence of code still copyrighted
> by e.g. Motorola Inc., Digital Equipment Corporation, and Compaq
> Computer Corporation.
>
> If/when you make (substantial) changes to these files, you can add a
> "Copyright 2023, Logic PD, Inc. dba Beacon EmbeddedWorks" line.

OK.   We can drop this patch from the series.

thanks,

adam
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
