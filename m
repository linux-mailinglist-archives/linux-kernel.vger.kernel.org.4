Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC453689192
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBCIGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjBCIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:05:50 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1795D2C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:04:12 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s67so3122874pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 00:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7HGUCnUWkPRHR5V5XRcjLIGICmpSMabqz1JQFqqS94=;
        b=JBBEC6y4/nuMSIaIZgkJV5xOCCCZNW1vt9C2vNxqEJIucI00kPNjVd5Daefpk7DzOv
         x2VG2RpPPkvIlff95IA3onxoVqlKlbC8ZOtvVypSHcJ7/bTr+JYtDF9M65nFXwgsGDcs
         XCap0AA+foJ3Mfr+CiQtJ/IgHRhYeoYPmVkBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7HGUCnUWkPRHR5V5XRcjLIGICmpSMabqz1JQFqqS94=;
        b=iLFueJT/4CTilYFqzajxC5NukhmmYEbFuRb7c/w9r+0/Ho64hYj1aGRRe6zl4JSTgD
         XNyx8X/wwKXZvvchu0EfpFHi9DNBA5S9GUV2m5tn0eqzyJqGFanZ1TMM38O+C+8wsHeF
         zkt7KMeL3Lx0+0kQ43baR+ticPx5N1b9SYL8jyzvP/VLQ3lm2g5UgWwcCc5LBj6gUu9m
         cZb8lK7kdLrUuGHfEU5+ao0grY+TlSlEe+RJB8sZ479WYqG6GlzIFtBMaScM34zmeBDG
         msYNKhGxx8p6lF49HVTtvY4cWcVEKlV7Io5bwjd88uxlAg/zGFoC4dVVsh2Y4dmpIXmg
         jK3A==
X-Gm-Message-State: AO0yUKVMX7B/uPIe78O3jDQMgW6DzrCuwki/fpI5r33DxuB0Yj7xNsEk
        Wu6dePd/6/lnqvGwlXHlcM5nne3oBl/lU33CdVJW
X-Google-Smtp-Source: AK7set+xhG1pRqTN1k6V9hR0hMBl60+BvgwGrS8ytdStZKITVce/S9xwAQz2khlmGuFIkG5V0Peh3QOqNcKe4ShjZuA=
X-Received: by 2002:a62:e30c:0:b0:592:8390:8b97 with SMTP id
 g12-20020a62e30c000000b0059283908b97mr1853972pfh.15.1675411452011; Fri, 03
 Feb 2023 00:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20230201231250.3806412-1-atishp@rivosinc.com> <20230201231250.3806412-8-atishp@rivosinc.com>
 <Y9ufoeZ/4obZDJz6@wendy>
In-Reply-To: <Y9ufoeZ/4obZDJz6@wendy>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 3 Feb 2023 00:04:00 -0800
Message-ID: <CAOnJCUKVXGXsFBUE753-HOr_CtN-5Nsq+yBQj1eT13WyU2r54g@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] RISC-V: KVM: Add skeleton support for perf
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Lin <eric.lin@sifive.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
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

On Thu, Feb 2, 2023 at 3:34 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Wed, Feb 01, 2023 at 03:12:43PM -0800, Atish Patra wrote:
> > This patch only adds barebone structure of perf implementation. Most of
> > the function returns zero at this point and will be implemented
> > fully in the future.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > +/* Per virtual pmu counter data */
> > +struct kvm_pmc {
> > +     u8 idx;
> > +     struct perf_event *perf_event;
> > +     uint64_t counter_val;
>
> CI also complained that here, and elsewhere, you used uint64_t rather
> than u64. Am I missing a reason for not using the regular types?
>

Nope. It was a simple oversight. I will fix it.
Do you have a link to the CI report so that I can address them all in v5 ?

> Thanks,
> Conor.
>
> > +     union sbi_pmu_ctr_info cinfo;
> > +     /* Event monitoring status */
> > +     bool started;



-- 
Regards,
Atish
