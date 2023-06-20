Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE8736C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjFTMz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:55:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F31708;
        Tue, 20 Jun 2023 05:55:54 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39cc64e4a44so2321166b6e.0;
        Tue, 20 Jun 2023 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687265753; x=1689857753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GShgRfKOlKpaj1lYu1lbhujHhsIiz6oBYw+aZwN2suk=;
        b=gT7XttF1usxTwCr5o1fye/3TbEl3DyoL4Si5Gq+549INcVZ4cITvxqRioY75rGzaXf
         vY3DaIvXuVnTNXpd3PZ9qR7V5YkelgouSzwdUjpdGTQ37HuFYLFuTDsN69hBhNV9kpnn
         B5godEPEYcOfzDuMLKw5MawmLp/PBi24zz2r9M/x0AGQalc9e4ui/Rdr8wS8dQyVzasv
         zhweJ5FN3gYkAX0wGVFiuHALZXM0WMCx0QBlrEGmKro/5us4NXAw6qkKjddZUnf8ZCEU
         S9U7cgjjDBFUYxFHstqtprFN2O6vci0P/wQnm8wZtfeJUFthfsNEgWiDp4ENAGhBNmTT
         TA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687265753; x=1689857753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GShgRfKOlKpaj1lYu1lbhujHhsIiz6oBYw+aZwN2suk=;
        b=aOMAVdgqb8MBZ8ZmzqSDzFq3b5ZoGcBZA1r5DFi6EnoBY9QclY5V1YY8iFcXN3GEvZ
         AaPlgfxvXSGoKLdyazQZtrUr5Z135gihDeP3ducIDI4k93W7pmawnpfs3lJypH6TIYw4
         PlE1P5XhNrBLCbcPAnKUhKNiMOi7OfANhpcr0KEmfDq63n9LYsDMKUnQlAhemzvvo/C4
         Suyn/U+2CoLLfGAFfkTbzje9aFvtUlHJweGZ9WPEK+1MZooqz8IOCRak8Ldvhi65Yn4l
         5L4sP+DPkUfpnYLA7WQvqA6WJRs3dNe5cvqXh9YeT3wvbteKFK7tATWLCdR9t4gOFSQc
         7oUg==
X-Gm-Message-State: AC+VfDxU5r3vicqIWi/p3wT/Ln9jkFH8Jc/hvvjP5ADpo5kK0fITC7Tn
        DM/tj7SHvDY9ibOWS7uuySA4ILVNeMV8Wh54KxY=
X-Google-Smtp-Source: ACHHUZ6EXdRg19WgE9D1h2RX/uXFxNvdR5GSzNLlrzNdXvNt3naipadmMZcuONmeryIn14ckDYYLfF+mGwE/WAAtLy4=
X-Received: by 2002:a05:6808:2202:b0:39e:ae9e:b6ac with SMTP id
 bd2-20020a056808220200b0039eae9eb6acmr11458931oib.49.1687265753695; Tue, 20
 Jun 2023 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <OSYP286MB03120BABB25900E113ED42B7BC5CA@OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OSYP286MB03120BABB25900E113ED42B7BC5CA@OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 20 Jun 2023 14:55:41 +0200
Message-ID: <CAMhs-H_OtDgJmBrcrN33goXDM19WJr1+Za+G9tibMZrO+9KL1A@mail.gmail.com>
Subject: Re: [PATCH] mips: ralink: introduce commonly used remap node function
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        tsbogend@alpha.franken.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
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

On Tue, Jun 20, 2023 at 1:46=E2=80=AFPM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> The ralink_of_remap() function is repeated several times on SoC specific
> source files. They have the same structure, but just differ in compatible
> strings. In order to make commonly use of these codes, this patch
> introduces a newly designed mtmips_of_remap_node() function to match and
> remap all supported system controller and memory controller nodes.
>
> Build and run tested on MT7620 and MT7628.
>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/ralink/common.h |  2 --
>  arch/mips/ralink/mt7620.c |  9 ---------
>  arch/mips/ralink/mt7621.c |  9 ---------
>  arch/mips/ralink/of.c     | 42 ++++++++++++++++++++++++++++++++-------
>  arch/mips/ralink/rt288x.c |  9 ---------
>  arch/mips/ralink/rt305x.c |  9 ---------
>  arch/mips/ralink/rt3883.c |  9 ---------
>  7 files changed, 35 insertions(+), 54 deletions(-)

Awesome! More deletions than additions in arch folders is always a
good thing :-).

Changes look good to me. Thanks for doing this!

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
