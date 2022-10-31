Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC1613C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiJaRaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:30:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29819E0D9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667237401; x=1698773401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3ltsP6T9EWEyCrM8OqXT5q3fuQGDY4Ku8Nj+QBZFxHI=;
  b=eiUQqxPok9W/McHKCoJDI00SuV9w/ZGORitw2ozgkXGvtHi8atZlqMVw
   2syiR0Tnm6TegvDIOgy2iGr57Q0HsEWPH5d68O+6GqVDR/sb8KQNqduGk
   9oKnGWe3fNDvGmbwN5NLmT/o9ZLDyGt3iiGv+mXqoHcHZK+0rYYaemmnS
   82DL1982fQuSnCAEOvCFO3eLdf8joU/DPzOzuf6URJBmS2Ujza7ii8PVJ
   /ThS0UH3rvpw/jNFjuzWbA4X2S97QEVzjwLEdwMww8wBDvBZUFgz2IXBJ
   5HHn1kIMBOuIr9MMAEQq31e3WsARVwc8erzIbUFM2r4gXX3HsP8GkM/BT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="296375130"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="296375130"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 10:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="808627981"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="808627981"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga005.jf.intel.com with SMTP; 31 Oct 2022 10:29:57 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Oct 2022 19:29:56 +0200
Date:   Mon, 31 Oct 2022 19:29:56 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 6.1-rc: names of video outputs changed?
Message-ID: <Y2AGFPsvY79RE4Jn@intel.com>
References: <20221031165834.GA10150@duo.ucw.cz>
 <Y2ABatgNLVAAjpSW@intel.com>
 <20221031171952.GA10666@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031171952.GA10666@duo.ucw.cz>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:19:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I used to be able to do:
> > > 
> > > pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
> > > warning: output HDMI1 not found; ignoring
> > > pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
> > > warning: output VGA1 not found; ignoring
> > > 
> > > ...but now I have to do:
> > > 
> > > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> > > xrandr: cannot find crtc for output VGA-1
> > > pavel@duo:~$     xrandr --output LVDS-1 --off
> > > pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> > > 
> > > Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
> > > so. Who did it and why? Hardware is thinkpad x220, and this breaks my
> > > scripts :-(.
> > 
> > Are you sure you didn't just switch from intel ddx to modesetting ddx?
> 
> How do I tell?

You can read through your Xorg log file.

Or you can do something like this:
lsof -p $(pidof X) | grep _drv.so

-- 
Ville Syrjälä
Intel
