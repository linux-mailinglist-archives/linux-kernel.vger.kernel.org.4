Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B791C7464A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGCVG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:06:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FAE59;
        Mon,  3 Jul 2023 14:06:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363KkklH015899;
        Mon, 3 Jul 2023 21:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kf6a8f2zayKx9LTfaLSkoGTGTiIxgMuV5IPvELMWJQ4=;
 b=Y32lhCdsHualNtkQYtskbVgQ8iR34tiZd70U/wTcVT15B6fbh+jzd/7FdEP63oLabR9s
 RTIUm8NjzabsOQP7Hp2SgiQkLuH43Y91sx5PhaASmCImp3OYtjC2CfTf15Z2aqguH/s2
 NpQeR4i0p+YJ5xzqFviKXBht4UNWd1zv6nUL/tY4IUDFIpoMtx/vGje0f2FdH6NTfj4k
 YH0j5ilYCVcvp0YEcs1I3Sx5iplHPRln3Fia3HB1PwKtzGN5NcWzU5UaB5YtCy3zVsS/
 YEDyJ/o/ypB+smeQJh3BKywwshPmUkoyLwppD/AXw2gfDPq9pl/ixzgBj90/sDe8kHFG xw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rkwyfh0ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 21:06:00 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 363L5xAY020569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 21:05:59 GMT
Received: from [10.110.23.29] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Mon, 3 Jul 2023
 14:05:58 -0700
Message-ID: <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com>
Date:   Mon, 3 Jul 2023 14:05:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, Alex Elder <elder@linaro.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com>
 <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xPPByBNK4qpXUqaj3eMFPyXF3yEyeyp0
X-Proofpoint-GUID: xPPByBNK4qpXUqaj3eMFPyXF3yEyeyp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=802
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030193
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2023 1:29 AM, Krzysztof Kozlowski wrote:
> On 30/06/2023 18:04, Mukesh Ojha wrote:
>>>
>>>> We don't add layers when they are not needed, and never when there is no
>>>> actual user.  If you need the extra "complexity" later, then add it
>>>> later when it is needed as who knows when that will ever be.
>>>>
>>>> Please redo this series based on that, thanks.
>>>
>>> My bigger issue with this whole series is what would this all look
>>> like if every SoC vendor upstreamed their own custom dumping
>>> mechanism. That would be a mess. (I have similar opinions on the
>>> $soc-vendor hypervisors.)
> 
> Mukesh,
> 
> LPC CFP is still open. There will be also Android and Kernel Debugging
> LPC microconference tracks. Coming with a unified solution could be a
> great topic for LPC. Solutions targeting only one user are quite often
> frowned upon.

LPC is far out and in November. Can we not have others speak up if they 
have the similar solution now? We can expand this to linux-kernel and 
ask for the other SOC vendors to chime in. I am sure that we may have 
existing solutions which came in for the one user first like Intel RDT 
if I remember. I am sure ARM MPAM usecase was present at that time but 
Intel RDT based solution which was x86 specific but accepted.

---Trilok Soni
