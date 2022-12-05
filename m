Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FA642272
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiLEFFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiLEFFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:05:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1438913D6C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:05:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10282076pjd.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 21:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bMFNjv5LCSiFbi2Ifk0YDLoby8q0nNuWrZEdeWRC4to=;
        b=ZiSgeCN/NEZng0AqbA5A/3Ohh7MMrkbgyBJLQDvw2lMhYmUF4WNkpOEAGatDOG8dEs
         eqx8z48xrR1w0rMrrgMfZDymyIjoH7YzhcchIQpPcLkQ9kNGf955r5hcCYJNKBke6K6I
         9tfzqCtBmvdGrmYy3MPKA2pmlSz9OaEZKCVOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMFNjv5LCSiFbi2Ifk0YDLoby8q0nNuWrZEdeWRC4to=;
        b=rbLwMbgLfgq/uDkjVOX3gMIVIONL0f/ndOLR7qqmSm+WoS8CfFAsgMKiL+Zw+h+ctT
         qGJG8lxFd0CcIQgES+t235mnEMbWaoO2s8ucpfC+1k9YYOGR6zV21kwaetXxh+hOnl9h
         MhWI9xYwFPjUE6lWL5oepxsKSAtLeir4orJRzzSiN48s70UvdFnNd5MZaVe7lcULCWuN
         3zXs9D3EcF8D9/wkvAl9yN/WC/VJGChuJ533PGYszYi+9N76+XajRrO+COeVJKzFCEt8
         VEfd+2AaWWaMPABgyQqQv+BrthUYO4QyUYsmUGPEcFYxbuQ4sNiAGy2o3SH+Q2qc8HYQ
         HMxQ==
X-Gm-Message-State: ANoB5pmYpHikeg+HdLJonupbsvxJPoFdp5yxXgU4OGBTUYWcaAT8IDJ7
        uZcgJu0LVfdV1T5Mtt7dVq2VgFAcrXtfBGWYfv7NWg==
X-Google-Smtp-Source: AA0mqf7TcsdLvKZHwq+ZDnS8QFWK4+s9CWYBnaQDTJqsYyWJQEHt+qOm+IKycZ/hlD+/bVPHPdWXHCie8iXXISNL4HQ=
X-Received: by 2002:a17:902:e313:b0:189:97e9:c8e with SMTP id
 q19-20020a170902e31300b0018997e90c8emr31261214plc.63.1670216705527; Sun, 04
 Dec 2022 21:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org> <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-3-3ac355b66723@chromium.org>
From:   Yunke Cao <yunkec@chromium.org>
Date:   Mon, 5 Dec 2022 14:04:54 +0900
Message-ID: <CAEDqmY6-gs+aOYRzrRzYaB2Ww0hfxySayd9A7eQinFnSqk5sMA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera names
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 2:08 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
> append a unique number to the device name.
>
> Fixes v4l2-compliance:
>     Media Controller ioctls:
>          fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>        test MEDIA_IOC_G_TOPOLOGY: FAIL
>          fail: v4l2-test-media.cpp(394): num_data_links != num_links
>        test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..f4032ebb3689 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
>                 break;
>         }
>
> -       strscpy(vdev->name, dev->name, sizeof(vdev->name));
> +       snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
> +                stream->header.bTerminalLink);
>
>         /*
>          * Set the driver data before calling video_register_device, otherwise
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

Reviewed-by: Yunke Cao <yunkec@chromium.org>
