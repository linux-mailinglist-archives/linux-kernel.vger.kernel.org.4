Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C26665AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbjAKVhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjAKVhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:37:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85820193DD;
        Wed, 11 Jan 2023 13:37:38 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BIwcQp030624;
        Wed, 11 Jan 2023 21:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=73v7h9gaVWnsHfRd3nEUmHjhkhyk2FVAxSIKlBk+LMg=;
 b=NOAz35kqtEQeuSKxCYRxxDdeAll4dgDK73WPKpLxx6teO/ptUHlDb+T6ctpth6CqRGW6
 +G130gVjwhZR4s1Bu22YCp/W5wn6pT9g3+iXJyXmPbMlW2NXCeTzfXx2sMnThiCbtsY2
 F+772j/loFN0DkTMJhQkmg2m3APcSlS8vLVbWvpLn43KcaLTfUHAkGY6lFrURVZSqntQ
 /kNG1WhX8uNAsMIVEW0toHcjkDhJtXsh0xCe/HkQYoMCcAwgaikswi922dLcvrMQKsci
 mBJ/cGAw6DZUfB97OAhTu39mcWWN02JYSWSleo+WzvEh6H3WYnHRBq/ew7Nu5wtbmrJW NQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kaxabuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 21:37:32 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BLbVOX012840
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 21:37:31 GMT
Received: from [10.110.116.113] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 13:37:31 -0800
Message-ID: <2f1d92e7-08e0-13f3-2087-f0c55d83383c@quicinc.com>
Date:   Wed, 11 Jan 2023 13:37:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: Change socinfo variable name and
 scope
Content-Language: en-US
To:     Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-2-quic_namajain@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230111082141.18109-2-quic_namajain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RuraqHbRXjqM1OyRBPUVAWJd9hAzima_
X-Proofpoint-GUID: RuraqHbRXjqM1OyRBPUVAWJd9hAzima_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 12:21 AM, Naman Jain wrote:
> Change socinfo structure variable scope from function to file
> to make it easy to support custom attributes for sysfs. Also,
> change variable name to make it more descriptive.

Did you mean debugfs?

Can you one example of custom attribute in the commit text so that we
understand the motivation better?

> 
> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
> ---
>   drivers/soc/qcom/socinfo.c | 80 ++++++++++++++++++++------------------
>   1 file changed, 42 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index 10efdbcfdf05..251c0fd94962 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -175,6 +175,7 @@ struct socinfo {
>   	__le32  npartnamemap_offset;
>   	__le32  nnum_partname_mapping;
>   };
> +static struct socinfo *soc_info;

Is there any better way to do it? Should not asume the just one object
and dynamically allocate it? Let's wait for Bjorn to check as well.

---Trilok Soni
