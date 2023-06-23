Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9A73B77A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFWMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjFWMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:36:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CBB10C1;
        Fri, 23 Jun 2023 05:36:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b52bf6e66aso3024775ad.3;
        Fri, 23 Jun 2023 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687523805; x=1690115805;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRFszYI+9Qw1I1IAdyHoXb57hiMrn2v6H8gZ9EF6v9U=;
        b=L5R0/RAydkwltXsXehskQEBkNzFK4/MVvfMkBTioAsH8bRDuO3IsG058ILG/Fm3Y/G
         q/d127dskB6hmxwbGWh72gS2E/dzane7nlYj+aDK8vEV6KJtLCHGE5s24WDq7f1/BDo0
         EIGRIDHQz+aC+jDkbF/4t+wzL9pazKMWD/PqHjXsGbK7iX5Ug7fKqsmDnxuZkBVvHIFn
         LvppyyltF194+L4JZb7xQ2O6NPZ4xxbASCq+5d5RjthX5JsMVWm5GJwpDh20+51pm3C9
         AhS/RolaCcrYEbRterYhnk+hzAO0w1GzAgJh0YH+Ei4eisrgOEEFOVqQj+Ne1HjR+bv1
         Gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687523805; x=1690115805;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fRFszYI+9Qw1I1IAdyHoXb57hiMrn2v6H8gZ9EF6v9U=;
        b=kR4n74m6xIU+L0MGm+7t4nroC9svQXNketNgeOYbpx+qOQkf7Vo4ivf1GnRg2Tn61r
         BhiHk7VkWfMamwkqthnG/Cdz17JKtuwJ7k2Y+FosW5IE5en6BoXY1gm7UXIFEXXlM1Gu
         2HU0MjziJJR/hF2agNrABL6N35GwJ/24mSd1XajN1hqg4BMvYb8t0H3LuXKALXWLQmTR
         i/bSQIIpIJ5E6Mfsh02G3GeFDnpxHqKGYIhul288xkVWvXlrOPqBqb8sgQ1EhyAihuTX
         HJjYny/WW9nfa+BOoucxlYghcrjUjAAu11e2QDTKfbHd21wWKfQD8ksoUDpXv3PyQHTt
         0n2A==
X-Gm-Message-State: AC+VfDxLKPvR5zJ6CtqaMCa51LyQmrCxMLfOUASVVRavFcgPP7/KBvq3
        28LgYJsQxi+iiLdc5Ff03cE=
X-Google-Smtp-Source: ACHHUZ5G3Xm07SkD9tSvZjIav/cQnBT+Rn3G8kuel8ZSZvnXQ5c9RcE/3DmDQVTFKqgtT1WcEiasPA==
X-Received: by 2002:a17:902:bb96:b0:1ac:8837:de9 with SMTP id m22-20020a170902bb9600b001ac88370de9mr8065763pls.3.1687523804673;
        Fri, 23 Jun 2023 05:36:44 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001b694130c05sm5414045plh.1.2023.06.23.05.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 05:36:44 -0700 (PDT)
Message-ID: <5d4959b7-61da-8ab0-6bc6-21305d37c7aa@gmail.com>
Date:   Fri, 23 Jun 2023 19:36:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Elmar Stellnberger <estellnb@elstel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel fault on hibernation: get_zeroed_page/swsusp_write
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> page allocation error using kernel 6.3.7-desktop-1.mga9 #1 SMP PREEMPT_DYNAMIC, from Fr 09 Jun 2023 22:57:31, Key ID b742fa8b80420f66; see the backtrace in the dmesg
>> cat /proc/cpuinfo
> siblings	: 4
> core id		: 1
> cpu cores	: 2
> ...
> type: regression, worked with the previous kernel, namely 6.3.6, Mo 05 Jun 2023 21:37:15, Key ID b742fa8b80420f66 before updating today

And then:

> The first hibernation attempt resulted in the backtrace you can see in the dmesg above, my second hibernation attempt from a text console (vt03 or so) has worked without errors and the third one I tried to do from the GUI/X11 again; see the debug options I had turned on). On the third attempt something strange did happen. It seemed to write to disk as it should, the screen turned black but the power led and button still stayed alighted. Waking up by pressing the power button did not yield any effect, nor the SysRq keys (alas forgot to write 511 to >/proc/sys/kernel/sysrq). After a hard power reset it booted as if not hibernated. On the first hibernation attempt I could see lengthy and intermittent disk access. On the third attempt I had waited for some considerable time.

See Bugzilla for the full thread and attached infos (dmesg, journalctl,
stack trace disassembly).

Unfortunately, the reporter can't provide /proc/kcore output
and haven't performed bisection yet (he can't build custom kernel).

Anyway, I'm adding it to regzbot (as stable-specific regression) for now:

#regzbot introduced: v6.3.6..v6.3.7 https://bugzilla.kernel.org/show_bug.cgi?id=217544
#regzbot title: page allocation error (kernel fault on hibernation involving get_zeroed_page/swsusp_write)
#regzbot link: https://bugs.mageia.org/show_bug.cgi?id=32044

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217544

-- 
An old man doll... just what I always wanted! - Clara
