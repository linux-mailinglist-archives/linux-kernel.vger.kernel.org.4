Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF96FB91C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjEHVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjEHVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:02:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BF47AB5;
        Mon,  8 May 2023 14:02:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f14e499ffcso3874488e87.0;
        Mon, 08 May 2023 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683579771; x=1686171771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kd2Xog2CzdWfsNMCGKzahYuxxTGGaQSyxOqU/nCMlRg=;
        b=TvJHhQsgSiGPzy0bZX++m+kpMy435ANFg7O7wEEqm8XcQiQWrmJiFlNCZixoyjmYhv
         MWxY1B4CRUPVb99RFTQkVdNYwwblxY38pvAGiRysm5qxtNMUhSm8aTd11av0U74WeP+/
         6cWx5fAhURy110BxUldpCKJwSUk3jPCPfW45RUc9vj8tq1m547asOcOOrBz3wJqpiVV5
         ZJxbeQsW3PGjHZpGPRdsc4xHKDhXcgGHAmcmepeuGiPFFYCHGT+30nrCJj87yFMUShBQ
         sqQAdC3/tqDkNf5yjctsu7Uk+hSTCByAwX/VQsDKOxLdJX8oO9p2pYvuKFAyWKHnGwjY
         nLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579771; x=1686171771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd2Xog2CzdWfsNMCGKzahYuxxTGGaQSyxOqU/nCMlRg=;
        b=dDCMO5sdF8RCBtjNjmVTE/hgeZncVbEKnosan6HSuwVVUMQukkWQ18YB+rCKJDPnkY
         jLaI9VR1Gc3MFxSFsX13K4XAabrbD7+t+wZtdLt1XyV2Q2oleoWGDeUCk4Z6N7ORdTBi
         MmA711+o47S1LJw7vtayb3fo8nVtzeu07NeY09oxBQZR8K3mbiBcVBc9eWRnck0hmS+1
         jxHWzvEBuF/sH4e1M1fa6R47RgWZ/V9H6t7bufMbcwNiRnb/rTtBxg6cO5J9ia6KG7oP
         EQ11qUYKct/WZ4TGMGvDAHeHcn/Y7VRAmbynn0CK0NkBP1EFbi25xkNURgC5yi9rAwLL
         ftXA==
X-Gm-Message-State: AC+VfDxpzK6C1Mp3v2VGjQB87np/T1JQcQ/a/tFwaWJajsS5g6RljLu0
        e4fzb7XeZUve4cnr/5Tabv/GoWwfukfakyDVKpM=
X-Google-Smtp-Source: ACHHUZ52pW5HxluZ1u+Pw0Z71TaIRwgKnLc4G6jzKjdH5uvj9OxwbnK6ZO5X8oEZP02WzCb1XmtF/GLnj+Tl3i1xPDc=
X-Received: by 2002:a19:f51a:0:b0:4f1:3eea:eafe with SMTP id
 j26-20020a19f51a000000b004f13eeaeafemr98209lfb.45.1683579771384; Mon, 08 May
 2023 14:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <3bff7eeb-72ef-42c0-b569-cd93355ab7ed@t-8ch.de>
In-Reply-To: <3bff7eeb-72ef-42c0-b569-cd93355ab7ed@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 16:02:22 -0500
Message-ID: <CAOOmCE9o0f-r8546FF-hbpvD8OoXjrZfyCFv90wLs+Lz4-qhkg@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] HP BIOSCFG driver
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Thomas,

No problem at all.  Any time you can provide me is greatly appreciated.
Thank you for letting me know.

Regards,

Jorge

On Mon, May 8, 2023 at 3:57=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> Hi Jorge,
>
> On 2023-05-05 17:00:30-0500, Jorge Lopez wrote:
>
> <snip>
>
> >  .../testing/sysfs-class-firmware-attributes   | 117 ++-
> >  MAINTAINERS                                   |   6 +
> >  drivers/platform/x86/hp/Kconfig               |  16 +
> >  drivers/platform/x86/hp/Makefile              |   1 +
> >  drivers/platform/x86/hp/hp-bioscfg/Makefile   |  12 +
> >  .../x86/hp/hp-bioscfg/biosattr-interface.c    | 319 ++++++
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 982 ++++++++++++++++++
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h  | 523 ++++++++++
> >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 482 +++++++++
> >  .../x86/hp/hp-bioscfg/int-attributes.c        | 448 ++++++++
> >  .../x86/hp/hp-bioscfg/ordered-attributes.c    | 443 ++++++++
> >  .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 584 +++++++++++
> >  .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 381 +++++++
> >  .../x86/hp/hp-bioscfg/string-attributes.c     | 415 ++++++++
> >  .../x86/hp/hp-bioscfg/surestart-attributes.c  | 133 +++
> >  15 files changed, 4860 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/biosattr-interfa=
ce.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.=
c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/ordered-attribut=
es.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attrib=
utes.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attribute=
s.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/string-attribute=
s.c
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attrib=
utes.c
>
> Unfortunately I'm not sure I'll find enough time this week for a full
> review of this revision.
>
> I'll review bit by bit as time permits.
>
> Thomas
