Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB92164226F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 06:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiLEFCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEFCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:02:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82CDFADF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:02:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so10126300pjp.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RaPN84Uxf892uugyR0/feAI2xM9TuK0z8cP4MEIBR8c=;
        b=XPzQWo9Aig7b540V7TojrYhvSH53zgLOaQkg0q3giQu2YDrfVnTZIMTRRi3iCqD9+c
         sAUbjJ50eTtwtIrPQqlDVcLb50kh1nyvmElQpnBMqBM7Ds0lNjxEcEmbYuiosrUZnNRU
         b+24kKscS6YJnUHalv8THRhltm0XxrIk5t4LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaPN84Uxf892uugyR0/feAI2xM9TuK0z8cP4MEIBR8c=;
        b=4uIztfUnEzPeCT+8lDo94Yhq4FNT8DNOI++rS4D+e0nSf1lxRCg8gSbuuYN7rdbKYE
         LlrA+svZeaURCyByEXDsenTzHbv0/+061IrRRio9Xa9eM4e//iHlibikeVU0meOHAvkE
         /TeWMe06RGwyiTVXhNIjcbx7+X4wqNK/o6VPZ2PdspLHRCgCmIojekIrpfAARS+8sf19
         vnDMOzPsyTxbZz2YKR1pmxO6mEbCy8sRXzwpqesECIqBponrG1NDentSAw2fXga6fM+N
         NHr51kQZL3mKC6Fj98YQODUGeGj0r+ryeDrZ++dzxvWuoZkH1QForU9arkadfV72PhGW
         cf6Q==
X-Gm-Message-State: ANoB5pnc3YEJps8yAaoqLUKBiBnk+INkKpgNfH4HuLs8eskD7iyMIOxU
        lY1PEtBHXTcRTYoIkPMOsE/dHPyO/OeGldNxe5Mdo6cN5VYH/ZbC
X-Google-Smtp-Source: AA0mqf6psoRKWmJz/JSqESjSHaDjM+aeAcK9X2GX1CQDKXqq0KqtubyUdxlKbqLSiT3wHzGn2ZcdBessKGx3W3DrpKI=
X-Received: by 2002:a17:90a:f189:b0:219:996c:6bfc with SMTP id
 bv9-20020a17090af18900b00219996c6bfcmr12489960pjb.134.1670216533438; Sun, 04
 Dec 2022 21:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org> <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
From:   Yunke Cao <yunkec@chromium.org>
Date:   Mon, 5 Dec 2022 14:02:02 +0900
Message-ID: <CAEDqmY4F5fmcBydBtvyUQdUOBCs9N1HjrWBJAc-p0Smgj8VE2g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of
 metadata devices
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
> Devices with Metadata output (like uvc), create two video devices, one
> for the data itself and another one for the metadata.
>
> Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
> to avoid having multiple devices with the same name.
>
> Fixes v4l2-compliance:
> Media Controller ioctls:
>      fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
>    test MEDIA_IOC_G_TOPOLOGY: FAIL
>      fail: v4l2-test-media.cpp(394): num_data_links != num_links
>    test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
>
> Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/v4l2-core/v4l2-dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
> index 397d553177fa..5c2c9ebb6b96 100644
> --- a/drivers/media/v4l2-core/v4l2-dev.c
> +++ b/drivers/media/v4l2-core/v4l2-dev.c
> @@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
>         if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
>                 return -EINVAL;
>
> +       /* Add Meta: to metadata device names */
> +       if (vdev->device_caps &
> +           (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
> +               char aux[sizeof(vdev->name)];
> +
> +               snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
> +               strscpy(vdev->name, aux, sizeof(aux));
> +       }
> +
>         /* v4l2_fh support */
>         spin_lock_init(&vdev->fh_lock);
>         INIT_LIST_HEAD(&vdev->fh_list);
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae

Reviewed-by: Yunke Cao <yunkec@chromium.org>
