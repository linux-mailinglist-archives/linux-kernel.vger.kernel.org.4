Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA75E6312
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIVNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiIVNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:02:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FCE6A19;
        Thu, 22 Sep 2022 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663851738; x=1695387738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eoSHFPTIVV1AyhYemgSVhhNywqbp4RenvpD+BM9ByR0=;
  b=KavOG/UTUggCL8K4/R/qCM3DOIpR/x94UHqdl/bBrMwNNHfHgV7uvpkW
   TDEQTcpur1OgYCMU4aRnaEc3A3ev/43xGbU5l1a5icgsATxeP/xrOrqba
   WcGntzqaR2/2JxcPYrPjeTOFaEghbaE6JI5QlpwgVCxVP2IQNEU+1jCv7
   21A5Z5AmX3/5+lCZw70jNFDOSmSMhLSxNJG/elyljD3dnYnvtgFY8L4SA
   EJJ1uUF2qiXaSUHT08MfPHSHINPEr+Yh/p5GY51Y7HC3U44Wm2oE3gG8j
   5IpbQfCxwD09HexNXZjtLTmU78sgHF2xiU3aaOX3usLUEzFpOrjCa5nqv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386575951"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="386575951"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:02:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="745371975"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:02:07 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 75E2B20075;
        Thu, 22 Sep 2022 16:02:05 +0300 (EEST)
Date:   Thu, 22 Sep 2022 13:02:05 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] media: platform: Add Renesas RZ/G2L MIPI CSI-2
 receiver driver
Message-ID: <YyxczbcHWF47FL8/@paasikivi.fi.intel.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyuDoaewe4AQBdsF@paasikivi.fi.intel.com>
 <CA+V-a8sa+gEwyGRNqbz04BZ3ZtGkokJn9YrZ+U5q0VcY1BDKSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8sa+gEwyGRNqbz04BZ3ZtGkokJn9YrZ+U5q0VcY1BDKSA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 22, 2022 at 01:53:49PM +0100, Lad, Prabhakar wrote:
> > > +int rzg2l_csi2_cmn_rstb_deassert(struct rzg2l_csi2 *csi2);
> > > +int rzg2l_csi2_dphy_setting(struct rzg2l_csi2 *csi2, bool on);
> > > +void rzg2l_csi2_mipi_link_setting(struct rzg2l_csi2 *csi2, bool on);
> >
> > Are these something that could be achieved using the standard interfaces,
> > as I believe the other drivers are doing? The pre_streamon and
> > post_streamon callbacks could be relevant for this.
> >
> Thanks for the pointer. I have now moved some code to pre_streamon ()
> and rest to s_stream(). Is there any mandatory rule to have both
> implemented? (as I wont be needing post_streamoff(), nothing complains
> so for)

In principle no.

But if you e.g. resume the device in pre_streamon, you'll need to suspend
it in post_streamon.

-- 
Sakari Ailus
