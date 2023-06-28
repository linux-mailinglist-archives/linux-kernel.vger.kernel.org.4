Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD147414D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjF1PXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:23:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:29278 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbjF1PXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:23:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SEboS8032604;
        Wed, 28 Jun 2023 15:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WFkKKkqtyqaZFCoepnWbsAmdxJT8uhDZrVsVu73pAn8=;
 b=PpDvGt6bBkXi6ENnBU9PxLr4o/Js+whE8hX+6ViJxiBV6iFehCdMer9vAeYtApyD4O0u
 indt7vGInUxJ74kfAQWsHhpuHBN3e1aRvtCYvXwN02zOzSTl8tIBGn+S8dHRFkjfzcCv
 maeVF726Ny/hXit72YBtIS4iGG8oHhcfJGsSrFZy9vcpAqEMxMc3z/ccNFWEjpbrsWyq
 tMiN/hcdY/JIZVzFjgz5zBoP858ZKTup0pCYhlF8ahTLKCZzqO31zYJG0TNPvZnoSU8M
 2KIV5DLw0j+me7Q674XP2GyZwfuN861dsi7EClb3h2ZCfBAH0sve8fXtRwf+Ueh8IfI6 sQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgexthah8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:23:11 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SFNBOM008369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 15:23:11 GMT
Received: from [10.216.26.159] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 28 Jun
 2023 08:23:01 -0700
Message-ID: <86c104a6-a685-4d05-08f4-e1be595f9d31@quicinc.com>
Date:   Wed, 28 Jun 2023 20:52:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/21] kallsyms: Export kallsyms_lookup_name
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-3-git-send-email-quic_mojha@quicinc.com>
 <a26f22d2-95a7-4143-bff5-45ef0b53b30b@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <a26f22d2-95a7-4143-bff5-45ef0b53b30b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xhyixVggvep4Hpw--p5GRvSXPJDLqlTn
X-Proofpoint-GUID: xhyixVggvep4Hpw--p5GRvSXPJDLqlTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=870 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 7:23 PM, Pavan Kondeti wrote:
> On Wed, Jun 28, 2023 at 06:04:29PM +0530, Mukesh Ojha wrote:
>> Module like minidump providing debugging support will need to
>> get the symbol information from the core kernel e.g to get
>> the linux_banner, kernel section addresses bss, data, ro etc.
>>
> One might ask why we would need such a debug driver to
> be compiled as module? What would you do if we need to capture more
> kernel data structures later? Do you plan to continue use
> kallsyms_lookup_name() to query all the symbols?

You are on point, i needed this driver to be static but i don't have
any example at present to collect more than just _linux_banner_ from
my existing set of patches..

Agree, it will be easier to make this driver as static instead of
opening up the doors for modules to abuse via exporting
kallsyms_lookup_name() and also it will be very slow for production
kernel uses.

> 
> I have seen v3 discussion where you are asked to compile this driver
> as module but that time there was no reason why your driver needs to
> be compiled as statically, now you have a reason (linux_banner) for
> it.

Yes, at present minidump driver will not be able to compile without
exporting kallsyms_lookup_name()

-Mukesh

> 
>> commit 0bd476e6c671 ("kallsyms: unexport kallsyms_lookup_name()
>>   and kallsyms_on_each_symbol()") unexports kallsyms_lookup_name
>> due to lack of in-tree user of the symbol. Now, that minidump
>> will one of its user, export it.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> Thanks,
> Pavan
