Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F269BA04
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBRMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:38:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2288417174;
        Sat, 18 Feb 2023 04:38:52 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ICD8PE002280;
        Sat, 18 Feb 2023 12:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g3kOTMIXEvGqXsDw9ykYi5ROfsHk1clT6WdQXaM+IkA=;
 b=EIJdGhKM3eESaZKjKcM4pvjrqhAGQY2FCZbinaQwpnt/Hxp3SoWwgKasfGQp3+9ZUJhQ
 fj82t9qQwxwLIeWBTLlx5ojXB2N9vrmEUahUH42GAhLQw6ZNisY6CxW099QuzhhNK8VY
 FnzYapHyg60/dEJMyw7TQ7GJ5ynL9amwhSbaTahbYhyvvMq9ic/a1t4JscSiYJyGE08V
 Ivu0RUtptL++BkfMg1yMzHyZIsMd3/G2pER0EMrDAihPVRzMBAh82AB47oIdkT6Jr+HR
 K6swoQ4CnxOTvxfWKPe8DBLg/q3xunAdscNT39vw0bLUFzCb28hSvONWK9Tvk0JoHXbs +g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntps18swd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 12:38:42 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31ICcfLd010907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 12:38:41 GMT
Received: from [10.216.19.78] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 18 Feb
 2023 04:38:39 -0800
Message-ID: <3fe19c46-7013-5f93-8645-e294cf84940c@quicinc.com>
Date:   Sat, 18 Feb 2023 18:08:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] firmware: qcom_scm: modify
 qcom_scm_set_download_mode()
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
 <20230203190248.ywmb54gmdd4blv46@ripper>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230203190248.ywmb54gmdd4blv46@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UTKHes_NnYsK3p4_aCYVwHa8_uqPAMyx
X-Proofpoint-ORIG-GUID: UTKHes_NnYsK3p4_aCYVwHa8_uqPAMyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-18_07,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302180111
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2023 12:32 AM, Bjorn Andersson wrote:
> On Fri, Feb 03, 2023 at 03:47:15PM +0530, Mukesh Ojha wrote:
>> Modify qcom_scm_set_download_mode() such that it can support
>> multiple modes. There is no functional change with this change.
>>
> 
> As Dmitry said, you argue for added flexibility, but doesn't provide a
> user of that flexibility. I will drop this patch from the queue for now.
> 
> Please include this together with the patch(es) that benefit from such
> flexibility.

Sure, will add this along with patches which benefit from this change.

> 
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>    - Stop changing legacy scm id for dload mode.
>>
>>   drivers/firmware/qcom_scm.c | 15 +++++++--------
>>   include/linux/qcom_scm.h    |  5 +++++
>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index cdbfe54..6245b97 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>>   
>> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>> +static int __qcom_scm_set_dload_mode(struct device *dev, enum qcom_download_mode mode)
>>   {
>>   	struct qcom_scm_desc desc = {
>>   		.svc = QCOM_SCM_SVC_BOOT,
>> @@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>>   		.owner = ARM_SMCCC_OWNER_SIP,
>>   	};
>>   
>> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>> +	desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>>   
>>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>   }
>>   
>> -static void qcom_scm_set_download_mode(bool enable)
>> +static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
>>   {
>>   	bool avail;
>>   	int ret = 0;
>> @@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
>>   					     QCOM_SCM_SVC_BOOT,
>>   					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>   	if (avail) {
>> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>> +		ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
>>   	} else if (__scm->dload_mode_addr) {
>> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
>>   	} else {
>>   		dev_err(__scm->dev,
>>   			"No available mechanism for setting download mode\n");
>> @@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   	 * disabled below by a clean shutdown/reboot.
>>   	 */
>>   	if (download_mode)
>> -		qcom_scm_set_download_mode(true);
>> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
>>   
>>   	return 0;
>>   }
>> @@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
>>   {
>>   	/* Clean shutdown, disable download mode to allow normal restart */
>>   	if (download_mode)
> 
> PS. Wouldn't it make sense, if !download_mode to set NODUMP?

IMO, it does not need even a check, since our intention is to disable
download mode during reboot/restart.

-Mukesh
> 
> Regards,
> Bjorn
> 
>> -		qcom_scm_set_download_mode(false);
>> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>>   }
>>   
>>   static const struct of_device_id qcom_scm_dt_match[] = {
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index f833564..f9bc84e 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -14,6 +14,11 @@
>>   #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
>>   #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
>>   
>> +enum qcom_download_mode {
>> +	QCOM_DOWNLOAD_NODUMP    = 0x00,
>> +	QCOM_DOWNLOAD_FULLDUMP  = 0x10,
>> +};
>> +
>>   struct qcom_scm_hdcp_req {
>>   	u32 addr;
>>   	u32 val;
>> -- 
>> 2.7.4
>>
