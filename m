Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEB6CF3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjC2T6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjC2T6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:58:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6A5FFE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:58:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54184571389so314052257b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680119912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4EJkdGyxMVcGxifO1qafyN9ve0DpJKcD1zNZPvkoOQ=;
        b=X7Pqfv0UK+v9i1cGCHrYEiTNG6rNWMy3nKSoSP69TUwEbb/VWxwJVWvgxXWGmfs0Ap
         y9phc0S0DAoRi77m3KGFUynMRyqcy59esvGK2+OUdkAQwkwL+sitXQu+ABjPu61jJ3IN
         fCySkM3AHpmLiN2nDRaI4fqn1aiywYTNjl09Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4EJkdGyxMVcGxifO1qafyN9ve0DpJKcD1zNZPvkoOQ=;
        b=XV+KEXETAWARSTp4QP7j6KFepAi6MrmS8Vyfl0KwohozrCPOKD9eHtasvS5I7t2aF8
         vEkatTnmL52iL3YAhfl1dtra955+ktbyvLbS/c7TDZzv92ZTSjTSgQjXKQE0atinf97M
         PfRo9xZAJPcgx6zWTtxjExRMdfRwktREbV8jofGZ7BFbR4E8K0dnsjQWRJjHvUJEdtdN
         RINw2LyLRr/tr1geiAGCJF6+bQ7GRfaQq7rmdm5kOlG0AFvZHhfClbii4njdaZrgpDNg
         Zat5fqSg14IGmMfTknPWqVhNxkmlhFp1QwZ07QYLAo3XB8Cc3Ynyw4A2p7BF9QZHDzuW
         Uu0A==
X-Gm-Message-State: AAQBX9elwsyUIlJphbNx0/29aqITJ9NyGbbN+Oilv1jz5nqQSYQ5oOvM
        KfpzKbZVyNXCtJ/GRnY2ziicrxJPTJKj2IVuSv5qH6SnJL483r6ZGSc=
X-Google-Smtp-Source: AKy350Zxl1w9uKQOFJbJozgdk2onV0JTPFVvHfQK6FKbD2iD8tQ3HNsJrLn371sk+ohcuprwiigk4AQFfG32UhEiIkY=
X-Received: by 2002:a81:e308:0:b0:532:e887:2c23 with SMTP id
 q8-20020a81e308000000b00532e8872c23mr10210700ywl.9.1680119912635; Wed, 29 Mar
 2023 12:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230328121609.68105dd5@canb.auug.org.au> <4fd06223-e307-50e6-f4ec-40ca34fc1a4b@gmail.com>
In-Reply-To: <4fd06223-e307-50e6-f4ec-40ca34fc1a4b@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 29 Mar 2023 15:58:20 -0400
Message-ID: <CAEXW_YRMjXpRoss_cgF_mghseZbY-86UouDmcLbVW-oOpZ_D2A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rcu tree with the rdma tree
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:38=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.com=
> wrote:
>
> On 3/27/23 20:16, Stephen Rothwell wrote:
> > Hi all,
> >
> > FIXME: Add owner of second tree to To:
> >        Add author(s)/SOB of conflicting commits.
> >
> > Today's linux-next merge of the rcu tree got a conflict in:
> >
> >   drivers/infiniband/sw/rxe/rxe_mr.c
> >
> > between commit:
> >
> >   5bf944f24129 ("RDMA/rxe: Add error messages")
> >
> > from the rdma tree and commit:
> >
> >   330f72b82ab0 ("RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep(=
)")
> >
> > from the rcu tree.
> >
> > I fixed it up (the code modified by the latter was moved by the former,
> > so I used this files from the former and applied the following merge fi=
x
> > patch) and can carry the fix as necessary. This is now fixed as far as
> > linux-next is concerned, but any non trivial conflicts should be mentio=
ned
> > to your upstream maintainer when your tree is submitted for merging.
> > You may also want to consider cooperating with the maintainer of the
> > conflicting tree to minimise any particularly complex conflicts.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 28 Mar 2023 12:12:24 +1100
> > Subject: [PATCH] fixup for "RDMA/rxe: Add error messages"
> >
> > interacting with "RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep=
()"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband=
/sw/rxe/rxe_verbs.c
> > index 84b53c070fc5..bbdfbff5c752 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > @@ -1341,7 +1341,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struc=
t ib_udata *udata)
> >       if (cleanup_err)
> >               rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_err)=
;
> >
> > -     kfree_rcu(mr);
> > +     kfree(mr);
> >       return 0;
> >
> >  err_out:
>
> Thanks, I thought we had already done this. If not then we should. This i=
s the correct fix
> for that rcu mightsleep business.
>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
>

Bob, could you please squash Jon's diff into your original patch
("RDMA/rxe: Add error messages".) before you send your pull request
for 6.4? Then I can just drop my patch.

That will be best. WDYT?

thanks,

- Joel
