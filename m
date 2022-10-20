Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309060687D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTSzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJTSzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:55:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024E109D74;
        Thu, 20 Oct 2022 11:55:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KImKfS019504;
        Thu, 20 Oct 2022 18:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cAKh7P/WUcWrGrJvQqjzPkZ9P+JRGd3BvMSSASlphww=;
 b=ndCf2rVLi1wpWm0BWCVSLp8lLNLcYTJx6YQAplpyxRZY+xnsIXlEijR3PPhhilfbbOVl
 5Vum6dSkhkRj3nN4OWQdxP9GSQW0bLr2dNOULOXNRNNXDAPzlSEpLG9Mv7zqaYNhAcjY
 RfNkccm8SK4r60qNqJGMj05kkJX01CB7F53JmM0zprmX6P8y1qsvH4cnm3ffjN/y1SZq
 xiujpJ65+D74l193i/MfmjyOjAxbspK+LLXKr6Yq5I63zbYr8JpPEZ545P9C15jenvdY
 yeZZNhG5fkFXUAzFFp4awgQAxbWAN94u9Jxx+2VhXqtFKG+E3IrEFzRFAMKSC64veUgQ aA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb8ckgvma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:55:08 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29KIt7w4023841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 18:55:07 GMT
Received: from [10.110.41.234] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 20 Oct
 2022 11:55:07 -0700
Message-ID: <bb2e92c8-8e19-8840-c1ec-8c7ef667fdbf@quicinc.com>
Date:   Thu, 20 Oct 2022 11:55:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
 <56af2a04-1b21-000d-e3f9-86b6ac74aaf2@linaro.org>
 <a0032338-482f-0de7-5952-c3c8b8423df6@quicinc.com>
 <50372a15-56ce-6ad6-f622-00624b909db8@linaro.org>
 <Y1FTJgloEi5ag2/j@gerhold.net>
 <9fbe1bf5-a84d-c56b-1c0e-6848ee3d30fe@linaro.org>
 <Y1GCs6uCz5o9az+v@gerhold.net>
 <835d3432-daf2-e824-5c84-7d47604f586f@linaro.org>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <835d3432-daf2-e824-5c84-7d47604f586f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UUPu6WheNAv7RIcGQ6nJVFxLWvCN6d85
X-Proofpoint-ORIG-GUID: UUPu6WheNAv7RIcGQ6nJVFxLWvCN6d85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=856 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2022 10:59 AM, Krzysztof Kozlowski wrote:
> On 20/10/2022 13:18, Stephan Gerhold wrote:
>>> No, it puts attention to the board designer that he needs to provide the
>>> clock in his design.
>>>
>>> We had such talks about other platforms, although I do not have any
>>> recent bookmarks. Something older:
>>>
>>> https://lore.kernel.org/all/3382034.5ADO0F7naY@wuerfel/
>>>
>>> https://lore.kernel.org/linux-samsung-soc/53DAB0A6.9030700@gmail.com/
>>>
>> If I understand you correctly your argument for having the clock in the
>> board DTS instead of the SoC DTSI is:
>>
>> The SoC DTSI describes the components of the SoC, while the board DTS
>> describes the components of the board (built around the SoC). The clock
>> is part of the board (and not the SoC) and therefore belongs into the
>> board DTS and not the SoC DTSI. Having the SoC/board components clearly
>> separated ensures people writing new board DTS pay attention to
>> everything board-specific.
>>
>> Correct? This sounds reasonable to me.
> Yes.
>
>> However, the main question of my previous mail was: Why do you
>> alternatively recommend to keep the clock defined in the SoC DTSI and to
>> just put the clock-frequency into the board DTS? This sounds like a
>> contradiction of the above to me: the clock is still (partially)
>> described as part of the SoC, even though it belongs to the board.
> The proposal is a trade-off, compromise between code duplication and
> above recommendation of splitting SoC <-> board.
>
> As you said, all boards will provide this clock, so it is reasonable to
> put some pieces of it in the SoC DTSI to avoid duplication. But the
> final piece - what clock is there exactly (model, frequency etc) should
> be put in board DTS to clarify that this comes with board.
>
>> Someone writing a board DTS should not just put attention to the
>> clock-frequency, but also if they have a single fixed-clock or
>> maybe some kind of clock-fixed-factor setup, as I wrote.
> True. If such setup is probably, then my recommendation would be to put
> entire clock to the board.
Going through this thread, this seems to be the conclusion. Will all clock nodes to the
DTS files.
>
> Just note, that even in proposed frequency->board DTS, it is still
> possible to use the clock-fixed-factor.
>
>
Thanks,
Melody
