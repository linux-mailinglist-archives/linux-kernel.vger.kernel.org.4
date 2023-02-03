Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C160688FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBCGds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBCGdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:33:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87755BD;
        Thu,  2 Feb 2023 22:33:45 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135HhfC001674;
        Fri, 3 Feb 2023 06:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SuTIbaGSUcvGKk8oWpdqXguJe8chLfMFfh4n4U1RKs8=;
 b=mZD2JtqJu+cWl3fP93Br3vKp5cHWzCFhBH9psjywYzvpHDbvZufgS0D3HT3dfQRolSZS
 Y/qyg7ScoyONLFzhk4uWTj0XrsDFh8F4ohXFZq3ONPiY7grkYC9EjkS4teitFzmzzftQ
 sZxJHPux3o72JA6A8JmSb2NnIAa4Q8Wdzi6sjOq7dPunr9+viQL/H42QX9ypt7og0DyH
 xUgOLYwQpYFhYomZqinlkD0IHYcVjn1kDsc6sVZUOYb6x8Jv4EVp5vLsxcbyuKuk4weh
 bX5KacHx+9vucHqWCg7zC6tU3wP0Q8sJ45RUeU5YCu72e2BqVzfHe9vtprgwTe7ymoKF eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfnyhmx6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 06:33:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3136XPV2016299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 06:33:25 GMT
Received: from [10.216.51.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 22:33:20 -0800
Message-ID: <de86d4ce-b9a9-9202-c7b9-ea49e9b1d41b@quicinc.com>
Date:   Fri, 3 Feb 2023 12:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 02/14] ASoC: qcom: SC7280: audioreach: Add sc7280 hardware
 param fixup callback
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
        <bgoswami@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>
References: <20230201134947.1638197-1-quic_mohs@quicinc.com>
 <20230201134947.1638197-3-quic_mohs@quicinc.com>
 <Y9p57qn9+Pig9igE@sirena.org.uk>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <Y9p57qn9+Pig9igE@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FQhYFWnXTTN1IudxQWb0NB1blKm9qU0h
X-Proofpoint-ORIG-GUID: FQhYFWnXTTN1IudxQWb0NB1blKm9qU0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_03,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=630
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030058
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/1/2023 8:10 PM, Mark Brown wrote:
> On Wed, Feb 01, 2023 at 07:19:35PM +0530, Mohammad Rafi Shaik wrote:
>
>> +#define DEFAULT_SAMPLE_RATE_48K	48000
> Why are we bothering with a define here given that the define also
> encodes the value and it's only used in once place?
okay, will remove it.
>
>>   	for_each_card_prelinks(card, i, link) {
>>   		link->init = sc7280_init;
>>   		link->ops = &sc7280_ops;
>> +		if (link->no_pcm == 1)
>> +			link->be_hw_params_fixup = sc7280_snd_be_hw_params_fixup;
> We only set the fixup in the case where there's no PCM but we removed
> the constraint in all cases - isn't the constraint needed otherwise?
okay, will add conditional check for constraint and will only do if 
no_pcm is zero.
