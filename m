Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ABB65344E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLUQqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLUQq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:46:29 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497624F29;
        Wed, 21 Dec 2022 08:46:27 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id i20so14063226qtw.9;
        Wed, 21 Dec 2022 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvON8TqnojOQVl9NlsJCtNwn4S7xBAtXgHeXxuDAxy4=;
        b=og7LZpjbhLE3HZ7Fjfx2/cAdGFxSN+j734UTBSSSVHDAPto+GfGPUAw+Yq5v5700WB
         26W3UQJz4h9cx0Ud8GczGRr8jEXYP4fvvTEkyXTh1LiM3eVSJgiB3jKzD3F+9+rhTTz3
         VGg6AeobQeY4hIXBN2RaEGRYs0CBm+5LCrgvkTliIwsTrKF1uVNrUeELyMFT2CijTJQ9
         5gaFziZ8QKyROMYoQsUBBaJuJY4O/cb8m6UnEyQbi185N2J9pqef1xSNMcVb2GCPeL0r
         ESeN6hQZVimAgSKY38LQ9KjqrWVrB/Udyv+WdtMn/L4g0qMGqJ1Dxajh4iccnhbXQ8rD
         +0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvON8TqnojOQVl9NlsJCtNwn4S7xBAtXgHeXxuDAxy4=;
        b=wXDI18CAzc/9aWyDppVtMgdedlwZ8s/FgZIWmIxq5QCv7B3b61O50b3EryMDpAqF1V
         WX3XacnSnZ43XgCQXJt/Gr2UT4ywMBHxnym5aYnttPIWvLqu9GEq/HglFfA1jR1ZScDN
         trzAEFqBzaBMTKVzUE3l2f6noLUSbXHeARHu/hRJtf+ZEaoLOIQMrZE1iC9auxLtePN3
         eVb0p4rPPfgEfSN1gXAItcSmHt7ECcwuYH6yiLsEZoxlKeSBogt8OCA2FBNz0Ag/gv8A
         c9hnCNgOaiikqeoZLLR1LUd/+dzLJrFz4Xutlf20TVvqVGB/Ts7a6MpAy4tkMhkoBXDw
         6ivg==
X-Gm-Message-State: AFqh2kryclOiN45QOKUqskJzCe7LdxjZ+Cv9D0SyzBoN2iOAx3pefc5d
        0kx10i7fkMm5HrBjvByAsJJeGHpN3hnYrR79Aiw=
X-Google-Smtp-Source: AMrXdXuL1KmHYzwV//G7UY1NWB+tY4sqUYbIdHvbrIl5p5ywupEWdAqif9YKcsZrZnQnzEZYdVP0xUaa4CQsD/CoW+0=
X-Received: by 2002:ac8:450f:0:b0:3a7:b44d:bd56 with SMTP id
 q15-20020ac8450f000000b003a7b44dbd56mr102676qtn.464.1671641186142; Wed, 21
 Dec 2022 08:46:26 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre+XJS_s5FgVteYA@mail.gmail.com>
 <678adc67-9e46-3eef-f274-c951b121570f@nbd.name> <CABXGCsMUbs+bf=tWnx98r4v_JzVmYdVyOos9EhcGJ6jnEwathA@mail.gmail.com>
 <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
In-Reply-To: <a30d8580-936a-79e4-c1c7-70f3d3b8da35@nbd.name>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 21 Dec 2022 21:46:15 +0500
Message-ID: <CABXGCsNJKy2SQffeU+uaua5SM_77YiGKdPLRdzSF3F+ShpF+5w@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Felix Fietkau <nbd@nbd.name>
Cc:     lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Wed, Dec 21, 2022 at 7:12 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> Thanks! I guess I focused on the wrong part of your kernel log
> initially. After more code review, I found that there is in fact a DMA
> related bug in the commit that your bisection pointed to, which happened
> to uncover and trigger the deadlock fixed by my other patch.
>
> So here's my fix for the DMA issue:
> ---
[cutted]
>                 qbuf.skip_unmap = false;
> -               if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> +               if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {
>                         dma_unmap_single(dev->dma_dev, addr, len,
>                                          DMA_FROM_DEVICE);
>                         skb_free_frag(buf);
>

Sorry for stupid question.

Do you have a separate branch?
I see that the code is differ between master branch and the patch.

For example in patch the line:
- if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
replaced by the line:
+ if (mt76_dma_add_rx_buf(dev, q, &qbuf, buf) < 0) {

But in master branch
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/mediatek/mt76/dma.c?id=b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf#n604
after line:
qbuf.skip_unmap = false;
followed the line:
mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
without if condition.

So I'm stuck applying the patch :(

-- 
Best Regards,
Mike Gavrilov.
