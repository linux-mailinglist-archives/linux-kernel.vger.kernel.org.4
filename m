Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB86AE188
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCGN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCGN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:58:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5B438B77;
        Tue,  7 Mar 2023 05:58:51 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327BklQt020723;
        Tue, 7 Mar 2023 13:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZDZ/jH5eBcghpL85l0fMXalPgbSG2EzY8vXOU3ZyTrQ=;
 b=TaizpaEpeZlXRkPz1KwnNktAciZnUT95HA0vhHKjzP5U7wUsoNnJSid2db15ZhjAMlUa
 4lh4mLe+V8UhtSL27W1bw5b+XCHT/HuF1AcGlNzCZEzLGcXwvXdTb3CW9QaeilZcXYc6
 q2nXZdYCm66nBAHq2FLmCLTZyV7X1L2vlHXtC4uDje6QUSLnLaD0uzcqVSu2VTfMLVHP
 3QgfaYz8Xz6n/l71QsiqqUEFVJB4ODe43977nd1QWeyqoshQ4ItnVfjlt/s1lQtCKOzy
 IMqSy7gXdfpHamyZVKDnBUQ6wa1iNTPy4rI5Zfzz6F+djKP8S3xD8voNqp9fzhX0MkpR CA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p5usx1kcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 13:28:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 327DSr6X012116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 13:28:53 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Mar 2023
 05:28:50 -0800
Message-ID: <d04262c0-af6c-0f56-eb50-4a1cf5c2146b@quicinc.com>
Date:   Tue, 7 Mar 2023 21:28:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] stm: class: Add MIPI OST protocol support
Content-Language: en-US
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
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
 <37ec6af5-f71b-7a92-9c59-1c89595382bc@quicinc.com>
In-Reply-To: <37ec6af5-f71b-7a92-9c59-1c89595382bc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BmHFUHbPoOz6F9EgQiP3-KGZkoqTfqeP
X-Proofpoint-GUID: BmHFUHbPoOz6F9EgQiP3-KGZkoqTfqeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_07,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=981 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/2023 9:26 PM, Jinlong Mao wrote:

> Hi Alexander,
Sorry, correct the typo.
>
> On 3/3/2023 2:05 AM, Alexander Shishkin wrote:
>> Mao Jinlong <quic_jinlmao@quicinc.com> writes:
>>
>>> Add MIPI OST protocol support for stm to format the traces.
>> Missing an explanation of what OST is, what it's used for, how it is
>> different from the SyS-T and others.
> I will updae the explanation in next version.
>>
>>> Framework copied from drivers/hwtracing/stm.p-sys-t.c as of
>> You mean stm/p_sys-t.c. Also, it's not a framework, it's a driver.
>
> The driver refers to code structure of p_sys-t driver. So, add this 
> comments after
> internal review.
>
>>
>>> commit d69d5e83110f ("stm class: Add MIPI SyS-T protocol
>>> support").
>> Why is this significant?
>>
>>> diff --git a/drivers/hwtracing/stm/p_ost.c 
>>> b/drivers/hwtracing/stm/p_ost.c
>>> new file mode 100644
>>> index 000000000000..2ca1a3fda57f
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/stm/p_ost.c
>>> @@ -0,0 +1,95 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copied from drivers/hwtracing/stm.p-sys-t.c as of commit 
>>> d69d5e83110f
>>> + * ("stm class: Add MIPI SyS-T protocol support").
>> Same as in the commit message.
>>
>> [...]
>>
>>> +#define OST_TOKEN_STARTSIMPLE (0x10)
>>> +#define OST_VERSION_MIPI1        (0x10 << 8)
>>> +#define OST_ENTITY_FTRACE        (0x01 << 16)
>>> +#define OST_CONTROL_PROTOCOL        (0x0 << 24)
>> These could use an explanation.
> I will add the explanation.
>>> +#define DATA_HEADER (OST_TOKEN_STARTSIMPLE | OST_VERSION_MIPI1 | \
>>> +            OST_ENTITY_FTRACE | OST_CONTROL_PROTOCOL)
>> Does this mean that everything is ftrace? Because it's not.
> Only ftrace is supported in p_ost now. Other header type will be added 
> later.
>>
>>> +
>>> +#define STM_MAKE_VERSION(ma, mi)    ((ma << 8) | mi)
>>> +#define STM_HEADER_MAGIC        (0x5953)
>>> +
>>> +static ssize_t notrace ost_write(struct stm_data *data,
>>> +        struct stm_output *output, unsigned int chan,
>>> +        const char *buf, size_t count)
>>> +{
>>> +    unsigned int c = output->channel + chan;
>>> +    unsigned int m = output->master;
>>> +    const unsigned char nil = 0;
>>> +    u32 header = DATA_HEADER;
>>> +    u8 trc_hdr[24];
>>> +    ssize_t sz;
>>> +
>>> +    /*
>>> +     * STP framing rules for OST frames:
>>> +     *   * the first packet of the OST frame is marked;
>>> +     *   * the last packet is a FLAG.
>> Which in your case is also timestamped.
> I will add the comments.
>>
>>> +     */
>>> +    /* Message layout: HEADER / DATA / TAIL */
>>> +    /* HEADER */
>>> +
>>> +    sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
>>> +              4, (u8 *)&header);
>> The /* HEADER */ comment applies to the above line, so it should
>> probably be directly before it.
> Got it.
>>
>>> +    if (sz <= 0)
>>> +        return sz;
>>> +    *(uint16_t *)(trc_hdr) = STM_MAKE_VERSION(0, 3);
>>> +    *(uint16_t *)(trc_hdr + 2) = STM_HEADER_MAGIC;
>>> +    *(uint32_t *)(trc_hdr + 4) = raw_smp_processor_id();
>>> +    *(uint64_t *)(trc_hdr + 8) = sched_clock();
>> Why sched_clock()? It should, among other things, be called with
>> interrupts disabled, which is not the case here.
> I will check. If it is not necessary here, I will remove it.
>>
>>> +    *(uint64_t *)(trc_hdr + 16) = task_tgid_nr(get_current());
>> Is there a reason why trc_hdr is not a struct?
> No particular reason here.
>>
>> Thanks,
>> -- 
>> Alex
