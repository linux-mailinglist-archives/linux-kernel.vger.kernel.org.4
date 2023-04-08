Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC46DBAD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDHMUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDHMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:20:16 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926F5B9B;
        Sat,  8 Apr 2023 05:20:15 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id h198so7325972ybg.12;
        Sat, 08 Apr 2023 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680956414; x=1683548414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhbv7Y5Jgs9ftPKleaknEhF4CyhB+GwqEo6U+Rr9mIc=;
        b=kewdyz87bq2iHid5EObeNKszKFtBaD+7IqwhaAlfkh4BXU43XHG0n2XFhE+8I64XoZ
         5vf/WXHewQ2r1JosqkV7cmmaF7Xo3YvF0R2w4N6H6HLcWl1GoA2FLD4ofgwx0JxaTTrq
         CSipUN6RQEUZwSJzL3lwv1Zny4ZWY4oDtBZPqBNHgqwrrBaVhKwRgM/zpeASYlW2SZhI
         71EqJEbs7Yhe+LjUaohEKTrE1vaWHdE4ojLs8Vewlr/uKsjzGq2f9FzNuRbS0G7zV1WF
         3SXZPxBoJCq5Ci9ZklpxYDXRQs/JwtNjqxDNdLTG9w7dTOcoV2GFEBeH5krYm5I5IZ02
         8ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680956414; x=1683548414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhbv7Y5Jgs9ftPKleaknEhF4CyhB+GwqEo6U+Rr9mIc=;
        b=pumuHHWSGmqMJKFRATlfHF/uMsquMuoGpGwUW0vTbwRJAWkBY/QIienUhMI9SPpRDh
         74sBcE+MsGXV7Bncwdfia8gsUQ7PTzG9fzXG55ZxwYVFQUFdd1EepmihLu3yjpFBO9ts
         J/au2EmGKo3lc5RB5mQFWtFdyOJJHbiMDV0zfPupkEqs6iE5FEISmhTOLvy6n30bTuq2
         QsqI4FNOQ/IGt0YxCuHHfsi8o7kFvTg41FeoFVbjADeaIi0UdT+xOJB0j6O8m1L+Kifb
         HKFPVkZ6FuagEKDNAgYJ1qg2rB12xt141O17lNpvFk34rg7rGXlQdZKMfUWrBbE8RMPz
         VuOg==
X-Gm-Message-State: AAQBX9e2Hw99HCQMPZb9YYPN00EfRbTaBATVkl/uk/TfPg7NqGFibxHe
        TbF3bdbJShH3IkYxEGtccWDFThNPuJTAW6hdhJI=
X-Google-Smtp-Source: AKy350byafsIIuMRDAbzbtG99qHBwJjc6HbvgeYdBJg3DC7Y1cC2snm+nm7ja1eD+czjeKKSwOkkAYx2grZ+GMjtYY4=
X-Received: by 2002:a25:be11:0:b0:b7d:4c96:de0 with SMTP id
 h17-20020a25be11000000b00b7d4c960de0mr993477ybk.5.1680956414354; Sat, 08 Apr
 2023 05:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215917.1475704-1-robdclark@gmail.com> <20230406215917.1475704-2-robdclark@gmail.com>
In-Reply-To: <20230406215917.1475704-2-robdclark@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Sat, 8 Apr 2023 13:20:03 +0100
Message-ID: <CACvgo50nOw-82pc2mEbydWH3=RDXuOKwnBnjmOhV-UYcbjRKQA@mail.gmail.com>
Subject: Re: [RFC 1/2] drm: Add fdinfo memory stats
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Christopher Healy <healych@amazon.com>,
        open list <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rob,

On Thu, 6 Apr 2023 at 22:59, Rob Clark <robdclark@gmail.com> wrote:

> +- drm-purgeable-memory: <uint> [KiB|MiB]
> +
> +The total size of buffers that are purgable.

s/purgable/purgeable/


> +static void print_size(struct drm_printer *p, const char *stat, size_t sz)
> +{
> +       const char *units[] = {"B", "KiB", "MiB", "GiB"};

The documentation says:

> Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
> indicating kibi- or mebi-bytes.

So I would drop the B and/or update the documentation to mention B && GiB.

> +       unsigned u;
> +
> +       for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
> +               if (sz < SZ_1K)
> +                       break;
> +               sz /= SZ_1K;

IIRC size_t can be 64bit, so we should probably use do_div() here.

> +       }
> +
> +       drm_printf(p, "%s:\t%lu %s\n", stat, sz, units[u]);
> +}
> +
> +/**
> + * drm_print_memory_stats - Helper to print standard fdinfo memory stats
> + * @file: the DRM file
> + * @p: the printer to print output to
> + * @status: callback to get driver tracked object status
> + *
> + * Helper to iterate over GEM objects with a handle allocated in the specified
> + * file.  The optional status callback can return additional object state which

s/return additional/return an additional/

> + * determines which stats the object is counted against.  The callback is called
> + * under table_lock.  Racing against object status change is "harmless", and the
> + * callback can expect to not race against object destroy.

s/destroy/destruction/

> + */
> +void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
> +                           enum drm_gem_object_status (*status)(struct drm_gem_object *))
> +{

> +               if (s & DRM_GEM_OBJECT_RESIDENT) {
> +                       size.resident += obj->size;
> +                       s &= ~DRM_GEM_OBJECT_PURGEABLE;

Is MSM capable of marking the object as both purgeable and resident or
is this to catch other drivers? Should we add a note to the
documentation above - resident memory cannot be purgeable

> +               }
> +
> +               if (s & DRM_GEM_OBJECT_ACTIVE) {
> +                       size.active += obj->size;
> +                       s &= ~DRM_GEM_OBJECT_PURGEABLE;

Ditto.

With the above nits, the patch is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
Emil
