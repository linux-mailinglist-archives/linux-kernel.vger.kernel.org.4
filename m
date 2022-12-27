Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551D66566F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiL0CyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0Cx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:53:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28585F05
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:53:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o2so6539625pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KR/MTddndhrF854cjUdZkm6VOiWGCsSn4VR35RAan14=;
        b=yzjmTWgwV46cwAJcXBWQOBE+gRDJKX9aukZEhkfygJI+PIBsOW5Or17jBktWsNBuDR
         DOhmJcXu0LGGuL/0vFzkALuzNpS+33FoBtlLqYTjfehQpfwvT+tWveh3FZU2dpKuyQCU
         fymjGEck1qWENRb8vf31qIKPYl420sHGxYJYJfQhdYRbBHNpFTLlCXKz/pfmU/RuAtPy
         1e69AfIIULgJ7jafU6zTDlvHCz0grXgXJqxuwzNWQnltvWxbsrTFVfFFQ3GnRL+BCGpu
         X813dO73oaPPesi2U+zIwshyNXOJ/hm+umK8HyzZ7WIyvyYw6svsHPGyrY62BVzJVT1/
         Q1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR/MTddndhrF854cjUdZkm6VOiWGCsSn4VR35RAan14=;
        b=gqU5Lg0nDDBXL0p2OKsqKDc1X5ss62Nfj7HbOQCfjANUQr2/UK6jp+NPBK8IIRmcDi
         hEUzCrWbo+WBQCjtCDnvuREAZTVVE52FKPjCGGoqyOh0WNNPs/u6mpReIPFLDywbg4Zp
         kdwUmLvQNluwIVJm/CKjAGG+jd0yl4SIiMghkY7QdOnr2a+M3nAJG10uL/JZ04Kq0PKW
         GCX76DlA28wDpmJV+IlncfESuQvpPX13G00h983lAceX6xAwBF0MwVVXfjzlqrQjhjwS
         MBEyjeLeg8GkoXLaLHcB4EzHMfujkWJuEZwwBQ9WsyhCzQCl5zk8REEI+6zCZ4y7xcR6
         hKWA==
X-Gm-Message-State: AFqh2koZa3KGKa2VZlXx8aHOkyKjZ8KmloqWAqROajQutJEcXQszx9V4
        Xi5Kq1sdw0K1GrAsuxJRRBoVoQtUsmxxY4Dd
X-Google-Smtp-Source: AMrXdXtpM2kiqm7hRldN7I3x1PMsD7AFC+yLnGsPUMdc71lFROVJFroNOWTiovi0JFtAkqe3GVMoIA==
X-Received: by 2002:a05:6a20:13a0:b0:9d:efbe:a0f5 with SMTP id w32-20020a056a2013a000b0009defbea0f5mr32674970pzh.5.1672109635694;
        Mon, 26 Dec 2022 18:53:55 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id c134-20020a624e8c000000b00572198393c2sm7444838pfb.194.2022.12.26.18.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 18:53:55 -0800 (PST)
Date:   Tue, 27 Dec 2022 08:23:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
        ray.huang@amd.com, Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/13] cpufreq: amd-pstate: fix kernel hang issue
 while amd-pstate unregistering
Message-ID: <20221227025353.gbgdcmmi6vomhpqp@vireshk-i7>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-5-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225163442.2205660-5-perry.yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-12-22, 00:34, Perry Yuan wrote:
> In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call to
> increase increments the kobject reference count of policy and make it as
> busy. Therefore, a corresponding call to cpufreq_cpu_put() is needed to
> decrement the kobject reference count back, it will resolve the kernel
> hang issue when unregistering the amd-pstate driver and register the
> `amd_pstate_epp` driver instance.
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/cpufreq/amd-pstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 204e39006dda..c17bd845f5fc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  		max_perf = min_perf;
>  
>  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)

This should have been sent separately and not in this series. It is a
bug fix, which could have been merged in the 6.1 itself and now is
candidate for 6.2-rc1, while the rest of the series needs to wait for
6.3.

-- 
viresh
