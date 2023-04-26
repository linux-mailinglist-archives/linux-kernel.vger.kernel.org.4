Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5B6EF3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbjDZMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjDZMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:06:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F241B6;
        Wed, 26 Apr 2023 05:06:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QAq4XQ028089;
        Wed, 26 Apr 2023 12:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z2jHxQbkgWifyzS7It9g20bYYdz3itj1DvYyz0UFD2w=;
 b=cwKoDA6wwWge/jJD6apwLlcxzvcVXqmBSaqDdbtuk+R7YPLS2U5mMlSJrxodhsfYcjYr
 r3f9vrbsbQe22vES5eI0wiP89EyqnsS6/NqzvLgYMfLEI40MKEX/saeMT0xCtBPEEFNn
 iLC1cWRWSRWCCvaJorgigbijWd5mV+2T/f1WeuX3nMc93dfpUWdCz+KPeGray7SvJ/oU
 aa8Cat/Qi9g6yzcvrNFx60T4zdHXAJsDMWdHdKIwcvzU3WNgn1Ks/LvZlbaVMRMsX7iq
 c23RcOn+G+jiTFfR75Do7oUqs7eDQKaBMNxrCnSQLp3LiL+4VT+nwmHN80rs2GtJZvwH SA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6rk0sfsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 12:05:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33QC5t6n001527
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 12:05:55 GMT
Received: from [10.218.19.109] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 05:05:50 -0700
Message-ID: <f051bfe8-e612-f54e-7729-7816591fa21c@quicinc.com>
Date:   Wed, 26 Apr 2023 17:35:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for USB
To:     Adrien Thierry <athierry@redhat.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <ZEcEGJiikEC2wIVE@fedora>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <ZEcEGJiikEC2wIVE@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cp0MOlgnQ56BPstlgv_si6hnHIMqXW7n
X-Proofpoint-ORIG-GUID: cp0MOlgnQ56BPstlgv_si6hnHIMqXW7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_04,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=604 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260108
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

On 4/25/2023 4:05 AM, Adrien Thierry wrote:
> Hi Shazad,
> 
> On Fri, Apr 21, 2023 at 07:09:15PM +0530, Shazad Hussain wrote:
>> Update relavent DT bindings for USB, add new config to the phy driver,
>> add USB and PHY nodes to the .dtsi and enable them in the board .dts
>> for the sa8775p-ride platform.
>>
>> Shazad Hussain (6):
>>    dt-bindings: usb: qcom,dwc3: Add bindings for SA8775P
>>    dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SA8775P
>>    dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add SA8775P USB PHY
>>      binding
>>    phy: qcom-qmp: Add SA8775P USB3 UNI phy
>>    arm64: dts: qcom: sa8775p: add USB nodes
>>    arm64: dts: qcom: sa8775p-ride: enable USB nodes
>>
>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   |   1 +
>>   .../bindings/phy/qcom,usb-snps-femto-v2.yaml  |   1 +
>>   .../devicetree/bindings/usb/qcom,dwc3.yaml    |   5 +
>>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |  92 +++++++
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 239 +++++++++++++++++-
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c       |  45 ++++
>>   6 files changed, 381 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 
> Thanks for posting this. I tested the series on the sa8775p, and it seems
> initialization for the controller at a400000 sometimes fails with a
> timeout (-110) error:
> 
>      dwc3 a400000.usb: Adding to iommu group 2
>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
>      xhci-hcd xhci-hcd.0.auto: can't setup: -110
>      xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
>      xhci-hcd: probe of xhci-hcd.0.auto failed with error -110
>      dwc3 a600000.usb: Adding to iommu group 3
>      dwc3 a800000.usb: Adding to iommu group 4
>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
>      xhci-hcd xhci-hcd.1.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000000000010010
>      xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a800000
>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
>      xhci-hcd xhci-hcd.1.auto: Host supports USB 3.1 Enhanced SuperSpeed
>      hub 1-0:1.0: USB hub found
>      hub 1-0:1.0: 1 port detected
>      usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>      hub 2-0:1.0: USB hub found
>      hub 2-0:1.0: 1 port detected
> 
> In this case, only usb devices for a800000 are showing:
> 
>      dracut:/# ls -alh /sys/bus/usb/devices
>      total 0
>      drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>      drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1/1-0:1.0
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2/2-0:1.0
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb1
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.1.auto/usb2
> 
> This happens approximately 1 out of 2 reboots. Here's the kernel output
> when initialization succeeds:
> 
>      dwc3 a600000.usb: Adding to iommu group 2
>      dwc3 a800000.usb: Adding to iommu group 3
>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
>      xhci-hcd xhci-hcd.0.auto: hcc params 0x0110ffc5 hci version 0x110 quirks 0x0000000000010010
>      xhci-hcd xhci-hcd.0.auto: irq 161, io mem 0x0a800000
>      xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
>      xhci-hcd xhci-hcd.0.auto: Host supports USB 3.1 Enhanced SuperSpeed
>      hub 1-0:1.0: USB hub found
>      hub 1-0:1.0: 1 port detected
>      usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>      hub 2-0:1.0: USB hub found
>      hub 2-0:1.0: 1 port detected
>      dwc3 a400000.usb: Adding to iommu group 4
>      xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>      xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 3
>      xhci-hcd xhci-hcd.1.auto: USB3 root hub has no ports
>      xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe65 hci version 0x110 quirks 0x0000000000010010
>      xhci-hcd xhci-hcd.1.auto: irq 162, io mem 0x0a400000
>      hub 3-0:1.0: USB hub found
>      hub 3-0:1.0: 1 port detected
> 
> And the list of usb devices:
> 
>      dracut:/# ls -alh /sys/bus/usb/devices
>      total 0
>      drwxr-xr-x 2 root root 0 Feb 27 00:00 .
>      drwxr-xr-x 4 root root 0 Feb 27 00:00 ..
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 1-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1/1-0:1.0
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 2-0:1.0 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2/2-0:1.0
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 3-0:1.0 -> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3/3-0:1.0
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb1 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb1
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb2 -> ../../../devices/platform/soc@0/a8f8800.usb/a800000.usb/xhci-hcd.0.auto/usb2
>      lrwxrwxrwx 1 root root 0 Feb 27 00:00 usb3 -> ../../../devices/platform/soc@0/a4f8800.usb/a400000.usb/xhci-hcd.1.auto/usb3
> 
> Have you also encountered this?
> 

I did try 10 reboots and did not encounter this issue on my setup tough.

> Best,
> 
> Adrien
> 

---
-Shazad
