Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A1697006
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBNVrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:47:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387829400;
        Tue, 14 Feb 2023 13:47:38 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EK65T2010074;
        Tue, 14 Feb 2023 21:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6NCAb+ClkItOONSxabmS6/8CYNLKrgnbP0lxkLcbOCc=;
 b=dsnAXD9t2DldWUXmSfg1eRhCJ+O0w0wKQX2GxnoD5FUFgB8SUkfii2Eyti1ou0kMUTGe
 +evfXO9a1AmmkawoLhmr03k0zDVHU/IMNo6ElQwW2SZb7DDbg/QoaONL/Jkxi6YuFyUD
 jyAaMG3lC53mDUiYynxCbMnjbMG6gXlvFMWSeHxWJrBA2Mb/tEB/tNUWfICCsOkK1JxG
 fyywMXGGu8ClLYgOtrYbHaEqKd5h3ZbMVkwVJ1C8kqoufp/4JmKLS8r3Lp80FL8xi5Ms
 foR5fji7IQUhGaAdA0IZyP9vxmw4zbFx/WUcc3Ao5ePk1hAc9GEPVR5hsiiUqGft2ySI 4w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtv0bfj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:47:35 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELlY9X005546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:47:34 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 13:47:33 -0800
Message-ID: <63f41994-6408-1fe5-2d75-363dc6933eed@quicinc.com>
Date:   Tue, 14 Feb 2023 13:47:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230213190122.178501-1-quic_molvera@quicinc.com>
 <20230213190122.178501-2-quic_molvera@quicinc.com>
 <7336923b-e322-1211-0c1d-7ad70c7bfef7@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <7336923b-e322-1211-0c1d-7ad70c7bfef7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1u1ylr2O_BeTw-I7zpYupQgODldTjDdN
X-Proofpoint-ORIG-GUID: 1u1ylr2O_BeTw-I7zpYupQgODldTjDdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=442 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140185
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 1:47 AM, Krzysztof Kozlowski wrote:
> On 13/02/2023 20:01, Melody Olvera wrote:
>> Add nodes for IPCC, MPSS, and AOSS drivers. Also update
>> the scm node to include its interconnect.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>
>>  
>> +		aoss_qmp: power-controller@c300000 {
>> +			compatible = "qcom,qdu1000-aoss-qmp", "qcom,aoss-qmp";
>> +			reg = <0x0 0xc300000 0x0 0x400>;
>> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
>> +						     IPCC_MPROC_SIGNAL_GLINK_QMP
>> +						     IRQ_TYPE_EDGE_RISING>;
>> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +
>> +			#clock-cells = <0>;
>> +			#power-domain-cells = <1>;
> This does not look right. Which part of aoss-qmp registers power domains?

You're right; I didn't realize part of the driver that registered this had been removed. Will drop
that line.

Thanks,
Melody
>
> Best regards,
> Krzysztof
>

