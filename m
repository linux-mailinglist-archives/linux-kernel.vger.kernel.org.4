Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA6B025F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCHJGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCHJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:06:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D0BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:05:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id n18so13902389ybm.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678266326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+Gsc/3GU1aL454j0TvLIwKL6VxxplPTSU5IedqKYCE=;
        b=hdx/naIPzuExXjPXbsIhTZSzkT39OKSRuDdJljda2MuslBlEALQM/hi+Woivug3zQI
         rCQUPqSHdraFcGLXfQYuDSHRUsVwwGgV7CDt68+hkInq6Qt9SOVTZnb1kA9c6XLFRW+Z
         IuoHrVn5tjvZEP46gs1USYuVR5Rq92+h4Sld8cRORR5ud+5VNr41MmkkGFpkkKKl+9ob
         kqmVorJdoScOvxeG4iNn0hmrEigu5zq7fjB4e2Jtlz4rQmpZwX7wfDJcZnB0g7HpIhNg
         1yotUrIrnbvjpwT/k8tJF+89xs1i3ohJvAeFaWjB7RzU2SCeelI8uOuoggJxpZGTZS/6
         0I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+Gsc/3GU1aL454j0TvLIwKL6VxxplPTSU5IedqKYCE=;
        b=NDM9fJrt+8T2im2AvagOHEYLdsgu/qOC6P+vjySLcbsHtUU28wgCR5bGG0zf72exes
         Nx5yXicFvGiKxPPlZU/laT58Itkx45AK2iOXa4rCTQysQ+qClBTZPnpIrjUMBWJJkQFU
         g3U1xzgcEoJ345FZ24VfEk0BfUluIUpKfbtn3IolFXxagyeWhZ7MmBMJ9STkvumzJiXc
         KMWKJEsyN9NdM+PJrAZeT3cAczHw3pkxe4Oea3DxmKwdB7HNqnabOx/fTxCtqd3GPrK0
         6yGzubvnQuPWj3epmKwELedoHL6HbFG0ru+RmFPxsQie955ZVzhHkeQredhW4OzF6J41
         kxJA==
X-Gm-Message-State: AO0yUKUOmsP9G614qxpE5wEAzs810ffv7vfOGE5hGdbWR/sFK7sHYFhm
        HrH9Dv/azG7HVWcN4oq/PWpuzi+WTSNm3nui3coZug==
X-Google-Smtp-Source: AK7set8oQJ3lXsPwsFRAWSx8foJvxXELmNh/z6zSGhaX5S/xpQI7+FPlNjghBoufbgsCZ8Ei+JiE6jGLBW6Bguxoo8g=
X-Received: by 2002:a5b:1cb:0:b0:9f5:af8a:3b61 with SMTP id
 f11-20020a5b01cb000000b009f5af8a3b61mr10644887ybp.4.1678266326271; Wed, 08
 Mar 2023 01:05:26 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com>
 <ZAcNhtm/+mik1N2m@gondor.apana.org.au> <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
 <ZAf/rAbc3bMIwBcr@gondor.apana.org.au> <ZAgDku9htWcetafb@gondor.apana.org.au>
In-Reply-To: <ZAgDku9htWcetafb@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Mar 2023 10:05:14 +0100
Message-ID: <CACRpkdZ-zPZG4jK-AF2YF0wUFb8qrKBeoa4feb1qJ9SPusjv+Q@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 4:40=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
> On Wed, Mar 08, 2023 at 11:23:24AM +0800, Herbert Xu wrote:
> >
> > Nevermind, I know why it doesn't work.  It's specific to ux500
> > where you're polling the DCAL bit.  But the DCAL bit only works
> > for the final hash, it doesn't work for the intermediate state.
> >
> > Let me check how the old ux500 handled this case.
>
> Hmm, it seems to use the same bit.  I guess the meaning must be
> different with ux500.

Not sure if it's that or if we were just lucky, or the tests were not
as extensive back on the old driver :/

> Could you check for me which wait_busy() call is actually failing?
> Is it the one I added right before we save the state, or is it
> something else?

It times out - always - before writing the HMAC key in
stm32_hash_xmit_cpu().

So this:

                stm32_hash_set_nblw(hdev, length);
                reg =3D stm32_hash_read(hdev, HASH_STR);
                reg |=3D HASH_STR_DCAL;
                stm32_hash_write(hdev, HASH_STR, reg);
                if (hdev->flags & HASH_FLAGS_HMAC) {
-                       if (stm32_hash_wait_busy(hdev))
+                       if (stm32_hash_wait_busy(hdev)) {
+                               dev_err(hdev->dev,
+                                       "timeout before writing key in
stm32_hash_xmit_cpu()\n");
                                return -ETIMEDOUT;
+                       }
                        stm32_hash_write_key(hdev);
                }
                return -EINPROGRESS;

Gives:

[    4.812106] stm32-hash a03c2000.hash: allocated hmac(sha256) fallback
[    5.008829] stm32-hash a03c2000.hash: timeout before writing key in
stm32_hash_xmit_cpu()
[    5.017167] alg: ahash: stm32-hmac-sha256 final() failed with err
-110 on test vector "random: psize=3D0 ksize=3D70", cfg=3D"random: may_slee=
p
use_final src_divs=3D[<fl"
[    5.041034] alg: self-tests for hmac(sha256) using
stm32-hmac-sha256 failed (rc=3D-110)

I put error messages at all other timeouts too but they do not
trigger.

This is why non-HMAC works fine all of the time.

> If it's something perhaps we aren't restoring the state in the
> right way, because the stm32 state restoring code is quite different
> compared to the ux500 code.

It's just the HMAC that is failing so I'm puzzled, because until
this point it is essentially a clean SHA sum.

I also noticed that it only happens with long keys (more than
64 bytes) that need to set bit 16 (HASH_CR_LKEY) in the control
register.

> Could you also confirm that the old ux500 driver actually passes
> all the extra tests on your hardware? It literally saves and
> restores the state every 256 bytes :)

I had this old patch set where I tried to clean up the old driver:
https://lore.kernel.org/linux-crypto/20220816140049.102306-1-linus.walleij@=
linaro.org/
I put this old patch set on top of v6.0.

First I enabled the old crypto driver without extended tests: all works fin=
e.

Then I enabled the extended tests. It does seem like it has
the same problem!

[   25.486878] CPU: 1 PID: 91 Comm: cryptomgr_test Not tainted
6.0.0-00016-g23791565aac5 #3
[   25.494967] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[   25.501932]  unwind_backtrace from show_stack+0x10/0x14
[   25.507175]  show_stack from dump_stack_lvl+0x40/0x4c
[   25.512236]  dump_stack_lvl from nmi_cpu_backtrace+0xd4/0x104
[   25.517988]  nmi_cpu_backtrace from nmi_trigger_cpumask_backtrace+0xdc/0=
x128
[   25.525034]  nmi_trigger_cpumask_backtrace from
trigger_single_cpu_backtrace+0x24/0x2c
[   25.532952]  trigger_single_cpu_backtrace from
rcu_dump_cpu_stacks+0x10c/0x150
[   25.540173]  rcu_dump_cpu_stacks from print_cpu_stall+0x14c/0x1d0
[   25.546268]  print_cpu_stall from check_cpu_stall+0x1cc/0x26c
[   25.552013]  check_cpu_stall from rcu_sched_clock_irq+0x74/0x16c
[   25.558017]  rcu_sched_clock_irq from update_process_times+0x68/0x94
[   25.564377]  update_process_times from tick_sched_timer+0x60/0xec
[   25.570470]  tick_sched_timer from __hrtimer_run_queues+0x15c/0x218
[   25.576737]  __hrtimer_run_queues from hrtimer_interrupt+0x124/0x2b0
[   25.583090]  hrtimer_interrupt from twd_handler+0x34/0x3c
[   25.588489]  twd_handler from handle_percpu_devid_irq+0x78/0x134
[   25.594498]  handle_percpu_devid_irq from generic_handle_domain_irq+0x24=
/0x34
[   25.601640]  generic_handle_domain_irq from gic_handle_irq+0x74/0x88
[   25.608000]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
[   25.614187]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[   25.620462]  call_with_stack from __irq_svc+0x98/0xb0
[   25.625514] Exception stack(0xf10ad970 to 0xf10ad9b8)
[   25.630563] d960:                                     c1d59a00
40000013 c056bbfc 00005f32
[   25.638734] d980: 00000000 00000008 f10ad9e0 00000020 c1f69bc0
c1f69bc0 c2364140 f10adb34
[   25.646904] d9a0: 00000000 f10ad9c0 c056da50 c099d1ec 20000013 ffffffff
[   25.653512]  __irq_svc from _raw_spin_unlock_irqrestore+0x1c/0x20
[   25.659605]  _raw_spin_unlock_irqrestore from regmap_read+0x50/0x60
[   25.665882]  regmap_read from hash_hw_write_key+0xd8/0x100
[   25.671377]  hash_hw_write_key from init_hash_hw+0xd8/0xfc
[   25.676862]  init_hash_hw from hash_hw_final+0x88/0x36c
[   25.682089]  hash_hw_final from ahash_final+0x58/0x9c
[   25.687138]  ahash_final from do_ahash_op+0x20/0x98
[   25.692019]  do_ahash_op from test_ahash_vec_cfg+0x68c/0x984
[   25.697677]  test_ahash_vec_cfg from test_hash_vec+0x64/0x168
[   25.703421]  test_hash_vec from __alg_test_hash+0x158/0x2d8
[   25.708991]  __alg_test_hash from alg_test_hash+0xc0/0x170
[   25.714474]  alg_test_hash from alg_test.part.0+0x378/0x4b8
[   25.720044]  alg_test.part.0 from cryptomgr_test+0x24/0x44
[   25.725537]  cryptomgr_test from kthread+0xc0/0xc4
[   25.730334]  kthread from ret_from_fork+0x14/0x2c
[   25.735036] Exception stack(0xf10adfb0 to 0xf10adff8)
[   25.740081] dfa0:                                     00000000
00000000 00000000 00000000
[   25.748252] dfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   25.756422] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

I can't see 100% if it is the same issue but it does hang on something
related to writing keys.

So for Ux500 at least I suppose it would be best to inhibit .import and
.export when using HMAC with long keys unless I can figure out exactly
what the issue is here. I wonder if that is possible?
Or do I have to remove it from the HMAC algos altogether?

Yours,
Linus Walleij
