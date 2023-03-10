Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E76F6B4DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCJQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCJQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:56:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98913594D;
        Fri, 10 Mar 2023 08:54:43 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACPYqc032149;
        Fri, 10 Mar 2023 16:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WywzoVOPk1XQW/04XS0vfAgwyDP6SUtf1p8b26kcZ8U=;
 b=N1Y4aPyMIts8hVlfdJYzTuhc+apxGXSAEJj3vXDeVtBbIoKEbOa5iDX6vu3bRwK3WSSJ
 MraTd4bjTWti7hHxqrXwWzz45sGxE476+uSlrEZ7NU5E5FJ6DLDj+FyYqZHMII1KVtvf
 baFegNWWE5mFp7MqwQETEhd1jAe4Lg+lfctOmwM8fU5nmNe9XeX1/+000UDDXWurz3MJ
 7eUBagLlP42OsxpAyPwJkv2s/9XrT1u+mpq3v9yP/0aUJbNoEnIokPcMoSyVdnkr49T5
 DpMdxVDPueCwruXbR5vqck9fEQfYPpswfK0r9FYdRRj6AztFQRPFTn5058wQgBUFKYeN Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7sj7t4qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:54:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32AGsSBb016600
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:54:28 GMT
Received: from [10.216.55.163] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Mar
 2023 08:54:21 -0800
Message-ID: <8aadbea6-29c0-713f-ced3-263307ad0051@quicinc.com>
Date:   Fri, 10 Mar 2023 22:24:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-2-quic_kriskura@quicinc.com>
 <ade5b126-9506-5e0d-3071-d26c97ecfc9a@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ade5b126-9506-5e0d-3071-d26c97ecfc9a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xxycwd_jZulj4EyrcYQy571dZb8zrAok
X-Proofpoint-ORIG-GUID: Xxycwd_jZulj4EyrcYQy571dZb8zrAok
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0
 suspectscore=0 mlxlogscore=597 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/10/2023 10:11 PM, Krzysztof Kozlowski wrote:
> On 10/03/2023 17:34, Krishna Kurapati wrote:
>> Add bindings to indicate properties required to support multiport
>> on Snps Dwc3 controller.
>>
>> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> What happened with entire previous changelog? This is not v1 but v5 or
> more? At least v4 was here:
> 
> https://lore.kernel.org/all/20230115114146.12628-2-quic_kriskura@quicinc.com/
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

   Since I pushed a formal patch series, I mentioned PATCH in header 
instead of "Patch v5". If the RFC v4 is to be followed by Patch-v5, I 
can re-push the changes again with a proper header and fix my mistake.

The previous change log is mentioned in cover letter.

https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/

Regards,
Krishna,
