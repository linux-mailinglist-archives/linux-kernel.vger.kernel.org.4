Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6BE5F46AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:27:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730322A961;
        Tue,  4 Oct 2022 08:27:52 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294F8J6k029513;
        Tue, 4 Oct 2022 15:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zyLq0PBfAnT7RYguxlx3UP0BjMuFPEQa0WL1wruEIUg=;
 b=NTXRhCTD9o5ldHDK/uE9QfZCvDmRdnM+ELetjPAK1PQ2aeHjGxUJ/1kyqthThdDoXk00
 lGf0pBBUkJUkwwnnQv+h4EfbTi83OuMUogX8Nr01ivbuXA1eIUYaS5iAW90uqiNFD+Bf
 Hn2I6ktNSlDzuyXBqZsof0V/ejZekuxWqf/POMqxV6J5gY7a1OflVPcycrE5esvI+gpN
 2tiK28tVPLRmirX75NPFEYjTqlYwkE8NoXjMAn0RlfeTmlqPOfTXcB2ldwovFXKruGs6
 yy24kELcd3LTP+6/ilgjoTjd2YdbULDNZc5vkM1FxLu/UjIMNu6rtlxSD+d0M97vTMDk 1w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxcvtx8gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 15:27:49 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294FRlve019320
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 15:27:47 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 08:27:46 -0700
Message-ID: <2e385bec-6eff-a410-d977-c3f99c69ab42@quicinc.com>
Date:   Tue, 4 Oct 2022 10:27:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/5] Add misc support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <084e6f2f-0976-85c8-e27c-b5ed7722d396@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <084e6f2f-0976-85c8-e27c-b5ed7722d396@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fQVEXySW8fswh7qm-8wY1brY1ctaUwcd
X-Proofpoint-ORIG-GUID: fQVEXySW8fswh7qm-8wY1brY1ctaUwcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxlogscore=979 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040100
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/1/2022 4:34 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> This series firmware, SoC, rpmpd, tz-log, and mmc bindings as well as
>> pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.
>>
>> This patchset is based off of [1] and [2] YAML conversion patches.
> All of your patchsets were sent to wrong Bjorn's address. This means
> either you based on mainline (which is reasonable but for some reason
> address was not fixed in mainline...) or on some older linux-next.
>
> I propose to rebase on recent linux-next, so you will get proper Bjorn's
> email.
>
> Best regards,
> Krzysztof

Thanks Krzysztof. Yeah I figured that out; will add his most recent email in the next patchset. I was working on the tip of the linux-next stable branch, but does it make more sense to rebase on the master branch of linux-next prior to submitting?

Thanks,

Melody

