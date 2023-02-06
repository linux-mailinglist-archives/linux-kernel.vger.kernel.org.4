Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7472A68BBE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBFLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:42:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3565B0;
        Mon,  6 Feb 2023 03:42:38 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3166KBHh003454;
        Mon, 6 Feb 2023 11:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2AkN329K6J+91VYzBSNBGV3qS2/+ZXQLtTRYt0TZRG0=;
 b=YP6o5PT6XaAgW6lBHHMXOlQCramnKS0OKaQp05U3WakVK8Ze51EK+3YpqqDg0HOZa+V9
 dFddCWdfN1LTbB7tKNBNAYk8DjvxiUXdTODn2FG0wFuJpEVGq7EpikRVVjmXqYFfPgbV
 MH1xZPBmNQnJx0VBjkRKQY5S5nvEyCsK9IjE1w8+sPYpEm44tbm5bEqeJXwWwIN1BlAZ
 IhQy6zc1nG55WIHk886qaIHqkb6mE/pJNhyyKWTIq0acPaN9wscvST4HERYPSg1urSL6
 KFN2y5DSo3qQHrCUll1kU3uKE4xiFndGvA7XF8TP4uq8nuFokSQAhMfIeE4DdTx/E1FZ oA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhff2kjue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 11:42:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316BgIC1005857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 11:42:18 GMT
Received: from [10.50.19.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 03:42:11 -0800
Message-ID: <b5f08d0b-6009-39bb-1819-322a8dc056c4@quicinc.com>
Date:   Mon, 6 Feb 2023 17:12:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 0/9] Add minimal boot support for IPQ5332
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <CACRpkdbtEFCSKX8VcD9bAZLy-PYfwVCRKYwXJmh0hnK2Nroq0A@mail.gmail.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <CACRpkdbtEFCSKX8VcD9bAZLy-PYfwVCRKYwXJmh0hnK2Nroq0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iWipT9JYFiain5QlH-cLgyurHdlkRwe6
X-Proofpoint-GUID: iWipT9JYFiain5QlH-cLgyurHdlkRwe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_05,2023-02-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=900
 suspectscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060100
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/6/2023 4:55 PM, Linus Walleij wrote:
> Hi Kathiravan,
>
> thanks for your patches!
>
> On Mon, Feb 6, 2023 at 8:12 AM Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
>> Kathiravan T (9):
>>    dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
>>    pinctrl: qcom: Introduce IPQ5332 TLMM driver
> I have applied these two patches to the pin control tree for v6.3.


Thanks a lot Linus!


>
> I see no reason to wait for more review since Krzysztof acked the
> bindings and the driver isn't invasive at all, any problems can certainly
> be fixed up in-tree.
>
> Yours,
> Linus Walleij
