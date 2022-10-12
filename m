Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A685FC97C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJLQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLQvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:51:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79758E0729
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:51:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s2so25323031edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc9aPWwlaDEIemVAkXQodWBJZdXQzUAWkTmFVV68fY0=;
        b=PPRbtC3X/dWkdaga6/ZZnmIo4zcpZu7mj0OcnoRXqs6WmgIly9BfuRMrykKi5WXuUo
         zp7G8XeQ5wr7tWraiJqb6btLJG3syUDC/jLP34XdlSXQW9Lm3OdHhCPiyyYF8UK63D4F
         +yt8q8wn3jWDB9WU56jVz+4tlIgB6VL43rK19Y7R95YF0V6CjN75KIswYQ5ij5VWiH9V
         ESJNx08v8EVbXB4x/8jSqSVgU0oTzd4OTRzGdf7BYc2uaBlfHGBHWa1628VAXJpY60u7
         PKtVuXkyUa8hjIsOEJj4cv4d6Q/Erc2WxmOJ5LkB3mjtVl2i0d5cou2SP7beeVmRvLfi
         dk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc9aPWwlaDEIemVAkXQodWBJZdXQzUAWkTmFVV68fY0=;
        b=VBff1UxtanCrITAzXLrprpvXTztPo3TsvB4W2QHwdX90eyCk5K72LxLOat+yFAcDdZ
         lz51ioq45BENUXRcko5BvZfnUCXKzu1Q9euzOMX4w715o5X8elKhdxU8u78ZCF+xBhjC
         WBqNhRBERiYH+2457/121fVq5FYFW8pSOCWWu0dD2AlIrv0O6zquaDgY6q2CyVZnttFs
         n0HtxglWUB14CTdxhER+3S3oqzhzEBB4Uq6HBN3gQO4a873P3RDUXHAUfTgEkKYloXae
         VzJOAWrU4BN0weq5MQCu68nbpHomgAPgxv/+zrM7jiWSIBCgkQTMQGOkGEhMLN5+dC1O
         ghew==
X-Gm-Message-State: ACrzQf079oOt2LIEnDW5W1p3ryAcPuJjYV69kpvKZhjp1k4uGkymCTkX
        kHwbcwjv6DauTb/dPs7b7TbjfjeS8uNsEHXtbEsyqQ==
X-Google-Smtp-Source: AMsMyM4mL2KbEj1uyd6HS/gLki+zY4bv0j6z+PgMy4GA07O6RzxRDklOcj0SEXaDCbIgjXU1aL+3ME+x2P0sKt5Piqk=
X-Received: by 2002:a05:6402:d6c:b0:458:ef3d:5926 with SMTP id
 ec44-20020a0564020d6c00b00458ef3d5926mr28667061edb.54.1665593479938; Wed, 12
 Oct 2022 09:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz> <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
 <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz> <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
In-Reply-To: <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Wed, 12 Oct 2022 09:51:08 -0700
Message-ID: <CAPTztWZec=aakACy=1VaKOZ0nTbqvY_D+f2xEy0s+sfHL3wXMQ@mail.gmail.com>
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Vinicius Petrucci <vpetrucci@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
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

On Wed, Oct 12, 2022 at 5:34 AM Vinicius Petrucci <vpetrucci@gmail.com> wrote:
>
> > Well, per address range operation is a completely different beast I
> > would say. External tool would need to a) understand what that range is
> > used for (e.g. stack/heap ranges, mmaped shared files like libraries or
> > private mappings) and b) by in sync with memory layout modifications
> > done by applications (e.g. that an mmap has been issued to back malloc
> > request). Quite a lot of understanding about the specific process. I
> > would say that with that intimate knowledge it is quite better to be
> > part of the process and do those changes from within of the process
> > itself.
>
> Sorry, this may be a digression, but just wanted to mention a
> particular use case from a project I recently collaborated on (to
> appear next month at IIWSC 2022:
> http://www.iiswc.org/iiswc2022/index.html).
>
> We carried out a performance analysis of the latest Linux AutoNUMA
> memory tiering on graph processing applications. We noticed that hot
> pages cannot be properly identified by the reactive approach used by
> AutoNUMA due to irregular/random memory access patterns. Thus, as a
> POC, we implemented and evaluated a simple idea of having an external
> user-level process/agent that, based on prior profiling results of
> memory regions, could make more effectively memory chunk/object-based
> mappings (instead of page-level allocation/migration) in advance on
> either DRAM or CXL/PMEM (via mbind calls). This kind of tiering
> solution could deliver up to 2x more performance for graph analytics
> workloads. We plan to evaluate other workloads as well.
>
> Having a feature like "pidfd/process_mbind" would really simplify our
> user-level agent implementation moving forward, as right now we are
> adding a LD_PRELOAD wrapper (for signal handler) to listen and execute
> "mbind" requests from another process. If there's any other
> alternative solution to this already (via ptrace?), please let me
> know.
>

Interesting, looking forward to seeing your paper! This is the kind of
use case I was trying to describe for pidfd_mbind() - a userspace
orchestrator with some intimate knowledge of the process' memory
layout (through profiling, like in your case, or otherwise), that can
direct memory to the right nodes / memory tiers.

- Frank
