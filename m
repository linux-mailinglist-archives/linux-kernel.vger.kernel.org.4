Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361406D15ED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCaDUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCaDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:20:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CC12CE6;
        Thu, 30 Mar 2023 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680232810; x=1711768810;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ZADYbqfNW8xuM7gMaCx6gIrssaqHTZAewavO5POSwPk=;
  b=P7e6DgeWuLQzfVZQr7T3Zf21eDGx5wkSma7q9tlEKYCyetXCB9fiREg/
   FBt0gMIL0kZxJ4xvdvY8S4/CV2xF9VqIjwyUC0IIclTgEBAyo0Q5cT5jj
   iI7+jM83hJUdCniTm0oZHCtLNxrbfziS3Hjz39gOmNwIe4N28RI5IJ/8s
   pLJQq0gfGwsjRSvscIfxzh6CTJYkpopdL1LHch4EptpAGTUYRK0mFmHkg
   +8S+gzBETJIvxcAHOghCIxpZjsLQZ1aoMJUzgRMgjcxTYCUqWUpwqi5/1
   +eULURATzyXo+8vQE1062Frw4yfDPfdqMPOfA/z78ljQwQxKvyySXA2XT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="342992684"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="342992684"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="684938166"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="684938166"
Received: from chuaweiz-mobl.amr.corp.intel.com (HELO [10.209.109.216]) ([10.209.109.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:20:07 -0700
Message-ID: <3af2945e-9a0e-c23a-ff06-d070692f5202@linux.intel.com>
Date:   Thu, 30 Mar 2023 22:12:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH V4 1/2] ASoC: max98363: add soundwire amplifier driver
Content-Language: en-US
To:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org,
        rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        herve.codina@bootlin.com, wangweidong.a@awinic.com,
        james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
References: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230330234319.6841-1-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 18:43, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> Added Analog Devices MAX98363 SoundWire Amplifier Driver.
> The MAX98363 is a SoundWire peripheral device that supports
> MIPI SoundWire v1.2-compatible digital interface for audio and
> control data.
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>

LGTM

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
