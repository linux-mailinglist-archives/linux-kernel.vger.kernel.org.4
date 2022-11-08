Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69273620CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiKHKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiKHKLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:11:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF25CE2B;
        Tue,  8 Nov 2022 02:11:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A88bapU015600;
        Tue, 8 Nov 2022 10:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h8+ioOxt/M50vRMcvRz9EeFpvFX/e57/3WpIPPmWfBk=;
 b=oX4xm7HS0JiNM8HMqg1/YgWVDld8WNMHjUCkM2tEa4zhV7RstP2Lw/DXI81xuT6UJ5mk
 /7XCtucyxClNFDKcsC3xRAimnt5kWRJnfQae2BPwqs9MEca0LRBT+pCvsfpenN895pAS
 1hvI7gCpTZdQjxc0hqhYKP9YfO19pF8RAk/+dJeLcUsgCc1UnUy1oolnf9upeHRAF7Uo
 cxLSymHDVjvCR19sb66L8H917jQvRYCpEBRd3Kr0CZJjxZ207sCkeYW1Hb3ZJd+f1Qla
 QD4fisgT+Pugt2RzxsSVKhG9mxmUMrJZlnZpMgiB5qmCG86yzObNCh9F9buXODSmC0v3 LQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmk8em1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 10:11:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8AAxxa028342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 10:10:59 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 02:10:55 -0800
Message-ID: <e5b529c7-865c-b5d1-c3bf-dc6b162431d7@quicinc.com>
Date:   Tue, 8 Nov 2022 15:40:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm
 reference boards as LTE
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bjorn.andersson@linaro.org>, <dianders@chromium.org>,
        <jinghung.chen3@hotmail.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>
References: <20221108092207.8186-1-quic_sibis@quicinc.com>
 <ca515021-326d-6034-2af9-54e73e1cc8fa@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <ca515021-326d-6034-2af9-54e73e1cc8fa@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HLvoFt3Ucq8T2Tbrx1BERlM7Q1fw_O3h
X-Proofpoint-ORIG-GUID: HLvoFt3Ucq8T2Tbrx1BERlM7Q1fw_O3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=798
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211080055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof,
Thanks for taking time to review the series.


On 11/8/22 15:04, Krzysztof Kozlowski wrote:
> On 08/11/2022 10:22, Sibi Sankar wrote:
>> When the modem node was re-located to a separate LTE source file
>> "sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
>> weren't marked appropriately. Fix this by marking all Qualcomm
>> reference devices as LTE.
>>
>> Fix-suggested-by: Douglas Anderson <dianders@chromium.org>
> 
> There is no such tag. If it is a fix, use Reported-by. If it is not, use
> Suggested-by.

lol I should have just stuck with S-b but found the tag being used a
number of times. I'll fix this up if the series warrants a re-spin.

-Sibi

> 
>> Fixes: d42fae738f3a ("arm64: dts: qcom: Add LTE SKUs for sc7280-villager family")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
> 
> Best regards,
> Krzysztof
> 
