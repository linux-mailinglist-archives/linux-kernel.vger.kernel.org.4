Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ABD74503A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGBTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:10:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740C1C2;
        Sun,  2 Jul 2023 12:10:41 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362ImAF5021294;
        Sun, 2 Jul 2023 19:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U2mjDAvqkkSpk+J8eReI+feCEnW7cKR95W2c86RrKNc=;
 b=PEnW+PWeJC3ydBSJmJutF9NKDORiGx0egKdGFIDHaJsLOoMuRyIqZbrbScVBRAl32dfm
 jj6aTB0iP8+8HIKHeHod84ORh4XERtPTjqe73FPRjrcJ/guvUwyw6ibyDqAnx3VPKA5V
 OgFiGokoyIzVgPxiRIF17k1ZW54MFy07ZtIGuqvxqQwoQUJCg1AdkAVMd6wiSUUVoZIG
 kMTFPNdk8JOi93v+gnOIifUqkUhAZRueiN55oP+4FlEI6l/BArnU9ES/c6R7AuyIG2X1
 wDDxetj1cCt/L/B7ECtEC2SaWtgWQn8q0DC3E+dbhHmc7tjI4nhYhqoeChl5K2J3DpJZ QQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjdedtbby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 19:10:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362JASls029828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 19:10:28 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 12:10:22 -0700
Message-ID: <622288dd-cb3c-b673-5544-46ff10106dbc@quicinc.com>
Date:   Mon, 3 Jul 2023 00:40:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-9-quic_kriskura@quicinc.com>
 <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
 <b183a130-6237-7d15-5d5a-b56582b92b35@quicinc.com>
 <ZJr9Xiv6_0nG0Pui@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJr9Xiv6_0nG0Pui@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Toaz9_Daqu55fAPPAuWZ0VbLZd6PQ4xh
X-Proofpoint-ORIG-GUID: Toaz9_Daqu55fAPPAuWZ0VbLZd6PQ4xh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 mlxlogscore=766 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020182
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 8:46 PM, Johan Hovold wrote:
> On Sat, Jun 24, 2023 at 12:43:23PM +0530, Krishna Kurapati PSSNV wrote:
>>> On 21.06.2023 06:36, Krishna Kurapati wrote:
>>>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
>>>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
>>>> platforms.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
>>> Not a comment to the patch, but very nice that Qcom ensured every
>>> endpoint is wakeup-capable, this used not to be the case before :D
> 
>> Yes wakeup is supported by all ports now, but I didn't make those
>> changes now as I wanted to keep driver code diff minimal and don't need
>> wakeup support for the product currently. But for sure, will update
>> driver code to handle wakeup on all ports in near future.
> 
> Why didn't you include it in v9? I thought you had a working
> implementation for this?
> 
> Since wakeup will be another case where glue and core need to interact,
> it's good to have the wakeup implementation from the start to be able to
> evaluate your multiport implementation properly.
> 
> Right now it looks like you only added wakeup interrupt lookup and
> request, but then you never actually enable them which is not very nice.
> 
> Johan

Hi Johan,

  As mentioned in one of my comments on earlier patches, wakeup is not a 
requirement I currently need to work on for the product. I added 
multiport IRQ support only because my pathces need to modify IRQ names. 
If there is a customer requirement I get in the future, I will 
definitely implement the wakeup part. But for now, I would like to stick 
to what is necessary for getting Multiport to work.

Regards,
Krishna,
