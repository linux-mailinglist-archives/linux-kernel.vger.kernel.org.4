Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783160F3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiJ0JdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiJ0Jcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:32:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB7240BF;
        Thu, 27 Oct 2022 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666863149; x=1698399149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oglNlZd03blw6ctUoQlZFxomNHxkVQMJcNNs7El2KW8=;
  b=KqGdysen+iKYuo9g7+SwmvZVMb479EvbQs/lUuGikegaSOgZtonYD1Ab
   y8XCUvFsOwiJrUneexhRnRKz7qxLto8vpN4YS0xeBnJL1WZ2um63AsOxK
   fsgGj8t9l0uYpmv814/nP4yOlIwtZ0oXw0/Ad6FjI7/OTkQioWBgqLXew
   oZsthy1pFxXsYKVy0Ov7ijhVu9jcVrN5pvdWFYi6H2LLNTazZypbV8lay
   ZpaR+pgripWeKbhfi7MmggWi+HNRYMkING75A55B2z+b/oXFJJvQCHsMO
   giDq+0CrUmorCEoapzkE8f8AXNZqGokETxbZ6neP857Pl7ZO85LQDpg68
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="370243980"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="370243980"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:32:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737610971"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="737610971"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:32:23 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id CFE5D2026C;
        Thu, 27 Oct 2022 12:32:20 +0300 (EEST)
Date:   Thu, 27 Oct 2022 09:32:20 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <Y1pQJP1DMZvdioZF@paasikivi.fi.intel.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 26, 2022 at 02:06:49PM +0100, Prabhakar wrote:
>   ARM: dts: imx6qdl-pico: Drop clock-names property
>   ARM: dts: imx6qdl-wandboard: Drop clock-names property
>   arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock-names
>     property

Are Freescale/Renesas arch maintainers fine with me taking these patches
or should they be merged through another tree?

Thanks.

-- 
Kind regards,

Sakari Ailus
