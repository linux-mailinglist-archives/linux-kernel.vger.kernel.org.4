Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754386FF039
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbjEKKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjEKKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:55:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA17698;
        Thu, 11 May 2023 03:55:12 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BA1s5n016040;
        Thu, 11 May 2023 10:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8+brlyBNhx/Yq06mLrhP4Dh29gMdRsBtZEDRxZThxMo=;
 b=Lh+U3Mnss/kr269TBQ/44+rNUHiHG/NiMTnNKqOdj75t3wsy2E2xAMkObEP+pj5XKR9C
 xkssapMXrm1IrGqGUzsIexTlqVMVzo8fepA6R9dOCCj+BKNFHiu9ggJsc6DxA15TnPwx
 0k1BBvCuDUlmytExjLTBswSYPCyH7Xh5nFcRN/o/LXzn2G3ls5S0i4SsAtepsK2d74UX
 DoSN5MWGbOV0fPzB0mM5UAwy1kj7phctH9zQhpEoEeigs6E2yVr0pgiI4uCXFAnOmDqN
 5VazUyadAixmNWSYyPZ7Wkt7suah/VuHg+ooSMw6UMSKwQtyPuCoyjV61ftVB/nCFUsW 3g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgj141gqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 10:54:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34BAsJ7Y026678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 10:54:19 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 11 May
 2023 03:54:14 -0700
Message-ID: <daff6818-525d-7a99-de08-e289848cadf9@quicinc.com>
Date:   Thu, 11 May 2023 16:24:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 7/8] arm64: dts: Add ipq5018 SoC and rdp432-c2 board
 support
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-8-quic_srichara@quicinc.com>
 <8f5040e0-169b-554b-c9e6-479b8f098bc6@gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <8f5040e0-169b-554b-c9e6-479b8f098bc6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tub2K_I1yNaTJ2VTvqXEEh8-_DE6rYDZ
X-Proofpoint-ORIG-GUID: tub2K_I1yNaTJ2VTvqXEEh8-_DE6rYDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=964
 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110093
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2023 3:54 PM, Robert Marko wrote:
> 
> On 10. 05. 2023. 15:41, Sricharan Ramabadhran wrote:
>> Add initial device tree support for the Qualcomm IPQ5018 SoC and
>> rdp432-c2 board.
> 
> Hi, does reboot work for you with this patchset?
> I have tested on 2 different IPQ5018 boards and they wont reboot,
> I get the:
> Requesting system reboot
> [  321.005977] qcom_scm firmware:scm: No available mechanism for setting 
> download mode
> [  321.006128] reboot: Restarting system
> 
> And then it just hangs there.
> 

  Yes, that is because SDI disabling using separate SCM is still not
  there. I will add support for that in a separate series.

Regards,
  Sricharan
