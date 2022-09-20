Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26CF5BEB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiITQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiITQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:28:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DBD5A8BD;
        Tue, 20 Sep 2022 09:28:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KFURhF003269;
        Tue, 20 Sep 2022 16:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=VSzjtJ+iL/H6yfXfqjWpjH8XeRgh0pgcNMJl2d+jvYo=;
 b=W8xQoVHEy+pkfimPJ9pHEEgynZz560lDU+CpbgUw7GzNm0FyoDcjVU8QsrYQvNal9N3n
 Ez/fIz4JcDOA7yjKsKCtE2/0zPR2y5fK/4q0E8iQahi8dKfMxTraDKMAKAk3c59ZuRQE
 zXbKX4bm55leucpctzwDWM2Muqlt/D8UoSgQ6i1FqU7Y9Z6BEP3lDxAeJ4y9Hc/n/ysJ
 WQfrW5WJ77YWz5b358gnc7/G0yUIdA72k6mHDw2vVtm5jJmxVeBRVp0BRHdM0biUaRaZ
 0uOsmv6SIYwpCVBXNSMHXfHkgCQSqFMCIK5J0R1WlaIGO9PJQjk6O23ZnZ5JpbYqYB7A 2Q== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq8fw1pu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 16:28:52 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KGSpl6009846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 16:28:51 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 09:28:51 -0700
Date:   Tue, 20 Sep 2022 09:28:50 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] soc: qcom: llcc: Move struct llcc_slice_config to
 header
Message-ID: <20220920162849.GA27067@quicinc.com>
References: <1663384000-8097-1-git-send-email-quic_gurus@quicinc.com>
 <20220919205633.qw5ucwjtyt4vjsro@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220919205633.qw5ucwjtyt4vjsro@builder.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9L65oIdKd_tfhZvgW3En1zP4I7t34S7r
X-Proofpoint-ORIG-GUID: 9L65oIdKd_tfhZvgW3En1zP4I7t34S7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19 2022 15:56, Bjorn Andersson wrote:
> On Fri, Sep 16, 2022 at 08:06:40PM -0700, Guru Das Srinagesh wrote:
> > Move struct llcc_slice_config to header so that it can be reused by
> > other kernel modules.
> 
> Can you please continue this sentence to provide some concrete examples?
> Will we see those other users posted upstream?

There is an llcc debug module downstream that we're currently using to test the
llcc driver that uses this struct and has to copy the struct definition because
it's not in the header. I can check with the team about their plans to upstream
this driver.

Thank you.

Guru Das.
