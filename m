Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C47134B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjE0M17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjE0M15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:27:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5CBF3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:27:56 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34RCFE7S013020;
        Sat, 27 May 2023 12:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=IF/hiqRxf6vSljvbcIWa2mpjRo75YCgYwzVNchZ94k0=;
 b=XMq2lDz17kovopHWpomrplEt+7Gj7TBUPr4Blex/RsDvl/clunWDla/RgOxtRSJhSoRK
 HQVsb/YqqN5oKtaDJtg3BATqbDBf3Bfkqguu1BkUadZz/SVsAYdVf2SmQ4y1oz5YYhjp
 FYP8k6pQC1AXaNFvTScTTeoczSYefuAUQFkn0EJn2CcQZn5IFqcRDhv+2CZIWb5JpSFa
 E0GXB595ZMqbxO2D7JKwr33xJ/93dnUoL9NlgSZG3ltex2eIFrI0+M9uT5e4jIjXHoeK
 WOTGEyqh6YYbxpDLyYHGjy8cVo7YPsFzkK17TPv86HuQXOZkHAfLE9AugsHwzzYZHHXQ dA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qub5dgdc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 12:27:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34RCReMm021826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 12:27:40 GMT
Received: from hu-pbaronia-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 27 May 2023 05:27:38 -0700
Date:   Sat, 27 May 2023 17:57:34 +0530
From:   Prathu Baronia <quic_pbaronia@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/cpucaps: increase string width to properly format
 cpucaps.h
Message-ID: <20230527122734.GA677156@hu-pbaronia-blr.qualcomm.com>
References: <20230517100452.382174-1-quic_pbaronia@quicinc.com>
 <ZHB7tvDa7d6T6SEq@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHB7tvDa7d6T6SEq@arm.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2d8fSMKJuQ_dfT25PzM1mCjl0bE4yeQG
X-Proofpoint-GUID: 2d8fSMKJuQ_dfT25PzM1mCjl0bE4yeQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=403 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305270108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:28:22AM +0100, Catalin Marinas wrote:
> Why not make it larger, say 40, just in case.
Sure Catalin, will do in v2.

Prathu
