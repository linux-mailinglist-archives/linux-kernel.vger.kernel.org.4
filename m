Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98B466D4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjAQD0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjAQD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:26:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299AD227A2;
        Mon, 16 Jan 2023 19:26:46 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H1wCZ6015506;
        Tue, 17 Jan 2023 03:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=odUyeb4Moo2RJygLWdv551YNqxNag5tHWg49OhqtLmQ=;
 b=hK+xtphkfuY88FzegIZqcsgFdS6BIAUai4W7yFN+b/ZcIrulLVWlAQBoytW4PveSXgJe
 emRJL6eFbyyCjMbR24vaIczf+fnkHj+sKEka4KnLxwqhBvEDoUHBC/VP4OuO1vd+ab1H
 v7XMlVL+1GxiOIJTUKAVAkZmJet3ZflnmYFn8z1n1Hgpe9WyHe0bODLz+jNjK2iW51+m
 3v22cWIqjvcmmdmiF8JEDhmH4Lu7DA53w0y6rA7PolA/0GUc79ti3b+clqgOhjUECHaf
 z1kVbL+/q6Qtm6ONfjMHfL/qtIKlt2YZGYY112GyIAO3r5fcodpjG2TcwmfPHI13cl/C OA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3n5qveh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 03:26:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H3QLLI000593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 03:26:21 GMT
Received: from [10.253.11.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 19:26:16 -0800
Message-ID: <185c988d-4213-f1e3-b400-0f86845eaf78@quicinc.com>
Date:   Tue, 17 Jan 2023 11:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v16 6/8] Coresight: Add TPDA link driver
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20230106092119.20449-1-quic_jinlmao@quicinc.com>
 <20230106092119.20449-7-quic_jinlmao@quicinc.com>
 <c8831ad9-d867-d977-da5f-2cc1b71704cf@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <c8831ad9-d867-d977-da5f-2cc1b71704cf@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pKPaFg5SzYrcENuO3R7AYXodh0ZT45M2
X-Proofpoint-ORIG-GUID: pKPaFg5SzYrcENuO3R7AYXodh0ZT45M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=734 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170024
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/2023 5:36 PM, Suzuki K Poulose wrote:
> On 06/01/2023 09:21, Mao Jinlong wrote:
>> TPDA(Trace, Profiling and Diagnostics Aggregator) is
>> to provide packetization, funneling and timestamping of
>> TPDM data. Multiple monitors are connected to different
>> input ports of TPDA.This change is to add tpda
>> enable/disable/probe functions for coresight tpda driver.
>>
>>   - - - -         - - - -        - - - -
>> | TPDM 0|      | TPDM 1 |     | TPDM 2|
>>   - - - -         - - - -        - - - -
>>      |               |             |
>>      |_ _ _ _ _ _    |     _ _ _ _ |
>>                  |   |    |
>>                  |   |    |
>>             ------------------
>>            |        TPDA      |
>>             ------------------
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Btw, do we expect to see these devices on an ACPI system ?

These devices are not supported on an ACPI system.

Thanks
Jinlong Mao
>
> Suzuki
