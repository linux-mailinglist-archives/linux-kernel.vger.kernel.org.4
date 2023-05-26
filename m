Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDE712550
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbjEZLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEZLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:13:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A70BF7;
        Fri, 26 May 2023 04:13:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (p7097156-ipoefx.ipoe.ocn.ne.jp [153.231.19.155])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CCF49B4;
        Fri, 26 May 2023 13:12:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685099563;
        bh=d3LVk7G1Bewsb4CigKlj5v/bqNRgnFoj2UDBwuFHOMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJJBDryPsmO4a0EUNxBhbiYBZZDze9O9NIh+PJM9FoStv1SGKfyAjotNIItezp733
         zZWIftFhn8Tgfq0X4R4fknhuswScC/IRidiRq1JDhWsI8dcDbeteOD53IZJg12RRbn
         wiSoaSAl5BG1ReGGJo5/qTl6hWvgnCx4fdLwWaHs=
Date:   Fri, 26 May 2023 14:13:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <20230526111301.GA19530@pendragon.ideasonboard.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <Yyxd0BJw5syjVsvm@paasikivi.fi.intel.com>
 <88033d6a-b1d6-a77d-cab7-1401d97ae8e2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88033d6a-b1d6-a77d-cab7-1401d97ae8e2@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 03:51:36PM +0500, Muhammad Usama Anjum wrote:
> On 9/22/22 6:06 PM, Sakari Ailus wrote:
> > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> >> On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> >>> For the time being, I agree with your recommendation to not buy these
> >>> devices if you care about camera support.
> >>
> >> I second this, don't buy these devices if the vendor is not willing to
> >> get their drivers upstreamed properly.
> > 
> > I can now confirm that IPU6 driver upstreaming is now planned, with IPU6
> > input system driver to be upstreamed first. The intent is that we would
> > have patches for review on LMML around the end of the year.
>
> Is there any update on IPU6 driver? Probably it hasn't been sent upstream yet?

The IPU6 requires multiple drivers. The "easy" part (the IPU6 input
system) has been submitted to the linux-media mailing list (see [1]).
That driver will allow capturing raw frames from the camera sensors
(assuming drivers for the sensors in your particular device are
available).  Another driver has also be submitted to setup the IVSC (a
chip present in some systems between the camera sensor and the IPU6),
see [2].

The hard part (the IPU6 processing system) will still take time, and
once a driver for that is available, the userspace implementation in
libcamera will also take time.

[1] https://lore.kernel.org/linux-media/20230413100429.919622-1-bingbu.cao@intel.com/
[2] https://lore.kernel.org/linux-media/1685022434-24609-1-git-send-email-wentong.wu@intel.com/

> > The processing system driver will need more work to replace the custom
> > interface. For a fully functional camera stack, also libcamera support for
> > IPU6 will be needed.
> > 
> > I think I can say a major factor for why we're here is that the original
> > intent was to use a different interface for upstream but as we don't have
> > one yet and probably won't for quite some time, this doesn't really seem
> > like a viable option anymore.
> > 
> > So I'm afraid I can't promise a quick fix but at the same time I can say
> > work is being done to address this.

-- 
Regards,

Laurent Pinchart
