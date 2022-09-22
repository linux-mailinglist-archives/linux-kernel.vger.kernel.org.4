Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57E15E632C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIVNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIVNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:07:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04967EBBC0;
        Thu, 22 Sep 2022 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663852058; x=1695388058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIiUludhaEiP1q42HoGcIondmm0hwzStdN7EzNx6+6k=;
  b=juv2hUjjNUBf4hGN3jCWrj+OGEyUqHH/JOjHd8wX+Et4J0X/c6pwPRNu
   BeMqHTFWXrQgupHexAC/a5mT5cyW4BK246oAUapzBKPMJmymhXfvsijdm
   Y08t0iLKhlvECFIDjRC5wmAYm3hHqts8rFX9DjPhXyxu4Y8K8OBqbB/JY
   GeMA9rJPCOnYnLmDLXPQjkDy4U6+lXvlmd3W+GAwbLJB4atGQSJIDOs5z
   Kyg/Z3lkBtNBgdyfXZXzLRjP2F6EvGQl26CHNuUUn0wSg8QIja6Pqp5mW
   Ygiul2CNI+I+uiptVVl2VenLLLniH4zdrNw5YG2X35SIbS/GykNvOEREl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283343169"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="283343169"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:06:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="688286472"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:06:26 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 88E4320075;
        Thu, 22 Sep 2022 16:06:24 +0300 (EEST)
Date:   Thu, 22 Sep 2022 13:06:24 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <Yyxd0BJw5syjVsvm@paasikivi.fi.intel.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUaEDMbZD70x+hD@kroah.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, others,

On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > For the time being, I agree with your recommendation to not buy these
> > devices if you care about camera support.
> 
> I second this, don't buy these devices if the vendor is not willing to
> get their drivers upstreamed properly.

I can now confirm that IPU6 driver upstreaming is now planned, with IPU6
input system driver to be upstreamed first. The intent is that we would
have patches for review on LMML around the end of the year.

The processing system driver will need more work to replace the custom
interface. For a fully functional camera stack, also libcamera support for
IPU6 will be needed.

I think I can say a major factor for why we're here is that the original
intent was to use a different interface for upstream but as we don't have
one yet and probably won't for quite some time, this doesn't really seem
like a viable option anymore.

So I'm afraid I can't promise a quick fix but at the same time I can say
work is being done to address this.

-- 
Kind regards,

Sakari Ailus
