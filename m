Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ACF60C6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiJYIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJYIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:46:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C765246;
        Tue, 25 Oct 2022 01:46:33 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e19so3798488ili.4;
        Tue, 25 Oct 2022 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVJzdvRrckYl+6uw766hou4RRx69jQK8xN0BAui+beM=;
        b=OqaowXZBvOvx2bK6X7sLgVHuAra4t0D/Y6UoVMergSpT97H/7zFyE+hYIqDgCo5OJJ
         i5QIR3Kk5DPTrlj3kcWHt8UstcmxNy7sC4jHo0XN5yCCYiB/+1DS6vGbQdTLQW37ZWGq
         FS3Wwvr2D1R1skA4eTKirbXrHNVfPibmQKlGSsBkPeBvPL+0XTsPukYCfAfixWfJFZ9y
         0NDzMGtqhzOwsMSXzsAtuvX+UV/9Oz/ttQR3b0/ZcwcxxHAQVsRpnLrewP9Do2GY0W5s
         Nh8vBZhXXZAh43YkVRBAVASIeWTAIIVYzyDo9qXrzNIgQrrKCd+ar7Cjf/NWDdd/ANBC
         RLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVJzdvRrckYl+6uw766hou4RRx69jQK8xN0BAui+beM=;
        b=QunKWjHG48f/Vp3nInnU2F5i8/JcvJRJXWE2E7j4ukxJ1lpqsk8LJpgTdsTBoWrz6b
         BNyWMXSOOMs7U1t/5P07DGkLvEAdmFyceXS+X2/ykv4k1cHcFfdrU+V2vRgaeQ7os2rZ
         OmOov97hZQHAtkjG7fGW0diQ+FBqGxb+Lj92SSZC91abcSgIayFF9VOmGQ3TWFB/ENDa
         JfXceZFIVLbwlYPVdZ8ZOybU72aiTP1tXjC/WUv+eOg/RoahhR9BHYekC5/aspUD1Hw5
         FbwpNb06Ts52V7RDTS5MMB1+8oBxZmxqFLNmmTb1I4HaKH0HxQcAUdDG8njqWOfhzq81
         zv3w==
X-Gm-Message-State: ACrzQf147lVs7vajfB2WWOMYyjxHxu2dbKz076n+OqYIf4Ab0llsvRCf
        Qau9/gBwL/s0IxKem0gaq58=
X-Google-Smtp-Source: AMsMyM75UVxCs7Ray+F+74gVi2DU0nU9xjOz/NT9qhM9L9HCB3TarxvfQElL6ffiJ4jDswRxq4uLDw==
X-Received: by 2002:a05:6e02:1a69:b0:2fa:970:70f2 with SMTP id w9-20020a056e021a6900b002fa097070f2mr22603800ilv.204.1666687592969;
        Tue, 25 Oct 2022 01:46:32 -0700 (PDT)
Received: from qjv001-XeonWs (c-67-167-199-249.hsd1.il.comcast.net. [67.167.199.249])
        by smtp.gmail.com with ESMTPSA id d32-20020a0285a3000000b00372bbd04b75sm140779jai.87.2022.10.25.01.46.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Oct 2022 01:46:32 -0700 (PDT)
Date:   Tue, 25 Oct 2022 03:46:30 -0500
From:   Jeff Vanhoof <jdv1029@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: uvc gadget performance issues with skip interrupt impl
Message-ID: <20221025084628.GA31171@qjv001-XeonWs>
References: <20221025063359.GA19049@qjv001-XeonWs>
 <Y1eYg1ESBtLJFQ20@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1eYg1ESBtLJFQ20@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 25, 2022 at 10:04:19AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 25, 2022 at 01:34:01AM -0500, Jeff Vanhoof wrote:
> > Hi,
> > 
> > During the queuing up of requests from the UVC Gadget Driver to DWC3 for one
> > frame, if a missed isoc event occurs then it is possible for the next
> > consecutive frame(s) to also see missed isoc related errors as a result,
> > presenting to the user as a large video stall.
> > 
> > This issue appears to have come in with the skip interrupt implementation in
> > the UVC Gadget Driver:
> > 
> > usb: gadget: uvc: decrease the interrupt load to a quarter
> > https://lore.kernel.org/r/20210628155311.16762-6-m.grzeschik@pengutronix.de
> > 
> > Below is an example flow of how the issue can occur (and why).
> > 
> > For example (ISOC use case):
> > 1) DWC3 driver has 4 requests queued up from the UVC Gadget Driver.
> > 
> > 2) First request has IOC bit set due to no_interrupt=0 also being set, and IMI
> > bit is set to detect missed ISOC.
> > 
> > 3) Requests 2,3,4 do not have IOC bit set due to no_interrupt=1 being set for
> > them. (Note: Whether or not the IMI bit is set for these requests does not
> > matter, issue can still crop up as there is no guarantee that request 2,3,4
> > will see a missed isoc event)
> > 
> > 4) First request gets a missed isoc event and DWC3 returns the req and error to
> > UVC Gadget Driver.
> > 
> > 5) UVC Gadget Driver, in uvc_video_complete, proceeds to cancel the queue by
> > calling uvcg_queue_cancel.
> > 
> > 6) UVC Gadget Driver stops sending additional requests for the current frame.
> > 
> > 7) DWC3 will still have requests 2,3,4 queued up and sitting in its
> > started_list as these requests are not given back to the UVC gadget driver
> > because they each have no_interrupt=1 set, and the DWC3 driver will not have
> > any additional interrupts triggered for them as a result.
> > 
> > 8) Approximately 30-100ms later a new frame enters the UVC Gadget Driver (from
> > V4L2), and it proceeds to send additional requests to the DWC3 driver.
> > 
> > 9) Because requests 2,3,4 are still sitting in the started_list of the dwc3
> > driver, the driver does not stop and restart the transmission that normally
> > helps it recover from the missed isoc situation (this usually happens in
> > between frames).
> > 
> > 10) Some of the requests from the new frame will have no_interrupt=0 set, but
> > these requests will be considered missed/late by the DWC3 controller.
> > 
> > 11) Because these new requests have the IOC bit set (and possibly IMI),
> > interrupts will be triggered causing the DWC3 Driver to return the req and
> > error to the UVC Gadget Driver.
> > 
> > 12) And if the last set of requests sent by the UVC Gadget Driver have
> > "no_interrupt=1" set, then DWC3 may not interrupt further until new requests
> > come in, and the cycle of frame drops/errors will continue.
> > 
> > I have briefly mentioned this issue in another conversation with Thinh. At the
> > time he mentioned that 3 things could possibly be done to help resolve this
> > issue:
> > 
> > 1) The UVC Gadget Driver should ensure that the last requests queued to DWC3
> > must always have "no_interrupt=0" set.
> > 
> > 2) DWC3 can detect stale requests, stop the transmission and give back the
> > requests to the UVC Gadget Driver, and restart the transmission for the new set
> > of requests.
> > 
> > 3) Set "no_interrupt=0" for each request.
> >  
> > I have tested out various implementations for all 3 possibilities and they each
> > seem to work ok. Note that these test implementations are not ready for prime
> > time, but served as a way to prove that potential changes in these areas could
> > help to resolve this issue.
> > 
> > I believe that a change for the UVC Gadget Driver should be made, but it also
> > makes sense for the DWC3 driver to also attempt to recover from this situation
> > if possible.
> > 
> > Does anyone have an opinion on the best way to proceed?
> 
> Please see this set of patches and the discussion around them:
> 	https://lore.kernel.org/r/20221018215044.765044-1-w36195@motorola.com
> 
> Some of them are already queued up in my tree and in linux-next, can you
> try that?  There are others for the dwc3 driver on the mailing list as
> well, testing those would be wonderful if you could do that.
> 
> thanks,
> 
> greg k-h

I've been working with the submitter of those patches (Dan) to debug various
crashes and performance issues being seen. I believe that the issue I've
described above is unique and am not aware of any current fixes targetting a
fix for it. This issue will primarily appear for users experiencing frame drops
due to missed isoc issues when the skip interrupt implementation in uvc is
enabled (usb: gadget: uvc: decrease the interrupt load to a quarter).

Thanks,
Jeff



