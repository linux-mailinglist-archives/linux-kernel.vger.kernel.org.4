Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491D05E5F17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiIVJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIVJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:54:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353CBD62DF;
        Thu, 22 Sep 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663840432; x=1695376432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ea4BsOUuW5M+zmX5YxUck7K6UPsasg/bw+USsOLkLts=;
  b=g14WIUg0Ys56JVRceEFDNnThYqihXs9Bb/LP/k5M7RN+JoItfl3tU578
   ruSptfoCmY2R9UGyC50nxWm6io7INhYDpbLxinBni+RA+QR+lIrwfQmXh
   C4D0tmw4Lyg5a0nknR59/gYUZfID0KeTfBcTQU+y67iwuWphwZ9oLzRrz
   TxZBgK5Px+Y+9qDGVEgEfACFLMiiY9EkhuVXrzMz7/COwJoSZSOaWnqHI
   ZxRtdruPa8c625DMnXUrFm0US0dh4SqskCQ0J6QNsRe3Jy2s9G8luLfJp
   Z/VBdyXlMHEMDOyPk1bBUm4tjtAc5vwYuWMvF+f7CHDxSKySeVZgR3uMi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="298971170"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="298971170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 02:53:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570900587"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 02:53:46 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 7EB1C20075;
        Thu, 22 Sep 2022 12:53:44 +0300 (EEST)
Date:   Thu, 22 Sep 2022 09:53:44 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Message-ID: <YywwqFi+2Nah2RpY@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911200147.375198-1-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Sun, Sep 11, 2022 at 11:01:33PM +0300, Mikhail Rudenko wrote:
> Hello,
> 
> this series implements support for Omnivision OV4689 image
> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> megapixel image sensor. Ihis chip supports high frame rate speeds up
> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> connection.
> 
> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
> 
> While porting the driver, I stumbled upon two issues:
> 
> (1) In the original driver, horizontal total size (HTS) was set to a
> value (2584) lower then the frame width (2688), resulting in negative
> hblank. In this driver, I increased HTS to 2688, but fps dropped from
> 29.88 to 28.73. What is the preferred way to handle this?

If horizontal total size is less than the frame width, something is
certainly wrong there. You can't have negative horizontal blanking. Neither
it can be zero.

> 
> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> gain is not linear across that range. Instead, it is piecewise linear
> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> with more linear segments in between. Rockchip's camera engine code
> chooses one of the above segments depenging on the desired gain
> value. The question is, how should we proceed keeping in mind
> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> libcamera will do the mapping, or the driver will do the mapping
> itself and expose some logical gain units not tied to the actual gain
> register value? Meanwhile, this driver conservatively exposes only
> 0x0-0xf8 gain register range.

-- 
Sakari Ailus
