Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8E1714084
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjE1VNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1VNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:13:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177EB8;
        Sun, 28 May 2023 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685308396; x=1716844396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1pk6WOHF6lAXsXWjNBSZaBU5uet0vhPcVxBvcZGXqGU=;
  b=m9loG8ipldHQSBmqkHJXANr1GyIewdr5gs2VJUeWQtnKtqgXznkSeZI7
   aztMKIh5icfp1P2s2xW18jlpP9zvRIQxCUko2iN6iV87+L+QcmXPPkps+
   u2SItMm9zDvd1ebNjHDWWMzlyn0BselmTyi0pv+AYmjOyioGFk2SwiAZ2
   o6iGPyT40e1Jqs+AFfVHht31Ieqx3vme8P5cLo8QJxnH7+QwBoKMRX+de
   FK4EDXEQp201U/Y2Vs0pPJhHFg4AA01b6VeZ8UHzgIxnb5Cqi/4l3jv7f
   p5dqetqYooewhu9Mh9uzXuZcmMWbcB3/QpTMFLh0ByC0ntYdepXYuL4OT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="420318990"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="420318990"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 14:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="770910621"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="770910621"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 14:13:10 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id E770612303D;
        Mon, 29 May 2023 00:13:07 +0300 (EEST)
Date:   Sun, 28 May 2023 21:13:07 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <ZHPD40NVGgFr3Iek@kekkonen.localdomain>
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
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On Fri, May 26, 2023 at 03:51:36PM +0500, Muhammad Usama Anjum wrote:
> Hi Sakari,
> 
> On 9/22/22 6:06 PM, Sakari Ailus wrote:
> > Hi Greg, others,
> > 
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
> Is there any update on IPU6 driver? Probably it hasn't been sent upstream
> yet?

I can confirm work is ongoing to upstream IPU6 ISYS driver. I'd hope to
have that in upstream some time this summer.

-- 
Kind regards,

Sakari Ailus
