Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196EE748A89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjGERcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGERcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:32:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25D4199D;
        Wed,  5 Jul 2023 10:31:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3658VZdo020618;
        Wed, 5 Jul 2023 17:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MlX/UZ0ZXE/72U2AV0V88Yyf3NKh+5tvQkq5oSMpx9E=;
 b=oEsYD/vvDJx9I16U5GmklPgKbnTHKeZMkb2tJer354sH217R0zTqquJ53M+OqPzsf2JZ
 26hjQhgAyVBxQ+kkGociceDG2sxd+2HdTMFPf3apSBaqmmHMRnaikxoYD58y/QY0byrt
 rr2dPVHfrckS93szwrh9M0av/93juQes52/Liqj6XVTFZAMt0+Pb0WR5kaeJaNJglwJK
 DdOa6n07F73z9fH2EeRNH0o0yeUIWOdtQnp1KIzaiQlPFSR9VmjvZOD6UDECrACP896y
 e2Fypy4iSXxGMA6sPbidN8TOJjpYVtXUqFulpihlHX7qiExvdB50F/hNAjwUCgMw8PLZ lw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmhf13myy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 17:29:57 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365HTu6b015191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 17:29:56 GMT
Received: from [10.110.49.233] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 10:29:55 -0700
Message-ID: <355de4c7-180d-4edd-b6fd-9c8e29e40e42@quicinc.com>
Date:   Wed, 5 Jul 2023 10:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related
 support
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh>
 <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <CACRpkda3CJ7G4-wDPkWmzg6nyCoEfG+u2cQH6KXWNjbftd90ow@mail.gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CACRpkda3CJ7G4-wDPkWmzg6nyCoEfG+u2cQH6KXWNjbftd90ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VZW6qNveH1EguEh4PjOv0RhaMztUvQ2V
X-Proofpoint-ORIG-GUID: VZW6qNveH1EguEh4PjOv0RhaMztUvQ2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050159
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2023 2:27 AM, Linus Walleij wrote:
> On Thu, Jun 29, 2023 at 1:12 AM Rob Herring <robh+dt@kernel.org> wrote:
> 
>> My bigger issue with this whole series is what would this all look
>> like if every SoC vendor upstreamed their own custom dumping
>> mechanism. That would be a mess. (I have similar opinions on the
>> $soc-vendor hypervisors.)
> 
> I agree with Rob's stance.
> 
> I think it would be useful to get input from the hwtracing developers
> (Alexander and Mathieu) who faced this "necessarily different" issue
> with all the hwtrace mechanisms and found a way out of it. I suspect
> they can have an idea of how this should be abstracted.

Any mailing list you suggest we expand to so that we get inputs from the 
hwtracing developers and maintainers or just look into the MAINTAINERS 
file and start an email thread?

We are fine to submit the abstract for the LPC in next two weeks, but 
prefer to have lot of good discussion before it on the mailing list, so 
that we have code to talk about in LPC.

---Trilok Soni
