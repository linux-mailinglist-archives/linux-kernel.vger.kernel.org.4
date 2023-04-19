Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AAC6E79F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjDSMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDSMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:49:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F933C15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:49:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id m65so2911064vsm.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1681908574; x=1684500574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w9ZPopfYb851oejNmrAcF7O0IByv+Fq2MPAPsJJ/DqQ=;
        b=RT7+HX3qWB3xYcDjZFMsz6lztVqMmovaSB2+eFCV8Nzl5nAQ1Vz585FD3QMl/Sw+ZV
         dcR5RKk8OjDOYIuYxqEeZgMZRPACYkBFCvQoPfsU3pFNTc3LzpB6owfYwVaZS5Ar/bL7
         mHtOK4e0H7uv8Ys6coMENmrNr66T3gNbMes97xmdbau/bPANiVaiB1YgyWlYmi+EfSzf
         gDwwqLXdcQKpcSeeEk87vAPVfqi9La6sic8Oubx5NR7ItiddnTO/rN5MgXZJMhOopnLY
         v4cGnN91EtXKuUuxRUQvDl1qtieuvgbEXnidmfe2j5DCiZXH8gANBZhwBXZaBhhLap9p
         lxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908574; x=1684500574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9ZPopfYb851oejNmrAcF7O0IByv+Fq2MPAPsJJ/DqQ=;
        b=TowQJT46mGw4Rkyf79LVePce+yCEacqR4sRN0b82rLhHnljpTSd2zCEX1BJbdum3VB
         8t2XeSB1stkL0QJ9aJepF1gFTOtIokdzAfqm7N0OwyWPjkWtVKHn7uEp/a5I58+3kSFn
         2ubEytUedZv5NOoAo6MHgQXoDFCo3TcFk14M3o845u/1/f/TH4C80as9WANUWuSjZwGo
         WTWBcnYvH47l+CLu/lc0EJKHKEflA1HqY9rHQtG1Jr0XPy7eO6pjf/O0iaTwa/6I7kqn
         BWWNWJQtJvCfxDbaf2wISJgpHoeL8P1qEHHAfjUkMBbAEOV6Dz3aJjpIBmqByyF1IvHb
         ksKQ==
X-Gm-Message-State: AAQBX9e+JuUnf9d7aZdokYqWPe2k9X3wPpAPUwo3kvfmmnhZpKOURSKo
        +ZJUeq6SjjnxUiQ2XXGvWi6u+WLB1iAFhJ1EHDtUCg==
X-Google-Smtp-Source: AKy350aq1mhGLE4hoHadZ/gc4EutmzjUTgZamR0AicY3syq8d/SzTnWNCtDlNqSDaz2Uiq3lekb/FJ6jmGHzVvJ+dLg=
X-Received: by 2002:a05:6102:3003:b0:42f:e8d9:989 with SMTP id
 s3-20020a056102300300b0042fe8d90989mr4668084vsa.14.1681908573976; Wed, 19 Apr
 2023 05:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
 <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
 <CAPY8ntArOOqPQzvkJrQEyuVFfb6j8x6WODTMHOn1qHPU588mbQ@mail.gmail.com>
 <0f1baf5e-2ff6-e10b-5c3e-0a82c71d0ce6@wolfvision.net> <CAPY8ntAjBEFfeV6nnQs34Y22QM-irT13ALDv4ksP8AYK=jWsKg@mail.gmail.com>
 <3ab7bfc4-aaae-2e39-b420-40ad8d71dda4@wolfvision.net> <CAPY8ntCNuvgmF37kDvVh1kuepbLqy2hWcz9HOi8iub9trHmi2g@mail.gmail.com>
 <ZDbKU5kwcb7RGeCo@kekkonen.localdomain> <ccae3994-3b1b-4050-ea34-98f97cf886e0@wolfvision.net>
 <ZD+t5QYH20Y8+8MV@kekkonen.localdomain> <45fea085-54c3-157e-6459-adaaf1edebf5@wolfvision.net>
In-Reply-To: <45fea085-54c3-157e-6459-adaaf1edebf5@wolfvision.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 19 Apr 2023 13:49:18 +0100
Message-ID: <CAPY8ntAYiCVM7gr2pU12CEDtRfTZOVYn0t-CPD7FA9DDq+mz4w@mail.gmail.com>
Subject: Re: [libcamera-devel] [PATCH RFC 1/4] media: v4l2-ctrls: add lens
 group status controls for zoom and focus
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Brotzge <Alexander.Brotzge@wolfvision.net>,
        Dieter Mathis <Dieter.Mathis@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

On Wed, 19 Apr 2023 at 12:25, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Sakari,
>
> On 4/19/23 11:01, Sakari Ailus wrote:
> > Hi Michael,
> >
> > On Mon, Apr 17, 2023 at 02:38:20PM +0200, Michael Riesch wrote:
> >> Hi Sakari,
> >>
> >> On 4/12/23 17:12, Sakari Ailus wrote:
> >>> Hi Dave, Michael,
> >>>
> >>> On Wed, Apr 12, 2023 at 02:55:56PM +0100, Dave Stevenson wrote:
> >>>>>> If the ranges aren't updated, where should that out-of-range lens
> >>>>>> movement leave the lens?
> >>>>>
> >>>>> This is up to the hardware controller, but I would guess it typically
> >>>>> stops one step before disaster. Wherever that may be, the error
> >>>>> condition and the current position can be read out via this new STATUS
> >>>>> control.
> >>>>>
> >>>>> Does this sound good so far?
> >>>>
> >>>> Sounds reasonable, but I'm not the gatekeeper (that would be Sakari or
> >>>> Laurent), and I'm just expressing my views based on the lenses I've
> >>>> encountered.
> >>>> All of my lenses have a single drive for focus, a single drive for
> >>>> zoom, and where there are multiple elements they are all connected
> >>>> mechanically. Your setup sounds far more complex and is likely to need
> >>>> a more extensive driver, but it'd be nice to not unnecessarily
> >>>> overcomplicate the interface.
> >>>
> >>> Could we also have a driver that uses these new controls?
> >>
> >> If you are referring to the driver for our custom lens controller, then
> >> I have to say that it is under development and simply not ready for
> >> release yet. Also, the decision has not yet been made whether or not
> >> this will be an open-source driver.
> >>
> >> A different approach could be the adaptation of the vimc-lens driver,
> >> which currently only supports FOCUS_ABSOLUTE. But this would raise
> >> several implementation questions and at least for me this would be a
> >> nontrivial task.
> >>
> >> Is it required to have a driver for this interface (in the sense that
> >> the patches cannot be accepted otherwise)?
> >
> > That has been traditionally required, and a virtual driver isn't usually
> > considered enough. There are at least two reasons for this. The first one
> > being that if the driver isn't reviewable and targetting upstream it may be
> > difficult to figure out whether the interface changes are the right ones
> > for that driver. This is perhaps a lesser concern here. Secondly, there is
> > also unwillingness to add interface elements that might never be supported
> > by the kernel itself --- this is effectively just dead code.
> >
> > Also cc Hans and Laurent.
>
> I understand your concerns. Cc: Alexander and Dieter
>
> We aim to be an open-source friendly company. If you are OK with us
> submitting a driver that targets very custom hardware that is only
> available in integrated form in our products (and not, for instance,
> available for sale as a standalone device), then we are prepared to
> submit the driver sources for consideration for inclusion in mainline
> Linux. Would this be acceptable?

My plan with the motor drive is far simpler with a Pi RP2040
microcontroller on I2C running an ADC for the potentiometers, PWM for
motor control, and a PID loop driving it. The MCU code will be open
source.
It is a spare time project rather than work, so I can't guarantee
timescales, but I'll see if I can find some time to progress it.

(It could all be driven from the kernel with ADC and PWM, but I don't
see such a driver being accepted. Offloading it to an MCU seems to be
the easier option).

> As I already stated above, it will take us some time to prepare
> everything in a form that is suitable for submission. Now should I
> submit the next iteration(s) of the series at hand as RFC or as regular
> patch series?
>
> >>> The controls themselves appear reasonable to me as well. I guess there are
> >>> changes to be made based on the discussion?
> >>
> >> I'd summarize that whether or not the status controls are compound
> >> controls of the type V4L2_CTRL_TYPE_LENS_STATUS is the open question.
> >>
> >> As a potential follow-up question I recently asked myself if the struct
> >> v4l2_ctrl_lens_status should contain trailing reserved bytes for future
> >> extension (no idea, though, what this could be).
> >>
> >> Alternatively, we could come up with "V4L2_CID_FOCUS_CURRENT (integer)"
> >> for the current position and "V4L2_CID_FOCUS_STATUS (bitmask)" (and add
> >> further controls when they are needed. Here, we lose atomicity but maybe
> >> this can be ignored. One could assume that all relevant controls are
> >> read out with a single ioctl which provides at least some level of
> >> atomicity.

VIDIOC_G_EXT_CTRLS should allow you to read multiple controls in one ioctl call.
It would be multiple calls to your g_volatile_ctrl handler, so
potentially multiple I2C calls to your lens controller.
There is the option of cluster controls, but I think that is largely
only applicable for setting controls rather than reading them.

  Dave

> > There might be something that could be done in the control framework to
> > address this. But it's not something that can be expected to happen soon.
> >
> > I'd perhaps keep them separate, not to make it a compound control just for
> > the access reason. But I certainly don't have a strong opinion about it.
>
> After some further considerations, and following Dave's and your
> comments, I'll keep them separate.
>
> Discussion to be continued with v2.
>
> Best regards,
> Michael
>
> >
> >>
> >> Any comments and/or recommendations to this open question would be much
> >> appreciated.
> >>
> >> Other review comments will be incorporated in the next iteration of this
> >> series as well, but they are quite straightforward.
> >
