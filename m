Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F360EA66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiJZUmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiJZUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:42:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0929F35E;
        Wed, 26 Oct 2022 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666816919; x=1698352919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rBT0PII3za2aGVCQVmX15R78vHrk5mnZYW0vaDCMOXg=;
  b=m9Yu7TayNxnNrQbNBw64FpM37Z/npEdy94NdL97PG0cKBlxpXIekqH3H
   3qu+1Iuv0XH1euQukihYDCPDfmX/AeA5XrRFFuWk96KnxWUoBKoOqPQld
   Ve0Mg050skleltAxvGm+wNdJrG8HlkGLD0l3LxVFb1yq3HsfFyUXZvLuH
   4fSHJsQbkk+w9H8IzJ7JyrSZMhjIMZjFDq+ircR4/oxZZK1fvDhRkb2ju
   FSvSFu9KmEm4am1JA9YpHwPjXcWMKS865Bbxb6X6n3wn21uss0F+j9DSZ
   H9v0DxqtEDObQrb6rJc+IIpyDAdwdBH8Ee3DfTA5WVBLOLCA31HuP7un9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="288450835"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="288450835"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:41:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="610103296"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="610103296"
Received: from bcoan-mobl2.amr.corp.intel.com (HELO [10.209.189.197]) ([10.209.189.197])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 13:41:57 -0700
Message-ID: <e3ebba30-65ec-183a-eb91-c5147c28441d@linux.intel.com>
Date:   Wed, 26 Oct 2022 15:14:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] soundwire: qcom: add support for v1.7 Soundwire
 Controller
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
 <20221026110210.6575-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221026110210.6575-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1582,6 +1597,7 @@ static const struct of_device_id qcom_swrm_of_match[] = {
>  	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>  	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>  	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
> +	{ .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },

is this line intentional, it looks odd that 1.7 is compatible with 1.5,
but 1.6 isn't?


