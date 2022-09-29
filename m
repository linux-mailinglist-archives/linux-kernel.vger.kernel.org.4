Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D985EEE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiI2GvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiI2GvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:51:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F15861111
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:51:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 29so667484edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kz+Hz89yA+A9oD9zEfvonQT4s+M88L6q5qK2Vlp3lgE=;
        b=jPxlW2Gpq61LZNNd9XbbMxTif/2kP/CNqmt+e+8NGztRZwXJTJxhfX69UTbSWAjzjn
         1j3t9YkS5Hjcd7JjuJfXOMTJHZVeEO4ArMzNK9cfdCJBBWREzxSQ+BnDr5+FkJZHQ9/z
         IiOl86coXlXkGaE1WO96tnv90zLSBiTQQtTItJFnfS3keBSvNCJc8BnuL2x1VkvukzWQ
         XSJDvEEushcnWpF3yt9Z+z0kLD+xMXjUOrZfF3gL1XYsbwjx3YBCTv0jxOjaX7y8WWg3
         zYvjaPSGUIQBaBIBANHP/gOCKJAPNooKlzxWCStk1JdWgrJD5SsmT/LDhDpAf2zP0Mm2
         gbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kz+Hz89yA+A9oD9zEfvonQT4s+M88L6q5qK2Vlp3lgE=;
        b=dG+PxHduwVoDv3XufFsFHZQqcbuqM9BpwqM/Aq9B7t5CaCOzhiNGx1apUajqx8HAJa
         6fzYtKCrzHUt4Id5F448EuJ3u6FuncMBRnqSLa9j/KOl3QwrCgVqVtu2Ry8bZRqc70Tz
         Lb5xZxi/dwYNOw4hr4X6Zn2uZyjXytm84MVQAVcm1EQinevO7w01RqTh0YPDSbgCvjZX
         YfVJd7ngP1NQxlNTajI40ujfv9dJ009eFRb1ejv+SBrQ+QsTkZzwYcQSgjz/OvHrXpyV
         xPPiX8J6zq3955rjDXFblzejgx+KofZ+9KJRTQvzI91XOmHymIIvFGARBJBcuBS7cgbn
         Ik3g==
X-Gm-Message-State: ACrzQf0d68a4AI/RfvJc3RH2vkdCdJ65DBY9KsH5DZwAztlDKot7wc+3
        w2lAZahb8WsfION6JUglVePi3hh9/FCS4shY1CojXibUs5WqCyCL
X-Google-Smtp-Source: AMsMyM7pAOByQ+JlAqWeadB7wDkmtiAkOJq9mbdDha5uTS8eKtGbIIWaoNoqMpecvObUgF7XAi0+59p3qe/tHleL0l4=
X-Received: by 2002:a05:6402:380a:b0:451:ae08:7a6c with SMTP id
 es10-20020a056402380a00b00451ae087a6cmr1714322edb.161.1664434258601; Wed, 28
 Sep 2022 23:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12P6DckVUJL7V_Z7ASj+8A3yyx9eX5MpZPF47Rzg6CjEA@mail.gmail.com>
 <7hh71uixd9.fsf@baylibre.com> <CAFCwf12mjshsf+GC-Y9irvPFT=W4Uis10OnZ4PNN1txjXyzLSA@mail.gmail.com>
 <YzFfzWJYsuhpUiPG@infradead.org>
In-Reply-To: <YzFfzWJYsuhpUiPG@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 29 Sep 2022 09:50:31 +0300
Message-ID: <CAFCwf11L2krr6Tzj6G+NO1Dsfp3drQ-+N4f+7xo6Ez-sVPgg8w@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Mon, Sep 26, 2022 at 11:16 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Btw, there is another interesting thing around on the block:
>
> NVMe Computational Storage devices.  Don't be fooled by the name, much
> of it is not about neither computation not storage, but it allows to
> use the existing NVMe queuing model model to allow access to arbitrary
> accelerators, including a way to expose access to on-device memory.
>
> The probably most current version is here:
>
> https://www.snia.org/educational-library/nvme-computational-storage-update-standard-2022
Thanks for the link. Indeed, there were some people in the BOF that
mentioned computational storage as something that is relevant.
I'll watch the presentation to understand the direction it is going
and how it maps to what we were planning to do.

>
> The first version will be rather limited and miss some important
> functionality like directly accessing host DRAM or CXL integration,
> but much of that is planned.  The initial version also probably won't
> be able to be supported by Linux at all, but we need to think hard about
> how to support it.
>
> It woud also be really elpful to get more people with accelerator
> experience into the NVMe working group.
I will be happy to help and contribute.

Oded
