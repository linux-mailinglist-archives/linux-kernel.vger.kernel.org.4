Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23C6338B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiKVJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiKVJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:38:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20127B27;
        Tue, 22 Nov 2022 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669109925; x=1700645925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4YfwEoCNf9y2bbVgA0lkiee8S9bFPoPb39DN1uonMiY=;
  b=OAs8IruyjG8128kcyK9MxwEvkeXKiw10xCUiGFoaRXdFL6Ac3Jtwjovj
   ABhypCqsrZleCdwuknhEMDCnjDZIXRjF+4g+1uSGfxvCXTggfJwbRFn9D
   PdyhuK3yOuwVo2p7mvYqMad2aAJtl5sHePNj22pse+jPb3jIB+DJgE3mb
   myzLkIe8hTJy8KuGC5uy03OGRNv49J6LRPikPTVECxRY8evqGGNyD/r+K
   OpmfFWhmYug+ZGtWGtTj7AMtECJrPDZqqVsieh7fbN23ntoQ1oaBa8XBp
   x3fDV4H2hejiajKHd5qLCs1v1ww1RYBIr5SeSWotRo+/X5ZaCGvfp7JK2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312477955"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="312477955"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:38:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="816041518"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="816041518"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 01:38:28 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D054C2015F;
        Tue, 22 Nov 2022 11:38:25 +0200 (EET)
Date:   Tue, 22 Nov 2022 09:38:25 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 4/4] media: platform: Add Renesas RZ/G2L CRU driver
Message-ID: <Y3yYkQhJJFLau08X@paasikivi.fi.intel.com>
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102004329.5410-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, Nov 02, 2022 at 12:43:29AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> 
> Based on a patch in the BSP by Hien Huynh
> <hien.huynh.px@renesas.com>
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Laurent's comment arrive a little late but the patch does not compile
against the media tree anymore. The argument of the media_pipeline_start()
and media_pipeline_stop() is now a pad, not an entity. See what the changes
look like in other drivers (the commit id is
12cecbf9150f67b0ce7d88bc2e243e67637726c2).

I'll still take the DT binding patches.

-- 
Kind regards,

Sakari Ailus
