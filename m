Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F24621216
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiKHNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiKHNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:15:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5000E27B25;
        Tue,  8 Nov 2022 05:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667913346; x=1699449346;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=V8a1s54ki0Du02Crq9QZu279WBYeboXOkqd8m36ok38=;
  b=Tl2D9JtP+tKzBoZ5ip/xbtUwQPlPN6gbQaN/k5y5Yk/tpEcbrHswhYKs
   zALvlTfFe5WCCyK/GDZ0E8jDCQa5ZU+yHnS2GzkNx/r6kc/w6s68lAVab
   ciYUTuACMO2PqIEKTULPjiMKl2B4CwVQtxdAbxgxCOCkGDDPtGjnMEnKM
   7OutSS8fAFtEP5n0sJkrctDamr1k0aBOvsPWkY2WgH4WQvBIwNiviXEHC
   /kKszd923cm/p1Nhvmzq7MqxknPkB6xVN0Yj9UwSbblwi2wJqfz/QxN7E
   VWg5aj07v6DduuRBa3SCattzHjgeuicXRBI1tH/9//cLeJ1ObRks7Efvb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372831877"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="372831877"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:15:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614275786"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="614275786"
Received: from smoriord-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.110])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:15:38 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, tzimmermann@suse.de, lyude@redhat.com,
        Sandor.yu@nxp.com, javierm@redhat.com,
        ville.syrjala@linux.intel.com, sam@ravnborg.org, maxime@cerno.tech,
        penguin-kernel@I-love.SAKURA.ne.jp, oliver.brown@nxp.com
Subject: Re: [PATCH v3 00/10] Initial support for Cadence MHDP(HDMI/DP) for
 i.MX8MQ
In-Reply-To: <cover.1667911321.git.Sandor.yu@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1667911321.git.Sandor.yu@nxp.com>
Date:   Tue, 08 Nov 2022 15:15:32 +0200
Message-ID: <87iljp8u4r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022, Sandor Yu <Sandor.yu@nxp.com> wrote:
> The patch set initial support for Cadence MHDP(HDMI/DP) DRM bridge
> drivers and Cadence HDP-TX PHY(HDMI/DP) drivers for iMX8MQ.

Has some get_maintainer.pl guidance changed recently or something, or
why am I increasingly being Cc'd on patches that are largely irrelevant
to me?

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
