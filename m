Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE796194D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiKDKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiKDKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:50:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965992B272;
        Fri,  4 Nov 2022 03:50:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A4AOC3j013740;
        Fri, 4 Nov 2022 10:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A9giptHeWqvr+ADTpesZYe1XkQ6LUW6iP/WTxkN+epo=;
 b=EALXttxRlgQ2YaNw73CqA+RdkEDfOWHG0Q31evrdFdGQaGlRF4GrsAdC+UQiHwymdPjM
 jFtDsiltl1qYs8SruyiBrZbqjEEgYLiCxd/BtWviEoRcS4i0P50Gestzrd5m0GCYvq/Y
 MI0E/NHZt0kZS4ls74MYjb/tnbwygZEC4r0R8+lpagAYMpCVBfkXQKAdxU+EnoO85jLQ
 dlGvuZPimUzD0YCCOqw8MqD6A/fi3SorXcyEVA4YI6fz0xiAO+lRnkkDpKkyD1kNdkaM
 nfv/pPrFYsyJKEs9ps6ClbB1CAC5Mxw+tpJO6TxliLjb7AFiq+wKw9NKsBbMOtIJ8/oi 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmvgk8m87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 10:50:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A4AohMu000518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 10:50:43 GMT
Received: from [10.206.64.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 03:50:41 -0700
Message-ID: <eb549cdc-01ef-2f9b-719c-3c2857e43313@quicinc.com>
Date:   Fri, 4 Nov 2022 16:20:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] wifi: ath11k: Trigger sta disconnect on hardware
 restart
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20221104085403.11025-1-quic_youghand@quicinc.com>
 <166755883456.9892.7557940279708188243.kvalo@kernel.org>
Content-Language: en-US
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <166755883456.9892.7557940279708188243.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6YEEfO5i_0bg_y_rdCcZG6yrRNg9Ft6S
X-Proofpoint-GUID: 6YEEfO5i_0bg_y_rdCcZG6yrRNg9Ft6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_07,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/4/2022 4:17 PM, Kalle Valo wrote:
> Youghandhar Chintala <quic_youghand@quicinc.com> wrote:
>
>> Currently after the hardware restart triggered from the driver, the
>> station interface connection remains intact, since a disconnect trigger
>> is not sent to userspace. This can lead to a problem in targets where
>> the wifi mac sequence is added by the firmware.
>>
>> After the target restart, its wifi mac sequence number gets reset to
>> zero. Hence AP to which our device is connected will receive frames with
>> a  wifi mac sequence number jump to the past, thereby resulting in the
>> AP dropping all these frames, until the frame arrives with a wifi mac
>> sequence number which AP was expecting.
>>
>> To avoid such frame drops, its better to trigger a station disconnect
>> upon target hardware restart which can be done with API
>> ieee80211_reconfig_disconnect exposed to mac80211.
>>
>> The other targets are not affected by this change, since the hardware
>> params flag is not set.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>
>> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> This had a new warning:
>
> drivers/net/wireless/ath/ath11k/mac.c:8056: Blank lines aren't necessary before a close brace '}'
>
> I fixed it in the pending branch.

Thank you Kalle.

Regards,

Youghandhar

