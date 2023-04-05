Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D86D7B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjDELfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjDELfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:35:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C651BD7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680694540; x=1712230540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z4M+lGF3PxW5jIEFmkFI2Pz3GGvuMaU0PB9nsRWm/Lw=;
  b=Hwcs9KWlyi8Y93C/nzd+FGEtcdQeEevE3hRgWNanU/7O7h/iJbDS1KnT
   XbBpFb9k+u26nvsb2atOAoqht9L3RW7VlEsXIEiEqlZT3QIoh06V5HZ5s
   sQwwzMamvkVekCUfFlSHLR6KC5CKCtch1JFf5Y7Bjh7rUGPGbVvZBHAtH
   hkfuOdtRbugcej2XKKTL7RayOKoCfqFstkfSQuwfwr/fGdwNf0xKDYGDo
   CRjlZVaSUrgLHBORYoHHgUzPhOcFf5vZyRXj3jB3ahHmMLK0E55ITrYRr
   nHDVEjiF/jaEFFpclDiQ1sSSmm2/wa38AJVwBXuvSaUyxgyH8UppyWn+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370257021"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="370257021"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="860943315"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="860943315"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:35:36 -0700
Message-ID: <030c2cbf-dec3-91fb-ac82-949cf5764b78@linux.intel.com>
Date:   Wed, 5 Apr 2023 13:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
Content-Language: en-US
To:     "Ding, Shenghao" <shenghao-ding@ti.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Baojun" <x1077012@ti.com>, "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        Shenghao Ding <13916275206@139.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
References: <20230329100107.8181-1-13916275206@139.com>
 <8d0d0478-1e45-ea52-f1b7-910b747d6282@linux.intel.com>
 <7a0cfa60e2a244168edd49c3d2f6a2bd@ti.com>
 <458d7c2f-bcee-9ec3-e955-9661a06a3349@wanadoo.fr>
 <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <bbae9e35f2bf4cbcbc78f852041e4b2e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2023 1:21 PM, Ding, Shenghao wrote:
> Hi Both
> I wrote a test code to verify the be32_to_cpu & be32_to_cpup,
> static int __init lkm_init(void)
> {
> 	char test_buf[]={0x12, 0x34, 0xab, 0xbc, 0x56, 0x78, 0xef};
> 	unsigned int *k, p, q;
> 	int i;
> 
> 	printk("Hello, Shanghai!\n");
> 
> 	for (i = 0; i < 4; i ++) {
> 		k = (unsigned int *)&test_buf[i];
> 		p = be32_to_cpup((__be32 *)k);
> 		q = be32_to_cpu(test_buf[i]);
> 		printk("%d: *k = 0x%08x p = 0x%08x q = 0x%08x %ld\n",
> 			i, *k, p, q, sizeof(unsigned int));
> 	}
> 	return 0;
> }
> The output is:
> [ 9109.722548] Hello, Shanghai!
> [ 9109.726287] 0: *k = 0xbcab3412 p = 0x1234abbc q = 0x12000000 4
> [ 9109.727665] 1: *k = 0x56bcab34 p = 0x34abbc56 q = 0x34000000 4
> [ 9109.728553] 2: *k = 0x7856bcab p = 0xabbc5678 q = 0xabffffff 4
> [ 9109.729308] 3: *k = 0xef7856bc p = 0xbc5678ef q = 0xbcffffff 4
> Apparently, be32_to_cpup's output is what I expected.
> Looking forward to your comments. Thanks.
> 

It makes sense, as array access reads 8 bit value, you would need to 
access value using pointer instead. So instead of doing 
be32_to_cpu(test_buf[i]) you would need to do be32_to_cpu(*(test_buf + 
i)) if I didn't mess the pointer magic ;)

And then I'm not sure which is better, be32_to_cpup or be32_to_cpu.

> BR
> Shenghao Ding
> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Saturday, April 1, 2023 4:41 AM
> To: Ding, Shenghao <shenghao-ding@ti.com>; Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>; Shenghao Ding <13916275206@139.com>; broonie@kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-louis.bossart@linux.intel.com
> Cc: Lu, Kevin <kevin-lu@ti.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Xu, Baojun <x1077012@ti.com>; Gupta, Peeyush <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
> 
> Le 31/03/2023 à 04:19, Ding, Shenghao a écrit :
>> Hi Amadeusz Sławiński
>> Thanks for your comment.
>> Answer inline.
>>
>> -----Original Message-----
>> From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
>> Sent: Thursday, March 30, 2023 7:54 PM
>> To: Shenghao Ding <13916275206@139.com>; broonie@kernel.org;
>> lgirdwood@gmail.com; perex@perex.cz;
>> pierre-louis.bossart@linux.intel.com
>> Cc: Lu, Kevin <kevin-lu@ti.com>; Ding, Shenghao
>> <shenghao-ding@ti.com>; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org; Xu, Baojun <x1077012@ti.com>; Gupta,
>> Peeyush <peeyush@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
>> Subject: [EXTERNAL] Re: [PATCH v10] ASoC: tas2781: Add tas2781 driver
>>
>> On 3/29/2023 12:01 PM, Shenghao Ding wrote:
>>> Create tas2781 driver.
>>>
>>> Signed-off-by: Shenghao Ding <13916275206@139.com>
>>>
>>> ---
>>> Changes in v10:
>>>     - using be16_to_cpu and be32_to_cpu instead of SMS_HTONS and SMS_HTONL
>>>     - optimize and reduce the boundary checks
>>>     - Add comments on some kmemdup instead of kzalloc+memcpy
>>>     Changes to be committed:
>>> 	modified:   sound/soc/codecs/Kconfig
>>> 	modified:   sound/soc/codecs/Makefile
>>> 	new file:   sound/soc/codecs/tas2781-dsp.c
>>> 	new file:   sound/soc/codecs/tas2781-dsp.h
>>> 	new file:   sound/soc/codecs/tas2781-i2c.c
>>> 	new file:   sound/soc/codecs/tas2781.h
>>> ---
>>
>> ...
>>
>>> +
>>> +static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
>>> +	struct tasdev_blk *block, const struct firmware *fmw, int offset) {
>>> +	const unsigned char *data = fmw->data;
>>> +
>>> +	if (offset + 16 > fmw->size) {
>>> +		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
>>> +		offset = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +	block->type = be32_to_cpup((__be32 *)&data[offset]);
>>
>> Wouldn't just be32_to_cpu(data[offset]) work instead of be32_to_cpup?
>> Same in other cases.
>> [DING] data[] is a char array, the code will convert data[offset],
>> data[offset + 1], data[offset + 2] and data[offset + 3] into host instead of data[offset] only.
>>
> 
> Not sure to follow you.
> Isn't it the purpose of be32_to_cpu() to take a 32 bits word, in other words 4 x 8 bits char, and swap what if needed (little endian arch)?
> 
> It ends to __swab32() ([1] for the "constant" implementation)
> 
> 
> be32_to_cpup(&p) ends to __swab32(*p), which really looks to the same as be32_to_cpu(p).
> 
> Can you elaborate more?
> 
> CJ
> 
> 
> [1]:
> https://elixir.bootlin.com/linux/v6.3-rc3/source/include/uapi/linux/swab.h#L18
> 

