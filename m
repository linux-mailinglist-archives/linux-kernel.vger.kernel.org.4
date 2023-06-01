Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353ED719543
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjFAISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFAIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:18:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EACC0;
        Thu,  1 Jun 2023 01:18:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35157f9D005856;
        Thu, 1 Jun 2023 08:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : cc : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9ulyxtnLbyf2a3USAS9PA7RGoPLjIpqABENYOr2SUxo=;
 b=hpwiw+D0StlZA2kcXGi0KtZmF8o4LkWiGX3gyXgJnsYlH5xIuvm6DDCUQC7UUZ84o3Rz
 MUc4mnNe9+0E5FiuPmk6+gxELCPILy5zrfN/XRWRw1QXvNDCauPg7GpjG75ltDChH3S2
 Velq0orx6RgAs4RnN3ttbVK3AeDT4tSCTy3gN2erasvfA57AtUv+JXyQmu3TWfUy5d9N
 bBZR6K6WA5RbQRgB2vIr5vcLfUaIp/tyMnW6kpMRGDoaIAuebe2aMzlMa5LsK3Z8jpoc
 W+XmyunKkkhfW3uOYtIVNwWne9OAIPqARPndPaUZC6lNyv+NywkJ2rPzbhjuHnaO6wWk Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxdr994qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 08:18:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3518I5fF028365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 08:18:05 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 01:18:01 -0700
Message-ID: <13686cd8-c887-32ef-d314-0955be366373@quicinc.com>
Date:   Thu, 1 Jun 2023 16:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/11] Add support to configure TPDM DSB subunit
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <7e2eaf1f-369a-d664-1011-3da6efb382a3@arm.com>
 <725b6ccd-ff70-a3d2-fe44-797c0509e643@quicinc.com>
Content-Language: en-US
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
In-Reply-To: <725b6ccd-ff70-a3d2-fe44-797c0509e643@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PCVBf0gBnt9zwnUMCp9nacwEQ8lQ9rG2
X-Proofpoint-GUID: PCVBf0gBnt9zwnUMCp9nacwEQ8lQ9rG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_05,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010072
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 3:50 PM, Tao Zhang wrote:
> On 4/28/2023 12:53 AM, Suzuki K Poulose wrote:
>> On 27/04/2023 10:00, Tao Zhang wrote:
>>> Introduction of TPDM DSB subunit
>>> DSB subunit is responsible for creating a dataset element, and is also
>>> optionally responsible for packing it to fit multiple elements on a
>>> single ATB transfer if possible in the configuration. The TPDM Core
>>> Datapath requests timestamps be stored by the TPDA and then delivering
>>> ATB sized data (depending on ATB width and element size, this could
>>> be smaller or larger than a dataset element) to the ATB Mast FSM.
>>>
>>> The DSB subunit must be configured prior to enablement. This series
>>> adds support for TPDM to configure the configure DSB subunit.
>>>
>>> Once this series patches are applied properly, the new tpdm nodes for
>>> should be observed at the tpdm path /sys/bus/coresight/devices/tpdm*
>>> which supports DSB subunit.
>>> e.g.
>>> /sys/devices/platform/soc@0/69d0000.tpdm/tpdm0#ls -l | grep dsb
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_edge_ctrl_mask
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_mode
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_mask
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_ts
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_type
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_patt_val
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_mask
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_patt_val
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_ts
>>> -rw-r--r--    1 root     root      4096 Jan  1 00:01 dsb_trig_type
>>>
>>> We can use the commands are similar to the below to configure the
>>> TPDMs which support DSB subunit. Enable coresight sink first.
>>> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
>>> echo 1 > /sys/bus/coresight/devices/tpdm0/reset
>>> echo 0x3 0x3 0x1 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl_mask
>>> echo 0x6d 0x6d 0 > /sys/bus/coresight/devices/tpdm0/dsb_edge_ctrl
>>> echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_ts
>>> echo 1 > /sys/bus/coresight/devices/tpdm0/dsb_patt_type
>>> echo 0 > /sys/bus/coresight/devices/tpdm0/dsb_trig_ts
>>> echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_patt_mask
>>> echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/tpdm0/dsb_trig_patt_val
>>>
>>> This patch series depends on patch series "[PATCH v2 0/9] coresight:
>>> Fix CTI module refcount leak by making it a helper device"
>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230425143542.2305069-14-james.clark@arm.com/ 
>>>
>>
>> There is v6 available for the above and there may be changes in the data
>> structures. But the series is stable now, and may be you could cordinate
>> with James and repost the series at rc1 ?
>
> This patch series has depended on James's v6 patch series. It's a 
> description mistake.
>
> The link I posted is James's v6 patch series.
>
> Would you mind continue to review this patch series first?
>
>
> Tao
>
Hi Suzuki,


Do you have more review comments on the rest of the patches(#5-#11) in 
this series?

Or do you prefer me to update patches(#1-#4) and resubmit first?


Best,

Tao

>>
>> Suzuki
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org
