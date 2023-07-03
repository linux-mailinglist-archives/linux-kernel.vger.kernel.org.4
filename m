Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAB746120
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGCRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGCRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:05:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA9E59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:05:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89bc52cd1so4376675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688403950; x=1690995950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YdKUgtYJMJrIMJYs9dXkGEz/jJa8FAqhLNPLHC6AiI=;
        b=gy1Or7k76ULxRye1QzJQRLzXBvn3UzqZ0dYITMQ8wPS5hp+E4sLRxw1hzflUpAEkkV
         i+DKhxmT4um90J3HcPIsDo/5GoZ4bnCcawTYJoSSb6aGOKkY5agM+nD/T+S7kYki71iX
         SqIDnCuQ9i0qfmuuBHdy6XFN6a4Xzf3VAcZYmokbrP+SWwScIWlZw/02tyIDmIheAR9q
         8mUFKZ2/bUlkRbDMz4t5QqFwYssNgrar/KkM+Xcwky+QCoke+dtxkvNkUTk4RoZMLI5R
         dCdbMU2WFnT9cuIdK4ObvCHHvHW1pKqperWPww52sH9RPNTEwculJHraZTwdsw0Otv2z
         Dw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403950; x=1690995950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YdKUgtYJMJrIMJYs9dXkGEz/jJa8FAqhLNPLHC6AiI=;
        b=GtVHC0o3CNPhw20RmSeiErueGqBhpoYa5jbbdvruj0IEi6zBLlLSq3vYPrqrYhcvq6
         ktv5tb4KJkL56YIgmL0Kz7hff6ENojH04Gn0Qzrm1O1xteVOxbxc32Hpva5z0wztO+FF
         rRlrZQNaZr6W0E4uClq7F5T6lcCn1AqbNLy7w/0HqzUknaB7vqJQy3avYkxD2IR4lv0k
         AQo6ASo+ByGqbxRTagLhrz8iTa6sbQ7UUCjcnFNx+9jrxDv7MjkdVrCE9HS+JGCQcgm2
         0bo1cDqkA3Sm0268q8RKFk54xFJw1OkcQ7e3FVOfpifgTEVH6RXxMp7O5OAnFvEFA1Zi
         tTKQ==
X-Gm-Message-State: ABy/qLYnOyFSzeBzAAweDvDvTT/SbsIzRR5aX0TnmyRggTGn9JeCEB+V
        mhRCeZp8Oe1k+nHWxbeiJV1ilYRt0BGD/9BD3XlG2bDm/kQ=
X-Google-Smtp-Source: APBJJlGtJ7Ru1Qc97PJ8b7TcYyUas2gHBkLJfvVRhm5JMQWUuDSWMhxJBq8WRi+y7VG60QUPZkBcwOmllFAV9vkeDMo=
X-Received: by 2002:a17:90b:886:b0:263:1720:f802 with SMTP id
 bj6-20020a17090b088600b002631720f802mr8813729pjb.30.1688403950226; Mon, 03
 Jul 2023 10:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230703123243.7795-1-duminjie@vivo.com> <CAMo8Bf+rgAnzMF732rzNgWbnmijFbr1yd5aCiY1Hcf4qdpj6FQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+rgAnzMF732rzNgWbnmijFbr1yd5aCiY1Hcf4qdpj6FQ@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 3 Jul 2023 10:05:39 -0700
Message-ID: <CAMo8BfKe1nR+UP1WiUWFX0E7GSEfHsF8bZapsUYu3NFTnA8_AQ@mail.gmail.com>
Subject: Re: [PATCH v1] arch: free dev before return
To:     Minjie Du <duminjie@vivo.com>
Cc:     chris@zankel.net, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, 11162212@vivo.com,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 7:19=E2=80=AFAM Max Filippov <jcmvbkbc@gmail.com> wr=
ote:
> On Mon, Jul 3, 2023 at 5:33=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrot=
e:
> >
> > We fixed a bug where the variable dev
> > was not freed before return.
> >
> > Signed-off-by: Minjie Du <duminjie@vivo.com>
> > ---
> >  arch/xtensa/platforms/iss/network.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Applied to my xtensa tree with the following commit message:
>
>    xtensa: ISS: fix etherdev leak in error return path
>
>    iss_net_configure frees etherdev in all error return paths except one
>    where register_netdevice fails. Add missing free_netdev to that path.
>

After testing it I realized that in that error return path the etherdev is
freed by the iss_net_pdev_release callback and that this patch
introduces freeing an active timer on that path. I've dropped this patch
and committed another one that adds a comment about what's going
on at that place.

--=20
Thanks.
-- Max
