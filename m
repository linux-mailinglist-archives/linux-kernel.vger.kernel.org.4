Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C986E1B29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDNElj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:41:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904B4683;
        Thu, 13 Apr 2023 21:41:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E32Qsk025843;
        Fri, 14 Apr 2023 04:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hJRpPmNCPtJVBcrq0CaP8SRzwZ3nh+MkoQO9ClK7m2w=;
 b=TZ8CNwYTYVquAWr+pDhAWJnwBilNFXHe+JDLUYctmzwvhDvWhpm4eU4UXxc68MPHkNbS
 3Mz3q5ifBOM5zo07z15B9R6rNE/tG4IJnyYppP4klN1j5P+E7IhniGL1ntZnXjsTl6eY
 EgKFAmIsEVjDWkBXf+dchkDqUrRD6iijIMJ/N6n1n+zdom/srQHoYHSTfJ4SwRzZoPsU
 Zyr/ExPRDecQ2jpnu2Hz87gwXhQnNiRPBN/t7plZogSJKY9DVFrGycQyyomrzvP9X4ky
 xFPPe8lUv2FAH0xzPiIA1Jqz+Ef4zUXYCaqzOtlh0lKgQUZRLk99aqpM45LHnDZzpw3i AA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px6cnk1c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 04:41:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33E4fGbV008380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 04:41:16 GMT
Received: from [10.216.8.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 13 Apr
 2023 21:41:10 -0700
Message-ID: <f55fb40e-50d7-c4f2-efee-8de24a6a31f2@quicinc.com>
Date:   Fri, 14 Apr 2023 10:11:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 0/8] Add multiport support for DWC3 controllers
To:     Adrien Thierry <athierry@redhat.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <ZDhP823LUMCDuD9q@fedora>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZDhP823LUMCDuD9q@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uQYKuBL01LX8LffcCvm-kYUC8gttuV27
X-Proofpoint-GUID: uQYKuBL01LX8LffcCvm-kYUC8gttuV27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_01,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140041
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 12:24 AM, Adrien Thierry wrote:
> Hi,
> 
>> Krishna Kurapati (8):
>>    dt-bindings: usb: Add bindings for multiport properties on DWC3
>>      controller
>>    usb: dwc3: core: Access XHCI address space temporarily to read port
>>      info
>>    usb: dwc3: core: Skip setting event buffers for host only controllers
>>    usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>>    usb: dwc3: qcom: Add multiport controller support for qcom wrapper
>>    arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
>>    arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
>>      ports
>>    arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb
>>      controller
>>
>>   .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
>>   arch/arm64/boot/dts/qcom/sa8295p-adp.dts	 |  47 +++
>>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  22 ++
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  58 +++
>>   drivers/usb/dwc3/core.c                       | 373 ++++++++++++++----
>>   drivers/usb/dwc3/core.h                       |  71 +++-
>>   drivers/usb/dwc3/drd.c                        |  13 +-
>>   drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
>>   8 files changed, 523 insertions(+), 102 deletions(-)
> 
> I tested this series on the sa8540p-ride, with a USB Ethernet adapter
> plugged into the board. The device shows up as expected:
> 
> # lsusb -tv
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 10000M
>      ID 1d6b:0003 Linux Foundation 3.0 root hub
>      |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>          ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/4p, 480M
>      ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> Tested-by: Adrien Thierry <athierry@redhat.com> # sa8540p-ride
> 

Hi Adrien,

  Thanks for testing out the patches.

Regards,
Krishna,
