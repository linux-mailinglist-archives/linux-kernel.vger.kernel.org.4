Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C20662896
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjAIObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjAIObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:31:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8D654E;
        Mon,  9 Jan 2023 06:31:42 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309DBCHM020698;
        Mon, 9 Jan 2023 14:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=62HdukqYPMV75t04yPVpNh5jiURq5K9MvpCo7sCNlZQ=;
 b=DPqgfHFGI7fDCt7lYbP6Y4HPfOF8lbJucZPfcY8xmkYAY0vRP0lMn3q60FsheMptK4gG
 PHFi0ohHK2amoC4mGcO+E2fxFEDO280c1FFOQm5tdcM6untkk+jAqEhh52/X8iSuHDgD
 mvPTCTy/Mz1XnRLTQawIAAq6V1NIhKa/7acHhiLEn7IMj0x+o97lefcJ6fGrAq8aEXlh
 Nmf5T2MSLsgI8ypN7YM9OChs1XZNYvb2ykyBizvP6u3BXX2+1izS5cYe0p3V2y8x3h1n
 49v7oEhXaXsUUhnYcF217swIOgHx8ZLntACp1BI6O92yQLu1z7A3If+mNDzSdv5stwvv aA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0yab96j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 14:31:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309EVVj6007219
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 14:31:31 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 06:31:28 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V0 0/1] bootconfig: Increase size and node limit of bootconfig for DCC support
Date:   Mon, 9 Jan 2023 20:01:04 +0530
Message-ID: <cover.1673261071.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c3wHp8IzG8SPi5K7vnZ1EoFFWxLyIkAo
X-Proofpoint-ORIG-GUID: c3wHp8IzG8SPi5K7vnZ1EoFFWxLyIkAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_08,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=550 adultscore=0
 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090104
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Data Capture and Compare(DCC) is a debugging tool that uses the bootconfig
for configuring the register values during boot-time. Increased the max size
and nodes supported by bootconfig to catre to the needs of the Data Capture and
Compare Driver. Further details on DCC is available on the below links:-

https://lore.kernel.org/linux-arm-kernel/20221228172825.r32vpphbdulaldvv@builder.lan/T/

https://lore.kernel.org/linux-arm-kernel/cover.1673247689.git.quic_schowdhu@quicinc.com/

Souradeep Chowdhury (1):
  bootconfig: Increase max size of bootconfig from 32 KB to 256 KB for
    DCC support

 include/linux/bootconfig.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
2.7.4

