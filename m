Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB61681E79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjA3WzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjA3WzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:55:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FC014E8A;
        Mon, 30 Jan 2023 14:55:00 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ULujeK024979;
        Mon, 30 Jan 2023 22:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rm0iqWOS+sI5gIuwr8/Tp9JmVMOL9RZOaYwrQiZBsFI=;
 b=HJm17lkZQQIsSQhYaZiE5SUmF7HqwAbOCgIYu6TJJY9VGaVXKGhEEBqIfNPjHUiCgsQl
 AFsG9vRIECLSfjy0ZdI493K+DyWTZVCWAloPnlBSP/ZjDTmRQd1xk+f/quqvreCVFxku
 O9josAaTWlbGi8MM4N2OtoRPzHb4rhnXlX6iwnqbyZtGRnxsQWaP8LXCSDlsfdtE8e6Y
 MPc3d16hQ5wLuafKGX7ZpTTG/MyV36LcMmfQSL0/cvnW62FWByqV+McfjrQ72wa55tkW
 tiJr1jn23My6rhbtFen5GwPTk/efF8JdB09qALngZZiWpAKiPuPTOX1xxC4wdPrQeNWa cQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncu1tw6g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:54:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UMsPgt016444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:54:25 GMT
Received: from [10.110.113.14] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 14:54:24 -0800
Message-ID: <5dec443d-9894-2d06-1798-c56b8f2e1e5e@quicinc.com>
Date:   Mon, 30 Jan 2023 14:54:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 09/22] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20230126031424.14582-10-quic_wcheng@quicinc.com>
 <dea77277-6971-fe27-1ae0-ed551e84b6e4@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <dea77277-6971-fe27-1ae0-ed551e84b6e4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L7y1LGlTcfLKWAvKAlyC2pR18Ztn9lEu
X-Proofpoint-ORIG-GUID: L7y1LGlTcfLKWAvKAlyC2pR18Ztn9lEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=543 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300209
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 1/26/2023 7:38 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 1/25/23 21:14, Wesley Cheng wrote:
>> The QC ADSP is able to support USB playback endpoints, so that the main
>> application processor can be placed into lower CPU power modes.  This adds
>> the required AFE port configurations and port start command to start an
>> audio session.
>>
>> Specifically, the QC ADSP can support all potential endpoints that are
>> exposed by the audio data interface.  This includes, feedback endpoints
>> (both implicit and explicit) as well as the isochronous (data) endpoints.
>> The size of audio samples sent per USB frame (microframe) will be adjusted
>> based on information received on the feedback endpoint.
> 
> I think you meant "support all potential endpoint types"
> 
> It's likely that some USB devices have more endpoints than what the DSP
> can handle, no?
> 

True, as we discussed before, we only handle the endpoints for the audio 
interface.  Other endpoints, such as HID, or control is still handled by 
the main processor.

> And that brings me back to the question: what is a port and the
> relationship between port/backend/endpoints?
> 
> Sorry for being picky on terminology, but if I learned something in days
> in standardization it's that there shouldn't be any ambiguity on
> concepts, otherwise everyone is lost at some point.
> 

No worries, I can understand where you're coming from :).  After 
re-reading some of the notations used, I can see where people may be 
confused.

> 
>>   static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>> +	[USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
>>   	[HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
>>   	[SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
>>   				SLIMBUS_0_RX, 1, 1},
> 
> And if I look here a port seems to be a very specific AFE concept
> related to interface type? Do we even need to refer to a port in the USB
> parts?
> 

Well, this is a design specific to how the Q6 AFE is implemented.  There 
is a concept for an AFE port to be opened.  However, as mentioned 
earlier, the "port" term used in soc-usb should be more for how many USB 
devices can be supported.

If there was a case the audio DSP would support more than one USB 
device, I believe another AFE port would need to be added.

Thanks
Wesley Cheng
