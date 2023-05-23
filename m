Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8883D70DA70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjEWK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEWK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:26:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A5109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:26:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f601283b36so51695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684837579; x=1687429579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1H76tKbgjPFeSY6ce6Fy9Gg5JTky+hF4vrdziz1dy0=;
        b=datsF4F2PP91XwOTePCnE1IMO83smQN6dzZrt4pSdfmrMJz/RpZ7LwT03X+EaUF0sd
         3rMkYOfLFESd5YmuX4zNZb/wrFuvu4CsKcAMiKg34oFacNxTgVMyh2JeHUNnpI9C1mrl
         R7cv8pq5JJtpcKdNwHjwUX59UBTSf3gnDCbZ8nSH6EYNHpzY08Pm4k2WNiAST5ZCzzrN
         rrrhoAFvFs9gpr8ARkVZekdzHyjebqv/1I/MUf+CRsZuAKsyY32IajkjH5A9jR3H1RBF
         Bt1DVgD3COqdnPE5J5XBtkgIyn05Bm7Jtbvz4wpuW+yJknid7JXRCuJ3uvK0mJeM8YDS
         1LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684837579; x=1687429579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1H76tKbgjPFeSY6ce6Fy9Gg5JTky+hF4vrdziz1dy0=;
        b=JgAT0GspLx0+O6/dCw+Po0EVoCnm1l7Nvo6zj14+ZTk8k9Nc/0Hxh973en3XfsLJDg
         X6aEMsNFWvPE5682r5wqPaaIWZU7Z22x3Zg4BCRMSwPJM9fc1xNwXvuWK0Wl7Q31++1V
         ep9Iaabt589R77xF5RiXpZk9W6ftMHo1Jl5Iyfr53aOpGkeRNU7TldBfaN768J9esyXL
         FAZ1myHW8/ayDVvCwThGa/Kk+217i+LFllWokjUD0N34H4wmjrNtYDyqsa8cVDxpwtMM
         US+Cx4wrkQnNX3UUGpR5qFcfL1HWdbLt5kI0XLkL9aLF0uXvtfUc5fSLDTq72ts3zjZP
         zKFg==
X-Gm-Message-State: AC+VfDzHde4PDle2taMEDkJPFwRdzUEm4jx6f/qbmkSgZdsUBkz1ZVmp
        CTv0IjuQz/OmwGSy1fHvEx4CsxLTXH0RPQMlcAeGLA==
X-Google-Smtp-Source: ACHHUZ7p/LxtpjcqvWmqtAZKSYkPYql8MUrCOUd2n55sPHU1VYSxR9YvliEd4xR2jzKu+OHpmRmJtmXUX2xRF8ev38Y=
X-Received: by 2002:a05:600c:1e0f:b0:3f2:4fd2:e961 with SMTP id
 ay15-20020a05600c1e0f00b003f24fd2e961mr165715wmb.0.1684837578832; Tue, 23 May
 2023 03:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124201.441634-1-imagedong@tencent.com>
 <20230517124201.441634-4-imagedong@tencent.com> <CANn89iKLf=V664AsUYC52h_q-xjEq9xC3KqTq8q+t262T91qVQ@mail.gmail.com>
 <CADxym3a0gmzmD3Vwu_shoJnAHm-xjD5tJRuKwTvAXnVk_H55AA@mail.gmail.com>
 <CADVnQynZ67511+cKF=hyiaLx5-fqPGGmpyJ-5Lk6ge-ivmAf-w@mail.gmail.com>
 <CADxym3ZiyYK7Vyz05qLv8jOPmNZXXepCsTbZxdkhSQxRx0cdSA@mail.gmail.com>
 <CADVnQy=JQkVGRsbL0u=-oZSpdaFBpz907yX24p3uUu2pMhUjGg@mail.gmail.com>
 <CADxym3awe-c29C-e1Y+efepLdpFWrG520ezJO1EjJ5C3arq6Eg@mail.gmail.com>
 <CADVnQyk2y68HKScad4W2jOy9uqe7TTCyY-StwdLWFPJhXU+CUA@mail.gmail.com>
 <CADxym3bbGkOv4dwATp6wT0KA4ZPiPGfxvqvYtEzF45GJDe=RXQ@mail.gmail.com> <CADVnQymzzZ9m30-1ZA+muvmt-bjaebtMT0Bh8Wp5vXZuYifONQ@mail.gmail.com>
In-Reply-To: <CADVnQymzzZ9m30-1ZA+muvmt-bjaebtMT0Bh8Wp5vXZuYifONQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 May 2023 12:26:06 +0200
Message-ID: <CANn89i+K1vo=suwPR43MHeRera513sof7Sz8Qz2tGS3WfWW=OA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: handle window shrink properly
To:     Neal Cardwell <ncardwell@google.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 5:04=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Sun, May 21, 2023 at 10:55=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
>
> > BTW, a previous patch has explained the need to
> > support window shrink, which should satisfy the RFC
> > of TCP protocol:
> >
> > https://lore.kernel.org/netdev/20230308053353.675086-1-mfreemon@cloudfl=
are.com/
>
> Let's see what Eric thinks about that patch.

I have not received a copy of the patch, so I will not comment on it.
