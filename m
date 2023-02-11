Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D50692C15
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBKAcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:32:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CCB1ADC5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:32:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h17so8209951ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLk3N6Go0BGyrEJaF9vC3EBGKIKqnzWEMDRO70teK4M=;
        b=cnBtBG0CW3B/2iQ2B5/D9xY8SBHkZx1vfdgXy1z6TvA1ugBr4M4WiTz9R2fksi0PFO
         MyYpbWlkauMp/ZpJbxXO4FEkuZQahxjrUzKPf2uRrdLf3pfQ7tSSoiyxrsfFrWNKzEf9
         kMz9+JMaxH+qfC3cg0oGhAcMDK4w+LmUTbhlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLk3N6Go0BGyrEJaF9vC3EBGKIKqnzWEMDRO70teK4M=;
        b=M2LmzuYnY259lLofzvig1C1c4r9j/D+SVUxPhfC4tAAz8TRlcWJJRY3ohXUodS6l2x
         NU8N4MiuqQdco8EniThn03/Xsgz8sr4VQVLdXaO1Z+8QbEYYyXPveuIcLnVof1CRl8eY
         VuFQEKMczYESZeIbSFC12Ao1hv7uwlKHlRvLVpaTRwK4T0hrj1v1KgwheLRd69q8/LXS
         aATTFT/c2gq02Ot6iPRPX0IDsh35FpCY+Ega/p0T6mr2C5Hfg1suBwHl4DjOnREelPMc
         CFp1Wx/G0SQG85189K9/VMwwvbj+gLXFELlhw7bjjxQ18G1/DzYJHpUszt6baPJzpzEy
         TQ/g==
X-Gm-Message-State: AO0yUKVOjUInLlHXHo6sxXcsta2TGinZ8whqDoDxK31jdsEU4e/GQedN
        Pp8MgEkoJlA830pS8K1qeBzCgEMoQgzs1sLGGdB9qIks0YYGwK8F
X-Google-Smtp-Source: AK7set9D/zU4cDYCyWxNtSbviTpbc/NX1394tyVjqRqUcNBQYTAUNU/eh7TnshobTDBv0iuuy9WJ9Z4u82/RZkkdT0c=
X-Received: by 2002:a2e:2f1e:0:b0:293:25c1:808f with SMTP id
 v30-20020a2e2f1e000000b0029325c1808fmr2060546ljv.154.1676075544135; Fri, 10
 Feb 2023 16:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org>
In-Reply-To: <20230204022051.2737724-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Feb 2023 19:32:12 -0500
Message-ID: <CAEXW_YQN-AxYV=Buxt7jv9VxHWB-hoSUBjJ3VXDoc945qK=5XQ@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
To:     linux-kernel@vger.kernel.org
Cc:     Qiang Zhang <Qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 9:21 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Recent discussion triggered due to a patch linked below, from Qiang,
> shed light on the need to accelerate from QS reporting paths.
>
> Update the comments to capture this piece of knowledge.
>
> Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  kernel/rcu/tree.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93eb03f8ed99..713eb6ca6902 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>         } else {
>                 /*
>                  * This GP can't end until cpu checks in, so all of our
> -                * callbacks can be processed during the next GP.
> +                * callbacks can be processed during the next GP. Do
> +                * the acceleration from here otherwise there may be extra
> +                * grace period delays, as any accelerations from rcu_core()
> +                * or note_gp_changes() may happen only after the GP after the
> +                * current one has already started. Further, rcu_core()
> +                * only accelerates if RCU is idle (no GP in progress).
>                  *

And I couldn't help but pass this through ChatGPT:

Before:
This GP can't end until cpu checks in, so all of our callbacks can be
processed during the next GP. Do the acceleration from here otherwise
there may be extra grace period delays, as any accelerations from
rcu_core() or note_gp_changes() may happen only after the GP after the
current one has already started. Further, rcu_core() only accelerates
if RCU is idle (no GP in progress). NOCB kthreads have their own way
to deal with that...

After:
In order to ensure all callbacks are processed efficiently, this grace
period (GP) must not end until the CPU checks in. To avoid unnecessary
grace period delays, it is important to initiate acceleration from the
current location. Any acceleration from the functions "rcu_core()" or
"note_gp_changes()" may only occur after the next GP has already
started. It is important to note that "rcu_core()" will only initiate
acceleration if the RCU system is idle (no GP in progress). NOCB
kthreads, on the other hand, have their own unique method for handling
this situation.

It sounds well written, but maybe a bit factually incorrect.. trying again:

To ensure all callbacks are processed in the next grace period, this
GP must not end until the CPU has checked in. To avoid any additional
grace period delays, it's important to perform the acceleration from
here. If acceleration is performed from rcu_core() or
note_gp_changes(), it may only occur after the next GP has already
started. Additionally, it's important to note that rcu_core() will
only accelerate if RCU is idle and no GP is in progress. The NOCB
kthreads have a separate mechanism for dealing with this issue.

Not bad, but the first sentence is still factually incorrect. Yes, I'm
bored..why do you ask? ;-)

I think except for the first sentence though, it made for a nice
grammatical re-write (give or take Frederic and Qiang's comments ;-)).

 - Joel



>                  * NOCB kthreads have their own way to deal with that...
>                  */
> @@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>                         /*
>                          * ...but NOCB kthreads may miss or delay callbacks acceleration
>                          * if in the middle of a (de-)offloading process.
> +                        *
> +                        * Such missed acceleration may cause the callbacks to
> +                        * be stranded until RCU is fully de-offloaded, as
> +                        * acceleration from rcu_core() and note_gp_changes()
> +                        * cannot happen for fully/partially offloaded mode due
> +                        * to ordering dependency between rnp lock and nocb_lock.
>                          */
>                         needacc = true;
>                 }
> --
> 2.39.1.519.gcb327c4b5f-goog
>
