Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01B6DE3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDKSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDKSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:16:24 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63D6E9B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:15:54 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id y17so8141210vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1681236953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4S0xEvdunaSL+zbPuHJ5s3VFMKCKqJuiCI0S2OKaZQ=;
        b=UqGNkOJYNaelzGuQIlv0PKOFymJDD1+EaLAj9dZk28ZbmoJI+chXaQjStdXmChjrHG
         rTNJ4xExqR5SZTnqg6FKlEh2rhllsJNsbrX8XKCr2Pe/gQlkIc5sWErriUfEqhdpMHMj
         RadFlz2zYGU2zQQEeu9ZAmQCy01vtm/UfzcU6kqlMdRaFxvIO/5v2pJ29UyitdWHm5sY
         XcjrVFGv+Q3HhCLt0xM91jyuKoYcTAWsmN/juLA6s05mSvmsQaOouOqO5YfAlzYvqbda
         XUMslwuq9A5d3+JdRCi3AoqdF5qSjc8Tjnbmhny9bpOU6sUPBkInBDJNGBqtwx85bLHL
         QtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4S0xEvdunaSL+zbPuHJ5s3VFMKCKqJuiCI0S2OKaZQ=;
        b=tm0+MOm8KVfNIzEQTXv3lZEngj43GSNCRGwAERJnRRQ8utS0zPFLJdfB5+rejN0rnu
         9nFvEyr56HbQXUdxN19n8TkMhwWcDH8PdQ8eu1YLc5HPRi9YTl3P6yrdnMfskoUd7Kka
         LCiOOCN+fn9otNPf0oiebuGg6qWbJBUghPCC+PnKlVQ8596829VXLHwV5QoTMoH2+zmx
         r/BhEKMBr/74EQN3wd4G+TXZyrp2XP9BJGhc6fTcmGs4MNiy+ctBaI4OTbE+M84zhSSC
         daTcX7YchtP8r9FuX/4zhHQhooRF24JAVk/bN1Nd8gV4ZVu3l9T1Rpa2ARdwd/3eH4xQ
         C7Vw==
X-Gm-Message-State: AAQBX9e1/fdplLUlD6ezvBzjE+WpacLNZibqiHqXeCH5MyPPhoCIb7SV
        gStJbhXfj7C80utByw/YPIAhu92xsB+j8Rgo0aIEpPqi2eMZqC1QRtY=
X-Google-Smtp-Source: AKy350YNBQvST6HxVAb5F4t2LRcDW1VfpL6yfV+1u51w69zx3nOIujTSOtNcVdPDw5YP5EMOaDdFd+ZjNw35GyrADkw=
X-Received: by 2002:a67:d589:0:b0:42c:47fa:5b86 with SMTP id
 m9-20020a67d589000000b0042c47fa5b86mr6738867vsj.1.1681236953446; Tue, 11 Apr
 2023 11:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com> <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
In-Reply-To: <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 11 Apr 2023 19:15:37 +0100
Message-ID: <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On Tue, 11 Apr 2023 at 18:33, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Dave,
>
> On 4/6/23 17:16, Dave Stevenson wrote:
> > Hi Michael
> >
> > Thanks for the patch.
> >
> > I've got a personal interest here as I'd love to be able to control a
> > couple of CCTV lenses that I have. Those have standard motors with
> > potentiometers for position feedback, not stepper motors, but
> > otherwise have the same limitations of slow movement.
>
> That's great to hear :-) Thank you for your feedback!
>
> > On Thu, 6 Apr 2023 at 15:31, Michael Riesch via B4 Relay via
> > libcamera-devel <libcamera-devel@lists.libcamera.org> wrote:
> >>
> >> From: Michael Riesch <michael.riesch@wolfvision.net>
> >>
> >> Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
> >> the status of the zoom lens group and the focus lens group, respectively.
> >> The returned data structure contains the current position of the lens group
> >> as well as movement indication flags.
> >>
> >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> >> ---
> >>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
> >>  drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
> >>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
> >>  include/media/v4l2-ctrls.h                         |  2 +
> >>  include/uapi/linux/v4l2-controls.h                 | 13 ++++++
> >>  include/uapi/linux/videodev2.h                     |  2 +
> >>  6 files changed, 81 insertions(+)
> >>
> >> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> index daa4f40869f8..3a270bc63f1a 100644
> >> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
> >> @@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
> >>      to the camera, negative values towards infinity. This is a
> >>      write-only control.
> >>
> >> +``V4L2_CID_FOCUS_STATUS (struct)``
> >> +    The current status of the focus lens group. This is a read-only control.
> >> +    The returned data structure contains the current position and movement
> >> +    indication flags. The unit of the current position is undefined. Positive
> >> +    values move the focus closer to the camera, negative values towards
> >> +    infinity. The possible flags are described in the table below.
> >
> > The units are undefined, but positive and negative mean something with
> > respect to some unspecified focal distance represented by 0. That
> > seems a little odd.
> >
> > I was going to suggest that it seems to make sense to follow the same
> > units as V4L2_CID_FOCUS_ABSOLUTE, but on reading that description in
> > [1] it's the same text.
> > I suspect there was a little too much copy/paste from
> > V4L2_CID_FOCUS_RELATIVE, or the intent was that increasing the value
> > brings the focus closer, and decreasing moves it towards infinity.
> >
> > If we did specify that it was the same units as
> > V4L2_CID_FOCUS_ABSOLUTE, then what would that mean for use with
> > V4L2_CID_FOCUS_RELATIVE? Then again the only user of _RELATIVE appears
> > to be ov5693 with atomisp and that just maps it onto _ABSOLUTE, so
> > potentially it's redundant and could be deprecated.
> >
> > [1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/ext-ctrls-camera.html
>
> I think we agree that the _STATUS controls should use the same unit as
> the corresponding _ABSOLUTE control, whatever that may be.
>
> Then, the question is whether the description of FOCUS_ABSOLUTE needs to
> be revised. I would agree that the intention probably was: "Larger
> values move the focus closer to the camera, smaller values move the
> focus to infinity." (cf. the phrasing in the description of IRIS_ABSOLUTE).
>
> It would be interesting to know whether zero and negative values are
> (intentionally?) included. Since they are not explicitly excluded, my
> driver exposes the position of the lens in motor steps to the user
> space. If the values were (supposed to be) restricted to positive values
> like ZOOM_ABSOLUTE, this would not be allowed of course.
>
> As to the relation to _RELATIVE, I think it should be clear that all
> controls should act on the same scale and I don't see any problems here.
> However, feel free to point out what I am missing :-)
>
> >> +
> >> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> >> +
> >> +.. flat-table::
> >> +    :header-rows:  0
> >> +    :stub-columns: 0
> >> +
> >> +    * - ``V4L2_LENS_STATUS_IDLE``
> >> +      - Focus lens group is at rest.
> >> +    * - ``V4L2_LENS_STATUS_BUSY``
> >> +      - Focus lens group is moving.
> >> +    * - ``V4L2_LENS_STATUS_REACHED``
> >> +      - Focus lens group has reached its target position.
> >> +    * - ``V4L2_LENS_STATUS_FAILED``
> >> +      - Focus lens group has failed to reach its target position. The driver
> >> +       will not transition from this state until another action is performed
> >> +       by an application.
> >
> > When would the lens state transition from V4L2_LENS_STATUS_REACHED to
> > V4L2_LENS_STATUS_IDLE?
> > If it's reached the position then it is at rest, and being at rest is
> > the definition of V4L2_LENS_STATUS_IDLE.
> > Likewise the lens always has a target position based on the control
> > value, so it's always at V4L2_LENS_STATUS_REACHED when it's not
> > moving.
> > Is there a need to have 2 states?
>
> Good point, I need to reconsider that (and possibly remove one of those
> states).
>
> > If the position is the same units as V4L2_CID_FOCUS_ABSOLUTE, then do
> > you leave the determination of state to the application?
>
> I am afraid I don't quite follow.

If the application sets V4L2_CID_FOCUS_ABSOLUTE to 42, and
V4L2_CID_FOCUS_STATUS returns that the position is now 42, then the
application knows that the lens has reached the requested position. If
the two controls return different values then the lens is still
moving.
What new information does adding an additional status flag give you?

(Thinking aloud) I guess you have got my case where your readback is
via an ADC so that the position may fluctuate slightly due to
conversion noise. The control loop for applying power to the motors
will presumably stop at some point and stop trying to adjust the
position, so potentially it could be the state returned from that
control loop. However the noisy ADC position could also be solved by
the position being returned by the control loop instead of giving the
raw value.

> But FWIW the application should read out the flags to find out whether
> the lens is moving and, if this is not the case, whether the last move
> command (FOCUS_ABSOLUTE or FOCUS_RELATIVE) has succeeded or failed. The
> failed state is important as there might be the possibility that
> depending on the zoom lens position certain focus positions are not
> available (and vice versa).

How would you configure those kinds of restrictions in the kernel
driver? Is the kernel driver the best place to do it (so many things
are being kicked back to userspace these days)?
If it is to be done in the kernel, then shouldn't eg changing the zoom
position alter the ranges advertised for the relevant focus controls?
If the ranges aren't updated, where should that out-of-range lens
movement leave the lens?

  Dave

> >>  ``V4L2_CID_FOCUS_AUTO (boolean)``
> >>      Enables continuous automatic focus adjustments. The effect of manual
> >>      focus adjustments while this feature is enabled is undefined,
> >> @@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
> >>      movement. A negative value moves the zoom lens group towards the
> >>      wide-angle direction. The zoom speed unit is driver-specific.
> >>
> >> +``V4L2_CID_ZOOM_STATUS (struct)``
> >> +    The current status of the zoom lens group. This is a read-only control.
> >> +    The returned data structure contains the current position and movement
> >> +    indication flags. The unit of the current position is driver-specific and
> >> +    its value should be a positive integer. The possible flags are described
> >> +    in the table below.
> >> +
> >> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
> >> +
> >> +.. flat-table::
> >> +    :header-rows:  0
> >> +    :stub-columns: 0
> >> +
> >> +    * - ``V4L2_LENS_STATUS_IDLE``
> >> +      - Zoom lens group is at rest.
> >> +    * - ``V4L2_LENS_STATUS_BUSY``
> >> +      - Zoom lens group is moving.
> >> +    * - ``V4L2_LENS_STATUS_REACHED``
> >> +      - Zoom lens group has reached its target position.
> >> +    * - ``V4L2_LENS_STATUS_FAILED``
> >> +      - Zoom lens group has failed to reach its target position. The driver will
> >> +       not transition from this state until another action is performed by an
> >> +       application.
> >> +
> >>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
> >>      This control sets the camera's aperture to the specified value. The
> >>      unit is undefined. Larger values open the iris wider, smaller values
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> index 29169170880a..f6ad30f311c5 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> >> @@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
> >>         case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
> >>                 pr_cont("HEVC_DECODE_PARAMS");
> >>                 break;
> >> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >> +               pr_cont("LENS_STATUS");
> >> +               break;
> >>         default:
> >>                 pr_cont("unknown type %d", ctrl->type);
> >>                 break;
> >> @@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
> >>                         return -EINVAL;
> >>                 break;
> >>
> >> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >> +               break;
> >> +
> >>         default:
> >>                 return -EINVAL;
> >>         }
> >> @@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
> >>         case V4L2_CTRL_TYPE_AREA:
> >>                 elem_size = sizeof(struct v4l2_area);
> >>                 break;
> >> +       case V4L2_CTRL_TYPE_LENS_STATUS:
> >> +               elem_size = sizeof(struct v4l2_ctrl_lens_status);
> >> +               break;
> >>         default:
> >>                 if (type < V4L2_CTRL_COMPOUND_TYPES)
> >>                         elem_size = sizeof(s32);
> >> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> index 564fedee2c88..9b26a3aa9e9c 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >> @@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>         case V4L2_CID_CAMERA_ORIENTATION:       return "Camera Orientation";
> >>         case V4L2_CID_CAMERA_SENSOR_ROTATION:   return "Camera Sensor Rotation";
> >>         case V4L2_CID_HDR_SENSOR_MODE:          return "HDR Sensor Mode";
> >> +       case V4L2_CID_FOCUS_STATUS:             return "Focus, Status";
> >> +       case V4L2_CID_ZOOM_STATUS:              return "Zoom, Status";
> >
> > Is there a need for the comma in the text strings?
>
> Not sure, actually. Some other strings used commas. Monkey see, monkey do.
>
> Best regards,
> Michael
>
> >
> > Cheers
> >   Dave
> >
> >>
> >>         /* FM Radio Modulator controls */
> >>         /* Keep the order of the 'case's the same as in v4l2-controls.h! */
> >> @@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
> >>                 *flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
> >>                           V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
> >>                 break;
> >> +       case V4L2_CID_FOCUS_STATUS:
> >> +       case V4L2_CID_ZOOM_STATUS:
> >> +               *type = V4L2_CTRL_TYPE_LENS_STATUS;
> >> +               *flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
> >> +               break;
> >>         case V4L2_CID_FLASH_STROBE_STATUS:
> >>         case V4L2_CID_AUTO_FOCUS_STATUS:
> >>         case V4L2_CID_FLASH_READY:
> >> diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
> >> index e59d9a234631..f7273ffc20c9 100644
> >> --- a/include/media/v4l2-ctrls.h
> >> +++ b/include/media/v4l2-ctrls.h
> >> @@ -52,6 +52,7 @@ struct video_device;
> >>   * @p_hdr10_cll:               Pointer to an HDR10 Content Light Level structure.
> >>   * @p_hdr10_mastering:         Pointer to an HDR10 Mastering Display structure.
> >>   * @p_area:                    Pointer to an area.
> >> + * @p_lens_status:             Pointer to a lens status structure.
> >>   * @p:                         Pointer to a compound value.
> >>   * @p_const:                   Pointer to a constant compound value.
> >>   */
> >> @@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
> >>         struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
> >>         struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
> >>         struct v4l2_area *p_area;
> >> +       struct v4l2_ctrl_lens_status *p_lens_status;
> >>         void *p;
> >>         const void *p_const;
> >>  };
> >> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> >> index 5e80daa4ffe0..8b037467ba9a 100644
> >> --- a/include/uapi/linux/v4l2-controls.h
> >> +++ b/include/uapi/linux/v4l2-controls.h
> >> @@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
> >>
> >>  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_BASE+36)
> >>
> >> +struct v4l2_ctrl_lens_status {
> >> +       __u32 flags;
> >> +       __s32 current_position;
> >> +};
> >> +
> >> +#define V4L2_LENS_STATUS_IDLE                  (0 << 0)
> >> +#define V4L2_LENS_STATUS_BUSY                  (1 << 0)
> >> +#define V4L2_LENS_STATUS_REACHED               (1 << 1)
> >> +#define V4L2_LENS_STATUS_FAILED                        (1 << 2)
> >> +
> >> +#define V4L2_CID_FOCUS_STATUS                  (V4L2_CID_CAMERA_CLASS_BASE + 37)
> >> +#define V4L2_CID_ZOOM_STATUS                   (V4L2_CID_CAMERA_CLASS_BASE + 38)
> >> +
> >>  /* FM Modulator class control IDs */
> >>
> >>  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX | 0x900)
> >> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> >> index 17a9b975177a..256c21c68720 100644
> >> --- a/include/uapi/linux/videodev2.h
> >> +++ b/include/uapi/linux/videodev2.h
> >> @@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
> >>         V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS        = 0x0272,
> >>         V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX      = 0x0273,
> >>         V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS       = 0x0274,
> >> +
> >> +       V4L2_CTRL_TYPE_LENS_STATUS              = 0x0300,
> >>  };
> >>
> >>  /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
> >>
> >> --
> >> 2.30.2
> >>
