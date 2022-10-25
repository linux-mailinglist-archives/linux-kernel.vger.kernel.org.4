Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390860CF64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiJYOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJYOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:43:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7515BCA6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:43:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m5-20020a9d73c5000000b0066738ce4f12so681263otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+YUvxMJN1Ia93YxRf3chGSDyOBQQOLEOxAxVDNWPJI=;
        b=V+pBY54SA0twJVfCKJRf/JA1OkN1MaFq9gkfLqyvYnW7qDNqrto67VtKhzr+YLMS7i
         yPys2HMKrUTZbpT6snAjrfErEap3bZFbyceSoI2QlEJAfeui8u9O0bnJe2FTvft8h3Bb
         JknQA+MvTapyUiciIFV6WBCVC4/Y/wRB6t8NJM9VdoHzQ14HMzn/bRKHbH3ft8bs0jgy
         H1oMBGe1eRi1bVHeNMWJr+RvrR+RlhdjE0jd+gbi3E0jEbJQH5m11gNix1JUNT+LjbYZ
         ZAfubpXrzri1sS/XF2CAu2ECK1IoFJIywvdMz+n0+A2pPjen7/zTi5U5SwGdAJXka32z
         krmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+YUvxMJN1Ia93YxRf3chGSDyOBQQOLEOxAxVDNWPJI=;
        b=WuaEWeUbCuIFX2kCbRC1KjbMCdD4iUpqhYmeu5xHAT6jLJln6PUJ5eg3ZUDrIcJJ6/
         Ox/ZY+vwsfXmAoDJfgB0KP8Ktv62drmvsupTDjZITSY89RO3oc1m/tdussZiIN5Aui5T
         cYY1kAEY74P8mUH5E0VdyFZtbW1SzsCyVhUO9zopPp07bSC9JcFhT4CZqipDfjMo+Q3I
         k89/1XawuWyvGKjr7jDicF3KkFP9s5DZ6VKaBBCxzQQEa7rTEdiYturH+BcsbCb0hm+9
         UPij8UDsLCdRHiJQ6sNrzYbP/TTTRnW1rJhKsy/s+g4pF4Q8lTTMgkqlvaEA5zdxok+G
         WE/w==
X-Gm-Message-State: ACrzQf04v8k/TGTli1+soWzE0HafeFjY/CjkyHPe2rQ82EWtMMrv97wL
        lBiuu5dNkMIiDr26HYH8QnJHdh0WxsaD2s2/XBs=
X-Google-Smtp-Source: AMsMyM5u7tzRYeOdHQJXgMqRAfZHJbHWuaRVh+exIuXOH4EAG5/KYXdgNC3w+axhYmpFI62Flo97/gzF6EqBtd469d8=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr19667831otm.233.1666708993198; Tue, 25
 Oct 2022 07:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <af4c71cb-be60-e354-ca4f-23e834aca6e1@suse.de>
 <CAFCwf12HDZvsr1TrRFQH9Vi26S-Xf9ULgxtBazme90Sj5AzhQQ@mail.gmail.com>
 <c22bd93e-8bd2-6865-711a-37aeadbca7f9@nvidia.com> <CAPM=9tyEqzQ09WcRtE1Zd3XjOaR9a2ms-vL-O5x2ong7iPF=4w@mail.gmail.com>
 <Y1fFRIxRq+enLWyd@nvidia.com> <CADnq5_PH3xR_nnN2wQ2NjydUoT+X0z_9OvHtaabwcPbwP-o+9A@mail.gmail.com>
 <Y1fz89kib4zVuqn5@nvidia.com>
In-Reply-To: <Y1fz89kib4zVuqn5@nvidia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Oct 2022 10:43:01 -0400
Message-ID: <CADnq5_OuVWTmgRZsyF50VdJg0AfSS7_3cN2UCWrBDayXcPUkSQ@mail.gmail.com>
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

On Tue, Oct 25, 2022 at 10:34 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 25, 2022 at 10:21:34AM -0400, Alex Deucher wrote:
>
> > E.g., the kfd node provides platform level compute
> > topology information; e.g., the NUMA details for connected GPUs and
> > CPUs, non-GPU compute node information, cache level topologies, etc.
>
> See, this is exactly what I'm talking about. What on earth does any of
> this have to do with DRM?

At least for the GPU information it seems relevant.  What value are
acceleration device cache topologies outside of the subsytsem that
uses them?

>
> We alread have places in the kernel that own and expose these kinds of
> information, drivers need to use them. Not re-invent them.

I don't disagree, but I'm not sure where the best place for these
should be.  Probably a lack of knowledge of where this should actually
live and indifference from the maintainers of those areas since this
use case doesn't match existing ones.

Alex
