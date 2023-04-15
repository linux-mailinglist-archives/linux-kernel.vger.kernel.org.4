Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A442B6E3342
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDOTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDOTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 15:10:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF403C0B;
        Sat, 15 Apr 2023 12:10:07 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FJ5bY5028214;
        Sat, 15 Apr 2023 19:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=N3vL3RGfvK8GznC4j9MO7miYb9Yae3BnD+igqgQ/+S4=;
 b=aDw9JemMK0uvEMesppGvqOLQA7CQbSuDmvb3Ie7x5KqAtZVx7qxUhznH8n/ctG3o+VT4
 xfrD+ktL30M+qUexQPM12bqCKIUk4n3pH6QxJuF9HGwDXBuSWypx8N3i/Rxw3QxAnD+L
 xHeg+yAEDBzy7ps8OMC8LCRBYoCSMmWCt5TXoqT+FwUFnLzDRNZKu7ellaibM2Jdl34T
 qIixDRf9fmmJ2wFr8vDZ9/4QxTNY64esgtU/f+pxUO2/FNXe2j0mF9eYBrDYnw7MH3jA
 Vg6KHOgIwszESwxXY6PN2hk/ko3Q1bho938lwC2AyuN2m2FDpxCu9QpcO7xA41NXM+B/ 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymmg0un6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 19:09:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33FJ9drp002810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Apr 2023 19:09:39 GMT
Received: from [10.216.37.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 15 Apr
 2023 12:09:32 -0700
Message-ID: <f979b4c2-c0e8-6b43-796b-10c21ae4df75@quicinc.com>
Date:   Sun, 16 Apr 2023 00:39:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 8/8] arm64: dts: qcom: sa8540-ride: Enable first port
 of tertiary usb controller
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
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
        <quic_harshq@quicinc.com>, <quic_shazhuss@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-9-quic_kriskura@quicinc.com>
 <20230414155159.zmhkeoxwhxe5czm5@halaney-x13s>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230414155159.zmhkeoxwhxe5czm5@halaney-x13s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V8M1DKbwj9CQN79F062NW3Eb_Eceuf0E
X-Proofpoint-GUID: V8M1DKbwj9CQN79F062NW3Eb_Eceuf0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 mlxlogscore=605 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 9:21 PM, Andrew Halaney wrote:
> On Wed, Apr 05, 2023 at 06:27:59PM +0530, Krishna Kurapati wrote:
>> Enable first port of Quad port Tertiary USB controller for SA8540 Ride.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> This is nitpicky, but I liked some of the description in the first[0]
> version of this patch that I authored for you:
> 
>      From dcb27d07f079194ebd7efe1c9bec64da78beb290 Mon Sep 17 00:00:00 2001
>      From: Andrew Halaney <ahalaney@redhat.com>
>      Date: Thu, 19 Jan 2023 14:53:38 -0600
>      Subject: [PATCH] arm64: dts: qcom: sa8540p-ride: Enable usb_2
>      Content-type: text/plain
> 
>      There is now support for the multiport USB controller this uses
>      so enable it.
> 
>      The board only has a single port hooked up (despite it being wired up to
>      the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
>      which by default on boot is selected to mux properly. Grab the gpio
>      controlling that and ensure it stays in the right position so USB 2.0
>      continues to be routed from the external port to the SoC.
> 
>      Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> Specifically the bit helping explain what the mux, its default state,
> etc are things I find explain some of the hardware/patch better. Personal
> opinion of course but I'll highlight it since you dropped it out :)
> 
> [0] https://lore.kernel.org/linux-arm-msm/20230119220942.ja5gbo3t3fl63gpy@halaney-x13s/
> 
> Either way, thanks for taking the patch along and working on this.
> 
> Thanks,
> Andrew
> 

Hi Andrew, Sorry for that. Will make sure to update the commit text with 
this info in the next version.

Regards,
Krishna,
