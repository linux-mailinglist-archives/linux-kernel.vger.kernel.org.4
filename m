Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1408A7147EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjE2K3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjE2K3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:29:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0EDF;
        Mon, 29 May 2023 03:29:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T9WNAq014816;
        Mon, 29 May 2023 10:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+GnvblfIUOkZ/zDNtcKmp2FvpIbjJT1RpBnh3d/65Wg=;
 b=HspXfgbfHymTAxrx59OLOZ5U/l39lu56Rda+Dz4w0b8CquOdTORI/KmzpG7/MlvVToe9
 gnyK3jlKAHj6LliK4f6vc/hOuVI5JlFHd8syas86mCd6uGEQbywwBsntH8O1Muwbr4wP
 ILtjL2KTIoQBJ0wlLoHu9khaOqdWm+ZpmAVN1M0y+92jCV0YoDic7Mch0VvZcpC5GSWT
 5umZtS+WWdwqCTFcegu9eeeGtSgGFWAgoHJTQFQLhQ3jHp3m+f5i3Y5y+2evINW+9gKQ
 w4dKWHCcKgM35H187FdX8j1cNIAIksvFB299Is3YjDAFoB/cteHXIvgdv4v+SSexJDFk 0A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quarmb6yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:28:55 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TASsI4032463
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 10:28:54 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 03:28:48 -0700
Message-ID: <3f1ea35c-694b-b4d7-4fc3-0f4902b809ed@quicinc.com>
Date:   Mon, 29 May 2023 15:58:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <andy.shevchenko@gmail.com>
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CACRpkdaX3i-O3=8XbLYJ1hXT8dOE7WJUUT6JxOKmWTJwru_24Q@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CACRpkdaX3i-O3=8XbLYJ1hXT8dOE7WJUUT6JxOKmWTJwru_24Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6VBjN16-9Xy6ugrQBxFq_RqkOX0DC1gg
X-Proofpoint-GUID: 6VBjN16-9Xy6ugrQBxFq_RqkOX0DC1gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_07,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=849 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290090
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 5/22/2023 1:02 PM, Linus Walleij wrote:
> On Fri, May 19, 2023 at 2:55 PM Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
> 
>> Add pinctrl definitions for the TLMM of IPQ5018.
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [v7] No change
> 
> This looks mostly fine, but I want you to consider Andy's remarks.
> With those addressed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
  Thanks.
  Sure, will fix and repost with Andy's comments addressed.

> Can this file and the bindings be applied independently of the rest
> of the patches? In that case I can apply v8 bindings+this patch to
> the pinctrl tree.
> 

  Yes, this can go independently. Will repost v8 tomorrow.

Regards,
  Sricharan
