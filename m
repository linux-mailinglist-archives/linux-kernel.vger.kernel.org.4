Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C674D372
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjGJK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjGJK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:29:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8138C9;
        Mon, 10 Jul 2023 03:28:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9DPIS019969;
        Mon, 10 Jul 2023 10:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ISiuR4TfQERhwJZYv0yi/JPjED7i7kGHRGpeUjLNigc=;
 b=Dtl2eLT9DKeO9j3HBLafXFb/HrzLYzzPPaEk5xCZP+uOr2OtkAo9n2FFgCdhOYKJKr/O
 nNGngGfML8Yr/2I4eMRTGec8EqlBWYaJeIJJTAWUmVj0Y7atPDtH8tCbCN1PPjVWUtRX
 0Wzfz/DY3tNW86t41vssquv3w2FtDsbuf2FvRsSRDkJXVMwDLleE8WhgZZIBRO+BjvUE
 34NccEYQK+xRw+GTM59WyRdsnGO4joWhpbfp15yDqjw2FyBI8OPiszpRSdYY8sHK7RJ0
 DX4xLCk+1gszbed533BgKYjhWDJa7Y3IhNJ5DkEZ0urbofLS15GERp1asAvM0UR3FW/3 iQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrf5mg7tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AASTO7009767
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 10:28:29 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 03:28:24 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/2] Drop the mem noc clocks from the IPQ5332 GCC driver
Date:   Mon, 10 Jul 2023 15:58:05 +0530
Message-ID: <20230710102807.1189942-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sJX6HCos2V0Wl6K2NgSoxN9wAbRe5H0v
X-Proofpoint-ORIG-GUID: sJX6HCos2V0Wl6K2NgSoxN9wAbRe5H0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=581 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the recent design changes, all the mem noc clocks will be
configured by the bootloaders and it will be access protected by the TZ
firmware. Also there are no comsumers for these clocks in the kernel. So
drop these clocks from the GCC driver.

With these clocks removal, remove the gcc_apss_axi_clk_src clock as well
since no clocks uses this as a parent.

Kathiravan T (2):
  clk: qcom: ipq5332: drop the mem noc clocks
  clk: qcom: ipq5332: drop the gcc_apss_axi_clk_src clock

 drivers/clk/qcom/gcc-ipq5332.c | 206 +++++++--------------------------
 1 file changed, 39 insertions(+), 167 deletions(-)

-- 
2.34.1

