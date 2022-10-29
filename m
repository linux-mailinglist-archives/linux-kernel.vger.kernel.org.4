Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5C6121FB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2Jpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ2Jpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:45:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED961D63;
        Sat, 29 Oct 2022 02:45:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29T9im6c009885;
        Sat, 29 Oct 2022 09:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NbnSfTQFRtU1QAkKnF5HQ/jgkcL6x48/jtBbKCN1o3A=;
 b=ejhQh9s2wQmjT/ve77N4cIuGzdvilUOs6YrRn5l727HoTGHxnfkeXRo2t652VOMAT8Ui
 GHBfwPBsV5aXWi+GZZOrIrrIoZvUzJIS/t8Sfh0ym1uo6Q8uE05dV2c83NWiHOHNOzub
 tRT/3uHY2LjAFiw8KlZmBpZx3YWLmAdQJRz4iXchE78Mz3BGQmdsaaETWbcmw1JWmj9q
 GqIsgiKKrjjbCfdg4dv72+11nIlrI1BXch2F6j06UQy3HdEEfEVhKu4jD9E/l9LWDLIY
 aJaAPCIWrty69yfNyts+Nc+znA0oEu0tpF/cXNX3TkaJAY1onxrYjBy+ZPfu5qid3gxS Zg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kgwcyrkw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Oct 2022 09:44:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29T9ilIc007037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Oct 2022 09:44:47 GMT
Received: from [10.216.56.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 29 Oct
 2022 02:44:41 -0700
Message-ID: <6e0590af-0bd1-cbef-c573-fa62b5bc9e63@quicinc.com>
Date:   Sat, 29 Oct 2022 15:14:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1664368073-13659-1-git-send-email-quic_srivasam@quicinc.com>
 <1664368073-13659-2-git-send-email-quic_srivasam@quicinc.com>
 <a1a78c72-2067-1ea8-a50e-0dcf4ae4bb83@linaro.org>
 <97b462ea-e283-60ee-e272-b136ca08a251@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <97b462ea-e283-60ee-e272-b136ca08a251@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8nPSRRS4ej5El_L6aCOcLQBLyEF-NcIn
X-Proofpoint-GUID: 8nPSRRS4ej5El_L6aCOcLQBLyEF-NcIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-29_05,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=811 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210290068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/28/2022 10:32 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzysztof!!!
> On 29/09/2022 03:32, Krzysztof Kozlowski wrote:
>> On 28/09/2022 14:27, Srinivasa Rao Mandadapu wrote:
>>> Add ADSP PIL loading support for SC7280 SoCs.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>> ---
>>> Changes since V9:
>>> 	-- Add missing unevaluatedProperties in glink-edge.
>>> Changes since V8:
>>> 	-- Add glink-edge reference.
>>> 	-- Remove redundant glinke-edge properties.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> Actually not... you still do not Cc all necessary maintainers. I don't
> understand why.
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

Sorry for missing it. Actually it was long back patch.

Recently After your suggestion on soundwire bindings patch,I am taking 
care of it.

>
> Best regards,
> Krzysztof
>
