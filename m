Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A56374B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKXJEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiKXJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:04:30 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929A1121C2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:04:27 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-142faa7a207so1286588fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GskdefzDhpEJdGPupN73trBGgVe2XcooqSs6tZjZg+E=;
        b=clwCIfMJqaJ0fQEwDkADVQu6BE0lfReVFb9n6+9d/WHIJrWK8pmsDFzcHSNh+q5FL5
         iKMqTRrVgT6nmZgmVV5KZe1LTGExe3COTBFaCFVkThZC3MzR6gY8ibDhMstZoLLjE1+j
         CXZ9MEW17ik+wp8O823aI2Z2hERUesuhNOmSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GskdefzDhpEJdGPupN73trBGgVe2XcooqSs6tZjZg+E=;
        b=sVt0S6jX3sAUSyIRbmpH8ToPO58yMh8/3BVC3TOS5w6lfpGU3kJ4uDjhW1F9T/+mL8
         lK3HtA5/VQAkVE8UNU2t/ekNIzUlt+bXIaRqMx7Y6l/oa6OS+31M6fszZBW8Vi+A7fSZ
         8IS3tFa/IxPv2pr6cqPGaU0v23+/qrLSoxuTYJ0FaZB7uKnREKh0Zz7ZVJXMhxMzOHSP
         NaoGS1ATfQSg3TtUaqZ2iAbwnH9O6D4DfM8Q1eGJ/EeMt/hgmz4EM+6npYWFbzMsMlil
         ALE9XmLkRUbj3AH2P71TBts3mgoMDiAZM0rHEpPCKnpVignzOa3Ul97sNhFh0bIK1eda
         jvZg==
X-Gm-Message-State: ANoB5pnuBk5u0wI0X88HYr2DgcGO9j6Wryq0/898iu07RlreihDD4G1o
        DCDeHEZ3q6DcI7uqFk5m1h+BqKDpFgGuQeJ5C112
X-Google-Smtp-Source: AA0mqf48nDcZ5pOw8inOJMr+cmGIXfYN/bZRBYRNG8WluVWZ7S+k4L2pJQZvJLssjgZFGEwvT+XVs+wM4BU4BUdqbpM=
X-Received: by 2002:a05:6870:c18a:b0:142:870e:bd06 with SMTP id
 h10-20020a056870c18a00b00142870ebd06mr15305401oad.181.1669280666095; Thu, 24
 Nov 2022 01:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20220718170205.2972215-1-atishp@rivosinc.com> <20220718170205.2972215-6-atishp@rivosinc.com>
 <20221101141329.j4qtvjf6kmqixt2r@kamzik> <CAOnJCULMbTp6WhVRWHxzFnUgCJJV01hcyukQxSEih-sYt5TJWg@mail.gmail.com>
 <CAOnJCUKpdV3u8X6BSC+-rhV0Q8q2tdsa8r_KTH5FWCh2LV2q8Q@mail.gmail.com> <20221123133636.gke3626aolfrnevy@kamzik>
In-Reply-To: <20221123133636.gke3626aolfrnevy@kamzik>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 24 Nov 2022 01:04:15 -0800
Message-ID: <CAOnJCULUH09HPZL6Ks-xUsiDLQPR6xOv2g+ic9Gd3uwea6hCyQ@mail.gmail.com>
Subject: Re: [RFC 5/9] RISC-V: KVM: Add skeleton support for perf
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 5:36 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> ...
> > > > > -     csr_write(CSR_HCOUNTEREN, -1UL);
> > > > > +     /* VS should access only TM bit. Everything else should trap */
> > > > > +     csr_write(CSR_HCOUNTEREN, 0x02);
> > > >
> > > > This looks like something that should be broken out into a separate patch
> > > > with a description of what happens now when guests try to access the newly
> > > > trapping counter registers. We should probably also create a TM define.
> > > >
> > >
> > > Done.
> > >
> >
> > As we allow cycles & instret for host user space now [1], should we do the same
> > for guests as well ? I would prefer not to but same user space
> > software will start to break
> > they will run inside a guest.
> >
> > https://lore.kernel.org/all/20220928131807.30386-1-palmer@rivosinc.com/
> >
>
> Yeah, it seems like we should either forbid access to unprivileged users
> or ensure the numbers include some random noise. For guests, a privileged
> KVM userspace should need to explicitly request access for them, ensuring
> that the creation of privileged guests is done by conscious choice.
>

If I understand you correctly, you are suggesting we only enable TM
bit in hcounteren ?
We also need a mechanism to enable the hcounteren bits from KVM guest userspace.

I can think of the following approaches.

1. The CYCLE, INSTRET enabling can also be via one reg interface.
2. We can enable it during first virtual instruction trap if these
bits in guest scounteren
are enabled.

> Thanks,
> drew



-- 
Regards,
Atish
