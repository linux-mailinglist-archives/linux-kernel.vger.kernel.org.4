Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EBD6D56B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDDCYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDDCYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:24:36 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F881BF3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:24:36 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bl22so9273827oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 19:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680575075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCNpBaL/2sjk43glshlJ9dr/bfWByILp/8UnbydzX4U=;
        b=W1B4Fzo3MIqhNrx9wAVeCr/1Aip0HgjJCktQ0vPQD2jKqITDXiNJoZyotzpfz49VjC
         gd4IL4ktiB+ZjYDJNuBNe9ivpLjFbDC2QUWbzi3O8NIZGFmCoG5RQm4RMnxjTDipWdor
         Rzx3Nc5vcykYUPCAXF7MnPoNlhqNqZ+qlgwbE5lj7+L1sp//RqZvH8TzW46kqqRku8hC
         OQH67rIFhsBx/beCpzldMCDaObJDwfSIJNAZNuPqPSlYGyfUrrvuD/xKfLPq7iWHgBGH
         SKjhT+Wa1nZLNei1p9JydYb8Cfeqn6tgNL5w/vt05qoC/H2YfEcMZlVr/l7cz/lKVbvD
         i1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680575075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCNpBaL/2sjk43glshlJ9dr/bfWByILp/8UnbydzX4U=;
        b=qmvt2w7Qn/5eiK2pAWziOulaR8c4r6QwU0o+mJD45zRWpZlB0wtnKbvZec48fE/u3V
         gBQOu77pBV9002J78Om6goNpStNtZSVv9VujHiQSfBP2rbnJnfGD5cqsTXWxojhQ4bN6
         U2mesNW+ob1D9cSNYIgEuuJIGKkz82IQh4/oQvDN6qZWEFM+Yp9HKrutjypYDFZls2aK
         WhsS/M+kcX03uycrZgutV6azflU7Rbor2FSblj63rhXIEy6IfWROWjM8apLpgqJtvt2S
         CGUIumspoUuzFQFDHat4LpcI+sJtMeur8hEbzjVacAKwddYn4quOOlqrzc/kMEgo6kib
         1fhQ==
X-Gm-Message-State: AAQBX9cV1X3/nSkBtn6ODMfmzCDtjWmzpZXVKlx0J56rXUR7qxZTw4hr
        bva7bfyHSRHINw5TG6328CA=
X-Google-Smtp-Source: AKy350aiI8VfU6NNjBRfNqhZFOMENHN2IpeCLyJp6i9s5cUHI/ZTkaJwNbsAPnzyX6uwHgc42xUNgg==
X-Received: by 2002:a05:6808:148c:b0:386:ca25:9a9 with SMTP id e12-20020a056808148c00b00386ca2509a9mr812799oiw.7.1680575075248;
        Mon, 03 Apr 2023 19:24:35 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id x9-20020a05680801c900b003875e29808esm4606596oic.0.2023.04.03.19.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:24:34 -0700 (PDT)
Date:   Mon, 3 Apr 2023 19:24:32 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: Re: [PATCH 1/2] cpu/hotplug: introduce 'num_dying_cpus' to get dying
 CPUs count
Message-ID: <ZCuKYN2ZUJjn752J@yury-laptop>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404014206.3752945-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:42:05AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce '__num_dying_cpus' variable to cache the number of dying CPUs
> in the core and just return the cached variable.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  include/linux/cpumask.h | 20 ++++++++++++++++----
>  kernel/cpu.c            |  2 ++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 2a61ddcf8321..8127fd598f51 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -135,6 +135,8 @@ extern struct cpumask __cpu_dying_mask;
>  
>  extern atomic_t __num_online_cpus;
>  
> +extern atomic_t __num_dying_cpus;
> +
>  extern cpumask_t cpus_booted_once_mask;
>  
>  static __always_inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
> @@ -1018,10 +1020,14 @@ set_cpu_active(unsigned int cpu, bool active)
>  static __always_inline void
>  set_cpu_dying(unsigned int cpu, bool dying)
>  {
> -	if (dying)
> -		cpumask_set_cpu(cpu, &__cpu_dying_mask);
> -	else
> -		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
> +	if (dying) {
> +		if (!cpumask_test_and_set_cpu(cpu, &__cpu_dying_mask))
> +			atomic_inc(&__num_dying_cpus);
> +	}
> +	else {
> +		if (cpumask_test_and_clear_cpu(cpu, &__cpu_dying_mask))
> +			atomic_dec(&__num_dying_cpus);
> +	}
>  }

Corresponding set_cpu_online() is implemented in C-file probably for a
reason. Are you sure that similar function for dying mask should
reside in a header? If so, can you share your reasoning?

Regardless, now that you added the identical function to
set_cpu_online, I think it's worth to make it a general approach:

void set_cpu_counted(unsigned int cpu, bool set,
                        struct cpumask *mask, atomic_t *cnt);

void __always_inline set_cpu_online(unsigned int cpu, bool online)
{
      set_cpu_counted(cpu, online, &__cpu_online_mask, &__num_online_cpus);  
}

void __always_inline set_cpu_dying(unsigned int cpu, bool dying)
{
      set_cpu_counted(cpu, dying, &__cpu_dying_mask, &__num_dying_cpus);  
}
