Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E196A68C973
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBFWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBFWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:32:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC647EE8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:32:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l12so4285798edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7GqiDnnbtUw28nuIsiTOre+ZKz+TpI1lg7hwVstG3g=;
        b=bjqC5GS/eZCj8Q0tz1L7nhIPi+KBAKimBOQARz+19LvOTMg3hMzlZzkrgdDEO6xqTb
         B7RSKAxUSBQ5hXb3vPRlno1jQ2dpZDRN9VUVLwy02Qh424sdV3GZybk3TDAEj4DZiAFE
         r065BaTFJy8y+uMmf9W4ObmnllL8uoPjTyH7+iMmk8bf2TKfR6eMn2wGIaxPpVi5NtVU
         gZCa1vJ87AX5mxbHOJNqbU44FQI7mCgPPROEJrSQq4YL4mTjbMThGyFHIA6R3bcYqfnA
         1qUiLR04aRJKbuOqI21o9cr8g3s4afL6lwp8mHwwoD5Ap2cMEjB3r52ZQmSA0Q5hczb4
         e77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7GqiDnnbtUw28nuIsiTOre+ZKz+TpI1lg7hwVstG3g=;
        b=xK62aA4QBfHA3e6VthjYJVhmNrnibdyDEC+FYrtciV1abB0+7s8lkl19xf3OcIMRSD
         g62hJZ6UxIqdTauTdK1/6gVVdWZULQYdGjAQxBYODbGVywR0MUWVj82XIsK5cQm0hLii
         6Zx1NFhNTmI1fGNDZXa2YchXCXV48HUxGReAQgnXts0fE53xC/BhC3V4GXZa8NYaypwT
         eFKyLnC/IYadMM4ZyQ20xs8yNsdjhB7HACRWkt+1XdJlAMjn3yNzFa5epYpqaOWZeU+D
         ihRRfipeQRzLpFbI9gL0Vd5OfpCGShw9uqt+qFnhm89viWIU/1iUMFAD3dt4vda6jTU3
         AW0Q==
X-Gm-Message-State: AO0yUKVOUUrewZYU2CDZf37g0+Hhe+ed8CiiDpSGsP6s/M/DJTs9ilIB
        u+0wcmg/a7hi4PXJBvNu/h5d4dgRIySG9T3OHhRqJA==
X-Google-Smtp-Source: AK7set+fpQlkQiXWMD+8ZcR3RJN1nHtZejJ0HA+mjicGMdIFu+JAoEP4S27FYorBirbtxbR7/J9pRmKttPt7Z+Se9PE=
X-Received: by 2002:a50:c053:0:b0:4aa:b1a9:c77c with SMTP id
 u19-20020a50c053000000b004aab1a9c77cmr28409edd.5.1675722767487; Mon, 06 Feb
 2023 14:32:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
In-Reply-To: <Y+Fttp1ozejoSQzl@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 14:32:10 -0800
Message-ID: <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Tejun Heo <tj@kernel.org>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Feb 6, 2023 at 1:14 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 06:47:51PM +1100, Alistair Popple wrote:
> > If too much memory in a system is pinned or locked it can lead to
> > problems such as performance degradation or in the worst case
> > out-of-memory errors as such memory cannot be moved or paged out.
> >
> > In order to prevent users without CAP_IPC_LOCK from causing these
> > issues the amount of memory that can be pinned is typically limited by
> > RLIMIT_MEMLOCK. However this is inflexible as limits can't be shared
> > between tasks and the enforcement of these limits is inconsistent
> > between in-kernel users of pinned memory such as mlock() and device
> > drivers which may also pin pages with pin_user_pages().
> >
> > To allow for a single limit to be set introduce a cgroup controller
> > which can be used to limit the number of pages being pinned by all
> > tasks in the cgroup.
>
> As I wrote before, I think this might fit better as a part of memcg than as
> its own controller.

I guess it boils down to which we want:
(a) Limit the amount of memory processes in a cgroup can be pinned/locked.
(b) Limit the amount of memory charged to a cgroup that can be pinned/locked.

The proposal is doing (a), I suppose if this was part of memcg it
would be (b), right?

I am not saying it should be one or the other, I am just making sure
my understanding is clear.

>
> Thanks.
>
> --
> tejun
