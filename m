Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3360AE52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiJXO5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJXO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:56:47 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4408811E47E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:34:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id u2so5163384ilv.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lfbbdd8m3exY54PJ70XsxZ5WZRKTVQmtXn7p16MZtx8=;
        b=mK/sJ2sAUxDQqsX9xUPzACU5yfL0+2msGHbuXQDVEeIvNxrwdifcNpDdAYflyFO2h5
         wQcMQhzfdz3AJ/Erw7lKDzb4gZ0kOmaxDzRulOLeqCajZwQymVAbq88Uj7k7PUWjkTGW
         q5oEralxI+44cfMTT67LEVv/v81sdhOfzFVXZdSnjD8bxC2l/EU5EXJvWFz6qoMOHKOa
         3200txfgWKrCd8u7CotU3KKQRen9qXiZ+PxmhuM7xoC/7V6WYBlr+9fQ2lV7WM4zH1bQ
         FEIDv9ROi6rG7pDI9llgkWewWTRT8ViJ9piEpRkrc10WNMJzRGWhgCAXPWn4Lm+LlOUm
         AKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lfbbdd8m3exY54PJ70XsxZ5WZRKTVQmtXn7p16MZtx8=;
        b=m3qhaqXlAMZyEsnQvQFClA67DcatdKMcIsbhRp676Hc0a2J639v28idexwkY8GN2To
         j9TtkoESjUOQJra7yJlMoeuKRq5S7DnRa0FukVjP7BT3/Y2cIlByWpcffdTdjzU4kxYd
         3ib1t1NZofb8iHVc6Gco1Qy6QZG+YFdOmp+YFECMSgwNnEPx3uK7FTtSxFXfdSp/G67o
         HvuSKOjnJxaiSFMFX+y5eusCIkOIg+F1u4vhtX/ZF9A3vun6IuGHWxA3gsDX72nTsc0K
         aSE/FLeeorYv/0K0lHfqTnG0J10PXrM07H+vs/cwgc0tdTPP1ob2tcHsG+02gUHRdenp
         NQqg==
X-Gm-Message-State: ACrzQf2pUOnW4UGd2O3WMRBTdxtqcmd/0Ebeg/kHmWXi/efXfCTo4mcw
        NUSzR2joCEQ/dJFPQyATCei3wE80LsA6mebi
X-Google-Smtp-Source: AMsMyM59y1Lej1SJlG4qCtG52x3QuFnZ69Tk1DkYp7mNgm22zXD3dqT423+Xg2qU6Njxb8kI19Zxzw==
X-Received: by 2002:a63:2215:0:b0:43b:e00f:7c7b with SMTP id i21-20020a632215000000b0043be00f7c7bmr28034739pgi.511.1666616469665;
        Mon, 24 Oct 2022 06:01:09 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d68-20020a621d47000000b0056bbba4302fsm2265363pfd.117.2022.10.24.06.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:01:08 -0700 (PDT)
Message-ID: <e9bb46e4-c8d3-d5a0-9bed-27eccc2ea2ab@bytedance.com>
Date:   Mon, 24 Oct 2022 21:01:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH 0/2] Optimize the process of scanning CPU
 for some functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <Y1ZiKz1rxEcQ886D@hirez.programming.kicks-ass.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <Y1ZiKz1rxEcQ886D@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/24 Peter Zijlstra wrote:
> On Fri, Oct 21, 2022 at 02:15:56PM +0800, Hao Jia wrote:
>> These two patches optimize the process of scanning the CPU by
>> adjusting the search order or breaking the loop.
> 
> Is it really optimization, as in it now runs measurably faster, or just
> cleanups?

I'm very sorry that my description confused you.

Yes, these two patches should just be cleanups.

Reduce the number of attempts by adjusting the scan order or breaking 
the loop in time.
IMHO, it will lead to a little optimization in most cases.
But they won't bring significant performance gains. So, it's just cleanups.


Thanks,
Hao
