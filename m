Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AFE6D4599
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjDCNW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjDCNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:22:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1E1558A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:22:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e65so34662495ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680528152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=puJQIiNwi0B7OHT+YCNoLm1RVfBbXjaYqHubaytTOZc=;
        b=iFmu6Bph/r5JtPpy4KiE3uF1FZx4WD1yKmH9pZNGnpcQ+rpE7jJXoHdkumVA8mECJ9
         1yuVFCPOEZAJvB8kJXc1F2AequweKSrN82RJjtyE2aSxlHiKn5qTmxPsEspfGvjnxcc+
         xO4OI/xLCUDLiDR6iXCVuF5rWXOkUwipr/nJZ6syWHfavVYl1oBrGXDm9cMRfyY0HS5R
         LHpXIg53OEKGjqDV8dmXxMElXPSjS96U8N6WMzBQtsbMd2tFuDVmB76E3bEOWSld7FPY
         a25ESuLO+P8iW9goF0NmubEftjJ0BDJT9c9zkgjjNItMW4hPRPFvcCOQCTUSDEPhXRqD
         QU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680528152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puJQIiNwi0B7OHT+YCNoLm1RVfBbXjaYqHubaytTOZc=;
        b=qnT2FEDRiTPwqqyy8S7ufmcGI5lCRY9/DuIEPuXNt0l63xPPprBP9+WtzrEbT8z607
         DH9KY7DgkWC+WRpWYPYzVykKmGd8fzjCWB45cPWtciMXVTPDS6ICdrmpvPJOQyRTnmvS
         rJdVrJgt6uqgK+keKGCKalWIkJwwitGFJy8e1r6i2W/kWs0v9QtXkOS0PTYCtjtTqgoI
         meyjTZnputQa7mPY0zxvX97R/A1d6eslKs5lWbVS43xaQlxOSZZ3wVFfm5bvnQEWskrx
         aZCV1Tw0BH8KJwD1Dnxo19LVWVszVjZo8qX66Ik39LzT6urZ6v9qKZvSWQ+gAfwEhmS8
         u5TQ==
X-Gm-Message-State: AAQBX9d4KaAGX0CP/vxSjM05zb41TK/wOux/fy56C8qNhsefXmPaiSbe
        9QwcLrSCdvihsWq0jH6hzvJAVX0uWaYd/4JF0zU=
X-Google-Smtp-Source: AKy350bWysdzXHGZ8/wze3T0qWf/LM4Wl8ayF7vOJuIYnrg0bXgibm9ykvXEhOtu6Wmfpbs5ZM+9QenlXSPq3ioXank=
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id
 o126-20020a25d784000000b00b763b21b1dcmr11126480ybg.0.1680528152080; Mon, 03
 Apr 2023 06:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
 <20230323230755.1094832-3-dmitry.osipenko@collabora.com> <ZCXF4q81wPcczkqx@arch-x395>
 <3618a293-4f61-b076-0a9c-c70812436431@collabora.com> <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
In-Reply-To: <CACvgo51GWRCQuiJDVrqo=xzd3frKvs6WNcc755pbu8jNk6t-Rg@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 3 Apr 2023 14:22:20 +0100
Message-ID: <CACvgo53bkvDm7CXN_zFETZeuWas50tJys6u+nc5DO_MWK4SZfw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/virtio: Support sync objects
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@redhat.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
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

On Mon, 3 Apr 2023 at 14:00, Emil Velikov <emil.l.velikov@gmail.com> wrote:

> > > I think we should zero num_(in|out)_syncobjs when the respective parse
> > > fails. Otherwise we get one "cleanup" within the parse function itself
> > > and a second during the cleanup_submit. Haven't looked at it too closely
> > > but I suspect that will trigger an UAF or two.
> >
> > There are checks for NULL pointers in the code that will prevent the
> > UAF.  I'll add zeroing of the nums for more consistency.
> >
>
> Riiiight the drm_syncobj is attached to the encapsulating struct
> virtio_gpu_submit _only_ on success.
> By clearing the num variables,  the NULL checks will no longer be
> needed ... in case you'd want to drop that.
>
> Either way - even as-is the code is safe.
>

Err or not. The NULL check itself will cause NULL pointer deref.

In more detail: in/out syncobjs are memset() to NULL in
virtio_gpu_init_submit(). The virtio_gpu_parse_(|post_)deps() will
fail and leave them unchanged. Then virtio_gpu_free_syncobjs() and
virtio_gpu_reset_syncobjs() will trigger a NULL ptr deref, because
they are accessing the elements of a the (NULL) array.

Apart from the num_(in|out)_syncobjcs=0, I would drop the NULL checks
- they give a false sense of security IMHO.

-Emil
