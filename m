Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DA5BC2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiISGdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISGdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:33:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8244317A88;
        Sun, 18 Sep 2022 23:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663569199; x=1695105199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r0/uBQA5005Rs7fYs3jAa6s1cVz0tORDno4ZJmynCXc=;
  b=HfWiTD30ya3KzIEB5BzjcJzveFdfn3v6SzYSsLVyWN+WJJ5dN26yuCBt
   rD2Y+nR1XPoqOIinwkiWxIEf4Cqr/dljimBFkhVSIOOAd4vgjpn2MKEm5
   gCxlYo1Y+Iix0yTx5/PTZFCeDt+LVZJPg4gRiH09HZFXgvJeFaBmFOb76
   IRLN8cI4vGhZ7PfM7sBPzzGqEm9lGJ3BpizkJrcEEOlRralNUBFIF3oWe
   y7rq23XZ065biZfggxpTvcknQhLfuSJsMyTgnf+ceVeWyYMTZGXojftsz
   70v3JOFGZ7DpGYFl2awewKsL/+EBeVvWlrx+Hw1zL4vm/kv1mjyC4ln5p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="282344198"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="282344198"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:33:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="760738803"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 23:33:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BB04220078;
        Mon, 19 Sep 2022 09:33:12 +0300 (EEST)
Date:   Mon, 19 Sep 2022 06:33:12 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Message-ID: <YygNKE7LLtpwfnz+@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <20220914155122.GA9874@tom-ThinkPad-T14s-Gen-2i>
 <87k064pa2v.fsf@gmail.com>
 <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Fri, Sep 16, 2022 at 03:34:01PM +0200, Tommaso Merciai wrote:
> > >> +	ret = clk_set_rate(ov4689->xvclk, OV4689_XVCLK_FREQ);
> > >> +	if (ret < 0) {
> > >> +		dev_err(dev, "Failed to set xvclk rate (24MHz)\n");
> > >> +		return ret;
> > >> +	}
> > >> +	if (clk_get_rate(ov4689->xvclk) != OV4689_XVCLK_FREQ)
> > >> +		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
> > >
> > >
> > > What do you think about?
> > > Thanks.
> > 
> > Unfortunately, I have no experience with ACPI-based devices. :(
> > 
> > Do you mean that in the case of an ACPI device and devm_clk_get_optional
> > returning NULL we should assume that the clock is already enabled and
> > will stay enabled during sensor operation? How should we distinguish it
> > from the case of an OF-based system and clock just missing from device
> > tree?
> 
> Not exaclty :)
> 
> I copy comment from [1]
> 
> if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
> you use the get_optionl() version ? Otherwise in the ACPI case you will have
> -ENOENT if there's not 'xvclk' property and bail out.
> 
> Unless my understanding is wrong on ACPI we have "clock-frequency" and
> on OF "xvclk" with an "assigned-clock-rates",

Generally yes. It's also possible to have a clock in ACPI based system
although those clocks do not come from ACPI. See e.g.
drivers/platform/x86/intel/int3472/clk_and_regulator.c .

-- 
Sakari Ailus
