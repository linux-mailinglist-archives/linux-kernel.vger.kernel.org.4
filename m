Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8546B6DF7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDLN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjDLN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:56:26 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BC9038
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:56:15 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id t20so20975261uaw.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1681307775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V76eATIt34s3wc/nCwEAYWCHGgwXGLQ0Gsjr/w1FnI8=;
        b=RzHp4YkuO2e1biK5DgN/RdrA+lFmREwYNZkInmcVOXoW5fRWoN4/vlTnpTW6nslhKy
         mTaXaOVU1jR0fylElzo9PRAWl2vsjSv3JsNkg9E1uJxnKuEV0QZ45nSjC8TKu9VxJERu
         q1uI7UfpUz6doBOgcidWXycwVXBuXNDS15s7rOJjT5H2nHBEoHyBE0E4oZJvUrbl0osh
         QoYr9qVN82DqDzegPyi3muEbYHGPPbYyfLh2zKfHKSPw+cVc8ecXockb75SfaP+GQ0E/
         YbCjzHf0dXwIXQfwBS9DBQujC/Xy9uGaeRN6Lfk75WNFmaXUnSoKfnwDpSAgcP3MCfPG
         1Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V76eATIt34s3wc/nCwEAYWCHGgwXGLQ0Gsjr/w1FnI8=;
        b=MdDXce2zyOXmdfUgTKziNFuqbQ975w9Iz4EX3XKyU05anK9qPcVzGhJxAUNuNdu0qx
         mkBrboP5H5Jgr2MFHsE3S9GO077zlV3MFw6OinK98CpjsWxpmhtEKQqtOiclNf57ufoF
         vON/SSD1rtXsUOllf4qc0wSFUTa5cNReEgQuMpdIOyf3/Fwb42PwJ2gUGbcxMTG6GpYJ
         xD9sOO2oGfZhqXCqrI0gTmFLU9NxmtkCThElw/5tcDbqU978v/FnB1ZCpcX1bPv7cSl2
         0I6NgLhfKscfObwEBoNqZa1DVGuLS1Y0KwaWy6CbVd/v7f5mGOFITW3VD3ueMvXUB8R3
         4TIw==
X-Gm-Message-State: AAQBX9cfp+n9ER0gUubnPL4uSc3XctuSevDZmHxwWXS1kK60mg760qnL
        mreTWyf9NJ0dbameNCTzYRimMZ7ew9QeSKwPrr2l0A==
X-Google-Smtp-Source: AKy350YmflJyx577Hsj3epdx3z96RtWf1ldjX4nI/S+2Qo57dIQslwLCIb1E7ajs02CiaafuO+NmxqlXqOG/kY92i/I=
X-Received: by 2002:a1f:b607:0:b0:43f:b0aa:62a9 with SMTP id
 g7-20020a1fb607000000b0043fb0aa62a9mr1351422vkf.1.1681307773455; Wed, 12 Apr
 2023 06:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net> <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
In-Reply-To: <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 12 Apr 2023 14:55:56 +0100
Message-ID: <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On Wed, 12 Apr 2023 at 09:00, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Dave,
>
> On 4/11/23 20:15, Dave Stevenson wrote:
> > Hi Michael
> >
> > On Tue, 11 Apr 2023 at 18:33, Michael Riesch
> > <michael.riesch@wolfvision.net> wrote:
> >>
> >> Hi Dave,
> >>
> >> On 4/6/23 17:16, Dave Stevenson wrote:
> >>> Hi Michael
> >>>
> >>> Thanks for the patch.
> >>>
> >>> I've got a personal interest here as I'd love to be able to control a
> >>> couple of CCTV lenses that I have. Those have standard motors with
> >>> potentiometers for position feedback, not stepper motors, but
> >>> otherwise have the same limitations of slow movement.
> >>
> >> That's great to hear :-) Thank you for your feedback!
> >>
> >>> On Thu, 6 Apr 2023 at 15:31, Michael Riesch via B4 Relay via
> >>> libcamera-devel <libcamera-devel@lists.libcamera.org> wrote:
> >>>>
> >>>> From: Michael Riesch <michael.riesch@wolfvision.net>
> >>>>
> >>>> Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
> >>>> the status of the zoom lens group and the focus lens group, respectively.
> >>>> The returned data structure contains the current position of the lens group
> >>>> as well as movement indication flags.
> >>>>
> >>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >>>> ---
> >>>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
> >>>>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
> >>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
> >>>>  include/media/v4l2-ctrls.h                         |  2 +
> >>>>  include/uapi/linux/v4l2-controls.h                 | 13 ++++++
> >>>>  include/uapi/linux/videodev2.h                     |  2 +
> >>>>  6 files changed, 81 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >>>> index daa4f40869f8..3a270bc63f1a 100644
> >>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >>>> @@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
> >>>>      to the camera, negative values towards infinity. This is a
> >>>>      write-only control.
> >>>>
> >>>> +``V4L2_CID_FOCUS_STATUS (struct)``
> >>>> +    The current status of the focus lens group. This is a read-only control.
> >>>> +    The returned data structure contains the current position and movement
> >>>> +    indication flags. The unit of the current position is undefined. Positive
> >>>> +    values move the focus closer to the camera, negative values towards
> >>>> +    infinity. The possible flags are described in the table below.
> >>>
> >>> The units are undefined, but positive and negative mean something with
> >>> respect to some unspecified focal distance represented by 0. That
> >>> seems a little odd.
> >>>
> >>> I was going to suggest that it seems to make sense to follow the same
> >>> units as V4L2_CID_FOCUS_ABSOLUTE, but on reading that description in
> >>> [1] it's the same text.
> >>> I suspect there was a little too much copy/paste from
> >>> V4L2_CID_FOCUS_RELATIVE, or the intent was that increasing the value
> >>> brings the focus closer, and decreasing moves it towards infinity.
> >>>
> >>> If we did specify that it was the same units as
> >>> V4L2_CID_FOCUS_ABSOLUTE, then what would that mean for use with
> >>> V4L2_CID_FOCUS_RELATIVE? Then again the only user of _RELATIVE appears
> >>> to be ov5693 with atomisp and that just maps it onto _ABSOLUTE, so
> >>> potentially it's redundant and could be deprecated.
> >>>
> >>> [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-camera.html
> >>
> >> I think we agree that the _STATUS controls should use the same unit as
> >> the corresponding _ABSOLUTE control, whatever that may be.
> >>
> >> Then, the question is whether the description of FOCUS_ABSOLUTE needs to
> >> be revised. I would agree that the intention probably was: "Larger
> >> values move the focus closer to the camera, smaller values move the
> >> focus to infinity." (cf. the phrasing in the description of IRIS_ABSOLUTE).
> >>
> >> It would be interesting to know whether zero and negative values are
> >> (intentionally?) included. Since they are not explicitly excluded, my
> >> driver exposes the position of the lens in motor steps to the user
> >> space. If the values were (supposed to be) restricted to positive values
> >> like ZOOM_ABSOLUTE, this would not be allowed of course.
> >>
> >> As to the relation to _RELATIVE, I think it should be clear that all
> >> controls should act on the same scale and I don't see any problems here.
> >> However, feel free to point out what I am missing :-)
> >>
> >>>> +
> >>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> >>>> +
> >>>> +.. flat-table::
> >>>> +    :header-rows:  0
> >>>> +    :stub-columns: 0
> >>>> +
> >>>> +    * - ``V4L2_LENS_STATUS_IDLE``
> >>>> +      - Focus lens group is at rest.
> >>>> +    * - ``V4L2_LENS_STATUS_BUSY``
> >>>> +      - Focus lens group is moving.
> >>>> +    * - ``V4L2_LENS_STATUS_REACHED``
> >>>> +      - Focus lens group has reached its target position.
> >>>> +    * - ``V4L2_LENS_STATUS_FAILED``
> >>>> +      - Focus lens group has failed to reach its target position. The driver
> >>>> +       will not transition from this state until another action is performed
> >>>> +       by an application.
> >>>
> >>> When would the lens state transition from V4L2_LENS_STATUS_REACHED to
> >>> V4L2_LENS_STATUS_IDLE?
> >>> If it's reached the position then it is at rest, and being at rest is
> >>> the definition of V4L2_LENS_STATUS_IDLE.
> >>> Likewise the lens always has a target position based on the control
> >>> value, so it's always at V4L2_LENS_STATUS_REACHED when it's not
> >>> moving.
> >>> Is there a need to have 2 states?
> >>
> >> Good point, I need to reconsider that (and possibly remove one of those
> >> states).
> >>
> >>> If the position is the same units as V4L2_CID_FOCUS_ABSOLUTE, then do
> >>> you leave the determination of state to the application?
> >>
> >> I am afraid I don't quite follow.
> >
> > If the application sets V4L2_CID_FOCUS_ABSOLUTE to 42, and
> > V4L2_CID_FOCUS_STATUS returns that the position is now 42, then the
> > application knows that the lens has reached the requested position. If
> > the two controls return different values then the lens is still
> > moving.
> > What new information does adding an additional status flag give you?
>
> I can think of two situations:
>
>  - Hardware error: the lens stops at 40 (for whatever reason). Since 40
>    != 42 the lens is still moving, although a hardware error has occured
>    that may need recovery or at least reporting.

Are you thinking of the lens drive having totally failed, or just that
the requested position is out of the achievable range?

Looking at the flash controls[1], hardware failures are handled by
V4L2_CID_FLASH_FAULT as a separate control.

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-flash.html

>  - Different controls: If moving = (V4L2_CID_FOCUS_ABSOLUTE == current),
>    then what happens if the application performs a
>    V4L2_CID_FOCUS_RELATIVE with -3? current should reach 39,
>    V4L2_CID_FOCUS_ABSOLUTE is still at 42, the lens is still moving from
>    the application's point of view.

V4L2_CID_FOCUS_RELATIVE really ought to die IMHO, or at least work in
co-operation with V4L2_CID_FOCUS_ABSOLUTE such that the absolute
current position can always be retrieved.

Using _RELATIVE to set a position that is outside of the range defined
by _ABSOLUTE is meaningless. Any call to S_CTRL on _RELATIVE almost
has to be followed by a call to G_CTRL _ABSOLUTE to know the final
result, so why not just make a S_CTRL _ABSOLUTE call in the first
place.

I guess _RELATIVE may have uses in the case where there is no
read-back of the position at all, but in that case I don't see a way
that your new controls could be implemented.

> Don't get me wrong, a simple control that reports the current position
> would be way easier. But I feel that we may regret this in the future.
> Also, I would not use two separate controls "current" and "flags/status"
> in order to avoid non-atomic access patterns.

I have no fixed views, but overcomplicating things is generally bad news.

> > (Thinking aloud) I guess you have got my case where your readback is
> > via an ADC so that the position may fluctuate slightly due to
> > conversion noise. The control loop for applying power to the motors
> > will presumably stop at some point and stop trying to adjust the
> > position, so potentially it could be the state returned from that
> > control loop. However the noisy ADC position could also be solved by
> > the position being returned by the control loop instead of giving the
> > raw value.
>
> With stepper motors the readback is not that noisy, but in any case the
> flags field allows an underlying controller to signal certain conditions
> without relying on the exact value of the current position. I think that
> is a plus, especially for noisy readback.
>
> >> But FWIW the application should read out the flags to find out whether
> >> the lens is moving and, if this is not the case, whether the last move
> >> command (FOCUS_ABSOLUTE or FOCUS_RELATIVE) has succeeded or failed. The
> >> failed state is important as there might be the possibility that
> >> depending on the zoom lens position certain focus positions are not
> >> available (and vice versa).
> >
> > How would you configure those kinds of restrictions in the kernel
> > driver? Is the kernel driver the best place to do it (so many things
> > are being kicked back to userspace these days)?
>
> In our case we have a hardware controller that needs to handle the
> restrictions anyway in order to avoid mechanical damage. The kernel
> driver is only responsible for reading out the controller status and
> transforming it into the V4L2 control.

How does userspace know what the valid ranges are? Do you end up with
the same restrictions having to be coded in both your controller and
userspace, or are you relying on the driver reporting back this error
status with userspace not knowing by how much it got it wrong by?

> I am not sure how any restrictions can be reliably handled in software,
> hence I don't have a strong opinion on whether this is done in kernel or
> user space.
>
> > If it is to be done in the kernel, then shouldn't eg changing the zoom
> > position alter the ranges advertised for the relevant focus controls?
>
> While it should be possible to update the minimum and maximum of e.g.,
> FOCUS_ABSOLUTE, I am not sure whether the interface is designed for
> frequent re-reading of the range.

There's nothing in there that stops you, and several hooks to help you.
Updating V4L2_CID_VBLANK on most raw sensors will update the range on
V4L2_CID_EXPOSURE, as the exposure period can't be longer than the
frame period. It would be similar that each change to ZOOM_ABSOLUTE
would result in a range adjustment to FOCUS_ABSOLUTE.
Userspace can also use VIDIOC_SUBSCRIBE_EVENT to subscribe to any
updates in controls, so it gets told automatically of any updates.

> > If the ranges aren't updated, where should that out-of-range lens
> > movement leave the lens?
>
> This is up to the hardware controller, but I would guess it typically
> stops one step before disaster. Wherever that may be, the error
> condition and the current position can be read out via this new STATUS
> control.
>
> Does this sound good so far?

Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
Laurent), and I'm just expressing my views based on the lenses I've
encountered.
All of my lenses have a single drive for focus, a single drive for
zoom, and where there are multiple elements they are all connected
mechanically. Your setup sounds far more complex and is likely to need
a more extensive driver, but it'd be nice to not unnecessarily
overcomplicate the interface.

  Dave

> Best regards,
> Michael
>
> >
> >   Dave
> >
> >>>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
> >>>>      Enables continuous automatic focus adjustments. The effect of manual
> >>>>      focus adjustments while this feature is enabled is undefined,
> >>>> @@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
> >>>>      movement. A negative value moves the zoom lens group towards the
> >>>>      wide-angle direction. The zoom speed unit is driver-specific.
> >>>>
> >>>> +``V4L2_CID_ZOOM_STATUS (struct)``
> >>>> +    The current status of the zoom lens group. This is a read-only control.
> >>>> +    The returned data structure contains the current position and movement
> >>>> +    indication flags. The unit of the current position is driver-specific and
> >>>> +    its value should be a positive integer. The possible flags are described
> >>>> +    in the table below.
> >>>> +
> >>>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> >>>> +
> >>>> +.. flat-table::
> >>>> +    :header-rows:  0
> >>>> +    :stub-columns: 0
> >>>> +
> >>>> +    * - ``V4L2_LENS_STATUS_IDLE``
> >>>> +      - Zoom lens group is at rest.
> >>>> +    * - ``V4L2_LENS_STATUS_BUSY``
> >>>> +      - Zoom lens group is moving.
> >>>> +    * - ``V4L2_LENS_STATUS_REACHED``
> >>>> +      - Zoom lens group has reached its target position.
> >>>> +    * - ``V4L2_LENS_STATUS_FAILED``
> >>>> +      - Zoom lens group has failed to reach its target position. The driver will
> >>>> +       not transition from this state until another action is performed by an
> >>>> +       application.
> >>>> +
> >>>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
> >>>>      This control sets the camera's aperture to the specified value. The
> >>>>      unit is undefined. Larger values open the iris wider, smaller values
> >>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >>>> index 29169170880a..f6ad30f311c5 100644
> >>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >>>> @@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
> >>>>         case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
> >>>>                 pr_cont("HEVC_DECODE_PARAMS");
> >>>>                 break;
> >>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >>>> +               pr_cont("LENS_STATUS");
> >>>> +               break;
> >>>>         default:
> >>>>                 pr_cont("unknown type %d", ctrl->type);
> >>>>                 break;
> >>>> @@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
> >>>>                         return -EINVAL;
> >>>>                 break;
> >>>>
> >>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >>>> +               break;
> >>>> +
> >>>>         default:
> >>>>                 return -EINVAL;
> >>>>         }
> >>>> @@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
> >>>>         case V4L2_CTRL_TYPE_AREA:
> >>>>                 elem_size = sizeof(struct v4l2_area);
> >>>>                 break;
> >>>> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >>>> +               elem_size = sizeof(struct v4l2_ctrl_lens_status);
> >>>> +               break;
> >>>>         default:
> >>>>                 if (type < V4L2_CTRL_COMPOUND_TYPES)
> >>>>                         elem_size = sizeof(s32);
> >>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> index 564fedee2c88..9b26a3aa9e9c 100644
> >>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> @@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>         case V4L2_CID_CAMERA_ORIENTATION:       return "Camera Orientation";
> >>>>         case V4L2_CID_CAMERA_SENSOR_ROTATION:   return "Camera Sensor Rotation";
> >>>>         case V4L2_CID_HDR_SENSOR_MODE:          return "HDR Sensor Mode";
> >>>> +       case V4L2_CID_FOCUS_STATUS:             return "Focus, Status";
> >>>> +       case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
> >>>
> >>> Is there a need for the comma in the text strings?
> >>
> >> Not sure, actually. Some other strings used commas. Monkey see, monkey do.
> >>
> >> Best regards,
> >> Michael
> >>
> >>>
> >>> Cheers
> >>>   Dave
> >>>
> >>>>
> >>>>         /* FM Radio Modulator controls */
> >>>>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
> >>>> @@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
> >>>>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
> >>>>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
> >>>>                 break;
> >>>> +       case V4L2_CID_FOCUS_STATUS:
> >>>> +       case V4L2_CID_ZOOM_STATUS:
> >>>> +               *type = V4L2_CTRL_TYPE_LENS_STATUS;
> >>>> +               *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
> >>>> +               break;
> >>>>         case V4L2_CID_FLASH_STROBE_STATUS:
> >>>>         case V4L2_CID_AUTO_FOCUS_STATUS:
> >>>>         case V4L2_CID_FLASH_READY:
> >>>> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> >>>> index e59d9a234631..f7273ffc20c9 100644
> >>>> --- a/include/media/v4l2-ctrls.h
> >>>> +++ b/include/media/v4l2-ctrls.h
> >>>> @@ -52,6 +52,7 @@ struct video_device;
> >>>>   * @p_hdr10_cll:               Pointer to an HDR10 Content Light Level structure.
> >>>>   * @p_hdr10_mastering:         Pointer to an HDR10 Mastering Display structure.
> >>>>   * @p_area:                    Pointer to an area.
> >>>> + * @p_lens_status:             Pointer to a lens status structure.
> >>>>   * @p:                         Pointer to a compound value.
> >>>>   * @p_const:                   Pointer to a constant compound value.
> >>>>   */
> >>>> @@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
> >>>>         struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
> >>>>         struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
> >>>>         struct v4l2_area *p_area;
> >>>> +       struct v4l2_ctrl_lens_status *p_lens_status;
> >>>>         void *p;
> >>>>         const void *p_const;
> >>>>  };
> >>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> >>>> index 5e80daa4ffe0..8b037467ba9a 100644
> >>>> --- a/include/uapi/linux/v4l2-controls.h
> >>>> +++ b/include/uapi/linux/v4l2-controls.h
> >>>> @@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
> >>>>
> >>>>  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_BASE+36)
> >>>>
> >>>> +struct v4l2_ctrl_lens_status {
> >>>> +       __u32 flags;
> >>>> +       __s32 current_position;
> >>>> +};
> >>>> +
> >>>> +#define V4L2_LENS_STATUS_IDLE                  (0 << 0)
> >>>> +#define V4L2_LENS_STATUS_BUSY                  (1 << 0)
> >>>> +#define V4L2_LENS_STATUS_REACHED               (1 << 1)
> >>>> +#define V4L2_LENS_STATUS_FAILED                        (1 << 2)
> >>>> +
> >>>> +#define V4L2_CID_FOCUS_STATUS                  (V4L2_CID_CAMERA_CLASS_BASE + 37)
> >>>> +#define V4L2_CID_ZOOM_STATUS                   (V4L2_CID_CAMERA_CLASS_BASE + 38)
> >>>> +
> >>>>  /* FM Modulator class control IDs */
> >>>>
> >>>>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
> >>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> >>>> index 17a9b975177a..256c21c68720 100644
> >>>> --- a/include/uapi/linux/videodev2.h
> >>>> +++ b/include/uapi/linux/videodev2.h
> >>>> @@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
> >>>>         V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS        = 0x0272,
> >>>>         V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX      = 0x0273,
> >>>>         V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS       = 0x0274,
> >>>> +
> >>>> +       V4L2_CTRL_TYPE_LENS_STATUS              = 0x0300,
> >>>>  };
> >>>>
> >>>>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
> >>>>
> >>>> --
> >>>> 2.30.2
> >>>>
