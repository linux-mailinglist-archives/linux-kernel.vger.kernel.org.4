Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEC6E67ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjDRPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDRPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:20:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166B83C3;
        Tue, 18 Apr 2023 08:20:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IAYOFv021374;
        Tue, 18 Apr 2023 15:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/HohYFfTG1GLIaax09t4Ld6q7yqW2itdIzPMwPQ9NhQ=;
 b=b+Re9FgVp60KfU03U2T/p+/krDkUitTeEbyF9UFtJdf1M4WT0XookgKO0y1o0V6B4k+r
 m+It09ONtDYwaqo7XCoV1s4bnU3cptlJ07fK/pSNXBP5quoyBxZjhs01asqtTPRPl5n5
 WauGsvFRB0m9gOuSF9NDrmWKaaVl77IWB9Q2WPspsG78UWtU5Kq8UJEbq7x0h3M2rmqZ
 WThPAte5ufx0P9VOseThE2WHRTeIzhqvanSSkaeNZ2S0R3aGNdTZSIJm1P5kub6hHOiN
 GPrVuU6q0KpzMP7HxU3vnrrCGJdALOVsv9C25tWJtSNTPDt+1Nvr2mYEHiOBt06FK/B9 gA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1bvktamf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:19:59 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IFJwLn027373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:19:58 GMT
Received: from [10.216.30.222] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 08:19:52 -0700
Message-ID: <55d3dc01-8909-db69-fbac-60e7636febdc@quicinc.com>
Date:   Tue, 18 Apr 2023 20:49:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, Brian Masney <bmasney@redhat.com>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-4-git-send-email-quic_mojha@quicinc.com>
 <24ec8534-60a4-b308-0831-9ab6b983d902@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <24ec8534-60a4-b308-0831-9ab6b983d902@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sBHGT8gEIQSbCfnAzUf88VmV45l7x24b
X-Proofpoint-ORIG-GUID: sBHGT8gEIQSbCfnAzUf88VmV45l7x24b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=620 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180131
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+@Brian

On 4/14/2023 4:01 AM, Srinivas Kandagatla wrote:
> 
> 
> On 22/03/2023 13:30, Mukesh Ojha wrote:
>> +Dump collection
>> +---------------
>> +
>> +The solution supports extracting the minidump produced either over 
>> USB or
>> +stored to an attached storage device.
>> +
>> +By default, dumps are downloaded via USB to the attached x86_64 machine
>> +running PCAT (Qualcomm tool) software. Upon download, we will see
> 
> Are these both PCAT and dexter tools public?

I think, PCAT comes as part of Qcom Package Kit.

Last time, I checked with @Brian, he was saying the they use PCAT 
software tool running on x86_64 machine attached to QCOM device to
get the dump(via USB) out of the device.

Dexter.exe seems private tool, that only requires if we use storage
(via ufs/emmc) to save minidump on the target device itself and later 
use adb to pull out the rawdump partition dump and pass it through
dexter to convert it to same binary blobs which we got directly through
PCAT.

I don't at least have any way to avoid dexter tool at the moment.
However, i will think if we can develop any script which does the
same.

-- Mukesh

> 
> --srini
>> +a set of binary blobs starts with name md_* in PCAT configured directory
>> +in x86_64 machine, so for above example from the client it will be
>> +md_REGION_A.BIN. This binary blob depends on region content to determine
>> +whether it needs external parser support to get the content of the 
>> region,
>> +so for simple plain ASCII text we don't need any parsing and the content
>> +can be seen just opening the binary file.
>> +
>> +To collect the dump to attached storage type, one need to write 
>> appropriate
>> +value to IMEM register, in that case dumps are collected in rawdump
>> +partition on the target device itself.
>> +
>> +One need to read the entire rawdump partition and pull out content to
>> +save it onto the attached x86_64 machine over USB. Later, this rawdump
>> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
>> +this into the similar binary blobs which we have got it when download 
>> type
>> +was set to USB i.e a set of registered region as blobs and their name
>> +starts with md_*.
>> -- 2.7.4
