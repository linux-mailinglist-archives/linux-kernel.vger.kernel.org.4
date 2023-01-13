Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45066A21F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAMSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjAMSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:33:53 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D052C51
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:30:24 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id 3so23066980vsq.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CXzwvPSlVj3I6D/88tyYLanpnLn/NDNCNzhBeAOiGYM=;
        b=I531NW5K7Qsn31FeCSrTjL5IBfAkbpXCnoHEFr59z0it+fWxQgQ2vRsLj0jxooBany
         mW3Zb1fi8SHgMf2OmV3QbrQU2eIha8LYe3KuOy2clkf15zGa0GcwbXAedwfHSL7A5pdP
         AQ/Lq6p7WFT6cUIKi6WQX0gyXrV+VV1ReisvGai0o15pGQZn34m9FjlZS/OjbM9/6Vth
         vzJFRvcVMUpFlKu2rmSOmAumQIfShzuPXMxHKwv4gYjRjGQf4TwdeddAz7pzNHF5JnBZ
         avR/hHNGYwz0T9RaqlvtqWN/p0PEK3XRxzTw7dr9chCOOIOG+CxBFk42EUQfmmwnJ7zF
         yA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXzwvPSlVj3I6D/88tyYLanpnLn/NDNCNzhBeAOiGYM=;
        b=AAD3aqD2BylL+fXZuVXlYr+HTbcFcUQaKSplbMJONppGMIcAx5WvSttjnkS+MTLljN
         F0mpLGbRGtnX342TAK/hc9PFTeiDloUmX7CVHq8j3j/Lm6TgGPfrchPvIzp63kDltmqH
         vpjpmntlTYVZmc3rAN/QRHZlwEW9diSImoczoOsaDlFRZDibBSF6Q5alf5IvXu7zW1rC
         zVCBSMQdEMsj59vFKqb9dZvBcdKVF4FyFgun+MwB4GlHqPijCOBkTqDlQxhVEvbiuTgx
         RfvVT+8vujZFq45Hdgq2Bhcpu2HI/YbeeZPwJIgkgLS/ddZpOVz7Hp8gbW9xMT/g4Ict
         8KAQ==
X-Gm-Message-State: AFqh2kpBe/OMPhNCzl0fNpOi5OqoWbsT6XMx9O/qfz4yC018SryToE69
        ZBg+lQyUD2nZPJp/5rZ6ReRUp86hPEXDyAEPN5U=
X-Google-Smtp-Source: AMrXdXsHLZ8s1p6LZJ4XXpzy/6UHD2QthJavSExaGcngbBLrF89HjvbE6MXSPcEdIEPY0Fsy++ntWEVFZC4rdd6wqVM=
X-Received: by 2002:a05:6102:c8b:b0:3b2:ebc9:6307 with SMTP id
 f11-20020a0561020c8b00b003b2ebc96307mr12162616vst.73.1673634623018; Fri, 13
 Jan 2023 10:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20221206003424.592078-1-jim.cromie@gmail.com> <Y79Btep8JnPKvuAp@phenom.ffwll.local>
In-Reply-To: <Y79Btep8JnPKvuAp@phenom.ffwll.local>
From:   jim.cromie@gmail.com
Date:   Fri, 13 Jan 2023 11:29:57 -0700
Message-ID: <CAJfuBxxZ0Kjc0G5Ngv7bmokkC4AJKZ07OMCKyLmHBGSsjG7qfA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] DRM_USE_DYNAMIC_DEBUG regression
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, jbaron@akamai.com, gregkh@linuxfoundation.org
Cc:     daniel.vetter@ffwll.ch
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

On Wed, Jan 11, 2023 at 4:09 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Dec 05, 2022 at 05:34:07PM -0700, Jim Cromie wrote:
> > Hi everyone,
> >
> > DRM_USE_DYNAMIC_DEBUG=y has a regression on rc-*
> >
> > Regression is due to a chicken-egg problem loading modules; on
> > `modprobe i915`, drm is loaded 1st, and drm.debug is set.  When
> > drm_debug_enabled() tested __drm_debug at runtime, that just worked.
> >
> > But with DRM_USE_DYNAMIC_DEBUG=y, the runtime test is replaced with a
> > post-load enablement of drm_dbg/dyndbg callsites (static-keys), via
> > dyndbg's callback on __drm_debug.  Since all drm-drivers need drm.ko,
> > it is loaded 1st, then drm.debug=X is applied, then drivers load, but
> > too late for drm_dbgs to be enabled.
> >
> > STATUS
> >
> > For all-loadable drm,i915,amdgpu configs, it almost works, but
> > propagating drm.debug to dependent modules doesnt actually apply,
> > though the motions are there.  This is not the problem I want to chase
> > here.
> >
> > The more basic trouble is:
> >
> > For builtin drm + helpers, things are broken pretty early; at the
> > beginning of dynamic_debug_init().  As the ddebug_sanity() commit-msg
> > describes in some detail, the records added by _USE fail to reference
> > the struct ddebug_class_map created and exported by _DEFINE, but get
> > separate addresses to "other" data that segv's when used as the
> > expected pointer. FWIW, the pointer val starts with "revi".
>
> So I honestly have no idea here, linker stuff is way beyond where I have
> clue. So what's the way forward here?
>

Ive fixed this aspect.
Unsurprisingly, it wasnt the linker :-}

> The DEFINE/USE split does like the right thing to do at least from the
> "how it's used in drivers" pov. But if we're just running circles not
> quite getting there I dunno :-/
> -Daniel
>

Sending new rev next.
I think its getting close.
