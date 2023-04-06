Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F16D991F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjDFOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbjDFOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:08:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9BCA246;
        Thu,  6 Apr 2023 07:08:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336BpXij002789;
        Thu, 6 Apr 2023 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aKFvk1JtXx2S9NUKKALGnrNEGdO96VrOsyhOMvOmCRQ=;
 b=fF3u35ei2sQTkzYRX5bmRlbmDI6B4CY6uZBw+TVfQdR5LGERtKNBM72KAnTOcz5mWGGg
 HKHJ7BflOWzaWdC0GIgmt5+wdDH4lWzRrsCZQY+g5gSspA6rsX/4vjuQ803TCJ7g+jMH
 PBS+ApI3mo6PBX9waueRWBxwcLm9KDWMr+GguoJE5fAcdss6KEZQXYdcHBILjubwTlwh
 JYIGL82C7MG+u2Ci6B4nI6Z4tJrADoL5F9ZJ3sHZikExI9/6aEptmdetdsMLSUFZbxKO
 8AwpxosdsrNrFhEZOKcluyoKyLv1uNFybr1RFLSO3YHkScKhiq0DHAk7zxWmEBDnvzel xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3psnmj1cc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 14:08:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 336E88BF009755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 14:08:08 GMT
Received: from [10.216.10.176] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 6 Apr 2023
 07:08:00 -0700
Message-ID: <fa8838de-7d7e-71dd-9f9f-2604bd0faf1a@quicinc.com>
Date:   Thu, 6 Apr 2023 19:37:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-2-quic_kriskura@quicinc.com>
 <63bfaa1e-c627-bfe1-0bef-d001dae41014@linaro.org>
 <c18db964-1af7-7bbf-0d0f-cbb037f7500a@quicinc.com>
 <20230405201709.GA397286-robh@kernel.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230405201709.GA397286-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xyl_e54sFDmZnliyj18Hs0Viud3qGZjz
X-Proofpoint-ORIG-GUID: Xyl_e54sFDmZnliyj18Hs0Viud3qGZjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_07,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=869 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060125
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/2023 1:47 AM, Rob Herring wrote:
> On Wed, Apr 05, 2023 at 07:45:07PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 4/5/2023 7:31 PM, Krzysztof Kozlowski wrote:
>>> On 05/04/2023 14:57, Krishna Kurapati wrote:
>>>> Add bindings to indicate properties required to support multiport
>>>> on Snps Dwc3 controller.
>>>>
>>>> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>> Link to v5: https://lore.kernel.org/all/20230310163420.7582-2-quic_kriskura@quicinc.com/
>>>
>>> You did not test it at v4 and you got report for this. Your changelog in
>>> commit msg does not mention fixing it.
>>>
>>> It looks like you did not test it for the second time (or sixth time).
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi Krzysztof,
>>
>>    I did do a dt_binding_check and I got the following result:
>>
>> kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales2/skales/kernel$
>> make DT_CHECKER_FLAGS=-m dt_binding_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>    HOSTCC  scripts/basic/fixdep
>>    HOSTCC  scripts/dtc/dtc.o
>>    HOSTCC  scripts/dtc/flattree.o
>>    HOSTCC  scripts/dtc/fstree.o
>>    HOSTCC  scripts/dtc/data.o
>>    HOSTCC  scripts/dtc/livetree.o
>>    HOSTCC  scripts/dtc/treesource.o
>>    HOSTCC  scripts/dtc/srcpos.o
>>    HOSTCC  scripts/dtc/checks.o
>>    HOSTCC  scripts/dtc/util.o
>>    LEX     scripts/dtc/dtc-lexer.lex.c
>>    YACC    scripts/dtc/dtc-parser.tab.[ch]
>>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
>>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>>    HOSTLD  scripts/dtc/dtc
>>    LINT    Documentation/devicetree/bindings
>> invalid config: unknown option "max-spaces-inside-empty" for rule "brackets"
>> xargs: /usr/bin/yamllint: exited with status 255; aborting
> 
> This indicates your yamllint version is too old.
> 
> Rob

Let me give a try with latest version.
Thanks for pointing it out. 🙂

Regards,
Krishna,
