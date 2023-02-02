Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3E688562
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjBBRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBBRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:30:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E46EAC5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:30:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so2006794wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJsqO9ccDg3aYN+Xes+xxvWd7JmlQmKL6WOcJpU3hP0=;
        b=j7OZ4lA5kyRDqd/Ve9ZS5mhmccpKED8txw9QQIbn2dkpo5EHkEpAtYDMZoZxuHc4l1
         CqAr4TJEFP3zC/zjUFQHOCUCVwcM08i+1/rqed1uuIR1OWVRXZbwGAN0loj+0wNV5b64
         TcpvC3jeLTvv89Z8rT554aRhfDmfGFJzCkOH6RbAwrCTI6aLjVKKFIfCZNcCsFC6y5Vm
         2ye87VjA7LvMWGSbYOo7nx18qj2Lw2qJYVLKhMTl4Dj/GKX8cINsXzL5w5Tv+ck3cr3D
         OWdSV357F8BTC6MBd7T9NTx0TKLVG5kFKFXVVpZvY9GDwlzPH/2EaEwHvTOGY79cX0g4
         F4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJsqO9ccDg3aYN+Xes+xxvWd7JmlQmKL6WOcJpU3hP0=;
        b=dijqmWdWzPiuOVz9Qx+lN2iQB6wyjsVV+FKLXNYbQ4a+eBAv9pQjuIQiKEoYCH8o5Q
         Ol5F0W3uUKW/WWtAXzRzVXGUetB/9QwpQ0NH2571QX3TXAoFZzyIg9MHqpHWzw+C/IZr
         Tny3GcbybTbmegyLTfhOKd5Bstl+ptDrnM7WLC2R/H7AaT7SyPQLaJGbasnZe1BV3h1f
         /IzG7lONcHBG7hQI8RWIYc68ZwsGow/fNtryfsZTZ/ViH+ofKXhxRxRQonKfEydF1Aa4
         axkyzcvvuw2aY6v6B0VC5H0LJFBpu12oxJiuxXviJ30MrOtJt+ppjpHIcAi5BKqJAwS0
         S0+w==
X-Gm-Message-State: AO0yUKWrtKWeNPsptuCspdcBjlZ0xSmlT78+43l2P8YCZW5MxmCvSOzJ
        LpRkKMg9evqE4YNGVLEEMzzLyDpC1sXmArhh
X-Google-Smtp-Source: AK7set9osSFbUU6g5UAhijUC/OgzTgoLxZ2rnbSppOUaU/Z9jpz1s5SRnhCKmJL7Zv6kjIfTcVbzoA==
X-Received: by 2002:a05:600c:1987:b0:3dd:1b5d:9b18 with SMTP id t7-20020a05600c198700b003dd1b5d9b18mr6479641wmq.29.1675359041941;
        Thu, 02 Feb 2023 09:30:41 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003dec22de1b1sm477996wmq.10.2023.02.02.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:30:41 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:30:40 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Eric Lin <eric.lin@sifive.com>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 09/14] RISC-V: KVM: Make PMU functionality depend on
 Sscofpmf
Message-ID: <20230202173040.e4rdrkdeuq7vdauk@orel>
References: <20230201231250.3806412-1-atishp@rivosinc.com>
 <20230201231250.3806412-10-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201231250.3806412-10-atishp@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:12:45PM -0800, Atish Patra wrote:
> The privilege mode filtering feature must be available in the host so
> that the host can inhibit the counters while the execution is in HS mode.
> Otherwise, the guests may have access to critical guest information.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 2dad37f..9a531fe 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -79,6 +79,14 @@ void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
>  	struct kvm_pmc *pmc;
>  
> +	/*
> +	 * PMU functionality should be only available to guests if privilege mode
> +	 * filtering is available in the host. Otherwise, guest will always count
> +	 * events while the execution is in hypervisor mode.
> +	 */
> +	if (!riscv_isa_extension_available(NULL, SSCOFPMF))
> +		return;
> +
>  	ret = riscv_pmu_get_hpm_info(&hpm_width, &num_hw_ctrs);
>  	if (ret < 0 || !hpm_width || !num_hw_ctrs)
>  		return;
> -- 
> 2.25.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
