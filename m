Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE917297C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbjFILFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjFILEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:04:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E43210D;
        Fri,  9 Jun 2023 04:04:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b24b34b59fso6667645ad.3;
        Fri, 09 Jun 2023 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686308682; x=1688900682;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEZPAeIV/OtWRVRtfhWloaaTiFQRpVuQ6c3hWe/ckak=;
        b=YaA7FMxKN+7vfMRVRCcEnnj7qFuw1UrPnx42VMlRMLMiKtKScyF2LosWNEBAlz9G84
         oN/JbLD1ts2NmctqUJM380hZjHyjBEPjKpVyTWBEIOHIV/86tkGDqM/XIPJaVxHhBMRk
         +1T4+NpQ/PKA05JzfA4KDADEa7jKcgvYdJNUuOtH0SbUvtqqRVBIE8PZ8elR26asbV4M
         uqK7Uyij+97rzlSYEvJhWDoNa4BoL+qRp/nTUCrEb8YZm0rBy3QlixtBs58DFj2kY214
         hp1O9ZiRMZ4JWBwKtTFhe/VOyKOlyZDTXSFnP97NqMkcPkoDFq9rdjQ9lqiClv59wi53
         ffqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308682; x=1688900682;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aEZPAeIV/OtWRVRtfhWloaaTiFQRpVuQ6c3hWe/ckak=;
        b=Uca+hI9Z8WuYC56jcLYXlNaNlQ84+1taNuF2r3NbZKN6l1X7kNvquEtsJKzCdXbfY3
         OSyA9NAzLmd49maLTodPB3zcT9qmdVcKPf7RodRUCPUoECpN5vdLRv1RSsnhxx9slACE
         M9UEWLtLC3+kpdY0JzUA7b7wrNYocs+17CRqxINFwp8MzhM7qUoU813H35prmOcA9RvI
         /SfMl524BtVsQ0Vx8iPEVA2yQYIT7A6F48rYuxe8q4xnCGn7ItvclnnpvPDLiTkHQnSC
         Zk99vlPzei53WEhmLlmFK9d8hF7CF545qqz1FYTk9X9PQhu6e8jrrtWMvkwxkFVkE+lD
         rLmw==
X-Gm-Message-State: AC+VfDyog+WCTchaovEnCmmwIgwVBBa/qVIx90J2PVOUlryqdKqaqc7g
        A3Q+cfLb4ApyLDGTr3i0rk4=
X-Google-Smtp-Source: ACHHUZ4PedxoYr1YVS117Tj0fzkFfE6nw0uZj3KY70eFDjoP9uhOO4uoh/QfIhve0hKdM1mR8BV7eA==
X-Received: by 2002:a17:902:704a:b0:1b3:8862:2403 with SMTP id h10-20020a170902704a00b001b388622403mr709032plt.36.1686308681966;
        Fri, 09 Jun 2023 04:04:41 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b06f7f5333sm3042080pld.1.2023.06.09.04.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:04:41 -0700 (PDT)
Message-ID: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
Date:   Fri, 9 Jun 2023 18:04:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Joe Breuer <linux-kernel@jmbreuer.net>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Waking up from resume locks up on sr device
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I'm running LibreELEC.tv on an x86_64 machine that, following a (kernel) update, now locks up hard while trying to device_resume() => device_lock() on sr 2:0:0:0 (the only sr device in the system).
> 
> Through some digging of my own, I can pretty much isolate the fault in this device_lock() call:
> https://elixir.bootlin.com/linux/v6.3.4/source/drivers/base/power/main.c#L919
> 
> I put an additional debug line exactly before the device_lock(dev) call, like this:
> dev_info(dev, "device_lock() in device_resume()");
> 
> This is the last diagnostic I see, that device_lock() call never returns, ie line 920 in main.c is never reached (confirmed via TRACE_RESUME).
> The device, in my case, is printed as sr 2:0:0:0.
> 
> Knowing this, as a workaround, booting with libata.force=3:disable (libata port 3 corresponds to the SATA channel that sr 2:0:0:0 is attached to) allows suspend/resume to work correctly (but the optical drive is not accessible, obviously).
> 
> When resume hangs, the kernel is not _completely_ locked, interestingly the machine responds to pings and I see the e1000e 'link up' message a couple seconds after the hanging sr2 device_lock().
> Magic SysRq, however, does NOT work in that state; possibly because not enough of USB is resumed yet. Resuming devices seems to broadly follow a kind of breadth-first order; I see USB ports getting resumed closely before the lockup, but no USB (target) devices.
> 
> This is a regression, earlier kernels would work correctly on the exact same hardware. Since it's an 'embedded' type (LibreELEC.tv) install that overwrites its system parts completely on each update, I don't have a clear historical record of kernel versions. From the timeline and my memory, moving from 5.x to 6.x would make sense. Due to the nature of the system, it's somewhat inconvenient for me to try numerous kernel versions blindly for a bisection; I will try to test against some current 5.x soon, however.
> 
> I do have the hope that this information already might give someone with more background a strong idea about the issue.
> 
> Next, I will try to put debug_show_all_locks() before device_lock(), since I can't Alt+SysRq+d.

See Bugzilla for the full thread.

Anyway, I'm adding it to regzbot (with rough version range since the reporter
only knows major kernel version numbers):

#regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
#regzbot title: Waking up from resume locks up on SCSI CD/DVD drive

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217530

-- 
An old man doll... just what I always wanted! - Clara
