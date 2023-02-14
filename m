Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1333B696F34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjBNVV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjBNVV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:21:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FC4C1B;
        Tue, 14 Feb 2023 13:21:26 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E5vpG5019603;
        Tue, 14 Feb 2023 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EPOS+mC6owHZicF0E9fRU/+aTK9FaaTURvDTgPScYjA=;
 b=CmFDSbusbNuQ4oEwlZBQ+Ra+V7nMooY84E6Ji639c7mYHlIQ/u1mrGQvmxmI1zfLdGZ6
 mQFw1w0pmeUI8/jGtko6r4Zj2F+keel3+LwbU1UZu4AcepUfQnvOuDBe5VFbD9M6/4kO
 3lTdQbHi+mKN16PvnIL3ZKVw/wWEYRrySv2jbQAFC6Gz0Kwrt0CoXL6rmayIM4ISRVcb
 iCR+BRqsuEhyTZxMWPgZUc6j+nWLpmUsO2gpmTHXflE9swFhx/szoe+RQFR58xpdxQDJ
 TAdem0/4VuQirip8RPJ1XnZSL8aDCz4iQlGQdJbwJjdlN/61bWnul9bG6cbqOvr738DF 0g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr4kpa7ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:21:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ELLLb2030392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 21:21:21 GMT
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 13:21:20 -0800
Message-ID: <b6d2c965-f499-3c0e-9f46-5304d20e66fb@quicinc.com>
Date:   Tue, 14 Feb 2023 13:21:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/9] dt-bindings: soc: qcom: aoss: Document
 power-domain-cells for aoss
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-4-quic_molvera@quicinc.com>
 <86f5121c-d9de-250d-b845-fee70f28c1c6@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <86f5121c-d9de-250d-b845-fee70f28c1c6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cYR1TrKXIXCYzdwh6-XPy7T0cMyroEJQ
X-Proofpoint-ORIG-GUID: cYR1TrKXIXCYzdwh6-XPy7T0cMyroEJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=877 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140183
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 12:25 AM, Krzysztof Kozlowski wrote:
> On 13/02/2023 19:52, Melody Olvera wrote:
>> Document "#-power-domain-cells" field for aoss devices as required
>> by power-controller bindings.
> The power domain cells are for power domain providers. The reason to add
> them is because it is a power domain provider. Power-controller bindings
> do not require drivers which are not power controllers to become such...
> and this driver is not power domain provider / power controller, is it?

You're correct; I didn't realize. I'll drop this patch.

Thanks,
Melody
>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Best regards,
> Krzysztof
>

