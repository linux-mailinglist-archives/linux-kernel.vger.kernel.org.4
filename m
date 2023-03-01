Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8E6A732F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCASNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCASNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:13:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF601BD5;
        Wed,  1 Mar 2023 10:13:45 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321CGDCb005351;
        Wed, 1 Mar 2023 18:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=PkCoY5YJaplAxoxuh+GGCM1Gzz64qER+fDDhom7xHj4=;
 b=fQWN89fcJdkqLMV2eKbK3SixilnfoD+GQmSin4g69HJTS9dwpdepqFNPyO3cCt0qeTta
 F8/UPhPpgzGlrV+Xu6yPrX8qR6MoCt9jc0xa8M/nxLdaEFjGt/n4t3x8m2cBU5Uebo/y
 HiTvLMvC6+6j4d7x9Cf10bBMZ4p3NUAxythO7pCouR9ZMbQMZlKFKtH+QZyW4rhwtFQc
 /fTSYt/n3nxQ8sBEesbZjjmzwBWoh931uuXmx0MFS+Cg9KXxmaXWOHplARFc57Tbm4DA
 A+xaHtMbmuFX6zdc67oosxayZAOU0m+tkDxIlKECVh3ooIhxcTKsesu/B84kaG0pqJ2U tA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1vgejs19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 18:13:22 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321IDKOx027145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 18:13:20 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 10:13:20 -0800
Date:   Wed, 1 Mar 2023 10:13:19 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ufs: mcq: qcom: Fix Smatch static checker warning
Message-ID: <20230301181319.GE10301@asutoshd-linux1.qualcomm.com>
References: <80523aada69f5cab90cac76c84aa153b1ea648ad.1677608784.git.quic_asutoshd@quicinc.com>
 <20230301070508.GA5409@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301070508.GA5409@thinkpad>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P4gXMN0J5Z2Iy4ftECDgsQ5Mag5xkoON
X-Proofpoint-ORIG-GUID: P4gXMN0J5Z2Iy4ftECDgsQ5Mag5xkoON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2023 at 23:05 -0800, Manivannan Sadhasivam wrote:
>On Tue, Feb 28, 2023 at 10:27:06AM -0800, Asutosh Das wrote:
>> The patch (c263b4ef737e: "scsi: ufs: core: mcq: Configure resource
>> regions") from Jan 13, 2023, leads to the following Smatch static
>> checker warning:
>>
>> drivers/ufs/host/ufs-qcom.c:1455 ufs_qcom_mcq_config_resource() warn:
>> passing zero to 'PTR_ERR'
>> drivers/ufs/host/ufs-qcom.c:1469 ufs_qcom_mcq_config_resource() info:
>> returning a literal zero is cleaner
>>
>> Fix the above warnings.
>>
>
>You should not name the subject after the tool that used to find the issues.
>Instead, subject should mention the actual issue like fixing return values,
>removing the devm_kfree in error path etc...
>
>Provided that, you should also split this patch into two as you are fixing
>two independent issues.
>
>Thanks,
>Mani
>

Thanks for taking a look.
I will fix it in the next version.

-Asd

>> Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
>> ---
>>  drivers/ufs/host/ufs-qcom.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 34fc453f3eb1..cb20c7136c2c 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -1451,8 +1451,8 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>>  		if (IS_ERR(res->base)) {
>>  			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
>>  					 res->name, (int)PTR_ERR(res->base));
>> -			res->base = NULL;
>>  			ret = PTR_ERR(res->base);
>> +			res->base = NULL;
>>  			return ret;
>>  		}
>>  	}
>> @@ -1466,7 +1466,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>>  	/* Explicitly allocate MCQ resource from ufs_mem */
>>  	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
>>  	if (!res_mcq)
>> -		return ret;
>> +		return -ENOMEM;
>>
>>  	res_mcq->start = res_mem->start +
>>  			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
>> @@ -1478,7 +1478,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>>  	if (ret) {
>>  		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
>>  			ret);
>> -		goto insert_res_err;
>> +		return ret;
>>  	}
>>
>>  	res->base = devm_ioremap_resource(hba->dev, res_mcq);
>> @@ -1495,8 +1495,6 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>>  ioremap_err:
>>  	res->base = NULL;
>>  	remove_resource(res_mcq);
>> -insert_res_err:
>> -	devm_kfree(hba->dev, res_mcq);
>>  	return ret;
>>  }
>>
>> --
>> 2.7.4
>>
>
>-- 
>மணிவண்ணன் சதாசிவம்
