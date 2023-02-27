Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B96A4C89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjB0Uz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB0Uzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:55:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76125E3F;
        Mon, 27 Feb 2023 12:55:51 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RD0R1Z008607;
        Mon, 27 Feb 2023 20:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=LoXvMWyEAfQCVCMsBf7NgNnDVRCawaflNIjWJlJ7ovI=;
 b=JysaNCY6HInJ4ylpFEgVk0DcHq7kpPBkQ2TGe8h/WixXbjy9Qx6QEQIeQ0Z7Z5uRtn4c
 ky3ESlAtNLg7qR8ZhMr29eP4TZhnoITASrIG+ylvOMaM/2m/mTBVidXhoyr9LmOF7Yxc
 fAUz7HjBmfyPglvnaMY4UJHLvARNCJyVCRs2CviKCOBw0xQVJCQeVKWDZOB6S3vu5iqA
 PSxvQvOOc/FRCrUztHDDCKf4/mKQE9JonjzoSi9uasvQ8b3Gq4N6GYZ8pmXXMQ1w0zXo
 K2HSbcyJPm0jLgQtIDUH2pccikQw/4l1xUtI4VVgc6rnEllBTBb24rergYeWCsxDeXap kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p0u3thftx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 20:55:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RKthUU029168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 20:55:43 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Feb 2023 12:55:43 -0800
Date:   Mon, 27 Feb 2023 12:55:42 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Sarannya S <quic_sarannya@quicinc.com>
CC:     <arnaud.pouliquen@foss.st.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH V5 3/3] rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
Message-ID: <20230227205542.GB4062527@hu-bjorande-lv.qualcomm.com>
References: <1676994962-18206-1-git-send-email-quic_sarannya@quicinc.com>
 <1676994962-18206-4-git-send-email-quic_sarannya@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1676994962-18206-4-git-send-email-quic_sarannya@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RplLd9AGHLwN6wDAAe5PuEtFO-tapfl9
X-Proofpoint-ORIG-GUID: RplLd9AGHLwN6wDAAe5PuEtFO-tapfl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=955 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:26:02PM +0530, Sarannya S wrote:
> Add TICOMGET and TIOCMSET ioctl support for rpmsg char device nodes
> to get/set the low level transport signals.

Please update subjet and this commit message as well.

> 
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 60 +++++++++++++++++++++++++++++++++++++++-------
>  include/uapi/linux/rpmsg.h | 11 +++++++++
>  2 files changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 3e0b8f3..fdcb4ff 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -23,6 +23,7 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <linux/termios.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rpmsg.h>
>  
> @@ -68,6 +69,8 @@ struct rpmsg_eptdev {
>  	struct sk_buff_head queue;
>  	wait_queue_head_t readq;
>  
> +	u32 remote_signals;
> +	bool flow_control;
>  };
>  
>  int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> @@ -109,7 +112,22 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	skb_queue_tail(&eptdev->queue, skb);
>  	spin_unlock(&eptdev->queue_lock);
>  
> -	/* wake up any blocking processes, waiting for new data */

Is this comment no longer valid?

> +	wake_up_interruptible(&eptdev->readq);
> +
> +	return 0;
> +}
> +
> +static int rpmsg_ept_flow_cb(struct rpmsg_device *rpdev, void *priv, bool enable)
> +{
> +	struct rpmsg_eptdev *eptdev = priv;
> +
> +	if (enable)
> +		eptdev->remote_signals = RPMSG_FLOW_CONTROL_ON;
> +	else
> +		eptdev->remote_signals = 0;
> +
> +	eptdev->flow_control = true;

So remote_signals is the state of the remote's requested flow control
and flow_control is carrying the information that the flow control has
been requested, to interrupt poll.

I think something like remote_flow and remote_flow_updated would make
that more intuitive.


Also, remote_signals can be bool and you can just assign enable, no need
for the conditional.

> +
>  	wake_up_interruptible(&eptdev->readq);
>  
>  	return 0;
> @@ -146,6 +164,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->flow_cb = rpmsg_ept_flow_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  	mutex_unlock(&eptdev->ept_lock);
> @@ -166,6 +185,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> +	eptdev->flow_control = false;
>  
>  	/* Discard all SKBs */
>  	skb_queue_purge(&eptdev->queue);
> @@ -279,6 +299,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
>  	if (!skb_queue_empty(&eptdev->queue))
>  		mask |= EPOLLIN | EPOLLRDNORM;
>  
> +	if (eptdev->flow_control)
> +		mask |= EPOLLPRI;
> +
>  	mask |= rpmsg_poll(eptdev->ept, filp, wait);
>  
>  	return mask;
> @@ -289,14 +312,35 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  {
>  	struct rpmsg_eptdev *eptdev = fp->private_data;
>  
> -	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
> -		return -EINVAL;
> -
> -	/* Don't allow to destroy a default endpoint. */
> -	if (eptdev->default_ept)
> -		return -EINVAL;
> +	bool set;
> +	u32 val;
> +	int ret;
> +	
> +	switch (cmd) {
> +	case RPMSG_GET_SIGNAL_IOCTL:

Signals is a glink name for this, how about:

RPMSG_GET_OUTGOING_FLOWCONTROL

> +		eptdev->flow_control = false;
> +		ret = put_user(eptdev->remote_signals, (int __user *)arg);
> +		break;
> +	case RPMSG_SET_SIGNAL_IOCTL:

RPMSG_SET_INCOMING_FLOWCONTROL

> +		ret = get_user(val, (int __user *)arg);
> +		if (ret)
> +			break;
> +		set = (val & RPMSG_FLOW_CONTROL_ON) ? true : false;

The reason for only considering some bit(s) in the argument is to allow
for future expansion, but unless you validate that those bits are unused
by the caller you could end up with clients passing unexpected bits in
~1, effectively preventing such future modifications.

So if we're masking out the state, then we need to also reject (arg &
~1). But I would prefer that we instead treat it as a boolean and do:

  set = !!arg;

> +		ret = rpmsg_set_flow_control(eptdev->ept, set);
> +		break;
> +	case RPMSG_DESTROY_EPT_IOCTL:
> +		/* Don't allow to destroy a default endpoint. */
> +		if (eptdev->default_ept) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		ret = rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
>  
> -	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
> +	return ret;
>  }
>  
>  static const struct file_operations rpmsg_eptdev_fops = {
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index 1637e68..e9aa6b9 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -10,6 +10,7 @@
>  #include <linux/types.h>
>  
>  #define RPMSG_ADDR_ANY		0xFFFFFFFF
> +#define RPMSG_FLOW_CONTROL_ON  0x001
>  
>  /**
>   * struct rpmsg_endpoint_info - endpoint info representation
> @@ -43,4 +44,14 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
>  
> +/**
> + * Get the remote rpmsg char device's flow control signal.

s/signal/state/

> + */
> +#define RPMSG_GET_SIGNAL_IOCTL _IOW(0xb5, 0x5, struct rpmsg_endpoint_info)
> +
> +/**
> + * Set the flow control for the local rpmsg char device.
> + */
> +#define RPMSG_SET_SIGNAL_IOCTL _IOW(0xb5, 0x6, struct rpmsg_endpoint_info)
> +

Regards,
Bjorn

>  #endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
