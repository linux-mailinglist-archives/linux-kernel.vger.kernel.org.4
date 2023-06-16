Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CA732645
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFPElc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFPEl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:41:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A961B2D54
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:41:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38ede2e0e69so298553b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686890463; x=1689482463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUBNdvZEy5ylqnC9r05Mj1s+Fs0jViK6hGgq08JR7YA=;
        b=lpW8zNecrnLvVl3tPQDWSW1JtAHSbSGZ6xyE4n3jYQY96CmC4DPj/Phz3UBE9Lh2bs
         tacUaFd/1MDJx5J2zv8UULmb6ofCIL+85etXUcxCXG0tn2UUONMos4AEji7ohb19Eef6
         ryBA+N1+Mxf8pO7r80m4F6iVyi0tj61X1o4uDFdOLHzWqyMJLtyW7Qdt5ArGMlbv70mL
         FoH1vO6dSJf7bfacYgoRJMfdRXOLEdQQCKfYR/Arp+pubTeRpN92T2U2iMdsSBGaZu3Y
         JatGt2zxbQHncKkFDKwExEQ6/EYF3kjpTGqfqLm89XW2Y2Kd8T52W2adj/qjDUlBbi10
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686890463; x=1689482463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUBNdvZEy5ylqnC9r05Mj1s+Fs0jViK6hGgq08JR7YA=;
        b=BprvS7XhEjPke0q6KkQwRteuPayrFzATdTO4sHtKyPAmWSuMFLFbOBrD+FjyS+FVwL
         1atPYeeSG0CR/lZKEr+eWrphtofZyXunxkiVxeemj7RF+coVXFZs5f4Is/HC/8tnwrTv
         SdpxHsTcNoVn/2IXT8ZoXcC0HXlmaZ34GlVeOWW+cQr3WjfHwKVPb4rqGpau2TwkVtaL
         LWxxLflaHpTT2pHiRwG3nAxMG60qzFZl/L0kctw+BuoYAhW9AjlHb4zTvban9tDQqFz1
         dVILa51ksAHFshRjhxBoYudExJjsD5aXiKVg2vKvYwaxtcDFU0DwlP9iq8SS2aiOA0Sv
         2Yng==
X-Gm-Message-State: AC+VfDyPgRACPEDv/8/m5Z6VYUbrFoyw9OcGx+EHBAQvJBCKmAPo4VLo
        EVCPOVmm/t79EmJUpJzNvjYyAQdvRSRbaVWXT1fHfw==
X-Google-Smtp-Source: ACHHUZ6Pb+RrF4G2y4aaH71FEJce5C+FydqiNFjzuifW7RzVOZQelbL54EJcfB0FumXcV0ePwos6NzUW4B8lb9ya5nU=
X-Received: by 2002:a05:6808:220e:b0:39e:7c5a:1daa with SMTP id
 bd14-20020a056808220e00b0039e7c5a1daamr1355968oib.9.1686890462893; Thu, 15
 Jun 2023 21:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com> <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
In-Reply-To: <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Fri, 16 Jun 2023 12:40:51 +0800
Message-ID: <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Fabian for tagging me.
>
> I am not familiar with #1, so I will speak to #2. Zhongkun, There are
> a few parts that I do not understand -- hopefully you can help me out
> here:
>
> (1) If I understand correctly in this patch we set the active memcg
> trying to charge any pages allocated in a zspage to the current memcg,
> yet that zspage will contain multiple compressed object slots, not
> just the one used by this memcg. Aren't we overcharging the memcg?
> Basically the first memcg that happens to allocate the zspage will pay
> for all the objects in this zspage, even after it stops using the
> zspage completely?

It will not overcharge.  As you said below, we are not using
__GFP_ACCOUNT and charging the compressed slots to the memcgs.

>
> (2) Patch 3 seems to be charging the compressed slots to the memcgs,
> yet this patch is trying to charge the entire zspage. Aren't we double
> charging the zspage? I am guessing this isn't happening because (as
> Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
> this patch may be NOP, and the actual charging is coming from patch 3
> only.

YES=EF=BC=8C the actual charging is coming from patch 3. This patch just
delivers the BIO page's  memcg to the current task which is not the
consumer.

>
> (3) Zswap recently implemented per-memcg charging of compressed
> objects in a much simpler way. If your main interest is #2 (which is
> what I understand from the commit log), it seems like zswap might be
> providing this already? Why can't you use zswap? Is it the fact that
> zswap requires a backing swapfile?

Thanks for your reply and review. Yes, the zswap requires a backing
swapfile. The I/O path is very complex, sometimes it will throttle the
whole system if some resources are short , so we hope to use zram.

>
> Thanks!
>
