Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977186F6FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjEDQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEDQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:19:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A33C0D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:19:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-555e853d3c5so6295907b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683217190; x=1685809190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISgqM4Z3Oi0FOwES04jIULNzOCOdZrHkvVQ6clhiCe4=;
        b=ynlJAFUVp16VnGFAJScNIgHM+CiYCqNDozchRl+hPTp9o4xLTK0eeMwFDFEWlqNBSW
         Zzekrq1mTZdQcZ4ik/Jc+HIgaIigtU9uBov2d+ivniTh2ZC55DULrczXWGPfRS6oNN+I
         GsY4CqQrSO9AsjbxTpvA10VGrkJf42ukc4U68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683217190; x=1685809190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISgqM4Z3Oi0FOwES04jIULNzOCOdZrHkvVQ6clhiCe4=;
        b=mH08aF/VQ186DuH6E0947ns/EzRXDZ/GjsmMsHcgfVHm+9l5BPGiDJXFCTVQLTYVV/
         MEtLoUZ3Zbr8dQf3aQqMPtJsNmnCIABizoPZ+N+N+vbt9fa8E8CayHXo/LCj94qvZqUF
         ejTjaNlp2Tv+xeX3eVD6lM7J7kVedDlN+0KehZvNDKMbGNlY76CCmW/j/JHYSwVsTMGF
         mu6lJSZqIwPFKy+wxfWP8z7shc1ERzYVIWYM229Wlxvt17Wyuau8b+Pc9odCwyn8E06X
         KReXievxHlm9oUeFj1d8d1Zv/a0xyq3VY7TttAOOl93n+xK6mIPSl3SlRCTqZyDT/eQ3
         PxUg==
X-Gm-Message-State: AC+VfDy56sBBKtKc24GlcO9Tz1W+SgX1+EXFSaPA7h9cwUCfzYsCXmvt
        6eE529qAuXGmw3zEjwvr7/VqvlywUw+nnvpUqgRtTA==
X-Google-Smtp-Source: ACHHUZ7Yp3+WQfq/QuEa5h/xCOquElst7AsS4IE2H03WFhR+n21PmV7Y1oY51U8ng8zmrYIyT+xj0V6XvA0P9ZapDIU=
X-Received: by 2002:a25:a4c5:0:b0:ba1:90ed:f7e7 with SMTP id
 g63-20020a25a4c5000000b00ba190edf7e7mr520110ybi.23.1683217189683; Thu, 04 May
 2023 09:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com> <20230504012914.1797355-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20230504012914.1797355-3-mathieu.desnoyers@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 4 May 2023 12:19:38 -0400
Message-ID: <CAEXW_YRoqwX1Z3OcRJKxDZ+jAN6Woby+avC9FTdP_8+xyuYqCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] rculist.h: Fix parentheses around macro pointer
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
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

Hello Mathieu,

On Wed, May 3, 2023 at 9:29=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Add missing parentheses around use of macro argument "pos" in those
> patterns to ensure operator precedence behaves as expected:
>
> - typeof(*pos)
> - pos->member
>
> This corrects the following usage pattern where operator precedence is
> unexpected:
>
>   LIST_HEAD(testlist);
>
>   struct test {
>           struct list_head node;
>           int a;
>   };
>
>   // pos->member issue
>   void f(void)
>   {
>           struct test *t1;
>           struct test **t2 =3D &t1;
>
>           list_for_each_entry_rcu((*t2), &testlist, node) {       /* work=
s */
>                   //...
>           }
>           list_for_each_entry_rcu(*t2, &testlist, node) { /* broken */
>                   //...
>           }

Yeah it is not clear why anyone would ever want to use it like this.
Why don't they just pass t1 to list_for_each_entry_rcu() ? I would
rather it break them and they re-think their code ;).

>   }
>
> The typeof(*pos) lack of parentheses around "pos" is not an issue per se
> in the specific macros modified here because "pos" is used as an lvalue,
> which should prevent use of any operator causing issue. Still add the
> extra parentheses for consistency.

The consistency argument is valid though.  I will stay neutral on this
patch. ;-)

thanks!

 - Joel



>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang1.zhang@intel.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/rculist.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index d29740be4833..d27aeff5447d 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -388,9 +388,9 @@ static inline void list_splice_tail_init_rcu(struct l=
ist_head *list,
>   */
>  #define list_for_each_entry_rcu(pos, head, member, cond...)            \
>         for (__list_check_rcu(dummy, ## cond, 0),                       \
> -            pos =3D list_entry_rcu((head)->next, typeof(*pos), member); =
 \
> -               &pos->member !=3D (head);                                =
 \
> -               pos =3D list_entry_rcu(pos->member.next, typeof(*pos), me=
mber))
> +            pos =3D list_entry_rcu((head)->next, typeof(*(pos)), member)=
;\
> +               &(pos)->member !=3D (head);                              =
 \
> +               pos =3D list_entry_rcu((pos)->member.next, typeof(*(pos))=
, member))
>
>  /**
>   * list_for_each_entry_srcu    -       iterate over rcu list of given ty=
pe
> @@ -407,9 +407,9 @@ static inline void list_splice_tail_init_rcu(struct l=
ist_head *list,
>   */
>  #define list_for_each_entry_srcu(pos, head, member, cond)              \
>         for (__list_check_srcu(cond),                                   \
> -            pos =3D list_entry_rcu((head)->next, typeof(*pos), member); =
 \
> -               &pos->member !=3D (head);                                =
 \
> -               pos =3D list_entry_rcu(pos->member.next, typeof(*pos), me=
mber))
> +            pos =3D list_entry_rcu((head)->next, typeof(*(pos)), member)=
;\
> +               &(pos)->member !=3D (head);                              =
 \
> +               pos =3D list_entry_rcu((pos)->member.next, typeof(*(pos))=
, member))
>
>  /**
>   * list_entry_lockless - get the struct for this entry
> @@ -441,9 +441,9 @@ static inline void list_splice_tail_init_rcu(struct l=
ist_head *list,
>   * but never deleted.
>   */
>  #define list_for_each_entry_lockless(pos, head, member) \
> -       for (pos =3D list_entry_lockless((head)->next, typeof(*pos), memb=
er); \
> -            &pos->member !=3D (head); \
> -            pos =3D list_entry_lockless(pos->member.next, typeof(*pos), =
member))
> +       for (pos =3D list_entry_lockless((head)->next, typeof(*(pos)), me=
mber); \
> +            &(pos)->member !=3D (head); \
> +            pos =3D list_entry_lockless((pos)->member.next, typeof(*(pos=
)), member))
>
>  /**
>   * list_for_each_entry_continue_rcu - continue iteration over list of gi=
ven type
> @@ -464,9 +464,9 @@ static inline void list_splice_tail_init_rcu(struct l=
ist_head *list,
>   * position.
>   */
>  #define list_for_each_entry_continue_rcu(pos, head, member)            \
> -       for (pos =3D list_entry_rcu(pos->member.next, typeof(*pos), membe=
r); \
> -            &pos->member !=3D (head);    \
> -            pos =3D list_entry_rcu(pos->member.next, typeof(*pos), membe=
r))
> +       for (pos =3D list_entry_rcu((pos)->member.next, typeof(*(pos)), m=
ember); \
> +            &(pos)->member !=3D (head);  \
> +            pos =3D list_entry_rcu((pos)->member.next, typeof(*(pos)), m=
ember))
>
>  /**
>   * list_for_each_entry_from_rcu - iterate over a list from current point
> @@ -486,8 +486,8 @@ static inline void list_splice_tail_init_rcu(struct l=
ist_head *list,
>   * after the given position.
>   */
>  #define list_for_each_entry_from_rcu(pos, head, member)                 =
       \
> -       for (; &(pos)->member !=3D (head);                               =
         \
> -               pos =3D list_entry_rcu(pos->member.next, typeof(*(pos)), =
member))
> +       for (; &(pos)->member !=3D (head);                               =
 \
> +               pos =3D list_entry_rcu((pos)->member.next, typeof(*(pos))=
, member))
>
>  /**
>   * hlist_del_rcu - deletes entry from hash list without re-initializatio=
n
> --
> 2.25.1
>
