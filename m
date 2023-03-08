Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F696B1263
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCHTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCHTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:45:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C74CC31E;
        Wed,  8 Mar 2023 11:45:06 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiZIF010415;
        Wed, 8 Mar 2023 19:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=H6jMqgfm3V8Qj0PUS9PAemacGI7PkMRtMR7kxzto+5w=;
 b=OxgZKCZUgiXcpVWqwa1xa8za1mmVP+cU2gef26fxHBrcBjryXBnQsb/6JXDPREJ7mguw
 ogMCfCI0SBlTts3RYeCe6uw30OsVTNJwCj25pkfcfk3tiEOfGPHpk0pbkgFZOqXBm/eA
 pQYrtigt9SLFlrfF/a0Ed1x2CcfCr6l9YsuOcRIgcJUAp2pzRfyg5wMqFDQa3vF+mXvD
 dQJpRdLq3BfjJNUuwixrcJRZNYV2pnih2ucRCocNuH0sdUJ4J1pmeaD4cSpHdsRIEJkw
 mvucEfqx9FF6Q7Ii90nbGJI36+8rFfzukrkLXCjizr0PCfTLXdQxM+CFDMwGojEx/squ wQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416ws207-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328IRjxv036440;
        Wed, 8 Mar 2023 19:44:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g45y0tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:44:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEan+mgOw5I3d9XjBKotEonm2A75wyuhyVWnaNWjO7SbNEdgx4MXdM/NhWbGkTiQsKNke74dBsz0Lvs8q3i8fyi1MfCSi5BeUJseU02O+mBPHcEbAOrIW8KAehAbFEe40TKAwbx8Diyqj9/D5tMpj3u1QrNyEbt42bZ0zcO8DRMrjSOp7ok5289mv25AeKyNFXUze7jqQJmkZHeY+F0JvZd8K2nAsRBgA2bEqtvbosE0xtgu/gW+LQWfIYHxc2J3A9VMJIHe9HeLYh0e01Gmo/NEzpxsnvlHGPWZlAVIhQ2ZWqocYJnnTXEuc/RpBEM0RVLWIOVvIo7wvMVqFuobTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6jMqgfm3V8Qj0PUS9PAemacGI7PkMRtMR7kxzto+5w=;
 b=W5BNx4CcIh3wy86K4s3eJEo65gHs1b03jOC4mTZLoaDsEus1lbTlazCl0WWsxaz5xOn7nDD6TwxeTgsW+Lco0aKsaThb1M2c7ThXg9Np6SAWC+CTfF8MYZreByY/L7nOASWVb8xySyfWad6eYMBKZImJZuzpFP9O7TqkOfGLd68U9ujA+poxt0VgAPoXoubQI+wbXznyqWRAVmh+13P5ZJBUPkKkRUmtNWEzuFc/ChzrY32PrjlJpEFWJVwC2K8DXfoE0M+z3+JlMmmM08AtW4peJzI99xZN+oUH9xbv5hSZgZjx1eE0Ra3zRjFeuqVE15QlH0aa1ScX95k6zNNlhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6jMqgfm3V8Qj0PUS9PAemacGI7PkMRtMR7kxzto+5w=;
 b=Wv8uga0K8m8edlp+S0LJq/70PN+zqCSPkQgZlUvSlFPoKBlsk9kVMLgcDXyB3IXd7BFCWYPLuLr8EQdHe4s6EAZHwRsfGRd2Uh8HaTAguoaggsNrYJkhax3TkTyOOwVx8f60IBrk+xWzYY3/Te/J7zMDIHO6Q40EHVTGyy+j/Bw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 19:44:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:44:26 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH 17/18] mfd: twl4030-audio: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:43:06 +0000
Message-Id: <20230308194307.374789-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0273.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: e54526d5-3a04-4900-062f-08db200d867a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPm+dd+NorQ2nIYSqw+vXh+5xvzND8qVnVdNgjsfSoXuEgZpD1Ijb0I0UEx0Za9MfQ/W3pMYUHCXr2HXM4B3XUeZKhNlrwXpDW7uO21fqmZSj0/m49dYAgEUSFpsscLQQn5mfRTUy5loxvN/3e8DUtamKTQGJyyCgRqIdJge3pdFNKn/vrkI6CbKZASta5oIb93Qctq6WaE4FyeQrexwMHiP8BE139K7MtIr7F/03OjB75iotQBfPbGD2B51w/soZDlcRhmkrbMAEG+CPgXCmWun316Huiz6m9+APh/2vn9C1eqZRq/GcIQuC8qKv5Ak4bZa+TG9cjt0GKYXT34/ePj4j7Tv/XpnGXo2o4Rtn7lL6U99D9E3vtadC7HpUkIxgdrWYd1bnptoFHlANCdFAs4ZsL7T9cuQOa1eewV/PWoeFoxfWI2DIywmseGN6OyvMeWbh3p5x/sjeuO6sglL5I3ioVbGR6zEC15MyDaNC8Q6uEF1NZEjzIQC3HA+rDtHvS6BZ43Yg+dsrl/66oFWNfuXEvFSnhLg81amnm0E2sJ54WqrbsesoBpiF7qnSJMj4bbNVWVYFRcSuxhhsJwmZoYrb2jTYhGvuLznu2zzHbQHM0526RheksGbB904LuC7oi0+wRdtiOvYA4oBGUghsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(44832011)(8936002)(6486002)(83380400001)(5660300002)(186003)(478600001)(1076003)(6666004)(36756003)(6506007)(6512007)(316002)(2616005)(54906003)(86362001)(41300700001)(38100700002)(66556008)(8676002)(66946007)(66476007)(6916009)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQ20GsvD54YovrcREvt9B8OdMUkriXZEvbKSwDkhYCCFzuhOJ+ikNpECnkY5?=
 =?us-ascii?Q?NoUL4fJTsqP8KAvUCEpTvqV1BLF0yp9gaS4oQOQQwJJXtUuaqZPz+6UAvFNy?=
 =?us-ascii?Q?8keZjUskL2sa2jlok8Uhz8Fb8OVbrntn+go3aHeU7WiOFfPTyXJENmgW4tYo?=
 =?us-ascii?Q?pR1+115KqLLhAUBkXItOEeVvj9Ru/dP1gdfCmdqUzS+ty4FpuDxAI9dAIQSf?=
 =?us-ascii?Q?R3/3p5qeyoODE4TvEIx77YhZdE4FngFWVI3vvd4yrDOqhExxCMtbDnSeLDtD?=
 =?us-ascii?Q?SHmEVOLB2bkBxtT8pBKHdBwb/jMKRNcdwFW5GyjD6Yg3rJEy+rALHp5KoCBw?=
 =?us-ascii?Q?NjCxsjnl3X/4nx9q6dEej+ScK7XKeHQnnoSGd+sWMSTn5FdWjCB80ku5H3OH?=
 =?us-ascii?Q?2qrau+4NqE6nJG8AceS7Qc8pLig5nX7mlauE9zNVr5IN41i2Uy4tj4iGdvvt?=
 =?us-ascii?Q?IEM4fr0wIOX3bu2rL+QaxOgoHaQrNJ/zf8W8C/QFX4PwxpDfRxMRGJDTQB9A?=
 =?us-ascii?Q?TpcCtpxsBU07xDox3N/HLKUagO+rEzL9PkM7JKp0whX5hqFfEdYElKuDqxSL?=
 =?us-ascii?Q?dvV6Vy83Cy2kptH6WUV3mv1Oe9xLLF+kopeax/+g8a+i+4ZmY7ccHekNQ5HX?=
 =?us-ascii?Q?VTB/ttEoxszgNK1ohzWkKlsdhuSEK6RO6Oe1hALNoeAPu7feSi3Nu9+dgdg3?=
 =?us-ascii?Q?1VI9JSheunGGCn+a8f4R5TFj5+m+ekAJXI0hNKrDqzTewJuUs0dvraTFrdBg?=
 =?us-ascii?Q?T214lHVgmfSoQFec85qtPtDWwhMQ7duNhnGK09es6EgiUwMwb5ZaSLgxDwNK?=
 =?us-ascii?Q?sdOBiwyB4IuUYeHuHsx0XGvVvkNooZgMrWFvby0MLz6SrC64pEGU1mE6YgJs?=
 =?us-ascii?Q?dp/HKFfN8SAPaGGw0yVYxf0tqKB5bN0huUQLWpAC25MwakIQArUUGNDZr93c?=
 =?us-ascii?Q?dkDeft6wO8hmOR8+hdZGhcUvn823WY6rkG+nbDjxmDfa1qJUKDeueDsfBuqV?=
 =?us-ascii?Q?P0O+qdbH7BwnuEccA5ypwxnfOOcLxwjsF+ELX41+FsZj/i3wf8Jggg0l1weR?=
 =?us-ascii?Q?h94eI6t/phaSmCrDikyF0tw1nOLOR6nH0uEw4BAHi0HFQTInIhwvT3UFYqkl?=
 =?us-ascii?Q?ZLeUm31RDFjcvRGz6i8fjjZHVGOhyfBd6fzoMlg+GxsMliTnbsWjxOKPqE29?=
 =?us-ascii?Q?Xrvcw5cYyaJb/Gp1/V1o6XJf5ss/uHaXQsyh4QNUkr2qtgLbkbmPJQTBUaP1?=
 =?us-ascii?Q?/AsNs+Y9cymJdwDH5Y5wDf3BiWRmVr+44xP1iSjL8TDXCZUPSHk5u1aY9oB5?=
 =?us-ascii?Q?DU7WlJcXCtmXqGAsQZtYWYGTB6g+rHsMaVTP/d+jvki+E2bxlUMvCWrlBPgc?=
 =?us-ascii?Q?lPCgqGtzIojkMCV33EKrYqRYFDzro0ER4QcByTMKzmzKPvaSzLtwUJzL7WEZ?=
 =?us-ascii?Q?K3QXYczXnXB71f2qLCZcLI26eI1Ezt0gwFnEv+obLJHryEYK07HxQg+vv2C/?=
 =?us-ascii?Q?C+NuTwOVChq1XUi/AvXYfW2Ut3fhNueiXYha9XQKV5n879sM8O37F8Srji4D?=
 =?us-ascii?Q?fIUQuRNp+qSwKcl5go1iYLk5R7LT+7bJrRYH7tfRMcDlniISRGnBORL+5U1o?=
 =?us-ascii?Q?4S8i9WeF6s4Odj+BZo88rRE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 19P2dURI5EkIYHSw5nvLznTWGb2dliQtxVRJ0oMNhEMvGbf15D4R8Hg/LG7SMJ2JSpCL78FDRof0wlZEuXkaHV3umKaKWjU1+vdp7hUtejYAnhzniDDENovtQIN002WgJuxACDVqNLN/gpXpb9PheR4MUB5oxFI4ZCh/krFNgE9qlN2WTleu7GA66yGAay6SZuRYySFCr72sxGV8eKCX5qa660YIUWglumwF0g1mfjqZL4I4wbvg0om49bgVRQ6PJQEDA3Hg6YYU+MCWAFrhI+TozHDUpQK3javpqhz7cgqByxfELJixvXTvm1kmjkxjDtHA7hw8bO+91pQjYDtS+vV9u048qrPZwCC1sjsn5L7JHJ75WUvi6O6jxNeF7lKI2qYbIvCN3BTfxnxD3Onzon45aepKyVtWYbZBRQruyXZlOkio6QISLdS26zFnHQzHPeWrL/3EXEcPZvTgWuQmYhpuYzhf68hYGuVsTTcyOb+9opFj9rLTReMdP/EqEt+rqb4O+IbWPF/Oy/RkSaPCkPT+w22i5OFGeJ9yE0PeskayfElLeFd1orIfJSO6GlphLGm1QlSCk00n3j10EsQDg/l86AYTY9WksieRDSLQ2dGMdBQBBf8JCPN4IQ09nnW1Dg4L7j880vCjqnPxJaIMSJrFZZw71HFRuMzVZNScOQ8GxTT+TN5wbyKfftEmbMZILuqGdH3tsfx72eL5vRqDbvMjQybAZ+b9sMRFF1xRTtlZ9/nDm3B9KaMZrg1+ond/uSlNZpnN5dPQJrX/D0Qu+VUsvJJbyb+6QTlmq9hh/nTtt4tXHH3m+knkS4uSbOq+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54526d5-3a04-4900-062f-08db200d867a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:44:26.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQkuUHYanhg0MPvgxFiaxWRXKUzXKkajM268ejBUz6iaRuqXnt6WbwxZrQQTARVlscFavytNtto5x6ZRQbnrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: GLa7TnpBYa4s75swCrsAQGssPuF4qEh0
X-Proofpoint-ORIG-GUID: GLa7TnpBYa4s75swCrsAQGssPuF4qEh0
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
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl4030-audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e4..88002f8941e5e 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -285,5 +285,4 @@ module_platform_driver(twl4030_audio_driver);
 
 MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030-audio");
-- 
2.39.1.268.g9de2f9a303

