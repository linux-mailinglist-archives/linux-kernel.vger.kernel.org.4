Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661966F1298
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbjD1Hlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbjD1HlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:41:06 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F646AC;
        Fri, 28 Apr 2023 00:40:45 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-772661d22c2so3293385241.0;
        Fri, 28 Apr 2023 00:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682667643; x=1685259643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MnQ5of6M5/y7NIEMwyCrgsAXsP/6p2NWEIphTReCHEM=;
        b=o9mc1/g7mBWHjnVTA6rJ/gtnlcn3yIosoBwhs0YVtkhqkH6vQncrIO/B+LDPDJ/9tp
         IZtNSYL9F12hLX0U9o2p+Ie3FyfFskFqHfKAOZIKj5DJadgOBY5/WKqZI8VgF6Xflf/R
         lFCwaABW1YUvgH8Luh01/5Y2z2EEgiD7sGkPuMyhFvXFQzdYlFIsPfQkkEIN+gjDySQc
         idmVofYdKf/o1oZl83ANxLD47SjSFldOLV/3Go1xLtKNEPaQyisDWtIqP1RvC8K8nvD1
         a1p0K1OtJg3temYIZW+kaWpgmt/V+9LLb7UgVMuJ1hcre0Si01amy6z9Cfdq+Y6DtbhY
         bLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667643; x=1685259643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnQ5of6M5/y7NIEMwyCrgsAXsP/6p2NWEIphTReCHEM=;
        b=eRypm7KuCe5IbZk+e9h+xlRRwfYLbbRyEYWPdQBfgsBJfFawQ6ItUqo4DfwDVx2d1R
         sdGJUCI2WuhduLlr5XOTNKMF8jDlGMOoE+caffftKArEGt1xV3X0ShHeMs4memjH3ptT
         4zL8RCZk95kX2cK6kIrP9vwEsB/+rTg5yg3UeinSs1XSL/5ojkR5eVqVfiZ63Shlq94Y
         K3+UDG4MeK7eesBYmpWWqbYczeSTZQ0LbOvITKcgXp0LzD/jBx9x5UVn5q+mUpdqHMcQ
         YIIKDBc+Iuaun0ADedrg+PM3WkTkuv8Yovqqoe6UnIF3a5U1o3GT1a7Z3sXUhHGtANhA
         mi/A==
X-Gm-Message-State: AC+VfDxRT7MV1gIvT2/SgHBoZ5CoNb4yTIEbEtdtYj6VAWMsLafyc9kY
        m3SoJBiQV72dTGJJVu1MyiQdNazYYUE2P29Ayi8=
X-Google-Smtp-Source: ACHHUZ73o2NFQLqN/VJRmpmG5rttPIfs6eFu1Z7n2MTiFytaKZNNxdtR5y2DVukspV/gGCNoBDGiBrAO9+GsIrdOxb4=
X-Received: by 2002:a05:6102:2455:b0:430:3aec:efb5 with SMTP id
 g21-20020a056102245500b004303aecefb5mr2036514vss.3.1682667643018; Fri, 28 Apr
 2023 00:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230207091902.2512905-1-milkfafa@gmail.com> <20230207091902.2512905-8-milkfafa@gmail.com>
 <d91457ea-44c3-b96b-ce60-3e5ce9a80f7b@xs4all.nl>
In-Reply-To: <d91457ea-44c3-b96b-ce60-3e5ce9a80f7b@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Fri, 28 Apr 2023 15:40:31 +0800
Message-ID: <CADnNmFoJc_9irFx8CbmnXZ+qW_XNRJ5-SbBLLiAXYS8PHb0LPA@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
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

Hi Hans,

Sorry for the late response.

> > +static void npcm_video_get_resolution(struct npcm_video *video)
>
> I think 'ncpm_video_detect_resolution' might be a better name.

OK, will change to 'ncpm_video_detect_resolution'.


> > +{
> > +     struct v4l2_bt_timings *act = &video->active_timings;
> > +     struct v4l2_bt_timings *det = &video->detected_timings;
> > +     struct regmap *gfxi;
> > +     unsigned int dispst;
> > +
> > +     video->v4l2_input_status = 0;
> > +     det->width = npcm_video_hres(video);
> > +     det->height = npcm_video_vres(video);
> > +
> > +     if (act->width != det->width || act->height != det->height) {
> > +             dev_dbg(video->dev, "Resolution changed\n");
> > +             npcm_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>
> Why return all buffers? You shouldn't have to do this.
>
> Right now this function is only called at start streaming and when
> query_dv_timings is called. Is it possible for the resolution to change
> while streaming? If so, do you get an interrupt or is there some other
> mechanism to detect this? Normally a resolution change will raise a
> V4L2_EVENT_SOURCE_CHANGE event, and userspace then decides what to do
> (typically stopping streaming and reconfiguring the video pipeline).
>
> What happens if you continue streaming when the resolution changes?
> Particularly when the new resolution is larger than the current
> buffer size.

Yes, it is possible for the resolution to change while streaming.
In our case, userspace application keeps monitoring resolution by
calling query_dv_timings,
and it will stop streaming and reconfiguration if resolution changes.
I've checked that VCD can support resolution change interruptions.
I'll add interrupt support as you suggested.


> > +     if (det->width == 0 || det->height == 0) {
> > +             det->width = MIN_WIDTH;
> > +             det->height = MIN_HEIGHT;
> > +             npcm_video_clear_gmmap(video);
>
> This looks like a potentially dangerous side-effect. I would not expect this
> function to have any side effects: it just detects the new resolution.

Will remove this and modify the flow of ncpm_video_detect_resolution.


> > +static int npcm_video_enum_input(struct file *file, void *fh,
> > +                              struct v4l2_input *inp)
> > +{
> > +     struct npcm_video *video = video_drvdata(file);
> > +
> > +     if (inp->index)
> > +             return -EINVAL;
> > +
>
> You need to call npcm_video_get_resolution(video); here as well,
> to ensure inp->status is valid. Although ideally you know if there is a
> new resolution due to an interrupt or something like that.

Understand. Will add support for resolution change interrupt to ensure
inp->status is valid.


> > +     if (vb2_is_busy(&video->queue)) {
> > +             dev_err(video->dev, "%s device busy\n", __func__);
> > +             return -EBUSY;
> > +     }
> > +
> > +     video->active_timings = timings->bt;
>
> This updates the active_timings even if npcm_video_set_resolution
> fails. Is that what you would expect?

active_timings should be updated only if npcm_video_set_resolution
succeeds, will modify it.


> > +static int npcm_video_sub_event(struct v4l2_fh *fh,
> > +                             const struct v4l2_event_subscription *sub)
> > +{
> > +     switch (sub->type) {
> > +     case V4L2_EVENT_SOURCE_CHANGE:
> > +             return v4l2_src_change_event_subscribe(fh, sub);
> > +     }
>
> This makes no sense unless you can actually detect resolution changes
> and raise this event.
>
> If there is no easy asynchronous way of telling the driver that the resolution
> changed, would it be possible to have a thread that periodically checks the
> current detected resolution?

Will add support for resolution change interrupt and raise the event.


> > +     switch (ctrl->id) {
> > +     case V4L2_CID_NPCM_RECT_COUNT:
> > +             ctrl->val = video->rect[video->vb_index];
>
> Does this change per frame? This is not really a reliable way of passing this
> information to userspace.
>
> I also wonder if the number of rects isn't something that can be deduced from
> the payload size of the buffer.

VCD supports two capture modes:
  - COMPLETE mode: Capture the next complete frame into memory.
  - DIFF mode: Compare the incoming frame with the frame stored in
memory, and update the differentiated rects in memory.

If using COMPLETE mode, rect_count is always 1 (complete frame).
If using DIFF mode, rect_count will be the number of differentiated rects.
In DIFF mode case, rect_count is not deducible so userspace needs to
use V4L2_CID_NPCM_RECT_COUNT control to get the information.


> > +     kfree(video->rect);
> > +     video->rect = NULL;
>
> This line is not needed.
>
> > +
> > +     video->rect = kcalloc(*num_buffers, sizeof(*video->rect), GFP_KERNEL);
>
> Possibly overkill to allocate this. It can be an array of size VIDEO_MAX_FRAME
> as well. Up to you, though.

OK, I will modify it as you suggested.


> > +     vbq->io_modes = VB2_MMAP | VB2_READ | VB2_DMABUF;
>
> Does VB2_READ make sense? It can't really be used with a HEXTILE format
> since that has variable length payloads, and with read() you don't know
> the size of each compressed frame.

VB2_READ should be removed. Thank you so much for the detailed review.

Regards,
Marvin
