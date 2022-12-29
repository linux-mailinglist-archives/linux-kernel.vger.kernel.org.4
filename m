Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2539658CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiL2M2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiL2M16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:27:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91D263D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CDDB6178A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FFEC433F2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672316876;
        bh=kMyVX3hg9ufAE640eUtlK+duN/DOwEbGq6CsAH0RFpg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GI2zZo+vDQhG/4GZj20RE1NAvTP2RmC4PcROi5lNyZwDULNM3zm7m29XeFRegG3iq
         DKr3o0pPX+0S7goAG93sCKkowjaU9mT7Y8VDCj6YLSRZvNRpagiddPPqG6j7fFw53r
         AVr1DE8/E8aIKXEjtnZAkImXGpUWsCRk2G69/P9KUWEe41QJUPFwgX6xBiaf4cmnjO
         7lgv49lsC9lvx7YQ3s5OGQik/cmA1fQ1hx1c6Xd+PAOUIAfxeeMYdzNXOn4/vrfR6U
         3GgdLOh93QjQWxhzmJ/3PowWrC+d9V7/7ie2+DV9VzbJc3YSZ+Ia5V2fvU0873F+u7
         zpkHhfs8XDKxA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-48641a481dfso84893137b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 04:27:56 -0800 (PST)
X-Gm-Message-State: AFqh2krt4BFSCSejRkWA5UrFWJITdMOvshwVBN6m0tt+ihqKv8eP3vLS
        mP9/5lBSWoohb6W//ycpAIcb/ebI76rojJCAavE=
X-Google-Smtp-Source: AMrXdXvbkB7RvKVDzQDmZBdvczEpFKYqXxTUYwGdumSZ1d2h8wVpkpY8a/NOxNif2Pa56CsSZ68dT/sx+EPANuc+rrk=
X-Received: by 2002:a81:838d:0:b0:46e:a921:1d82 with SMTP id
 t135-20020a81838d000000b0046ea9211d82mr2312203ywf.487.1672316875943; Thu, 29
 Dec 2022 04:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20221226213227.26953-1-ogabbay@kernel.org> <5db3ee62-d864-1eb7-65c3-21e86037cbe0@quicinc.com>
In-Reply-To: <5db3ee62-d864-1eb7-65c3-21e86037cbe0@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 29 Dec 2022 14:27:29 +0200
X-Gmail-Original-Message-ID: <CAFCwf106PK-Rbr-P397xqm_4xkiKZgbo6CfGbSQQQTq0=AWQPA@mail.gmail.com>
Message-ID: <CAFCwf106PK-Rbr-P397xqm_4xkiKZgbo6CfGbSQQQTq0=AWQPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs/uapi: move uapi file to drm
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     airlied@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 8:29 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 12/26/2022 2:32 PM, Oded Gabbay wrote:
> > Move the habanalabs.h uapi file from include/uapi/misc to
> > include/uapi/drm, and rename it to habanalabs_accel.h.
> >
> > This is required before moving the actual driver to the accel
> > subsystem.
> >
> > Update MAINTAINERS file accordingly.
> >
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
>
> This would impact the hl-thunk project at
> https://github.com/HabanaAI/hl-thunk as the open userspace, right?  I
> don't appear to see corresponding changes there.  Is there a dev branch
> I'm missing?
I will change it in a few weeks. The driver changes are only inside my
branch, I have time until the next merge cycle.
Oded
>
> -Jeff
