Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4640A736C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjFTM74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjFTM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:59:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B867199E;
        Tue, 20 Jun 2023 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687265977; x=1718801977;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ppz5GRSz8+PUi7YOQuxhF2hz7S1cp4ihR/22egVfqhA=;
  b=Oz/3mEIPyqr4wT3n2wOgi7P0OFbst0GUnx/uP3I+RHEd6+1Ct7hyIAzr
   hI96JSOXt9Od44yLoD8IbbrSRsG1IEvRg+xaMeEZgp15oCgo+g8R0r/2T
   xSyGcwDgbfG/v88OME2SQgcUES3BBXw3m+NKKgbHGDaLcYE2cT2IykeCX
   xdS5TLfgoNmt7gP26x6Gm/JftQNqvkxwz2qci9GmvfJ1T+3j9ER22JXQd
   PI2iWfoD0Qxg2hHgkzIIXB2iQ2PR2fcMkax9G1UV1lEjMxsGkwtZiH+5a
   a8jK2rFOPg3Km9f5buwHRsr/9uJRdtwyjLStrJXwQXjB3uI+xOolCpMO7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349582721"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349582721"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 05:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708256245"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="708256245"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 05:59:32 -0700
Message-ID: <daffc540-3b99-f71d-538b-84c897730208@linux.intel.com>
Date:   Tue, 20 Jun 2023 15:59:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v8 0/5] DesignWare PWM driver updates
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20230614171457.69191-1-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 20:14, Ben Dooks wrote:
> This series is an update for the DesignWare PWM driver to add support for
> OF (and split the PCI bits out if aynone else wants them). This is mostly
> the same as the v7 series, but with code moved around and module-namespace
> added, plus review comments processed.
> 
> Since we no longer have the hardware, the clock code hasn't been changed to
> either lock the rate whilst the PWM is running, or to deal with any sort
> of change callback. This is left to future work (and I would rather get
> something in that does currently work) (second note, the hardware we did
> use had a fixed clock tree anyway)
> 
> This account is probably going away soon, I have cc'd my main work
> email to catch any responses.
> 
> Thank you all for the reviews.
> 
I tested the patchset on Intel Elkhart Lake and didn't see issues.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
