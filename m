Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC86A0152
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjBWCzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjBWCzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:55:45 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6034C34
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:55:43 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id d7so7087692vsj.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677120942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AZET/dAHnThSMI4ijShZNNiovoZM2A1RWGGjD4Jr3zI=;
        b=cQA7kltWBFhKaJFUORao4wek6jqjyO5D4kYl2n7nRPq3J23ED5n+McNlruyi43uuZl
         07VJ9zt4Nm++tPV3fZ0GPkp+rOqEcek1ldgMMLzR4f36/FF8Wx5t3CKAazBh3Z13hddI
         B6W1eOUUTqWrpMBR7j9rrOPL8xVjOZ680Q5kmvqASZuxgvTrFGqiAJ142h0x2kc0WyH5
         2yZF2L3He+AN7F3B9MVgRoQ6mGhm6rZ//a0QfDtrX3ML2Jo0k74YIAXyAXFaqd+V5q1j
         xruLkqG7LM1OPIR415ZcAjCnV4/6IEcL4uqzIcrQ9dhQgQhHI8v+wa3uUdGhv0LCzUEf
         gGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677120942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZET/dAHnThSMI4ijShZNNiovoZM2A1RWGGjD4Jr3zI=;
        b=H4d45JLMVisAia4RSfEDV5d7CD8WqXTVfXpZo0fZtnEfsp2NDpey6kmR6yCiI8b/5T
         m0hGcGWrdHu7LZpvvpKhd0tcbR4Z4fQuxXL2NgZxoAVQwigRKnctuHsqtAjjbvwhKw/S
         IsAhuGZ1JV9fWI1fXi7oFVzp8FfV4FP6olQ4MjAIvx+j94DHl/gVm6S9wIMMdUNJoEIY
         enowZCAJG+EfzRo8WAExC/kbO9LCBSmX062oXYTPTuyJvk12RqmZ8VWhDx8ey81Npq8H
         5eMJTB7vgqQ19nLYV26U2Eif9lB1CdTB3NCQIv1I/GC/cgExyCgP/bISuujdvXaosv6O
         tOOA==
X-Gm-Message-State: AO0yUKVrfklwufi5uvIAdi443ecVngmSoOEW+ZVhrXrWaQN5ILtDzTYV
        2GhMhNgezfue+/XTJoCfO/sGzclYH/TybecJWpmTpg==
X-Google-Smtp-Source: AK7set+xIQn5l60WL9i2IviMkablDKXnJOMl8YCsfmyE5doLc73GdhGypaDze9dw46Wo8k5gVoLEbV4HXYtU7CRLrck=
X-Received: by 2002:a1f:7ccf:0:b0:406:1e33:3ddb with SMTP id
 x198-20020a1f7ccf000000b004061e333ddbmr1856299vkc.1.1677120942440; Wed, 22
 Feb 2023 18:55:42 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Feb 2023 08:25:31 +0530
Message-ID: <CAK9=C2Uy_0B6D2TGq35sfrGkp9s1Td=cEsidzDPTDhG7Nq5EWw@mail.gmail.com>
Subject: Re: Perf event to counter mapping question
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Beeman Strong <beeman@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 5:58 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> Hi All,
> We are trying to figure out what is the best approach to define the
> perf event to programmable counter mappings in RISC-V.
> Until recently, all the programmable counter/event selector registers
> were writable in M-mode (highest privilege mode) only. The firmware
> residing in M-mode
> would discover the mapping from device tree[1] and the perf driver
> relies on SBI PMU[2] interface to discover the mapping between event &
> counters.
>
> There are new ISA extensions being proposed to make counters /event
> selector register in supervisor mode as well. Thus, a pmu driver
> can directly program the event selectors without relying on firmware.
> However, the kernel needs to be aware of counter mapping to do that.
>
> AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> much easier. It just needs to pick the next available counter.
> On the other hand, x86 allows selective counter mapping which is
> discovered from the json file and maintained in per event
> constraints[4].
> There may be some legacy reasons why it was done in x86 this way[5].
> Please correct me if I am wrong in my understanding/assumption.
>
> Here are a few approaches that can be used to solve it in RISC-V.
>
> 1. Continue to use device tree bindings
> Cons: We have to define similar entries for ACPI. It makes
> virtualization difficult as the VMM has to discover and update the
> device tree/ACPI as well.
>
> 2. Mandate all-to-all mapping similar to ARM64.
> Note: This is only for programmable counters. If the platform supports
> any fixed counters (i.e. can monitor
> only a specific event), that needs to be provisioned via some other
> method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> AMU not PMU.
>
> 3. All platforms need to define which subset of events can be
> monitored using a subset of counters. The platform specific perf json
> file can specify that.
> This approach provides more flexibility but makes the code path a bit
> more complex as the counter mask constraint needs to be maintained per
> event basis.
>
> 4. Any other approach ?

I suggest a 4th approach where by default the kernel assumes all-to-all
mappings and optionally perf json file can be used to override mappings
for certain counters. This approach is more like a hybrid approach between
approach #2 and #3. It work fine with KVM RISC-V as well because Guest/VM
will assume all-to-all mapping for logical HW counters whereas Host can have
specific counter mappings.

>
> Any thoughts on what would be the best approach for RISC-V. It would
> be great to repeat any past mistakes in RISC-V by learning from
> experience from the community.
>
> [1] https://lore.kernel.org/lkml/Y6tS959TaY2EBAdn@spud/T/
> [2] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc#function-find-and-configure-a-matching-counter-fid-2
> [3] https://elixir.bootlin.com/linux/v6.2/source/arch/arm64/kernel/perf_event.c#L899
> [4] https://elixir.bootlin.com/linux/latest/source/arch/x86/events/core.c#L876
> [5] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1978937.html
> --
> Regards,
> Atish

Regards,
Anup
