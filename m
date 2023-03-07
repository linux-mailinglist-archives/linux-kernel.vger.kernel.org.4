Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CEB6AE66D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCGQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCGQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:27:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAD12F2C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:26:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so54517946edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678206389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gyN0Y9p8hJ4ax2W78FF1WA4EkbsuVJwY8Lp0RHjxAk=;
        b=XS3J9PKMVkp2llI3EniM5oVARXgLfq8B27XoVNkPr9G/6Dr14z6EOEiDHeM0ivzwI7
         aMzhtEsZG5dszunTWKFDmpH0BqHtJhXW2Rvj0iqHi/CL13Bmq3uU9nus9AAJbg12k9g3
         b91HMCrHEs6F+AOL4+ONelPHAw8pMm50VAt+W+iwD86cRNkHs90WDqwkIGbE6b+tePcD
         9pqDLDsrhCuC0vXJusPNfo+RJ6n+IYRvAUM+QpZwr4GqgPJF5Eo2KpkNP6gPtUCBGs+e
         LObE95EN/a5f7DJdKajPZW8Zt9gZh9+vC1PNxyK5R0pPIOEkh9dBrCOXr9qa8U6Tjd60
         OKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gyN0Y9p8hJ4ax2W78FF1WA4EkbsuVJwY8Lp0RHjxAk=;
        b=nI7gmV+vQDYimtBTn7sBMJpFvj3G+LB8gxGZ36kKFIv7KiB8d/t77DrcBGpxD7aqfa
         pgjtDI4Vz0fBhx+vBH90tevppQJsBEF7Jm04gBOc1h+N07dUP3usNmG4P2v7pOwW3SW+
         0qdBmN1hAKN0bRnDQFoA5xSQPfndfsJlGqoV2ro+duUhUkr6TkeUAdxh2eGyJ5d6zMqd
         DPpCeS7BDVwNm8dIBq18GOFXx6WN/OUkXNzQtwYGdH31qYWiJqn4Gdumvoofgf7S50Pk
         WIr16UQueH9+0AVY4wrVnhV59eCkOrAGK7N1CdcJ47JbtiXb3V/IlM3sZcPaCl4Dky7O
         hh0A==
X-Gm-Message-State: AO0yUKVEadCi/6gM2j0CuSzjYjdj3lPG07WbR03CFdw0SsGmyz4JyBrB
        l+/OuqcPlBpgiIQ2i8rOBi0543/GnZeWmUZ0ncQUyHnamrXLlagm
X-Google-Smtp-Source: AK7set+MKhM5nzwXvuYxHTjDStwp5VRKkrpFSwuzzH15A+TQ1olYMZoJ9YWSvbiN8Oe2+lhRulwR/yvpLoNDaBmGhoE=
X-Received: by 2002:a17:906:ce38:b0:8b1:30da:b585 with SMTP id
 sd24-20020a170906ce3800b008b130dab585mr7545049ejb.6.1678206389353; Tue, 07
 Mar 2023 08:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20230306152810.ptb622tfhoxehhdc@mobilestation>
 <20230307122021.1569285-1-void0red@gmail.com> <e4ac3d74-9a91-e4ff-eee3-67237f35ac7b@intel.com>
In-Reply-To: <e4ac3d74-9a91-e4ff-eee3-67237f35ac7b@intel.com>
From:   Kang Chen <void0red@gmail.com>
Date:   Wed, 8 Mar 2023 00:26:17 +0800
Message-ID: <CANE+tVo98AZuRGcAshv5W6v2+fKjTruDVRRdgjfyAVk93cC3_g@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_tool: check null return of devm_kcalloc in tool_init_mws
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     fancer.lancer@gmail.com, allenbh@gmail.com, jdmason@kudzu.us,
        linux-kernel@vger.kernel.org, ntb@lists.linux.dev
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

What a cool tool, thanks for your suggestions.

On Wed, Mar 8, 2023 at 12:06=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 3/7/23 5:20 AM, Kang Chen wrote:
> > devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> > and will cause null pointer dereference later.
> >
> > Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API suppor=
t")
> > Signed-off-by: Kang Chen <void0red@gmail.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>
> You forgot to pick up my review tag. I do recommend using the tool 'b4'.
> It picks up all the tags for you and works rather well.
>
> > ---
> > v2 -> v1: add Fixes and Reviewed-by tags
> >
> >   drivers/ntb/test/ntb_tool.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> > index 5ee0afa62..eeeb4b1c9 100644
> > --- a/drivers/ntb/test/ntb_tool.c
> > +++ b/drivers/ntb/test/ntb_tool.c
> > @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
> >               tc->peers[pidx].outmws =3D
> >                       devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw=
_cnt,
> >                                  sizeof(*tc->peers[pidx].outmws), GFP_K=
ERNEL);
> > +             if (tc->peers[pidx].outmws =3D=3D NULL)
> > +                     return -ENOMEM;
> >
> >               for (widx =3D 0; widx < tc->peers[pidx].outmw_cnt; widx++=
) {
> >                       tc->peers[pidx].outmws[widx].pidx =3D pidx;
