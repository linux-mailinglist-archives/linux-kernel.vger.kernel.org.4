Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634260CED4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiJYOVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiJYOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:21:49 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313BE43E6A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:21:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so7785451otb.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9p8b3r4r5R88ziLyc8TQ9IiZL1OeYDsYpURNkbKqfCk=;
        b=BwEjBo8P6bns8/5Dw+Ak9i3INaSL07KKFzCbBHV0ZDUpuIYq9lxoAdu8fMawt4JwML
         CAxyLuzSoTsoix10JAiVA9GgCWjNmaS/RXMLqHuvC4zmtCTsN0z3QnN9i7T8kEQeP6dL
         3qSsTmRB3cR+iALMV7dB+5tv3Y5lAFaO3xA24cijN/uHkUo3v4jKaWZmZOnmyP3ubWk/
         Co7EL2PG3bdzsy+rdBGHzrIpK2QXXplE6PlXRCnEQSS050GNQtJS0cwTE7ausKfzheAi
         OjLwOODPw5cJiv10pIUypDx5Dzxy+PElu2H4X/bsP6h3wyyx6t6ddZ94/MPDMJKoMdUk
         HwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p8b3r4r5R88ziLyc8TQ9IiZL1OeYDsYpURNkbKqfCk=;
        b=0VzQF2ts5mUvO5EFERmveanQXGskBv25evQr6hYWDvMZmj2wUsJr30Htv87ObgaIwL
         PRC9miOZ3cUgQfFPvsyuHsXuhRvT2P7Iz4sOtXJJ0AyBamoHbiTIMZHKYNV+kM0fJFV2
         eJ7k6eh6vunEjANocP6WcCmtLHpteVwnsiOem5hbDvaMaYselwW4NmCLwT2NeFn/wz8m
         pvXhlIvDfYFiacbiaiDkPIcldV1cuC1DN9FyBm2zyPfzvxTPprhLnkBxI3asz5n34tXN
         NA64QOlP+dYTsb9ypCOSF4uQL8OzpB1XsU+iaCHOJ1+Lkin0UbBs5++5McWCI7YbeGfQ
         hmIg==
X-Gm-Message-State: ACrzQf3uPB6CmZmL5eb+GHZEhje4bqG5pmuGN6UDTARYdjzGfcqpmG+5
        gp5Jlz9+UMj9FzvfVMI1g6inp95u1r9sLX6Nxhg=
X-Google-Smtp-Source: AMsMyM7jdjnwHDf5ZBmC25i4R/uXpYqOYOgLhjD6TCWs0aGXZMwu717KJG+mkQn9pzR3X7Kdp4yw7YBWXiIix2Uh1ZM=
X-Received: by 2002:a05:6830:2475:b0:661:b91c:f32a with SMTP id
 x53-20020a056830247500b00661b91cf32amr19355124otr.123.1666707706758; Tue, 25
 Oct 2022 07:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <af4c71cb-be60-e354-ca4f-23e834aca6e1@suse.de>
 <CAFCwf12HDZvsr1TrRFQH9Vi26S-Xf9ULgxtBazme90Sj5AzhQQ@mail.gmail.com>
 <c22bd93e-8bd2-6865-711a-37aeadbca7f9@nvidia.com> <CAPM=9tyEqzQ09WcRtE1Zd3XjOaR9a2ms-vL-O5x2ong7iPF=4w@mail.gmail.com>
 <Y1fFRIxRq+enLWyd@nvidia.com>
In-Reply-To: <Y1fFRIxRq+enLWyd@nvidia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Oct 2022 10:21:34 -0400
Message-ID: <CADnq5_PH3xR_nnN2wQ2NjydUoT+X0z_9OvHtaabwcPbwP-o+9A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jiho Chu <jiho.chu@samsung.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Kevin Hilman <khilman@baylibre.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jagan Teki <jagan@amarulasolutions.com>
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

On Tue, Oct 25, 2022 at 7:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 25, 2022 at 12:27:11PM +1000, Dave Airlie wrote:
>
> > The userspace for those is normally bespoke like ROCm, which uses
> > amdkfd, and amdkfd doesn't operate like most device files from what I
> > know, so I'm not sure we'd want it to operate as an accel device.
>
> I intensely dislike this direction that drivers will create their own
> char devs buried inside their device driver with no support or
> supervision.
>
> We've been here before with RDMA and it is just a complete mess.
>
> Whatever special non-drm stuff amdkfd need to do should be supported
> through the new subsystem, in a proper maintainable way.

We plan to eventually move ROCm over the drm interfaces once we get
user mode queues working on non-compute queues which is already in
progress.  ROCm already uses the existing drm nodes and libdrm for a
number of things today (buffer sharing, media and compute command
submission in certain cases, etc.).  I don't see much value in the
accel nodes for AMD products at this time.  Even when we transition,
there are still a bunch of things that we'd need to think about, so
the current kfd node may stick around until we figure out a plan for
those areas.  E.g., the kfd node provides platform level compute
topology information; e.g., the NUMA details for connected GPUs and
CPUs, non-GPU compute node information, cache level topologies, etc.

Alex

>
> Jason
