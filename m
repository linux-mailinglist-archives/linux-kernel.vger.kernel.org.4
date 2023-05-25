Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5FE711806
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbjEYUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjEYUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:21:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBDFBB;
        Thu, 25 May 2023 13:21:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PKF3fg004577;
        Thu, 25 May 2023 20:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+jv0tSUkqXYAsbK/kPqtx+0ChG7JKI02Wxt8hXxY6ic=;
 b=ZF77pkntnQnPZspifzfWSQ/NkR5X4P/Aq2yK8wmd1CS4VT6u9aOufiLWF+r0sLnFnPRN
 o/Kdm0Rr9J6rsUOLDtlIxp/7TUXN5DBg0XAKlNB+pB5637wSgB+NEXMWolIMX6WN4BXG
 aDHXUlliU3ItpXBA0Xc20gUpXHRSb+KO63auMXBjnHBIIh+79Bw4eDGq0Rm45+5b5TTI
 uYJgaGuZfKP9Atmlz9w735W+CA7ZDbmL+WX7nNHlVaSHnZsTDaPh2pGQjF6hZJXZwkCa
 J2cA8RM+SUrF/3gLX8cXyRQIbgALZCTAilE4mNgzvSgTu5SdwtklmuhBrQ2uNnlDamuY Zg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsqqjay6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 20:21:47 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34PKLkgw030985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 20:21:46 GMT
Received: from [10.110.51.179] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 13:21:45 -0700
Message-ID: <44062c19-673c-f65e-2ee9-f49bf38fed1a@quicinc.com>
Date:   Thu, 25 May 2023 13:21:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ansuelsmth@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
 <20230525120956.3095317-2-robimarko@gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230525120956.3095317-2-robimarko@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fzQOidQUoPcouyI1M6lFZZhxiGJJ2l7k
X-Proofpoint-ORIG-GUID: fzQOidQUoPcouyI1M6lFZZhxiGJJ2l7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250172
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2023 5:09 AM, Robert Marko wrote:
> SMEM has been GPL licensed from the start, and there is no reason to use
> EXPORT_SYMBOL() so switch to the GPL version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Excellent. Thank you.

Reviewed-by: Trilok Soni <tsoni@quicinc.com>

---Trilok Soni


