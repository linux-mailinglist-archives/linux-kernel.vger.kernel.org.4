Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0561184D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ1Qzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJ1QzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:55:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B86DFBB;
        Fri, 28 Oct 2022 09:55:05 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SFEXVV013225;
        Fri, 28 Oct 2022 16:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=65w+/b1UcSm9ZrL4tVY5V+QxqSjkxIl5y2VasRMireM=;
 b=aCONdXr9c7n57SarGkcKROdMjW82I9wv4LuKR4wimR9Kg3G5ORZkcsWVNZH8a7aDnVEQ
 DmHC7jG8K3M7bte2OJzHE/YS3+apmtNvVRFfPkCv4ENX8wxq5IW2bcbWlQw04OMhznwv
 dR1KbMKWKMzbGX+r9Da6bjxnD22y2l4MAs4GZf5Z5oGv3hY4aGU+lbtv7SOVY88iVJEn
 Pnav0ap2i541Z9OcXFCTy2dVijOICPGzNB0KEQ9WYlnn0uvgqYYEXKpur0AF0HK3C8h1
 1+1y5zKxx3N3XQpZnA6QQsR60bNJI3p3QAaUXiFOSLQ9sjwwmhsKCXEAGlwsuj5Pq7hE Dw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kgdaw0wwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:54:55 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29SGssdH028525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:54:54 GMT
Received: from [10.110.28.248] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 28 Oct
 2022 09:54:53 -0700
Message-ID: <9707bf67-1b22-8a77-7193-fc909b4f49de@quicinc.com>
Date:   Fri, 28 Oct 2022 09:54:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Add RPMHCC bindings for
 QDU1000 and QRU1000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026190441.4002212-1-quic_molvera@quicinc.com>
 <20221026190441.4002212-3-quic_molvera@quicinc.com>
 <de2cd5c0-1c3d-5d47-4896-82e32f3c0d88@linaro.org>
 <52cf61ed-88bd-b04e-1596-15013d613c4c@quicinc.com>
 <f6293fb0-9892-1f94-47a6-a9275231d741@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <f6293fb0-9892-1f94-47a6-a9275231d741@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iJ61gDpusWNyjJRI8XTQkhH4wAApkNkh
X-Proofpoint-ORIG-GUID: iJ61gDpusWNyjJRI8XTQkhH4wAApkNkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=758 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 6:09 PM, Krzysztof Kozlowski wrote:
> On 27/10/2022 21:04, Melody Olvera wrote:
>>
>> On 10/27/2022 8:57 AM, Krzysztof Kozlowski wrote:
>>> On 26/10/2022 15:04, Melody Olvera wrote:
>>>> Add compatible strings for RPMHCC for QDU1000 and QRU1000.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>> This looks correct except:
>>> 1. redundant bindings in subject
>>> 2. not cc-ing all maintainers
>>>
>>> so still not tag.
>>>
>>>
>> Not sure what you mean by redundant bindings; should I remove
>> "QRU1000"? "Compatible strings"? Please advise.
> In the subject please drop second 'bindings' word, because it is
> redundant so:
>
> dt-bindings: clock: Add RPMHCC for QDU1000 and QRU1000
> or
> dt-bindings: clock: Add QDU1000/QRU1000 RPMHCC
Oh ok that makes sense. Sorry about the confusion.
>
>> Also, I got maintainers from running get_maintainers.pl on
>> linux-next/master; is this wrong? Not sure what I'm missing here.
> You miss some of Qualcomm maintainers. Maybe more, I did not check every
> possible output for every patchset. I just spotted missing Konrad,
> because it sticks out. If you copy the output of some commands, be sure
> you copy everything. Otherwise, just automate it so there will be no
> chances for mistakes.
Ah ok no worries. Will make sure my copy-paste is thorough.

Thanks,
Melody
