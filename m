Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801106622F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjAIKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjAIKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:16:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B858B1089;
        Mon,  9 Jan 2023 02:15:30 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3097kvdG020423;
        Mon, 9 Jan 2023 10:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gMSsfsc6W5Z7AWbXOxhhnPrA/eSOnqm85HvHrPE2o8s=;
 b=UNlriiL/wHgLgiBceVXVA0qrb/rkeYDAX0viBOxfb6QYV9yFI2+j+K8ty6jB6UJAWT+H
 +akEfI/5IlEweCvv9Nm0VMN8l0/11n+e0qouxyUmzBoc0ST9FOAyYKjGfjcCvTqvPrBx
 W7hv7XbFDJo73xnNmxe94OJtPH0jt/cW5Gx36LMze0iSIMuz73p4Hi66U6tU0cu5J/we
 i+zzQig+9VV4C32lDB4gkFxsBdY2GDz8mqUIto6PXuXe99uGu6y+osGMxb8aSs0ZC+3K
 fUgd43tWkxEO+O/cwo9rkY5FSk/euu8xe5xqP2Njkv+e5De9LNYuVw/UjE7E4767BPwL Qw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0b92t9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 10:15:16 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309AFFU2030936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 10:15:15 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 02:15:10 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Subject: [PATCH V0 0/1] Add QAD, Cti-trigger and Bootconfig support for Data Capture and Compare(DCC)
Date:   Mon, 9 Jan 2023 15:43:43 +0530
Message-ID: <cover.1673247689.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: flXfUITHtK1rNZUz5b5e7R28OPd1-JPk
X-Proofpoint-ORIG-GUID: flXfUITHtK1rNZUz5b5e7R28OPd1-JPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_03,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090071
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
	link_list_0 {
		qcom-curr-link-list = <The list number to configure>
		qcom-link-list =  <Address as same format as dcc separated by '_'>,
	}
}

Example:

dcc_config {
	link_list_0 {
		qcom-curr-link-list = 6
		qcom-link-list = R_0x1781005c_1_apb,
				 R_0x1782005c_1_apb
	}
	link_list_1 {
		qcom-curr-link-list = 5
		qcom-link-list = R_0x1784005c_1_apb
	}
}

2.QAD

QAD can be enabled as a part of debugfs file under each individual list folder.
QAD is used to specify the access control for DCC configurations, on enabling
it the access control to dcc configuration space is restricted.

3.CTI-trigger

CTI trigger is used to enable the Cross trigger interface for DCC. On enabling
CTI trigger the dcc software trigger can be done by writing to CTI trig-out.
Also the hwtrigger debugfs file is created which needs to be disabled for enabling
CTI-trigger.

Souradeep Chowdhury (1):
  soc: qcom: dcc: Add QAD, Ctitrigger and Bootconfig support for DCC

 Documentation/ABI/testing/debugfs-driver-dcc |  24 +++
 drivers/soc/qcom/dcc.c                       | 281 ++++++++++++++++++++++++++-
 2 files changed, 301 insertions(+), 4 deletions(-)

--
2.7.4

