Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1D69E553
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjBUQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjBUQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F3196BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998720; x=1708534720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iqD6VB3dm3m3zjYF1FbGjINgDU1gByjhn5gk1ce92qw=;
  b=WQXJ4vRAyV+Z7YjB/9LfKRh+j33Z0mpv0huU7LLm6gsBRD8428n4MlLd
   W3goSlsTiyrPWoYrx7QK1jv3lL2XISkLTN6am9sgvf+VtBjNzPoWchW0x
   X8xKIhH4R8HwnKjlHEFb08HHjoKAINSV9JPYvpJQ52krqBrAD/5Whbg/v
   5XIqJosLblAQvn9LIDyHLfVDTkglmOioyN5FTEt70vbxJwxZHXnvb1Ack
   Nq9mE9r/elkLo45oTMXEC5XNhdAyL5DnFzayFOo/pP6m1j2vnkK9pfBhI
   XfHQX5P8c2myGDQl3KDnZAC+w4iTvExVH4m8uueBvl9zQZQDZCN47944y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884647"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569100"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569100"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:35 -0800
Message-ID: <c870e74e-5f21-49f1-7bc4-f2211e0cfdd6@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:01:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V3 4/8] soundwire: amd: enable build for AMD SoundWire
 manager driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-5-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230220100418.76754-5-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/23 05:04, Vijendar Mukunda wrote:
> Enable build for SoundWire manager driver for AMD platforms.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


