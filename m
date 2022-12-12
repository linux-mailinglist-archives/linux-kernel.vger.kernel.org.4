Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90464A23D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiLLNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiLLNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:51:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343A1648C;
        Mon, 12 Dec 2022 05:50:27 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCD6WYf020215;
        Mon, 12 Dec 2022 13:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KBr2nujL/8WgecDyy2hO8xRFUeux4gt+CP0RVpGPESg=;
 b=DnRcaVdMpRKuuhSLsi0/9uhxNG2YoUHMBi8H3POFMK9R0TQnQs3h5dDqymOfLUP+5bq7
 OALuv2Hsc5VUZ982BbzBLk883X2ZF/kBbkx61b7eSd+OlZ/A62AHDXSyQOe882UxMwAQ
 GBHhk0txiCV6yYuBZo6prCNZUsEugZWIa37QGWnNm7tyfxvQcPjCf5gn7/ZRUc7zkoH+
 a1gkC6FT69tGgKc4qBHhP/CUkdbnkvAZKL6Dg14gCeVCpRJGOe0nr3pv9RteSs/NMRa8
 R/PgqYmVNLeGOZinvuzNsmjklPCTdFdB+9q5GMrNH7pn/OvTD9/cKm4N/385hCitORG9 Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mchesc8rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 13:49:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BCDng9V019327
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 13:49:42 GMT
Received: from [10.216.26.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 05:49:34 -0800
Message-ID: <60034623-a681-4398-fe19-660006245e3b@quicinc.com>
Date:   Mon, 12 Dec 2022 19:19:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] remoteproc: elf_loader: Update resource table name check
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <bgoswami@quicinc.com>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <krzysztof.kozlowski@linaro.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n520=mjdc4H1m8au0iBo2qEeaL8OrF1HCP0bXORe2Wa_7w@mail.gmail.com>
 <ec403926-24ef-947d-2a1c-6cbf0e31ab89@quicinc.com>
 <CAE-0n50VYGNF_rGzyb_2Jd8dY8cFx3BeOw0s-ywELkRqEEig4g@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n50VYGNF_rGzyb_2Jd8dY8cFx3BeOw0s-ywELkRqEEig4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _9CkMgZBuPbRZETnGVxJhFgF7dIGtIlc
X-Proofpoint-GUID: _9CkMgZBuPbRZETnGVxJhFgF7dIGtIlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2022 2:22 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-12-08 05:40:54)
>> On 12/7/2022 7:25 AM, Stephen Boyd wrote:
>> Thanks for Your Time Stephen!!!
>>> Quoting Srinivasa Rao Mandadapu (2022-12-01 04:20:48)
>>>> Update resource table name check with sub string search instead of
>>>> complete string search.
>>>> In general Qualcomm binary contains, section header name
>>>> (e.g. .resource_table), amended with extra string to differentiate
>>>> with other sections.
>>>> So far Android adsp binaries are being authenticated using TZ,
>>>> hence this mismatch hasn't created any problem.
>>>> In recent developments, ADSP binary is being used in Chrome based
>>>> platforms, which doesn't have TZ path, hence resource table is
>>>> required for memory sandboxing.
>>>>
>>> Does this need a Fixes tag?
>> I don't think so. I feel It's kind of enhancement.
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> ---
>>>>    drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
>>>> index 5a412d7..0feb120 100644
>>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>>>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
>>>>                   u64 offset = elf_shdr_get_sh_offset(class, shdr);
>>>>                   u32 name = elf_shdr_get_sh_name(class, shdr);
>>>>
>>>> -               if (strcmp(name_table + name, ".resource_table"))
>>>> +               if (!strstr(name_table + name, ".resource_table"))
>>> Was the strcmp not working before because the 'name_table' has something
>>> else in it? It really looks like your elf file is malformed.
>> Actually, DSP binary is prepared by combining different elfs. So Section
>> header names are appended with
>>
>> something else to distinguish same section name of different elfs, by
>> using some Qualcomm specific QURT scripts.
>> Hence final binary contains resource_table name appended with module
>> specific name.
>>
>> So this patch is required to handle such modified name.
>>
> Can you clarify how the section header name looks? Probably you can
> objdump the section here and provide that information to help us
> understand.

Here is the Section header info.

$ readelf -SW bootimage_relocflag_kodiak.adsp.prodQ.pbn
There are 65 section headers, starting at offset 0x434:
readelf: Error: File contains multiple dynamic symbol tables

Section Headers:
   [Nr] Name              Type
   [ 0]                   NULL
   [ 1] .shstrtab         STRTAB
   [ 2] .text.ukernel.island PROGBITS
   [ 3] .data.ukernel.island PROGBITS
   [ 4] .qskernel_exports.island PROGBITS
   [ 5] .start            PROGBITS
   [ 6] .qskernel_main    PROGBITS
   [ 7] .qskernel_rest    PROGBITS
   [ 8] .comment          PROGBITS
   [ 9] .data.common.island PROGBITS
   [10] .rodata.common.island PROGBITS
   [11] .data.va.island   NOBITS
   [12] .rodata.va.island PROGBITS
   [13] .text.common.island PROGBITS
   [14] .text.va.island   PROGBITS
   [15] .start            PROGBITS
   [16] .ukernel.main     PROGBITS
   [17] .init             PROGBITS
   [18] .text             PROGBITS
   [19] .fini             PROGBITS
   [20] .interp           PROGBITS
   [21] .hash             HASH
   [22] .dynsym           DYNSYM
   [23] .dynstr           STRTAB
   [24] .rodata           PROGBITS
   [25] .eh_frame         PROGBITS
   [26] .ctors            PROGBITS
   [27] .dtors            PROGBITS
   [28] .dynamic          DYNAMIC
   [29] .data             PROGBITS
   [30] .bss              NOBITS
   [31] .sdata            PROGBITS
   [32] QSR_STRING        PROGBITS
   [33] .comment          PROGBITS
   [34] .tcm_island.audio_process PROGBITS
   [35] .data.common.island.audio_process PROGBITS
   [36] .rodata.common.island.audio_process PROGBITS
   [37] .data.va.island.audio_process PROGBITS
   [38] .rodata.va.island.audio_process PROGBITS
   [39] .text.common.island.audio_process PROGBITS
   [40] .text.va.island.audio_process PROGBITS
   [41] .start.audio_process PROGBITS
   [42] .init.audio_process PROGBITS
   [43] .text.audio_process PROGBITS
   [44] .fini.audio_process PROGBITS
   [45] .interp.audio_process PROGBITS
   [46] .hash.audio_process HASH
   [47] .dynsym.audio_process DYNSYM
   [48] .dynstr.audio_process STRTAB
   [49] .rodata.audio_process PROGBITS
   [50] .eh_frame.audio_process PROGBITS
   [51] .ctors.audio_process PROGBITS
   [52] .dtors.audio_process PROGBITS
   [53] .data.rel.ro.audio_process PROGBITS
   [54] .dynamic.audio_process DYNAMIC
   [55] .data.audio_process PROGBITS
   [56] .bss.audio_process NOBITS
   [57] .sdata.audio_process PROGBITS
   [58] QSR_STRING.audio_process PROGBITS
   [59] .comment.audio_process PROGBITS
   [60] .start.ac_bin_process PROGBITS
   [61] .resource_table.ac_bin_process PROGBITS
   [62] .comment.ac_bin_process PROGBITS

>
> I think remoteproc_elf_loader.c assumes the ELF file is properly formed.
> There should be a section named '.resource_table', so the strcmp will
> find it by looking at the section header names.
