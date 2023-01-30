Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F48681E31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjA3Wgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3Wgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:36:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B2C655;
        Mon, 30 Jan 2023 14:36:41 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKxZK2009515;
        Mon, 30 Jan 2023 22:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KdOKdPUw1bqLM9gwsel5D/At4bEf1Z3G25I8RcfFud8=;
 b=BBU00XS7qtR+QhLdoXbGWZp8Gg352rrE/Ej5yw3u/cp/jCn3HR7rQ92R6zrl2DB32Ohh
 4iYFPUcH606PZCm1Ebl+iDsZ73JdcpuFfuyMAZjmfaCJDB9OstlzBjcXQ48ACsC6lSSp
 9Zd80J4Z/UnrFphsr9qloPYdNY8SuVveYJRmy7861hVPP0oDo+4t5oxCr9CyE4k67iKA
 W65qBRvvI+MuwMHRB2GKeuS+BbqAPp1OYcI31b7ENYB4YVzxvqfHZ0GGHVRss3yANQIh
 qzQ4ejhssWAOXihZgZkjAmsXGFuxi2aqWMQseweGThjZW7a7T3+pCD+cBjJsHiWDzwT4 UQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncua8w553-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:36:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UMaLLc030234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:36:21 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 14:36:20 -0800
Message-ID: <733ac9d4-93ae-b54b-7dd4-fba1015f4db8@quicinc.com>
Date:   Mon, 30 Jan 2023 14:36:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com>
 <64b60c9a-5f9b-6377-1307-095a42d18dc3@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <64b60c9a-5f9b-6377-1307-095a42d18dc3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QCMLAMP5U4fPrBNdoCtOt6PZJHuDXvX4
X-Proofpoint-ORIG-GUID: QCMLAMP5U4fPrBNdoCtOt6PZJHuDXvX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300207
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/26/2023 7:32 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/25/23 21:14, Wesley Cheng wrote:
>> Some platforms may want to register its USB port to be handled by the ASoC
>> framework.  Audio playback/capture support is also handled entirely by the
>> vendor ASoC drivers.
> 
> Can you clarify what you mean by 'port'?
> 

Ideally, port is intended to represent how many USB audio devices the 
audio DSP can support.

>> +/**
>> + * snd_soc_usb_add_port() - Add a USB backend port
>> + * @dev: USB backend device
>> + * @connection_cb: connection status callback
>> + *
>> + * Register a USB backend device to the SND USB SOC framework.  Memory is
>> + * allocated as part of the USB backend device.
>> + *
>> + */
>> +struct snd_soc_usb *snd_soc_usb_add_port(struct device *dev,
>> +			int (*connection_cb)(struct snd_soc_usb *usb, int card_idx,
>> +			int connected))
>> +{
>> +	struct snd_soc_usb *usb;
>> +
>> +	usb = devm_kzalloc(dev, sizeof(*usb), GFP_KERNEL);
>> +	if (!usb)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	usb->connection_status_cb = connection_cb;
>> +	usb->dev = dev;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_add_tail(&usb->list, &usb_ctx_list);
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return usb;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_add_port);
> 
> Can a backend have more than one ports?
> 

The intended model is one BE per usb device.

> Is there any relationship between port and USB endpoint, and if yes
> where is this determined?
> 

Might need some more clarification on this question.  I mean, whichever 
port the USB device is connected to will be the USB endpoint(s) being 
utilized.

Maybe the confusion is in the "port" label itself?  You can think of 
port meaning the same thing as a udev. (struct usb_device)

>> +
>> +/**
>> + * snd_soc_usb_remove_port() - Remove a USB backend port
>> + * @dev: USB backend device
>> + *
>> + * Remove a USB backend device from USB SND SOC.  Memory is freed when USB
>> + * backend is removed.
>> + *
>> + */
>> +int snd_soc_usb_remove_port(struct device *dev)
>> +{
>> +	struct snd_soc_usb *ctx, *tmp;
>> +
>> +	mutex_lock(&ctx_mutex);
>> +	list_for_each_entry_safe(ctx, tmp, &usb_ctx_list, list) {
>> +		if (ctx->dev == dev) {
>> +			list_del(&ctx->list);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&ctx_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_remove_port);
> 
> What happens if the ASoC driver probes/initialize AFTER the USB device
> is plugged?
> 

Good point, that's one thing I was seeing how we could address 
initially, but never got around to adding it.  Currently the code would 
basically not enable the DAPM pins/path for that backend device. (when 
we probe the USB backend, we disable the USB_RX_BE pin)

If the USB SND driver gets the connection before the USB BE is up, then 
q6usb_alsa_connection_cb() would not be called, which sets the USB_RX_BE 
pin state (to enable).  Then when the Q6USB backend is probed, the 
USB_RX_BE pin state would be set to disabled.

Will see if I can maybe cache the connection state somewhere and pass it 
along when the USB BE is up.

> Likewise, can the ASoC driver be removed 'safely' with a fallback to
> normal non-offloaded operation happening on remove?
> 

As of now, there is no automatic fallback for that scenario.  If I 
compile all our Q6 dai drivers as modules as well as the platform card, 
then we won't be able to individually remove ASoC component modules 
since they are being used by the platform soundcard device.

The only way to remove the USB backend driver is first to remove the 
platform sound card, which will tear down the current audio session and 
remove the sound card that was created.


>> +
>> +/**
>> + * snd_soc_usb_connect() - Notification of USB device connection
>> + * @usbdev: USB bus device
>> + * @card_idx: USB SND card instance
>> + *
>> + * Notify of a new USB SND device connection.  The card_idx can be used to
>> + * handle how the USB backend selects, which device to enable offloading on.
>> + *
>> + */
>> +int snd_soc_usb_connect(struct device *usbdev, int card_idx)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return -ENODEV;
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +	if (!ctx)
>> +		return -ENODEV;
>> +
>> +	if (ctx->connection_status_cb)
>> +		ctx->connection_status_cb(ctx, card_idx, 1);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_connect);
>> +
>> +/**
>> + * snd_soc_usb_connect() - Notification of USB device connection
>> + * @usbdev: USB bus device
>> + *
>> + * Notify of a new USB SND device disconnection to the USB backend.
>> + *
>> + */
>> +int snd_soc_usb_disconnect(struct device *usbdev)
>> +{
>> +	struct snd_soc_usb *ctx;
>> +
>> +	if (!usbdev)
>> +		return -ENODEV;
>> +
>> +	ctx = snd_soc_find_usb_ctx(usbdev);
>> +	if (!ctx)
>> +		return -ENODEV;
>> +
>> +	if (ctx->connection_status_cb)
>> +		ctx->connection_status_cb(ctx, -1, 0);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_usb_disconnect);
> 
> Similar concern on connect/disconnect, does this assume any specific
> order for the driver probe?

I think the above explanation clarifies the order which is currently 
going to cause us to potentially miss a device connection.

Thanks
Wesley Cheng
