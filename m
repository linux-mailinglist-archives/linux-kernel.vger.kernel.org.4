Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA646914C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBIXk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBIXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:40:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A4328D25
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:40:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u9so4694246plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adGyWVOR2nlTk/KUDUV+jez2l94K5Pjv+2axtOX1duc=;
        b=S+EeEmO/AgJdkddnM+GWSByan9rLpwI4+43Gudk5YalfLOzLAuwamWpHK1A3g3yUED
         2LnBV8HTZPc5z9nodgYPXMOI/udYa0xc9TX+C4DsT/U87QDK1AcC8BCnSXXNJJ6fT5Zs
         61SmNWhg80g9TqDEubKkH6lE7kKTZ+w0xi2dRR7ZSRj599yP6SBBqSC5op2UzK8IxpPI
         s2CIbVc4Xnip8zB854CKHUooPrlnKf2DT9RLPxe5ahTT7lwNfQOV9C5pPCAXsQ4FqKgh
         5gHPZTOJngYLLtrbDWUKwWu0s44ZhIBjeDqMW8+WWJElEZkfDoT/F9R5Iq3aoULeaNbp
         wQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adGyWVOR2nlTk/KUDUV+jez2l94K5Pjv+2axtOX1duc=;
        b=0ph4fvaJRKzSNbdkT99iiU0Q0q7S0KRJrFMew+pm/3B5XdMfTwOY/0hjScCvfmm+C5
         sIlcWRlHrGzBvpN9y6TiZ9qzWgXNPL5FkCGmJxdEY89g1EQw+mVKR/av3jOAl6BluayZ
         5O47hjvrh/y+mNmhBfy/lopOh11GQ2AU8Lcu0r3SLndf8nBDQsFJW2ZVPpDvUAYyIzIO
         2seCdEqLVURcd//yQPq5qjXes8xbTet9rrOBlb4LNgnZZsIfE5PlR+rmKU7evnzH0UOP
         /gT+/NhOjcUcb1bSoYHtG0pxFTQAWEI9SMYyoAY2lFEa168oCM9EzeBX0DORyduzrwQ6
         p/Iw==
X-Gm-Message-State: AO0yUKWxku1HCJpNKKFdrqAPnqdrl8WVHDXzMzTVRu+Kqx1emuQxvIxx
        1dkenLNuDvEca5hTFHtagvTiRQ==
X-Google-Smtp-Source: AK7set/PIVkjEJocB7mqQ2J4zvRNKQNxBKAt4KUZK4EGawWrd33e2I/AS6Uk8j9LVQifXxOgK4Aitg==
X-Received: by 2002:a17:902:e385:b0:199:4d57:63a7 with SMTP id g5-20020a170902e38500b001994d5763a7mr5588208ple.52.1675985972689;
        Thu, 09 Feb 2023 15:39:32 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d3d300b0019611a075fasm2077211plb.58.2023.02.09.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:39:32 -0800 (PST)
Date:   Thu, 09 Feb 2023 15:39:32 -0800 (PST)
X-Google-Original-Date: Thu, 09 Feb 2023 15:38:52 PST (-0800)
Subject:     Re: [PATCH] clocksource/drivers/riscv: Refuse to probe on T-Head
In-Reply-To: <87a0a7c9-6069-b043-2fc2-8d1bc05ddb1a@sholland.org>
CC:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     samuel@sholland.org
Message-ID: <mhng-25d39bba-2df2-4976-a3c0-b867a54cb61c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 15:35:53 PST (-0800), samuel@sholland.org wrote:
> Hi Palmer,
>
> On 2/9/23 17:23, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> As of d9f15a9de44a ("Revert "clocksource/drivers/riscv: Events are
>> stopped during CPU suspend"") this driver no longer functions correctly
>> for the T-Head firmware.  That shouldn't impact any users, as we've got
>
> The current situation is that the C9xx CLINT binding was just accepted,
> so the CLINT is not yet described in any devicetree. So at least with
> upstream OpenSBI, which needs the CLINT DT node, the SBI timer extension
> never worked at all.
>
>> a functioning driver that's higher priority, but let's just be safe and
>> ban it from probing at all.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> This feel super ugly to me, but I'm not sure how to do this more
>> cleanly.  I'm not even sure if it's necessary, but I just ran back into
>> the driver reviewing some other patches so I figured I'd say something.
>
> This is not necessary as long as we add the riscv,timer node with the
> riscv,timer-cannot-wake-cpu property before we add the CLINT node. So it
> should not be a problem for any C9xx platform going forward.

Awesome, that sounds way better.

>
> Regards,
> Samuel
>
>> ---
>>  drivers/clocksource/timer-riscv.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index a0d66fabf073..d2d0236d1ae6 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -139,6 +139,22 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>  	if (cpuid != smp_processor_id())
>>  		return 0;
>>
>> +	/*
>> +	 * The T-Head firmware does not route timer interrups to the core
>> +	 * during non-retentive suspend.  This is allowed by the specifications
>> +	 * (no interrupts are required to wake up the core during non-retentive
>> +	 * suspend), but most systems don't behave that way and Linux just
>> +	 * assumes that interrupts work.
>> +	 *
>> +	 * There's another timer for the T-Head sytems that behave this way
>> +	 * that is already probed by default, but just to be sure skip
>> +	 * initializing the SBI driver as it'll just break things later.
>> +	 */
>> +	if (sbi_get_mvendorid() == THEAD_VENDOR_ID) {
>> +		pr_debug_once("Skipping SBI timer on T-Head due to missed wakeups");
>> +		return 0;
>> +	}
>> +
>>  	domain = NULL;
>>  	child = of_get_compatible_child(n, "riscv,cpu-intc");
>>  	if (!child) {
