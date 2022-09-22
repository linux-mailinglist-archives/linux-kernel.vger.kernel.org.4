Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3F5E6D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIVUkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIVUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:39:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62A4F64E;
        Thu, 22 Sep 2022 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663879197; x=1695415197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nKjt8i5hI5NVF3hw3pzSK85gr4EvQwA7dsp365aeqTE=;
  b=DMOl9FDWNv69Q0o8bOdHPqZGZPLe/JGiGfFbUyTHpb2SaeLhsn65t2jf
   9pEr9zGQoVd0uOVjmAAH54ZokazwlQ+D2tG0z4DW0VEnNteCU0KABVtAS
   MngLNcQ3ciBSPqSKh+XimK6/JUOaPdW7bOpGkTqB7YCcI4dn7Z5hY3lTS
   3H5DhUc5mJT3ZI50veOrFXBskx14xntgSuxv+vHLqDCbYH0iHtrTscpeq
   dBGrLDg61KJZHULFtE21Ta6r1c6I7zRCFvKp9A9TH3yWVs3AUg3XUaJXu
   eDFUxcIv6CUYmHBPL0JIlEOcQHp8blgIr9bdQPh96X7Nfc3yH4kVAc0Ty
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300411398"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300411398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762354903"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:39:50 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 60DAB2007A;
        Thu, 22 Sep 2022 23:39:48 +0300 (EEST)
Date:   Thu, 22 Sep 2022 20:39:48 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Message-ID: <YyzIFGo6SYhVP6sj@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <YywwjmN9qqwFoEc5@paasikivi.fi.intel.com>
 <87czbnif04.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czbnif04.fsf@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Thu, Sep 22, 2022 at 06:23:05PM +0300, Mikhail Rudenko wrote:
> 
> Hi Sakari,
> 
> and thanks for reviewing this!

You're welcome!

> 
> Please see my comments below:
> 
> On 2022-09-22 at 09:53 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
...
> >> +static inline u32 ov4689_cal_delay(u32 cycles)
> >> +{
> >> +	return DIV_ROUND_UP(cycles, OV4689_XVCLK_FREQ / 1000 / 1000);
> >
> > Please use the actual rate instead.
> >
> 
> Do you mean clk_get_rate(ov4689->xvclk), right? What if we have an ACPI

Yes.

> system and xvclk is NULL here? Please explain.

There are a few ways this could work on ACPI based systems but generally
you'd have "clock-frequency" property to indicate the frequency even if
clocks themselves wouldn't be available (when controlled via ACPI)).

-- 
Kind regards,

Sakari Ailus
