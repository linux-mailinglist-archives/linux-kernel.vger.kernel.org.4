Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F763613BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiJaRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJaRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:10:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9B12D2B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667236206; x=1698772206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SAXQrfesOB3YLTPAk7qxauA2Uhq6ODe+CXHF5a+y0Aw=;
  b=i31BrzAKA1b/3lbq8C8WH/jgToIoek8nc/xtDH28MtRZrI4N2neJ81iT
   TLbzsOz6kOwrEbz3S17fRzCgaCeRQdjM27zL1xvqyLIBYdU1O9xx6e4IV
   cvA2/pRmNiN0WDinpT44/mWt4wX393SL5hqd7mxN4AF6n5RtA3WBhDgnC
   qpSWuEu2JdrfXftQLw/tKFPJkC5NGQrOkxeyL3nwlpfFYmvw38Sy+FwP7
   Yap6N50ElKwwurfeE6EnXSJMqTA9xpBlMQBf/KDS7XwW7IeeWiltkSSrc
   w9wcHjaw2DqtncyI3spHuJ7K4pHK0gCqKFePhnqzVWfBQhJdpFDiAnj72
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310041339"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310041339"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 10:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="697099364"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="697099364"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga008.fm.intel.com with SMTP; 31 Oct 2022 10:10:02 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Oct 2022 19:10:02 +0200
Date:   Mon, 31 Oct 2022 19:10:02 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 6.1-rc: names of video outputs changed?
Message-ID: <Y2ABatgNLVAAjpSW@intel.com>
References: <20221031165834.GA10150@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031165834.GA10150@duo.ucw.cz>
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

On Mon, Oct 31, 2022 at 05:58:34PM +0100, Pavel Machek wrote:
> Hi!
> 
> I used to be able to do:
> 
> pavel@duo:~$     xrandr --output HDMI1 --mode 1920x1080 --primary
> warning: output HDMI1 not found; ignoring
> pavel@duo:~$     xrandr --output VGA1 --mode 1280x1024 --below HDMI1
> warning: output VGA1 not found; ignoring
> 
> ...but now I have to do:
> 
> pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> xrandr: cannot find crtc for output VGA-1
> pavel@duo:~$     xrandr --output LVDS-1 --off
> pavel@duo:~$     xrandr --output VGA-1 --mode 1280x1024 --below HDMI-1
> 
> Notice the change from HDMI1 to HDMI-1. I believe that's new in 6.1 or
> so. Who did it and why? Hardware is thinkpad x220, and this breaks my
> scripts :-(.

Are you sure you didn't just switch from intel ddx to modesetting ddx?

-- 
Ville Syrjälä
Intel
