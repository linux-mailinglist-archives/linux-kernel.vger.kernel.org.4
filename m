Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2C6B4DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjCJQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjCJQ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:58:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A0011051A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678467429; x=1710003429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i2ac7HdZrtUnY/gA1NCVmTfRzi9Lx/7d4lpHUaUwla0=;
  b=KPQ8AsD5NxJq0kPQkm3lxE5WsOZAqJytytfAJPdtIndjaxeZi0S93Hrp
   586HA2Gswoq3rjcBxR1HD3N5oZvju8d9sQnA9Wy1TGpMwzRWQziPQchE3
   68gzrUV5acK2nVOT24Xqz36mgA+WjIJzAAu0tqUiH52Wp+Oy435zXQsTY
   LN99o35JQbc/abiJmDEfuHN81vVxBhwnIyyekhCftuvvoUADg5FZd4xlB
   9RPidOqYIHe/miafBXxveUKzPSJtRI+PN4pyDkFrXlyoRXytTaLZIhWoU
   r6XMKTb3MmOi/O+rZpTH5ykWryVcybU01+06X3U3uIvfPEWOR8uabtpXz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334249275"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="334249275"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="801660804"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="801660804"
Received: from ikably-mobl.amr.corp.intel.com (HELO [10.255.33.96]) ([10.255.33.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:54:57 -0800
Message-ID: <235cf556-10a9-c461-e4bf-700ab8c32d51@linux.intel.com>
Date:   Fri, 10 Mar 2023 10:45:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V7 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
 <20230310162554.699766-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230310162554.699766-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/23 10:25, Vijendar Mukunda wrote:
> AMD ACP(v6.x) IP block has two SoundWire manager devices.
> Add support for
>   - Manager driver probe & remove sequence
>   - Helper functions to enable/disable interrupts,
>     Initialize sdw manager, enable sdw pads
>   - Manager driver sdw_master_ops & port_ops callbacks
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Apart from debatable style issues in the way local variables are exposed
(inconsistent use of multiple variables/line, random variations to
reverse x-mas tree), this looks good enough to me for an initial
contribution.

Thanks for bearing with my feedback.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

