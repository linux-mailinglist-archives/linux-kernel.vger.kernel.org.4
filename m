Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364671254B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbjEZLK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEZLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:10:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5FF7;
        Fri, 26 May 2023 04:10:23 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAi2qS002420;
        Fri, 26 May 2023 11:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CRrNtT48/agfTTOGQnq/S02EfFlooFG80KnqCaI2A3Q=;
 b=aIcLdf1PWJBxzObO9/Jiz/fdEzXC3UyA4ZEG3988/LKbuihKAgp6v9//p6YIoN2YmbxJ
 9fWDa7vm+VixIB0wv9x3yYJZcuX1vwIK8yMsdDrLb7KFNvEvhtfwnOCcY3KZr4cVZyV1
 Rlrln+RUX7iKdVIfRuIutAvAON3SBR+c0UC6rQs3Nht468Sgx/IueBExONxtzzIkPd1f
 Bhbmh4KTyEZn099Wm2fwNJ/oxprigSuYbkG5ksEdPzhQMu+3djsv29ySv1JCAKqwSvJO
 1x0MKzzlITdJbs64qpPPGuClStOBCetnLoLtgPwjQeBnPC7xcFTF4y5w25x4Fngyv+86 RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtu0u02kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:10:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QBAGGB014757
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 11:10:16 GMT
Received: from [10.50.37.96] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 04:10:13 -0700
Message-ID: <08a6ee40-0729-3573-9938-aa44a6ef297c@quicinc.com>
Date:   Fri, 26 May 2023 16:40:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2] clk: qcom: camcc-sc7180: Add parent dependency to all
 camera GDSCs
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cponnapa@quicinc.com>
References: <20230501142932.13049-1-quic_tdas@quicinc.com>
 <f450c63a57fc5a9536d3c48df26244cf.sboyd@kernel.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <f450c63a57fc5a9536d3c48df26244cf.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y_s3zw8lY4QNOhqq0TokKBzzywTgCWMT
X-Proofpoint-GUID: Y_s3zw8lY4QNOhqq0TokKBzzywTgCWMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=810
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260096
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 5/11/2023 1:02 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2023-05-01 07:29:32)
>> Camera titan top GDSC is a parent supply to all other camera GDSCs. Titan
>> top GDSC is required to be enabled before enabling any other camera GDSCs
>> and it should be disabled only after all other camera GDSCs are disabled.
>> Ensure this behavior by marking titan top GDSC as parent of all other
>> camera GDSCs.
>>
>> Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Is something broken right now? The commit text doesn't tell me if we
> need to backport this to stable kernels or merge it as soon as possible.
> What's the priority of this fix?


Modularization of camx driver triggered this issue now, but there could 
be some other scenarios which could trigger the same issue on stable 
kernels.  Hence it needs to be back ported to stable kernels.

