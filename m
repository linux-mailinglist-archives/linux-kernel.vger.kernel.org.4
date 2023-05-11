Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408EB6FEB60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEKFrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKFrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:47:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4EC9D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:47:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so10341543276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683784068; x=1686376068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQlEekySQF52YhMHEw8D5nR4uh5gqpXzONo/bL8otQk=;
        b=pOwlZcdAxRKV4NPMj2MYMEiA7b+8IuYtKRiioIOQhYnNjfvtqf2X/6x/p9UUqUXpQ+
         I1Zzs+jqmpXVaoyAcioTHsfEfUllCBRXSZTNz2RHbs9hBCXREIhtQ/VSFPNOxMy1nnvI
         3ZAbpMUt7ALzI4OmJRAnWcF6YDL76R2LQkgR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784068; x=1686376068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQlEekySQF52YhMHEw8D5nR4uh5gqpXzONo/bL8otQk=;
        b=SFW7eEB6z3cWDLQrqAzu34KPW06rfsXsumukifDg1dyIZ58Zq8OxnMT7nVgSfs8pPw
         btLO3CZ9/74E5jP8nHz8XZffSxB4/3avoOrgPKijlsV7GTwELWxk9AMDHkudflucbrAg
         Icw0s29VK6q7z2bY1wwOEMajmJbh0p8BVAQbW5WA/OIl2be/WRW6GY+uNExLE3AwmvrY
         GL0ZSLqaBoNk1B66nuS/sybSPcYKeTJmNN66r2dcvwHNkZspiAVRuCyoNZJ9dc5n4Yhb
         YPXBohjBZP57P6jDXccmms1jwzWTDTStCe0FVGUKZU3NkdIdNPLZVKz3lZyhsQxOKjNO
         WKhg==
X-Gm-Message-State: AC+VfDw2L7nCsNS7xLSTCrnzHCRihNa/OoXJgvAKsEdM5vEsw9+oWKqv
        bwu02gYt2Vs/RW/fgtjLHQOwGIpCl5+sRGlIdc2qoNDDR6VQYBkEXTY5yQ==
X-Google-Smtp-Source: ACHHUZ6wAWXHrv0njSSijEPO06hDqDVAN1MRuN/Wpg52wSUEiT5gS3hrjznfhj1BXxXu0vgJSGG5XX7lztgwZfy00HQ=
X-Received: by 2002:a25:f81d:0:b0:b9a:7845:ebdd with SMTP id
 u29-20020a25f81d000000b00b9a7845ebddmr19604793ybd.17.1683784067743; Wed, 10
 May 2023 22:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop> <20230510171238.2189921-5-paulmck@kernel.org>
In-Reply-To: <20230510171238.2189921-5-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:47:36 -0700
Message-ID: <CAEXW_YQNRQuPP8GzHMZXWPoLmbpK3rB_+eVXmiRu6RrsihrEpQ@mail.gmail.com>
Subject: Re: [PATCH rcu 5/6] doc/rcutorture: Add description of rcutorture.stall_cpu_block
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> From: Zqiang <qiang1.zhang@intel.com>
>
> If you build a kernel with CONFIG_PREEMPTION=3Dn and CONFIG_PREEMPT_COUNT=
=3Dy,
> then run the rcutorture tests specifying stalls as follows:
>
> runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4" \
>         bootparams=3D"console=3DttyS0 rcutorture.stall_cpu=3D30 \
>         rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_block=3D1=
" -d
>
> The tests will produce the following splat:
>
> [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> [   10.841073] rcu_torture_stall start on CPU 3.
> [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
> ....
> [   10.841108] Call Trace:
> [   10.841110]  <TASK>
> [   10.841112]  dump_stack_lvl+0x64/0xb0
> [   10.841118]  dump_stack+0x10/0x20
> [   10.841121]  __schedule_bug+0x8b/0xb0
> [   10.841126]  __schedule+0x2172/0x2940
> [   10.841157]  schedule+0x9b/0x150
> [   10.841160]  schedule_timeout+0x2e8/0x4f0
> [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> [   10.841195]  rcu_torture_stall+0x2e8/0x300
> [   10.841199]  kthread+0x175/0x1a0
> [   10.841206]  ret_from_fork+0x2c/0x50

Another way to get rid of the warning would be to replace the
cur_ops->readlock() with rcu_read_lock(). Though perhaps that will not
test whether the particular RCU flavor under testing is capable of
causing a stall :-).

>         rcutorture.stall_cpu_block=3D [KNL]
>                         Sleep while stalling if set.  This will result
> -                       in warnings from preemptible RCU in addition
> -                       to any other stall-related activity.
> +                       in warnings from preemptible RCU in addition to
> +                       any other stall-related activity.  Note that
> +                       in kernels built with CONFIG_PREEMPTION=3Dn and
> +                       CONFIG_PREEMPT_COUNT=3Dy, this parameter will
> +                       cause the CPU to pass through a quiescent state.
> +                       Any such quiescent states will suppress RCU CPU
> +                       stall warnings, but the time-based sleep will
> +                       also result in scheduling-while-atomic splats.

Could change last part to "but may also result in
scheduling-while-atomic splats as preemption might be disabled for
certain RCU flavors in order to cause the stall".

> +                       Which might or might not be what you want.
> +

Suggest drop this line ;-).

 - Joel

>         rcutorture.stall_cpu_holdoff=3D [KNL]
>                         Time to wait (s) after boot before inducing stall=
.
> --
> 2.40.1
>
