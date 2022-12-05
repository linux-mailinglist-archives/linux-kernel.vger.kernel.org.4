Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB1642276
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLEFGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiLEFGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:06:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043713E14
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:06:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so13675991pjc.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 21:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzfrLwm5deU9EoxlVLLuZC97Fkv3AmaoGMX6USkrA64=;
        b=Zu+cTwtzIEa2DayV2B+ULuTjRbtYRVbRfrJMdOOf/L0piPGAAVYzFqwvRza5DjxUhl
         hJwxg7DKoHD/E1ZymPfIaBBUwDsZSdF3Z/pjDrJOaurJ6b8M4jaL52VlVFGAqmugZgGq
         XR8DXCK/uHwfM2PbwGFzvv79DI8jHejR3d620=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzfrLwm5deU9EoxlVLLuZC97Fkv3AmaoGMX6USkrA64=;
        b=fbwdR4wA2ilMqCJw3ieIiNOlCLpTWtr+XdOJapKVx62lEJfM/VxNbIUfb4CCDCP+BY
         ulLyL6bbXRcjSKmUsxZT/y+uDr8/UxpPTiX6YvXBzsq5OXSMsGlCn6mdEyo/Zljx3Vm0
         yf3ihJUEnft+8/5Oln20ESe+br6k8e0EYiVV519d0hZHBumUvQIQJdcI9VPX5IxCaHob
         e13KNbLzIup5UPXhsh0nxTc5ii/ohHu02kaAbbAIsZtvBsrhhcVBHZ3/NQZxirfQF4ew
         6OmibZj9ieULq4Uhh4etxkxpmZ9v2364rCWrmLw/A+EX4YWw9xBNBhYVdVE3tbDcTG6w
         +bkQ==
X-Gm-Message-State: ANoB5pk0XquYPwA7HUS71G3fiEwgnBYLXdNBnncdcrOkFK9k1utrS6BW
        OL7bySWMu4aPhDbMlDwYoTE2PpzUrFGRsqES67l0pw==
X-Google-Smtp-Source: AA0mqf6/aI/IikDNXRBNBDSaZdlmIrFsbHubSAFSaPrATJSF4xyCg3CROO+wb0tx56D8sLQb4RSmFlr3UV8dae9Kixg=
X-Received: by 2002:a17:902:e313:b0:189:97e9:c8e with SMTP id
 q19-20020a170902e31300b0018997e90c8emr31265974plc.63.1670216806624; Sun, 04
 Dec 2022 21:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org> <20220920-resend-meta-v4-2-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-2-3ac355b66723@chromium.org>
From:   Yunke Cao <yunkec@chromium.org>
Date:   Mon, 5 Dec 2022 14:06:35 +0900
Message-ID: <CAEDqmY4aWJriw9NvcbHh4OUv+NVPZ1BBH-Rp0sPO8EFnOmX4xQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] media: Documentation/driver-api: Document device name
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 2:08 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Document how the name of the metadata devices is modified.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/driver-api/media/v4l2-dev.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
> index 99e3b5fa7444..935a46e29c5e 100644
> --- a/Documentation/driver-api/media/v4l2-dev.rst
> +++ b/Documentation/driver-api/media/v4l2-dev.rst
> @@ -42,7 +42,9 @@ You should also set these fields of :c:type:`video_device`:
>  - :c:type:`video_device`->v4l2_dev: must be set to the :c:type:`v4l2_device`
>    parent device.
>
> -- :c:type:`video_device`->name: set to something descriptive and unique.
> +- :c:type:`video_device`->name: set to something descriptive and unique. If the
> +  device has the `V4L2_CAP_META_CAPTURE` or `V4L2_CAP_META_OUTPUT` capabilities,
> +  the string `Meta:` will be inserted before the original name.
>
>  - :c:type:`video_device`->vfl_dir: set this to ``VFL_DIR_RX`` for capture
>    devices (``VFL_DIR_RX`` has value 0, so this is normally already the
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
Reviewed-by: Yunke Cao <yunkec@chromium.org>
