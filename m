Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC17C5EF0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiI2IzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiI2Iy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:54:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02FE2FFFC;
        Thu, 29 Sep 2022 01:54:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T7jbB5023403;
        Thu, 29 Sep 2022 08:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ymFId9rk0VYVRNTJRUXusW4P91daBexoxJBCMtJmVsE=;
 b=TxbkkHQFnhhlxcfiZY8qmpspZSmxBCxcp1KgKfHnUpBjYt/BWRRTe98rOP7YQB/sGFse
 hznDTZ0FPBvwt/xD/hUcPV5Hom4qkAD7jIEOqPtLv0aQXFP0Nus1HGCg4Mn2Ctek1Q3Z
 cz4rzXHuFAC7rzz3RskyG6xPdKoNTCEutXssx/SBMjDpgfac+GY0hSxdnn6os2Kx3KTP
 iS7vND3zhnbjMKEVdC6Ub0usgdmtcl+L3kMbFIpKwpzWt4zAtufDcEEZFeFND2bYxHyZ
 TBXAW2kdA3mrDcAhJsMnLXPKxWFI0Yu0MU9f5Uwk4pXGBGpkbJiV1UxZtEX5MNUzDIn/ LA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvv1ssyx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 08:54:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28T8sl8a026001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 08:54:47 GMT
Received: from [10.216.29.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 01:54:43 -0700
Message-ID: <0cc382cb-b76e-a5a5-3480-47a451bdc958@quicinc.com>
Date:   Thu, 29 Sep 2022 14:24:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
 <CAA8EJpr9pcN-SG-yQNUGEoHCmv74prChprj4f42PKpSAzGzVKQ@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJpr9pcN-SG-yQNUGEoHCmv74prChprj4f42PKpSAzGzVKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cal0fDb_t370IOgCZ6HrsUhSET20IujE
X-Proofpoint-ORIG-GUID: Cal0fDb_t370IOgCZ6HrsUhSET20IujE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290054
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2022 1:29 PM, Dmitry Baryshkov wrote:
> On Thu, 29 Sept 2022 at 10:14, Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>>
>> Override the SNPS Phy tuning parameters for SC7280 devices. These
>> values are common for both trogdor and herobrine variants.
> 
> They are common for trogdor and herobrine, but should these parameters
> be a default? In other words, a random new device based on sc7280
> would more likely use these overrides or the hardware defaults?
> 
Hi Dmitry,

   Currently there are only two platforms, so I made these changes on 
common dtsi. If a new platform comes (mostly it won't) we can override 
them in platform specific file is what I thought.

Regards,
Krishna,
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 2125803..ae2c23e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3310,6 +3310,13 @@
>>                          clock-names = "ref";
>>
>>                          resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
>> +
>> +                       qcom,hs-rise-fall-time-bp = <0>;
>> +                       qcom,squelch-detector-bp = <(-2090)>;
>> +                       qcom,hs-disconnect-bp = <1743>;
>> +                       qcom,hs-amplitude-bp = <1780>;
>> +                       qcom,hs-crossover-voltage-microvolt = <(-31000)>;
>> +                       qcom,hs-output-impedance-micro-ohms = <2600000>;
>>                  };
>>
>>                  usb_1_qmpphy: phy-wrapper@88e9000 {
>> --
>> 2.7.4
>>
> 
> 
