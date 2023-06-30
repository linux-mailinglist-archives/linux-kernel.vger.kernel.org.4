Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41CE743488
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjF3FpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjF3FpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:45:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388CD3A8B;
        Thu, 29 Jun 2023 22:44:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7f92b764dso8415525ad.2;
        Thu, 29 Jun 2023 22:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688103879; x=1690695879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Md88dxy0Oq073zhiW/L7j2467fRKk8w3qHvdwFL4C9M=;
        b=PcjD32MMYgiYE564baUOEyiGOo22UgtVHw0i59AYfPpgyunfV/fOoc6viTly+vaOhb
         zRV2g5/ghxDxVFaXHb4j4geiWH+qCuDuINmC+dUjaRbqr6bbrMBcwX9EZKX5X4mWCnkK
         ny1z2eOBxlwYymTMSilH2LSBpQyf2Nid4F+cVjbYi95/cR7av3ygJbYYNtnN0Fn4b5A+
         nzUeTOlwl7kBUqvsjz5xKPpsUNzl4iHVC/M2gJKJMTIlRcgt+397t9Bg2vqPfxieECvM
         UNoi5r2SUU6fzVSyEG9GPtwNHwmddZ2KX2XgCUogouM6va3jJkdCcKTKaDXo7sqi8y3W
         xp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688103879; x=1690695879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md88dxy0Oq073zhiW/L7j2467fRKk8w3qHvdwFL4C9M=;
        b=T1kB7h62ZTbgBCB15Oso8MKScUg55YHMXnhruDa1tM/HajEPo9vHYeK3gBd7XNKHTm
         0s6JP6B/3O0yer+N/gcNhcaizAsBqa7+3UQgqcBvxtvhRVGb0Q0wWKINTpO2u09uCsi/
         PIcOAlMos6aOq3xFjFlQH/WWSJSmQrKbC1rYzCZ9i42Uiul3r3Yt9eKciSNMrvVJXPH7
         HT539A51ky7lRcMI2+Y096EbGm70lykSxFicuq7mKZlLKIQ3IS9i70yJNwAqdu2+bMao
         0fkYrvwep5Y8SdLFjqPRtZfdE6VEbBgMYuqay0BFCFgtHlSj2Y5E492vs5BBu4SMvNNB
         fLDw==
X-Gm-Message-State: ABy/qLaDMb0lLh1xN32+g2wtBS3zsdPO30+MhSKV1bIS9yWqV0Jmaa3m
        MDmmnc1top6Xe1DXthzhiNtXMfaECyQ=
X-Google-Smtp-Source: APBJJlFTSPdz9sZ9BVH+flhoUgKYShHebTBaqggxrP+wIhHccl62R6D2aSkvZGgq38Bi5Pl5TuIgug==
X-Received: by 2002:a17:902:ecc5:b0:1b8:144c:7023 with SMTP id a5-20020a170902ecc500b001b8144c7023mr893750plh.60.1688103879352;
        Thu, 29 Jun 2023 22:44:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902a5ca00b001b53c8659fesm9942394plq.30.2023.06.29.22.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 22:44:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5a6cb162-790a-d24a-8946-090f4a893cf7@roeck-us.net>
Date:   Thu, 29 Jun 2023 22:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] watchdog: core: stop watchdog when executing poweroff
 command
Content-Language: en-US
To:     Meng Li <Meng.Li@windriver.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230630053912.28205-1-Meng.Li@windriver.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230630053912.28205-1-Meng.Li@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 22:39, Meng Li wrote:
> From: Meng Li <meng.li@windriver.com>
> 
> On some platforms, for example, Intel SoC FPGA platform, the watchdog is
> started in from u-boot, and so kernel will create a timer and work to
> keep watchdog alive. .But when user executes commands "poweroff" or
> "shutdown -h", the system is reset when watchdog triggers timeout even
> if WDOG_STOP_ON_REBOOT is set in watchdog driver. The root cause is
> that the watchdog not stopped properly because the SYS_POWER_OFF case
> is not supported in nofify callback function. So, add this case to stop
> watchdog when executing poweroff command.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index d4c5a736fdcb..5b55ccae06d4 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -161,7 +161,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
>   	struct watchdog_device *wdd;
>   
>   	wdd = container_of(nb, struct watchdog_device, reboot_nb);
> -	if (code == SYS_DOWN || code == SYS_HALT) {
> +	if (code == SYS_DOWN || code == SYS_HALT || code == SYS_POWER_OFF) {
>   		if (watchdog_hw_running(wdd)) {
>   			int ret;
>   

