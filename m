Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8E6FA110
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjEHHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjEHHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:31:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC23C3B;
        Mon,  8 May 2023 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683531099; x=1715067099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3nm7aSt0DFMclJqVyDYsQtyYwsSpDIUwMLJXetpid2s=;
  b=gMfzmMCU5qiu8xYlrqvRZNcIfbLDmtRAHM7fKkVv2WpiA7ts4gvfuEAG
   GoRyLZenhrIB7CnHHDcuf9cJMPXveyNW7Mwthw6EDHXx+j1aqLKtb6Sv9
   OtYEMqiKM+Lxlsh7S+fBcSjdOG5B3OH40dA/jV8ryNTjsSqKdqXIunBs+
   ya5NCziVq3mW37p5jRzRnK8sSyjnvLS/VSZ7GUxR3r1dNBg8S1Fhy1+Ud
   kSYzb4nqNXw7iuLn9EXll3zusAjFj4SjVsuz+0qOwqOyQtFUI42mrTkHh
   FB9NxwVvKc4SGZDZNktfDsAEhCx1eIR73UTdRdTX1zAZfTlEidzR2Z3GY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329200243"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329200243"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767967877"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767967877"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:31:34 -0700
Message-ID: <68205138-a0ae-f6cf-c81b-e94168a01a29@linux.intel.com>
Date:   Mon, 8 May 2023 09:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/5] ASoC: tas2781: Add Header file for tas2781 driver
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com
References: <20230508054453.700-1-13916275206@139.com>
Content-Language: en-US
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230508054453.700-1-13916275206@139.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 7:44 AM, Shenghao Ding wrote:
> Create Header file for  tas2781 driver.
> 
> Signed-off-by: Shenghao Ding <13916275206@139.com>
> 
> ---
> Changes in v2:
>   - fixed issue | Reported-by: kernel test robot <lkp@intel.com>
>     | Link: https://lore.kernel.org/oe-kbuild-all/202305022033.LiI7Ojm4-lkp@intel.com/
>   Changes to be committed:
> 	new file:   include/sound/tas2781-dsp.h
> 	new file:   include/sound/tas2781-tlv.h
> 	new file:   include/sound/tas2781.h
> ---

...

> +enum channel {
> +	top_left_Chn,
> +	top_right_chn,
> +	bottom_left_Chn,
> +	bottom_right_chn,
> +	max_chn,
> +};

Why some enums have capitalized Chn? Just use chn everywhere.



