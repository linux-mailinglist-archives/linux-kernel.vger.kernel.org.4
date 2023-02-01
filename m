Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51603686834
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBAO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:26:48 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A43D91B;
        Wed,  1 Feb 2023 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675261607; x=1706797607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=71c35E+QlELiDoCRu9TrKbxnNSfXkZbgGsnlKAeDVBU=;
  b=gAmzrnFS3kr+f+f0P5VTEyR02XhSwrZ7CrD6sYYAzYsfCNymKxqg8Z5Y
   u7x242FObY1YKrd23RAULtZhcvN5VfPc0sRoshI2vLt8IjQwE8wCHXLeb
   wTBl9hyyXUKb1zqSyi4F7Aji0lGDrxW0rN4FlVY9xY1L8fXcrhBOuz63e
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Feb 2023 06:26:46 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 06:26:45 -0800
Received: from [10.50.40.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 06:26:36 -0800
Message-ID: <fd8ab034-7a50-0d28-dbfc-601a30f97af7@quicinc.com>
Date:   Wed, 1 Feb 2023 19:56:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/6] arm64: defconfig: Enable ipq6018 apss clock and PLL
 controller
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
 <20230113143647.14961-4-quic_devipriy@quicinc.com>
 <b8b90989-4bc9-f3a9-516e-2101bfc2293d@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <b8b90989-4bc9-f3a9-516e-2101bfc2293d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review the patch

On 1/31/2023 3:01 PM, Dmitry Baryshkov wrote:
> On 13/01/2023 16:36, devi priya wrote:
>> Enable the PLL controller and IPQ6018 APSS clock controller
> 
> ... it is used on several IPQ platforms to clock the CPU so it should be 
> enabled and built-in.
> 
Okay, got it. Will update the commit message as suggested in V2
>>
>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> 
> Just to check: is the capitalization correct in your name here and 
> everywhere else? (please excuse my ignorance here, I do not know all the 
> spelling/capitalization rules).
> 
Sure, will change the naming style to Camel Case
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index e0ae0996d5ad..8de3979b10a3 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1092,6 +1092,7 @@ CONFIG_QCOM_CLK_APCS_MSM8916=y
>>   CONFIG_QCOM_CLK_APCC_MSM8996=y
>>   CONFIG_QCOM_CLK_SMD_RPM=y
>>   CONFIG_QCOM_CLK_RPMH=y
>> +CONFIG_IPQ_APSS_6018=y
>>   CONFIG_IPQ_GCC_6018=y
>>   CONFIG_IPQ_GCC_8074=y
>>   CONFIG_IPQ_GCC_9574=y
> 
Best Regards,
Devi Priya
