Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8336A479E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjB0RNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjB0RNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:13:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1138421D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677517978; x=1709053978;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=heJxswUr8eAn1KOvEZyHmciQ28qADJo0M3WNsxy8kk4=;
  b=PjqpSvemBbceDQFqU6QFmkMho29MQs6ZZ7GcMvfOz2I8JuNXBAa5bTY+
   W76JwMX4BJDUta9eaMOsG2VCIFinX9k0YBhV/i+TjxRRPrK4xnhkD9UBO
   oyWeK39V5L/qVI7c7mpjvb901n2RXxpVgrazeZFVZ+H3gjDyiYAdc+CYC
   bRQyeeJTO/yKE04xqkFbpy8srxsLoq7zeRNvs1mZdqZaIxPIbTh3UiPeE
   EKRudj5up5/Q2gMgocI/ufiudHhF+N6C+B5SLXSghF3QUPcI7seKbTAoG
   tbKkkT6m+Wc2QPCtT5wuyTlwigJUUHMaQSdgHhqbSmrFg9PALIdpD95Co
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313583670"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313583670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651302245"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="651302245"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:08:26 -0800
Message-ID: <73b2a130-98a4-d0c5-8cb1-488edd925de2@linux.intel.com>
Date:   Mon, 27 Feb 2023 11:37:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V4 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-4-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230227154801.50319-4-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 10:47, Vijendar Mukunda wrote:
> Register dai ops for SoundWire manager instances.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

