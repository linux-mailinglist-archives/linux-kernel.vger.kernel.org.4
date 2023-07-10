Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C774D4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGJMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGJMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:07:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA365F4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688990869; x=1720526869;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vhQl0HD5I0/ESpqDJlfvf8LP7w3sp0fBVoVyKApq+B4=;
  b=jpz3dyIJ+mhMLKZORXjkiFkw0kdAW6fbA3krXCPYAv+GOLpfaVpATWJ3
   XvbNoAbUSFWqy5IiA+rO4wvy4f3h6I4SlRGB1ovbQibh77RqwKz05IQTg
   waJGQYYW04GNUzzLVnH+BX+2bJNK0UtX4wVm+S9/ENRrCnjjRiEM2NlFy
   XnCbb6M5gQ2L/AsRu2k5amLB039WfLlkblzMKKLEha6wrq9bIAebW3Nfe
   QBw9OEFBW0+KhTPyoxzp+PD5n/0VLLK8wT+TY2UeReDUQRmoXnBQmUWOV
   ic5XVBRkz+GphKA25fyMN4HV9RJLTJdJiJi7UdsFJIK0+9gpDE+3cWF7z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344652533"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344652533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 05:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810792645"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="810792645"
Received: from stoicaan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.170])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 05:07:45 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] drm/loongson: Remove a useless check in
 cursor_plane_atomic_async_check()
In-Reply-To: <13d4c853-ed7b-f0f5-dffb-a7811f2da249@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230710102411.257970-1-suijingfeng@loongson.cn>
 <6c7bbce7-5521-b868-019f-bce26f309730@suse.de>
 <8182fecd-d290-293a-d963-ddbea79dbf03@loongson.cn>
 <87r0pghtu9.fsf@intel.com> <13d4c853-ed7b-f0f5-dffb-a7811f2da249@suse.de>
Date:   Mon, 10 Jul 2023 15:07:43 +0300
Message-ID: <87o7kkhsvk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Should be OK; it's an isolated driver. I did a review early on and after 
> ~13 revisions I asked for it to be merged. It's actually a bit hard to 
> find reviewers.

Fair enough.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
