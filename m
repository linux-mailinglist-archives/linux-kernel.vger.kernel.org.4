Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495F5FC565
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJLMe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJLMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:34:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F574E099;
        Wed, 12 Oct 2022 05:34:43 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z20so16073791plb.10;
        Wed, 12 Oct 2022 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFBHoOeG3ghGeuO274+7fL8QgYjk7OYjm0X789Rsduk=;
        b=ea0YD8TEwyHxV2D0ffzgep/rqf+7nMi89namwACoS79RTxlEuwazEaupSaJqkcaIhP
         W5BWcaB16bI2AalWWeM36/ijmi76MRUFY7aE+d/m83LdlAGuSeOdwL8B2R/V3bBq09D9
         /p9L55f7HaKlONLqq8N1ZWKJ1q0pPVZalzfB9xgVrbqqbJ2UP80VxhzsQBeZQH8MG8W7
         tj9vvM6YOCEFNMOLHKTXyAPP2I/jI2I5CkkRJ2eiLYyAO9I1UCsDYvOEbPrH+obRCv6y
         yxfwjE9IZYrkCpzlbrZ5DKX6wqB79ZqyomP7C1u83f7ty7IfaFl692KGlOqQrxAxxL2x
         NZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFBHoOeG3ghGeuO274+7fL8QgYjk7OYjm0X789Rsduk=;
        b=Nks8kibAKPMbWVzc5b7e3chQ7QPe9pT5mFf8KpS5nuGkgLZN0Icmc7JP5owG14X3Zo
         rSBGNVniCtbhID85y8oBQNW3zrWLjNO6C6vZ1kQxTCFkS1wHL+GELY/OP7mcNx9fdTER
         Bd2gF/pTpDKH4BGkqqYUTMe+umDqC+JEW4WsdMu+eXWTEqSD5YvEktwtIA3q7NWoBkbo
         bttLygGuTiDPFphhu4703qWl7CM8UcVL8WyQZfOOWV91FkuF9zjc6Kq2KJJQy/jPosNz
         +sP7xQ703nzPj5ZPBE69YrCMg4eObTQjpB5upvWOZ3yg+8u2HpAGygRTjrvZsO7ltLhB
         z1eA==
X-Gm-Message-State: ACrzQf1SZm1d0f8lsSRoZu4zSDciezKRv8bF9YefqLL4oUsX4zqsML2S
        H5Ojfmpv0JxMlIoC8nePbihqIgKZKhcyr1wW98s=
X-Google-Smtp-Source: AMsMyM7vomdIe7mnxwPdFaZGIzuDJHCoALDasxWDvWlwqR7qabo9kulZv+0PAH7jr/hGViyB7QrdwnPv3s0QAACNN94=
X-Received: by 2002:a17:90b:4a4d:b0:20d:4dc7:fa72 with SMTP id
 lb13-20020a17090b4a4d00b0020d4dc7fa72mr4814262pjb.86.1665578083191; Wed, 12
 Oct 2022 05:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz> <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
 <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
In-Reply-To: <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
From:   Vinicius Petrucci <vpetrucci@gmail.com>
Date:   Wed, 12 Oct 2022 07:34:06 -0500
Message-ID: <CAEZ6=UOA6=ikSdxN662xyhT3wauGuqZReKLOb=_9EmSRckNr=Q@mail.gmail.com>
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frank van der Linden <fvdl@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, per address range operation is a completely different beast I
> would say. External tool would need to a) understand what that range is
> used for (e.g. stack/heap ranges, mmaped shared files like libraries or
> private mappings) and b) by in sync with memory layout modifications
> done by applications (e.g. that an mmap has been issued to back malloc
> request). Quite a lot of understanding about the specific process. I
> would say that with that intimate knowledge it is quite better to be
> part of the process and do those changes from within of the process
> itself.

Sorry, this may be a digression, but just wanted to mention a
particular use case from a project I recently collaborated on (to
appear next month at IIWSC 2022:
http://www.iiswc.org/iiswc2022/index.html).

We carried out a performance analysis of the latest Linux AutoNUMA
memory tiering on graph processing applications. We noticed that hot
pages cannot be properly identified by the reactive approach used by
AutoNUMA due to irregular/random memory access patterns. Thus, as a
POC, we implemented and evaluated a simple idea of having an external
user-level process/agent that, based on prior profiling results of
memory regions, could make more effectively memory chunk/object-based
mappings (instead of page-level allocation/migration) in advance on
either DRAM or CXL/PMEM (via mbind calls). This kind of tiering
solution could deliver up to 2x more performance for graph analytics
workloads. We plan to evaluate other workloads as well.

Having a feature like "pidfd/process_mbind" would really simplify our
user-level agent implementation moving forward, as right now we are
adding a LD_PRELOAD wrapper (for signal handler) to listen and execute
"mbind" requests from another process. If there's any other
alternative solution to this already (via ptrace?), please let me
know.

Thank you!

Vinicius Petrucci
Principal Performance Engineer
Micron Technology
