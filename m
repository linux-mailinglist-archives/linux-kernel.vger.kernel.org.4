Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493AE68A44E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjBCVKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBCVKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:10:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5045F6E83;
        Fri,  3 Feb 2023 13:10:51 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313IVb8N010686;
        Fri, 3 Feb 2023 21:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZwBcmTdvENe/UCzaX+/lYMOvHHhx3Ba8Mp4hnf162Yg=;
 b=ADvu6N3t7pbnKvo4/yIoCghYnY413jFeo+LM3T4o/Zu2AItsR/19zWP7rNLJud6C1/mZ
 nbqyvtCgLFQqau0a/LiknfY1fiawSYCqGJywm75HQMrlVxWz6zSXwEMy0kG54ToEILXM
 /E/qPPquPNqdl1zl2IPoYadD3nDcxiKMYU0oetNdYg09r/lSN/Ki8cJYgzLiBxKWuClc
 ovbGXGkTp4YvFmU+qDQL4wmWJDZiBfjgGxRVr28m2UIWHUjLSMXj5y3+SJW+2JJUZpMa
 VhO/8MfzAJ1yVarqMY9FnS6VGh47gb9LtqT45sYXK1UgApBOxQXdUfHlZLMkySCvUxXV BQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngns2jhaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 21:10:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313LAmYE007497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 21:10:48 GMT
Received: from [10.110.30.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 13:10:47 -0800
Message-ID: <66daf24a-0d72-b96d-aaf1-4f0e78e9cf33@quicinc.com>
Date:   Fri, 3 Feb 2023 13:10:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/qcom* to ARM/QUALCOMM
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230203183115.2836316-1-quic_eberman@quicinc.com>
 <20230203192718.eyuvmi7kniwulv63@ripper>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230203192718.eyuvmi7kniwulv63@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TEEKdEaiQwe76JdWwdB51kvJ7tBRN5kB
X-Proofpoint-ORIG-GUID: TEEKdEaiQwe76JdWwdB51kvJ7tBRN5kB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_19,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=861 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030190
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 11:27 AM, Bjorn Andersson wrote:
> On Fri, Feb 03, 2023 at 10:31:14AM -0800, Elliot Berman wrote:
>> ARM/QUALCOMM support currently includes include/linux/*/qcom* but is
>> missing a few Qualcomm headers directly in include/linux/.
>>
>> This effectively adds following headers directly under ARM/QUALCOMM.
>>   - include/linux/qcom-geni-se.h
>>   - include/linux/qcom_scm.h
>>
> 
> Seems odd to have these lone files here...
> 
> Would you be willing to push these two files into
> include/linux/firmware/qcom/ and include/linux/soc/qcom/ instead?
> 

Sure, this is also good approach to me.

qcom-geni-se.h: 
https://lore.kernel.org/all/20230203210133.3552796-1-quic_eberman@quicinc.com/

qcom_scm.h: 
https://lore.kernel.org/all/20230203210956.3580811-1-quic_eberman@quicinc.com/

Thanks,
Elliot
