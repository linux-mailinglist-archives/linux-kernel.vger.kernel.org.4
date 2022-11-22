Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCE6334CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKVFqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKVFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:46:40 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6902250C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:46:38 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id cz18so3164769qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjiZg3BkKRa+5nrgX4c6pM7EemDt9g+l9eFKcUuBwg0=;
        b=LGqR8sYOlJCM7sRrnNFAfrnydhj12NbWtVQsTHjVpM+NG8nU/c+AyEea9A0AH/GN8G
         egm8+O5nltbpOQsSiAwk+bgqQg1m4tGzDJW1sKx2xz4pbY0owbTW+2+5iC0kh36cG3gD
         8/dMVb8Vi/ul16v707s8H9Zet8YJOe+T2S6/0l9hVzzC7OAQFi0uowu/srq2MvqgLxW7
         nv/Pr0jpYreeB5k1PbLe061bc3+dx2NO6DcMdO9uCk5Q/D6LlzpiKR+XKxqq4lfm7Ed+
         XnTAwP0PMbj2VyUR7sgBUd2PoEGqCXs5PxBW7XiphSLH2H93UFPlG4Hb9AF2QkcZybyz
         ErLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjiZg3BkKRa+5nrgX4c6pM7EemDt9g+l9eFKcUuBwg0=;
        b=2ZCwMc1FZSp/H1Tqkf6dwmftcwYBVUAqAU7Bs3fLot9YfXZ49xE3xb6vCWNVKBvMtk
         Qlo8N0gVHS5yZwj9QIoodtvGTFuUQQ7gqP8DVLhQa2wIIvUqciH3yQiGtx/0VBOoUA2v
         uu5qZFH+L6yZx0EzCPqkNG0GilT67/0QNKOHUfuw1LxXzPvMsQNx+7SUr5tIAlIa61Gl
         3DyEAgRN1lqYtVykjG/OupDoi4TyxD2cTif8bw9D3mcLfYNxYc3+5jaBEpl8edCHgmQq
         QfKsLBoToKHza4z6WcH+/Bv9MqfpbjM9nfKUGh4YLv5jZ2dIg/pOcQLYe5BJSph1rVXK
         8l9w==
X-Gm-Message-State: ANoB5pkiPK9fghdgXEMQlQwOpnn7clXftf9VUpDMldyUu2dZ2A/Qb2+a
        X6p6qt/JqXBxziLeVhXQbZRng74iYwh1j+hiPjE=
X-Google-Smtp-Source: AA0mqf5IMb6LpswSHC0kaNKDc8KRo0Lq8j0cuqoJ8fiLuaKlNKXC3eaHdq7e8Jir7bvwXYtpNlHqOL6DPGm5skhaPpw=
X-Received: by 2002:a05:6214:3712:b0:4bb:9358:2a1e with SMTP id
 np18-20020a056214371200b004bb93582a1emr4535379qvb.97.1669095997497; Mon, 21
 Nov 2022 21:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org> <02c514c0-62c4-1cdf-5d3f-b3d8942ef005@amd.com>
In-Reply-To: <02c514c0-62c4-1cdf-5d3f-b3d8942ef005@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 22 Nov 2022 15:46:25 +1000
Message-ID: <CAPM=9ty_YHrM5QhAjgFvNdpkEwnB_WHsouhYG8m5XGrb+kmWAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
To:     Sonal Santan <sonal.santan@amd.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiho Chu <jiho.chu@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Friedt <chrisfriedt@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>
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

On Tue, 22 Nov 2022 at 09:06, Sonal Santan <sonal.santan@amd.com> wrote:
>
> On 11/19/22 12:44, Oded Gabbay wrote:
> > This is the fourth (and hopefully last) version of the patch-set to add the
> > new subsystem for compute accelerators. I removed the RFC headline as
> > I believe it is now ready for merging.
> >
> > Compare to v3, this patch-set contains one additional patch that adds
> > documentation regarding the accel subsystem. I hope it's good enough for
> > this stage. In addition, there were few very minor fixes according to
> > comments received on v3.
> >
> > The patches are in the following repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
> >
> > As in v3, The HEAD of that branch is a commit adding a dummy driver that
> > registers an accel device using the new framework. This can be served
> > as a simple reference.
> >
> > v1 cover letter:
> > https://lkml.org/lkml/2022/10/22/544
> >
> > v2 cover letter:
> > https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
> >
> > v3 cover letter:
> > https://lore.kernel.org/lkml/20221106210225.2065371-1-ogabbay@kernel.org/T/
>
> Thanks for defining the new accel subsystem. We are currently working on
> DRM based drivers for unannounced acceleration devices. I am fine with
> these changes with the assumption that the choice of using classic DRM
> or accel is left up to the individual driver.

I don't think that decision should be up to any individual driver
author. It will have to be consensus with me/Daniel/Oded and the
driver authors.

Dave.
