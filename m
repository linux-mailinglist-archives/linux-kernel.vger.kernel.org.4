Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1036993A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBPLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:53:12 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD43865D;
        Thu, 16 Feb 2023 03:53:11 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8uO4A007096;
        Thu, 16 Feb 2023 02:54:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=Nm2Qkb+fnrFs5aSXMYiuYqjHnHukzY5A7pyESRyHqfM=;
 b=RwsJJrkqsVhW5UEdg6O1wysW/NqwChvPl0db/vp52qKsvKBODAgT0tH70vunsapArW6W
 lriEyNXIcJY35iVtWkakTad7Br0hflSMvAvQhhYUqW3SU342pBiTcUxEr0iEATNPUdSz
 Z/J77gGbLGZSoyJfC+ymgmwFMK5V9mjwTxsjNI9l1snIKmF56iTULsw7X2UhngBnVzpf
 +RxGm1GQT1/KLmLTpjOz2h6ahhDzc83meMjPbj2LT5l0Bhe/MFGK0nkj4z3yYKz4b1/D
 rtltNuuWtlAgusYT+v9ZMjUC6okSzs/8Ayb/FAhdnTWkP8A0Nqpj9p70ktnoh4NJ0HFt fQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3np8f3a0wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 02:54:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOc4PK6kzoS2CxLlT+wHKgqxCz/IkEVaftIPlCnsoXkMJqQauReEBmSTFD3gmr/SzSAsiQl0JHttDI2NHmIA2qz6fbL8NO4CL8eEL/ny3/numWUbO5YGL4/sN6iOsm5xe8HytV04zD2lY0i4O0Aq0ipMwJBiRi1hUe2xCgXwanfgnGu6WPsScLK3BDto+80oXCoRmDIG09Vt78W9u6YprFU2gBY4127Kkm0Z35mcGj2QbaKDS7mivZ2lhIeP22t5M6rmdBYMAkbIUJhLn5fNrguH+O4jx5cNWh4+8TZaeZB4P0PJJ6kd0V437+ffoESW3mOcgZNHU6NhOwilSgNSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm2Qkb+fnrFs5aSXMYiuYqjHnHukzY5A7pyESRyHqfM=;
 b=HcGlheXwvN8+uZKnIo9xzIUgNacKCLEKL+o/UHdyC/FKT7agrbOERIBCwk5LbV8db/G9qqnA0+HyxsOPHkn8SLx9N8DgMQ6VUG1F1/3PXC0mJeWZvVlulFstgAxvCy5/eTHOZaf9mBEF39U2pQ2cYQ7xX5ya+E5MUiD6xjt1iLikprMW0XiWDpeaQuD+eoiOQayR9ULox/iNLVxSWHApRIwz5FN2iB6LI+js8t16tE1qnn/FRkY/fbLvWaZObXGiWJ4L5VTmPsOXkvFqtn9vlR3T71mLBQSSKP0jdGv3EWUDtwoWFwfjFH10g6cCfOiq/KnFiVQVbr4qdP1oBgRVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm2Qkb+fnrFs5aSXMYiuYqjHnHukzY5A7pyESRyHqfM=;
 b=HLUs103ukL8UmSBo0XbfG9xPk+RvCHmdJSDwoAuPZ2MF7lznPbiXmFINSG0B4Ctn/LvVGlhs7DCWyhFUjhlMZKj8e1tg1hdpJHDEx24J2Jm3QDxwYL6+mhEHOBrV/GveD+KR5+2pAlF+JK8rSYS3onTJ6HmOCUAnfkf6+/K1aEc=
Received: from BN9PR03CA0231.namprd03.prod.outlook.com (2603:10b6:408:f8::26)
 by DM6PR07MB7049.namprd07.prod.outlook.com (2603:10b6:5:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 10:54:32 +0000
Received: from BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::4f) by BN9PR03CA0231.outlook.office365.com
 (2603:10b6:408:f8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 10:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT027.mail.protection.outlook.com (10.13.182.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.6 via Frontend Transport; Thu, 16 Feb 2023 10:54:31 +0000
Received: from maileu4.global.cadence.com (eudvw-maileu4.cadence.com [10.160.110.201])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 31GAsRqi021870
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 02:54:30 -0800
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Feb 2023 11:54:26 +0100
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7
 via Frontend Transport; Thu, 16 Feb 2023 11:54:26 +0100
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 31GAsQxp364510;
        Thu, 16 Feb 2023 05:54:26 -0500
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 31GAsQvM364509;
        Thu, 16 Feb 2023 05:54:26 -0500
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <arnd@arndb.de>, <tony@atomide.com>, <jdelvare@suse.de>,
        <neal_liu@aspeedtech.com>, <linus.walleij@linaro.org>,
        <egtvedt@samfundet.no>, <biju.das.jz@bp.renesas.com>,
        <herve.codina@bootlin.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 4/4] MAINTAINERS: add Cadence USBHS driver entry
Date:   Thu, 16 Feb 2023 05:54:11 -0500
Message-ID: <20230216105411.364157-5-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230216105411.364157-1-pawell@cadence.com>
References: <20230216105411.364157-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu4.global.cadence.com
X-OrganizationHeadersPreserved: maileu4.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT027:EE_|DM6PR07MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd0d5e3-c960-4f60-8090-08db100c2f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHaaPLcz9ivsvUwRcwanZuEQ6C52Tf5lfHI6esv4QvIPrITdgoncEsn9CwNCWY07PcjD+NRVORpJ87/3NnN1FyXCAfcvmAB+azeVsRDngBmcFWxxgGPt9WgKtLoHCkz+0H37xy0SRi12O69M3xQ+E5aa4FsxKGCJcpYjghuClYrsxtr4A9P16UI2I1GnbPNnwVzkfK3kwz/cS8/olC7pqv9sMPN8vGgzEaRvsORhxejfsdMsShcKQdZW9XqPSGbq+GKIRSKV9GrlZYm1/43qyWrtsxkgMn3jSFF6saZxB9UH3FE+YFYdzwWPdmccKN5RyOEBp/GGG8moZHRDpJytIAx1ucksGdYybr6Sa49Z6zbvxdBBk5eUF5GNiljnoPBAesEUSpAEAhXIOFRbNoQ3E2Rlrx/7kClRYwFipb0GW7g6T5DNUcaZc92in4DiwZnY3x6Jz7Ynoi9Y8V620df06FwmnMuCYEMq1Dy64C7A4Bwynk3QYTkqRDD2cNgIl37YMVgeiB21+JnDUhpGvBLDIuB11TG6RS/J25DehjuSqu7gODfTEIzIF28UErbJSp5N9E7N/sjjeQyZNO+y93vBqtOkI/5npPPVJ3qxy3mhST+5eQhWB9swbQVm/E//K7/Z9CpXF4Y0GqfcaHzC+x0CBxidKM+8bnYbWiIGth6pnw085fBSmdMnLV963LDy6eldwva24aE4L928Lkav5e2Z0Q==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36092001)(451199018)(46966006)(40470700004)(36840700001)(1076003)(6666004)(26005)(186003)(86362001)(82740400003)(356005)(426003)(47076005)(336012)(2616005)(107886003)(478600001)(41300700001)(4744005)(8676002)(4326008)(6916009)(5660300002)(7416002)(8936002)(36756003)(54906003)(316002)(42186006)(7636003)(36860700001)(2906002)(70206006)(70586007)(82310400005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:54:31.7765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd0d5e3-c960-4f60-8090-08db100c2f1d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7049
X-Proofpoint-ORIG-GUID: xEf0dHsHS0bR-TQxzJuvOoU3NAgM5MF0
X-Proofpoint-GUID: xEf0dHsHS0bR-TQxzJuvOoU3NAgM5MF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_07,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=750
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302160092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds entry for USBHS (CDNS2) driver into MAINTARNERS file

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f76ca2808474..45ae3c375a2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4502,6 +4502,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	drivers/usb/cdns3/
 X:	drivers/usb/cdns3/cdns3*
 
+CADENCE USBHS DRIVER
+M:	Pawel Laszczak <pawell@cadence.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/udc/cdns2
+
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.25.1

