Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304F6E2925
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDNRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDNRSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:18:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD93A9C;
        Fri, 14 Apr 2023 10:18:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGgm5P031366;
        Fri, 14 Apr 2023 17:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PHnCsKlX2VKhgBwGvCNwM50VyEkwpSDcgXFOlOFMHv0=;
 b=A/rTOjNtZ3dtrQdZrIwBIBv3Wv3b5E2SHJyJjH7A3zfWcM+6+KVpoPc+bVcZgwOE4oda
 +94kxeUKJp06uDiujg2Mdd2zxWattjPbwv2jxwHtgOZ5OJLzcxGRznYLaRjct0cyscHI
 Swt/NmzlsgPat5nEA3ACDOfXFW7tsVDFDaXBWRvX+eHXrbIJPss4kh+aVeDZ03MkqHwi
 2BF0Ln9Uwy3O/a12NhHqVFUIKuleHD5o5EUrzf0AjKCHSz5bbvZXbZSQwhshT4aDLngC
 B7OT24RvrvLO7604s52ITj2NSCpn2XKwRshC081eZirHfATnzbFeSv3d7ZwqB4bzXaWB mg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxe66kngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:17:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EHHmam011887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:17:48 GMT
Received: from [10.110.60.111] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 10:17:47 -0700
Message-ID: <85b92732-5310-92ed-0d33-458dec906495@quicinc.com>
Date:   Fri, 14 Apr 2023 10:17:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?WWktRGUgV3UgKOWQs+S4gOW+tyk=?= <Yi-De.Wu@mediatek.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?= 
        <Yingshiuan.Pan@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TVkgQ2h1YW5nICjojormmI7ouo0p?= <MY.Chuang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?UGVpTHVuIFN1ZWkgKOmai+WfueWAqyk=?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?B?SmFkZXMgU2hpaCAo5pa95ZCR546oKQ==?= 
        <jades.shih@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U2hhd24gSHNpYW8gKOiVreW/l+elpSk=?= 
        <shawn.hsiao@mediatek.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= 
        <Ze-yu.Wang@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
 <20230413090735.4182-4-yi-de.wu@mediatek.com>
 <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
 <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
 <533a1a9b653cf63f1e5df7f95d1b23902809561d.camel@mediatek.com>
 <7256414b-5553-e025-334f-b8df48f40c31@linaro.org>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <7256414b-5553-e025-334f-b8df48f40c31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wqjVgE8LIVOZn6RtkiAIA6zkpNIZCase
X-Proofpoint-ORIG-GUID: wqjVgE8LIVOZn6RtkiAIA6zkpNIZCase
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140152
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2023 1:51 AM, Krzysztof Kozlowski wrote:
> On 14/04/2023 10:43, Yi-De Wu (吳一德) wrote:
>> On Thu, 2023-04-13 at 19:08 +0200, Matthias Brugger wrote:
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>
>>>
>>> On 13/04/2023 14:55, Krzysztof Kozlowski wrote:
>>>> On 13/04/2023 11:07, Yi-De Wu wrote:
>>>>> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>>>>>
>>>>> GenieZone is MediaTek proprietary hypervisor solution, and it is
>>>>> running
>>>>> in EL2 stand alone as a type-I hypervisor. This patch exports a
>>>>> set of
>>>>> ioctl interfaces for userspace VMM (e.g., crosvm) to operate
>>>>> guest VMs
>>>>> lifecycle (creation, running, and destroy) on GenieZone.
>>>>>
>>>>> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
>>>>> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
>>>>> ---
>>>>>    arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++++
>>>>>    drivers/soc/mediatek/Kconfig                  |   2 +
>>>>>    drivers/soc/mediatek/Makefile                 |   1 +
>>>>>    drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
>>>>
>>>> Hypervisor drivers do not go to soc. Stop shoving there everything
>>>> from
>>>> your downstream. Find appropriate directory, e.g. maybe
>>>> drivers/virt.
>>>
>>> Acked, what is the reason you want to add this to drivers/soc instead
>>> of
>>> drivers/virt?
>>>
>>> Regards,
>>> Matthias
>>>
>> Noted. We would take your advice and move it from
>> drivers/soc/mediatek/virt to /drivers/virt on next version.
>>
>> The reason we put it under our soc/ is that the drver is highly
>> propietary for mediatek's product and for aarch64 only. Maybe it's not
>> general enough to put in under /drivers/virt.
> 
> If virt folks reject the driver, because it is highly proprietary, then
> it is not suitable for soc/mediatek either.
> 
> Your argument is actually not helping you. It's rather a proof that this
> driver might not be suitable for Linux kernel at all.
> 
>>
> https://android-review.googlesource.com/c/kernel/common/+/2447547/1..2/drivers/virt/geniezone/gzvm.h#b91
> 
> I don't see there anything suggesting moving to soc/mediatek. Comment
> from Trilok (+Cc) suggests that your code is simply not portable. Write
> code which is portable and properly organized.

Thanks for the CC. I don't know how different these patches are from the 
ACK post, but if they are similar then I am surprised that patches of 
that state are posted here since they will need lot of work to get it 
reviewed here.

Also, do you plan to open-source your hypervisor? I am not sure if that 
is the requirement but it will be good to know if some version of your 
Hypervisor is open-sourced or you have plan for that.

---Trilok Soni

