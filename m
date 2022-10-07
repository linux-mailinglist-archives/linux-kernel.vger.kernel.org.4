Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639025F7515
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJGINP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJGINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:13:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893FDEB7EF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:13:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so4028675pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n8VvFVGhEVMZdHi8+5seVzuqaqkjdyrnFvIS6loiHwQ=;
        b=HtkV+NUpGjW7HXSzGJ6oZnrPPTREyGeCYFxDvh7RlDGAcijsSCgwmHoR9SvGnmuab4
         RsXVY5O3pLgan83+qkOJvhAaNmKc9TwmI6qEB5F+EydiYfkpYtJnEUUzb5G4TyildDnm
         dsvdCtBlg7drsXYMJvDzlxYjxh4GvEthtGbcdbws1UG/qVdX9gSufwzp7srZJyBYc8ca
         FYlRxDr5roboKs6JuzY359e2+MgipzjxTOw1OLhQ7NY4lnzxmtQze/7t0G80HJ+ORaUb
         +pW67ITt3KaHOmYgsRfhAJVQTn3JdR3WFf+uaO3FWT1/sIk7UcnjVYjXyf+3XZTn8UmX
         n+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n8VvFVGhEVMZdHi8+5seVzuqaqkjdyrnFvIS6loiHwQ=;
        b=dv4QocelsjXMjDSl7d1QDipkbh7pce+Ymv6Gr0JTJ3c1i8PMdlL3mAkfi+X/fHngMY
         BQUXZvFNq7ALi7tQzEzxaNw8w2otu1waVUWk6RPJSeAmOHgpwD+GZeXD04PyfQMq2rNP
         o73e6ilhKJLY1wM3sHOtlcbC8VCiAY7ugg407t03psaI7II7/3jshG7ML4dU26SbDUxR
         eu1dAHKT7ZQoCuLb5hcaQzLE5qHE3di5RWb9tgT24AepA06i66jGdrQCY8pReVhQeQRl
         Kjof0ShPFPhlQqDNitzsqz0kMjLcuOPtxA+m7RI4KDwVy0tOM6XEHQjFJjpe9L1YjjKp
         kltg==
X-Gm-Message-State: ACrzQf3ybjxA3JjJCVkJljToYOXsjbxxYB8TLlfh8D3Z3xI+kkMql4kN
        brE31fMXq4OAhJTgYnLHb0DDzlZjX0bE10HufkCx/g==
X-Google-Smtp-Source: AMsMyM68Bm1nFSvBPk7n2zafQw6ucnG0uukpNbiIy7kClP9xZYK6Z4ajGqFrItQYiTZlZU9CwF24JXqJDcADBkzlKiU=
X-Received: by 2002:a63:5b48:0:b0:458:1e98:c862 with SMTP id
 l8-20020a635b48000000b004581e98c862mr3472673pgm.568.1665130389005; Fri, 07
 Oct 2022 01:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com> <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
In-Reply-To: <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 7 Oct 2022 10:12:57 +0200
Message-ID: <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        =?UTF-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 8:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Sorry but you need to get your driver mainline in order to support
> > vmalloc interface.
>
> Actually, I think even then we shouldn't support vmalloc - and
> register_shm_helper() just needs to be changed to pass in an array of
> actual page pointers instead.

register_shm_helper() is an internal function, I suppose it's what's
passed to tee_shm_register_user_buf() and especially
tee_shm_register_kernel_buf() in this case.

So the gain is that in the kernel it becomes the caller's
responsibility to provide the array of page pointers and the TEE
subsystem doesn't need to care about what kind of kernel memory it is
any longer. Yes, that should avoid eventual complexities with
vmalloc() etc.

>
> At that point TEE_SHM_USER_MAPPED should also go away, because then
> it's the caller that should just do either the user space page
> pinning, or pass in the kernel page pointer.
>
> JensW, is there some reason that wouldn't work?

We still need to know if it's kernel or user pages in
release_registered_pages().

The struct tee_shm:s acquired with syscalls from user space are
reference counted. As are the kernel tee_shm:s, but I believe we could
separate them to avoid reference counting tee_shm:s used by kernel
clients if needed. I'll need to look closer at this if we're going to
use that approach.

Without reference counting the caller of tee_shm_free() can be certain
that the secure world is done with the memory so we could delegate the
kernel pages part of release_registered_pages() to the caller instead.

Cheers,
Jens

>
>                  Linus
