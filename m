Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA56BC56F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCPFBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCPFBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:01:15 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105A96F03
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:01:14 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id cj14so497633ybb.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 22:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678942873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11L4bG0IazgBpc/bEo/rh1pO9WY2JB5Cnz+AF2jVWr8=;
        b=fydBYh7IDK/xvjeo2SE6lxrCjGPC+IFbnMkvDmZIVYWNE9a1+T0biSAJNkEBQNOe7n
         WlpAv9tapTceCe+CQJ946JS1yM6trhd+ts0BT7VYGQ6MI6iBUqgckqUi/g0JX25f0MjZ
         GEqYi5fs2ZKxRHY5jUvEg5vX2IaCy8daHE9S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678942873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11L4bG0IazgBpc/bEo/rh1pO9WY2JB5Cnz+AF2jVWr8=;
        b=FZzfLRMRhU7zRUqFikTP+F8247BCh+wtrDYRylgjAp5rXinVAuZgRIBKcgCQKbSFo5
         xqeedEttybLeGwS6v9O6vdx72QI8g8HxR5TmTrxmQuBfbsCWCehVvtnlEP+fV/HjOAnS
         CCa8S+f8Qekqjhh5tu4T2N6QbBajwotzTm+Z34GwuuarpHavdtixVhRzMe4uHHwScnWd
         mtvMcsyuiUR8JFerJyMlX5s4WspjEQjwxUjtlB/6XkU3zPKhnkRu6G230o7XLriNiHN8
         lrBcJcvomBwg9GKHaWR1G5DisdsRxoy/R2EpkHMzQmbsoLUhcnoyIdkk+Ll6Z4WHIWI9
         OJEQ==
X-Gm-Message-State: AO0yUKXLlulGAxxDNNrz7dhYdv4YxJ9zM+CSpKYx0VlfUf09omiteg0A
        7wdNk7j5ZWuVXKL13/qBnfyidYrjC+ZV/ZGOVoBhTg==
X-Google-Smtp-Source: AK7set8aa1EiJes/s4PujwskpdRqRkJmJ9T179Ig2lW/L0+La8ScHCtdmUNP+KtSer8igSxOllboZrq+shxRKlwciRQ=
X-Received: by 2002:a25:9292:0:b0:b3a:e877:3290 with SMTP id
 y18-20020a259292000000b00b3ae8773290mr8897010ybl.2.1678942873240; Wed, 15 Mar
 2023 22:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home> <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home> <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
 <20230315182628.39329315@gandalf.local.home> <CAEXW_YSMr7b4K11T6kjThG8-DyxNiJMU3LOo-SwQ+Ev8h9taMw@mail.gmail.com>
 <20230315225046.3cfed1ee@gandalf.local.home>
In-Reply-To: <20230315225046.3cfed1ee@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 01:01:02 -0400
Message-ID: <CAEXW_YRhTsr8Yx2HyrcuK5ziNPDEPV-GFc0FG=UCQ-1J4UnvXg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 15 Mar 2023 22:13:26 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > Why not call it kvfree_rcu_alloc() ? It allocates right?
> >
> > Sure, but one can say now that allocating is an implementation detail? =
;-)
>
> I was being sarcastic.
>
> But as the mighty Linus once said: "In the Internet, nobody can hear your=
 sarcasm"
>

I guess it's official then - the internet has killed sarcasm. I
suppose we'll all have to resort to using more obvious forms of humor,
like dad jokes. ;)

 - Joel
