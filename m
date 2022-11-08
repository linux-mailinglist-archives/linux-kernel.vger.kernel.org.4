Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5E621345
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiKHNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiKHNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:48:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084CABC93;
        Tue,  8 Nov 2022 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667915309; x=1699451309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qR1PAw49O9yyNQraw+N2we5BbIg280yLj3h68SdQpeY=;
  b=mW2b8wax7YgITXVarLvCWdQtrNsWZ5mkLD4k722Gj6jFGQzv3CJbOHAf
   P8gfpef1tqJ2n9dJyX/RoBewPNKKE2AjNqVNShH8uV9HMMWXvus1wiUyW
   lju7K62RrH36M4oHKhytttbqJArS/1V0DXouyeAEaJO2Sz+fm+6i3dq/q
   0ieDl6MgjYu3CC/l7jC9d5RBItGtAzuT8nme+D3aRegFgOrQGrENBSbpS
   Y6gNM83fRhy0RO2YEEZR06JuFLvXdKHkZhsS9ydQcenantoR/+NcpQLa1
   jQ6VYvOxoirmloObsjSNCMkMvxv+Df911jykJLkSRpdI9E6Famb8HKW16
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310693654"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="310693654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:48:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669551302"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="669551302"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 05:48:26 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B942D2015B;
        Tue,  8 Nov 2022 15:48:23 +0200 (EET)
Date:   Tue, 8 Nov 2022 13:48:23 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        laurent.pinchart@ideasonboard.com, jacopo@jmondi.org,
        hverkuil@xs4all.nl, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-media@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add support for Toshiba TC358746
Message-ID: <Y2peJ+G7ho1HuJSl@paasikivi.fi.intel.com>
References: <20220930124812.450332-1-m.felsch@pengutronix.de>
 <20221028134349.lxvo2jjvs6aehrbd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028134349.lxvo2jjvs6aehrbd@pengutronix.de>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Oct 28, 2022 at 03:43:49PM +0200, Marco Felsch wrote:
> Hi,
> 
> gentle ping.

This is in my latest PR to Mauro:

<URL:https://patchwork.linuxtv.org/project/linux-media/patch/Y1uVp8hHo7DYUK82@valkosipuli.retiisi.eu/>

-- 
Sakari Ailus
