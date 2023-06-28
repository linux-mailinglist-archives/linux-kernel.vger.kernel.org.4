Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED5741640
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjF1QVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:21:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41392 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230304AbjF1QVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:21:46 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SD9iJ3001700;
        Wed, 28 Jun 2023 18:21:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cANbp4lTIZBNTyBSNmcaauw6ZYCKFuy+gZZ75QOuzgo=;
 b=J2xKykgXCi1cE3T71GEW/fHR4RPb/8j49w4V28i1v0YuvSoTYyhudjvZOexJJxlw2BMw
 HH5t+0IGtmGK2hPCcUhgmfjCwFP25xNXHrN9ByZKKK6uMxzrl0x4WOdCgGF/4lZqnTU/
 4jRsdxBW4+Jv98tXRUZqSaaHJVuo29u7AeNZc0GSkU2u0QfQXhZNyhvfvB/nALT9p4ST
 RF09N+r13ndFQOXHRLKcGYAn2RmZCPZkTjEI0dmxK9MMfQoUpBap996H4+CZGGDBG2be
 /TdkkA4bl/MR9h8Pjn9b0kJ7wovOxnjmBHHJeKHFPrlHE//F52h82fL3+vB1TBuzhEa/ Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rgngn92ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 18:21:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD9D8100057;
        Wed, 28 Jun 2023 18:21:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A0A0623152C;
        Wed, 28 Jun 2023 18:21:12 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 28 Jun
 2023 18:21:12 +0200
Message-ID: <c232e3f1-b703-d8d2-7e2d-19ed3f5fc3ad@foss.st.com>
Date:   Wed, 28 Jun 2023 18:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] spi: stm32: disable device mode with st,stm32f4-spi
 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230627123906.147029-1-valentin.caron@foss.st.com>
 <0815474b-a8fa-f486-fc6e-a85df88ed9b9@linaro.org>
Content-Language: en-US
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <0815474b-a8fa-f486-fc6e-a85df88ed9b9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_11,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/23 15:39, Krzysztof Kozlowski wrote:
> On 27/06/2023 14:39, Valentin Caron wrote:
>> STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
>> Stop probing if this case happens, and print an error with involved
>> compatible.
>>
> ...
>
>>   
>>   static const struct of_device_id stm32_spi_of_match[] = {
>> @@ -1798,8 +1802,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
>>   	struct device_node *np = pdev->dev.of_node;
>>   	bool device_mode;
>>   	int ret;
>> +	const char *compatible =
>> +		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev)->compatible;
> The goal was to replace it, so drop it.
Is is still needed for dev_err, so I can't
 > dev_err(&pdev->dev, "spi-slave not yet supported with %s\n", 
compatible);
>
>> +	const struct stm32_spi_cfg *cfg = (const struct stm32_spi_cfg *)
> Why do you need the cast? To drop the const? Are you sure it is really
> needed?
Effectively, this cast is useless, I will drop it.
>> +		of_device_get_match_data(&pdev->dev);
> Best regards,
> Krzysztof

Thanks,
Valentin

