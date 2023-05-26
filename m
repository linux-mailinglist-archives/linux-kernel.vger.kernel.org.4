Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEA712677
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjEZMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEZMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:21:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65ECA4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:20:55 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBYFLH030993;
        Fri, 26 May 2023 07:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=8FRvUnxeEwWZA99tu0bOyIubM9mJTTwebRYyDDCDp1M=;
 b=d4TNlwFuHIF7v+/nQZCuH+xjWv7fnu4l2ynjznlpiJpCjLp//a+w9st69/po+suYGOBr
 1tBsUSS1cfykLtxbSannu7qDCXTVIXXBRaefxe4C7SDcW9D3rm8v5m191bF+72zAeIae
 EOv4x96FQMufJqyLW4m86O+fgcVFj1rC0rt8UPLxFvqgF02S7ZdsQRHvD7huPSKZq7IC
 iXlMZkT1CskFhZBBTMRbm5Qa3fZsc91Ugx2/fzrfBD2Oa3Zprc+tYi6xdollPVx/rMCH
 FbOe0pNeVsOc9ZjF233FQeDeYorN6jcS57z/sYUbVwXjcyQPkdlB3f5UF4xiM+vBH9M5 Kg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm8d5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:20:34 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 26 May
 2023 07:20:32 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 26 May 2023 07:20:32 -0500
Received: from [198.61.65.166] (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5F4F2B38;
        Fri, 26 May 2023 12:20:32 +0000 (UTC)
Message-ID: <7c5f776d-bf17-ea3d-a4ee-3ac54194a215@opensource.cirrus.com>
Date:   Fri, 26 May 2023 13:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 13/13] ALSA: hda/cs35l56: Add driver for Cirrus Logic
 CS35L56 amplifier
Content-Language: en-US
To:     <Claudiu.Beznea@microchip.com>, <tiwai@suse.com>,
        <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <simont@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
 <20230525150659.25409-14-rf@opensource.cirrus.com>
 <6ff4235d-f8d0-3c3f-cc67-18aadee2afbc@microchip.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <6ff4235d-f8d0-3c3f-cc67-18aadee2afbc@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RWDcGByEdYWf6UE-LrUN2hVXgR0W9kqc
X-Proofpoint-GUID: RWDcGByEdYWf6UE-LrUN2hVXgR0W9kqc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/5/23 05:40, Claudiu.Beznea@microchip.com wrote:
> On 25.05.2023 18:06, Richard Fitzgerald wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> From: Simon Trimmer <simont@opensource.cirrus.com>
>>
>> Add a driver for the Cirrus Logic CS35L56 amplifier. This uses the same
>> component binding API as the CS35L41 driver. This is not a standalone
>> HDA device; it provides control of the CS35L56 for systems that use a
>> combination of an HDA codec and CS35L56 amplifiers with audio routed
>> through the HDA codec.
>>

<SNIP>

>> +
>> +       cs35l56->base.reset_gpio = devm_gpiod_get_index_optional(cs35l56->base.dev,
>> +                                                                "reset",
>> +                                                                cs35l56->index,
>> +                                                                GPIOD_OUT_LOW);
>> +       if (IS_ERR(cs35l56->base.reset_gpio)) {
> 
> devm_gpiod_get_index_optional() can also return NULL.
> 

Yes, that is expected. It's optional. It's not an error.
In that case cs35l56->base.reset_gpio will already be NULL.

>> +               ret = PTR_ERR(cs35l56->base.reset_gpio);
>> +
>> +               /*
>> +                * If RESET is shared the first amp to probe will grab the reset
>> +                * line and reset all the amps
>> +                */
>> +               if (ret != -EBUSY)
>> +                       return dev_err_probe(cs35l56->base.dev, ret, "Failed to get reset GPIO\n");
>> +
>> +               dev_info(cs35l56->base.dev, "Reset GPIO busy, assume shared reset\n");
>> +               cs35l56->base.reset_gpio = NULL;
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       dev_err(cs35l56->base.dev, "Failed property %s: %d\n", property, ret);
>> +
>> +       return ret;
>> +}
