Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F260376C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJSBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSBP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:15:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2431C5A2F7;
        Tue, 18 Oct 2022 18:15:57 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J0tfqf032095;
        Wed, 19 Oct 2022 01:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=8tSN5Rf0FvOU8jPXKjpxE37kkUeI+a1foe7H3Wbg7DY=;
 b=ALlBfnolJlXVJStUNdEv9bIey6j0Jb+iG1RfSXtMI+Vn9kMmi2NHtfUla+pIhtJDLXqP
 /LTIOcUrLBiYzPBe79wLOphB2P5U2iIS0mcXZ/vSpjw+VlWHCIqOUgwOs87LwFgLH9C5
 sjboYRRfN3Clqzn5cTsdPuT1KzCK+T6BkPP5qTnWt/ptqZAxiioYX6OkKJIMTTCUzaRS
 QVbim5UngZVpoKj5hn14uyusFpLvmI1vC6y4SuSGOevljTSWEtWTFRSawmtqHNn7MNN4
 ifzGZb8dH2Us17joT6Mgz/rjWVR+/V0A+Dm6xYvLbzi12/v5wS+a95wlKhVGsjtExHff OQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9yq1h396-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 01:15:50 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29J1FnAd008915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 01:15:49 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 18:15:49 -0700
Date:   Tue, 18 Oct 2022 18:15:48 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>
Subject: Re: [PATCH v1 1/1] drivers: remoteproc: Add bus scaling capability
 during bootup
Message-ID: <20221019011547.GA2489@quicinc.com>
References: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1mamFUoPZKOJFxen8ygRM8opkcZsTibB
X-Proofpoint-GUID: 1mamFUoPZKOJFxen8ygRM8opkcZsTibB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_10,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=590 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18 2022 14:10, Gokul krishna Krishnakumar wrote:
> During bootup since remote processors cannot request for
> additional bus bandwidth from the interconect framework,
> platform driver should provide the proxy resources. Make
> a proxy vote for maximizing the bus bandwidth during bootup
> for a remote processor and remove it once processor is up.
> 
> Change-Id: I798b3b000aef4761a7ff8cb6390b7ecd98f925b7

Please remove Change-Ids - they are not for upstream.

Thank you.

Guru Das.
