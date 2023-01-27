Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D767E027
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjA0JaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjA0JaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:30:08 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D555783E1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:30:06 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id l20so2156176vkm.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ysjH+7PyXERt0dSFZ/+JxtmEhrZYdPbcws7HaV0LWdI=;
        b=DoP1LK+vXEBZag/CfOsoacZjAoODDMs0JBNa0CgJ3y6OMgqIdqZpXeHsl4XEAuPnEW
         DUMyFHc56BUmUBLKRc7Eodyzr1tWZj1K6ntV3DXwMi6+wvKUyDpJH+VyLlWq1JfQrpoJ
         FW8t1sKZoR1OcGAGr5B7fDpluAauRHBmsjUfa500QBUrw6cThAWchphkt5kHOOaqmaDw
         3nEB60yjn8U8CnBcefX+16QKcdYOzKAoCCIx6/fGOy0INaGqkIgM9ILRQGs+aNo6wz5L
         45fdtcY3frbeOJbi6HINuLw36W0RF2SDh036bJ8EvigZbI5JRkw1N5GRNmBoFGkB5gzT
         JVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysjH+7PyXERt0dSFZ/+JxtmEhrZYdPbcws7HaV0LWdI=;
        b=ymMekjaUahcq8OBtq5lvgVgezO3yZ8r0dUrQMKMY6FzB0lF1ik4vdm/YiLc7P1FBTc
         FCsJSD3VHwgP+n8Z0BeSBmAggUNq8YoETulihbLHY5fFfyveo4ibbPSWntm9exDcWdIH
         GI/3aSRf/uLM1Vg+EZ5nhp1tpe7agpaWDHhClrBac+RETRxdozi4gGyjV3PA5XUVmy4k
         73TH236wN39MmqiWF0klwV9NkpLNL8meWZWhX433DrLj5xJt4ntdM2cJN2ymiTtZvWgm
         NrXvM+UZO48EgVH9Smn8TgB+u8z14BxiSdcU0qtGMcDz/lC/kIDJJADRsGpOHl3eliCc
         0YTA==
X-Gm-Message-State: AFqh2kr5ElfDvtg44gnxKGowT2mwG8lpQt0pidoJ1zuN5YjnJio5jak3
        wY3uwy6xuYXN2RVku6bgHLDti7FmP7hsHOB1fSX7YQ==
X-Google-Smtp-Source: AMrXdXsOqHFXz+NHLN1mDI3hbap1rW1M/dp8dfj+KyrUHnEy5jCY3UGxQDr0r2Dd6pKh0kTJg3RojZh4F0gsgvmQaps=
X-Received: by 2002:a05:6122:d9f:b0:3e1:cd5f:ea24 with SMTP id
 bc31-20020a0561220d9f00b003e1cd5fea24mr4449910vkb.29.1674811805452; Fri, 27
 Jan 2023 01:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20230123082114.4291-1-hdanton@sina.com> <0000000000006b647005f2ece55e@google.com>
 <CACT4Y+bAbSBBYVnBGqZechS_aV=zX6J-B2wdUC_acYYkQur1kw@mail.gmail.com>
In-Reply-To: <CACT4Y+bAbSBBYVnBGqZechS_aV=zX6J-B2wdUC_acYYkQur1kw@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 27 Jan 2023 10:29:54 +0100
Message-ID: <CANp29Y7KUL6NCu9+0+DFMRZ+g8xcaTJdnxqKofELYOCcyNiV7g@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: stack-out-of-bounds Read in xfs_buf_lock
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+0bc698a422b5e4ac988c@syzkaller.appspotmail.com>,
        syzkaller <syzkaller@googlegroups.com>, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 8:18 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > failed to delete instance: googleapi: Error 400: Invalid value for field 'instance': 'ci-upstream-kasan-gce-root-test-job-parallel-test-job-parallel-1'. Must be a match of regex '[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?|[1-9][0-9]{0,19}', invalid
>
> +Aleksandr, was this fixed already?

Yes, it was fixed by
https://github.com/google/syzkaller/commit/9dfcf09cf38eb123a007af28c5ee2562718893a0
