Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951EA5BF848
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiIUHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiIUHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:52:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7533844FD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:52:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sb3so11668460ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3t0QSICbCHMFeqWwEhSbFChZlPVdEP7jp9Mgy19n9ZI=;
        b=RcWUp3AC8ik5xA3FFb8AqV/B9BBLXdzlUOvbVcqm+KKvWeH+heXwvMZuNq688Yf6nN
         Oge7CqEuI5p1WGMwFEqHKJ4ClPT/ogD3VfsiILMeW0j6CZ3vBcsUfTEqyLiWkWZtIGqM
         YkFmYrMx0x7yHEoGmvVCJqgvdYWZIhlpmukNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3t0QSICbCHMFeqWwEhSbFChZlPVdEP7jp9Mgy19n9ZI=;
        b=A678/sKy5zJ83K7Kt3rUDnzipZJBdCTPEd6I0YbeRq4gB5mappJ9cfvpupzgPhCq32
         aZ583Io/qrXDfEzWBGyYOaGFBfd6royFkQTTBSU2ia05XtYvFi6lFFbuJPvQcEbxYT5s
         ValRo01zcudmxvhwqXXjTcrl6I4n0YbCHTZdb/nLjfUevM/jgkghxs4bDsuN5iA5lYXs
         E0huEEyihlAgjhc8SGs8+RRoUQMHYx1/w+/uGT5uQgpdF/uJK4wmWQlSZTynbKYcSsqs
         U+7fkv4Ljoke2iu1ZXlRukdQJwtvW+W5HFKUppBldrny1+GC3q73FwwT1ZhESueeDWcy
         EbbA==
X-Gm-Message-State: ACrzQf3sOff4bICSuysGCyZbEtpLQWOF9nwpGCzkOOkkTc/VBf+g14qw
        20uXIrxzn9qdrLtCQJ7D33aP+J6QfK2HLtuA
X-Google-Smtp-Source: AMsMyM7ZHj8i+Y3IQCwzyHWP8t90mGoIyRwqDzEJDxb0328Vc0cAAlIc/12RbM+5zsorQNZ0Vq+v3g==
X-Received: by 2002:a17:907:3f87:b0:781:ee94:7f91 with SMTP id hr7-20020a1709073f8700b00781ee947f91mr3241852ejc.52.1663746716825;
        Wed, 21 Sep 2022 00:51:56 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id s21-20020a1709062ed500b0077077b59085sm891677eji.184.2022.09.21.00.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:51:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id dv25so11597168ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:51:55 -0700 (PDT)
X-Received: by 2002:a17:907:94c7:b0:780:7ccd:aca7 with SMTP id
 dn7-20020a17090794c700b007807ccdaca7mr19896147ejc.136.1663746715369; Wed, 21
 Sep 2022 00:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220920-invalid-desc-v1-0-76a93174f3bc@chromium.org>
 <20220920-invalid-desc-v1-1-76a93174f3bc@chromium.org> <Yypgi6Jc9/tZLtIw@pendragon.ideasonboard.com>
In-Reply-To: <Yypgi6Jc9/tZLtIw@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 09:51:44 +0200
X-Gmail-Original-Message-ID: <CANiDSCsbwYfnqcWOjAJw2qvZnB-qE66LqGMhpD8youDj=f+U-g@mail.gmail.com>
Message-ID: <CANiDSCsbwYfnqcWOjAJw2qvZnB-qE66LqGMhpD8youDj=f+U-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] media: uvc: Handle cameras with invalid descriptors
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>
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

Do you mean something like this?

diff --git a/drivers/media/usb/uvc/uvc_entity.c
b/drivers/media/usb/uvc/uvc_entity.c
index 7c4d2f93d351..66d1f5da4ec7 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -37,7 +37,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
                        continue;

                remote = uvc_entity_by_id(chain->dev, entity->baSourceID[i]);
-               if (remote == NULL)
+               if (remote == NULL || remote->num_pads == 0)
                        return -EINVAL;

                source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
@@ -46,6 +46,9 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
                if (source == NULL)
                        continue;

+               if (source->num_pads != remote->num_pads)
+                       return -EINVAL;
+
                remote_pad = remote->num_pads - 1;
                ret = media_create_pad_link(source, remote_pad,
                                               sink, i, flags);

regarding making a new patch, whatever is easier for you ;)


On Wed, 21 Sept 2022 at 02:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Sep 20, 2022 at 04:04:55PM +0200, Ricardo Ribalda wrote:
> > If the source entity does not contain any pads, do not create a link.
> >
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > index 7c4d2f93d351..1f730cb72e58 100644
> > --- a/drivers/media/usb/uvc/uvc_entity.c
> > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > @@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
> >               source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
> >                      ? (remote->vdev ? &remote->vdev->entity : NULL)
> >                      : &remote->subdev.entity;
> > -             if (source == NULL)
> > +             if (source == NULL || source->num_pads == 0)
>
> source->num_pads and remote->num_pads should always be identical, but as
> the next line uses remote->num_pads, wouldn't it be better to test that
> variable ? If so, I'd move the test a file lines earlier, with the
> remote == NULL test.
>
> What do you think ? If you agree I can make that change when applying,
> there's no need for a new version. Otherwise I'll keep the patch as-is.
>
> >                       continue;
> >
> >               remote_pad = remote->num_pads - 1;
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
