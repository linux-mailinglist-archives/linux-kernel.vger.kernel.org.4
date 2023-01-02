Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBD65B28D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjABNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjABNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:14:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBF108;
        Mon,  2 Jan 2023 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672665260; x=1704201260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EZo+4DbqsCLXUlE2Wd1gNAT85a+dsXWwnwV168nBS/4=;
  b=U6XtXku4eQnDIqlnCi7fM8OgDEhbnD3csnTRcqJPXHFBZWB/aqYc9Zlk
   Lq0YS/5xOLnAFoOKoFODzm5OEVBGhRbEjCo/2WqY/wRkBfo0g4XBiyqNY
   0ph131WuCPZRgUh5+5F4N7y0jD4JyJr++6I8MVKhkvgD9d4s7sJmvf5F1
   wLPhbBhVyzdatS68SfBOym3JJSXRQasI9jq9uofUZgWxdRaL39BSHnm8g
   NzNRnrV13eyfZciL8NLytck4T/YyIj+xOZwaNE8EEy5WteWzrs4o6dbRq
   RrW5sUDon5DZmOtMOBd8cAtr8EKgdvL2G8gg1CAD5+gV4GtJ6aMdI/shr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319182331"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="319182331"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:14:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="743193756"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="743193756"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:14:17 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 341F920178;
        Mon,  2 Jan 2023 15:14:15 +0200 (EET)
Date:   Mon, 2 Jan 2023 13:14:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] media: v4l2-dev: sysfs: Support streaming attribute
Message-ID: <Y7LYp01J5co9KSfJ@paasikivi.fi.intel.com>
References: <20221223231736.2111774-1-kieran.bingham@ideasonboard.com>
 <Y6lu14VsuH1LbqFH@pendragon.ideasonboard.com>
 <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yvFnaY1MM7I5C7H18aJdvQ6XEQn979YkGYpCjRLsnJvCRr2vYWVKorYqFXGxP3tWKeJ5B0oEA4Fn4W2-IqPd_N_wivEM4uKJD4WX53RiSmY=@protonmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnabás, others,

On Wed, Dec 28, 2022 at 01:44:38AM +0000, Barnabás Pőcze wrote:
> Hi
> 
> 
> On 2022. december 26., hétfő 10:52, Laurent Pinchart wrote:
> 
> > Hi Kieran,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Dec 23, 2022 at 11:17:35PM +0000, Kieran Bingham wrote:
> > 
> > > Provide a streaming attribute to allow userspace to interogate if a device
> > > is actively streaming or not.
> > > 
> > > This will allow desktop notifications to report if a camera or device
> > > is active on the system, rather than just 'open' which can occur when
> > > configuring the device.
> > > 
> > > Bug: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669
> > > Signed-off-by: Kieran Bingham kieran.bingham@ideasonboard.com
> > > ---
> > > 
> > > This is a quick POC to see if such a facility makes sense.
> > > I'm weary that not all video devices may have the queues registered on
> > > the struct video_device, but this seems like an effective way to be able
> > > to determine if a device is actively streaming on a system.
> > 
> > 
> > I can imagine multiple problems, from race conditions to permissions and
> > privacy. In order to comment on the fitness of this solution to address
> > the problem you're trying to solve, could you describe the actual
> > problem ?
> 
> 
> The issue is explained in the following thread:
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2669#note_1697388
> 
> In short, the user wants to show a "camera-in-use" indicator when the laptop camera
> is used. The script that the user previously had only checked if /dev/video0
> was open in any process, if it was, the indicator was shown. However, libcamera
> - at least at the moment - keeps the file descriptor open as long as the Camera
> object exists, which pipewire keeps alive for the entire lifetime of the device,
> therefore the "camera-in-use" indicator is always shown.

A sysfs attribute is not a great way to address this.

libcamera certainly has information on whether streaming is ongoing. The
information should come from there. Or Pipewire. Dbus perhaps?

Alternatively libcamera could close the video devices while not streaming
but that would involve e.g. releasing possible video buffer allocations as
well, increasing streaming start latency.

-- 
Kind regards,

Sakari Ailus
