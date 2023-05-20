Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E662F70A54E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 06:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjETEWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 00:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjETEWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 00:22:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BF61BD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:22:50 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561f10b6139so24355077b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684556569; x=1687148569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtTOSvtfQG93Oel0meKxRB+k4uCHs3I7uk0ZTZm75x8=;
        b=Q1EECUwMrhw+/VXBEDI08aoB2G39WG+y6CST9973Czb0jNct9GJ8fvqXwZQ02FdRM3
         cKLG5mt5dpzf002oCDfbU9jbnIZTqsxzdoQXfTG73/oJYi0BZ/JZMm9ASd56fOw4H4Nz
         LLq9BTdtd8cU7BNRVp9zQyK8+mPz4vJYBcLFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684556569; x=1687148569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtTOSvtfQG93Oel0meKxRB+k4uCHs3I7uk0ZTZm75x8=;
        b=S8QbpDAmlpvQJd87NbO5yob4mQmbC2q/GJ0uAYyT7f/ixc9zfnr7R+rPmUcpyyekCA
         x6UIVOcueOVK8RcEk72gID7ntcSVU6OrTHXviXw7+sEeZIlY35vrbh+lbAewOoZMxxKO
         MXcokgiksDqbBiEXZ9SsttyuLoc/T+p8jb0nOCZnCKVb8fjp8a+dWgOx/ke2ZU+rbFF4
         nGb9fI1ZwygJbtI52kHnj9RfuFRg7rpBa4iiXyqkHvJA3/j58XgQXJSeBLDNc6bX3dXa
         exDWwohgWg3MOXout5WXwh9uNBQf/4bLF1bOZjbefZqR0/TZp2zxob3cP5xh52UKBga2
         Z/8g==
X-Gm-Message-State: AC+VfDzktn6zbhlAK2zHRBH+L1jsSUM3Jevo3FRP/ApLepCWpGgre4S+
        9tVZ3Yifm5zSMvdw4xplwCsPF061Y5ofFMsFMMfFow==
X-Google-Smtp-Source: ACHHUZ4NMcs0KKTciTfhFcPKbClou7h2OuXMWrw7zvwLfXuyRiIvLoBZUabWp3vqHHxnFyfuxaywKWAJmJPzE4ag+II=
X-Received: by 2002:a0d:e288:0:b0:545:637c:3ed7 with SMTP id
 l130-20020a0de288000000b00545637c3ed7mr4458531ywe.1.1684556569453; Fri, 19
 May 2023 21:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
 <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
 <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com> <CAEXW_YS-ScBYeTtj7PTZSSYXeApsZ1vhTpBFtq5jNA_R9055=Q@mail.gmail.com>
In-Reply-To: <CAEXW_YS-ScBYeTtj7PTZSSYXeApsZ1vhTpBFtq5jNA_R9055=Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 20 May 2023 00:22:38 -0400
Message-ID: <CAEXW_YRbekxrn4iUvWGzJBfwMButjT=srHZS2H9P910K8YmH=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
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

On Sat, May 20, 2023 at 12:14=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Sat, May 20, 2023 at 12:01=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, May 19, 2023 at 8:57=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > I also realize that I don't really need to check whether the masked
> > > source address falls under a VMA neighboring to that of the source's.
> >
> > I don't think that's true.
> >
> > You can't start randomly moving other source vma's that may have other =
contents.
>
> If the beginning part of the PMD is not mapped at the destination, I
> thought maybe a whole PMD could be moved to it. But I guess not
> because we don't want those contents to be accessible. So then in that
> case we have to forbid the optimization for all intra-VMA moves except
> those involving the stack. I will think more about it.

Duh, we can't move crap from the source like that also because it has
real data. I think I got confused between "moving" and "copying". I
feel silly, maybe it is time to go to sleep and live to fight another
day.

 - Joel
