Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F36977D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjBOIPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjBOIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:15:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6236683
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:15:03 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F6EJWo023028;
        Wed, 15 Feb 2023 08:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+wPUXjC3Udfj3F/o0omCJqKZy0EOSOZMXFFX6GyxQtA=;
 b=M4R7vi30D1LqYOTxnSVH32c9f1pC6x5HRkYtnsvQRkCXm3faGw+64M28+BkM06pOHw50
 CdV75Zb49EsyHb4r3WIDij2/pgJzqYISlNn30AJ6t5UdiUQKT1QrQgr5OzN+He97Ly1H
 UPmw8F0u5VzIDMRjRiLwEBIDXkLomKSN0QcK1Q2Gw/69+5NwTZidrAJF/kgC9zQgxs0W
 LXB7CPIpJ+NNSEmt444LtlvQ6rj39uVJ+UbcbrR9KmT1qpcAVxu+VeJpISP0eGp8oWGL
 M32f3X/Wyd34vLvve+jBPeWyi1iYKGxakKBYu0hofPhbW1Rm8uOOVCNxEWPFZvab8eGZ Iw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrprs0r3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 08:14:48 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F8ElrM020504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 08:14:47 GMT
Received: from [10.213.73.166] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 15 Feb
 2023 00:14:45 -0800
Message-ID: <9f224c54-ce6b-ad8f-3716-f23c4b6f803c@quicinc.com>
Date:   Wed, 15 Feb 2023 13:44:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V1] um: Fix compilation warnings
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
 <913fea79-09f9-b976-ff1a-cd833784abb6@quicinc.com>
 <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
From:   Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
In-Reply-To: <CAMuHMdUb9cduEae2vzX8LeVG7z0nRrKHrQN6UGJ_YLuWOBbKOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: omP47rjqb4GLmIn4powJRosGOfeT2qyZ
X-Proofpoint-ORIG-GUID: omP47rjqb4GLmIn4powJRosGOfeT2qyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_04,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=937
 clxscore=1011 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150074
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greert Uytterhoeven,

On 2/15/2023 1:37 PM, Geert Uytterhoeven wrote:
> Hi Srinivasarao,
>
> On Wed, Feb 15, 2023 at 6:36 AM Srinivasarao Pathipati
> <quic_c_spathi@quicinc.com> wrote:
>> On 2/15/2023 3:27 AM, Richard Weinberger wrote:
>>> ----- Ursprüngliche Mail -----
>>>> Von: "Srinivasarao Pathipati" <quic_c_spathi@quicinc.com>
>>>> static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
>>>> {
>>>> -    struct uml_pt_regs r;
>>>> +    struct uml_pt_regs *r;
>>>>       int save_errno = errno;
>>>>
>>>> -    r.is_user = 0;
>>>> +    r = malloc(sizeof(struct uml_pt_regs));
>>> I fear this is not correct since malloc() is not async-signal safe.
>> Thanks Richard for quick response. Could you please suggest alternative
>> function of malloc() with async-signal safe.
>>
>> if that is not possible Is there any other way to fix this warning? OR
>> do we need to live with that warning?
> Does this limit actually apply to this file, which calls into the host OS?
>
> How come you even see this warning, as we have
>
>      CFLAGS_signal.o += -Wframe-larger-than=4096
>
> since commit 517f60206ee5d5f7 ("um: Increase stack frame size threshold
> for signal.c") in v5.11?
>
> Gr{oetje,eeting}s,
>
>                          Geert

We were testing this on 5.10 kernel.

We will back port this change.

Thanks

