Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6866C36AE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCUQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:14:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC35BB9C;
        Tue, 21 Mar 2023 09:14:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGDkJZ020197;
        Tue, 21 Mar 2023 16:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=STLxretgSrKorO1inoaxrMl0MOAruib27t8XQDWlDD4=;
 b=Z2IqUBmDfKxFh4ISuw13EY5Ax8yKtY1doEku0tmBmIAddgbUVJV4FcjXhTGXNIjMvxiA
 g3CeDUmt+b3qrk9mtlUAbZghTfmNmFsh6dCx+Mqpv7GW+kY2EavSBmmgsCN/JgemYywH
 PxIDK2Pcu681smO5QhAqSlTu/Rf3fNn30uPe34IeDDDhqEKomhExaWBtuVSVaXKTuYxs
 wEyVr2PlZit1FN19x/g1PehPY2Tac9ivpj4amO5RBafsgHvThlJPyLFIMgGlYO73N6u9
 +eFfN9tZ0HgbMNqj+HyO1SR32dUdX2e9662jaHX8WWrZ+i1jAWuAxwpD12etrxeQkx6g dQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfc2pru93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 16:13:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LGDde4011062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 16:13:39 GMT
Received: from [10.216.40.180] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Mar
 2023 09:13:35 -0700
Message-ID: <f48da7ea-0c09-a2fc-0ecc-55c946189fb5@quicinc.com>
Date:   Tue, 21 Mar 2023 21:43:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 6/6] pstore/ram: Register context with minidump
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <1676978713-7394-7-git-send-email-quic_mojha@quicinc.com>
 <63f7c1de.170a0220.f48b.e137@mx.google.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <63f7c1de.170a0220.f48b.e137@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: abYGF1QvqcAsn1Ielr8hihDfoxktCQwA
X-Proofpoint-GUID: abYGF1QvqcAsn1Ielr8hihDfoxktCQwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 1:13 AM, Kees Cook wrote:
> On Tue, Feb 21, 2023 at 04:55:13PM +0530, Mukesh Ojha wrote:
>> There are system which does not uses pstore directly but
>> may have the interest in the context saved by pstore.
>> Register pstore regions with minidump so that it get
>> dumped on minidump collection.
> 
> Okay, so, this is a really interesting case -- it's a RAM backend that
> is already found on a system by pstore via device tree, but there is
> _another_ RAM overlay (minidump) that would like to know more about how
> the pstore ram backend carves up the memory regions so it can examine
> them itself too. (i.e. it's another "interface" like the pstorefs.)
> 
> So we need to provide the mapping back to the overlay. It feels to me
> like the logic for this needs to live in the minidump driver itself
> (rather than in the pstore RAM backend). Specifically, it wants to know
> about all the operational frontends (dmesg, console, ftrace, pmsg) with
> their virt & phys addresses and size.
> 
> The frontends are defined via enum pstore_type_id, and the other values
> are "normal" types, so it should be possible to move this logic into
> minidump instead, leaving a simpler callback. Perhaps something like:
> 
> void pstore_region_defined(enum pstore_type_id, void *virt,
> 			   phys_addr_t phys, size_t size);
> 
> How the pstore ram backend should know to call this, though, I'm
> struggling to find a sensible way. How can it determine if the device
> tree region is actually contained by a minidump overlay?


Do you think, if qcom_minidump_ready() can be used which checks minidump 
readiness ?

-Mukesh
> 
