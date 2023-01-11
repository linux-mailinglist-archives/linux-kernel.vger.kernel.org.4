Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AFE666753
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjAKX6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAKX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:58:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0134D4D;
        Wed, 11 Jan 2023 15:58:08 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BNh0WV022981;
        Wed, 11 Jan 2023 23:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Pq6DfPp2nmGGS2yFb2eHqopjSlvHS130z7zBWea5UTw=;
 b=lS/vQvbpcsy48KCoRePbN2MrQ84jFixRJVAtnFg60ev7WQcwCtun/hJOLqXepPjiI5FL
 q1mbrkjLH4oWDSx3r4TIqGnLlWeFMXT3Dcg38B3EW0hkAcXWrqgtaRwp1xq4+Bg+u4mN
 bwTe9V2zVhTHNYGwn5Vg1t1PoY1PknXb1ws8JCRdDKuDl1Jn30x7rYbKP+be0RoJTCbq
 5rRTsK03IMOVVPGZpqh2TLVwS+xuPnBAj6EkAURGkikL8ZP59De8lgClLBstjyRN8PeS
 2awBrOr7YY4i4eNprLDTpO1Qq4xBqs9m4q6iPEVkmDdsv6kJsP5qu0CGFbD55td4Z3xy vg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1ky4jgw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 23:58:01 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BNw1fL030122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 23:58:01 GMT
Received: from [10.110.116.113] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 15:58:00 -0800
Message-ID: <0794d7b5-2eb9-f11f-56bc-bf9d702022df@quicinc.com>
Date:   Wed, 11 Jan 2023 15:58:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add sysfs attributes for fields
 in v2-v6
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>
References: <20230111082141.18109-1-quic_namajain@quicinc.com>
 <20230111082141.18109-3-quic_namajain@quicinc.com>
 <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <08ffedc3-3104-18fc-4813-287eccd1fdca@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sSt9gh7AJiqRztRnuBZLPmURgNNLcAD3
X-Proofpoint-GUID: sSt9gh7AJiqRztRnuBZLPmURgNNLcAD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 mlxlogscore=696 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110176
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2023 3:19 PM, Dmitry Baryshkov wrote:
> On 11/01/2023 10:21, Naman Jain wrote:
>> Add support in sysfs custom attributes for fields in socinfo version
>> v2-v6. This is to support SoC based operations in userland scripts
>> and test scripts. Also, add name mappings for hw-platform type to
>> make the sysfs information more descriptive.
> 
> Please include a patch documenting your additions to 
> Documentation/ABI/testing/sysfs-devices-soc. Please describe usecases 
> for new attributes and their applicability to non-Qualcomm boards.
> 
> Note, that testing scripts can access debugfs entries without any issues.

The commit text mentions the "userland" scripts and it could mean the 
product OS like Android or Yocto having the applications using these 
/sysfs entries. Naman, please clarify if the vendor application layer in 
the Android is using these Entries to make decisions based on the 
platforms / soc information?

---Trilok Soni
