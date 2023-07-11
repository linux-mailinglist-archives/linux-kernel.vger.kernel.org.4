Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240474E89A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGKIAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGKIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:00:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32F12F;
        Tue, 11 Jul 2023 01:00:37 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B7r69x016338;
        Tue, 11 Jul 2023 08:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PQbXdi5c+KowifPmhI2Iw3sqR/stFtZFRjjgGgL19h8=;
 b=WJctRqc3b7h6Kvu+DGDFlsj6UwaAJmPydShuzKVmHWvPDi3++L6qQ+4fhsEci0eDY9Lv
 YRVmX8Te+3KlWccncXyzxzETLVJ7uh/siRWCiOskP8jY5vrztkp2S7JqFOEYMEPwHirK
 MNrqurpUk/VZ7J4VsOnwPdHty63SR+As1bkGE5P+yb5LiPxY2hI/QQe/8myoyj5s72LY
 kSsFDr9CovBmZyaEoAgRots6CBLg3m6rD95fdzRenO4YJ6Z4tmwTMtgJRuHfMjVsjilp
 rvxIQ6lWim8xcKvsrHzjooHyIre4ukRYht2IaPqOhbE5pHfSGcFdCyVwGZmdEDvNbOzl DQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0vqr8gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:00:33 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B80XE5003419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:00:33 GMT
Received: from [10.201.162.56] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 01:00:28 -0700
Message-ID: <250d6776-5aca-67e9-ac4c-73d8d43b0592@quicinc.com>
Date:   Tue, 11 Jul 2023 13:30:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Vignesh Viswanathan <quic_viswanat@quicinc.com>
Subject: Re: [PATCH] remoteproc: qcom: Add NOTIFY_FATAL event type to SSR
 subdevice
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_sjaganat@quicinc.com>
References: <20230503062146.3891-1-quic_viswanat@quicinc.com>
 <f7a0c15d-a7d7-c2ed-875d-c8c24ebf0dab@quicinc.com>
 <cfe32c1c-6d9b-1c74-c7d1-6597591edf77@quicinc.com>
 <3687b420-0993-7f76-7116-114b1784de05@quicinc.com>
 <d6b07470-983b-fd50-6b88-239ab0607e39@quicinc.com>
Content-Language: en-US
In-Reply-To: <d6b07470-983b-fd50-6b88-239ab0607e39@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SUxL535dJFs4tYTA4S7Bp-CHf6wD_Rcm
X-Proofpoint-ORIG-GUID: SUxL535dJFs4tYTA4S7Bp-CHf6wD_Rcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110070
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 4:10 PM, Vignesh Viswanathan wrote:
> 
> 
> On 5/29/2023 9:27 AM, Vignesh Viswanathan wrote:
>> Gentle Reminder.
>>
>> On 5/22/2023 3:03 PM, Mukesh Ojha wrote:
>>>
>>>
>>> On 5/3/2023 4:56 PM, Mukesh Ojha wrote:
>>>>
>>>>
>>>> On 5/3/2023 11:51 AM, Vignesh Viswanathan wrote:
>>>>> Currently the SSR subdevice notifies the client driver on crash of the
>>>>> rproc from the recovery workqueue using the BEFORE_SHUTDOWN event.
>>>>> However the client driver might be interested to know that the device
>>>>> has crashed immediately to pause any further transactions with the
>>>>> rproc. This calls for an event to be sent to the driver in the IRQ
>>>>> context as soon as the rproc crashes.
>>>>>
>>>>> Add NOTIFY_FATAL event to SSR subdevice to atomically notify rproc has
>>>>> crashed to the client driver.
>>>>>
>>>>> Validated the event in IPQ9574 and IPQ5332 by forcing the rproc to 
>>>>> crash
>>>>> and ensuring the registered notifier function receives the 
>>>>> notification
>>>>> in IRQ context.
>>>>
>>>> This was one of valid use case we encounter in android, We have some 
>>>> other way of doing the same thing without core kernel change with
>>>> something called early notifiers.
>>>>
>>>> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/7583d24de337aa1bf7c375a7da706af9b995b9a1#a840754ebb0e24e88adbf48177e1abd0830b72d2
>>>>
>>>> https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/257de41c63a5a51a081cc7887cdaa4a46e4d1744
>>>>
>>>> But good to address this if possible.
>>>
>>> Ack the idea of early notifier;
>>> But here, atomic does not guarantees it to be atomic.
>>>
>>> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>
>>> -- Mukesh
>>>
> Gentle Reminder!
> 
> Thanks,
> Vignesh
> 

Gentle reminder for review!

Thanks,
Vignesh

>>>
>>>>
>>>> -Mukesh
>>>>>
>>>>> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>>>>> ---
>>>>>   drivers/remoteproc/qcom_common.c     | 60 
>>>>> +++++++++++++++++++++++++++
>>>>>   drivers/remoteproc/remoteproc_core.c  | 12 ++++++
>>>>>   include/linux/remoteproc.h            |  3 ++
>>>>>   include/linux/remoteproc/qcom_rproc.h | 17 ++++++++
>>>>>   4 files changed, 92 insertions(+)
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>>>> b/drivers/remoteproc/qcom_common.c
>>>>> index a0d4238492e9..76542229aeb6 100644
>>>>> --- a/drivers/remoteproc/qcom_common.c
>>>>> +++ b/drivers/remoteproc/qcom_common.c
>>>>> @@ -84,6 +84,7 @@ struct minidump_global_toc {
>>>>>   struct qcom_ssr_subsystem {
>>>>>       const char *name;
>>>>>       struct srcu_notifier_head notifier_list;
>>>>> +    struct atomic_notifier_head atomic_notifier_list;
>>>>>       struct list_head list;
>>>>>   };
>>>>> @@ -366,6 +367,7 @@ static struct qcom_ssr_subsystem 
>>>>> *qcom_ssr_get_subsys(const char *name)
>>>>>       }
>>>>>       info->name = kstrdup_const(name, GFP_KERNEL);
>>>>>       srcu_init_notifier_head(&info->notifier_list);
>>>>> +    ATOMIC_INIT_NOTIFIER_HEAD(&info->atomic_notifier_list);
>>>>>       /* Add to global notification list */
>>>>>       list_add_tail(&info->list, &qcom_ssr_subsystem_list);
>>>>> @@ -417,6 +419,51 @@ int qcom_unregister_ssr_notifier(void *notify, 
>>>>> struct notifier_block *nb)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(qcom_unregister_ssr_notifier);
>>>>> +/**
>>>>> + * qcom_register_ssr_atomic_notifier() - register SSR Atomic 
>>>>> notification
>>>>> + *                     handler
>>>>> + * @name:    Subsystem's SSR name
>>>>> + * @nb:    notifier_block to be invoked upon subsystem's state change
>>>>> + *
>>>>> + * This registers the @nb notifier block as part the atomic notifier
>>>>> + * chain for a remoteproc associated with @name. The notifier 
>>>>> block's callback
>>>>> + * will be invoked when the remote processor crashes in atomic 
>>>>> context before
>>>>> + * the recovery process is queued.
>>>>> + *
>>>>> + * Return: a subsystem cookie on success, ERR_PTR on failure.
>>>>> + */
>>>>> +void *qcom_register_ssr_atomic_notifier(const char *name,
>>>>> +                    struct notifier_block *nb)
>>>>> +{
>>>>> +    struct qcom_ssr_subsystem *info;
>>>>> +
>>>>> +    info = qcom_ssr_get_subsys(name);
>>>>> +    if (IS_ERR(info))
>>>>> +        return info;
>>>>> +
>>>>> +    atomic_notifier_chain_register(&info->atomic_notifier_list, nb);
>>>>> +
>>>>> +    return &info->atomic_notifier_list;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(qcom_register_ssr_atomic_notifier);
>>>>> +
>>>>> +/**
>>>>> + * qcom_unregister_ssr_atomic_notifier() - unregister SSR Atomic 
>>>>> notification
>>>>> + *                       handler
>>>>> + * @notify:    subsystem cookie returned from 
>>>>> qcom_register_ssr_notifier
>>>>> + * @nb:        notifier_block to unregister
>>>>> + *
>>>>> + * This function will unregister the notifier from the atomic 
>>>>> notifier
>>>>> + * chain.
>>>>> + *
>>>>> + * Return: 0 on success, %ENOENT otherwise.
>>>>> + */
>>>>> +int qcom_unregister_ssr_atomic_notifier(void *notify, struct 
>>>>> notifier_block *nb)
>>>>> +{
>>>>> +    return atomic_notifier_chain_unregister(notify, nb);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(qcom_unregister_ssr_atomic_notifier);
>>>>> +
>>>>>   static int ssr_notify_prepare(struct rproc_subdev *subdev)
>>>>>   {
>>>>>       struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
>>>>> @@ -467,6 +514,18 @@ static void ssr_notify_unprepare(struct 
>>>>> rproc_subdev *subdev)
>>>>>                    QCOM_SSR_AFTER_SHUTDOWN, &data);
>>>>>   }
>>>>> +static void ssr_notify_crash(struct rproc_subdev *subdev)
>>>>> +{
>>>>> +    struct qcom_rproc_ssr *ssr = to_ssr_subdev(subdev);
>>>>> +    struct qcom_ssr_notify_data data = {
>>>>> +        .name = ssr->info->name,
>>>>> +        .crashed = true,
>>>>> +    };
>>>>> +
>>>>> +    atomic_notifier_call_chain(&ssr->info->atomic_notifier_list,
>>>>> +                   QCOM_SSR_NOTIFY_CRASH, &data);
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * qcom_add_ssr_subdev() - register subdevice as restart 
>>>>> notification source
>>>>>    * @rproc:    rproc handle
>>>>> @@ -493,6 +552,7 @@ void qcom_add_ssr_subdev(struct rproc *rproc, 
>>>>> struct qcom_rproc_ssr *ssr,
>>>>>       ssr->subdev.start = ssr_notify_start;
>>>>>       ssr->subdev.stop = ssr_notify_stop;
>>>>>       ssr->subdev.unprepare = ssr_notify_unprepare;
>>>>> +    ssr->subdev.notify_crash = ssr_notify_crash;
>>>>>       rproc_add_subdev(rproc, &ssr->subdev);
>>>>>   }
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c 
>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>> index 695cce218e8c..3de0ece158ea 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -1139,6 +1139,16 @@ static void 
>>>>> rproc_unprepare_subdevices(struct rproc *rproc)
>>>>>       }
>>>>>   }
>>>>> +static void rproc_notify_crash_subdevices(struct rproc *rproc)
>>>>> +{
>>>>> +    struct rproc_subdev *subdev;
>>>>> +
>>>>> +    list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>>>>> +        if (subdev->notify_crash)
>>>>> +            subdev->notify_crash(subdev);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * rproc_alloc_registered_carveouts() - allocate all carveouts 
>>>>> registered
>>>>>    * in the list
>>>>> @@ -2687,6 +2697,8 @@ void rproc_report_crash(struct rproc *rproc, 
>>>>> enum rproc_crash_type type)
>>>>>       dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>>>>>           rproc->name, rproc_crash_to_string(type));
>>>>> +    rproc_notify_crash_subdevices(rproc);
>>>>> +
>>>>>       queue_work(rproc_recovery_wq, &rproc->crash_handler);
>>>>>   }
>>>>>   EXPORT_SYMBOL(rproc_report_crash);
>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>> index fe8978eb69f1..f3c0e0103e81 100644
>>>>> --- a/include/linux/remoteproc.h
>>>>> +++ b/include/linux/remoteproc.h
>>>>> @@ -596,6 +596,8 @@ struct rproc {
>>>>>    * @stop: stop function, called before the rproc is stopped; the 
>>>>> @crashed
>>>>>    *        parameter indicates if this originates from a recovery
>>>>>    * @unprepare: unprepare function, called after the rprochas 
>>>>> been stopped
>>>>> + * @notify_crash: notify_crash function, called in atomic context 
>>>>> to notify
>>>>> + *          rproc has crashed and recovery is about to start
>>>>>    */
>>>>>   struct rproc_subdev {
>>>>>       struct list_head node;
>>>>> @@ -604,6 +606,7 @@ struct rproc_subdev {
>>>>>       int (*start)(struct rproc_subdev *subdev);
>>>>>       void (*stop)(struct rproc_subdev *subdev, bool crashed);
>>>>>       void (*unprepare)(struct rproc_subdev *subdev);
>>>>> +    void (*notify_crash)(struct rproc_subdev *subdev);
>>>>>   };
>>>>>   /* we currently support only two vrings per rvdev */
>>>>> diff --git a/include/linux/remoteproc/qcom_rproc.h 
>>>>> b/include/linux/remoteproc/qcom_rproc.h
>>>>> index 82b211518136..f3d06900f297 100644
>>>>> --- a/include/linux/remoteproc/qcom_rproc.h
>>>>> +++ b/include/linux/remoteproc/qcom_rproc.h
>>>>> @@ -11,12 +11,14 @@ struct notifier_block;
>>>>>    * @QCOM_SSR_AFTER_POWERUP:    Remoteproc is running (start stage)
>>>>>    * @QCOM_SSR_BEFORE_SHUTDOWN:    Remoteproc crashed or shutting 
>>>>> down (stop stage)
>>>>>    * @QCOM_SSR_AFTER_SHUTDOWN:    Remoteprocis down (unprepare stage)
>>>>> + * @QCOM_SSR_NOTIFY_CRASH:    Remoteproc crashed
>>>>>    */
>>>>>   enum qcom_ssr_notify_type {
>>>>>       QCOM_SSR_BEFORE_POWERUP,
>>>>>       QCOM_SSR_AFTER_POWERUP,
>>>>>       QCOM_SSR_BEFORE_SHUTDOWN,
>>>>>       QCOM_SSR_AFTER_SHUTDOWN,
>>>>> +    QCOM_SSR_NOTIFY_CRASH,
>>>>>   };
>>>>>   struct qcom_ssr_notify_data {
>>>>> @@ -29,6 +31,10 @@ struct qcom_ssr_notify_data {
>>>>>   void *qcom_register_ssr_notifier(const char *name, struct 
>>>>> notifier_block *nb);
>>>>>   int qcom_unregister_ssr_notifier(void *notify, struct 
>>>>> notifier_block *nb);
>>>>> +void *qcom_register_ssr_atomic_notifier(const char *name,
>>>>> +                    struct notifier_block *nb);
>>>>> +int qcom_unregister_ssr_atomic_notifier(void *notify,
>>>>> +                    struct notifier_block *nb);
>>>>>   #else
>>>>>   static inline void *qcom_register_ssr_notifier(const char *name,
>>>>> @@ -43,6 +49,17 @@ static inline int 
>>>>> qcom_unregister_ssr_notifier(void *notify,
>>>>>       return 0;
>>>>>   }
>>>>> +static inline void *qcom_register_ssr_atomic_notifier(const char 
>>>>> *name,
>>>>> +                              struct notifier_block *nb)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static inline int qcom_unregister_ssr_atomic_notifier(void *notify,
>>>>> +                              struct notifier_block *nb)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>>   #endif
>>>>>   #endif
>>>>
