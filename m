Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E474A396
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGFSHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGFSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:07:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221F1986;
        Thu,  6 Jul 2023 11:07:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Hal47003323;
        Thu, 6 Jul 2023 18:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AnBk3//qqbv6jRGecm2FdBxy7OhNyDeEajuF9tJwEds=;
 b=mtHGrztW01ckZelvZg/jz2727wr5EWlt+nG8bZdvMT5G9TvX6jalxVaq3xTR2Agv9JRE
 jlLuZVS3hthkhojmy6/IoG9HJI37pvOEISy9HBdNrQWujHxD0q8DlHT1y6cZ3HT6G8Rz
 SToS99am8/nuPAbCgXDaZDYtxYJHktlqIF6UbaSx6nWYbDUa57fXXREzzW6vKpCb4XMS
 j+Jtrs6ZtBJ0GxDeURnUWZ1AVcE6UR/OtoHWI8QtmijxV1iVz6yBgYW7xvjrDFiCRy/n
 4iZGbyv39fpReOY7I4gpL0Z7b/mWDo6tQNsm3M8Zqvpo486yUimuzwqcZbXy49udVNYH 6g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn152mb92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 18:07:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366I7Akq032528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 18:07:10 GMT
Received: from [10.110.49.233] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 11:07:08 -0700
Message-ID: <9f054246-d134-25b5-75ee-ff5b4b78d8a4@quicinc.com>
Date:   Thu, 6 Jul 2023 11:07:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
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
 <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com>
 <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zfm93BmM8TzEd0B4HaqTd4YfERv3kG6E
X-Proofpoint-ORIG-GUID: Zfm93BmM8TzEd0B4HaqTd4YfERv3kG6E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_13,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060162
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2023 10:40 AM, Rob Herring wrote:
> On Mon, Jul 3, 2023 at 3:06 PM Trilok Soni <quic_tsoni@quicinc.com> wrote:
>>
>> On 7/2/2023 1:29 AM, Krzysztof Kozlowski wrote:
>>> On 30/06/2023 18:04, Mukesh Ojha wrote:
>>>>>
>>>>>> We don't add layers when they are not needed, and never when there is no
>>>>>> actual user.  If you need the extra "complexity" later, then add it
>>>>>> later when it is needed as who knows when that will ever be.
>>>>>>
>>>>>> Please redo this series based on that, thanks.
>>>>>
>>>>> My bigger issue with this whole series is what would this all look
>>>>> like if every SoC vendor upstreamed their own custom dumping
>>>>> mechanism. That would be a mess. (I have similar opinions on the
>>>>> $soc-vendor hypervisors.)
>>>
>>> Mukesh,
>>>
>>> LPC CFP is still open. There will be also Android and Kernel Debugging
>>> LPC microconference tracks. Coming with a unified solution could be a
>>> great topic for LPC. Solutions targeting only one user are quite often
>>> frowned upon.
>>
>> LPC is far out and in November. Can we not have others speak up if they
>> have the similar solution now? We can expand this to linux-kernel and
>> ask for the other SOC vendors to chime in. I am sure that we may have
>> existing solutions which came in for the one user first like Intel RDT
>> if I remember. I am sure ARM MPAM usecase was present at that time but
>> Intel RDT based solution which was x86 specific but accepted.
> 
> RDT predated MPAM. resctrl is the kernel feature, and it supports
> Intel and AMD which are not identical. resctrl is being (extensively)
> refactored to add in MPAM support.
> 
> You are not the first here like Intel RDT, so I fail to see the
> parallel with minidump. We have an existing logging to persistent
> storage mechanism which is pstore. You should integrate into that
> rather than grafting something on to the side or underneath.
> 

Mukesh will chime in once he looks at the hwtracing suggested by Linus W 
and see if it fits. Mukesh seems have already looked at pstore and 
discussions/patches are there w/ pstore logic I believe, but it is okay 
if they are not perfect if we are still not decided on the right 
framework. Best to decide if the existing frameworks fits or not or we 
need to create the new one.

I would still prefer if other SOC vendors chime in here, since I am sure 
in the Mobile and Embedded world various SOCs may have requirements to 
get specific portion of the ramdump only for the quick analysis and 
meeting the storage requirements on the device for its collection.

As mentioned on another patch, we are fine the submit abstract at LPC 
debug MC, but I would like the framework discussion to continue so that 
we can decide during the LPC that either existing frameworks fits the 
needs or they need to be extended or new fwk is needed.

---Trilok Soni
