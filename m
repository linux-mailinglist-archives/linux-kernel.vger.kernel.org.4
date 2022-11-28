Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7347763AB87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiK1OrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiK1Oq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:46:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85024BCD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:45:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3305981pje.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwypJt2pbpSnqaKUhdNDX85hjjGPSY5lq4no+chAH5o=;
        b=qul9P9dsfRtS9FnYBq7V5iw0GxgW7CKYp54Fy3P1Vk5Nd2VET1yvFKB0J+Ar/sj//c
         CD2Q2M/ILzO0aHzSLAVgJLkX3h1mPjjXLKT1CIVMKN93jPC17JZFH0Kbr05F4zGEsvCP
         /mEAkd/g13Zc2Q0+cowFCVQ7ZNVXt8bOoCzrj5fY4QMwUBRwCTuHuMMDrCidjpbhe2YY
         5Yj62W2dcuZ6qd4h2EutIP8ajhZQsjHulo1pwwZpdgzaQM/U0gDVkWfPOvXiMbx1gnnC
         x9LqCYKW60nKernwO701tWvnQvUH+3jwIrvqAkKsxkSkpRtvCBk/GG6VSNGoOOatYZ31
         QKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwypJt2pbpSnqaKUhdNDX85hjjGPSY5lq4no+chAH5o=;
        b=5AxGHaHS7O+rOnWuYqMqqXAf1jm98ywUFDaT4RRn8w1Kpf65kgIOiFh6VgHpIGUfbl
         Rw2oksy6XBlLIRElvMqArpMuxdh2ja/NTWoNQVRnf8p0GkmOx/tYTkHRv5hWOuoYJZyd
         uFWJg0D4Ak8PlPOdpVi/extbORRCEddyqpUywGGKWQkCBqbxcAgAW4pdfXssV8c2Q8bR
         apD0Mj5DU9yGkHAnHBXp3B8Ck+j0fXnTQAHizkqyEQ4stjqs0txjUN4DtF8ia0s+9zpx
         ZpxzHJ+RJ8FB+u0NJ5KB989KxyMtG7pHkdOytHH8EiPujc0t8+dXY3r1sT4HAoiRNRNa
         WmXQ==
X-Gm-Message-State: ANoB5pmi7XCAWVWDoks3ydN3xg1HDt94pMZDF0xzHwN0Fs+0pnwbNAHX
        LT/jez1erPxOloBzvVC08S2gHjQ78Sb34qUB1pTFLA==
X-Google-Smtp-Source: AA0mqf756alfu+nTXdTTkBPWyoMGiQ9mwf5aNy25bxEi+CfvaZPb5QO4hJK021Dwz3VP0X0XqTeqGY8WeSl/7cX8eDM=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr53464933pjq.202.1669646758244; Mon, 28
 Nov 2022 06:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20221126012558.34374-1-jiasheng@iscas.ac.cn> <Y4HH5Ch1ABrRzN5/@kadam>
In-Reply-To: <Y4HH5Ch1ABrRzN5/@kadam>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Nov 2022 15:45:21 +0100
Message-ID: <CAPDyKFq+wYbRNtDmhMzU+5_LUXsqyw7O=-1BqhJN_j26HF++AQ@mail.gmail.com>
Subject: Re: [PATCH v2] memstick/ms_block: Add check for alloc_ordered_workqueue
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, maximlevitsky@gmail.com,
        oakad@yahoo.com, christophe.jaillet@wanadoo.fr, axboe@kernel.dk,
        hare@suse.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 at 09:01, Dan Carpenter <error27@gmail.com> wrote:
>
> On Sat, Nov 26, 2022 at 09:25:58AM +0800, Jiasheng Jiang wrote:
> > As the alloc_ordered_workqueue may return NULL pointer,
> > it should be better to add check for the return
> > value.
> > Moreover, the msb->io_queue should be freed if error occurs later.
> >
> > Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> > Changelog:
> >
> > v1 -> v2:
> >
> > 1. Assign error number to rc if alloc_ordered_workqueue fails.
> > 2. Free msb->io_queue if error occurs later.
> > ---
>
> My other question about this driver, not really directed to you but to
> anyone on the list is where the final destroy_workqueue(msb->io_queue)
> is when we unload the driver.

Good point, it's simply missing somewhere in the path of the
->remove() callback.

Kind regards
Uffe
