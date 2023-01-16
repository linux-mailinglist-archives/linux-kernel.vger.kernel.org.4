Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680D66CE72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjAPSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjAPSLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:11:23 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90150222D4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:55:59 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-142b72a728fso29562141fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmr/4EGVT6Movw4Gw2eBDFQeNgD1pGHhChAaxlPCJsU=;
        b=SfTnM2vVsOQnrYLrQD9H+RG2EW9ZSkr0xjOPTijmu0aGqrobYsidOwmjAWl+UKjvYp
         u5Qel07zihwL3o7ogRlLfYtYLm9CQ39KoEN54v5dBoL9AcWzj/NKt2rJSx82+K1fXdUH
         kwq1u0PKUTd0iqtVB2XV+N3JgSQlwsfdxrne2dtY+DNLtRwzb4CCs/HMic+3OY7NxxAp
         61E3JU+1SewSBPbs89B2q3R/A1wm9TQDV1VohQ+ygim0h4CXkBW8taXnDh4ySXm5H3c5
         r1b1gN1WO0kd2rh25bsyQl3A4QGXc2FyOEBSZVNq9MTM8OJuvt0KOilwPvvOzD1dmL5I
         W9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmr/4EGVT6Movw4Gw2eBDFQeNgD1pGHhChAaxlPCJsU=;
        b=Cfwk/yE+B62jpmZ7ckM4zty7ybKuBQdXch8CbTUTIZMYO/koJYcWdWWYvCRO4wxL0A
         LHhsa8874ZHsTdEMn4bAJi2g7acOAzpNKUL9sur/c8VpO+qrgcn5/R3Da/42AVD8jZev
         ZXCgbassaFtaAcYhx0Oon2eKs0YYLQ9U0aX/oAqsXlJxRCQ5z76XkPzWB6C/4evXrNQO
         0pY6rmCgSAzHw0kDVdsdzGrpbN80xolFnimftGziIAxErOLwuAP1lE0Qzk5RkAX3unxc
         0UOl35ZH8INQUHM8f4B9nPgEE56kB3b5w3Wm1KOYsiHu8HcgeS2z7/0BM+0wteQ/gcIP
         GfQA==
X-Gm-Message-State: AFqh2kogjWK4MsF2IJT4qv/YK1rgQReTZV8Bi0SN8ZbERWzDRhZG7cAU
        W3bqGFQ+y+CBsmgw3bH8AZWYYerxt2lIfkSZFnQ=
X-Google-Smtp-Source: AMrXdXtsyr3fZssneo+m+TaFDxl8UcCwFPa0HZ9ecIR2snIjS8XHBcWS8ZqbYDjLLr2NyLRnUaMRQxi7OAUj8r8E+KM=
X-Received: by 2002:a05:6870:7a18:b0:15f:5509:9a0d with SMTP id
 hf24-20020a0568707a1800b0015f55099a0dmr52425oab.46.1673891758551; Mon, 16 Jan
 2023 09:55:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673766696.git.drv@mailo.com> <DM6PR12MB2619EF8DBE956A8F79A579DCE4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EF8DBE956A8F79A579DCE4C19@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Jan 2023 12:55:47 -0500
Message-ID: <CADnq5_NuNYcgK1K-5J-cU7ZSNuMrkEMuO_ZkcNzWsESSKH-SaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/pm/powerplay: use bitwise or for bitmasks addition
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Deepak R Varma <drv@mailo.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

Applied.  Thanks!

Alex

On Sun, Jan 15, 2023 at 9:27 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Series is reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Deepak R Varma <drv@mailo.com>
> > Sent: Sunday, January 15, 2023 3:16 PM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; amd-
> > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; Praveen Kumar
> > <kumarpraveen@linux.microsoft.com>
> > Subject: [PATCH 0/3] drm/amd/pm/powerplay: use bitwise or for bitmasks
> > addition
> >
> > The patch series proposes usage of bitwise or "|" operator for addition of
> > bitmasks instead of using numerial additions. The former is quicker and
> > cleaner.
> >
> > The proposed change is compile tested.
> >
> > Deepak R Varma (3):
> >   drm/amd/pm/powerplay/smumgr: use bitwise or for addition
> >   drm/amd/pm/powerplay/hwmgr: use bitwise or for bitmasks addition
> >   drm/amd/pm/powerplay/smumgr/ci: use bitwise or for bitmasks addition
> >
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c      | 8 ++++---
> > -
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 +-
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
> >  drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c   | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
