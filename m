Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D273661EA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKGFiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGFis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:38:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64085F7E;
        Sun,  6 Nov 2022 21:38:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A75Ehj8008885;
        Mon, 7 Nov 2022 05:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LOmNW934C5MVnCwKLxAlx3sEVaqNfpouVEI8K0mtdkA=;
 b=e56vCSTLGNRm08gz8p25tPLe3x8KEYr5NwTCm53eysh4mUWi+1AO73f/DC5zSfiS8YEe
 11pGA85jA+aigmkbxbyZzkgKlohO79f12yOFD6dLPGKnx4lXkfF3EjsRg2s4CkYaX5cQ
 Ro2BWu/vv0T8CghYzNOrjOO1bjK4sC31CqJOBmQwxtJHaSq1H495Grhj/GyGPYGSVuD6
 lyrDXUF0NDhvGX1YCfmUAuRLv1sd4JRqaRAu1mgjLYKYrDm5aMeR9yt4st/MBkJ9ZLnk
 ERAzx7f60AQXJcXHtFarT2nJYwLR+dVs+SfX5g6icUneHL81uRL7WdDHbU3GBqSPGafA zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kphfv0nk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 05:38:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A75cbpK017933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 05:38:37 GMT
Received: from [10.50.40.69] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 6 Nov 2022
 21:38:34 -0800
Message-ID: <21cd992c-334e-3a28-f3ac-68a49a4ef00b@quicinc.com>
Date:   Mon, 7 Nov 2022 11:08:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: qcom: Update the force mem core bit for GPU clocks
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>, <linux-clk@vger.kernel.org>
References: <1666159535-6447-1-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52N6oxSLoU_=Cq1xK9bVX7H+AvPsR3dLepMNjKywdffvQ@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n52N6oxSLoU_=Cq1xK9bVX7H+AvPsR3dLepMNjKywdffvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 66Aw6M2hN4prCn1f4-S61TrOFHmzE1Z7
X-Proofpoint-GUID: 66Aw6M2hN4prCn1f4-S61TrOFHmzE1Z7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_16,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 malwarescore=0 mlxlogscore=670 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/2022 5:54 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-10-18 23:05:35)
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> There are few GPU clocks which are powering up the memories
>> and thus enable the FORCE_MEM_PERIPH always for these clocks
>> to force the periph_on signal to remain active during halt
>> state of the clock.
> I take it that missing this causes GPU to lose state when it suspends
> and that confuses the driver?


It is more related to GPU SMMU states and the stability issues that are 
encountered.

