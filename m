Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8106F6298
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEDBR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjEDBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:17:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5291BD9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:17:25 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso9346213276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683163044; x=1685755044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYRGESarX6qEq9ibuyR0jftRtbsKubLTTBm4ZRHsvzk=;
        b=IWO4xqtJg8wum15Mg3GzDQ+4gchHB4md6VixumuvhUg1jc1kZfj/8MaSZyoKOEEroR
         FuVxAxIFZu8KV6H/fojY/Z5SxziRD4DLosX5BmCNCamgJo7ehaK9HdNIpErFf9M96HLw
         JHAMwh99sVnz6KmxvFX7eJ3EbwevwOX2Aes3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683163044; x=1685755044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYRGESarX6qEq9ibuyR0jftRtbsKubLTTBm4ZRHsvzk=;
        b=f1j97g9rJIPgJR4TQbLlmgi6aq6GyEg5VCd4lNfnYx9siZOKFY72iMZSPPyXJFngeC
         MTelG+z9dP/x0cYgjhC0tvMz/Vb0V2jH1fu/8qv3ObsPZyZgQHzaoZO98XpETdH36lOd
         IKCLkLhUp9wGvNV83qn/UMOyloe5SHLeBC3IBc2vXb2BFeB6yDp0s0vtIgNo3sTyCb7a
         V4zssw31u/bUpWXZ4wktfVNYeSm5YWwWrdkjqXmxMw0eP+uMjhn2rLr7kLpW8XNeCP/e
         h8gdbFoF024dAIGhHasGNSXJ5wjU6UbHNw4QejtTL/cL5cHmBpEgvmukvRQXbeOsSUEk
         X0zA==
X-Gm-Message-State: AC+VfDyKGCfxseX3gG+5IquNmue9hwOtsyhXfCdWHI0EwcJQbJH71t1U
        R03JaTvS5e8lNqeOPVJpWse7Fx720k5ute+eYWhoCTtz+GAIWPTS1uA=
X-Google-Smtp-Source: ACHHUZ7xm5KIuHRud/dGwGaS6aNX7WB5DERzd325Xo9CLEXybvD9t4XF4Q2jey/zcsWNIMlXe7WeI5rm3j94w7oDxz4=
X-Received: by 2002:a25:40d7:0:b0:b8f:54a4:9a55 with SMTP id
 n206-20020a2540d7000000b00b8f54a49a55mr22210494yba.65.1683163044327; Wed, 03
 May 2023 18:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 3 May 2023 21:17:13 -0400
Message-ID: <CAEXW_YRkPrwL5uGthkmaBaxn9b4tcWDofdcTE=Lu6=yXeDNpWg@mail.gmail.com>
Subject: Re: [RFC PATCH] rcu: rcupdate.h: Add missing parentheses around macro
 pointer dereference
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 4:32=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
>
>   typeof(*p)
>
> rather than
>
>   typeof(*(p))
>
> The following test-case shows how it can generate confusion due to C
> operator precedence being reversed compared to the expectations:
>
>     #define m(p) \
>     do { \
>             __typeof__(*p) v =3D 0; \
>     } while (0)
>
>     void fct(unsigned long long *p1)
>     {
>             m(p1 + 1);      /* works */
>             m(1 + p1);      /* broken */
>     }
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  include/linux/rcupdate.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index dcd2cf1e8326..1565012fa47f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { =
}
>
>  #ifdef __CHECKER__
>  #define rcu_check_sparse(p, space) \
> -       ((void)(((typeof(*p) space *)p) =3D=3D p))
> +       ((void)(((typeof(*(p)) space *)p) =3D=3D p))
>  #else /* #ifdef __CHECKER__ */
>  #define rcu_check_sparse(p, space)
>  #endif /* #else #ifdef __CHECKER__ */
>
>  #define __unrcu_pointer(p, local)                                      \
>  ({                                                                     \
> -       typeof(*p) *local =3D (typeof(*p) *__force)(p);                  =
 \
> +       typeof(*(p)) *local =3D (typeof(*(p)) *__force)(p);              =
 \
>         rcu_check_sparse(p, __rcu);                                     \
> -       ((typeof(*p) __force __kernel *)(local));                       \
> +       ((typeof(*(p)) __force __kernel *)(local));                     \
>  })
>  /**
>   * unrcu_pointer - mark a pointer as not being RCU protected
> @@ -452,29 +452,29 @@ static inline void rcu_preempt_sleep_check(void) { =
}
>
>  #define __rcu_access_pointer(p, local, space) \
>  ({ \
> -       typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> +       typeof(*(p)) *local =3D (typeof(*(p)) *__force)READ_ONCE(p); \
>         rcu_check_sparse(p, space); \
> -       ((typeof(*p) __force __kernel *)(local)); \
> +       ((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define __rcu_dereference_check(p, local, c, space) \
>  ({ \
>         /* Dependency order vs. p above. */ \
> -       typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> +       typeof(*(p)) *local =3D (typeof(*(p)) *__force)READ_ONCE(p); \
>         RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"=
); \
>         rcu_check_sparse(p, space); \
> -       ((typeof(*p) __force __kernel *)(local)); \
> +       ((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define __rcu_dereference_protected(p, local, c, space) \
>  ({ \
>         RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() us=
age"); \
>         rcu_check_sparse(p, space); \
> -       ((typeof(*p) __force __kernel *)(p)); \
> +       ((typeof(*(p)) __force __kernel *)(p)); \
>  })
>  #define __rcu_dereference_raw(p, local) \
>  ({ \
>         /* Dependency order vs. p above. */ \
>         typeof(p) local =3D READ_ONCE(p); \
> -       ((typeof(*p) __force __kernel *)(local)); \
> +       ((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu)=
)
>
> --
> 2.25.1
>
