Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6F68057F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjA3FPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjA3FO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:14:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DAE23C71;
        Sun, 29 Jan 2023 21:14:58 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U4C3qs019432;
        Mon, 30 Jan 2023 05:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=M9KtfpmFVdbIRd/2qYLXC/lqTjcA85o9Am5EbHuy21w=;
 b=fTOk1h5wZ2M65sVyrHeda7+QCislWfOlIL5+JBKtmeeyfiDCUfcNLO6SRJCCVOyrUuyf
 +EhSjbTfDdeeswVC5Qmg2DT7biZCUUPyCBprP+/3FpT0Hqt6PTfPajHJCDSydlqjlvt9
 do0m7KPt6XepOoaHgBmH9T4dr+DQ/o6/XhQRyb2VW5AZfCNYGnzNbHnR1KGBzEBGAMIf
 gmJUrQX0JtDeYDcEK/T/pRv/VaDyg384r/sTtlcp5W0+PHmRpuPu0rmUTUDgJ+YzZO0n
 Vd3PnqjGGP/yyfzHHX/s2dAS6HOjaeL9QhDIJ4EfM1sVBGewDYQ9RMjK5AISvk6lHshZ oQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncs2x35cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U5EeUs030359
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 05:14:40 GMT
Received: from [10.216.24.235] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 21:14:37 -0800
Message-ID: <343d8b2f-9b7e-85ba-6f68-13cef73e55d0@quicinc.com>
Date:   Mon, 30 Jan 2023 10:44:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
 <10097835-30fe-bbad-6c95-e5ec9dca3e2e@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <10097835-30fe-bbad-6c95-e5ec9dca3e2e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: udmzns9DRiekGpBmEu07sWQoqDSenRk-
X-Proofpoint-GUID: udmzns9DRiekGpBmEu07sWQoqDSenRk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_03,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=622 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2023 1:34 AM, Krzysztof Kozlowski wrote:
> On 27/01/2023 17:00, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a
>> fixed and known location when read from the devicetree. This
>> is not desirable in an environment where it is preferred the
>> region to be dynamically allocated at runtime, as opposed to
>> being fixed at compile time.
>>
>> So, update the ramoops binding by inheriting some reserve memory
>> property to allocate the ramoops region dynamically.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> 
> Drop. There is no single need to store automated output of
> get_maintainers.pl in the git log forever. It can be easily re-created
> at any given time.
> 
> If you need it for your own patch management purposes, keep it under ---.
> 

Will drop, thanks.

> Additionally:
> where is patch number 2?

It was merged with 2/2 as it was not making sense to keep it as separate 
patch

-Mukesh

> 
> Best regards,
> Krzysztof
> 
