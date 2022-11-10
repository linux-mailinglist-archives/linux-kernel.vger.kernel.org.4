Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA5623C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiKJHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:04:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2414016;
        Wed,  9 Nov 2022 23:04:15 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA49Z6f026999;
        Thu, 10 Nov 2022 07:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YQqA+Zr54sEBuZb86behYUeWIo4KfLafIhcEQ3Yb+ls=;
 b=WBe1ydr1Vw/ZmYD6VOO5iAJoVSnnXwvijvS84VSydbHhEKYq/PCp9T1z48ZDwN2ubZ97
 dVejhlVCbVm/aknEUxcqDuB0LrwUy6afoMdOO7zQYIziHQ+q2rceT5YklRiETfAMqqae
 BKlLDl6EYNKQ2zuyRY42AB7wwKXRvDdw7tSbm+AwcYHJIWdwWNhHtbuGp8/CT3tjTK0f
 PB5TIarHzJm4yPsYrDDQNWN/TNWbI+e8PnqiKTPrgaS1kU+XLREHiRrA6BvllIqwm2/z
 2uPURZgot6WbtuAZbWVOYmPrNR+Yd3ClyEEWoP/A9YyoQysOFcpCKCiNzFDFGxxjc9pG NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krg1y9xmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 07:04:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AA743RZ005928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 07:04:03 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 9 Nov 2022
 23:03:56 -0800
Message-ID: <7c616858-3de9-6de5-bfee-572bf0405ec1@quicinc.com>
Date:   Thu, 10 Nov 2022 12:33:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V3 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm
 reference boards as LTE
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     <jinghung.chen3@hotmail.com>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>
References: <20221109055132.609-1-quic_sibis@quicinc.com>
 <CAD=FV=Wdrb27XCmj+VoNXtvFOYHGPkWXJujzZogzLK2ZMWgxTw@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAD=FV=Wdrb27XCmj+VoNXtvFOYHGPkWXJujzZogzLK2ZMWgxTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t7PUGj6U1WPI_ZhzxEUn60uVGwbdbs3X
X-Proofpoint-ORIG-GUID: t7PUGj6U1WPI_ZhzxEUn60uVGwbdbs3X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=800
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211100053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Doug,

Thanks for taking time to review the series.

On 11/9/22 23:10, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 8, 2022 at 9:51 PM Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> When the modem node was re-located to a separate LTE source file
>> "sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
>> weren't marked appropriately. Fix this by marking all Qualcomm
>> reference devices as LTE.
>>
>> Suggested-by: Douglas Anderson <dianders@chromium.org>
>> Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v3:
>>   * Fix incorrect tag usage [Krzysztof]
>>
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 4884647a8a95..ca09367abb6c 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -13,6 +13,7 @@
>>   #include "pmk8350.dtsi"
>>
>>   #include "sc7280-chrome-common.dtsi"
>> +#include "sc7280-herobrine-lte-sku.dtsi"
> 
> I think you need to _remove_ the include from the "idp.dts" file now,
> right? Otherwise it gets included twice.

sry missed ^^, will fix it in the re-spin.

- Sibi
