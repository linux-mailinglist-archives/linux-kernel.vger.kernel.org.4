Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E3683525
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjAaS1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAaS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:27:05 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50633FF2B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:27:03 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b1so19231974ybn.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HkHNPqnVxAIY/tqIt7qZnRTR4WfHWVZtazfgEEVLA1k=;
        b=tQEMNZ1+yeDZEj71B07fcjB50jM1i6aOuywWS/FEjrOnp3EcR69hAad3lu7vZn711m
         rWFCK+MRQGo98+OX7Z5YJLQhXxWxcbseEzjAKbTV3mnOpdwwmNbpFwvbdi+eNLV/KuMk
         sNXJc8FHml2fwt05JkbGF5OXq5QschNyjjqDrAvpuG6zFZbmRhPSLQnUptA+sed4s+4u
         /ShnkTt4PmvgX5jmo1mCcs2pWa08grni3e3ApLv3uhCKCxfacTcGLbncAhJRnWaiVYSm
         tdI+8rQTbvf6cG+WE0yUEx2Rdr8MDao7T3rRNVqVLCHHtQydcDhp9f9RmGWkoukyc4Oq
         rcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkHNPqnVxAIY/tqIt7qZnRTR4WfHWVZtazfgEEVLA1k=;
        b=fmMjjWXLtbr2G5ygDjcCVtkU/ni2h2sareq8/38Z158+qemS02Zuvzt5VhoBsm/mFh
         0CM065BBZ6ITEjXt/O7YlxRXhYKXYe+8RV3BCCqHXifCIvIMgqErAy/DK3HZh2mijq5A
         cIIx6eUcqlojUck0dBV8DenHQDwhYqFPaIbEm0u2k6URsEPB8N12rND/8LmPQhgEf1sl
         FKYVUYB8AKb6/tkDUkSKc1T/Yo5nNZN0OylgGjKTkHpX/PxYtcn91xysNG8QuMRqJ+XU
         KHiNQVqN7dQ5cfo62a+sJe2CWJ6CDQnFgK9R5+JymIKb8iG2Zi71pUQkE3V6cyQN32+b
         BInQ==
X-Gm-Message-State: AO0yUKUQqUuYKN3w6FjkyWM8fzdqfatu6TjKm5TPQmQGxHSHOI+lxU93
        pgVPgtxT/Zkqbw64iOVAVolnGCEOZWxwCuPnAnunOg==
X-Google-Smtp-Source: AK7set9Wi/SxOYBU/ud8H+po+UJzdx1g7/5fVkPjA4w3dbgGjnozI/UIgrAp4ux9zJMjoCX+yuiExNDq7TyEEr9b0cI=
X-Received: by 2002:a25:bfc4:0:b0:80b:877c:7a56 with SMTP id
 q4-20020a25bfc4000000b0080b877c7a56mr2044611ybm.368.1675189622981; Tue, 31
 Jan 2023 10:27:02 -0800 (PST)
MIME-Version: 1.0
References: <202301301057.e55dad5b-oliver.sang@intel.com> <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com> <Y9iq8fRT4sDgIwQN@casper.infradead.org>
 <20230131055743.tsilxx5vfl6gx4dj@google.com>
In-Reply-To: <20230131055743.tsilxx5vfl6gx4dj@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 31 Jan 2023 10:26:52 -0800
Message-ID: <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
Subject: Re: [linus:master] [mm] f1a7941243: unixbench.score -19.2% regression
To:     Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+per-cpu memory maintainers for FYI.

Thread started at
https://lore.kernel.org/linux-mm/202301301057.e55dad5b-oliver.sang@intel.com/

On Mon, Jan 30, 2023 at 9:57 PM Shakeel Butt <shakeelb@google.com> wrote:
>
[...]
> >
> > We could cut down the number of calls to pcpu_alloc() by a factor of 4
> > by having a pcpu_alloc_bulk() that would allocate all four RSS counters
> > at once.
> >
> > Just throwing out ideas ...
>
> Thanks, I will take a stab at pcpu_alloc_bulk() and will share the
> result tomorrow.
>

OK, not a one day effort.

Andrew, which option do you prefer?

1. Keep the patches as the test workload (fork ping pong) is not a
representative of real world workload and work on improving
pcpu_alloc() for 6.4+.

2. Revert the patches for now, improve pcpu_alloc() and re-introduce
the patches once we confirm that fork-ping-pong is not regressed
anymore.

thanks,
Shakeel
