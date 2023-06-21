Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09987390DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFUUiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFUUiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:38:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2E6EC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:38:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77e3f25446bso106324639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687379896; x=1689971896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IVDT+pHiNYnFSITOZZiipEu5nJYuLpHmhrSiK63MvU=;
        b=q9QaF7gpeCfzxdbtkgaNBWMp+z+n5J21Q95XVt1T79jLqR9ZnQdNa8YbtRG9jN1y2M
         ajit1EAmXJOB5ia//hxw3LVBUkFIy035lIYKH2QHR31AuTuPaZhPytxTW27y4lXwXuJA
         hNJAaM7OesGjT4Nubiv69k0TvokQG35CEZ3E1iAR+KuscDsa/B4CFZW9rgIsyQwzUlIz
         IiLDF3OW9kIvehJau9NN5p4dV+1Q1s4G5yXJUWXxqCLlU0lebxyltSKtjfB+S8AFn66t
         OcYUt7FDnoRQDlvGEafNNN+LyB/9NBgF1n9RHouhxX6phgOfGIQtL4wX2693hMDZvty/
         Iy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379896; x=1689971896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IVDT+pHiNYnFSITOZZiipEu5nJYuLpHmhrSiK63MvU=;
        b=GvdIn9fI1YCcaW6yanno+MCoDKHvAuQ24AmiK1kB3sJH14x3Yg1B6MY5RkfZUlcsXe
         CH6mxBtUlW9xcpgEgtTfmoOMp8mfkQdsBVRrU81zCCCcEm4OpqqvYxbzLm8LluqDoyOc
         csiBNNQtBAMXbkb27pQvAj8HHSeibxgr4P1AjZgpSVvP5zAYqYRzFuD1q0H/B0CFt6q6
         YtuzsfW38Rwt4s4a59MSmSidntDEehd1FGV3tI5Kwkiqive2kh4fKk0SHe5xgNmzCq5u
         cqH8Z5bCHjbiXpgDbrN06ZEOeo/NHiCqpYRAflINoRvg2ySmKIiQkzZekN0cfm3JFvQV
         okBg==
X-Gm-Message-State: AC+VfDzaTzwzF7C4ERogy4/63NyT9v0bFRv0wyBDsZZgJdHozfvti+4B
        xi0O34vkUgWY1xftUKPcasc=
X-Google-Smtp-Source: ACHHUZ5MTF4zSqzWhLiOWwa71LlYb/iMx+JkhRe5zn8h+XBxQJVLm3vw1pbZjEi+KOrU/G8jY8JdaA==
X-Received: by 2002:a6b:c9cf:0:b0:780:c92c:38ed with SMTP id z198-20020a6bc9cf000000b00780c92c38edmr409190iof.0.1687379896206;
        Wed, 21 Jun 2023 13:38:16 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id q1-20020a0566380ec100b004188a9370d7sm1562609jas.98.2023.06.21.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:38:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 10:38:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZJNftsP2t6b7taQE@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <edfb9182-72e8-8bc2-bae9-2384e4e52577@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfb9182-72e8-8bc2-bae9-2384e4e52577@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Swapnil.

On Mon, Jun 19, 2023 at 10:00:33AM +0530, Swapnil Sapkal wrote:
...
> Thanks for the patchset. I tested the patchset with fiotests.
> Tests were run on a dual socket 3rd Generation EPYC server(2 x64C/128T)
> with NPS1, NPS2 and NPS4 modes.

Can you elaborate or point me to a doc explaining the differences between
NPS1, 2 and 4? My feeble attempt at googling didn't lead to anything useful.
What's the test doing and how long are they running?

> With affinity-scopes-v2, below are the observations:
> BW, LAT AVG and CLAT AVG shows improvement with some combinations
> of the params in NPS1 and NPS2 while all other combinations of params
> show no loss or gain in the performance. Those combinations showing
> improvement are marked with ### and those showing drop in performance
> are marked with ***. CLAT 99 shows mixed results in all the NPS modes.
> SLAT 99 is suffering tremendously in all NPS mode.

Lower thread count tests showing larger variance is consistent with my
experience. Sometimes the scheduling and its interaction with workload seems
to exhibit bi(or higher degree)-modal behaviors and the swings get a lot
more severe when clock boosting is involved.

Outside of that tho, I'm having a difficult time interpreting the results.
It's definitely possible that I made some mistakes but in theory NUMA should
behave about the same as before the patchset, which seem sto hold for most
of the results but there are some striking outliers.

So, here's a suggestion. How about we pick two scenarios, one where CACHE is
doing better and one worse, and then run those two specific scenarios
multiple times and see how consistent the results are?

Thanks.

-- 
tejun
