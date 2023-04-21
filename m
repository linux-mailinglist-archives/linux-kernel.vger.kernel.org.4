Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C486EA854
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDUK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDUK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:27:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF82E63;
        Fri, 21 Apr 2023 03:27:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-552d64d1d2eso17556727b3.1;
        Fri, 21 Apr 2023 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682072827; x=1684664827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1jDlW0W3MhjA8VbvOr9JFFYadMRZj0oB2XjEN8u/ZQs=;
        b=Jq29MVaVXQLS7/50058udG92P2tJ0UekckHnIlgksme797+yXQe/r1AZ4lHs6wJmM3
         68UCR52u1/x0QZPBwDYQC/+6TpzG3a8XR8OnW+Usfo6Lna4M1f7uF7w9BeRa1aD06cMl
         zGL9krAi1vZ3U5UyV+Dl4j5XfFhrXqTgk/dPt3WpF1wqAXu44UUqaWLHNcjgV8b3zGjU
         dutK14XNfjEG+u2galkQfJXW/wAtUUJeqXrDXCeEVrEdt33M8X4iB/PsrMPsSqmyizi5
         xGCiDATgeh9PHT84RlBa7BJERI6ne2eFDP3lBcKxKS1LVBKsCtxb2+PJ0gnXGCFR8QLp
         pBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682072827; x=1684664827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jDlW0W3MhjA8VbvOr9JFFYadMRZj0oB2XjEN8u/ZQs=;
        b=KLABm/XCsEGu28leMiOFFn3eYtWTTf5JGXJSebveygdRwMcD/A4EciKXTZ0uuYIIn/
         1Zqdkf69Z0E6g3W/cjw+wFhounEXWG+9/MrFiQUEaEZoZjvFQTIYi/EcU/v11Er0T0rX
         XJVSZm6d7JP0BzvhxmVttmWOBhTNVUt7imBEAmeqlZ5JOTRVAf4CNFVWlx8BpnYsBIs6
         cps16XtuhCP2pD1X0cdzfKf1j8G78+ruHmIqDRc7hYxAqmM1WW9sNSBJGm40j5Z5IMPB
         VMugrV1FH13bb2c/30ZxraY9/+tg8O/6urX2luZjT9QTmcmM/YyomvHZC3ghkaWJtZyj
         uIMw==
X-Gm-Message-State: AAQBX9fmdLbpDvP3aZYSmZQYiFailEz6RUPLn6SD3He3f214JmemTTMp
        B65X6RgwLAYmB7mwOEJuDoT1a4rMC51NNADEMVZlhC7Xd1JjoO3I
X-Google-Smtp-Source: AKy350Z7RE8rSiaLK/lDI02fKHY8C/Hkm8qnkU6IUdScLzIa6Hrc+QXATCBAVcaBw4SmzH5UZ0SVAeWWaxXJZEHiMro=
X-Received: by 2002:a81:6fd5:0:b0:541:6d79:9291 with SMTP id
 k204-20020a816fd5000000b005416d799291mr1599574ywc.43.1682072827166; Fri, 21
 Apr 2023 03:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230412224311.23511-1-robdclark@gmail.com> <20230412224311.23511-6-robdclark@gmail.com>
In-Reply-To: <20230412224311.23511-6-robdclark@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 21 Apr 2023 11:26:55 +0100
Message-ID: <CACvgo525ogS4LSZDUyaqjSqjJWj=qLRkphji5469=3obFXoMrQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] drm: Add fdinfo memory stats
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 23:43, Rob Clark <robdclark@gmail.com> wrote:

> +/**
> + * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
> + * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
> + * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
> + *
> + * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
> + * and drm_show_fdinfo().  Note that an object can DRM_GEM_OBJECT_PURGEABLE if
> + * it still active or not resident, in which case drm_show_fdinfo() will not

nit: s/can/can be/;s/if it still/if it is still/

> + * account for it as purgeable.  So drivers do not need to check if the buffer
> + * is idle and resident to return this bit.  (Ie. userspace can mark a buffer
> + * as purgeable even while it is still busy on the GPU.. it does not _actually_
> + * become puregeable until it becomes idle.  The status gem object func does

nit: s/puregeable/purgeable/


I think we want a similar note in the drm-usage-stats.rst file.

With the above the whole series is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Fwiw: Keeping the i915 patch as part of this series would be great.
Sure i915_drm_client->id becomes dead code, but it's a piece one can
live with for a release or two. Then again it's not my call to make.

HTH
Emil
