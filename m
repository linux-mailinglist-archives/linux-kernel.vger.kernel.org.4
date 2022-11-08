Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4731A62195A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiKHQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiKHQ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:27:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820CB1FF92;
        Tue,  8 Nov 2022 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667924865; x=1699460865;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=h78vCa8Jt3/b52JPFCVtECZg21VRPdjuo2bou/9Cpy8=;
  b=K3zad+n65tjPGtHXfztBvnDFH+xChIO5DLZs6m7KLijlzYuUNf1AP+hB
   FUxwsuL4qOLi5b45abCMSsl+9ujEK1Jalli+nkCMo7x+WbVAo6/TKCQJx
   Ar13AfFLv4S9S1H2qjlU16zFANtYMtrXVSylLY5stSUAKd/hxTmDS8twE
   coosU7m1Gl5i1V7sLp5UJxbvUrItVC3Wf8mBvFkgEXp8SMytIPyzfBNjs
   XwNg4duCPwykWrbYoXjHa/H5k3oIA250Uo4gGjq0RBX9hCFNJN4QRMIQn
   FZyHITyKoR72G7aZ1Src1JjBZLXVl7DRjG34Rr/JcF9VSC4dv2fLpdWP/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="375012123"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="375012123"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:27:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669606468"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669606468"
Received: from smoriord-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.110])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:27:37 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Sandor Yu <sandor.yu@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "lyude@redhat.com" <lyude@redhat.com>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        Oliver Brown <oliver.brown@nxp.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [EXT] Re: [PATCH v3 00/10] Initial support for Cadence
 MHDP(HDMI/DP) for i.MX8MQ
In-Reply-To: <PAXPR04MB9448612AD6C7744B7C706D6FF43F9@PAXPR04MB9448.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1667911321.git.Sandor.yu@nxp.com>
 <87iljp8u4r.fsf@intel.com>
 <PAXPR04MB9448612AD6C7744B7C706D6FF43F9@PAXPR04MB9448.eurprd04.prod.outlook.com>
Date:   Tue, 08 Nov 2022 18:27:35 +0200
Message-ID: <875yfp8l8o.fsf@intel.com>
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

On Tue, 08 Nov 2022, Sandor Yu <sandor.yu@nxp.com> wrote:
> Run get_maintainer.pl for patch 1, 
> Your email address is list as follow,
> Jani Nikula <jani.nikula@intel.com> (commit_signer:2/8=25%)
>
> And I add the email address that comment as "commit_signer" into Cc list.

Please don't do that.

get_maintainer.pl gives you no less than *eight* people as designated
maintainers or reviewers.

I've acked two commits with one-line collateral changes to the files in
question.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
