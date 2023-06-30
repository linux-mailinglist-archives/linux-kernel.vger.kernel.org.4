Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF77438C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF3J4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjF3J4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:56:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCEC173C;
        Fri, 30 Jun 2023 02:56:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U7U0YZ004035;
        Fri, 30 Jun 2023 09:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eQ3vHT80MxEnZAb6UvuoEXPBJGI7Dh5eKZ0+Yk0ssB4=;
 b=Ja1LGnOHvcOmDEimWNBNq67sBhrvBeTaPi5IljaQBSi4xTkvj+Yiw9Vrk2l8kpTdsKvT
 4qaVCNqG+2leL8CGbV8xDrQmK2WPY/f/xb0hYv7hA6YIvNHkDbZPVXa6rCtQi6Db6o1p
 fi9E/hpAWpWaYKfRGFRNx9nNJ7KgjXUdt5s5dzsOD4X4hdxfqWsdoohl9K8j6yB1lvg9
 PKR0fVpHy4OXiCBDNfjFQbOcpIv2T2jF37xjhYV3WlCumgDP9Jq9erA7GQpvxBvZofT8
 8bouN/tFogcS+D0p2JPIfvF08aOlocPTcYwXqsLMByR3ecy787WtTr89nsmbCRs4VWMW Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhsycrcf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 09:56:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U9u5TP008806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 09:56:05 GMT
Received: from [10.217.218.238] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 02:56:01 -0700
Message-ID: <32832352-e832-3ce1-caed-51e909b9ba62@quicinc.com>
Date:   Fri, 30 Jun 2023 15:25:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V1] net: mhi : Add support to enable ethernet interface
To:     <mhi@lists.linux.dev>
CC:     <mrana@quicinc.com>, <quic_qianyu@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
Content-Language: en-US
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
In-Reply-To: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h_dA-siWs5EDVgqIwL2q6QZmGpEKJ2_g
X-Proofpoint-GUID: h_dA-siWs5EDVgqIwL2q6QZmGpEKJ2_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=914
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300083
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/2023 3:14 PM, Vivek Pernamitta wrote:
> Add support to enable ethernet interface for MHI SWIP channels.
>
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
>   drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 40 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index 3d322ac..0a47e15 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -11,6 +11,7 @@
>   #include <linux/netdevice.h>
>   #include <linux/skbuff.h>
>   #include <linux/u64_stats_sync.h>
> +#include <linux/etherdevice.h>
>   
>   #define MHI_NET_MIN_MTU		ETH_MIN_MTU
>   #define MHI_NET_MAX_MTU		0xffff
> @@ -38,10 +39,12 @@ struct mhi_net_dev {
>   	u32 rx_queue_sz;
>   	int msg_enable;
>   	unsigned int mru;
> +	bool ethernet_if;
>   };
>   
>   struct mhi_device_info {
>   	const char *netname;
> +	bool ethernet_if;
>   };
>   
>   static int mhi_ndo_open(struct net_device *ndev)
> @@ -140,6 +143,14 @@ static void mhi_net_setup(struct net_device *ndev)
>   	ndev->tx_queue_len = 1000;
>   }
>   
> +static void mhi_ethernet_setup(struct net_device *ndev)
> +{
> +	ndev->netdev_ops = &mhi_netdev_ops;
> +	ether_setup(ndev);
> +	ndev->min_mtu = ETH_MIN_MTU;
> +	ndev->max_mtu = ETH_MAX_MTU;
> +}
> +
>   static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
>   				       struct sk_buff *skb)
>   {
> @@ -209,16 +220,22 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
>   			mhi_netdev->skbagg_head = NULL;
>   		}
>   
> -		switch (skb->data[0] & 0xf0) {
> -		case 0x40:
> -			skb->protocol = htons(ETH_P_IP);
> -			break;
> -		case 0x60:
> -			skb->protocol = htons(ETH_P_IPV6);
> -			break;
> -		default:
> -			skb->protocol = htons(ETH_P_MAP);
> -			break;
> +		if (mhi_netdev->ethernet_if) {
> +			skb_copy_to_linear_data(skb, skb->data,
> +						mhi_res->bytes_xferd);
> +			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
> +		} else {
> +			switch (skb->data[0] & 0xf0) {
> +			case 0x40:
> +				skb->protocol = htons(ETH_P_IP);
> +				break;
> +			case 0x60:
> +				skb->protocol = htons(ETH_P_IPV6);
> +				break;
> +			default:
> +				skb->protocol = htons(ETH_P_MAP);
> +				break;
> +			}
>   		}
>   
>   		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
> @@ -301,11 +318,17 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>   		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
>   }
>   
> -static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
> +static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
>   {
>   	struct mhi_net_dev *mhi_netdev;
>   	int err;
>   
> +	if (eth_dev) {
> +		eth_random_addr(ndev->dev_addr);
> +		if (!is_valid_ether_addr(ndev->dev_addr))
> +			return -EADDRNOTAVAIL;
> +	}
> +
>   	mhi_netdev = netdev_priv(ndev);
>   
>   	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
> @@ -313,6 +336,7 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
>   	mhi_netdev->mdev = mhi_dev;
>   	mhi_netdev->skbagg_head = NULL;
>   	mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
> +	mhi_netdev->ethernet_if = eth_dev;
>   
>   	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
>   	u64_stats_init(&mhi_netdev->stats.rx_syncp);
> @@ -356,13 +380,14 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>   	int err;
>   
>   	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
> +			    NET_NAME_PREDICTABLE, info->ethernet_if ?
> +			    mhi_ethernet_setup : mhi_net_setup);
>   	if (!ndev)
>   		return -ENOMEM;
>   
>   	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>   
> -	err = mhi_net_newlink(mhi_dev, ndev);
> +	err = mhi_net_newlink(mhi_dev, ndev, info->ethernet_if);
>   	if (err) {
>   		free_netdev(ndev);
>   		return err;
> @@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
>   
>   static const struct mhi_device_info mhi_hwip0 = {
>   	.netname = "mhi_hwip%d",
> +	.ethernet_if = false,
>   };
>   
>   static const struct mhi_device_info mhi_swip0 = {
>   	.netname = "mhi_swip%d",
> +	.ethernet_if = false,
>   };
>   
>   static const struct mhi_device_id mhi_net_id_table[] = {
