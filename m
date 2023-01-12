Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36818667896
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjALPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjALPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:06:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400106338E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:55:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt23so28741796lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eVbemLweSFtIyStHy3sTEbPBu0/XrJNey3w3MbOOwEE=;
        b=ttXHb70rHqfCHVOXsf6Q5SH1fqRM+CaHYdV4Tqag+Er5QQiTg0y1+Wwg4Lq6Icz8gk
         07i9ZLd/4+zAk4eYIHRoIOn3cakEH9OrLhtM4IBNH+83PyySuj8LBD/SySlLt3ixgQaM
         HNv24AlUoYpaTKgZGYTqIGfYKQ7Xdvcpjthr21TzD2BxPttH9lZZxXs1+klT64JNwILS
         woxLHVoX26DOx1pxijJOZllJliT9/OwUkXzUBSArrCH5WrF2ppYUXt4ZJF1sLIO7HyOb
         wdG2WRVMc/aByObJ3YGG+mqAavghifEazNoGYj6xE35Z200zToR0Nl9VQIyx22iGsGoo
         tHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVbemLweSFtIyStHy3sTEbPBu0/XrJNey3w3MbOOwEE=;
        b=IaCfhSszxO6ub9bPFvl+ny5P79kLCMu+P1sx0apmcOX2zwcFPohyvp5GX9e9Y0w2pc
         um2qU/hXLGtnZ8GVIDM/VHFWUF4GIX37UWulvfQcplU+x19fdP3DvIq/JWpN2gyLZy76
         Ao/BjnXcNJO++Mgpw3grckOzSiKN0FfiQJw/+ipfckJd5lOhj3SDGxn+oJ2yQtHy0st1
         Ys4fA/0EUNEk3UuIdcdTpPaoP2oCkK4hA+2yPhO2kC0Yt+jdimibzJCSATDHgGGQsWjx
         z1x6JEzuha0Z1DefdrrTNOWLFcjjAaYxyHS7yjUaGAJqs9YtEUz+/yFwXlhN0rrkEPju
         xNMg==
X-Gm-Message-State: AFqh2kqdJ0SLh7hwnTUxCwJ+qhPHpK5eJEu0QG59EF0g1qanzEQ6l2sb
        eo0lPwd8mDX4pMY9h0l3B3QskC6IZar4QHNzkyS89w==
X-Google-Smtp-Source: AMrXdXt+v1FWLQNKkH6B+Roo5NSENxZFIjpoigv8VLgU4hO/6DIdLqekSCezf+AaI9MGINFaBKiRdOxPUMcZG4OlTuk=
X-Received: by 2002:a05:6512:388e:b0:4ca:f6a4:455a with SMTP id
 n14-20020a056512388e00b004caf6a4455amr6689684lft.321.1673535319553; Thu, 12
 Jan 2023 06:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com> <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-4-fa1897efac14@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 12 Jan 2023 11:55:07 -0300
Message-ID: <CAAEAJfBuA=gTpyeKs5mj0_1z+x5sZhse2OGPP5nmb5E6XNjBKw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] staging: media: rkvdec: Block start streaming
 until both queues run
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Ensure that both the CAPTURE and the OUTPUT queue are running (e.g. busy
> -> have buffers allocated) before starting the actual streaming process.
>

Usually, you want to write the "why" in the commit description,
instead of the "what",
which is (hopefully) more or less clear by reading the commit change.

The commit description should have enough information to understand
what is the impact of merging the commit (or what is the bug without
the merging the commit).

If you are fixing a spec violation, adding a reference to the spec is important,
if you are fixing a v4l2-compliance, pasting the error, etc.

> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index c849f6c20279..e0e95d06e216 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -562,6 +562,13 @@ static int rkvdec_start_streaming(struct vb2_queue *q, unsigned int count)
>         if (V4L2_TYPE_IS_CAPTURE(q->type))
>                 return 0;
>
> +       /*
> +        * Make sure that both the output and the capture queue are running
> +        */
> +       if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) == 0 ||
> +           rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) == 0)
> +               return -EAGAIN;
> +

IIRC, this is already handled by Videobuf2 core, see the comment for
vb2_start_streaming,
in drivers/media/common/videobuf2/videobuf2-core.c. There's also a
!q->num_buffers check
in vb2_core_streamon.

In general, if you see some kind of bug in a generic logic like this,
it's a red flag that something is wrong at the core level.

Thanks!
Ezequiel

>         desc = ctx->coded_fmt_desc;
>         if (WARN_ON(!desc))
>                 return -EINVAL;
>
> --
> 2.25.1
