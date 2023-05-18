Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58C70855D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjERPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjERPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:53:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066B19B;
        Thu, 18 May 2023 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684425206; x=1715961206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yy5e77k3doOrxSyCFI2HBiEAmW7848CBCulkXIzrGcU=;
  b=NRClt+o36ziN4WrPdqP0zeNJdi8bfcX5cqaPoQSLCpVsWDy+CoVFzVVl
   jRWHLQXcL25/hWlwALbVJphYJMlRaz/r0ciN83YmcQmJXjQRGPuFZXz+N
   dYmn3YjRCsiGWRYHTj83oGhjNsJnZ+HgCaV8CeGsPB+75QS/9mcGSfnye
   0rE2UPsTccpmh7qzXN8n7cau4ilxmEBpXxL4TLRFjEBG1MW0C+WnZwNNk
   j6Crxb1SJHOlxTB2vhJGV7n/3vkGNkZhhAa7ZsOeiW7iRIiBayLuTK9Ad
   4ZK63L8jNG7d+g4QGxaw9vdLUZFThq8HucJDvKW2YHVDiFuQ6S8enG0l0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336692208"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="336692208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702172670"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="702172670"
Received: from nithinks-mobl1.amr.corp.intel.com (HELO [10.209.80.104]) ([10.209.80.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:53:23 -0700
Message-ID: <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
Date:   Thu, 18 May 2023 10:16:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
 <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
>>> +				    ARRAY_SIZE(cs42l43_reva_patch));
>>> +	if (ret) {
>>> +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	pm_runtime_mark_last_busy(cs42l43->dev);
>>> +	pm_runtime_put_autosuspend(cs42l43->dev);
>>> +
>>> +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
>>> +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
>>
>> I don't why adding devices is not in probe. They use the same regmap
>> right? So there will be no problem in probing them from MFD probe.
> 
> Well except SoundWire is a bit of a special boy, the hardware is
> not necessarily available in probe, the hardware is only available
> at some point later when the device attaches. Doing it this way all
> of the attaching (and various detach/attach cycles the device needs
> during configuration) are over by the time the child drivers bind, so
> they don't all need special code to handle that.

if the devices are added in the probe, then the regmap needs to be moved
to cache-only and another special API would be needed to tell the MFD
framework to turn the regmap cache-only off.

But if it's the same regmap, the regmap cache is handled in the
SoundWire update_status callback so maybe  Krzysztof's proposal does work?
