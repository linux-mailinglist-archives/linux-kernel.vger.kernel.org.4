Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFF61464D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKAJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKAJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:08:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36345FA9;
        Tue,  1 Nov 2022 02:08:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A18mEYp013330;
        Tue, 1 Nov 2022 09:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ilX9N7XuGwQznLnjFjp8fK0eTBudblM02vlzIqJN95A=;
 b=hMj+1R7cAjVKhn0NMhP1yCBZ5iOcRFDEauigzkzBKh86eSsyZcqCfxW1ENX68zX9ZVfw
 XGEqJqpIdUywy90B5jExcPlevZr6UgriedzswHtjDquEhoLURO1KQpJ1JI/ASVogByNg
 64+DgWD0Vu4xC1t2CTCplfEKfzl8OH9SDtP+BWQJnKl3vMET2bMlo3Kw8hA3l+hNOjSt
 D+wKzP76Kulj6Y82NM22IEYChbZHtGOlR299gystlzkHslq9lebcCjH3fCVly44JLbqy
 pLD8Yb/RLZ6IxBb6mK/La/+ZJrNqw1SqIRaN53P9iF9AjOwhJCNuEp97fpWStOlWk0qm 3g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kk093820p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 09:08:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A198RVZ029968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Nov 2022 09:08:27 GMT
Received: from [10.216.27.235] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 02:08:25 -0700
Message-ID: <722d3571-b399-dbf0-26da-04b73331df49@quicinc.com>
Date:   Tue, 1 Nov 2022 14:38:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] wifi: ath10k: Add WLAN firmware image version info into
 smem
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026102257.19919-1-quic_youghand@quicinc.com>
 <b55ef95f-f400-9ef6-a427-525ae529d673@quicinc.com>
 <fd45187c-739c-cd5d-4d4b-ae6abad03a94@quicinc.com>
 <877d0fgiaa.fsf@kernel.org>
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <877d0fgiaa.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zYRwwMhjNqmSmIewrws5MHNOaUx2h2wY
X-Proofpoint-ORIG-GUID: zYRwwMhjNqmSmIewrws5MHNOaUx2h2wY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_05,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2022 2:31 PM, Kalle Valo wrote:
> (fixing quotation)
>
> "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com> writes:
>
>> On 10/28/2022 12:19 AM, Jeff Johnson wrote:
>>
>>> On 10/26/2022 3:22 AM, Youghandhar Chintala wrote:
>>>>    +static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, char
>>>> *fw_build_id)
>>> const char *fw_build_id?
>>>
>>>> +{
>>>> +    u8 *smem_table_ptr;
>>>> +    size_t smem_block_size;
>>>> +    const u32 version_string_size = 128;
>>> should you s/128/MAX_BUILD_ID_LEN/ since that is what is used to
>>> size qmi->fw_build_id?
>>>
>>> or alternately have the caller pass fw_build_id length as a separate
>>> param?
>> Sure Jeff. Will address it in next version of patch.
> BTW Youghandhar, your quotes were broken in this mail so your reply was
> difficult to find. See here:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20221026102257.19919-1-quic_youghand@quicinc.com/
>
> If you are using Outlook, I recommend switching to an application which
> respects standards more :) For example, some people seem to be happy
> with Thunderbird.


Thank you so much for your suggestion. I will address it.

Currently I am using  Thunderbird.

