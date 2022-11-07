Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7780161EBB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKGHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKGHUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:20:50 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC44F2;
        Sun,  6 Nov 2022 23:20:49 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id c31so3773519uae.10;
        Sun, 06 Nov 2022 23:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCSC1Xt7ibn8IOvDjJqPliEyiNhSv3szasXlPzJli/I=;
        b=V21INu9spLmVlUlsn2AwTd97U5fwSzKN/ig69ACcD0O4udIelk4GOxznlRKCnLr2G9
         oNApzsJ/WMmuFjJDmIaihCvcdkWz0RcLNazxgns6Dy/v9R0R5EO2aNCY5qYIoSEaw2WQ
         NlTUBE5P/mjNhZSZl8/MuytNtSWTOGNzV0M/OwE6JXwgFrkOkc7E3IkhuFX/z8tajJ//
         v4NvEiwegteNF9aOihus+vTMOulkUYSHrLMLZOKlJby7KLmOggwJgAndnIWB+4uygltQ
         S7A7rvanFY7hWv42zNgKHDuGS1g9K8L1ynKW7XZ9MJZUvu3ER2hy95K2tGaw/IyafoIT
         ENFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCSC1Xt7ibn8IOvDjJqPliEyiNhSv3szasXlPzJli/I=;
        b=dIHtDjE1BW5nYud8Hh0vNHIAWV2mc8cE5yRNddF3Llu5cljXbVFgTRsWpyMpHWL6oi
         /n/D+y/6BqjX58MB6oaPyyPmKSqkPF9ui0gKvWJRif/kKKfsbwWGJ3WbBdQDuio3r21z
         ruskyP69/H/HuDzqqt9hvWaFcHR358J7gicts19dT3VEeLOgFxYqYl/tPQvhZj1C76nC
         9Baa1cEQdqwX+tyDutv8x4YJbCd5UdWduPLt2Z0HUl0JOzYlAq06FO2bHyogDqZi9IYW
         D6rqZbKgGtWmoONh28daw+EReHFKvp5GlXMZ34gtoIpix5NGbHqUDIbsEKbyahSz3v1u
         PI6g==
X-Gm-Message-State: ACrzQf1gmsShDtJeS95XVxmZ4kRrOejR3YENJGKw6ChRvdyJYO1uEjgu
        g/w2N5ZlbEEaucRPjZNoCQHY+cqpT088wZiK+Mg=
X-Google-Smtp-Source: AMsMyM7GfHOoHTGIzy2QFrYqJaeS2plU7RtHustmbzsq9n87vaiRutdb5sBeo92zjeDyjKKkvMt3kYZNmYL+k2oyopM=
X-Received: by 2002:ab0:7702:0:b0:402:956d:377a with SMTP id
 z2-20020ab07702000000b00402956d377amr13928347uaq.19.1667805648195; Sun, 06
 Nov 2022 23:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20221104033810.1324686-1-milkfafa@gmail.com> <20221104033810.1324686-6-milkfafa@gmail.com>
 <357a3098-918b-895b-7305-0f1a63aacdb0@xs4all.nl>
In-Reply-To: <357a3098-918b-895b-7305-0f1a63aacdb0@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 7 Nov 2022 15:20:36 +0800
Message-ID: <CADnNmFp4r-3+pvHa+_HOxcXAkORadMzgg6fFKbLcgs66a_90gw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drivers: media: platform: Add NPCM Video
 Capture/Encode Engine driver
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for the review.

>
> These functions are not usually present when capturing from video. You don't
> have a choice w.r.t. resolution and fps, since that's determined by the
> incoming video. I would drop support for this.

Just to confirm, do you mean `npcm_video_enum_framesizes` and
`npcm_video_enum_frameintervals` functions?


> > +     switch (ctrl->id) {
> > +     case V4L2_CID_DETECT_MD_MODE:
> > +             if (ctrl->val == V4L2_DETECT_MD_MODE_GLOBAL)
> > +                     video->ctrl_cmd = VCD_CMD_OPERATION_CAPTURE;
> > +             else
> > +                     video->ctrl_cmd = VCD_CMD_OPERATION_COMPARE;
> > +     break;
>
> Incorrect indentation for the 'break'.

Will correct it.


> > +     v4l2_ctrl_new_std_menu(&video->ctrl_handler, &npcm_video_ctrl_ops,
> > +                            V4L2_CID_DETECT_MD_MODE,
> > +                            V4L2_DETECT_MD_MODE_REGION_GRID, 0,
> > +                            V4L2_DETECT_MD_MODE_GLOBAL);
>
> Why is this driver using a control designed for motion detection devices?
> That seems odd, and it looks like you are abusing this control to do something
> else.

The Video Capture/Differentiation (VCD) engine supports two modes:
- COMPLETE (capture the next "complete frame" into memory)
- DIFF (compare the incoming frame with the frame stored in memory,
and updates the "diff frame" in memory)

The purpose here is to provide a way for application to switch the
COMPLETE/DIFF mode. Since I couldn't find an appropriate ioctl that is
designed for this purpose, so I used VIDIOC_S_CTRL with control values
of V4L2_DETECT_MD_MODE_GLOBAL (for COMPLETE) and
V4L2_DETECT_MD_MODE_REGION_GRID (for DIFF). It would be appreciated if
you could point me in the right direction.


> When you post v7, please also include the output of v4l2-compliance to the
> cover letter!
> Make sure you compile v4l2-compliance from the v4l-utils git repo, do not
> use a version from a distro, that will be too old.

OK, I'll try to compile v4l2-compliance and include the output.

Regards,
Marvin
