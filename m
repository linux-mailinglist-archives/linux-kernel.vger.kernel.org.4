Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34C5FA2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJJR3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJJR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:29:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A6E95
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:29:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AGdcAp020104;
        Mon, 10 Oct 2022 17:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=RR+rZWydssfivVKmDxVVu22FUk3nGmiN5dKRjkPf/nw=;
 b=RYh9Vg3UHdL1zwBneonVAPmX+cG28C4LmmC7SWzEjHiieAt53Vq5vG2CPi7R2OAj6103
 5hU1A1X6me40bJlcGCT4vrnjU0NY9fw3uq2Wa8/McT7XrpnK8DtD7X1IVKo+DIwuzBsA
 AC1xjRVdJyhBxu/yS80QMSGF40Q2A771Ze1jKcZTPO4JHuK9RyK9ZJ4kBBWFENHsRMGu
 VST05jzmjngd1ABr4qahQMFWWM/sRG1Wnw/d57JjBvHc+X1eHJ4QO+rr0WNDghlav4nl
 XbIBsG2OnROh9panXY3+R6R+hRAj9J5zIngy9M414d31qWCVaC32fDgIxjREK+gP8OGS jA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k32gemw83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 17:29:35 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29AHLn3d001373;
        Mon, 10 Oct 2022 17:29:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3k3jqa2mdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 17:29:34 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29AHTY36012611;
        Mon, 10 Oct 2022 17:29:34 GMT
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 29AHTYU2012610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 17:29:34 +0000
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:29:33 -0700
Date:   Mon, 10 Oct 2022 10:29:32 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Tom Rix <trix@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
        "Elliot Berman" <quic_eberman@quicinc.com>, <llvm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <matt@codeconstruct.com.au>,
        David Howells <dhowells@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <jackm@dev.mellanox.co.il>
Subject: Re: [PATCH 2/2] scripts/clang-tools: Remove
 core.uninitialized.Assign check
Message-ID: <20221010172932.GA16534@quicinc.com>
References: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
 <edc9712e479c433471a5c6b14d3e7ede9c228f5c.1665026261.git.quic_gurus@quicinc.com>
 <CAKwvOdm9fOEEQ9cYud7U16Zgd+uahM6Gnv+evoQPjfOc13gZEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKwvOdm9fOEEQ9cYud7U16Zgd+uahM6Gnv+evoQPjfOc13gZEA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hkz4-1LKFfmDPtsW42boW1ftHoUku3Ph
X-Proofpoint-ORIG-GUID: hkz4-1LKFfmDPtsW42boW1ftHoUku3Ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_11,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 10 2022 10:22, Nick Desaulniers wrote:
> On Wed, Oct 5, 2022 at 8:24 PM Guru Das Srinagesh
> <quic_gurus@quicinc.com> wrote:
> >
> > Remove this check as it leads to false positives in some cases (not all):
> >
> > warning: Assigned value is garbage or undefined
> > [clang-analyzer-core.uninitialized.Assign]
> >       list_for_each_entry_safe(page, tmp_page, &pages, lru)
> >       ^
> 
> I don't think we want to disable this.  Tom and others have fixed bugs
> from this report. See also:
> commit d1bd5fa07667 ("lib: remove back_str initialization")
> commit 33b5bc9e7033 ("octeontx2-af: initialize action variable")
> commit 8d783197f06d ("mctp: Fix warnings reported by clang-analyzer")
> commit eed1a5c74216 ("drm/amdgpu: check return status before using
> stable_pstate")
> commit 3da4b7403db8 ("ALSA: usb-audio: initialize variables that could
> ignore errors")
> commit 38ac2f038666 ("iio: chemical: sunrise_co2: set val parameter
> only on success")
> commit afe6949862f7 ("afs: check function return")
> commit d108370c644b ("apparmor: fix error check")
> commit d52e419ac8b5 ("rxrpc: Fix handling of an unsupported token type
> in rxrpc_read()")
> commit 6a6516c024bb ("USB: storage: avoid use of uninitialized values
> in error path")
> commit f71e41e23e12 ("iio:imu:st_lsm6dsx: check
> st_lsm6dsx_shub_read_output return")
> commit 3a61cdf43e67 ("hwrng: intel - cleanup initialization")
> commit 094dd0d73062 ("rndis_wlan: tighten check of rndis_query_oid return")
> commit e3914ed6cf44 ("ieee802154/adf7242: check status of adf7242_read_reg")
> commit c2a3d4b4cac1 ("net/mlx4_en: Cleanups suggested by clang static checker")

Thanks for the list of these commits. Will review the relevant portion of my
code to address this report.

Thank you.

Guru Das.
