Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A71657EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiL1P7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbiL1P7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:59:40 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83C18E1D;
        Wed, 28 Dec 2022 07:59:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j130so9490131oif.4;
        Wed, 28 Dec 2022 07:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QUTtEkYcM1hcNSnuld4ZxvgWpVaBeAZ6MuL2nL7biI=;
        b=Cx02UtrmFKr3aEWXNvfpXP6CFbnJe/FleFllv5N9b7gIQRjPWRHzsujTpFywKOZ69a
         T4tu/NkvWspa8+K3EGCTtu1MJv+PXWDpM7WxtWt1i81zAruOD8jYCZIOEOf5Jp3LHvOV
         7sylocrbxD9PVewpY+V8DU8jp+JzeUdaoKmF3xX6fECFcWNc988haFcNIWWgo6H7O0ts
         Xc4DRBymIhXQ1oSb3yOAYynt+GCwh5E+HEpym4GK9kFFkSLJ8wwv5/ApsiRu1IIR7XTk
         862zBpZcd8JetJkjaMN3X7DnMIx8qYEAhEqrwva5WTIpQyQ7a98veJXI+6fev1bJbdql
         p1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QUTtEkYcM1hcNSnuld4ZxvgWpVaBeAZ6MuL2nL7biI=;
        b=AXFS1t+RIMBxHBNumbasoWkQ12mDuZS7O5tggX9XFOm1W/YMoe55M4zDPyef6YbYYO
         8ofo9hHm1a59/cBNkqfFmbo01GmInyfKJ4zLZqpeaPQpLSXGKBIEjyg8BJJsAHHEWhsS
         OO6GbB0KIgGPuRZSUKHznR/VZIp+d9EnUP5bRGhcJ74lqjBqDW9s9FYUdg/C8LvZikOU
         68f72ugfBBY75o4JuB9+SWZdtfCzEEG2r/gmW3qS0TNWKF0GfDnVWRgj7iBkiOarKUth
         j8tCm6hNoPjXa5EDgMhs7Br0Pjwe+PlIztHWjllf7sD1pthhewhOF3x7J2EC3Dv2W44N
         vgjg==
X-Gm-Message-State: AFqh2krqA4QlqCNGWLReAEtUAB3Pbu6qvngDfAeKO2Dnzh1tEL1471mn
        1WSGJKmq6zETlYB0mAyCIu1GlGo0iU4=
X-Google-Smtp-Source: AMrXdXsRGZeSqsgBVhNVNqSC3BgaAv93wcLsJxW2n2ByMobf1W0iI68MurJ/la+Ki/jon9tKO/Epxw==
X-Received: by 2002:a54:4193:0:b0:35c:58a2:edf7 with SMTP id 19-20020a544193000000b0035c58a2edf7mr11381045oiy.54.1672243178682;
        Wed, 28 Dec 2022 07:59:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b189-20020aca34c6000000b0035bd1909a66sm7064524oia.57.2022.12.28.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 07:59:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 07:59:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3] hwmon: coretemp: avoid RDMSR interruptions to
 isolated CPUs
Message-ID: <20221228155937.GA64676@roeck-us.net>
References: <Y5sWMEG0xCl9bgEi@tpad>
 <68f76ac7-5edd-d437-8bef-e233f2876660@roeck-us.net>
 <Y5x7hXGGLkcmejKq@tpad>
 <34dc4244-4e62-0b73-b6f9-430e4ee1a1e6@roeck-us.net>
 <Y5zT6B1mY9/pnwJV@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5zT6B1mY9/pnwJV@tpad>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 05:24:08PM -0300, Marcelo Tosatti wrote:
> The coretemp driver uses rdmsr_on_cpu calls to read
> MSR_IA32_PACKAGE_THERM_STATUS/MSR_IA32_THERM_STATUS registers,
> which contain information about current core temperature.
> 
> For certain low latency applications, the RDMSR interruption exceeds
> the applications requirements.
> 
> So do not create core files in sysfs, for CPUs which have
> isolation and nohz_full enabled.
> 
> Temperature information from the housekeeping cores should be
> sufficient to infer die temperature.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v3: do not create sysfs files for isolated CPUs (Guenter Roeck)
> v2: improve changelog to mention that an error is returned,
>      and sysfs file is not disabled (Guenter Roeck)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 9bee4d33fbdf..619dfde7a712 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -27,6 +27,7 @@
>  #include <asm/msr.h>
>  #include <asm/processor.h>
>  #include <asm/cpu_device_id.h>
> +#include <linux/sched/isolation.h>
>  
>  #define DRVNAME	"coretemp"
>  
> @@ -458,6 +459,9 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  	u32 eax, edx;
>  	int err, index, attr_no;
>  
> +	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> +		return 0;
> +
>  	/*
>  	 * Find attr number for sysfs:
>  	 * We map the attr number to core id of the CPU
