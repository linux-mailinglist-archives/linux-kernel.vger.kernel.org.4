Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3406C5FCC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:32:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6688051C;
        Wed, 12 Oct 2022 13:32:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKUfki006677;
        Wed, 12 Oct 2022 20:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P2TPIiA+0mTD5pa1egLsXhq/uA93iMdOPw4zh7UICaY=;
 b=Z1zyxrwd+fdayj85fpfZ8y/EH0S54lk66TCZOMBWKw/kFKtgeDbqgwYeycTP0GPqyi7v
 qUYNK65GyFmP3f4Xu4sV3Py3S9R1EIxJea50G1+TIQYoKbRmg11klzbtarDecn0/5ndQ
 DQrtvF3Ys35Ooz/hzQUaTMyqinQ3R52erLBv026Uquhhns/Jgponj0/ckmhbHDcsJtmk
 ziGosasPjv71c3PmfmJxUwsRp2pQjY9P3i6/eC0bo1hMg7JlYvM0Qdoj27qtb98+ua/v
 NJFi8zeD2wwcZWmMqHXRzMk8oXSDco8Gp9v6FH2yKodysSNdQcM5B7l1MnwLiZdxRBvj cg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5q6b20yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:32:30 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CKWT70015136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:32:29 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 13:32:29 -0700
Message-ID: <116bc168-0c0d-7d61-976e-1e110166e7fd@quicinc.com>
Date:   Wed, 12 Oct 2022 13:32:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-5-quic_molvera@quicinc.com>
 <20221007031147.vjzfipbroo3gnohz@builder.lan>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221007031147.vjzfipbroo3gnohz@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uk2y-ZVV-EYqojmUB-VGohjxO_4TtJ0w
X-Proofpoint-ORIG-GUID: uk2y-ZVV-EYqojmUB-VGohjxO_4TtJ0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=994
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120130
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/2022 8:11 PM, Bjorn Andersson wrote:
> On Fri, Sep 30, 2022 at 08:06:40PM -0700, Melody Olvera wrote:
>> Add the power domains exposed by RPMH in the Qualcomm QDU1000
>> and QRU1000 platforms.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  drivers/soc/qcom/rpmhpd.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> index 092f6ab09acf..f70573cbc636 100644
>> --- a/drivers/soc/qcom/rpmhpd.c
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -353,6 +353,19 @@ static const struct rpmhpd_desc sm8450_desc = {
>>  	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
>>  };
>>  
>> +/* QDU1000/QRU1000 RPMH powerdomains */
>> +static struct rpmhpd *qdru1000_rpmhpds[] = {
>> +	[QDRU1000_CX] = &cx,
>> +	[QDRU1000_EBI] = &ebi,
>> +	[QDRU1000_MSS] = &mss,
>> +	[QDRU1000_MX] = &mx,
>> +};
>> +
>> +static const struct rpmhpd_desc qdru1000_desc = {
>> +	.rpmhpds = qdru1000_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(qdru1000_rpmhpds),
>> +};
>> +
> Looks like you missed adding a (or two) entires to rpmhpd_match_table.
So I did. Will add.
>
> Regards,
> Bjorn
>
>>  /* SC7180 RPMH powerdomains */
>>  static struct rpmhpd *sc7180_rpmhpds[] = {
>>  	[SC7180_CX] = &cx_w_mx_parent,
>> -- 
>> 2.37.3
>>
Thanks,
Melody
