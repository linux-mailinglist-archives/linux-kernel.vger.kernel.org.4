Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1869FF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjBVXS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBVXSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:18:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7CD1B314;
        Wed, 22 Feb 2023 15:18:49 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MN2PxC032018;
        Wed, 22 Feb 2023 23:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kLp6Y2SwLfvdNEEx+KlRLVuK23xsbKShI7drVCOpPjI=;
 b=KeVcOukVog1gQWIjT6mo5/eAqjncIqPognZua9aNyC1dt3P+6ZmmwDvQSET1gGoOqlBv
 4HfvL9qy3dp1aPv0LoH9XJwodaEBhNILs/mQCDwg+pH45zwdQVbPjWXh0NvJVgDjk7J8
 iKe1QvaTzkm2qW43MI14NYqU4963JRj889SO3jySoIR5CdjyUsoWB3bgMXN0uqF8IGd3
 IztXcDoNIWe6aZ2j/1f1cGaAvhTe4SmqRrSixmprC8loLCYK817LCrcJhqds6LiCBYvC
 xkxIHwax8eWOeW5SmDhGOyR1floA7p25Fu1pxibhYn8l/04CF5OP2fJNlph7vG0RC8eF tA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwn389778-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 23:18:34 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31MNIXHa007425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 23:18:33 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Feb
 2023 15:18:33 -0800
Message-ID: <94ebe2f0-0baf-21c0-45d5-c5bc4df9ad94@quicinc.com>
Date:   Wed, 22 Feb 2023 15:18:32 -0800
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
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: epDXlmXZriZeLsP3EnT4PS9K2nrF5jdU
X-Proofpoint-ORIG-GUID: epDXlmXZriZeLsP3EnT4PS9K2nrF5jdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220201
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2023 10:10 AM, Srinivas Kandagatla wrote:
> 
> 
> On 14/02/2023 21:23, Elliot Berman wrote:
>>
>> The resource manager is a special virtual machine which is always
>> running on a Gunyah system. It provides APIs for creating and destroying
>> VMs, secure memory management, sharing/lending of memory between VMs,
>> and setup of inter-VM communication. Calls to the resource manager are
>> made via message queues.
>>
>> This patch implements the basic probing and RPC mechanism to make those
>> API calls. Request/response calls can be made with gh_rm_call.
>> Drivers can also register to notifications pushed by RM via
>> gh_rm_register_notifier
>>
>> Specific API calls that resource manager supports will be implemented in
>> subsequent patches.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile   |   3 +
>>   drivers/virt/gunyah/rsc_mgr.c  | 604 +++++++++++++++++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h  |  77 +++++
>>   include/linux/gunyah_rsc_mgr.h |  24 ++
>>   4 files changed, 708 insertions(+)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>>
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 34f32110faf9..cc864ff5abbb 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1,3 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +
>> +gunyah_rsc_mgr-y += rsc_mgr.o
>> +obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c 
>> b/drivers/virt/gunyah/rsc_mgr.c
>> new file mode 100644
>> index 000000000000..2a47139873a8
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -0,0 +1,604 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sched.h>
>> +#include <linux/gunyah.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/kthread.h>
> why do we need this?
> 
>> +#include <linux/notifier.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/completion.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "rsc_mgr.h"
>> +
> 
> ...
> 
>> +struct gh_rm {
>> +    struct device *dev;
>> +    struct gunyah_resource tx_ghrsc, rx_ghrsc;
>> +    struct gh_msgq msgq;
>> +    struct mbox_client msgq_client;
>> +    struct gh_rm_connection *active_rx_connection;
>> +    int last_tx_ret;
>> +
> 
>> +    struct idr call_idr;
>> +    struct mutex call_idr_lock;
> 
> IDR interface is deprecated you should use Xarrays instead here,
> 
> Other good thing about Xarrays is that you need not worry about locking 
> it uses RCU and internal spinlock, that should simiply code a bit here.
> 
> more info at
> Documentation/core-api/xarray.rst
> 

Done.

>> +
>> +    struct kmem_cache *cache;
>> +    struct mutex send_lock;
>> +    struct blocking_notifier_head nh;
>> +};
>> +
>> +static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, 
>> u8 type)
>> +{
>> +    struct gh_rm_connection *connection;
>> +
>> +    connection = kzalloc(sizeof(*connection), GFP_KERNEL);
>> +    if (!connection)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    connection->type = type;
>> +    connection->msg_id = msg_id;
>> +
>> +    return connection;
>> +}
>> +
>> +static int gh_rm_init_connection_payload(struct gh_rm_connection 
>> *connection, void *msg,
>> +                    size_t hdr_size, size_t msg_size)
>> +{
>> +    size_t max_buf_size, payload_size;
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +
>> +    if (hdr_size > msg_size)
>> +        return -EINVAL;
>> +
>> +    payload_size = msg_size - hdr_size;
>> +
>> +    connection->num_fragments = FIELD_GET(RM_RPC_FRAGMENTS_MASK, 
>> hdr->type);
>> +    connection->fragments_received = 0;
>> +
>> +    /* There's not going to be any payload, no need to allocate 
>> buffer. */
>> +    if (!payload_size && !connection->num_fragments)
>> +        return 0;
>> +
>> +    if (connection->num_fragments > GH_RM_MAX_NUM_FRAGMENTS)
>> +        return -EINVAL;
>> +
>> +    max_buf_size = payload_size + (connection->num_fragments * 
>> GH_RM_MAX_MSG_SIZE);
>> +
>> +    connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
>> +    if (!connection->payload)
>> +        return -ENOMEM;
>> +
>> +    memcpy(connection->payload, msg + hdr_size, payload_size);
>> +    connection->size = payload_size;
>> +    return 0;
>> +}
>> +
>> +static void gh_rm_notif_work(struct work_struct *work)
>> +{
>> +    struct gh_rm_connection *connection = container_of(work, struct 
>> gh_rm_connection,
>> +                                notification.work);
>> +    struct gh_rm *rm = connection->notification.rm;
>> +
>> +    blocking_notifier_call_chain(&rm->nh, connection->msg_id, 
>> connection->payload);
>> +
>> +    put_gh_rm(rm);
>> +    kfree(connection->payload);
> if (connection->size)
>      kfree(connection->payload);
> 
> should we check for payload size before freeing this, Normally kfree 
> NULL should be safe, unless connection object is allocated uninitialized.
> 

connection object is kzalloc'd, so it's always allocated initialized.

>> +    kfree(connection);
>> +}
>> +
>> +static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm *rm, 
>> void *msg, size_t msg_size)
>> +{
>> +    struct gh_rm_connection *connection;
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +    int ret;
>> +
>> +    connection = gh_rm_alloc_connection(hdr->msg_id, RM_RPC_TYPE_NOTIF);
>> +    if (IS_ERR(connection)) {
>> +        dev_err(rm->dev, "Failed to alloc connection for 
>> notification: %ld, dropping.\n",
>> +            PTR_ERR(connection));
>> +        return NULL;
>> +    }
>> +
>> +    get_gh_rm(rm);
>> +    connection->notification.rm = rm;
>> +    INIT_WORK(&connection->notification.work, gh_rm_notif_work);
>> +
>> +    ret = gh_rm_init_connection_payload(connection, msg, 
>> sizeof(*hdr), msg_size);
>> +    if (ret) {
>> +        dev_err(rm->dev, "Failed to initialize connection buffer for 
>> notification: %d\n",
>> +            ret);
> put_gh_rm(rm);
> 
> is missing.
> or move the get and other lines after this check
> 

Done.

>> +        kfree(connection);
>> +        return NULL;
>> +    }
>> +
>> +    return connection;
>> +}
>> +
> 
>> +static int gh_rm_send_request(struct gh_rm *rm, u32 message_id,
>> +                  const void *req_buff, size_t req_buff_size,
>> +                  struct gh_rm_connection *connection)
>> +{
>> +    u8 msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_REQUEST);
>> +    size_t buff_size_remaining = req_buff_size;
>> +    const void *req_buff_curr = req_buff;
>> +    struct gh_msgq_tx_data *msg;
>> +    struct gh_rm_rpc_hdr *hdr;
>> +    u32 cont_fragments = 0;
>> +    size_t payload_size;
>> +    void *payload;
>> +    int ret;
>> +
>> +    if (req_buff_size)
>> +        cont_fragments = (req_buff_size - 1) / GH_RM_MAX_MSG_SIZE;
>> +
>> +    if (req_buff_size > GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE) {
>> +        pr_warn("Limit exceeded for the number of fragments: %u\n", 
>> cont_fragments);
>> +        dump_stack();
>> +        return -E2BIG;
>> +    }
>> +
>> +    ret = mutex_lock_interruptible(&rm->send_lock);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Consider also the 'request' packet for the loop count */
>> +    do {
>> +        msg = kmem_cache_zalloc(rm->cache, GFP_KERNEL);
>> +        if (!msg) {
>> +            ret = -ENOMEM;
>> +            goto out;
>> +        }
>> +
>> +        /* Fill header */
>> +        hdr = (struct gh_rm_rpc_hdr *)msg->data;
>> +        hdr->api = RM_RPC_API;
>> +        hdr->type = msg_type | FIELD_PREP(RM_RPC_FRAGMENTS_MASK, 
>> cont_fragments);
>> +        hdr->seq = cpu_to_le16(connection->reply.seq);
>> +        hdr->msg_id = cpu_to_le32(message_id);
>> +
>> +        /* Copy payload */
>> +        payload = hdr + 1;
>> +        payload_size = min(buff_size_remaining, GH_RM_MAX_MSG_SIZE);
>> +        memcpy(payload, req_buff_curr, payload_size);
>> +        req_buff_curr += payload_size;
>> +        buff_size_remaining -= payload_size;
>> +
>> +        /* Force the last fragment to immediately alert the receiver */
>> +        msg->push = !buff_size_remaining;
>> +        msg->length = sizeof(*hdr) + payload_size;
>> +
>> +        ret = mbox_send_message(gh_msgq_chan(&rm->msgq), msg);
>> +        if (ret < 0) {
>> +            kmem_cache_free(rm->cache, msg);
>> +            break;
>> +        }
>> +
>> +        if (rm->last_tx_ret) {
>> +            ret = rm->last_tx_ret;
>> +            break;
>> +        }
>> +
>> +        msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, 
>> RM_RPC_TYPE_CONTINUATION);
>> +    } while (buff_size_remaining);
>> +
>> +out:
>> +    mutex_unlock(&rm->send_lock);
>> +    return ret < 0 ? ret : 0;
>> +}
>> +
>> +/**
>> + * gh_rm_call: Achieve request-response type communication with RPC
>> + * @rm: Pointer to Gunyah resource manager internal data
>> + * @message_id: The RM RPC message-id
>> + * @req_buff: Request buffer that contains the payload
>> + * @req_buff_size: Total size of the payload
>> + * @resp_buf: Pointer to a response buffer
>> + * @resp_buff_size: Size of the response buffer
>> + *
>> + * Make a request to the RM-VM and wait for reply back. For a successful
>> + * response, the function returns the payload. The size of the 
>> payload is set in
>> + * resp_buff_size. The resp_buf should be freed by the caller.
>> + *
>> + * req_buff should be not NULL for req_buff_size >0. If req_buff_size 
>> == 0,
>> + * req_buff *can* be NULL and no additional payload is sent.
>> + *
>> + * Context: Process context. Will sleep waiting for reply.
>> + * Return: 0 on success. <0 if error.
>> + */
>> +int gh_rm_call(struct gh_rm *rm, u32 message_id, void *req_buff, 
>> size_t req_buff_size,
>> +        void **resp_buf, size_t *resp_buff_size)
>> +{
>> +    struct gh_rm_connection *connection;
>> +    int ret;
>> +
>> +    /* message_id 0 is reserved. req_buff_size implies req_buf is not 
>> NULL */
>> +    if (!message_id || (!req_buff && req_buff_size) || !rm)
>> +        return -EINVAL;
>> +
>> +    connection = gh_rm_alloc_connection(cpu_to_le32(message_id), 
>> RM_RPC_TYPE_REPLY);
>> +    if (IS_ERR(connection))
>> +        return PTR_ERR(connection);
>> +
>> +    init_completion(&connection->reply.seq_done);
>> +
>> +    /* Allocate a new seq number for this connection */
>> +    mutex_lock(&rm->call_idr_lock);
>> +    ret = idr_alloc_cyclic(&rm->call_idr, connection, 0, U16_MAX,
>> +                        GFP_KERNEL);
>> +    mutex_unlock(&rm->call_idr_lock);
>> +    if (ret < 0)
>> +        goto out;
> 
> new line.
> 
>> +    connection->reply.seq = ret;
>> +
>> +    /* Send the request to the Resource Manager */
>> +    ret = gh_rm_send_request(rm, message_id, req_buff, req_buff_size, 
>> connection);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    /* Wait for response */
>> +    ret = 
>> wait_for_completion_interruptible(&connection->reply.seq_done);
>> +    if (ret)
>> +        goto out;
>> +
>> +    /* Check for internal (kernel) error waiting for the response */
>> +    if (connection->reply.ret) {
>> +        ret = connection->reply.ret;
>> +        if (ret != -ENOMEM)
>> +            kfree(connection->payload);
>> +        goto out;
>> +    }
>> +
>> +    /* Got a response, did resource manager give us an error? */
>> +    if (connection->reply.rm_error != GH_RM_ERROR_OK) {
>> +        pr_warn("RM rejected message %08x. Error: %d\n", message_id,
>> +            connection->reply.rm_error);
>> +        dump_stack();
>> +        ret = gh_rm_remap_error(connection->reply.rm_error);
>> +        kfree(connection->payload);
>> +        goto out;
>> +    }
>> +
>> +    /* Everything looks good, return the payload */
>> +    *resp_buff_size = connection->size;
>> +    if (connection->size)
>> +        *resp_buf = connection->payload;
>> +    else {
>> +        /* kfree in case RM sent us multiple fragments but never any 
>> data in
>> +         * those fragments. We would've allocated memory for it, but 
>> connection->size == 0
>> +         */
>> +        kfree(connection->payload);
>> +    }
>> +
>> +out:
>> +    mutex_lock(&rm->call_idr_lock);
>> +    idr_remove(&rm->call_idr, connection->reply.seq);
>> +    mutex_unlock(&rm->call_idr_lock);
>> +    kfree(connection);
>> +    return ret;
>> +}
>> +
>> +
>> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb)
>> +{
>> +    return blocking_notifier_chain_register(&rm->nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
>> +
>> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block 
>> *nb)
>> +{
>> +    return blocking_notifier_chain_unregister(&rm->nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>> +
>> +void get_gh_rm(struct gh_rm *rm)
>> +{
>> +    get_device(rm->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(get_gh_rm);
> 
> Can we have some consistency in the exported symbol naming,
> we have two combinations now.
> 
> EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
> EXPORT_SYMBOL_GPL(get_gh_rm);
> 
> lets stick to one.

done.

>> +
>> +void put_gh_rm(struct gh_rm *rm)
>> +{
>> +    put_device(rm->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(put_gh_rm);
>>
> ...
> 
>> +
>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>> +{
>> +    struct gh_msgq_tx_data *msg;
>> +    struct gh_rm *rm;
>> +    int ret;
>> +
> How are we ensuring that gunyah driver is probed before this driver?
> 
> 

Which driver?

>> +    rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
>> +    if (!rm)
>> +        return -ENOMEM;
>> +
>> +    platform_set_drvdata(pdev, rm);
>> +    rm->dev = &pdev->dev;
>> +
>> +    mutex_init(&rm->call_idr_lock);
>> +    idr_init(&rm->call_idr);
>> +    rm->cache = kmem_cache_create("gh_rm", struct_size(msg, data, 
>> GH_MSGQ_MAX_MSG_SIZE), 0,
>> +        SLAB_HWCACHE_ALIGN, NULL);
>> +    if (!rm->cache)
>> +        return -ENOMEM;
> new line here would be nice.
> 

done.

>> +    mutex_init(&rm->send_lock);
>> +    BLOCKING_INIT_NOTIFIER_HEAD(&rm->nh);
>> +
>> +    ret = gh_msgq_platform_probe_direction(pdev, true, 0, 
>> &rm->tx_ghrsc);
>> +    if (ret)
>> +        goto err_cache;
>> +
>> +    ret = gh_msgq_platform_probe_direction(pdev, false, 1, 
>> &rm->rx_ghrsc);
>> +    if (ret)
>> +        goto err_cache;
>> +
>> +    rm->msgq_client.dev = &pdev->dev;
>> +    rm->msgq_client.tx_block = true;
>> +    rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>> +    rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
>> +
>> +    return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, 
>> &rm->tx_ghrsc, &rm->rx_ghrsc);
>> +err_cache:
>> +    kmem_cache_destroy(rm->cache);
>> +    return ret;
>> +}
>> +
>> +static int gh_rm_drv_remove(struct platform_device *pdev)
>> +{
>> +    struct gh_rm *rm = platform_get_drvdata(pdev);
>> +
>> +    mbox_free_channel(gh_msgq_chan(&rm->msgq));
>> +    gh_msgq_remove(&rm->msgq);
>> +    kmem_cache_destroy(rm->cache);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id gh_rm_of_match[] = {
>> +    { .compatible = "gunyah-resource-manager" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, gh_rm_of_match);
>> +
>> +static struct platform_driver gh_rm_driver = {
>> +    .probe = gh_rm_drv_probe,
>> +    .remove = gh_rm_drv_remove,
>> +    .driver = {
>> +        .name = "gh_rsc_mgr",
>> +        .of_match_table = gh_rm_of_match,
>> +    },
>> +};
>> +module_platform_driver(gh_rm_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
>> diff --git a/drivers/virt/gunyah/rsc_mgr.h 
>> b/drivers/virt/gunyah/rsc_mgr.h
>> new file mode 100644
>> index 000000000000..d4e799a7526f
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.h
>> @@ -0,0 +1,77 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +#ifndef __GH_RSC_MGR_PRIV_H
>> +#define __GH_RSC_MGR_PRIV_H
>> +
>> +#include <linux/gunyah.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/types.h>
>> +
> <------------------
>> +/* RM Error codes */
>> +enum gh_rm_error {
>> +    GH_RM_ERROR_OK            = 0x0,
>> +    GH_RM_ERROR_UNIMPLEMENTED    = 0xFFFFFFFF,
>> +    GH_RM_ERROR_NOMEM        = 0x1,
>> +    GH_RM_ERROR_NORESOURCE        = 0x2,
>> +    GH_RM_ERROR_DENIED        = 0x3,
>> +    GH_RM_ERROR_INVALID        = 0x4,
>> +    GH_RM_ERROR_BUSY        = 0x5,
>> +    GH_RM_ERROR_ARGUMENT_INVALID    = 0x6,
>> +    GH_RM_ERROR_HANDLE_INVALID    = 0x7,
>> +    GH_RM_ERROR_VALIDATE_FAILED    = 0x8,
>> +    GH_RM_ERROR_MAP_FAILED        = 0x9,
>> +    GH_RM_ERROR_MEM_INVALID        = 0xA,
>> +    GH_RM_ERROR_MEM_INUSE        = 0xB,
>> +    GH_RM_ERROR_MEM_RELEASED    = 0xC,
>> +    GH_RM_ERROR_VMID_INVALID    = 0xD,
>> +    GH_RM_ERROR_LOOKUP_FAILED    = 0xE,
>> +    GH_RM_ERROR_IRQ_INVALID        = 0xF,
>> +    GH_RM_ERROR_IRQ_INUSE        = 0x10,
>> +    GH_RM_ERROR_IRQ_RELEASED    = 0x11,
>> +};
>> +
>> +/**
>> + * gh_rm_remap_error() - Remap Gunyah resource manager errors into a 
>> Linux error code
>> + * @gh_error: "Standard" return value from Gunyah resource manager
>> + */
>> +static inline int gh_rm_remap_error(enum gh_rm_error rm_error)
>> +{
>> +    switch (rm_error) {
>> +    case GH_RM_ERROR_OK:
>> +        return 0;
>> +    case GH_RM_ERROR_UNIMPLEMENTED:
>> +        return -EOPNOTSUPP;
>> +    case GH_RM_ERROR_NOMEM:
>> +        return -ENOMEM;
>> +    case GH_RM_ERROR_NORESOURCE:
>> +        return -ENODEV;
>> +    case GH_RM_ERROR_DENIED:
>> +        return -EPERM;
>> +    case GH_RM_ERROR_BUSY:
>> +        return -EBUSY;
>> +    case GH_RM_ERROR_INVALID:
>> +    case GH_RM_ERROR_ARGUMENT_INVALID:
>> +    case GH_RM_ERROR_HANDLE_INVALID:
>> +    case GH_RM_ERROR_VALIDATE_FAILED:
>> +    case GH_RM_ERROR_MAP_FAILED:
>> +    case GH_RM_ERROR_MEM_INVALID:
>> +    case GH_RM_ERROR_MEM_INUSE:
>> +    case GH_RM_ERROR_MEM_RELEASED:
>> +    case GH_RM_ERROR_VMID_INVALID:
>> +    case GH_RM_ERROR_LOOKUP_FAILED:
>> +    case GH_RM_ERROR_IRQ_INVALID:
>> +    case GH_RM_ERROR_IRQ_INUSE:
>> +    case GH_RM_ERROR_IRQ_RELEASED:
>> +        return -EINVAL;
>> +    default:
>> +        return -EBADMSG;
>> +    }
>> +}
>> +
> ---------------->
> 
> Only user for the error code coversion is within the rm driver, you 
> should just move this to the .c file, I see no value of this in .h 
> unless there are some other users for this.
> 
> 

Done.

> 
>> +struct gh_rm;
>> +int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, 
>> size_t req_buff_size,
>> +        void **resp_buf, size_t *resp_buff_size);
>> +
>> +#endif
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> new file mode 100644
>> index 000000000000..c992b3188c8d
>> --- /dev/null
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _GUNYAH_RSC_MGR_H
>> +#define _GUNYAH_RSC_MGR_H
>> +
>> +#include <linux/list.h>
>> +#include <linux/notifier.h>
>> +#include <linux/gunyah.h>
>> +
>> +#define GH_VMID_INVAL    U16_MAX
>> +
>> +/* Gunyah recognizes VMID0 as an alias to the current VM's ID */
>> +#define GH_VMID_SELF            0
>> +
>> +struct gh_rm;
>> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block 
>> *nb);
>> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block 
>> *nb);
>> +void get_gh_rm(struct gh_rm *rm);
>> +void put_gh_rm(struct gh_rm *rm);
>> +
>> +#endif
