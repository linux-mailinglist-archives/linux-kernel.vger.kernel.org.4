Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5F5B30FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiIIHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiIIHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:51:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7712518A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:46:24 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-127ba06d03fso1932632fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ezqTgX5aoFbbwvpb8+qZYeXbiyBI9c/LxzdN5thGYBE=;
        b=36o10mPT7FUuo1YoAo7NjWWgKGI1JALa6tQB4PGmjQu8/LEQLz3vqdyC27sKqApetx
         PF1vTDo18oi6kKiNlE1GiqzwKaPZeH4tOu4KavJWHrq0rZTmteHrNLarqezaeWXX5THn
         mJHjFSwnXgFs8wyPvx1JzQcDK60oeyZCEuTjPW+1TI8t6Z266xVoNgQ9TTUxfHiFuVhb
         p1SP6ENaW0EJLH0Tmve7+778fLX0KAT+pzZGEZgXCjf10vT62iMX+UpKxOSa2MeGpvIX
         vw3PX+4LGhdp3im+dV/onIYCZo0cU1r9qd/RmZwc6QdAxec8SYPRW3B8lnCbpPGYURw1
         my4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ezqTgX5aoFbbwvpb8+qZYeXbiyBI9c/LxzdN5thGYBE=;
        b=1/PARklN0ZyHaYUeyymz5lvDcJdvfuOikU+VhXzPhSPp9ED/7BPTgfm/OTVcYGtbOJ
         SXwIuZL7gvpW/Ir4ztIWP5qtmx0cHOEm5stW9VFSgdWONuscS0Fk6hJckEi2aBSG7zm3
         g5aENqmWJHut9F8dmWPPw1YdF4zZlMJUdAESBJ7xYP63naUVuoGOKid0aEhoJcsuLUtB
         Q+ysEOYx8SvRabbc3z4o8WDO4uhTWibCPNDaaos+72u8dnGyAzkCk44cCXYWhFCmZJ/0
         Vu6K8hzwGEjozW91sbxP/6z3aWkHz+q2kqPrMqXYTrbvwhwwcDh058zywLXHP3IRSRGk
         vnNA==
X-Gm-Message-State: ACgBeo2T0hNYNjA2AMEvGqQFSq+5NWZhijRKYHlCqV8PQN7E7AqXNzpN
        fCa8gmofjC9ffPaRDtQBB86oU4Yp711fiw==
X-Google-Smtp-Source: AA6agR7qNrCFjMSZtJX99NaFJwB36AGWp6zJMOQ+DYnsGTLGnxJJr/oMTnL0JwJEv5/AhJc6HAn/sQ==
X-Received: by 2002:a17:90a:640c:b0:1fe:1763:e169 with SMTP id g12-20020a17090a640c00b001fe1763e169mr8147519pjj.35.1662709106554;
        Fri, 09 Sep 2022 00:38:26 -0700 (PDT)
Received: from [10.4.108.105] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id r17-20020a170902c61100b0017532e01e3fsm708598plr.276.2022.09.09.00.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:38:25 -0700 (PDT)
Message-ID: <c7ecca99-696f-220d-7ecd-9be51cc947d9@bytedance.com>
Date:   Fri, 9 Sep 2022 15:38:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function
 'do_softirq_own_stack'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <lkp@intel.com>
References: <202209091157.akimiv18-lkp@intel.com>
 <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
 <69409ea6-6daa-7973-c950-c6ca9ad96f50@bytedance.com>
 <23cde275-613b-4895-a05c-48a0ec55ff6a@www.fastmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <23cde275-613b-4895-a05c-48a0ec55ff6a@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/9 15:35, Arnd Bergmann wrote:
> On Fri, Sep 9, 2022, at 9:07 AM, Qi Zheng wrote:
> 
>> BTW, when I just compiled the kernel with W=1, I found a lot of
>> compilation warnings, which is somewhat unexpected.
> 
> Correct, the kernel test robot only sends emails for newly introduced
> warnings, but it will keep nagging you about them.

Got it. Thanks.

> 
>         Aarn

-- 
Thanks,
Qi
