Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1702613321
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJaJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJaJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:56:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED2DE9C;
        Mon, 31 Oct 2022 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667210182; x=1698746182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mduoPnVpsgqdu/zqtJ+RGdN39nZQIvXTqYP/pgSK6gk=;
  b=HjGJFlUiUbm2av2M0SOevrNEW05A7EtTXCRPTbgrQCc76DahfkdOwZxP
   nNorsiijPaFI1o27ZvuIBQomz44O72N1hirJmPNN8Sj6V7zb28MvnSb7O
   fqmmUjVS2TNaF4dxYoh4p8az0hh+tf/6uxyh5onMmrxN5Ls8FR8ph9knm
   84P9zMJLOt/w4TXbBa67iA3dqee5YaTc/R/J5+sC4UbVY8qc3GuLJ/jz5
   kXqZZJopKy0rqNF+bX16HEnET8ImdRAY2X9HOiO/m5sd4YN8SSTpMoi7v
   yFDAskaKIenU5FFLlWIk9cjsYd3RDSSyEVHWqQSt7nIH9vEVR45RlnQYU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="306476709"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="306476709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 02:56:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="878680442"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="878680442"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 02:56:17 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2262E20210;
        Mon, 31 Oct 2022 11:56:15 +0200 (EET)
Date:   Mon, 31 Oct 2022 09:56:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/9] media: i2c: ov5645 driver enhancements
Message-ID: <Y1+bv3xdfH+Bb69f@paasikivi.fi.intel.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y1pQJP1DMZvdioZF@paasikivi.fi.intel.com>
 <20221029125412.GX125525@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029125412.GX125525@dragon>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 08:54:12PM +0800, Shawn Guo wrote:
> On Thu, Oct 27, 2022 at 09:32:20AM +0000, Sakari Ailus wrote:
> > Hello,
> > 
> > On Wed, Oct 26, 2022 at 02:06:49PM +0100, Prabhakar wrote:
> > >   ARM: dts: imx6qdl-pico: Drop clock-names property
> > >   ARM: dts: imx6qdl-wandboard: Drop clock-names property
> > >   arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names
> > >     property
> > 
> > Are Freescale/Renesas arch maintainers fine with me taking these patches
> > or should they be merged through another tree?
> 
> Go ahead to take i.MX DTS patches:
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Thanks, Shawn and Geert!

-- 
Sakari Ailus
