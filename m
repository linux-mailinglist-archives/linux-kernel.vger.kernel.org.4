Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2285FD977
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJMMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJMMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:46:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738A102500;
        Thu, 13 Oct 2022 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665665209; x=1697201209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mgH7bqIU6Bj+F/PoYyFSiLKrokyQ/VHmhqjqPAujEZ4=;
  b=QE4ldFPAoQXOizXyZPdjb5z0AgQM6WYbaL+PSbUpt1g5tlTFwx2kQBT/
   e3Ko6vC2PhAwFOHZEMml4bhpgZqmpEqvtIC+sX4Q7VMfVGWff4u0Tokv6
   mzrdbm44NPFRxZiQAdboW6iKQDvLghVYA4n9lT5U18tZg5dNQG2Ql6UO5
   3kNP5lA9caMFUHSeAyRRczGSlLiZ6BCcXsJhGtYLcCsI3Tyqy7AyfM1qO
   Z54IbxIN+JSf6JgItzTokUOSCmz//+y3943IyfKc0KmEXfNyukMacH9zz
   Ng6ZtgA0IjN0Yoa9nhrNNoGjdZvcdTUHCRhxffRwU1r+QBcJl4Uayf/zz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="288338013"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="288338013"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 05:46:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="872313807"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="872313807"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.252.189.128]) ([10.252.189.128])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 05:46:45 -0700
Message-ID: <f84e2722-ca56-8440-a5af-550080bd1f8f@linux.intel.com>
Date:   Thu, 13 Oct 2022 20:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     jeff_chang@ricthek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Jeff <jeff_chang@richtek.com>
References: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
 <Y0f98d0A04f8dzQV@sirena.org.uk>
From:   "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <Y0f98d0A04f8dzQV@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2022 8:00 PM, Mark Brown wrote:
> On Thu, Oct 13, 2022 at 04:06:43PM +0800, Jeff Chang wrote:
>
>> +config SND_SOC_RT5512
>> +	tristate "Mediatek RT5512 speaker amplifier"
> Looks like there's some Richtek/Mediatek branding confusion with this -
> it's a bit unclear.  It's all the same company in the end I guess so it
> doesn't matter.

Interesting, the naming of RT5512 looks like a Realtek codec. ^^


