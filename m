Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0948560AE31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiJXOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiJXOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:52:04 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1E3FF29
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:29:58 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id t16so6448810qvm.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHghRZjBeTS90B4qoyUHf9OG4smg4KARDuUEr/LIvD4=;
        b=iIHMrhs9kKLgXae/xDy6cjdwMdsIvEGogKmbpPAarpAO9eVWps86VxL3mpOpoE9NA7
         ZvEAxpZC16/ssSaU1OPH8ayrqjzhGFuk+csP89nHH499SyPsCFUX2gvl66Dni/ZAwk2C
         T58qjCvrHsjHR64iBACPO94PwUM6zIBBUm1IfMDjbIGLW7lGkgqsrIkx1Wrg5GGnPRcn
         XvuhiNw5Tu/PH5OhJIXuLhUbjBcZDIVt9ZlPw2lF4L+NS1fqtH00nVWpRbh2qBvpxOGV
         aH/o2xOuZ4iYXjDaBtmfZgMDKlH47IaX83O//hdKSA/ROv0S3PlheXcFl3iKnJbueKH5
         sFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHghRZjBeTS90B4qoyUHf9OG4smg4KARDuUEr/LIvD4=;
        b=XQK/mohTnXEBI13sFiLd+8twYmReJ+K09/mxecGWclSNeASHF9Siy06Uvz0MVyOp5i
         Cka/8pSOXyoW/D+HscoFNLAFtZfBZHGzxwuTrKS1++9IT2YLj9weUkTYkixSVJNYM6K/
         dhlZbKaWZTwOkSLM4O2L+SAzjiNjCUBgAmczHoDm/niQFX7hlumgXZ6BI5+lbRPE7E8H
         Gzi8umWx70gZqs6w/shsiGteXQYchQ10d/lp369VlqX+xyaK4CY6iRk8HYKb2bArN0qO
         pXD/Dz8m8pJckvEqOf0Hvwd4ek4QLJ36jxDMXL4nHXj1gnzW1SJtO7uJU3HDY4xGAB/k
         KERw==
X-Gm-Message-State: ACrzQf1kil3d3UQBDjGbYT7veL2r8h0256C14oeALFBL82zQRl79FQTc
        GOUNpGVw8d2L7IFb9wI0+tHYLbJnJhWSA6CA
X-Google-Smtp-Source: AMsMyM7JPO6XLEtIK+PH7NHwZanw+kbA0ReToyS5eSkJE+v+rOjkN8LogmWnmCW2ykvLT8/deYnhTQ==
X-Received: by 2002:a05:6a00:88f:b0:52c:6962:274f with SMTP id q15-20020a056a00088f00b0052c6962274fmr34222508pfj.12.1666613264040;
        Mon, 24 Oct 2022 05:07:44 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902d59100b00186a8085382sm1589525plh.43.2022.10.24.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:07:43 -0700 (PDT)
Message-ID: <ce44cad1-8eab-4275-6c7a-6208265f3ae8@bytedance.com>
Date:   Mon, 24 Oct 2022 20:07:36 +0800
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
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Just from code analysis, it will lead to a little optimization in most 
cases.
But they won't bring significant performance gains. So, it's just cleanups.


Thanks,
Hao
