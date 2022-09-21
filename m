Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042965BF84F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiIUHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiIUHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:53:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE66FA2C;
        Wed, 21 Sep 2022 00:53:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lh5so11660302ejb.10;
        Wed, 21 Sep 2022 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=n4kLQmApQuYfCua+fkdkdCH6ObCCltVjKHn9E4HrPlc=;
        b=Qk/hvjqyZ+5vWSTdjpWM5zXc/aQeDJN3erHQRvySVahQVeuAYTfO/Rk19SjBw/oAkP
         ELJWaMzOcVYx2LufQu2wy85U/OrWrJbsK9/Mxa4EBZlNAMNSKcvSAyn+8oiYeLmP6Gde
         J0MpeaFKcFZttUqLUDkMN1FsLmuhVtLpgOayBANrrFiibD3BZX7sRKW8VXBcNcLpaBvG
         FR/R1mwyVwrwLybNcwIdW4J8lMRx04hK+FguyhLEaohl3iGSMwi19U99KHaAITYnc2py
         HxFo58C5Y9Py7/ueGhMtxHDryHCRuX2bvADDXIlfrjOWnG7iBKXcTDNXHf6ac5awG/6n
         Xzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=n4kLQmApQuYfCua+fkdkdCH6ObCCltVjKHn9E4HrPlc=;
        b=U3Q8/IOLtKGXaEA1BGG5bc2JvRDqjQzvGaAk9KrD2S9jlwxAcPjC5xhVMVvauYrAx7
         ST0hNFmjCYBU+dWi3tEDRol9rzWmc1UbVJ4T0LMWizp8/lnf0A7b7rBX0JDzH20WH4Yv
         G8yszQ5PNcvZSpcF0S9EsktwrsyBBWFctEc/UXEEVS53rlKcseHNiuwEFk7rA9Eke3OL
         8yr1lSlLq4lypHjdTFhPiDIsSXNO7OkO+oLTQq6UTJe8RhK0zseeicu121qvcEPFeIE1
         7pAmpnLddy5EUxFLRl28IT8Of0NWj4b9Bht+Fi9glic/5vz1nOmRq0TficZxDJKX0ywF
         R7Nw==
X-Gm-Message-State: ACrzQf26dUfDZnt6Ac/5d6xUHrUBpA29tUplNcPOEdIY4f1nGqaQfKAH
        KeSSGClYWcOhxqxDziiqdIM=
X-Google-Smtp-Source: AMsMyM4wym5tLD5/4dv1psj1e9okNC8onQJZ3NNRuPt8xNO2bQ7Mm8gmAT98X8lVYjbr6Uj66ODRzA==
X-Received: by 2002:a17:907:2ced:b0:773:6f77:f10f with SMTP id hz13-20020a1709072ced00b007736f77f10fmr19946592ejc.34.1663746786846;
        Wed, 21 Sep 2022 00:53:06 -0700 (PDT)
Received: from gmail.com (1F2EF035.nat.pool.telekom.hu. [31.46.240.53])
        by smtp.gmail.com with ESMTPSA id en26-20020a056402529a00b0043ba7df7a42sm1328443edb.26.2022.09.21.00.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 00:53:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 21 Sep 2022 09:53:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     peterz@infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH V2] perf/x86/rapl: fix deadlock in rapl_pmu_event_stop
Message-ID: <YyrC4OyP2BtY8tNl@gmail.com>
References: <20220920014447.71946-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920014447.71946-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Duoming Zhou <duoming@zju.edu.cn> wrote:

> There is a deadlock in rapl_pmu_event_stop(), the process is
> shown below:
> 
>     (thread 1)                 |        (thread 2)
> rapl_pmu_event_stop()          | rapl_hrtimer_handle()
>  ...                           |  if (!pmu->n_active)
>  raw_spin_lock_irqsave() //(1) |  ...
>   ...                          |
>   hrtimer_cancel()             |  raw_spin_lock_irqsave() //(2)
>   (block forever)
> 
> We hold pmu->lock in position (1) and use hrtimer_cancel() to wait
> rapl_hrtimer_handle() to stop, but rapl_hrtimer_handle() also need
> pmu->lock in position (2). As a result, the rapl_pmu_event_stop()
> will be blocked forever.
> 
> This patch extracts hrtimer_cancel() from the protection of
> raw_spin_lock_irqsave(). As a result, the rapl_hrtimer_handle()
> could obtain the pmu->lock.
> 
> Fixes: 65661f96d3b3 ("perf/x86: Add RAPL hrtimer support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Move hrtimer_cancel() to the end of rapl_pmu_event_stop() function.
> 
>  arch/x86/events/rapl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 77e3a47af5a..7c110092c83 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -281,8 +281,6 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>  	if (!(hwc->state & PERF_HES_STOPPED)) {
>  		WARN_ON_ONCE(pmu->n_active <= 0);
>  		pmu->n_active--;
> -		if (pmu->n_active == 0)
> -			hrtimer_cancel(&pmu->hrtimer);
>  
>  		list_del(&event->active_entry);
>  
> @@ -300,6 +298,11 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>  		hwc->state |= PERF_HES_UPTODATE;
>  	}
>  
> +	if (!pmu->n_active) {
> +		raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +		hrtimer_cancel(&pmu->hrtimer);
> +		return;
> +	}

Looks racy now: AFAICS now it's possible for rapl_hrtimer_handle() to 
execute at an arbitrary moment after pmu->lock is dropped - which could be 
use-after-free after cleanup_rapl_pmus() executes and the PMU is freed, 
right?

There's also the quality-of-implementation issue of the hrtimer executing 
in a delayed fashion for the *next* event that may have been added, leading 
to possibly unexpected results.

Thanks,

	Ingo
