Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4869F3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBVLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:49:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B37311F8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:49:14 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M6S5e8008960;
        Wed, 22 Feb 2023 05:49:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=bR/ucIevVMrHwf818cMwYH7s5N4nnBuw/fCj1Y965Mo=;
 b=eWS4T6oCQj/BBCHmMiODFiOj9PBqBlnmGJL4dJOMmmCcrZIAREUydBp5edMoMsRqQcrW
 S2wg6YW9xvqowIt8wi/0J3hyzW6WdaFIA5D8xuEZ5vGvzM7S2gfhAMxhRljgsgAjokGE
 sOILL2jAQ3nvbntX0+b8afLMPYmx7zJlgOEEQ1QyOZIdHTX7E8AuG8wNQ69hoQDbi0WB
 37CWVIxhzjcJQoIagC1pWef7kJ/q3KRTbbVy/mOMrjzWnAVk+N/Yun1hMMnqWvXMAZWd
 72sckrEdJx6bx8vSUscgFzPi8KW9qV/4IKltw9Ovhv+XO5gk0mESGn0h83lqnDSAiDnI oQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ntvy7n02f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 05:49:01 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 22 Feb
 2023 05:48:59 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 22 Feb 2023 05:48:59 -0600
Received: from [198.90.251.127] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C13AB0E;
        Wed, 22 Feb 2023 11:48:59 +0000 (UTC)
Message-ID: <941c3c3f-673f-a4b8-092d-d495de9da9dd@opensource.cirrus.com>
Date:   Wed, 22 Feb 2023 11:48:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 10/10] ASoC: Intel: soc-acpi: Add CS35L56 Soundwire to TGL
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <broonie@kernel.org>, <cezary.rojewski@intel.com>,
        <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-11-rf@opensource.cirrus.com>
 <20097f1d-a7ef-9932-685c-afb22006076c@linux.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20097f1d-a7ef-9932-685c-afb22006076c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mNoATPT44rNtCSl7JuAVocIIXKqPLQ8k
X-Proofpoint-GUID: mNoATPT44rNtCSl7JuAVocIIXKqPLQ8k
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 16:52, Pierre-Louis Bossart wrote:
> 
>> +static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_one[] = {
>> +	{
>> +		.mask = BIT(0),
>> +		.num_adr = 1,
>> +		.adr_d = cs35l56_sdw0_adr,
>> +	},
>> +	{}
>> +};
>> +
>> +static const struct snd_soc_acpi_link_adr up_extreme_cs35l56_sdw0_four[] = {
>> +	{
>> +		.mask = BIT(0),
>> +		.num_adr = 4,
>> +		.adr_d = cs35l56_sdw0_adr,
>> +	},
>> +	{}
>> +};
> 
> If the machine driver has support for the 2-amplifier configuration,
> shouldn't it be present here as well?
> 

Not necessarily.
It's not a setup we're currently using on this initial TGL
configuration.

The machine driver we'd expect to work on multiple hardware. The
counting algorithm has to go through "2" anyway, and the code to
handle that is so trivial we may as well include it.

>> +
>>   /* this table is used when there is no I2S codec present */
>>   struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
>>   	/* mockup tests need to be first */
>> @@ -501,6 +546,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
>>   		.drv_name = "sof_sdw",
>>   		.sof_tplg_filename = "sof-tgl-rt711.tplg",
>>   	},
>> +	{
>> +		.link_mask = BIT(0),
>> +		.links = up_extreme_cs35l56_sdw0_four,
>> +		.drv_name = "sof_sdw",
>> +		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
>> +	},
>> +	{
>> +		.link_mask = BIT(0),
>> +		.links = up_extreme_cs35l56_sdw0_one,
>> +		.drv_name = "sof_sdw",
>> +		.sof_tplg_filename = "sof-tgl-cs35l56-sdw0.tplg"
>> +	},
>>   	{},
>>   };
>>   EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);
