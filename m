Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143FF6185FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKCROp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKCROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:14:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4786D10E2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:14:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p21so2535053plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38PbifJ82siOWP93EOR7nWjQvXdjLMHLCirjt79C52Y=;
        b=nBhmOboQE7UtoVHovVd+g9wJf2OqjOgsAYJ8dO0/Bqta4VQW1Yxv6X5VtZb8gdYx6Y
         df/AB3UlUgcySW2Mx8iZjVxzuYSy0hd4qF3anpFaS2s2EHvovwQ/tziVoNE6aC8bTLPc
         rpLEnmZCBnNvb8SC4uyu/IMdM3mdAQ2EVPRMyT8jdVCVhBfc18hAU4JUK2hdIRUHu3ld
         Yj8DFWhtMoE6esL1DWUfJJgFhTq45luEB/oJ4ujzAZ95OYrA9ReUR3D10TCQPqZqIVeQ
         wAHrxd9i8NWpCJ8dDgEp2u2OL1+7nYO7VBx8Y/oKVsIOewYdkC7YCzJv5rVhvx80c0hd
         TL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38PbifJ82siOWP93EOR7nWjQvXdjLMHLCirjt79C52Y=;
        b=0M4Q3h9Ry8qytIp76IxBip8qKffbeEdn5aeg7+JAs3V4yRmpfytJCoTq9+Qa+3sXi1
         MLe/ceg/18kIts6Ed2h/1Hr+WZDwNXe6vUFX5Lb+drlc86rRp8QJ6WimhcH4FsBYAkKF
         2C4nmM6pQ+K1xPleyxk39GUpVizDWO8NkhlREeK7uOT5qzN364E8iWygAfrkshP4nE4q
         aqwttkIx4k6Tk86nxfQTDTLJlT6z1yVpneh2LETI6gNfJ6IGbZ3nqWOiaNfz9OWgQ2ur
         A3K5kBeAL6XMcN0Fk5Kk+GhCkB4MzjiXr4AcTucIgIVENk++UNRWKcPKclXDvzRL1yqS
         QGLA==
X-Gm-Message-State: ACrzQf343cIzq1qWjj5R2aPXJlewbSu0piSzS8kQWFByfJ7GwsOybL5e
        vkVZh0+OmxWMZd3LimtBiJsOUKrLRnBYxpwN9Dg=
X-Google-Smtp-Source: AMsMyM5SFGmJQcKgV8VOyIegxXexsNHSW5jZFAzrpn8N1iAPMuHPcnEq83AZESGEVpJCuxBG58eMBvq5pNDn0CiK3mI=
X-Received: by 2002:a17:903:41ca:b0:186:a68e:c06d with SMTP id
 u10-20020a17090341ca00b00186a68ec06dmr30249533ple.61.1667495646749; Thu, 03
 Nov 2022 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz> <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz> <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
 <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
 <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com> <Y2NzvfCjd0X4g4p4@dhcp22.suse.cz>
In-Reply-To: <Y2NzvfCjd0X4g4p4@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Nov 2022 10:13:54 -0700
Message-ID: <CAHbLzkqXRLaAYsD+f5B5hgoE+STGat1syzpCUFH3f6W=HtMULA@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Davidoff <davidoff@qedmf.net>,
        Bob Liu <lliubbo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 12:54 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-11-22 13:08:08, Yang Shi wrote:
> [...]
> > So I think we narrowed down to two options:
> > 1. Preserve the interleave behavior but bail out if the target node is
> > not online (it is also racy, but doesn't hurt)
>
> I do not think there is merit in the interleave patch is dubious to say
> the least.
>
> > 2. Remove the node balance code entirely
>
> Yes, removing the balancing makes sense but I would still hope that we
> do not fail too easily if the range is populated on multiple nodes
> equally. In practice it will likely not matter much I guess but setting
> up all nodes with top score is just easy to achieve.

OK, thanks. I will come up with a patch to allow fallback between the
nodes, it should be largely based on the change suggested by you.

> --
> Michal Hocko
> SUSE Labs
