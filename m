Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B116ACE77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCFTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCFTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:53:37 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6F303C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:53:35 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-176d93cd0daso3275399fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678132414;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwTBPEI9m894tetNy41ILCxBXcZZsAkAVnVKSS8NJgk=;
        b=AbzpBzPcm35ClSsNehsLn8JXp18EBCu2dwGQkj8dIrHmYLVfSVU5PABn100k83IeTD
         GCYpoO4ebqhbPHklt2cJ3OL2udqk+655mNRD0WyyX4awu/qow0sClbjt+xJBtf0vpylH
         49/P5/6oqXYCJwz4Qw6tUmp1+DQb6LiWEPC9J6f2qCMD7Qn97vCC8GqkG0PpDO6Q7F6z
         e8BZkI/ZgnitBug+aD8D+07fa2AC3wD05oZ5RNw4hvkuq/fk9hlAc+r4dTNS8e04IWm+
         AK1tYbG8KjcEyb2eT5ND3T1mavR2wkx3CPjxfQ62y+tdw0P/IuwBQnWkf1eZ5Pt31ioV
         ping==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132414;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwTBPEI9m894tetNy41ILCxBXcZZsAkAVnVKSS8NJgk=;
        b=32Lbd7CduPTW3tOE5E/2aeYY1aOw2f6UQCaoinF0wgMqWyfXHx5DNYAVLcso3Cu/Nw
         4tgUC0cRSXaVzMv2ep9JEDQIEp115dUVrk0pvVFe2SFW8cSVxTDNfHftFFiScq8074wr
         F0ADxlopCmYpD/VbIr4MhtpkKq8z4h+cn54YFWKe+i0P35UXaBkg+Wcy6NUsw0LlGdh0
         Vp8LOOFf/s3HdMZbLkOesMef2MlU/TXx+yIoqZoqHVQhxAMIzFPKpO/hQjywGcVveTW6
         jfQFIjLD8LNxcBC1PNJhgoVAHkA/swHKYiCWlwkr8c9zOX0iy77IlTpAvW49lZ6c0jll
         jVVA==
X-Gm-Message-State: AO0yUKU3HCRz6RyouyakJHQQUaj5rrnGcC/E7AUg500XBU5lyMd7cy8x
        Qrnyl0cG95mK7n4p7/QxHGRkE+clkAA=
X-Google-Smtp-Source: AK7set9V156K/4QjxBGBupzi8T9pQ5DVtUDSnWt+1ywS3+YIgVRgjc7Chm2Tcg9GkCM5NIlc5yul+w==
X-Received: by 2002:a05:6870:6106:b0:163:92b4:175b with SMTP id s6-20020a056870610600b0016392b4175bmr7277522oae.40.1678132414206;
        Mon, 06 Mar 2023 11:53:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id zd34-20020a05687127a200b001730afaeb63sm4287817oab.19.2023.03.06.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:53:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 11:53:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc1
Message-ID: <74178f6a-22b1-42f0-aed7-98ef5ad8a690@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 10:12:01AM -0800, Linus Torvalds wrote:
> On Mon, Mar 6, 2023 at 8:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Various crashes, affecting several architectures.
> >
> > [   11.664666] BUG: unable to handle page fault for address: 000000000002d3db
> > [   11.667043]  lock_acquire+0xcb/0x330
> > [   11.667163]  _raw_spin_lock+0x2b/0x40
> > [   11.667255]  add_timer_on+0x92/0x150
> > [   11.667302]  try_to_generate_entropy+0x256/0x280
> 
> Ok, this seems to be due to the issue discussed here
> 
>    https://lore.kernel.org/all/CAHk-=witXXeQuP9fgs4dDL2Ex0meXQiHJs+3JEfNdaPwngMVEg@mail.gmail.com/
> 
> and I think the fix is as per the appended patch (that particular
> crash is due to the random.c part, but I did the others that 'git
> grep' picked out too).
> 
> Can you run your test-runs on this patch?
> 

With the patch below applied on top of v6.3-rc1, the crashes are gone:

Qemu test results:
	total: 511 pass: 511 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

>               Linus
> 
>  arch/powerpc/xmon/xmon.c         |  2 +-
>  drivers/char/random.c            |  2 +-
>  drivers/net/wireguard/queueing.h |  2 +-
>  drivers/scsi/lpfc/lpfc_init.c    | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 73c620c2a3a1..e753a6bd4888 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1275,7 +1275,7 @@ static int xmon_batch_next_cpu(void)
>  	while (!cpumask_empty(&xmon_batch_cpus)) {
>  		cpu = cpumask_next_wrap(smp_processor_id(), &xmon_batch_cpus,
>  					xmon_batch_start_cpu, true);
> -		if (cpu == nr_cpumask_bits)
> +		if (cpu >= nr_cpu_ids)
>  			break;
>  		if (xmon_batch_start_cpu == -1)
>  			xmon_batch_start_cpu = cpu;
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index ce3ccd172cc8..253f2ddb8913 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1311,7 +1311,7 @@ static void __cold try_to_generate_entropy(void)
>  			/* Basic CPU round-robin, which avoids the current CPU. */
>  			do {
>  				cpu = cpumask_next(cpu, &timer_cpus);
> -				if (cpu == nr_cpumask_bits)
> +				if (cpu >= nr_cpu_ids)
>  					cpu = cpumask_first(&timer_cpus);
>  			} while (cpu == smp_processor_id() && num_cpus > 1);
>  
> diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> index 583adb37ee1e..125284b346a7 100644
> --- a/drivers/net/wireguard/queueing.h
> +++ b/drivers/net/wireguard/queueing.h
> @@ -106,7 +106,7 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
>  {
>  	unsigned int cpu = *stored_cpu, cpu_index, i;
>  
> -	if (unlikely(cpu == nr_cpumask_bits ||
> +	if (unlikely(cpu >= nr_cpu_ids ||
>  		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
>  		cpu_index = id % cpumask_weight(cpu_online_mask);
>  		cpu = cpumask_first(cpu_online_mask);
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 61958a24a43d..73b544bfbb2e 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -12563,7 +12563,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  					goto found_same;
>  				new_cpu = cpumask_next(
>  					new_cpu, cpu_present_mask);
> -				if (new_cpu == nr_cpumask_bits)
> +				if (new_cpu >= nr_cpu_ids)
>  					new_cpu = first_cpu;
>  			}
>  			/* At this point, we leave the CPU as unassigned */
> @@ -12577,7 +12577,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  			 * selecting the same IRQ.
>  			 */
>  			start_cpu = cpumask_next(new_cpu, cpu_present_mask);
> -			if (start_cpu == nr_cpumask_bits)
> +			if (start_cpu >= nr_cpu_ids)
>  				start_cpu = first_cpu;
>  
>  			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
> @@ -12613,7 +12613,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  					goto found_any;
>  				new_cpu = cpumask_next(
>  					new_cpu, cpu_present_mask);
> -				if (new_cpu == nr_cpumask_bits)
> +				if (new_cpu >= nr_cpu_ids)
>  					new_cpu = first_cpu;
>  			}
>  			/* We should never leave an entry unassigned */
> @@ -12631,7 +12631,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  			 * selecting the same IRQ.
>  			 */
>  			start_cpu = cpumask_next(new_cpu, cpu_present_mask);
> -			if (start_cpu == nr_cpumask_bits)
> +			if (start_cpu >= nr_cpu_ids)
>  				start_cpu = first_cpu;
>  
>  			lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
> @@ -12704,7 +12704,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  				goto found_hdwq;
>  			}
>  			new_cpu = cpumask_next(new_cpu, cpu_present_mask);
> -			if (new_cpu == nr_cpumask_bits)
> +			if (new_cpu >= nr_cpu_ids)
>  				new_cpu = first_cpu;
>  		}
>  
> @@ -12719,7 +12719,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>  				goto found_hdwq;
>  
>  			new_cpu = cpumask_next(new_cpu, cpu_present_mask);
> -			if (new_cpu == nr_cpumask_bits)
> +			if (new_cpu >= nr_cpu_ids)
>  				new_cpu = first_cpu;
>  		}
>  
> @@ -12730,7 +12730,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
>   found_hdwq:
>  		/* We found an available entry, copy the IRQ info */
>  		start_cpu = cpumask_next(new_cpu, cpu_present_mask);
> -		if (start_cpu == nr_cpumask_bits)
> +		if (start_cpu >= nr_cpu_ids)
>  			start_cpu = first_cpu;
>  		cpup->hdwq = new_cpup->hdwq;
>   logit:
> 
