Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69CA6B8F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCNKHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:07:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55928A39E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:07:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x11so15991372pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678788468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elhZ/C9pEmcrQnwXGhf3DLeYvCwzpsEGSIJ8Spn1p6g=;
        b=bOQ/No7ulDtOd+Njr+yjbztQjxqbMkKy5sbsPkg0Nl7aM4yku3wlelGi5ouq89QyWk
         IlNkIAqq8DRxigf3qUgHvWu5r0J8000E5yoM3MGmsvoLDeZIv4z/BBDlUbIjEQ1dAmZW
         dG5YxL12tUJlJNg/ZTlvk6veabY+fJxNwGt18S/XFHq1XcXoV/tpkNWA/9/RXCjvi1ZE
         QW6+oj39pOTNlB1JIAC2XCPSqdzx2YkpTh+GipaIoACbjCrqBkKDdO3ZGCl0S/GqO8i4
         0yDFuH0q1fc1ZeABbz297c7nWw6Ax4yik7Cfw0sgvUgDzauQqbDAXOOGtMXICm6YR9ax
         UMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678788468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=elhZ/C9pEmcrQnwXGhf3DLeYvCwzpsEGSIJ8Spn1p6g=;
        b=gvNzHVoc15LHdsL0Erl1ptyx1SI8moHj6AaBGOEGhR2wr2LGdH95gQNJLyi2Top34V
         KvEE5XmUM/D2QRKgU2QrwEsb2EcoH5n2mzp1s6KTQ1W0DGGuKue+NYmjhduIpTQmazsi
         8U0OZLEKJTifEM9y4qDWpAXy91gP5fIsreS/8lcM0/ktuWKBq3zN8/wNvuIC1+GH6vad
         R4goeKkqfSOIyZO8IjEDQPtbQfBm0spFYN5Hb7z7CK41AWqy/k9j9zmedWrEjxLspcR1
         sohpTKBAPcH2wqi8gu3YFCzJAwsGpwZLfSnbxQY2lYGoj7UH2ghbdnnDXg/CXO4LNOjG
         ZnHA==
X-Gm-Message-State: AO0yUKVor1IkwNWIbz3sMmQqzWFnyjeOGjwMtKXf5bkS48m2nWkwjuNQ
        pU2jh5hQh9iqwJF4Jj0d8CfPmA==
X-Google-Smtp-Source: AK7set/0lUhiaUwEFfWQ9KqPzd8epwXjlX529Y05bAIE8sXE6S/pHWelr/eUxORSvYzPowBgCWC6Sg==
X-Received: by 2002:a05:6a21:78a6:b0:cc:5f27:d003 with SMTP id bf38-20020a056a2178a600b000cc5f27d003mr17953144pzc.56.1678788468185;
        Tue, 14 Mar 2023 03:07:48 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id q25-20020a62e119000000b005d6999eec90sm1220148pfh.120.2023.03.14.03.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:07:47 -0700 (PDT)
Message-ID: <f774cfeb-9524-5fd7-fe2d-e6c2a58684e2@shopee.com>
Date:   Tue, 14 Mar 2023 18:07:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND] mm/oom_kill: don't kill exiting tasks in
 oom_kill_memcg_member
To:     Michal Hocko <mhocko@suse.com>
Cc:     shakeelb@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230314091136.264878-1-haifeng.xu@shopee.com>
 <ZBA8NlwBTprShO3e@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZBA8NlwBTprShO3e@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/14 17:19, Michal Hocko wrote:
> On Tue 14-03-23 09:11:36, Haifeng Xu wrote:
>> If oom_group is set, oom_kill_process() invokes oom_kill_memcg_member()
>> to kill all processes in the memcg. When scanning tasks in memcg, maybe
>> the provided task is marked as oom victim. Also, some tasks are likely
>> to release their address space. There is no need to kill the exiting tasks.
> 
> This doesn't state any actual problem. Could you be more specific? Is
> this a bug fix, a behavior change or an optimization?


1) oom_kill_process() has inovked __oom_kill_process() to kill the selected victim, but it will be scanned
in mem_cgroup_scan_tasks(). It's pointless to kill the victim twice. 

2) for those exiting processes, reaping them directly is also a faster way to free memory compare with invoking
__oom_kill_process().
