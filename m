Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B660C1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJYC1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJYC1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:27:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6ABE3195
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:27:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so6800799qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EkA2ih1Lb3SoEIyMSEvVLzMyUM1IC/WaQbhghuPoTvk=;
        b=XMDoeeGiL9DmdTnU7eNgbF2kh1c8iYpq+zg0S4+qhzONTizOlgspiOkAa+AHuzbLuJ
         aXkIIN1ies7UU8t2k02H40Q4JOsuRWdACQ89dbhZqU9AErpRW7tp9ZJOw/xeTu2BtZPG
         cwPrmZ5X1p7uLPdoB1OcD8Jw4gHFfFhsVDx1bKMENBTAzaL5XBM6b9Fj9UGKrW9lVV+6
         wGbyWJS7IllkGMp9CutQYsog1ZTyeN4PRPwoTxgqtRTEBqcmbMWHxCoq8VlHY7suWBlZ
         xXGvIs591p8bCx4TaTIgBs2KAULx60HbxJUw1aEqB6p5fe42XWewcBGZbVYI0R9aLnDp
         w2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkA2ih1Lb3SoEIyMSEvVLzMyUM1IC/WaQbhghuPoTvk=;
        b=C1ItQaqTHPWQWmorp+/6hAdRAfxarGOBcLIYfkYH34ryQNOQWx7VMB2WaB9LYmjj0L
         BUc9hpWgOZh9OVp0xm9kC5SYAfx7EnsHmJ9eaccbvExAc8YkHzHIaZvL8Tjlysn/PYlx
         //JebZBsLhBycAOIDtq+CW8/AbF6OaVLzrWT+e68R6St1pn/kB7rBO5Hic14VdIelaWa
         k8EElkgRLDcwGfQsReTh529DQ4wZHL2o11yjAA5uMyOz23eZi6y7uVOaNAjHq2EyZdGm
         6ZpEs40T1f95dU+i9jVfNlIBfer89CP03ZXwsXnBt5aEBPoffxMA6fHVarnwwjaMkf40
         oWrw==
X-Gm-Message-State: ACrzQf2qXQW3CfqEfUepK3xNROoENeEwW9/em1WM220WJxFqMimOhHcq
        uPhovxJ8FUVb9XVVmMICQk8zHPOUJmWFY3pUs28=
X-Google-Smtp-Source: AMsMyM6HmWY1ZAbgdXfhz4bHb9AW/kHuW+hgrCBEiRVSWkR2JEBSu04VwkuCQMLdOT5LIGdw39CGf7Q/1zhSI8ng/qs=
X-Received: by 2002:ac8:5705:0:b0:39c:fe03:5ee2 with SMTP id
 5-20020ac85705000000b0039cfe035ee2mr25348883qtw.344.1666664843924; Mon, 24
 Oct 2022 19:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <af4c71cb-be60-e354-ca4f-23e834aca6e1@suse.de>
 <CAFCwf12HDZvsr1TrRFQH9Vi26S-Xf9ULgxtBazme90Sj5AzhQQ@mail.gmail.com> <c22bd93e-8bd2-6865-711a-37aeadbca7f9@nvidia.com>
In-Reply-To: <c22bd93e-8bd2-6865-711a-37aeadbca7f9@nvidia.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 25 Oct 2022 12:27:11 +1000
Message-ID: <CAPM=9tyEqzQ09WcRtE1Zd3XjOaR9a2ms-vL-O5x2ong7iPF=4w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
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

On Tue, 25 Oct 2022 at 12:21, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 10/24/22 05:43, Oded Gabbay wrote:
>
> Hi Oded,
>
> The patches make sense to me. I'm still just reading through and looking
> for minor issues, but at a high level it seems to match what the LPC
> discussions pointed to.
>
> >> What's your opinion on the long-term prospect of DRM vs accel? I assume
> >> that over time, DRM helpers will move into accel and some DRM drivers
> >> will start depending on accel?
> > I don't think that is what I had in mind.
> > What I had in mind is that accel helpers are only relevant for accel
> > drivers, and any code that might also be relevant for DRM drivers will
> > be placed in DRM core code. e.g. GEM enhancements, RAS netlink
>
> Yes. That is how I understood it ("it" being both the LPC discussions,
> and this patchset) as well:
>
>      * accel-only code goes in drivers/accel, thus allowing for
>        smaller, simpler drivers (as compared to full drm) for that case.
>
>      * graphics and display code still goes in drivers/gpu/drm, because
>        it is much too hard to rename or move that directory.
>
>      * code common to both also goes in drivers/gpu/drm.
>
> Looking ahead a bit more:
>
> For full-featured GPUs that do both Graphics and Compute, I expect
> that a *lot* of the code will end up in drivers/gpu/drm. Because so
> much of setting up for Compute is also really just setting up for
> Graphics--that's how it evolved, after all!
>
> And as things are structured now, it looks like those full featured
> GPU stacks will also need an aux bus (which I only just now learned
> about, but it looks quite helpful here). And also, user space will
> need to open both /dev/dri/* and /dev/accel/* nodes, if it needs
> access to anything live objects that drivers/accel owns.
>

I actually don't know if we really need to worry about compute nodes
for fully featured devices.

The userspace for those is normally bespoke like ROCm, which uses
amdkfd, and amdkfd doesn't operate like most device files from what I
know, so I'm not sure we'd want it to operate as an accel device.
Or the userspace is OpenCL like where we have stacks that already bind
using the drm interfaces so again not sure if there's any value there.

For anything which already has a userspace and stuff I don't think
this adds any value, for nvidia type cards I doubt there is much use
in using an accel node for the GPU related things at all.

Dave.
