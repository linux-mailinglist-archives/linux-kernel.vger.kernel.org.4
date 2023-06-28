Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D0741488
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjF1PFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:05:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:24504 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231886AbjF1PFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:05:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBrfTn007823;
        Wed, 28 Jun 2023 15:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OzLkR4S+T/Lq/RWUNFp92amr0KMTeZqRJceBBbmWwgc=;
 b=KOkj6Fwm61bhxNPBSSQ7haG8kPWLbTdMoqlOve4T2Y1Z3qmLDSEyLsOohyqL+j+1eErC
 KWDJZvdXHn8AvVw0U6k1Ahdq5Et4Mxjepmz622XN8JS3trRzMngXrPP/wDzSL+9QXD8C
 k5gpla27YSwCwNeuvFrl8N4SRP5PYh9dBt7Pvm7El0QbfBaO22PjfMaDoi/0bD5U9vIb
 Cnu8HWsxYOFCTVRmRNF1gk6/1PB1aq+0d8M3VN55v9IqH0ZXCUrHrkZZuYjJGzQihArP
 381xl5ZS/wCaOwDuvXas1XRbs1PJu+xN/gLU7p9XKUownZUmpy/uwRlZbzmrayu+ZObV RQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb1t9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:05:06 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SF55kE003112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:05:05 GMT
Received: from [10.216.26.159] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 28 Jun
 2023 08:04:57 -0700
Message-ID: <3f29c981-be84-99dd-7e5c-84ac32792c1f@quicinc.com>
Date:   Wed, 28 Jun 2023 20:34:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
 <CAHp75Vcu6_Gr6Y8ThzOZdC34-sxOx9esYhpS2p22rAWjwv5Bkg@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAHp75Vcu6_Gr6Y8ThzOZdC34-sxOx9esYhpS2p22rAWjwv5Bkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jnLRn8fp110S0Jt2xc2g4BloN4Ej1wEc
X-Proofpoint-ORIG-GUID: jnLRn8fp110S0Jt2xc2g4BloN4Ej1wEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=888 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 6:54 PM, Andy Shevchenko wrote:
> On Wed, Jun 28, 2023 at 3:35 PM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Module like minidump providing debugging support will need to
>> get the symbol information from the core kernel e.g to get
>> the linux_banner, kernel section addresses bss, data, ro etc.
>>
>> commit 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name()
> 
> Commit
> 
>>   and kallsyms_on_each_symbol()") unexports kallsyms_lookup_name
>> due to lack of in-tree user of the symbol. Now, that minidump
>> will one of its user, export it.
> 
> users
> 
> ...
> 
> Is it a direct revert? Then make it visible by leaving pieces from `git revert`.
> 

No, it is not direct revert..

> ...
> 
>> -
> 
> If not, drop this stray change.

ok

- Mukesh
> 
>> +EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
> 
> 
