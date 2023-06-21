Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729FC737BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFUHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjFUHEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:04:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98A10FF;
        Wed, 21 Jun 2023 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687331054; x=1718867054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e+07q9qYK+pw1eO+EaWmvyqs2V9p3O3dm0tM202IcTg=;
  b=nrEQSSUr/8AaSRe0n7VWd4BQn3RuR3R8ina280DDf8IOw0sHI7M/vEn9
   luz62puTBbzCTo4rNywZH8Hl48pFcDVVb06rsv19HytMLHiyBAGD8MpV3
   Z6OnhzN1Tqil5byXCO4Wr/JgrvfrrVkiAG/2Xogm3MEOyKIBE9DJ43uXE
   SmzHaPvREilmfpx+ftWJFZfsUA6t1R9fzQ9tOpmQpVThcUn0cT9V0vxRq
   KX8hYb8V+Zt2nUicK8U90OxaC5N7C1Oihxu4V195x91w4f5QD/AxZNKPb
   IzL8HH3TBNlsJZyHi82IwwZ/7cFEhjmmII1QcBF0UXCIEISQkLWIPgaTM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344827584"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="344827584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804254532"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="804254532"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 00:04:11 -0700
Message-ID: <99948b63-1f12-e9b6-11a2-e564f47b94f0@linux.intel.com>
Date:   Wed, 21 Jun 2023 10:04:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] counter: Fix menuconfig "Counter support" submenu entries
 disappearance
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy.shevchenko@gmail.com
References: <20230620170159.556788-1-william.gray@linaro.org>
 <4341aa87-c3b1-b0a4-4f82-c903c3085df3@infradead.org>
 <ZJIWLYtl6BEHfDZQ@fedora>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <ZJIWLYtl6BEHfDZQ@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 00:12, William Breathitt Gray wrote:
> On Tue, Jun 20, 2023 at 02:00:37PM -0700, Randy Dunlap wrote:
>> Hi,
>>
>> On 6/20/23 10:01, William Breathitt Gray wrote:
>>> The current placement of the I8254 Kconfig entry results in the
>>> disappearance of the "Counter support" submenu items in menuconfig. Move
>>> the I8254 above the menuconfig COUNTER entry to restore the intended
>>> submenu behavior.
>>>
>>> Fixes: d428487471ba ("counter: i8254: Introduce the Intel 8254 interface library module")
>>> Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>> Closes: https://lore.kernel.org/all/32ddaa7b-53a8-d61f-d526-b545bd561337@linux.intel.com/
>>> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>
Thanks, this fixes it.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

