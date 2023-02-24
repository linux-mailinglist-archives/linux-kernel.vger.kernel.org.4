Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334B6A1A31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBXK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjBXKZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:25:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C649457CD;
        Fri, 24 Feb 2023 02:25:07 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O4JEks002948;
        Fri, 24 Feb 2023 10:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W7eS4v+eK0DlCcuv0cz4po0QefEREJU4tt2j0IBhEds=;
 b=U8K1b1UYvFrRBFPacdtJ/Cvguoo2iEPirkUHQXMd6ubk25NjXAW14nHtkD7uSRQt6HRc
 PeH9xq/kUsVn+JWzeRlHXOceNdxE4FzmuaFql0A/l9FLravXGNsRZhUajeqwU/SgVnIk
 B3EJZ6blZAocGzqXWlPPmnprDQMauzTE/60bw494rRozgGO+nGQEE+Rb1SZ1y0utvLh6
 HslmxLK3cCxyvE/BkyeDGYh7Zlpev6KOBHzpYJf8ATH5ADwcu/2RDobHkBt06AFL9uUM
 H6D8bI4gdMnriX52cT5bZOJe2lb1/+oHKIJiGN9fnj53qUpYNZj14hil3rG98EBoNPiW Ig== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy8m47ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:23:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OANL2s004517
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:23:21 GMT
Received: from [10.216.22.47] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Feb
 2023 02:23:17 -0800
Message-ID: <cf859951-cecd-79a0-722d-8cee57ba18c9@quicinc.com>
Date:   Fri, 24 Feb 2023 15:53:07 +0530
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i3k-DWDJFrB0DCU7Xti1zEPhXBVs4rER
X-Proofpoint-ORIG-GUID: i3k-DWDJFrB0DCU7Xti1zEPhXBVs4rER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240085
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kees for checking into this.

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

It is not exactly like pstorefs where we can mount and check the logs in 
next boot.

This interface needs physical address and size of the region to be 
conveyed to the boot firmware via the minidump registration and firmware 
will dump this region as a blob out of the device on device crash.
Blobs can be either plain text like console logs or some thing which
needs parser for that reason virtual address is required.

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
Thanks, i will check on this.

> 
> How the pstore ram backend should know to call this, though, I'm
> struggling to find a sensible way. How can it determine if the device
> tree region is actually contained by a minidump overlay?

I agree, pstore will not have any awareness about minidump adding 
something inside pstore does not look good if it can provide API which
provide this information.

One more thing, since minidump is also one of the user of pstore in this
case and it may not need the fixed ram addresses to be mentioned in the 
carve out.

Do you think this can be accepted or if not any suggestion

https://lore.kernel.org/lkml/1675330081-15029-2-git-send-email-quic_mojha@quicinc.com/


-Mukesh
> 
