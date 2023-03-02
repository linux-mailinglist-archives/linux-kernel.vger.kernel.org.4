Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07A6A8B88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCBWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBWLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:11:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EC15C8A;
        Thu,  2 Mar 2023 14:11:45 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K42Es008689;
        Thu, 2 Mar 2023 21:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Sq4q+28VsTVr3doxQagH+JClA/d2qVf3vA/96kYD+yc=;
 b=JlVN8wwL4KCgrrdkkbOQPCfZSeDMcd5StlJYd/0Iegxa4zwnYc3/+R9/ii1yljfr9VqP
 3Nw4OsXldboKyV6jBnxnGGMY06NmKIPq8SMaZH4PknJ5LznLn+qaUHx6SRd/hafRhouY
 UtwdN0RyTc08Za2S0k74QPxCua3LwvdfjDAhrnqSam4QXcFiDcL1nQd3y5ylZGRWLcX1
 2Ys/lY6EJ/e9/5tACVj1UlfcFRI2S9H+1XiPTwbGxnoBZ/gjnCLq0hZExhaW0ws3tw1/
 8f7ddJ9ARYrCcb5eeJGkOgJ67AtEfWJnpHx7Y2wE9XQDP3sY3dGUykSxzTpf71ESw8mQ Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2d362-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KUXCd005225;
        Thu, 2 Mar 2023 21:18:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saxwrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9gnlAWbt7dTjxwr0SbjWpNxOMJLI/2QuGHQKbVQtI9sElysNH40cBhCR3zUdDMsegnXz7RZwgKflBBkabuutkthtzAUMsCkj9Sn/Wrig3aCxYpxg1EgbxAFLq1l4c/ZzPr4NvHyEg+E74S0URmcfi5DZMyWvawqDhVNaUJ6jqOP/YjEM3LZbiWhVKBTfKIaC5xkMJlFKvdMhj6dKSmDxUNoZQvGBLKM3HP9bhiCwzHxkzXD/gS4yBytLia54LrTap7nmzMXiBM4g4Uw3rVaIU2Aw5ypUtxXZ1f10Y6ARH0asyMHNjgUvuv2sSvJpXDQEn/OuvkQCvQODVX6vauZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq4q+28VsTVr3doxQagH+JClA/d2qVf3vA/96kYD+yc=;
 b=FhYDUlfsBfwISLvwd7rdEb2AkJk0+74zUY75QWn09jqtQUr+SPSWAK70dO4WgXgYxKR/OHwlG6yUVqrXtdJKF6kz5SWeRezgfFeP072XU2fFYMMsrSeGc2c+hmgHEzFyLivUqGexZ8L4ddO7VCeNjMDmYiw5pGylOMd6nsry6pC/B7mveoIR6ycBBebcllXP2PBK060b1+P+Kp+FnRg/k+1/RBl8GqVH24msjyevvjgkrJgc/TncAtqjh2ld9ABbh0K2alxqMy6A+gF9m6VVFbcT4qEd6t/pYMNrV6YmV71SzavW9k+GUUnBBhH8za6XehpsieVnGnEer6DYTmV5RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq4q+28VsTVr3doxQagH+JClA/d2qVf3vA/96kYD+yc=;
 b=vUEiwIMwK3qkxwG5lklTJwDailYqg4FK9Gkxe7U0PIcwGTq9IcdPlA1x3X/drzxJJo3h8p1BWC+YSu6xkQ+RqxdNYDU+aQw9J6wfdt2n6wL8+Zu6CTOwTmseNCdIEpJtyiowylbNjwA/io92erA2RChXou5MMxeQNCrkOtdtKkI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:34 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:34 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 05/17] drivers: bus: simple-pm-bus: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:47 +0000
Message-Id: <20230302211759.30135-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a8ada4-bdb6-4a55-6ee2-08db1b63ae81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNLzIqIpkBfBJRzgSH3sDCZvOZsanu9BstODs3mHF51K5E7/HgvIdpX9YcSUg4EPz2Pst9haTS9TBZX8LQoFhyUSIMrxJl21QVU7bLSYa5EbeZunx8u+9E4ukt6uUKj7EbuxdjNlwXAZ/JrS4x5eJzLPhvREF7d+R6savQwX5H4VIyw1ii7+msHINw02UejcJBmFFJ5oZggxcVjWZaBNww5e7BuQMa+inOHveuqABJvw2f2qk7Pt+HzlNoeEFdREbHAYTAt1F4lMZ1yCZDIMyXhJvFqQkBtyAy5Apf376kI/l2woc1rjYZ+zCV2tpksoOkTeKj1kiAqC+5Y2ergFpyVBaZdKDT/qOyU8X1h4xkBPS0M+BkpX7f8LhYJAtBTad2wXSsdkW5K2/4t4kMyM1ApK1f2yAYFhLRpD5jKfLM3YYv2HEXYXwGJm0BtlH19vWQlP0hUMvFlDzNZoGe+gG1ezNprM4nNTAr6sUWgkq1ArbhPdAzXv4+ZBRJXthK+ckqDDjZyQtS+BRv8eWlDZEdS4ZUAhYz4Ygpfe2Jg7wW5cVll9rYxSei3EGsSzzx/whSRwLe2yY5GjMLroON0X8qSQ75atKiDFtXuLX+JmHqOPaBfxZ37P1K386LkV/PvFataBFj9T3eXEUaI6y1r+Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SLNCzJEDAdnTFbXwI9oizYvSDGW2CklrUToDrjOrRlSzHbUXb6NZHd4kYwmk?=
 =?us-ascii?Q?qvgbJzWtktkojJz12PkSpJ4MxUl0cZhkPzg3bIUgEEBCaGNgPwvpcnbwZLCS?=
 =?us-ascii?Q?ZQr1fCaCURKJ5gBH8+CWrH/nHu5tEbPDgw+NaW1qdkIDiutwuo23K9FY2lpA?=
 =?us-ascii?Q?xBufLN+vGRUwPxUKVQyfZ+hHWJA7+WnUYhiFERuIbly6zlK8w8sSIXSWEwjn?=
 =?us-ascii?Q?xMorAPvZc8w0ZgDn3zC2fva6SYnloac+REfETKFgS6zB3dpoPC5hE79tx6ZW?=
 =?us-ascii?Q?2awnPPb4CgaRaiNTGGLqEJH2WorbIyRh7oftwbZDxPTXJpe1xwItXyCqWQR3?=
 =?us-ascii?Q?KHzn03TiK98DTAKFj1eKymRJRZxJW8DmWs1vpuX6nsE0vH83YGLbV4b0+g85?=
 =?us-ascii?Q?dhIr+59oATBiyJ6Nitz13Cus/5v2NTmOAbntS5wBuo2rBxDTu/Yoctwge2Qi?=
 =?us-ascii?Q?KRFsaFJ5hoZAP8RP3KpM0Zs5asBJQYcNZaPDn877Pp0hK96uIsov9S9mFMvO?=
 =?us-ascii?Q?LDXCoHgk3PVwFLjzE/UUyasiNGHAgKu2hdXWKblFC3Dbo8JV4GwISt8EtMKf?=
 =?us-ascii?Q?6EGR2fAsFEyjaPJMPuVTJwyfMgoAqMmBCtBGPZkm92gmluRLVVRr3ORCwSiS?=
 =?us-ascii?Q?hlW2xRD/gWDctEcOw+SCluog093Rq4gBFI+1f+/Ka/uvsB/ycE5B+2J52IoL?=
 =?us-ascii?Q?Rh+C1OjLCgAlFMWtMDru/FFUgW/4DahdFE3K9zi8M8qVJ7NO59G1DtZ4RmZX?=
 =?us-ascii?Q?7pThp5pXztjmjCUB5vSoBaasIxYGtCk6IBiUnRfWdP+yoRK7Y0weTkaDhR47?=
 =?us-ascii?Q?EuaxwUu/MUfiWo0XuLSliC+vgU120Tvai5kw31DQWc+asJcEtz3shH5q6IX9?=
 =?us-ascii?Q?mRb+nRDZyStCYAVZ129mieNSEo38FMei+Qq22jLovPlTk7a3F3Tr1Pb4Id0A?=
 =?us-ascii?Q?GQLEFxrLBxgzmyXKYNK0OqYi/dqUct/tixuqik0HibuxOpypgTQdyXJL4dTF?=
 =?us-ascii?Q?fLo7M8XLMsvqdafgDbhHY33eoYxZvV+Tgv1ntxdfXdxmdmSdhj3gnaierk8q?=
 =?us-ascii?Q?M/eYT6HLYUMpcwj3Gdqbpe4mgYX8iTnC2vWxUO43F4e63pg793JyhuAs6+3H?=
 =?us-ascii?Q?23TbiVgPtIx4KGudnachJCP/+7VMUWHYteIG+igOfZpGIY3dV3QZ5rX/XhnK?=
 =?us-ascii?Q?6kWvMvzwk20B4+5Q4asr1XbPZn50+/CiCvrFTrFguoj8FYo7yoTPHcPxW7Nk?=
 =?us-ascii?Q?DqjesCiQfQI4N6JtiB1IsQieDxlfSRwv0FhZdAQxUmBMzun7owYKMxs32FPS?=
 =?us-ascii?Q?C4S8cJqBiVeIZ4Jqsg9SXi981KQr9uXgzkee6spuA7mCU3Cwk21ftXP65GUq?=
 =?us-ascii?Q?2+A6J+X/oHYDsUVV1dfCNMRgRah1920JInkKehiZbb28qftiC899rvSekWnn?=
 =?us-ascii?Q?vUmoOQxomK75Im22HUrYsxtPTWaIZAXR/33WZWsy1fqin6PAtjAfSzH4mw5n?=
 =?us-ascii?Q?Z2yU12bnYFMYF08/zuNOQqd04fNJ5LikF485FUCfinyvn4MxjSJwf8EJdw4o?=
 =?us-ascii?Q?UgeXyFD5L+Mcp6fqzgt23xkR6RKNA2YymB56f3lkuvOOhwmQBf76HuIU0+6H?=
 =?us-ascii?Q?fMH8kIoET0VKEwBJZRmwFW8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u9qbgALb//ivvFEIC8VPgcwY7/E3giUJtiduSv/uioFDPuw68fEGyCK84g0HSDVJeguPcs64XjKus8WByZj5IgDAN8ZIZia/b2gsXPNtcDMyOtOvpjU5gfLMrn38dNSqkMEo8fcahpFjB96RZjdK7ARkDX4GfVuvN2u1EV/HU/kfKN0+00T69Q3b07PwyoirM7mSbO+uQxWb8DCRc7L/FUgz1IzGBTzBfIKAqWkyoPKs720eMPhzVcqCoT2AnEKWAC8hSIsfNCXIl5JWpcIGdpprZuCjvzUo8yIwQmEUnpFLeVMRTGX4hweIopqMlguOpAmD/UkLrMSQpJW3VRPcsPVh+G2UwCEJfdCanOSYKY9MTEGdoO7Hf/1f1vKXtpamwtCi67use1+fIKdyCMKbuidJrwXt3aSZN6sIV7S03Qxx3N5LUAfcq9/d2muuJjjkXUAFby4Ku4Xo4JkvNgEwxPDK1VDaXLnwjw/wBw6glbv/S+dpapcuzgE2KzGET5dmDDnUxColOVGfPObECBiX1vra5Jf7regDZpC3ld0W4gFf9e+GkqVXhmVaFDZn5CNRxSlF0XASJtGahUmDPyQDsExFZd7aJcMuWdKzvx7UWv260FY+P2c1xcge9A4a6oU1+62Ym2nhkaXn5hNCEbE3qlOpjlLGlj9BHq5v3LrXSVtJ8oCuM/NZcOIBmu61gPvL/uiVPtvidyYYn4OBj52WE5yleoAL4RukrxTe9rQrpyVkhWK/pJwqVaX7FPB7uynVuZW3hnudD0GOlo23JbVpGFul048rNW0Hw2peFlQe5XqmqW7Ed2/rEEI/rXE4m6YI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a8ada4-bdb6-4a55-6ee2-08db1b63ae81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:34.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmR/9QkQBJffGSy/U1EQ8AH6so4TloEHRizhy2+U10tdz8AzsAw+hSGo0scS7bD46RlLxMB5e63pWplLrPsWww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-GUID: XLsTVExSKVQ5koHvrIrqj9yRECvnjBOG
X-Proofpoint-ORIG-GUID: XLsTVExSKVQ5koHvrIrqj9yRECvnjBOG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
---
 drivers/bus/simple-pm-bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a4..32e6e960f1676 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -92,4 +92,3 @@ module_platform_driver(simple_pm_bus_driver);
 
 MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
 MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

