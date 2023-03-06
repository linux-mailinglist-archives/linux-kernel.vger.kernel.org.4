Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97C6ACC66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCFSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:23:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF359C7;
        Mon,  6 Mar 2023 10:22:55 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326DnQVb004336;
        Mon, 6 Mar 2023 16:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u+HeMWCnDL/51+TscHscVQEY/G74ehiDJ2aQmcF8ul8=;
 b=E9umlb3amdCqPwuBfvXhDkM2TEQoA+Txr25Jo1FN1uk0NO8jnfb3VdXMGszPeeLwh9XT
 TyD9jAb5UBBnrNCPzDwPXN+8MLzMNYfckEqhbQW4B2bSkFAHoquEIlmAwMi1kTjE321U
 O4FFZb/lmNNfpWApFrj+lXCKz37quB7KcAEPgVADJtq2S6KVvFEmHBEtkgx/tAaeM5yi
 vzdAREK9OnG2s5AhFnmELOL3zMiJZY6qd+uJ13fp4iGY98mORsedR75rxmj70wsJZNTh
 d5RidTDe5HGtXA1elfBxZa7Jij3XbPUYKMyfJFIqYRc4x+KGeIRqr5Jna1fWO1q+ENvT gQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p417jwep8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 16:56:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326GuCJB024582
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 16:56:12 GMT
Received: from [10.110.111.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 08:56:11 -0800
Message-ID: <186dd23e-765f-584f-11e1-84b27f728abe@quicinc.com>
Date:   Mon, 6 Mar 2023 08:56:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   John Moon <quic_johmoo@quicinc.com>
Subject: Re: [PATCH v2 2/2] docs: dev-tools: Add UAPI checker documentation
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <20230301075402.4578-3-quic_johmoo@quicinc.com>
 <CAK7LNAQUgr0rrJv8ZvPKfyC8zZ1XX-Wv2Npw4iJXDGor=HSKyQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAK7LNAQUgr0rrJv8ZvPKfyC8zZ1XX-Wv2Npw4iJXDGor=HSKyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A28HIHph3bEw3GIf7i0LrYogXJ86bcJ2
X-Proofpoint-ORIG-GUID: A28HIHph3bEw3GIf7i0LrYogXJ86bcJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=823 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/2023 10:20 PM, Masahiro Yamada wrote:
> On Wed, Mar 1, 2023 at 4:54 PM John Moon <quic_johmoo@quicinc.com> wrote:
>>
>> Add detailed documentation for scripts/check-uapi.sh.
>> ---
>>   Documentation/dev-tools/checkuapi.rst | 258 ++++++++++++++++++++++++++
>>   Documentation/dev-tools/index.rst     |   1 +
>>   2 files changed, 259 insertions(+)
>>   create mode 100644 Documentation/dev-tools/checkuapi.rst
>>
>> diff --git a/Documentation/dev-tools/checkuapi.rst b/Documentation/dev-tools/checkuapi.rst
>> new file mode 100644
>> index 000000000000..2255066658e3
>> --- /dev/null
>> +++ b/Documentation/dev-tools/checkuapi.rst
>> @@ -0,0 +1,258 @@
>> +.. SPDX-License-Identifier: GPL-2.0-only
>> +
>> +============
>> +UAPI Checker
>> +============
>> +
>> +The UAPI checker (scripts/check-uapi.sh) is a shell script which checks UAPI
>> +header files for userspace backwards-compatibility across the git tree.
>> +
>> +The script can produce false positives in some cases, so developers are
> 
> 
> and false negatives too.
> 

Yes, I'll expand the notes to include examples of false negatives in v3.
