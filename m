Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA6620BC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiKHJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKHJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:09:18 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB2917E09
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:09:14 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3321c2a8d4cso128106117b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/mSgd3/KZGrXlWsE1BO75aHYjWXnPANqXO30jlvy0o=;
        b=H1EigSh4jOLThRSpHnq9dcIPvYq1a+cJg60eKWX0jxMGiEoZ0mo+2o5tl/OIMQUMIR
         rilQK60Pz5yFli/andC57hJq6+PZvFQe5qFkMWEOMDd7ZrvCE8f6Mt4oFlrDbcZItgH9
         XgzcLaEbWSxRmR2pOqH3glvWxtnOC0ClHmtmaoQwylDKc1I3EPLIJGdH9p5RJL6ygn3Z
         8NWD8wGJyjDvU6qqlEcHl1e5E1xBLpadx/eUBbFR+hIAHfKE0bA8DNDQV45riUVRCPig
         xIc5gq/GdP0/7jbVk8yIZ8gGW2LGv5fbv4CiqkHkdaE7bPwxWaPUiId9bpfxbX9vAKzc
         +lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/mSgd3/KZGrXlWsE1BO75aHYjWXnPANqXO30jlvy0o=;
        b=m9E5OZcHoj7xw76ZSkBTbkZQJ8c2uGsSAlpL/1MdI2sMps9bwCUbHB/RnCRFGcoBy1
         +JTdf9Q9ezYhyrUraeGGbBW+m5pOuSbjEzGKuq4hM1IBAkb7a7o7ljXLq6kXKj5t48Ue
         WhW4aLyxUu2OLk6mZPkABQlK+G/+2zSJiULLuj0dWiBpbNgxGu9V2Yasdz+CagMOGACb
         ocBE9vN3nC46RHveyf/j6amRlNeCWxugB9iAaVm9gBE2cgqko68yB8UzeBRXqAri0JjG
         uYXQUJC8c5oKYshtftAd4YxDZBxlemLkaBAfHasvDRfyaxqSvxdhFqLaUQKRMt77WOVa
         YdUQ==
X-Gm-Message-State: ACrzQf09k6qYbqjd6iFK2wnj6oCn607WqXw0WQHmbD8LUZvI1igMGVqq
        eGtu0daLrIPUN9PialQeXsIMErJwi+m/MlZ/TzAkUA==
X-Google-Smtp-Source: AMsMyM4RQNU9stUJYhb4ZQLjB3gwRGc8RPODKXAWT5OzpvKnNsmrRhh9YG160heTdWtV/rSGnxwnNWI6zaktjNvEz7Q=
X-Received: by 2002:a81:4811:0:b0:368:e6a7:6b38 with SMTP id
 v17-20020a814811000000b00368e6a76b38mr51888756ywa.20.1667898553086; Tue, 08
 Nov 2022 01:09:13 -0800 (PST)
MIME-Version: 1.0
References: <00000000000058d01705ecddccb0@google.com> <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
 <Y2lGu/QTIWNpzFI3@sol.localdomain> <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
In-Reply-To: <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 8 Nov 2022 10:08:36 +0100
Message-ID: <CAG_fn=VPvdHxQc3xm5xkqgFq3uo5oTU_w5vyMj-qQD7DvwQ4BA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

> >
> > Anyway, this patch doesn't hurt, I suppose.  Can please you send it out as a
> > formal patch to linux-ext4?  It would be easy for people to miss this patch
> > buried in this thread.  Also, can you please send a patch to linux-f2fs-devel
> > for the same code in fs/f2fs/verity.c?
>
> Will do!

Shall I also initialize fsdata here:

$ git grep 'void \*fsdata;'
fs/affs/file.c:         void *fsdata;
fs/ext4/verity.c:               void *fsdata;
fs/f2fs/verity.c:               void *fsdata;
fs/hfs/extent.c:                void *fsdata;
fs/hfsplus/extents.c:           void *fsdata;
fs/ocfs2/mmap.c:        void *fsdata;

?
