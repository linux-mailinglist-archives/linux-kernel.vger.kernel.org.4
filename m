Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7736955C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBNBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBNBLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:11:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB72D7C;
        Mon, 13 Feb 2023 17:11:44 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIkTIL017901;
        Tue, 14 Feb 2023 01:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y6siSl3/wct/MYSfNJvPWS/tMI/7vOuzcSV/jDHdlo0=;
 b=H0rmSUxAeHYQxmRmmYkZpUHs0YxZuiloAWOFYI4KG8gKoD/6SxNC/xQolvxQAb1S/act
 OosOhb5rg7dPR5Iv0py5bZbDaIaQGH6Fdmn/poiYuoWOfwxU7h4Mo0UXwZwLqnT34rvq
 rSEWLJc+Re3EQVlZBN1VCBHJ5M8gRJ5YtpILB3PbVIGli1LeliVhqRa6JhnN1fIKqgFV
 y+UfXlP/JbNyUwgyj0zs4WIVX0UU4wPQEUvgsBIBgDrsDxT47URXUD3ZLQPebZIU2l81
 PysLqBxE34R3dAaZ7ha+vzi596caYWs090g5ZnohIcrG0w706QdjtvdMVN/8IvnHISQF Dg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7rmp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 01:11:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E1BeCh025118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 01:11:41 GMT
Received: from [10.216.32.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 17:11:38 -0800
Message-ID: <05652cb3-33cf-9ed9-c5ea-da26fbab2584@quicinc.com>
Date:   Tue, 14 Feb 2023 06:41:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] usb: gadget: ncm: Add support to configure wMaSegmentSize
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20230212175659.4480-1-quic_kriskura@quicinc.com>
 <CANP3RGerSsUPhzdExrok_sc2jst2firjsEkaLepHDgt_sFmO4w@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGerSsUPhzdExrok_sc2jst2firjsEkaLepHDgt_sFmO4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yTHatNzBKdPurtPaNwWB77Ad1TvoDpwm
X-Proofpoint-ORIG-GUID: yTHatNzBKdPurtPaNwWB77Ad1TvoDpwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_13,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140006
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 3:17 AM, Maciej Żenczykowski wrote:
> This isn't a review per say - just some loose comments.
> 
> On Sun, Feb 12, 2023 at 9:57 AM Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>> Currently the NCM driver restricts wMasxSegmentSize that indicates
> 
> there's a number of spelling mistakes, here, and in the commit title
> 
>> the datagram size coming from network layer to 1514. However the
>> spec doesn't have any limitation.
>>
>> Add support to configure this value before configfs symlink is
>> created. Also since the NTB Out/In buffer sizes are fixed at 16384
>> bytes, limit the segment size to an upper cap of 8192 bytes so that
>> at least 2 packets can be aggregated.
> 
Hi Maciej, Thanks for the comments:

> I've experimented with increasing mtu to boost performance before
> (have some half-baked patches/scripts somewhere).
> And while it did improve point-to-point performance, it wasn't
> actually useful for any real world use cases,
> as internet mtu is simply never above 1500.
My use case is actually a P2P connection and data is not strictly 
internet data. So I was trying to change the MTU and max segment size 
both at the same time to increase throughput.
> 
> Note that you cannot simply receive, aggregate (lro/gro) and forward
> aggregated packets without splitting them back up.
> 
> A change like this to be useful would require negotiating some sort of
> gso capabilities between the two devices
> (and thus extending the NCM standard).  I've been meaning to do
> this... but time...
> 
I have very little knowledge of GSO capabilities. Will get back and read 
up on them.
Is it something to do with splitting/aggregation of packets at Phy layer 
(segments of NTB) before giving them back to network stack ?

>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/f_ncm.c | 55 +++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ncm.h |  1 +
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index 424bb3b666db..1969e276017f 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -118,6 +118,12 @@ static inline unsigned ncm_bitrate(struct usb_gadget *g)
>>   /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>>   #define TX_TIMEOUT_NSECS       300000
>>
>> +/*
>> + * Currently the max NTB Buffer size is set to 16384. For atleast 2 packets
>> + * to be aggregated, the size of datagram must at max be 8192.
>> + */
>> +#define MAX_DATAGRAM_SIZE      8192
> 
>  From what I recall, there's a fair bit of overhead, and 8192 x2
> doesn't actually fit in 16384...
> That said... is it reasonable to require 2 to fit?  why? what's wrong
> with 15000?
Thanks for this, I missed the header being present here. I was under the 
impression that we might need to aggregate at least 2 packets. So made 
it (fixed_out_len/2). But seems like we can even put it to 15000 as 
well. Will remove this check in configfs store func.
> 
>> +
>>   #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>>                                   USB_CDC_NCM_NTB32_SUPPORTED)
>>
>> @@ -1440,6 +1446,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>           */
>>          if (!ncm_opts->bound) {
>>                  mutex_lock(&ncm_opts->lock);
>> +               ncm_opts->net->mtu = (ncm_opts->max_segment_size - 14);
> 
> this should use a constant, ETH_HLEN probably
Sure, will make this a constant.
> 
>>                  gether_set_gadget(ncm_opts->net, cdev->gadget);
>>                  status = gether_register_netdev(ncm_opts->net);
>>                  mutex_unlock(&ncm_opts->lock);
>> @@ -1484,6 +1491,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>
>>          status = -ENODEV;
>>
>> +       ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
>> +
> 
> Curious... wasn't this set previously?

The one set above was MTU size before register net device. This here is 
to update the required segment size to ecm_descriptor before requesting 
ep's and providing descs to composite.

Regards,
Krishna,
> 
>>          /* allocate instance-specific endpoints */
>>          ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>>          if (!ep)
>> @@ -1586,11 +1595,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>>   /* f_ncm_opts_ifname */
>>   USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>>
>> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
>> +                                               char *page)
>> +{
>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>> +       u32 segment_size;
>> +
>> +       mutex_lock(&opts->lock);
>> +       segment_size = opts->max_segment_size;
>> +       mutex_unlock(&opts->lock);
>> +
>> +       return sprintf(page, "%u\n", segment_size);
>> +}
>> +
>> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
>> +                                               const char *page, size_t len)
>> +{
>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>> +       int ret;
>> +       u32 segment_size;
>> +
>> +       mutex_lock(&opts->lock);
>> +       if (opts->refcnt) {
>> +               ret = -EBUSY;
>> +               goto out;
>> +       }
>> +
>> +       ret = kstrtou32(page, 0, &segment_size);
>> +       if (ret)
>> +               goto out;
>> +
>> +       if (segment_size > MAX_DATAGRAM_SIZE) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       opts->max_segment_size = segment_size;
>> +       ret = len;
>> +out:
>> +       mutex_unlock(&opts->lock);
>> +       return ret;
>> +}
>> +
>> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
>> +
>>   static struct configfs_attribute *ncm_attrs[] = {
>>          &ncm_opts_attr_dev_addr,
>>          &ncm_opts_attr_host_addr,
>>          &ncm_opts_attr_qmult,
>>          &ncm_opts_attr_ifname,
>> +       &ncm_opts_attr_max_segment_size,
>>          NULL,
>>   };
>>
>> @@ -1633,6 +1687,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
>>                  kfree(opts);
>>                  return ERR_CAST(net);
>>          }
>> +       opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
>>          INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>>
>>          descs[0] = &opts->ncm_os_desc;
>> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
>> index 5408854d8407..fab99d997476 100644
>> --- a/drivers/usb/gadget/function/u_ncm.h
>> +++ b/drivers/usb/gadget/function/u_ncm.h
>> @@ -31,6 +31,7 @@ struct f_ncm_opts {
>>           */
>>          struct mutex                    lock;
>>          int                             refcnt;
>> +       u32                             max_segment_size;
>>   };
>>
>>   #endif /* U_NCM_H */
>> --
>> 2.39.0
>>
