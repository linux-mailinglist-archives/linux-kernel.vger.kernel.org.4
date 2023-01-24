Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D25678F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjAXDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXDxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:53:52 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F031164D;
        Mon, 23 Jan 2023 19:53:50 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O3Wh8w025801;
        Tue, 24 Jan 2023 03:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ohPhfVqIZ7sR/2JraqPEi4V7O9ZxNUcspAjodZyARxM=;
 b=JPbSI0OQb5QkJu/0O5IudO44ewYGeD3gLKw3iyv38ANpqNhwOuKAponypgcet+fP1JXm
 N+Z8TcqNP2GosaZH1pdn0/I0kaBNYRF6M9b/Am6ATnPuDEqfFEG3L2PqHAxyFcj1y7lp
 eIcb/yqJ3WZu7NhnPm0zpBH1Xj9Azg0gkBUuAJvdgQyha7InA5iOjl+dpxwCmKm6fyv1
 i9QY/K2F8JT+q6VCZ8UZ45I1O0MNXLCwCRXrrgHJbF1UOtxtXdpROsaDrDbe9LrUah3V
 e51Rjvp8eiGMkgCP/45G5/c3Am+ESEI8m5bmRFU3az8NNO4n4Uj7GWXtdipdcCQfgCdI nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89pwcb1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 03:53:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O3raeK012381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 03:53:36 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 23 Jan 2023 19:53:32 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Alex Elder" <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 0/3] Add QAD, Cti-trigger and Bootconfig support for Data Capture and Compare(DCC)
Date:   Tue, 24 Jan 2023 09:22:34 +0530
Message-ID: <cover.1674531462.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lt0WCMNsHpz2dvY9LvqILzSCgAAlziiR
X-Proofpoint-GUID: lt0WCMNsHpz2dvY9LvqILzSCgAAlziiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=998 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Bootconfig, QAD and CTI-Trigger support for DCC.

1.Bootconfig

Bootconfig parser has been added to DCC driver so that the register addresses
can be configured during boot-time. This is used to debug crashes that can happen
during boot-time. The expected format of a bootconfig is as follows:-

dcc_config {
	link_list_<The list number to configure> {
		id = <The list number to configure>
		items =  <Address as same format as dcc separated by '_'>,
	}
}

Example:

dcc_config {
	link_list_6 {
		id = 6
		items = R_0x1781005c_1_apb,
			R_0x1782005c_1_apb
	}
	link_list_5 {
		id = 5
		items = R_0x1784005c_1_apb
	}
}

2.QAD

QAD can be enabled as a part of debugfs file under each individual list folder.
QAD is used to specify the access control for DCC configurations, on enabling
it the access control to dcc configuration space is restricted.  On setting the
QAD value, the list gets locked out for a particular component and cannot be
used by the rest.

3.CTI-trigger

CTI trigger is used to enable the Cross trigger interface for DCC. On enabling
CTI trigger the dcc software trigger can be done by writing to CTI trig-out.
Also the hwtrigger debugfs file is created which needs to be disabled for enabling
CTI-trigger. Hwtrigger needs to be disabled for components to be able to write to
CTI-trig-out.

Souradeep Chowdhury (3):
  soc: qcom: dcc: Add bootconfig support for DCC
  soc: qcom: dcc: Add CTI-trigger support for DCC
  soc: qcom: dcc: Add QAD support for DCC

 Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
 drivers/soc/qcom/Kconfig                     |   1 +
 drivers/soc/qcom/dcc.c                       | 290 ++++++++++++++++++++++++++-
 3 files changed, 308 insertions(+), 7 deletions(-)

--
2.7.4

