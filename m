Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68F672581
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjARRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:50:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6637B72;
        Wed, 18 Jan 2023 09:50:49 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IHeIwW014949;
        Wed, 18 Jan 2023 17:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=n13qaqBhQwvk6VRqBdj4Shf8iLETr+Tuc5gMC+2iR9k=;
 b=SADa5xiswmAho9gj8Cpj+l4E55v8zcWbjg+gkkrDvwr7Z0qwZRnlE9XM++luhZWT6fjY
 4QxdvrJ0LqoMWnHagdFSLE5UYw0dPhpQhKympyPj6eaesWysZEGmkXlovMlxL70XWA3i
 jUOGDXYBv2KXgrWNTNH6Ah+zwmDv7PD807ikYM7+wtpaeppN7q7Ov6Wn/siRFmQYgBdE
 lE/b5S99oDQfLUEb2/0mZQt4laLAIqGZfb7uZWR+jGGguqfRW/sQWvuJWII+bWPDDmgh
 i+WCktvr51jnQ5ADWR0epGoniLfQaj+92UftlgPZdJska2JQafDc8fTHQwD8DrrSK83s Dg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6debs5dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 17:50:45 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30IHoigP029007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 17:50:44 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 18 Jan 2023 09:50:43 -0800
Date:   Wed, 18 Jan 2023 09:50:42 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Chris Lew <quic_clew@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rpmsg: glink: Release driver_override
Message-ID: <20230118175042.GA3322341@hu-bjorande-lv.qualcomm.com>
References: <20230109223818.1706292-1-quic_bjorande@quicinc.com>
 <dc0e1609-a872-08e7-2801-0ece573181ad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc0e1609-a872-08e7-2801-0ece573181ad@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fsm2z8li2eCRGR9FmEzPI41kOtfxApmI
X-Proofpoint-ORIG-GUID: Fsm2z8li2eCRGR9FmEzPI41kOtfxApmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:01:01PM -0800, Chris Lew wrote:
> 
> 
> On 1/9/2023 2:38 PM, Bjorn Andersson wrote:
> > Upon termination of the rpmsg_device, driver_override needs to be freed
> > to avoid leaking the potentially assigned string.
> > 
> > Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
> > Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >   drivers/rpmsg/qcom_glink_native.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> > index 8620eea1dc8a..046271e439c5 100644
> > --- a/drivers/rpmsg/qcom_glink_native.c
> > +++ b/drivers/rpmsg/qcom_glink_native.c
> > @@ -1454,6 +1454,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
> >   {
> >   	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> > +	kfree(rpdev->driver_override);
> 
> I see in Krzysztof's original patch to fix up the driver_override we do
> kfree in other areas of rpmsg.
> 

Right, in the original patch what became driver_set_override() was open
coded and hence there was a kfree().

> More of a just curious as to why don't we use the driver_set_override
> function to clear the string? It's mentioned in the rpmsg header that the
> helper should be used.
> 
> --- include/linux/rpmsg.h
>  * @driver_override: driver name to force a match; do not set directly,
>  *                   because core frees it; use driver_set_override() to
>  *                   set or clear it.
> 

Looking around the kernel, just calling kfree() in the release function
seems to be how others are doing it as well. As such I presume that
comment applies to the runtime state, rather than while we're cleaning
things up.

Regards,
Bjorn

> >   	kfree(rpdev);
> >   }
> > @@ -1697,6 +1698,7 @@ static void qcom_glink_device_release(struct device *dev)
> >   	/* Release qcom_glink_alloc_channel() reference */
> >   	kref_put(&channel->refcount, qcom_glink_channel_release);
> > +	kfree(rpdev->driver_override);
> >   	kfree(rpdev);
> >   }
> > 
