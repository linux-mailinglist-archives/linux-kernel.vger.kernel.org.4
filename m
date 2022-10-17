Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A71601CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJQW75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJQW7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:59:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF5B8286A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:59:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so12316499pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+mO5dnQ4wEnM3Ay6tjAE6o+DD/J6JLdBc0IhSmPTiE=;
        b=d/w6LDf36K9mIyTgebfyXYxWvOSqeFeO9BIJysnYrODrG1L3s74UR3HH8WiI/k1UHO
         SZBqqXUVBCw10yRKptC5uJAwQ0wSq5FacwiXQAGSLy9Jrf4+CJfE+cpeEt8J8plcJCzT
         RqRUMdYFzrBU6BbE/AJSM0J5OjgsZR4Ud6Qq9NtQP4QkX8b0Qb1JjGIctn/l6GSDt4pW
         Rj28uM4eElzEC9vB1BSvxfkLHk1cIRyr1SDLLxOXbEZua1h9WXmmRZ4A0LAmF0Ji4zfu
         Vq1AxGXZdH/Y3SJ0RRAJE69N/tZCekClJQerSWMkNMAaJHNlR9tXBNDSzTPu27QigUOK
         l9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+mO5dnQ4wEnM3Ay6tjAE6o+DD/J6JLdBc0IhSmPTiE=;
        b=dW6MvsURLW63UWtldD+YVITeRtv5pI42gmq+u7GKLJAqtPl+VsjB1dSOi4LbfVKH9m
         3GF355MnBeX0GE0S+eaNREChI1gZFuY2DECG3YGMSuQKj4xS9KfwSrRPYDJE4mGf3Bp9
         f5klqg0WWnh0x1PXcPhMBFWHFDFEmWi8Hn/eaCK6L+ueDaxdYapS76xbPlSC7TJyx12H
         4NbbMA3Z5h4Cn+aFtEO1Vi4eg1rjLFbsfGm0drkhN6InV1t1ZF9WebyLKG8IUTPfU53e
         bc7EoQmRCtBh1EbYGBBadh+FdzN++YJcoAwBRzp6fWEVmnvNml6FyYzIC+yyBtpvBCth
         Y+Og==
X-Gm-Message-State: ACrzQf17/HJo26I+D24ypdpPljxbX0tfXiJT8K20FPrpUClfN22t+GC+
        1E+tCr7/no6cg6Cx3HKNlcBzVbBLPklhonCCtQk=
X-Google-Smtp-Source: AMsMyM7sC99nMlezAnA0gVBYwCHNCf15HZWPpH8F/FMxQJToAMkJ5LWYAdtzXjW6+ie2ZaCUNgTcH/ttBcfOQqQLXVw=
X-Received: by 2002:a17:90b:4c8c:b0:20b:d3f:3c8a with SMTP id
 my12-20020a17090b4c8c00b0020b0d3f3c8amr87645pjb.219.1666047566911; Mon, 17
 Oct 2022 15:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220916083604.33408-1-nixiaoming@huawei.com> <20220930091406.50869-1-nixiaoming@huawei.com>
 <910e5533-4abc-85f1-6bfc-4d776f8bed7b@huawei.com>
In-Reply-To: <910e5533-4abc-85f1-6bfc-4d776f8bed7b@huawei.com>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Mon, 17 Oct 2022 23:59:14 +0100
Message-ID: <CAB3wodeXGT0dGxZ+AGJvTU1mMHsqNo4--1c+6UVhYmJj4fO14w@mail.gmail.com>
Subject: Re: ping// Re: [PATCH v5 0/2] squashfs: Add the mount parameter "threads="
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        wangle6@huawei.com, yi.zhang@huawei.com, zhongjubin@huawei.com,
        chenjianguo3@huawei.com
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

On Mon, Oct 17, 2022 at 2:11 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>
> ping

I was hoping you'd notice the obvious mistake you made in the patch set,
and send an updated version, which would avoid me having to point out
such mistakes again.

I have replied to patch [1/2]

Phillip

>
> On 2022/9/30 17:14, Xiaoming Ni wrote:
> > Currently, Squashfs supports multiple decompressor parallel modes. However, this
> > mode can be configured only during kernel building and does not support flexible
> > selection during runtime.
> >
> > In the current patch set, the mount parameter "threads=" is added to allow users
> > to select the parallel decompressor mode and configure the number of decompressors
> > when mounting a file system.
> >
> > "threads=<single|multi|percpu|1|2|3|...>"
> > The upper limit is num_online_cpus() * 2.
> >
> > v5: fix a low-level mistake in patching:
> >    fs/squashfs/super.c:492:7: warning: "CONFIG_SQUASHFS_DECOMP_MULTI" is
> >    not defined, evaluates to 0 [-Wundef]
> >
> > v4: https://lore.kernel.org/lkml/20220916083604.33408-1-nixiaoming@huawei.com/
> >   Based on Philip Lougher's suggestion, make the following updates:
> >   1. Use static modifiers to avoid changing symbol names.
> >   2. Fixed some formatting issues
> >
> > v3: https://lore.kernel.org/lkml/20220902094855.22666-1-nixiaoming@huawei.com/
> >    Based on Philip Lougher's suggestion, make the following updates:
> >    1. The default configuration is the same as that before the patch installation.
> >    2. Compile the three decompression modes when the new configuration is enabled.
> >    3. "threads=1" supports only the SQUASHFS_DECOMP_SINGLE mode.
> >
> > v2: https://lore.kernel.org/lkml/20220816010052.15764-1-nixiaoming@huawei.com/
> >    fix warning: sparse: incorrect type in initializer (different address spaces)
> >    Reported-by: kernel test robot <lkp@intel.com>
> >
> > v1: https://lore.kernel.org/lkml/20220815031100.75243-1-nixiaoming@huawei.com/
> >
> > Xiaoming Ni (2):
> >    squashfs: add the mount parameter theads=<single|multi|percpu>
> >    squashfs: Allows users to configure the number of  decompression
> >      threads
> >
> >   fs/squashfs/Kconfig                     | 51 ++++++++++++++++--
> >   fs/squashfs/block.c                     |  2 +-
> >   fs/squashfs/decompressor.c              |  2 +-
> >   fs/squashfs/decompressor_multi.c        | 20 ++++---
> >   fs/squashfs/decompressor_multi_percpu.c | 23 +++++---
> >   fs/squashfs/decompressor_single.c       | 15 ++++--
> >   fs/squashfs/squashfs.h                  | 23 ++++++--
> >   fs/squashfs/squashfs_fs_sb.h            |  4 +-
> >   fs/squashfs/super.c                     | 93 +++++++++++++++++++++++++++++++--
> >   9 files changed, 199 insertions(+), 34 deletions(-)
> >
>
