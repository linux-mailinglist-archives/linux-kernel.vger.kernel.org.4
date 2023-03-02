Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C296A8CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCBX1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjCBX1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:27:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4EA58B57;
        Thu,  2 Mar 2023 15:27:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6cKq005226;
        Thu, 2 Mar 2023 21:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=7jpMoXnBh5eLGnV4A4XN9U55Y8SkHFS7NVga94qZ9FU=;
 b=OVvzde8XGMtx2B3VbSZGQehKl00391ECmUAQDryifcQvWllU+JwCzUcPzJDbW06UO6sE
 YGrU5PqtpvQvN49pLyaa5LHRCthjIEiRkXzWsD2gynr7Pgx8CfTdutLco1gA2oWYpbhN
 9v0iZRmlMKsNbcavznKbj0ecNny1sajJlhpXZmzPpw9R4GTlLRHy7CJE5YEEo6At5c1G
 Foj53WVu26KnQ/kdVR870ZMvb01C0S29xkV2WUQN+uTesh3FNDmJfrMTRC6OKjwFkEUO
 UQ8NThI2hZvCngCJtEo5cvyvWs0a0A/7Q8eZqG5YSwJNoOV+qWFSurXCyoXSli5M75xd 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7mw83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322KkpPs002200;
        Thu, 2 Mar 2023 21:19:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sacfdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5aBHWZHAc19rcCsmLnlG9hxiiqiwDkmvtrHjRMsuAjnFurYKsJhuq/GJCIbwOeYkqtK/47GE5ywtqJS0mu/7iXwDMondZou/9jXLHBvbOv7J8huIyjYHHGHB15Q7afCk4cDsGhY4AI8VWdtXbrJVe4lFCHLYQFW2vT5YZAftWcCOE+Obd4HPWZP5hj33CZQYmMcoMMP2BXHy9usXz5FM4906iTEPhUoGZ7E97WWL37e7TycGjkEG8pU+tkZ1LHT6QzGc6NlwrMa65VHzuyd93TVt/hgj+906cWxt9ByLI4ChQkGg0sy+vIjhqCZdRF4GqmCO/YxwrkYstJpGVz7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jpMoXnBh5eLGnV4A4XN9U55Y8SkHFS7NVga94qZ9FU=;
 b=YmSKR/hXlgOFF6be0gH1q3I/rfdLJqXUdsj/pxXKw/tuPodVZQQSae7ECeygVGAleeigPXM0lEVlspJ6RriE7c0aB5O18u8/hQFIRB+/FmYtjtB5yp2vQMOO8d0ZLGt6UUVWvfoV2Wvdwt8LRXoqQgLxn16OOppIVKp1D83Vk9gAuasof0I4rGsLgeF/44zzqRjzO3knCbPQ6wZguBlsFRigz023o/lrjpru9BtK+/usc2SScvvmD06Ee/2auA8pnfVYJ+M1GLMA+KWF2UdJlZH0kocwNA8i3hqPO+qaBLlnYajkMgO4gtJF0U4vJvUU/otMIPVFr1JAoQqd6VwBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jpMoXnBh5eLGnV4A4XN9U55Y8SkHFS7NVga94qZ9FU=;
 b=J8+9IXMHPZinrjaVq8Tiwkz6Lp0u6Ip1rafYC+vQor2FuP+V0JKEkKcpJPAXv/pt9s10EIUdCDf6PJA/Ntxm1hqbkJXNLbGPBal74EC8+NtanqlUsPP3PdfNdF8Durb1e2JI8iVuz/wWFmfroepSjU6MX89DC+8CJPy2aqsSfLk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:58 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:52 +0000
Message-Id: <20230302211759.30135-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0290.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef90a28-0c0c-4d60-f052-08db1b63bc74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwk9AjtwAs2KUSC7mCUVarMec3UcQcCxQsClPHPyh49m9sZRIhz2lfw6cHRfhPgvoqDwacby0aHcvmW41+jen3k3bUki1QTGCoin6U8gRwixvos9wUTXVONwPA+7779MLfB5Tjh1IkvT1Iyzl2Sbp9H0XmjJ7i4jXA5FgSUsKhTK4KfkgCrPp/78I5AryhHScOFvTSXs7hPxnQczD1EXJNo9udAMKiHbi4dYsuV3wqnnGdBkEJJnYmGMIQJsYML2KpBDPbSaoiCcUTN5wLDlPpNWTiJ3l3vfdZSJSmd98HvxY1wWAHUeNdMrrJKX04q3D4OZTFpmXuiI2K6HGcQMfYD1JJpy9vjK90rlRJ50dAdyB/282DHqMJg7KQ8xLq2aH/RL+oimeV+ptOKMU3zNERG7ZoJV6KBVl2eDMKMcpnKX37593U3U43Jr4DbYzZgNJ9vWyEmF7pMK+6xhUVrJEyMOMNCVgAEeN6WBJUvHN7TWmHSqYX91sSUTjff8RKmI1uWzOAekS50btDKjh2LmTO0bZhb/6AE4+OlzppAkJdw14MsVlhPZBAs0NQIJGN9TrnqiXNs3AlP2nbb286LSe88Rmeciqtp1DFCawuYa8p0U1oDoc9xPHDjp38+1TB7zVm+rymzOb81kUo/hMoudSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ewU/kKWlPCIQQRA3XzTfGglomemxpFAt4XEjOnhwDGdjycSvSQ0oDvUZZkuv?=
 =?us-ascii?Q?OKk2ZZDmt7WvIVXajGit591JkKT3wrrWz+SB1EQp+6jqxI5ENAgVckbwHl+q?=
 =?us-ascii?Q?e/z8jKRdgmy126pvtZkQPIktxicQCe/KLKegSvkCUzk+I56A147Ogyt91eoA?=
 =?us-ascii?Q?R5F7GWlXjWfEea1W7f4Ij4HZZkkRB6bQnxXs4dsE81l87tKJ4czmm4VQEvhp?=
 =?us-ascii?Q?WjEYsXLwSzdTtKTh9RIz8KyT4tn/g5IKVwm9pmbD+A8V+UlXDFpwaiOahKZV?=
 =?us-ascii?Q?w0NDvwDO9+XpnmMaQDAnZzVWgQIq1tAun1lYaTL0eG+KPmH0ixSGc78SqdQd?=
 =?us-ascii?Q?IrjnLlGZIYHeCvZj4szRipCVEO9IduLJWusgehZPqoUlBymVg3PsE9ukhPr9?=
 =?us-ascii?Q?uSeEC1CkIWTF6FCXI/sQ13Oq/B7CnCXkpWFH9yvqj3i9huns9/3Lsdg7w4Ng?=
 =?us-ascii?Q?8gSeQUE3TFlFbv8rHG+dH0H1s4BUrCxya61ORDcjo8Fh7pOhzEtJI9txfRl/?=
 =?us-ascii?Q?gZmR83oIHPQedup07AoqeXt9dTfPHCXMRyIhghkxRKKb/KNPpE0PnQq9LPfx?=
 =?us-ascii?Q?2jeHh/Sv5GfT1TKHkjF7hICvcjzaWx03sK7Uv8mntfvSe4cNOAvASXTp7w3v?=
 =?us-ascii?Q?WFSc+kk/u3iLw9QM1s7Qt/MfzMzbyvVof4aaOv1w46a21DcQ2wyIJWYFkOp4?=
 =?us-ascii?Q?haxX+eFSmYsSa7S6/BS/EqThEpfnAH/KD35XxuYf4wXYoUW8HXeSuOcKlzk7?=
 =?us-ascii?Q?d+1TfMOrRU/V40kM6ZEwGuqBgXx9jfnxFG+Nmo21BghPygm8kaCfRW6nGPgN?=
 =?us-ascii?Q?W3JduXcIp+QzRZ3R/4R6rBEsasetxuVVmbbEyrSClX7caKefC7cUCf8oQGGQ?=
 =?us-ascii?Q?w5auDVkHINIGrlRaS4XpinFNJ9/OZADHXn/Qcu/r7snjxMoF+Rg6k2GBaind?=
 =?us-ascii?Q?fBDTVlffCTGGp7If6Dk0QGqVdM1CLYYpA5sO2J8Q2Alb56AJOIA72aXmQFRD?=
 =?us-ascii?Q?Wxo4RQql0Vsx9CKuY16Twd6AGwBEyifXMeFub7UBj3J2NUxHNUDnfyOqq5la?=
 =?us-ascii?Q?RYhpSe4celcNG9rn7aGmRbHFpBgcOCLAQPyKsw87WMkh0ohvRvppKz1EAULD?=
 =?us-ascii?Q?Hbe21P1kU9TOcpdxwnR7eRFGIQWoM83YtJmeuDO8vIPcaf1oHkOtegtYgNx9?=
 =?us-ascii?Q?0AeWvLoXDGaUdTk6Uuyxaeu4zzd/d10cY/C0P26ksCKzHORO+xZ5do9BbEnI?=
 =?us-ascii?Q?9wyN+hc+FD2fQKfYxhcGwr7omXRwRfSwHrN0p1QUHLJazm/EOYFelVN13q0h?=
 =?us-ascii?Q?Dz/AkMfQvBixc0H7yKUT9OIQqP1vlyRWPRaVOcb3NlqPykckMtjIrV2VF0xd?=
 =?us-ascii?Q?fNL826GGasj5boOZeOiENis4SYxCkS0VNo4s0yk8emauPlM+ely5L/SIXaOl?=
 =?us-ascii?Q?XJqW1b20OfjTWG7a2Un7caWyux1CB4S15HuXCPWme554T3rYTcKO+k7BEQuO?=
 =?us-ascii?Q?ZIA1n7NTbnumsS6s1zRGdT4DdEUUgis8iJmFxMfe/1affdK2TZalNsSJ96a8?=
 =?us-ascii?Q?5FhqvAhHUmu/KEur2m0+TacAcWXUt2BJ/TEdXL7OkoWutPKWpJxxHLDh2zFp?=
 =?us-ascii?Q?xmbhRoLJGNzHv7okgvTzYWo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ScWTLufpqZVEeuhB7eZEiCq69aTXNmPNd+UPnxlUNQu9sXHdUdiNRO51UwRNTxRH1XjsBS1JoO2bO9Cc4xY+s/eeQ0aks6VSoVjxdoVphCzjyRNfg3LCoQXYvPGmRUK9Z6F8V1zCGhqn18r56uDipjeI8LAD8FA9RgXCgJ70j5SRDh5iv7L0lcVqABNhX64kELkg857l/skxvBTOk0GntaSe5Ov2wuPZpC/tBa8sRc0QCstqR1zL8uJPIkXw9NV+OgIE5DU4+Jb5b6zgd53RJEwYa7G2C5IU1bnavgmJWI8B6sn+qpkXlOaxb58tQmJ7/4SoJa5E/gv5zIxiAYgcvKj8bHu/VqSiUWxcK3J+47ivZW+xjtMf/cCwlhY9hylvPQui5I1uf0XEOGFLZq2Z/4lgh8IJtnOvfMzAUGuiqGBH/btpAPMgch5SgU7WIXO5xJUr+VsqI9TfytB4O24oISaJk65G0QWW2ReZ2gt/8YkovHrUBSQek987BPCsosdrlIPsWS4Y7xyHctWnhI50jMRa1VRToD8HFd+SNkkKjRvAhgTUkUYpAgaGGGIDiK7j8B0jheaIsm12IJQJ+wVOFYSzGtRbvTrkdu0tWf9L1h4E7ncbsVNLT61W+FObH5jrttWiFCuFZ1aplvyvChL2NfSYdpXCreGcop3HP/Rvp2LNw5VJLhjFLvbKlDcIWrwN78e2E7bZ+fisFcpVSaIBn1F519hXjzk7oTlU16wW3zsGtqVZFK7IorSpuz5OaNOiA2vhs+sEnrGyBtlDDdar67HbkwPx3dgcTwXUGmqL5iY6+qVQRplfpXinWeba2iozjf5Omy6jcE7tJMHTsKBxtHT/u7wdXBcna+9MUeGuXF12Mll/CzRm1Yc5OzU3oAaK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef90a28-0c0c-4d60-f052-08db1b63bc74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:58.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2UVbsyVLDTJSLqnhLLCFiF93aHJcN7IdcPlFBLW6wHjOxkujkDfTUe+wp3j3P7OT3txptep2AcRx75Oi4MTjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-ORIG-GUID: OBS94HZ598bRzthn_jKBLi-TIhOesPxc
X-Proofpoint-GUID: OBS94HZ598bRzthn_jKBLi-TIhOesPxc
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/n_null.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index f913b665af725..c24f75942c49d 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
 module_init(n_null_init);
 module_exit(n_null_exit);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alan Cox");
 MODULE_ALIAS_LDISC(N_NULL);
 MODULE_DESCRIPTION("Null ldisc driver");
-- 
2.39.1.268.g9de2f9a303

