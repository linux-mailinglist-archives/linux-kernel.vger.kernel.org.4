Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22621720054
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjFBLZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjFBLZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:25:47 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB618D;
        Fri,  2 Jun 2023 04:25:46 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3522oFOl029954;
        Fri, 2 Jun 2023 03:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=proofpoint;
 bh=/IxB5oidK5Op8bX5FachtCBIIReHmjUZQgKl1xdhz4k=;
 b=DaTHWhi8ZsF0KqRmnUZz7PgC5TWmSzV+krB/jXnqnRCUlDDUuIH2XbN5YuJ6wKNbF7P9
 3taUC6eYb2FXWUAki+kraS1enCOiQONz5oIrIC/5mJ+kiViYl6nJh0IGCWYYs+qZjGl1
 COy5LKaUbTfjj+zoSWKRdjUHAZ3B828C2ZC/bXEzxHEZ+jv7XGCSiL1p97a69xvU9/hx
 neorUGlPN0CepmB2Jlfjox032LX4vh6+KjFr/j4N+KSecrg8B//Ef8giXQEPg6J1eWjH
 yZRpGng/IItiAQ1lMrvM+zavTNmFBsShEfWCXyFh12c3FK+GXht4GgTh/E9m+dyAMOj1 Mg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3qx6x9hjf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 03:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6hR9ynMmh+d9RA5wDCsrZe0A+8QRfnmJsTYZanVu/XQl7aZShOnub7X3vMn/ncnbfuEDxQMMaRYLFDOwFLf0EAeOsu2bdQZDnp12ttZteb9DsDScu5t1qonebcHM5cObbEsfqPTincka7dnvEdu3JdsjwsGErdYLogdem1DBr3t8EvLaKKq6AhWASAHvP2xh14EGMgDOJ1iJ3eiXybXg7QrOjlsX+BJWVrP8KQ6oXQPkTzNd7bdO+Hd42fCqnGnfs6PGxiRZc/68PEiefXGLHs9DNgDX1opCJK0l2GA19XWUsJDeEE+CNG8FR82c4KgjQs1o2yrS6qx2ha5HhShJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IxB5oidK5Op8bX5FachtCBIIReHmjUZQgKl1xdhz4k=;
 b=YQIuS6CWX6y8YpFfK7vC3qupQQCb5nYcXUPEvdDn+Netw2aXA4vjypt5pRnXVSAJ4du/la5nTlbcee7LAY+wh8c5Pj1hqamXlEHt+HREya5gds1G9bTT08F1mr5qFAIZUsuYrbMChqHHsjYXtrQQ9rvKRET6sf5WBhdwd6Xe6QeokODsoSCywc8oIxuKksDqNako//RJ/a+wX8jJnoNBbxSh+1YHHCEKfp5GwjQQOo891qn36OCefINGWvXuXqRyjE6i/SkFHxr1TALU2U92Wwgjm1ge4VlUx33Wf1yqiM94lcAjdeelMCq0Dfm3HIl/HsNsoFc9RvW1SL70SWDrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IxB5oidK5Op8bX5FachtCBIIReHmjUZQgKl1xdhz4k=;
 b=6K268aXspbZ+9GXiO84dKaYJJ0RAhAx4AtrpSPWM4J2BogI8O2mOEc4R8fmg1ieLZC/ths1zZ9x/YaijO3PHWpMKKG83X4Yu6mTl6pzUV25VU2D23SeTqql7xnAEkD1aCrfDQjAwWvP6YU5NZ0P/VfldLEj9oLIlL8x1vaRpguw=
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by CO1PR07MB9017.namprd07.prod.outlook.com (2603:10b6:303:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 10:27:15 +0000
Received: from DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::76) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 10:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com; pr=C
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT049.mail.protection.outlook.com (10.13.178.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.9 via Frontend Transport; Fri, 2 Jun 2023 10:27:14 +0000
Received: from maileu5.global.cadence.com (eudvw-maileu5.cadence.com [10.160.110.202])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 352AR60g007697
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 03:27:11 -0700
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 2 Jun 2023 12:27:06 +0200
Received: from eu-cn02.cadence.com (10.160.89.185) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24 via Frontend Transport; Fri, 2 Jun 2023 12:27:06 +0200
Received: from eu-cn02.cadence.com (localhost.localdomain [127.0.0.1])
        by eu-cn02.cadence.com (8.14.7/8.14.7) with ESMTP id 352AR65L077931;
        Fri, 2 Jun 2023 06:27:06 -0400
Received: (from pawell@localhost)
        by eu-cn02.cadence.com (8.14.7/8.14.7/Submit) id 352AR6A6077930;
        Fri, 2 Jun 2023 06:27:06 -0400
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <Daisy.Barrera@siriusxm.com>, <Cliff.Holden@siriusxm.com>,
        <tony@atomide.com>, <jdelvare@suse.de>, <neal_liu@aspeedtech.com>,
        <linus.walleij@linaro.org>, <egtvedt@samfundet.no>,
        <biju.das.jz@bp.renesas.com>, <herve.codina@bootlin.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 4/4] MAINTAINERS: add Cadence USBHS driver entry
Date:   Fri, 2 Jun 2023 06:26:44 -0400
Message-ID: <20230602102644.77470-5-pawell@cadence.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230602102644.77470-1-pawell@cadence.com>
References: <20230602102644.77470-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-CrossPremisesHeadersFilteredBySendConnector: maileu5.global.cadence.com
X-OrganizationHeadersPreserved: maileu5.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM12FT049:EE_|CO1PR07MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e7877-5bf9-4b20-0f82-08db6353ef0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBIQFWYP8KLK5Z50TRNKI5UxvYNaQ60rAa/sgTPTY0KZ3zGL4e2naKk1F2TVsHgp0arFb4bbFjUkTQupgPVTUEAnoobWJddu627QewsEBSWAX9BUbuVgNggyun+VNgh1KrW+1TM5tz9unDvpJUT7K3B637gb+MW2tvpvgGW66z0IfUTgfUuZahmfSLO8Ep2q9YaY8NzAx5Z6Jec1KTjgkk7dt2s8Y1TGUqJe01pUsqafj2t5hM/+hnLye9blonhWWga5PA9NP00YyEBDckKtSMRDugbAAok20zRCJL/wh7tOzLN9BGSkJsg2HxZD9LvyIsSekzxV5CMOQdjTPyevJuIp/fkrqR0+I4G5k/uEJDLjriBlWwC72etiEyIpBOLJZ+xPINXHtiglovGjgKpv6viDmjKiVOcbnBd3bJlnaveW/yYnP2vP7+p9zCfbLo0c9aUUBHqLD5EwmUCbjre+dG2+NIv/PSGiebiKHCmygrM2JLOuAi5DHUKOW1/AHw3fMKuqs1myklxVEBfqfxke69FMxiZknMJCRmfIzdDh2I4KEsM7LBSLqICnut5b3SFOJnVZKY4ZSU74CgMD2vbZSyB7w8Hne++qx9ZVHs9XjoQLaxl22+BaKYDfS9Jxzxddse3u4jwBx9LJxDBaSGocIuaz52pxa4W7e9HGgP3OEtFopNsxQxzrrqu1OAJ0MXuYhHoOwFGlSrKw+uGbNQOj5Sfh8FFkEmKMbC/cxmzuP2HQ2c0i+B8cpuBPfkz0IAfs
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(316002)(7416002)(42186006)(5660300002)(2906002)(4744005)(54906003)(478600001)(70586007)(8676002)(70206006)(6916009)(4326008)(8936002)(6666004)(40460700003)(107886003)(82740400003)(356005)(7636003)(1076003)(40480700001)(186003)(26005)(47076005)(426003)(336012)(36860700001)(36756003)(82310400005)(86362001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 10:27:14.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e7877-5bf9-4b20-0f82-08db6353ef0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB9017
X-Proofpoint-ORIG-GUID: 8AULJTx3MJdDI5DSk1gorZhDzJTmjOhS
X-Proofpoint-GUID: 8AULJTx3MJdDI5DSk1gorZhDzJTmjOhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxlogscore=778 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index c269a15609e2..8b289d52d983 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4523,6 +4523,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
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
2.37.2

