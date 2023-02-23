Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53466A1395
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjBWXNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWXNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:13:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB6234D3;
        Thu, 23 Feb 2023 15:13:37 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NMmMS8032137;
        Thu, 23 Feb 2023 23:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zpwN53LM2dkZyG0/s3KuwKkrMrPixKOghZlenMmKrlg=;
 b=j8Dg0aRhJc07FdrPVqvcjFvAUzuXXz1eX+IWcJP2lC6ggoARjjLaiCOfnKM3pdQTUDbQ
 dFH7nzmRBpq4t68bBJbFFMu8FvGq2SzPRyhYcdc4edmHzFVsqXNJ7gxEsfnwj9YVBwCz
 IIB9KwpEdX+ULTMFA+v7q2alTWXEWaN3o3PibKxHOdHNL7tEWtjr49WkdoyFNo0bIUD6
 5vN8+8tq/npgsAn6p44lNHCZv5wxw+KwKmNPaDW3JTr6cDBwYIpSzw8OLagN1/V+I/lQ
 cz7o+NRxrP4OxqcUHex/0QYSQjWnkVryCB5b+ZJN9Brp6Enmr1LVXt42WEZQKjaOTMMr lw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwyc5jx9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:13:22 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NNDL06013275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 23:13:21 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Feb
 2023 15:13:20 -0800
Message-ID: <cd61963d-eb4c-9a4f-d48f-7a633bfd4be3@quicinc.com>
Date:   Thu, 23 Feb 2023 15:13:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
 <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
 <44a59ea4-da6e-e96a-5e89-dfd41db72823@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <44a59ea4-da6e-e96a-5e89-dfd41db72823@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -izvg1txNj7hY26iLrmzHV-Ay6Er-7gz
X-Proofpoint-GUID: -izvg1txNj7hY26iLrmzHV-Ay6Er-7gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230193
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 2:29 AM, Srinivas Kandagatla wrote:
> 
> 
> On 22/02/2023 23:18, Elliot Berman wrote:
>>>>
>>>> +EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>>>> +
>>>> +void get_gh_rm(struct gh_rm *rm)
>>>> +{
>>>> +    get_device(rm->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(get_gh_rm);
>>>
>>> Can we have some consistency in the exported symbol naming,
>>> we have two combinations now.
>>>
>>> EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
>>> EXPORT_SYMBOL_GPL(get_gh_rm);
>>>
>>> lets stick to one.
>>
>> done.
>>
>>>> +
>>>> +void put_gh_rm(struct gh_rm *rm)
>>>> +{
>>>> +    put_device(rm->dev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(put_gh_rm);
>>>>
>>> ...
>>>
>>>> +
>>>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct gh_msgq_tx_data *msg;
>>>> +    struct gh_rm *rm;
>>>> +    int ret;
>>>> +
>>> How are we ensuring that gunyah driver is probed before this driver?
>>>
>>>
>>
>> Which driver?
> 
> Am referring to gunyah.ko
> 
> TBH, gunyah.c should be merged as part of resource manager, and check if 
> uuids and features in probe before proceeding further.
> 


Ah -- gunyah_rsc_mgr.ko has symbol dependency on gunyah-msgq.ko. 
gunyah-msgq.ko has symbol dependency on gunyah.ko. gunyah.ko doesn't 
have any probe and does all its work on module_init.

In order to merge gunyah.c with resource manager, I would need to 
incorporate message queue mailbox into resource manager. IMO, this 
rapidly moves towards a mega-module which was discouraged previously.

Thanks,
Elliot
