Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3093609CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJXIkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJXIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:40:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6A23E81;
        Mon, 24 Oct 2022 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666600801; x=1698136801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qSqf3GoAdrUKrL08IAjfyc7oJTBmbWa0J0R/wRLkH1Q=;
  b=KKIKL1esS/wKrOQ1m1ysjcRlBwCQQm40EwvCw39s78YQhb5SPy1CujUe
   3BCTAeR5N/i9WDVattFV5RPT5mtC7JMX7fLNH2VGZa4XmgEwNpVdkNBfk
   Qt77Jl/cdpJRSYkYQKPYZK1A4eSYx1szgMhZQpEbZ8p8oVOpVNe/qtwfR
   AMB0NJHjkETHGROaeQRLB3k6BtLs3p99Wg/gDsIyYjaxiWqPTtGO8K5VO
   M/4cR4e6iyO2E+pJKOBT3229uKEp/OR2j9o0+wY4SGrF0tHvtTY8s/XC6
   UYyDUJ2gRJYjk41Jq++Mvihu/+1be2BMKkJPsdW2fx0dsg7mV7Nj3wS9a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="290670080"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="290670080"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 01:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="609121584"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="609121584"
Received: from mylly.fi.intel.com (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2022 01:39:57 -0700
Message-ID: <623284c8-f4bb-1020-2f2e-a475f424c5b5@linux.intel.com>
Date:   Mon, 24 Oct 2022 11:39:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH v6 00/10] Designware PWM driver updates for OF
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
Content-Language: en-US
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 10/20/22 18:16, Ben Dooks wrote:
> This is an updated version of the Designware PWM driver updates
> for OF support, which now splits the driver into PCI and OF parts
> as well as tries to sort out the review comments.
> 
> Hopefully this can now be queued for the next kernel version.
> 
> v6:
>   - fix removal ordering of DWC_PERIOD_NS

I did a quick test on our HW and PWM was counting as before.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
