Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A37720A77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbjFBUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbjFBUkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:40:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1B0E48;
        Fri,  2 Jun 2023 13:40:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352DuFJf005995;
        Fri, 2 Jun 2023 20:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9+03auotNTz1TIZFlXasLKcdBNaehKED/ltJTzRkCCM=;
 b=ck4BSOKDv958p3nZdyRLrQd0zBhueNGhzVUGik6DM9u57cZ3dDYjLjyksWPJOue3epL0
 eXOvBYppxYTifduXuDmwcwGdf1LuxY/dW6DAGQLNRi2f+m339MIiaP5YoPK4vzX6lzGz
 Y/uzHr7SpUXx1xqQYuVhRKpL5mxbMzOJj1VXKg/gysE0BhFFfaX0t+DwrgXNi5CkRAAV
 1GfVupqDWINzG6Zh5DPb1G2tYxiGFgdOQbaY3B2g2bBOZT7YuLtd0nMP6cEb4eNP4dXH
 uDBwB4ypiillYTIMzuQPCDkWWuuSPPaEkSkgqgKOA9/l7jj9h3/oqqGy0ZPwm/yCsceo RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qydr5heyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 20:40:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 352Keahr005559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 20:40:36 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 2 Jun 2023
 13:40:35 -0700
Message-ID: <e5044160-ebc8-b1e7-a944-33cd1b080eb3@quicinc.com>
Date:   Fri, 2 Jun 2023 14:40:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] MAINTAINERS: Add Carl/Pranjal as QAIC reviewers
Content-Language: en-US
To:     <quic_carlv@quicinc.com>, <quic_pkanojiy@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20230523161421.11017-1-quic_jhugo@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230523161421.11017-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NnAsRHPj8jLvNMlxwd8fmTl8hEIf8nKF
X-Proofpoint-GUID: NnAsRHPj8jLvNMlxwd8fmTl8hEIf8nKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=891 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020160
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/2023 10:14 AM, Jeffrey Hugo wrote:
> Carl and Pranjal have been reviewing the QAIC patches.  List them as
> reviewers so that they are copied on all developments which will make
> it easier for them to continue reviewing QAIC patches.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied to drm-misc-next
