Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52EB70F6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEXMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:45:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04C99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:45:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5344d45bfb0so140892a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684932316; x=1687524316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fQg7SojCw83NDMnJJByptDQfnCAuKoOFAlu1j20Vos=;
        b=SdLR5A8tB3EbaBOoKbQN6vD3E3F0bDBdOEMBYN3hmErA9RoVOxFx7Pl24I+m/h/f6V
         iTL2fUEBj4UtotE2q/+Vx449LVFW8KwvfmSAyMsf2nAxkv2yewAvLyJf9tn+ogaMlFx4
         Sq4fwCESPQqR2FKdetU9ix2IcIF+EKTUwVIoboxdwUx3I6CUDIeQHK6mPEMOjDV4PK1O
         1xTm26X4I0rW1abckYVUkoVL4Ach1CScd2NSIqq+LsrXNBeAx/dKLeKhdwEtIeX3qZ33
         yO21yTZUqyzKJL0QXfJ/d63b83fESU5iyO4e+90AUh44F7HojtEm4Yqk751f3+kmtJIT
         61Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684932316; x=1687524316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fQg7SojCw83NDMnJJByptDQfnCAuKoOFAlu1j20Vos=;
        b=XUH2vOm2hCX16x/BI0UojWsDQpMfQqH6izDFp16i2wP8aPDOmkOWaVLhRdWyikeibM
         pU0hB7AnRR/3NpSndBijhe0JYJaJSxACkBtNyr8yICNqKKaw/G7hfavAHnbQAkwgO64u
         iAo4LfnXfK/D2Iz2Ddym+YoT4TP+Igy2eSyuy2RxPb7FFBnPFZBjOr1xyIMie/TSHMPJ
         EGpsUkEz124CUadKYpLXfCyWwoE24KpvdjkSP25zEoZanEXCd1VmAjuE4UUjEd1VT2dB
         oi1zoED3CueAY4FFyDrlgpANT9hE3BvXGAg8OWIOhrt30O3p9D5JL6QcI6hR7tlT017E
         EYAg==
X-Gm-Message-State: AC+VfDxFzDpZLICWGkZx61A7M9HJaufE7yOr6+Y5HFj2/UO5MvagIDUd
        r32dquO3KvO4e+iKCSis9kFvpZiW6iGUMKWL72c=
X-Google-Smtp-Source: ACHHUZ6YQdpPG6WJb7zPLg26UU5R8g7bxvRzXEpTmxW8ayWIcH7KTAYa2ton22HY5z6MRHN3glZn5s+c2x3v3k4eX9Y=
X-Received: by 2002:a17:90b:1e05:b0:252:85ab:41d1 with SMTP id
 pg5-20020a17090b1e0500b0025285ab41d1mr19828335pjb.3.1684932316322; Wed, 24
 May 2023 05:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230518230626.404068-1-aford173@gmail.com> <CAOMZO5DBefFuLWi39txu2RiU5vdHVx-0T48Fua6M5Y6Fr9PGNg@mail.gmail.com>
 <CAHCN7xLqmMPtnHTVbApyYxY2tx97oRjsk_51abdDcZkOJmA=Tw@mail.gmail.com> <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
In-Reply-To: <CAHCN7xJTWqf_qfaZge4GpKuuzPE_OC-Kx7hBd_hFLOchH=Ef0g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 May 2023 09:45:04 -0300
Message-ID: <CAOMZO5Csjx17kfkxN1xMLuCg+-J0v6rjiuvaK-ZktXO50ZTuSw@mail.gmail.com>
Subject: Re: [PATCH V7 0/6] drm: bridge: samsung-dsim: Support variable clocking
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>
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

Hi Adam,

On Tue, May 23, 2023 at 8:49=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> Inki,
>
> I haven't heard back from you on whether or not you want the bindings
> patch to be included with me resending the series as V7 or if you're
> OK with a single, stand-alone patch.
> Will you let me know?  I have the patch standing by waiting for
> instructions.  If you're not the right person to ask, please let me
> know who the right person is.

Neil has also been collecting samsung-dsim patches. Maybe he can clarify.
