Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B716A2468
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBXWkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBXWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:40:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755246F424;
        Fri, 24 Feb 2023 14:40:02 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OFZaCr015746;
        Fri, 24 Feb 2023 22:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Aa6PSvz5BZk1EStzRiqlmzYuoCdHzQ0e/pseI0xLwrc=;
 b=eYS0+Gcy9rjHPabSaRz5Yc+Wf6gahJnBvN2zl467y/Xj89G7T/7Y/oTn1DGYJ0T8LZLt
 k/v92VdyEip+hZcSC1gRQBXbC889RJe2pAkfpUyZHM8dHO9q+nZqmLV4HnCvvRD7apJH
 I58ZKzCiALGhKTdr29kYZj4QkRHpQWLXmj6A7iJI8wj8ljl9eB5Wj/XoEipmXnrpJLNM
 u2+wdBBecuAxmeJEXXyzrukvrOelytFhyUNDw0gu6PD01oygIHPnWpJvkNDo1GcqJUtu
 yIJe0tiPSnao/pkCPK5mRr5N8MP/Ee99rfVeKOj/AF1If+DAdtt5wdJVqFM50WsRX8di Kw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwybwp285-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:39:40 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OMdYjI010164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 22:39:34 GMT
Received: from [10.110.9.108] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 14:39:33 -0800
Message-ID: <2fe3993a-b3b1-119d-e335-56979d6ecd99@quicinc.com>
Date:   Fri, 24 Feb 2023 14:39:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Alex Elder <alex.elder@linaro.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
 <9c56e16e-ecd0-2ef4-14d8-476029458359@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <9c56e16e-ecd0-2ef4-14d8-476029458359@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CKgDjhI-4ZSijQj4g5jO2634-VPPGT9M
X-Proofpoint-ORIG-GUID: CKgDjhI-4ZSijQj4g5jO2634-VPPGT9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302240182
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/2023 3:28 PM, Alex Elder wrote:
> On 2/14/23 3:23 PM, Elliot Berman wrote:
>>
<snip>
>> +}
>> +
>> +static int gh_rm_init_connection_payload(struct gh_rm_connection 
>> *connection, void *msg,
>> +                    size_t hdr_size, size_t msg_size)
> 
> The value of hdr_size is *always* sizeof(*hdr), so you can
> do without passing it as an argument.
> 

hdr_size is different when receiving reply (1 extra word) vs notification.

>> +{
>> +    size_t max_buf_size, payload_size;
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +
> 
> It probably sounds dumb, but I'd reverse the values
> compared below (and the operator).
> 
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
> 
> The payload size is the same across all messages in the
> "connection" right?  As is the number of fragments?
> It's not even possible/valid to have a zero payload size
> and non-zero number of fragments.  I think the second
> half of the above test can be dropped.
> 

The RM RPC specification doesn't require that the first message have 
payload. (It makes sense to do it and it does, but that's implementation 
detail)

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
> 
> I think I suggested (hdr + 1) rather than (msg + size) elsewhere
> and you took that suggestion.  I'd say do it one way or the other,
> consistently, everywhere.
> 

hdr_size != sizeof(*hdr) when we receive a reply message.

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
>> +    kfree(connection);
>> +}
>> +
>> +static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm *rm, 
>> void *msg, size_t msg_size)
> 
> I think it might be better if you do some of what the caller
> does here.  I.e., verify the current connection is null (and
> abort if not and make it NULL), then assign it to the new
> connection before you return success.  And return an errno.
> 

Since you and Srini both suggest to do it, I'll cave. :-)

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
>> +        kfree(connection);
>> +        return NULL;
>> +    }
>> +
>> +    return connection;
>> +}
>> +
>> +static struct gh_rm_connection *gh_rm_process_rply(struct gh_rm *rm, 
>> void *msg, size_t msg_size)
>> +{
> 
> Here too, make sure there is no active connection and then
> set it within this function if the errno returned is 0.
> 
>> +    struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
>> +    struct gh_rm_connection *connection;
>> +    u16 seq_id = le16_to_cpu(reply_hdr->hdr.seq);
>> +
>> +    mutex_lock(&rm->call_idr_lock);
>> +    connection = idr_find(&rm->call_idr, seq_id);
>> +    mutex_unlock(&rm->call_idr_lock);
>> +
>> +    if (!connection || connection->msg_id != reply_hdr->hdr.msg_id)
>> +        return NULL;
>> +
>> +    if (gh_rm_init_connection_payload(connection, msg, 
>> sizeof(*reply_hdr), msg_size)) {
>> +        dev_err(rm->dev, "Failed to alloc connection buffer for 
>> sequence %d\n", seq_id);
>> +        /* Send connection complete and error the client. */
>> +        connection->reply.ret = -ENOMEM;
>> +        complete(&connection->reply.seq_done);
>> +        return NULL;
>> +    }
>> +
>> +    connection->reply.rm_error = le32_to_cpu(reply_hdr->err_code);
>> +    return connection;
>> +}
>> +
>> +static int gh_rm_process_cont(struct gh_rm *rm, struct 
>> gh_rm_connection *connection,
>> +                void *msg, size_t msg_size)
> 
> Similar comment here.  Have this function verify there is
> a non-null active connection.  Then process the message
> and abort if there's an error (and null the active connection
> pointer).
> 
>> +{
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +    size_t payload_size = msg_size - sizeof(*hdr);
>> +
>> +    /*
>> +     * hdr->fragments and hdr->msg_id preserves the value from first 
>> reply
>> +     * or notif message. To detect mishandling, check it's still intact.
>> +     */
>> +    if (connection->msg_id != hdr->msg_id ||
>> +        connection->num_fragments != FIELD_GET(RM_RPC_FRAGMENTS_MASK, 
>> hdr->type))
>> +        return -EINVAL;
> 
> Maybe -EBADMSG?
> 
>> +
>> +    memcpy(connection->payload + connection->size, msg + 
>> sizeof(*hdr), payload_size);
>> +    connection->size += payload_size;
>> +    connection->fragments_received++;
>> +    return 0;
>> +}
>> +
>> +static void gh_rm_abort_connection(struct gh_rm_connection *connection)
>> +{
>> +    switch (connection->type) {
>> +    case RM_RPC_TYPE_REPLY:
>> +        connection->reply.ret = -EIO;
>> +        complete(&connection->reply.seq_done);
>> +        break;
>> +    case RM_RPC_TYPE_NOTIF:
>> +        fallthrough;
>> +    default:
>> +        kfree(connection->payload);
>> +        kfree(connection);
>> +    }
>> +}
>> +
>> +static bool gh_rm_complete_connection(struct gh_rm *rm, struct 
>> gh_rm_connection *connection)
> 
> The only caller of this function passes rm->active_rx_connection
> as the second argument.  It is available to you here, so you
> can get rid of that argument.
> 
>> +{
>> +    if (!connection || connection->fragments_received != 
>> connection->num_fragments)
>> +        return false;
>> +
>> +    switch (connection->type) {
>> +    case RM_RPC_TYPE_REPLY:
>> +        complete(&connection->reply.seq_done);
>> +        break;
>> +    case RM_RPC_TYPE_NOTIF:
>> +        schedule_work(&connection->notification.work);
>> +        break;
>> +    default:
>> +        dev_err(rm->dev, "Invalid message type (%d) received\n", 
>> connection->type);
>> +        gh_rm_abort_connection(connection);
>> +        break;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
>> +{
>> +    struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
>> +    struct gh_msgq_rx_data *rx_data = mssg;
>> +    size_t msg_size = rx_data->length;
>> +    void *msg = rx_data->data;
>> +    struct gh_rm_rpc_hdr *hdr;
>> +
> 
> Is it required that at least one byte (past the header) will
> be received?  I.e., should the "<=" below just be "<"?
> 
>> +    if (msg_size <= sizeof(*hdr) || msg_size > GH_MSGQ_MAX_MSG_SIZE)
>> +        return;
> 
> You previously reported a message here.  These seem like
> errors, which if they occur, maybe should be reported.
> They seem like "never happen" issues, but it's defensive
> to make these checks (which is good).
> 
>> +
>> +    hdr = msg;
>> +    if (hdr->api != RM_RPC_API) {
> 
> If this ever happens, is the hardware failing?  It seems
> like once Gunyah is initialized and you've checked the
> API version once, there should be no need to check it
> repeatedly.

I'd need to check the API version for the first message. On subsequent 
messages, I'd need to check if I already checked. Might as well just 
check the version every time?

<done for all the comments snipped>

>> +
>> +void get_gh_rm(struct gh_rm *rm)
> 
> It is often pretty handy to return the argument in
> functions like this.  It simultaneously takes the
> reference and assigns the pointer the reference
> represents.
> 
> 

I've updated so that gh_rm_get() returns a struct device * (the 
miscdev's device). Is this too unusual?

>> +{
>> +    get_device(rm->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(get_gh_rm);
>> +
>> +void put_gh_rm(struct gh_rm *rm)
>> +{
>> +    put_device(rm->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(put_gh_rm);
>> +
>> +static int gh_msgq_platform_probe_direction(struct platform_device 
>> *pdev,
>> +                    bool tx, int idx, struct gunyah_resource *ghrsc)
>> +{
>> +    struct device_node *node = pdev->dev.of_node;
>> +    int ret;
> 
> I think you should declare idx as a local variable.
> 
>      int idx = tx ? 1 : 0;
> >> +
>> +    ghrsc->type = tx ? GUNYAH_RESOURCE_TYPE_MSGQ_TX : 
>> GUNYAH_RESOURCE_TYPE_MSGQ_RX;
>> +
>> +    ghrsc->irq = platform_get_irq(pdev, idx);
> 
> Do you suppose you could do platform_get_irq_byname(), and then
> specify the names of the IRQs ("rm_tx_irq" and "rm_rx_irq" maybe)?
> 
>> +    if (ghrsc->irq < 0) {
>> +        dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, 
>> ghrsc->irq);
> 
> Maybe:    "Failed to get %cX IRQ: %d\n", tx ? 'T' : 'R', ghrsc->irq);
> 
>> +        return ghrsc->irq;
>> +    }
>> +
>> +    ret = of_property_read_u64_index(node, "reg", idx, &ghrsc->capid);
> 
> Is a capability ID a simple (but large) number?
> 
> The *resource manager* (which is a very special VM) has to
> have both TX and RX message queue capability IDs.  Is there
> 'any chance that these specific capability IDs have values
> that are fixed by the design?  Like, 0 and 1?  I don't know
> what they are, but it seems like it *could* be something
> fixed by the design, and if that were the case, there would
> be no need to specify the "reg" property to get the "capid"
> values.
> 

They aren't fixed by the design in a production version of Gunyah.

>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>> +{
>> +    struct gh_msgq_tx_data *msg;
>> +    struct gh_rm *rm;
>> +    int ret;
>> +
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
> 
> If you abstracted the allocation interface for these messages,
> you could actually survive without the slab cache here.  But
> if this fails, maybe you won't get far anyway.
> 
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
>> +struct gh_rm;
> 
> This might just be my preference, but I like to see declarations
> like the one above grouped at the top of the file, under includes.
> 
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
> 
> I haven't really checked very well, bur you should *use this*
> definition where a VMID is being examined. I.e., if you're
> going to define this, then never just compare a VMID against 0.
> 

I realize now the only place I *could* use GH_VMID_SELF is the one 
exception to usage of VMID -- in gh_rm_vmid_alloc. There, vmid of 0 
means "use dynamic allocation". Since there aren't any users of the 
GH_VMID_SELF, I'll drop it.

Thanks,
Elliot

>                      -Alex
> 
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
> 
