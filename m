Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24A6673117
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjASFSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjASFRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:17:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639751BE9;
        Wed, 18 Jan 2023 21:17:35 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J4WPWZ010850;
        Thu, 19 Jan 2023 05:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IiNe1D7wMVXUPC7Sw5JyIQAiN+MwSRp7HO+FgP9EyA8=;
 b=E7KHEut4oe8T8/K36K6WQHyrtV+u1rtV99CKZg+awDqa/nikv1vhxatX3HF00UwoiLn2
 ERqhdXbOl/d4mXFZouLlA405XcuqppUiW1aJRORTi0TxniTUbn47Y/2yY9fVpGD847XW
 DOD/aznAPmy+CYYLSBJH9i+ZhmF4aMR/sdJVn3ICS/N+UKZf/wnyCSoUPs6lIjPXWxfe
 YMJOMKM003p0+qS9oVcsL6/U0SyOd/hkPKv44nBvg4HyY1zoOhmABjNnTjMCSktM0NFa
 CKhq2K1DQHBqVd1OzZsVcw8WxCm/V4Mo8hmj7RWFGyZ3KMC/W2cD1h0bhoT7MZ4og0MX 7A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n69dpjn1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 05:17:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30J5HOTZ022308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 05:17:24 GMT
Received: from [10.216.31.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 21:17:18 -0800
Message-ID: <81f29a76-4daf-d5ec-afd5-e2305fbb8feb@quicinc.com>
Date:   Thu, 19 Jan 2023 10:47:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 0/5] Add multiport support for DWC3 controllers
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230119034352.stbhutga5ounihj7@builder.lan>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230119034352.stbhutga5ounihj7@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0JGznN4uxfDUfqHfN06r8af1gKT5Rc_
X-Proofpoint-ORIG-GUID: Q0JGznN4uxfDUfqHfN06r8af1gKT5Rc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=962 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190039
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 9:13 AM, Bjorn Andersson wrote:
> On Sun, Jan 15, 2023 at 05:11:41PM +0530, Krishna Kurapati wrote:
>> Currently the DWC3 driver supports only single port controller which
>> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
>> DWC3 controller with multiple ports that can operate in host mode.
>> Some of the port supports both SS+HS and other port supports only HS
>> mode.
>>
>> This change primarily refactors the Phy logic in core driver to allow
>> multiport support with Generic Phy's.
>>
>> Chananges have been tested on  QCOM SoC SA8295P which has 4 ports (2
>> are HS+SS capable and 2 are HS only capable).
>>
> 
> I can confirm that applying this series allow me to use all 6 USB ports
> on the ADP. Looking forward to v5.
> 
> Thanks,
> Bjorn
> 
Thanks Bjorn for testing it out.

Regards,
Krishna,
>> Changes in v4:
>> Added DT support for SA8295p.
>>
>> Changes in v3:
>> Incase any PHY init fails, then clear/exit the PHYs that
>> are already initialized.
>>
>> Changes in v2:
>> Changed dwc3_count_phys to return the number of PHY Phandles in the node.
>> This will be used now in dwc3_extract_num_phys to increment num_usb2_phy
>> and num_usb3_phy.
>>
>> Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
>> structure such that the first half is for HS-PHY and second half is for
>> SS-PHY.
>>
>> In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
>> present, pass proper SS_IDX else pass -1.
>>
>> Link to v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
>> Link to v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r
>>
>> Krishna Kurapati (5):
>>    dt-bindings: usb: Add bindings to support multiport properties
>>    usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>>    usb: dwc3: core: Do not setup event buffers for host only controllers
>>    usb: dwc3: qcom: Add multiport controller support for qcom wrapper
>>    arm: dts: msm: Add multiport controller node for usb
>>
>>   .../devicetree/bindings/usb/snps,dwc3.yaml    |  42 ++-
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  49 +++
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  60 ++++
>>   drivers/usb/dwc3/core.c                       | 325 +++++++++++++-----
>>   drivers/usb/dwc3/core.h                       |  15 +-
>>   drivers/usb/dwc3/drd.c                        |  14 +-
>>   drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
>>   7 files changed, 429 insertions(+), 104 deletions(-)
>>
>> -- 
>> 2.39.0
>>
