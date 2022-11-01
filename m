Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96A1614AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKAMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiKAMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:30:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2E6364
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 05:30:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so36639808ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMdJJP7qwJgB+YOZJZoHob5+MxmSHtL0fZ6b/8D51/A=;
        b=HRxnWtZ78Fle+GMZ/BglbxUAgUR/pOZoMyuTHxjejOFyG7ByqwcarnPhV0NQaqXYSl
         khrNMjh7fNsKZEwPrAjlzO8uNrMDO6NCJBJs9v/AgjRyb2rqst7VjvZtYzs57oN1upEl
         bH9HpfFj14uxOXfaah/iYuqn0p9h7C7/IfCCxWckV4oDaDXO/1URXqis5D+lWNn7+4TO
         pGHNOp7nJ48TWywRMqGUIb/UiMz60UzdR8+BkI+tDbtu8TmhJGK2AT/RK6lANdPYWU6V
         c5s8RtO/mLCsaW2Z0HcA7lDVYefF8rv6kvzBbCPq9JJdoyW1R2PMgIW1GDeoNxFehqo7
         GSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMdJJP7qwJgB+YOZJZoHob5+MxmSHtL0fZ6b/8D51/A=;
        b=hTyZjlcGvqMMDA3KkPpaQL6wOdcPpCzGiHSrysGy9KPen2UJftOlVsNjQGozEhnO2x
         dBVcH2jm7OUD6ebxnaOc/cGUjeYAokiUO1/h6bGtM7B/guHw9VG17qAE/Ae260oxWP/I
         9HOmjXBH7wIv42o/h1zuQUcGFvFZzYe1uT9FQkTJj76PMTTRSV0rz/jjgSGTl9w3in7r
         FWu6oOakCNhIDbz95LAkHoMPG/i9P6FMsaIYWBxcKkUweh0RCotmzNVGnkfNWysVIuO4
         g6k7cyDfhpHIqOJlrJDKGPMfSwWK6UPFy3eW/UBMEsWKSrXPKGQKo8Wu4bUwF+Z5Q9q7
         zA9w==
X-Gm-Message-State: ACrzQf1u7x49aJRkBrGB3vwtQ4WsXb3eLsaGAD46z77exee4nu7cB1NN
        H3Agf4COb254Ml21bTvKiRzIlA==
X-Google-Smtp-Source: AMsMyM43Au0M4n/HFiW/cXmrltu4nx6ymG910hAE86Cu/h8Mh2B6UpOdnv1cioo6CGtmr8+mmacM1Q==
X-Received: by 2002:a17:907:9d03:b0:7ad:e310:ea8 with SMTP id kt3-20020a1709079d0300b007ade3100ea8mr6546291ejc.400.1667305810129;
        Tue, 01 Nov 2022 05:30:10 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id bm6-20020a0564020b0600b00461a6997c5dsm4456757edb.83.2022.11.01.05.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:30:09 -0700 (PDT)
Date:   Tue, 1 Nov 2022 13:30:08 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC  1/9] RISC-V: Define a helper function to probe number of
 hardware counters
Message-ID: <20221101123008.e3bwen6f2yxi3whi@kamzik>
References: <20220718170205.2972215-1-atishp@rivosinc.com>
 <20220718170205.2972215-2-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718170205.2972215-2-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:01:57AM -0700, Atish Patra wrote:
> KVM module needs to know how many hardware counters the platform supports.
> Otherwise, it will not be able to show optimal value of virtual
                                        ^ the
> counters to the guest.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c   | 23 +++++++++++++++++------
>  include/linux/perf/riscv_pmu.h |  4 ++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 24124546844c..1723af68ffa1 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -27,6 +27,7 @@
>   */
>  static union sbi_pmu_ctr_info *pmu_ctr_list;
>  static unsigned int riscv_pmu_irq;
> +static struct riscv_pmu *rvpmu;

Do we really need rvpmu? From a quick scan of the series it's only used
for num_hw_counters, which has to be added to struct riscv_pmu, and
num_counters. How about instead creating a static global for num_counters
and then getting num_hw_counters by iterating pmu_ctr_list. If we want
riscv_pmu_sbi_get_num_hw_ctrs() to be faster, then we can cache the value
in a static variable in the function.

Thanks,
drew
