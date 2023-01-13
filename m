Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC46690B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjAMI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjAMI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:26:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9F1C135
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:26:06 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i1so597371pfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCiFP9JVqQYcltnhJxOwMzt0TI6SjVJUyNuyOtFokuQ=;
        b=e/UJMPBniTVg2GO6GZVo02MR6qRIoVE3kwcoylx1CAZ4skOPbDYphENuDrlumE9hF1
         9EdMGgoZN+FRJQng9AXQHTxO7ELGAEllUe91V4zzb9VIkZOvhKySWb9pYzzbY5Ge3zco
         e1eQO+uaXuGth6A4ouvTknEZzjyUQw5y9kMQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCiFP9JVqQYcltnhJxOwMzt0TI6SjVJUyNuyOtFokuQ=;
        b=FkEOtdOC4k5dZL3tTAzAyV1EM298OX42jsR+kvqtpG2L3TamuMjlbkDXXW6w/RXoCh
         fu8E/bz0IYpMcATD9HSzIj95CNom7vEdWcpCBY5UumyaXHJSCJWXCGAXAZ6VExzuX1dz
         mXQmynnxRQg8H8iYo08NUeUdoNM1LXZpCgCuM39NH7LAppCR2uJsd/9O9ygrhE7IJFfs
         sv7hAFA0yV9rUTRIBoxoYE0MKkOQ8hEnscuaDCS7tdvtoqAUlIdLoS8EvgPFe+lpsUDi
         RV9EApf1sQWXicO5zBYLbtQbmvTZZRLtpxWTPSUaTvA2WcYpBxChsjx2NUgXF3p2jslR
         3qew==
X-Gm-Message-State: AFqh2kqOZL1vjBtuAZBY00Ap3xbHvIABctPZHDO1EYttAfo59iw7I0fz
        a8lOWkkEoyFkf4MO4WDspXT2AQFfiFRvN7uz
X-Google-Smtp-Source: AMrXdXvtMNodEJmEFeruNUnXHk/YyZh/XWZAjAI2pUx42KRw0NTleoQCQnULQcv0gGtIEAXAD8bZMQ==
X-Received: by 2002:aa7:8d09:0:b0:577:3944:aa78 with SMTP id j9-20020aa78d09000000b005773944aa78mr69008488pfe.0.1673598365925;
        Fri, 13 Jan 2023 00:26:05 -0800 (PST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm11584441pfb.155.2023.01.13.00.26.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:26:04 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id f3so14506771pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:26:04 -0800 (PST)
X-Received: by 2002:a62:1501:0:b0:589:8362:c7ce with SMTP id
 1-20020a621501000000b005898362c7cemr1385816pfv.21.1673598363988; Fri, 13 Jan
 2023 00:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 09:25:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCuq483Eha-KfUM_1y4zb0sC8rNgf-yki5SjiUo3czaKBw@mail.gmail.com>
Message-ID: <CANiDSCuq483Eha-KfUM_1y4zb0sC8rNgf-yki5SjiUo3czaKBw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] meida: uvcvideo: reimplement privacy gpio as a
 separate subdevice
To:     Yunke Cao <yunkec@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunke

Thank you very much for the patchset :)

On Wed, 11 Jan 2023 at 09:52, Yunke Cao <yunkec@chromium.org> wrote:
>
> privacy_gpio in uvc were added as V4L2_CID_PRIVACY in uvc video node in
> https://lore.kernel.org/all/20201223133528.55014-1-ribalda@chromium.org/
>
> Userspace applications often require to constantly poll privacy control.
> Currently, polling privacy control requires keeping the video node open,
> which prevents the camera from autosuspending.
>
> This patchset adds a separate v4l2 subdevice. Userspace access the gpio
> via V4L2_CID_PRIVACY in the new subdevice. Applications can poll the
> privacy control status without opening the video node and activate the
> camera.
>
> The non-gpio V4L2_CID_PRIVACY in uvc is not affected.

Since this is a RFC, lets focus on the idea and not on the code itself.

- I am missing a reference to the subdevice from the media device. How
will a user figure out that /dev/v4l-subdev0 is the privacy gpio of
/dev/media0 and not /dev/media1?. Thake a look to the "ancillary
links"
- We have already exposed the control as part of the main video
device, that means that we need to keep that API. The control on
/dev/v4l-subdev0 should "mirror" the control on /dev/video0
- There is no need to v4l2_ctrl_fill_event(), if you modify the
control with a set controll function, the media controller should take
care of everything

@Sakari Ailus @Hans Verkuil : Assuming a correct implementation, how
would you feel about exposing a privacy gpio as a subdevice?


Thanks!!!


>
> Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Yunke Cao <yunkec@chromium.org>
> ---
> Yunke Cao (3):
>       media: v4l2-ctrls: Expose v4l2_ctrl_fill_event()
>       media: uvcvideo: remove entity privacy control in the uvc video node
>       media: uvcvideo: reimplement privacy GPIO as a separate subdevice
>
>  drivers/media/usb/uvc/uvc_ctrl.c          | 17 -------
>  drivers/media/usb/uvc/uvc_driver.c        | 44 ++----------------
>  drivers/media/usb/uvc/uvc_entity.c        | 76 +++++++++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h          | 19 +++++---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c |  9 ++--
>  include/media/v4l2-ctrls.h                | 12 +++++
>  6 files changed, 111 insertions(+), 66 deletions(-)
> ---
> base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> change-id: 20230111-uvc_privacy_subdev-1e7a167e86eb
>
> Best regards,
> --
> Yunke Cao <yunkec@chromium.org>



-- 
Ricardo Ribalda
