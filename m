Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D956EFFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbjD0DHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbjD0DGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:06:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FB46B8;
        Wed, 26 Apr 2023 20:05:57 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R2xOk3019904;
        Thu, 27 Apr 2023 03:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GNAlciDU+GX06s6Be7pZZX94vMNRxyGA7OeWiEL2XXg=;
 b=Us/P1zd74/aMxdwbW25Ka4Tcn6qDWMjGHVO4jV4lrFskecJK/LtXBdcuwNejq/zISXuH
 Y/I0g/I0WPtjqPO8izhhhPCs1zQeMJCTn63dWMsMhoqwxiA7K8YI9EZV+T9Jubfr92wR
 4qhw6HRoZ/8tLCXK8GYlkYCY42omnlK8RiKOt/IlU2HPtggjhYGePBB3R3xQpWP4n5IG
 482UpRfIKSSKKbeAtRpkpWaJuGdLBCD6Rwi3/jsVF0j+7Fn90UA0gMNd8SsiU5SpEQQl
 qrT6bgZ4K1LJamqg77Pz5dSOKzoHcCzqPt3yYFp7GuP44e6aJ0haFI9TagKEYEGM3pOA dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q75jyhdfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 03:05:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R35fkx021035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 03:05:41 GMT
Received: from [10.216.27.110] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 20:05:36 -0700
Message-ID: <9606b8db-ab16-763f-f9df-d059dcc4e4d0@quicinc.com>
Date:   Thu, 27 Apr 2023 08:35:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for USB
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrien Thierry <athierry@redhat.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <ZEcEGJiikEC2wIVE@fedora> <ac49075d-439e-da46-9ef6-0b0828f8e072@linaro.org>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <ac49075d-439e-da46-9ef6-0b0828f8e072@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UyzYc6VkwfNEB-4TZKtjJ7LlrgmdFIkr
X-Proofpoint-ORIG-GUID: UyzYc6VkwfNEB-4TZKtjJ7LlrgmdFIkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_01,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=623 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270027
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/2023 5:12 AM, Konrad Dybcio wrote:
> 
> On 4/24/23 23:35, Adrien Thierry wrote:
>> Hi Shazad,
>>
>> On Fri, Apr 21, 2023 at 07:09:15PM +0530, Shazad Hussain wrote:
>>> Update relavent DT bindings for USB, add new config to the phy driver,
>>> add USB and PHY nodes to the .dtsi and enable them in the board .dts
>>> for the sa8775p-ride platform.
>>>
>>> Shazad Hussain (6):
>>>    dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
>>>    dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
>>>    dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY
>>>      binding
>>>    phy: qcom-qmp: Add SA8775P USB3 UNI phy
>>>    arm64: dts: qcom: sa8775p: add USB nodes
>>>    arm64: dts: qcom: sa8775p-ride: enable USB nodes
>>>
>>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   1 +
>>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
>>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    |   5 +
>>>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  92 +++++++
>>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 239 +++++++++++++++++-
>>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  45 ++++
>>>   6 files changed, 381 insertions(+), 2 deletions(-)
>>>
>>> -- 
>>> 2.17.1
>>>
>> Thanks for posting this. I tested the series on the sa8775p, and it seems
>> initialization for the controller at a400000 sometimes fails with a
>> timeout (-110) error:
>>
>>      dwc3 a400000.usb: Adding to iommu group 2
>>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus 
>> number 1
>>      xhci-hcd xhci-hcd.0.auto: can't setup: -110
>>      xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
>>      xhci-hcd: probe of xhci-hcd.0.auto failed with error -110
>>      dwc3 a600000.usb: Adding to iommu group 3
>>      dwc3 a800000.usb: Adding to iommu group 4
>>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus 
>> number 1
>>      xhci-hcd xhci-hcd.1.auto: hcc params 0x0110ffc5 hci version 0x110 
>> quirks 0x0000000000010010
>>      xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a800000
>>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus 
>> number 2
>>      xhci-hcd xhci-hcd.1.auto: Host supports USB 3.1 Enhanced SuperSpeed
>>      hub 1-0:1.0: USB hub found
>>      hub 1-0:1.0: 1 port detected
>>      usb usb2: We don't know the algorithms for LPM for this host, 
>> disabling LPM.
>>      hub 2-0:1.0: USB hub found
>>      hub 2-0:1.0: 1 port detected
>>
>> In this case, only usb devices for a800000 are showing:
>>
>>      dracut:/# ls -alh /sys/bus/usb/devices
>>      total 0
>>      drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>>      drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1/1-0:1.0
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2/2-0:1.0
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2
>>
>> This happens approximately 1 out of 2 reboots. Here's the kernel output
>> when initialization succeeds:
>>
>>      dwc3 a600000.usb: Adding to iommu group 2
>>      dwc3 a800000.usb: Adding to iommu group 3
>>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus 
>> number 1
>>      xhci-hcd xhci-hcd.0.auto: hcc params 0x0110ffc5 hci version 0x110 
>> quirks 0x0000000000010010
>>      xhci-hcd xhci-hcd.0.auto: irq 161, io mem 0x0a800000
>>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus 
>> number 2
>>      xhci-hcd xhci-hcd.0.auto: Host supports USB 3.1 Enhanced SuperSpeed
>>      hub 1-0:1.0: USB hub found
>>      hub 1-0:1.0: 1 port detected
>>      usb usb2: We don't know the algorithms for LPM for this host, 
>> disabling LPM.
>>      hub 2-0:1.0: USB hub found
>>      hub 2-0:1.0: 1 port detected
>>      dwc3 a400000.usb: Adding to iommu group 4
>>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus 
>> number 3
>>      xhci-hcd xhci-hcd.1.auto: USB3 root hub has no ports
>>      xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe65 hci version 0x110 
>> quirks 0x0000000000010010
>>      xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a400000
>>      hub 3-0:1.0: USB hub found
>>      hub 3-0:1.0: 1 port detected
>>
>> And the list of usb devices:
>>
>>      dracut:/# ls -alh /sys/bus/usb/devices
>>      total 0
>>      drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>>      drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1/1-0:1.0
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2/2-0:1.0
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 3-0:1.0 -> 
>> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3/3-0:1.0
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> 
>> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2
>>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb3 -> 
>> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3
>>
>> Have you also encountered this?
> 
> I've had some issues with QMPPHY not (sometimes?) probing in time on 
> SM6115 only when built as a module.. perhaps it'd be worth checking out 
> of it works fine with =y?
> 

In my setup I tried keeping QMPPHY as =y only and did not see the issue

with 10 reboots.
> 
> Konrad
> 
>>
>> Best,
>>
>> Adrien
>>
---
Shazad
