Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8053172D9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbjFMGi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjFMGiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:38:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5200E69
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:38:24 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb167972cffso5628565276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686638304; x=1689230304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExFAj+YgJRdRcaCWeS0swTQHLCbPFVpzMAWP4t/hdrY=;
        b=XD9BVgoHBc61quB8SKkRdCfvYhK8MJcPLnNCWAYsPU5WIzK2/2TTwZyP9udjVpgYA/
         FsBDlIdaKIGc9oEnIq09TT8rnC6bpo5pqJs+ZSiMUirX6nFtj6YNKbwaUwSllrxtZToR
         E7ket0iUDu6T5Dh2dp6hIRY7ouWrv7yWe1HnwsgoFZbhSX+nCKzj94TDPSOPuW32iLSC
         QISB2MjGvLPxMZdIHPVXmqJ8Pz2tEnpD/KwNvtBCS1DjsyZbgufM5m6ORyzzVhtc/Ext
         LZ0xxaGcDpXGLzTuzdt3+AljxbgH2C8W9HBiNzDdcGrvHyUp5I7yGkDHSMEIZ047ciPH
         +LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686638304; x=1689230304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExFAj+YgJRdRcaCWeS0swTQHLCbPFVpzMAWP4t/hdrY=;
        b=fC8Kmuikpj3qdVS4ZA2iCdlSsVGxCzqRcp5YvgnZgmfJ2GVXmuiUbie0GnCHj9eKPk
         6nDlLHOqo7b7M6OMPjCd/xIbWwcYA7SffNJJipG/SMw/XM56z3+5UfAUI757yyGVPerM
         J89w0MU4PEOaDShHUER1l+BEs5d34ea/vUtnAZjOfBI+gzQ3X98UpZgk+/IryWCHPzLV
         +PtMLzUKUiwtmzJR7qvO9/cMyTi5jF0GZyQw1rd0bNyfw2rPRlLbCxRZmweZ5V02ENfO
         e8IfU80ppaaReKnKwdROw6yG6/JCSXoYwKRJZlLmaAuZvayv4w5qM53hFMBMOX/N7yc1
         4P+g==
X-Gm-Message-State: AC+VfDzPEMGBGPPmStv6Ri16wrBdDeXIerdcn+HRO3+uDSqTzKpvF/5r
        q2wVUlT5WWAYMJ0S54hNduhA9n/MijOP+kq0nuJ4XQ==
X-Google-Smtp-Source: ACHHUZ4QzMJOoKPnaIGmwIbagx01FpWCVjHkLLUN+4G5m0jH7BZUYj/pTq7XAyCGG7FQm15egVvbVCTXizmRW8ney74=
X-Received: by 2002:a25:26c8:0:b0:bd0:78cd:99dc with SMTP id
 m191-20020a2526c8000000b00bd078cd99dcmr846694ybm.37.1686638303955; Mon, 12
 Jun 2023 23:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230613104329.025f9e4b@canb.auug.org.au>
In-Reply-To: <20230613104329.025f9e4b@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 08:38:13 +0200
Message-ID: <CACRpkdZZX_iiN-XTG1ORqr2mpiOsJvLTOr3Lxertq9jgb=H03w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 2:43=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> After merging the arm-soc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/input/touchscreen/ads7846.c: In function 'ads7846_get_props':
> drivers/input/touchscreen/ads7846.c:1126:24: error: cast from pointer to =
integer of different size [-Werror=3Dpointer-to-int-cast]
>  1126 |         pdata->model =3D (u32)device_get_match_data(dev);
>       |                        ^
> cc1: all warnings being treated as errors

There is already a patch, I'm sure it's on its way in:
https://lore.kernel.org/linux-input/20230609202722.3634721-1-arnd@kernel.or=
g/

Arnd can you apply this patch to the SoC tree where the cause
(by me) is? It's on top of the OMAP GPIO cleanups.

Yours,
Linus Walleij
