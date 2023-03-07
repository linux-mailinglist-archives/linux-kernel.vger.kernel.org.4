Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1C6AE077
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCGN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCGN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:26:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0AD498A9;
        Tue,  7 Mar 2023 05:26:47 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327CoV0b022600;
        Tue, 7 Mar 2023 13:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b2q1KaocnoUMsygR4Cev+YfcMioBZtQwwI6bBPEUB44=;
 b=oEp/JtAKnU2uW1po8uDVI4GeqdgRYmyxpFWmNmArdfXY7MNiLOA+M37vH86dmpQo0f/v
 MgAI4nK4Fxb3jLNXi/XGs7fJVoFkdG6xULOJD71/uEmFqe/S7aY4xjEGDnZ6txEVngk1
 VawF+h50RAqsafs1adJbgs4DACEFcgR62ywk5BG/koge0phHrLw3+VSSneXnPLwHxHfU
 6FfK9l2IC8IZM0pjKLEtX9lcwfPYWYjjIwZfLaBMs14cSlnIx/NEXhWjiM2gUdUTxKEi
 WViqnLEqSEOlqDjOyFL8rMWS46gouz+gUUymo3WljFf+XaXz156E8eLnSTRRcLsAFk1z jA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417er2wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 13:26:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327DQPJ5023804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 13:26:25 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 05:26:22 -0800
Message-ID: <37ec6af5-f71b-7a92-9c59-1c89595382bc@quicinc.com>
Date:   Tue, 7 Mar 2023 21:26:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] stm: class: Add MIPI OST protocol support
Content-Language: en-US
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208124053.18533-1-quic_jinlmao@quicinc.com>
 <87lekfni5b.fsf@ubik.fi.intel.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <87lekfni5b.fsf@ubik.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aJbXV0YBOOd4OKJ0HGVJJt9Yw3gcEyg0
X-Proofpoint-GUID: aJbXV0YBOOd4OKJ0HGVJJt9Yw3gcEyg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_07,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=951 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexande,

On 3/3/2023 2:05 AM, Alexander Shishkin wrote:
> Mao Jinlong <quic_jinlmao@quicinc.com> writes:
>
>> Add MIPI OST protocol support for stm to format the traces.
> Missing an explanation of what OST is, what it's used for, how it is
> different from the SyS-T and others.
I will updae the explanation in next version.
>
>> Framework copied from drivers/hwtracing/stm.p-sys-t.c as of
> You mean stm/p_sys-t.c. Also, it's not a framework, it's a driver.

The driver refers to code structure of p_sys-t driver. So, add this 
comments after
internal review.

>
>> commit d69d5e83110f ("stm class: Add MIPI SyS-T protocol
>> support").
> Why is this significant?
>
>> diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
>> new file mode 100644
>> index 000000000000..2ca1a3fda57f
>> --- /dev/null
>> +++ b/drivers/hwtracing/stm/p_ost.c
>> @@ -0,0 +1,95 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copied from drivers/hwtracing/stm.p-sys-t.c as of commit d69d5e83110f
>> + * ("stm class: Add MIPI SyS-T protocol support").
> Same as in the commit message.
>
> [...]
>
>> +#define OST_TOKEN_STARTSIMPLE		(0x10)
>> +#define OST_VERSION_MIPI1		(0x10 << 8)
>> +#define OST_ENTITY_FTRACE		(0x01 << 16)
>> +#define OST_CONTROL_PROTOCOL		(0x0 << 24)
> These could use an explanation.
I will add the explanation.
>> +#define DATA_HEADER (OST_TOKEN_STARTSIMPLE | OST_VERSION_MIPI1 | \
>> +			OST_ENTITY_FTRACE | OST_CONTROL_PROTOCOL)
> Does this mean that everything is ftrace? Because it's not.
Only ftrace is supported in p_ost now. Other header type will be added 
later.
>
>> +
>> +#define STM_MAKE_VERSION(ma, mi)	((ma << 8) | mi)
>> +#define STM_HEADER_MAGIC		(0x5953)
>> +
>> +static ssize_t notrace ost_write(struct stm_data *data,
>> +		struct stm_output *output, unsigned int chan,
>> +		const char *buf, size_t count)
>> +{
>> +	unsigned int c = output->channel + chan;
>> +	unsigned int m = output->master;
>> +	const unsigned char nil = 0;
>> +	u32 header = DATA_HEADER;
>> +	u8 trc_hdr[24];
>> +	ssize_t sz;
>> +
>> +	/*
>> +	 * STP framing rules for OST frames:
>> +	 *   * the first packet of the OST frame is marked;
>> +	 *   * the last packet is a FLAG.
> Which in your case is also timestamped.
I will add the comments.
>
>> +	 */
>> +	/* Message layout: HEADER / DATA / TAIL */
>> +	/* HEADER */
>> +
>> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
>> +			  4, (u8 *)&header);
> The /* HEADER */ comment applies to the above line, so it should
> probably be directly before it.
Got it.
>
>> +	if (sz <= 0)
>> +		return sz;
>> +	*(uint16_t *)(trc_hdr) = STM_MAKE_VERSION(0, 3);
>> +	*(uint16_t *)(trc_hdr + 2) = STM_HEADER_MAGIC;
>> +	*(uint32_t *)(trc_hdr + 4) = raw_smp_processor_id();
>> +	*(uint64_t *)(trc_hdr + 8) = sched_clock();
> Why sched_clock()? It should, among other things, be called with
> interrupts disabled, which is not the case here.
I will check. If it is not necessary here, I will remove it.
>
>> +	*(uint64_t *)(trc_hdr + 16) = task_tgid_nr(get_current());
> Is there a reason why trc_hdr is not a struct?
No particular reason here.
>
> Thanks,
> --
> Alex
