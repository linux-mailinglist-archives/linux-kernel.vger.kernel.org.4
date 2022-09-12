Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D905B59C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiILL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiILL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:59:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC1A1BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:59:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f131so12348468ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=K/aKpFogT1WEO7IHcvDcgP69nZzWBbW4PAonGtD0RYs=;
        b=ZwoXycaLbjOzqTujT4LxBvY78NLY2eZSzwymD7l+qar9MEv3Q3JcgEfyssRTHEFCUn
         cGIokAaaTyacO+z7dJuVF53PR0yeV2NkfQlb0dSVKDOt5WRqPo/M5hXZ4CFt7LEKVlS8
         XH1zZ6BlbkDxSrK9tq7MhbO+SJyl00uiscjJ1kHvsiyrNWNBiBkEtQ4OAHmnakPLNUqL
         oS0znJrCC6Y0suHv78j4Mlyh8Ua8aXuMNYGRLz6OtY9wVdKPHr///urSPumyI42gW/Wm
         cq85asdwSDYzaX8ADsKsfiF3KKYJ8/ngwhI4YNwbl+Nn4H4YsKdNN8S2gjXkPw/h7fHf
         TNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=K/aKpFogT1WEO7IHcvDcgP69nZzWBbW4PAonGtD0RYs=;
        b=tCyxK3yiWk78D3DGpyUSwrrsfmr39N96pDxN1UJLniDqpDH/U2eoYegvcpSwpflzJm
         9OwbxywltgZ0kpL5E9J+owlFwIvL8Nd3FtD2ZdLbIQAkrDC7+gt0gu9soEQ+6Zlr4uy3
         k6AAnK3PFSw38MYNuQPc+0ELAQKqXZ0O+cOk83OHeZMaUU0+vkx7wRjWLUgVkBf297x2
         OQwPRhMSu6kM0lGZytib8vSBoPm130JUyRGMcnDH8/dOab7KZXd8w0rZPOojadguCToy
         5+nFXEgkAa/4wTJCxRfbyUtukZk53XEGNbtWc90F4uydarV4Y3fx97wsHjwtAff4yMxi
         vzxA==
X-Gm-Message-State: ACgBeo3loTdbTlOagSZHIVSWk8mxyWhYr/xEc/eYDm5IhvhaYXKVLcWI
        ixMiF7syGGuGy0YUDM0z8kj8opXojC66aWpHBz8k0f0TODw=
X-Google-Smtp-Source: AA6agR6ZfsRlrhONwo+IdzTbb0XMtaVqfg+44mjigcJVtjbjZ2UzXjk8fEsfbwMZpzNNMhxDCEMWmys1gA2588Y5uNE=
X-Received: by 2002:a25:3b46:0:b0:69c:a60e:2e57 with SMTP id
 i67-20020a253b46000000b0069ca60e2e57mr19367649yba.364.1662983981027; Mon, 12
 Sep 2022 04:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
In-Reply-To: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 12 Sep 2022 12:59:05 +0100
Message-ID: <CADVatmPAkS9ope2oOQHB8nKc_sx2MM9P6aSqxwdA5sgyqvCvvQ@mail.gmail.com>
Subject: Re: Linux 6.0-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 11:05 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's Sunday afternoon, time for another -rc release.
>
> Things look fairly normal for the rc5 timeframe, at least in number of
> commits, and in the diffstat.
>
> A bit over half the diff is drivers: GPU, rdma, iommu, networking,
> sound, scsi... A little bit of everything.
>
> The rest is the usual random fixes, with i2c doc updates standing out,
> but also various DT updates, a few filesystem fixes (btrfs and erofs),
> some core networking, and some tooling (perf and selftests).
>
> Nothing looks particularly scary, so jump right in.

clang build failure as reported in [1] is still there. Nathan has
posted a patch series at [2] to fix it, but it has not landed yet.


[1]. https://lore.kernel.org/lkml/YuwRyQYPCb1FD+mr@debian/#t
[2]. https://lore.kernel.org/all/20220830203409.3491379-1-nathan@kernel.org/


-- 
Regards
Sudip
