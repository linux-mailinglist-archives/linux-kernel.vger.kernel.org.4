Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB107085BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjERQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:16:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A88E53;
        Thu, 18 May 2023 09:16:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8eCg3027996;
        Thu, 18 May 2023 11:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=4uIzrfDj8yx0WsAt7S6xfJeGhn3K2sZ8xvXkTNP0sSs=;
 b=QreMEFj6gt6rhyfAxnIu4GJbevh18uLMt68Rc7u+MyHknRJjOd/gnVeDW6zZk3PXCF1O
 2PsR5MOX8QWC+S8z+6IKDdTYleb4LsifukGE2M+ABAMCiGLAbgxtPtgkH2lSyRI7KutN
 5Gv7o/BzeJW4hSkDANt8eaVm1RSEL4ZTDRCHV1d37Zw04tNq8eiOmBLbkeMkFir46fGQ
 aRPWWFifk7HORzmNuOikdzKoKI+QHRTdvZSah5xUh/M9CgjCdgq38aufY9LzZPPuT4ZQ
 n9EMDp5rdli0YDn1j4fjfuOucM8eY16/tKs+lAQqiH/L/LZY70mjKPKdR+BAvw/SD30H QA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1gnc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:16:00 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 11:15:58 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 11:15:58 -0500
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 15DD8B38;
        Thu, 18 May 2023 16:15:58 +0000 (UTC)
Message-ID: <049c2470-536a-1b1c-9828-7acb4d483309@opensource.cirrus.com>
Date:   Thu, 18 May 2023 17:15:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
 <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
 <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yv0VGpDpge4JxislDmVeA3nHRvZgiame
X-Proofpoint-ORIG-GUID: yv0VGpDpge4JxislDmVeA3nHRvZgiame
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2023 16:16, Pierre-Louis Bossart wrote:
> 
>>>> +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
>>>> +				    ARRAY_SIZE(cs42l43_reva_patch));
>>>> +	if (ret) {
>>>> +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
>>>> +		goto err;
>>>> +	}
>>>> +
>>>> +	pm_runtime_mark_last_busy(cs42l43->dev);
>>>> +	pm_runtime_put_autosuspend(cs42l43->dev);
>>>> +
>>>> +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
>>>> +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
>>>
>>> I don't why adding devices is not in probe. They use the same regmap
>>> right? So there will be no problem in probing them from MFD probe.
>>
>> Well except SoundWire is a bit of a special boy, the hardware is
>> not necessarily available in probe, the hardware is only available
>> at some point later when the device attaches. Doing it this way all
>> of the attaching (and various detach/attach cycles the device needs
>> during configuration) are over by the time the child drivers bind, so
>> they don't all need special code to handle that.
> 
> if the devices are added in the probe, then the regmap needs to be moved
> to cache-only and another special API would be needed to tell the MFD
> framework to turn the regmap cache-only off.
> 
> But if it's the same regmap, the regmap cache is handled in the
> SoundWire update_status callback so maybe  Krzysztof's proposal does work?

But you still can't access the hardware in probe(). So you'd have all
the child drivers probing but not able to talk to the hardware. The
child drivers would have to hook into the update_status() somehow so
they know when the peripheral has enumerated.
It's simpler to add them after the hardware has enumerated - they will 
be able to access the hardware in their probe().
