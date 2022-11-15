Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7486297A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiKOLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKOLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:41:50 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B321824
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:41:48 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF8JZWD002582;
        Tue, 15 Nov 2022 05:41:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=9KF0EFIu5GFZmsPwf8xI4U874ouEdeeDRfnS9r8p1MM=;
 b=PGN87a+qjhcm53UrwVC9jufNnvOnsDtRRNd08d2dl3+rvQqi66GAQBlOPP3CsxMZmx3j
 1rIdbBZh1cjDLHYNQmEhR4YKvqJFTOIGbM/QEuhOy0BaVSH9q/Wm5u4+VaTFtObOd9CA
 E/7uJioXpUa3QiqHzGa1Zmk5Z+XB7kqSP2uas4MWIPGpHIZo0GE64O/lKYxZVilpVeVF
 0VN7TTX8dT//V6zaAcdFg/R4lNljWnaOGOX3zr/NLBaq7L+SrUrP0c8Fa/B+X/8K1IPR
 SUZsYkNLZ1O+VD9+1XvPwr5FFW7P3jA+uGBLO3iDtirdVeDod1mq2pJlN2ecMIHafkRG 6A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kv73yg5xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 05:41:38 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 15 Nov
 2022 05:41:36 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Tue, 15 Nov 2022 05:41:36 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8DD5D46B;
        Tue, 15 Nov 2022 11:41:36 +0000 (UTC)
Message-ID: <730128a9-46ce-02b2-f88d-c9982fff2e69@opensource.cirrus.com>
Date:   Tue, 15 Nov 2022 11:41:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] soundwire: Provide build stubs for common functions
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-3-ckeepax@opensource.cirrus.com>
 <90b01c76-fc65-a57f-9247-fae78241342c@linux.intel.com>
 <20221115110345.GM10437@ediswmail.ad.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20221115110345.GM10437@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OsEL-2q4-CHKB36X-TLNp32ZRVT9gneW
X-Proofpoint-GUID: OsEL-2q4-CHKB36X-TLNp32ZRVT9gneW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 11:03, Charles Keepax wrote:
> On Mon, Nov 14, 2022 at 10:13:07AM -0600, Pierre-Louis Bossart wrote:
>>
>>
>> On 11/14/22 04:29, Charles Keepax wrote:
>>> Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
>>> that are quite likely to be used from common code on devices supporting
>>> multiple control buses.
>>
>> So far this case has been covered by splitting SoundWire related code
>> away from, say I2C, and with a clear 'depends on SOUNDWIRE'. This is the
>> case for rt5682, max98373, etc.
>>
>> Is this not good enough?
>>
>> I am not against this patch, just wondering if allowing code for
>> different interfaces to be part of the same file will lead to confusions
>> with e.g. register offsets or functionality exposed with different
>> registers.
>>
> 
> I guess this is a bit of a grey area this one. Both work, I guess
> the reason I was leaning this way is that in order to avoid a
> circular dependency if I put all the soundwire DAI handling into
> the soundwire code then I have to duplicate the snd_soc_dai_driver
> structure into both the sdw and i2c specific code (worth noting
> the I2S DAIs are still usable when the part is sdw to the host). But
> there are also downsides to this approach in that it will likely have
> some small impact on driver size when soundwire is not built in.
> 

I think we should just add the stubs. Other subsystems use stubs to help
with code that references stuff that might not be available.

Splitting all the soundwire-specifics out into a separate module works
for simple chips that are either I2S or soundwire. but can get messy for
a complex codec. I used the separate file method for CS42L42, but for a
driver I'm working on I abandoned that and put both DAIs in the core
code. I didn't notice the missing stubs because my defconfig that was
intended to omit soundwire apparently has something that is selecting
it anyway.
