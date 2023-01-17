Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5593C66E4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjAQRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjAQRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:16:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5704C0D6;
        Tue, 17 Jan 2023 09:15:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGSYSE010491;
        Tue, 17 Jan 2023 17:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=or+alx80QTK1rdYob2DTBo+WqIGJBCgdFbNavw1SvXw=;
 b=Jd2vzkeL6rfiE5GM/coqoalAfuPuW0w97fT/11JXGVK0KOYyaIgj111HGqvYE1OggYx7
 4jWa+kNv38HoY5HdjTC8c4kmb8QCEVDN3IvcwTCcMlyvFLpur6db8KEQkoCvxTpLtXMk
 HSHRndzTXUS4TV2myKz1+1/mmVPT3SyhGapghZ9CqiVxITPxFrfpKPE3FpBRYyUmOrmc
 yLV6mKUuWggzXJEqmIhUzzWcdtGRcBXd1tj8sPRUEUqEhaZLsj0I7+ISaxVrCBBW5ibi
 WBvsrpZp3+MKhRT74Qi36y4snUKGIw98sqICC9wALbxlxKU1p/nMemkXKD5hltMGatqN ZA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tnb3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 17:15:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HG7awi004833;
        Tue, 17 Jan 2023 17:15:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyywu08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 17:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwWV2lGCw1GKyf5qKPMj+30Obv+wSRnGmoOd4Urf5ah4scFcSrEc6PLBXivA48Tkeyk80v7oBqyKrGLYrrrwueIZkGsofP+0qA6msJ34AvNdf0AnQ+Zs9KByDUR50Ux2myhKhgzUIjLTiDRz9y6BmQwrTJi1qy6PmgyXcOyDp4/AWETgQq0PPMkMJ4Cj0BJZzHthp/o5Y6vCoxe9/lWUW74OpxFxN+aLvBKWlgkLn4UqlKDbf5FYck4jtAKng35yyRrE+j2StxuImq49q5oMUKK9Rzc9qzQ4Ad8vcNQUJWUmx7grpiSF86mJ6bwJItmA81CZQpHdL0dBIKmj4hynpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or+alx80QTK1rdYob2DTBo+WqIGJBCgdFbNavw1SvXw=;
 b=Eg4kZNUf+muBTbEUZZ147N5wgQeOcu5PKD+0vq8/VK7Oe7vIki9G3QoGnXyMDlvVYDb7yIgv6Ym/SiQ5bpqnnzTRugFTgJz4oP1Fun+u8DR0pS9ExZscC3athIhYJMGXVpEV7Hf2IZs2oObdEr51gezlaiJ4rDfQQ4xLa+VryVwSy9BuOmZKF7VE+YKv0aIVRV4WPc/eJFdL1ECyp5CwPmGdZHkdlwjwalRpAnrmWWpqxQAjVZg72WQjUv9aZYhSOiybO0tLJxnkIViIg4/i9FeFE1cVYFGi0xoEE4OeoZ3I+iBb5quagYl9PthTPHkqomu21gtmFjmGAwtYX8T+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or+alx80QTK1rdYob2DTBo+WqIGJBCgdFbNavw1SvXw=;
 b=wzaz3ANBB+Llnjvyo+oF0O6EEXFAf+/TPM5xBuzIq+rsGXOVe2Q9AqjkIdTXqyTdGjxwxYyaUTv+4CxlW51oclk0Hxp+e1GGT434QX1K8c55qwVFzYUGmtOufIUt7USf6ElylMJ/JpXUhJ0OFYkzUwBHnJKxjtTHxJhnGCLeZYU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB6738.namprd10.prod.outlook.com (2603:10b6:610:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Tue, 17 Jan
 2023 17:15:04 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6002.011; Tue, 17 Jan 2023
 17:15:04 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, jarkko@kernel.org, dwmw2@infradead.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH] certs: Reference revocation list for all keyrings
Date:   Tue, 17 Jan 2023 12:15:06 -0500
Message-Id: <20230117171506.3888602-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|CH3PR10MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: c919589f-4e93-474c-1739-08daf8ae5f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6QRA2c+4zoHF2zX044TGUxHKoV4IKgNyzItwnmVXOhGWmmJbJ+93el0kcJlxPtAb2v07/aTmn0hob0qWIcdYQC0gF+WYKnODjNrhmErI2vF1xFdhPDMqrp6a1l6QJZRGuEt8nujybKifrqk7sL7HhNYnKtgY66g2ZVOd7cDQakAFhTgBRSg9OQcZ1WbM9zzBENjsBLbXhCoUbrky3px1UY2Bva8kkLnUAkLJSpW60Uj/zxyhr07zCPm8RP2FakzYPEUgzkKO9U7fooEw8UcCZAP1bGHeDT5GznKXTrCrvgvZF7RGQhz2pD7iqowcPokJ7ZNr8/j2C53A1dYCsX8qXBDM8Iuy+rrXCZaMuPoVsVuhK8hYHkWORuAAvkYfTzClfZBjKoh4QODk2pGZ8mzclSJ8UwKOU8S24YN+tWNA0ZOvi8tA87ONKd91++eXvotRadQR14dABGiVPiusU7fJejRmq//d4GNacJHC+f0um2E8J3F8fxl6dc5EVLEXT3QYuiRLLo/YYi7u5dY1aMiolX+QKXO9Q1UdK9GbBk2jxxtlSFzDLST+5fvBzXOoIVhh/BgZrK9lzlmrdYpwWmDihqxW2GRMa6uQZLm9ouNvYbFlwkLnlGVIrzaAbXLvyHA2atJ24SMwqle4hTxW4ri/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(36756003)(86362001)(8936002)(41300700001)(44832011)(5660300002)(38100700002)(66556008)(6486002)(83380400001)(107886003)(478600001)(186003)(6512007)(6506007)(66476007)(316002)(8676002)(66946007)(4326008)(2616005)(1076003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LExz8e/ldT9GWEs89gSXMqhA8nhnWG2/YeeiJ7H71goWTDZUQ0UX9i2HfNb+?=
 =?us-ascii?Q?pDYCAjE3AT3isPENHleFTVN5Xprhh4sgl60L+hPZQJg1Ht+LoWtkabVXx3cr?=
 =?us-ascii?Q?pEzQniVYRrI6TpM9LaUy7mKscTUN92z6lGvT5TaZQx6arpLCgy9ikO91o2Y9?=
 =?us-ascii?Q?E73fsyrCiOKXRQKFRCzfEte7Ax5OQM8UxCWNSyzIiDGpVVTu2qE6mri7h2DC?=
 =?us-ascii?Q?fsAsBTYJElLYIAZr2nqIG+0VWlb6sk42xN50q84DXYaLiVdDTAelIxlvn02U?=
 =?us-ascii?Q?8OcXGdhAVIzmd+zqtarKGeTimdDDbtSw7aVKi3rMA+b891OM6vJS4zXHSUpZ?=
 =?us-ascii?Q?V/1E8Lill/gdXa0g4fAGIWBomiY5mLOvhFWIUFp63gR6JzBkmsDpEJ14r4PE?=
 =?us-ascii?Q?9Ns8sPGuIHETa8I0sz8RALk+L20zqW2+cykb2RDpBJ0kdpdwkidEphHz0aU0?=
 =?us-ascii?Q?Rl2qbld+aOC+tv833PM8CCPsP/UX/5vHt2Di6slJslXhiLUslyMYWcfNZCkR?=
 =?us-ascii?Q?ufH5e5LNiugySsMH/Z5a3qCCm/vNiOc3tMVU80e6m7nAQWCTV/el7vQDlziy?=
 =?us-ascii?Q?dGYeWDozEqAI0Mo6bmi0lYc+baqowaHoYtzoaGRnhEN2P0H7SQplKX8tlb0j?=
 =?us-ascii?Q?dwM7WKzbiSZijgmrBOEjHdFTbkWTlRIujU+eznXElh3Af6qhD57JzuZbIQli?=
 =?us-ascii?Q?PgDjPB2/5XAqN35srg9x2wCiEK/OORFvfId5qzwlNNjGf213Uwwv6mNfskM4?=
 =?us-ascii?Q?GlBjTeBCK50+GY5lyg84RXO83LTcZMLhWAuN+xNFSSC7bNYKZKGl0ez+eyya?=
 =?us-ascii?Q?MTJMdrzaRUlPOiwLNGbtm7hc3IU2UKIjOl3Lt5rma2GxSPfpllvAMjCzdK+H?=
 =?us-ascii?Q?aXVgjwzRUf7Vh0dDzlXEyNiANJNS39gpos0WAgq9CdG2vEqOgJLMiR+eGkwH?=
 =?us-ascii?Q?bfPp+vSSDcKd/CMy7oH4avH65gXR6V3E+NTQdEOXIFDZve/6evf+YVLOAsgp?=
 =?us-ascii?Q?4wuPfzlpuPic6x40k5CWGcy9IMWpkckmB/tYU1X3VBt1CeFuEbra/rTLl3+1?=
 =?us-ascii?Q?ORf4iY7rrcvRnQIznxl6eSluYjSROFb45J7i+Lj2SFv6L8Lp0PokGlej5Z8Q?=
 =?us-ascii?Q?8UfsHzMv6Iy51C9okjGS667uAvU5HifwnD4GrT3UDIbFW6Dv80uHHKyFC9xD?=
 =?us-ascii?Q?uIuMGZYPXAGP7QHRuw7MCpzs99MtULbyVl/ZQ9jHkDjuMqLMNrTj3hLk6R14?=
 =?us-ascii?Q?y7+yRwFSMSlQNuZO6Z3OBLBBmi6/E4qInUHI8KPnGHOTZx1pGhPykXyCK7sl?=
 =?us-ascii?Q?J3PIhSmgmwroZLTGOXKxHeDe+f3XeZ3zU6YgCUNjrfXPA1Phlh8G9tl3pQky?=
 =?us-ascii?Q?NiTLjsUeR5pwQV0gyUWSqVgdktl998O78be3jN2OU7jL+Om3uYUvYugo3rmq?=
 =?us-ascii?Q?7RiL4vxvKrd59oGVmLJoSDGCC2L1ALud9mAurv61qOG+AOrw9+2NSb3WUaMt?=
 =?us-ascii?Q?n7hSipuqBbCdsyMJvHec3xg9+fKpRczkqXNyZm22YhPBVt6/p3ohI9JdEF2J?=
 =?us-ascii?Q?t/aVj6Pp519gitK1fHwCeZoUMUt+L9EDWZNmH+TkdTyXxKSoPFTkCSIVOtfF?=
 =?us-ascii?Q?4iK+CUj7bgzWw2fgwJsaxmQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mnm5x0eKDjdObcVp45vmdvlOz0Ase7ChnGM/Sk39Bu+B0jy6j0HBmRsBI8D8XMgEPgX2ourtzsT3dAYoHuBVqw67yaf1lJ85NYMVk8FPDs/x/JbplhGwUE/dvHr8fO1B4p98wh0Hzr3WXK9LbrkWzU6UQBZUz8rT4c0BVsv8MKnI+HI8pQeKYSi6zre3pC6n3gNBEGY+CGCu1SCdiNdc+6t3n7zzpcmF0XteaeRHuVKlNbPNXv6JS5O8NHADoDw8o7ynTR6Ueah3vGc6D+c/gdR4JvVttmKoxmi6xH0N2JWLUiSlFN6PXMOG/hidMKPyj/S1Pcao3e05qkO3yE+xRBSdnZB1HbAAQcWNy5gg3h5BAgCmhk7uB+1DdSLfOXQ9V51PxPd2tYbU/tz5/5rXrs/B59IzjMsFDWys02eQufdA7altUVlh+Q95gkL9/4W7eIELQIhukQBjHX8thKbdH50dP3+B3sy0xBOTWTpa2hXPf51KBgPX0r3kcmZDQbKYSHhx9MbE8DBXqMGMBOrDAIjdmd/E0NcVhDl7Uwd5ztNYwRtCI6V3Nb7ncxk2l04G0/aawB/Ud/NSX4e3st2HiqMBx+eBcbior1pGN9G3hEDtVag72bN8qTaQmswRBhDI/SQYFyWudpsNvdMbh1jEpUeqiy6+cz48xBVlHPfWQRFmtH1a3fPnSlYiS5th3tJvFQ0oJDxy7fFU6nswvaOIMGx8r56MmF5pQZupV27a5Zf4pxcdWNygLEu3gREFDGxvnGd5RDwx2qI1hL3QulGf7z2/1+1ryolmqiaYwlMg0lQdQ1PscxPbsf9iGoD8N3LE2u0Qw/h9TZRF9TGeTmTCtlsmiutWoaqHvFFgCYSKAj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c919589f-4e93-474c-1739-08daf8ae5f9c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:15:04.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZWxiCWJd73CFQFmIJSGEdUGshHusmLPfCaYdmPv7cBCJX76+nmAOaLm6sOF8Xvl8P2PilZyQAyHrZXnXXDh8Th2BNEw6HBcHp4NPquawms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170138
X-Proofpoint-GUID: eMKCYlhN0uhOrnCkXSoXlZ6n6f1s8sPo
X-Proofpoint-ORIG-GUID: eMKCYlhN0uhOrnCkXSoXlZ6n6f1s8sPo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems booted with shim have a Forbidden Signature Database called mokx.
During boot, hashes and certs contained within the mokx are loaded into the
blacklist keyring.  When calling verify_pkcs7_message_sig the contents of
the blacklist keyring (or revocation list) are referenced when validating
keys on the platform keyring. Currently, when validating against the
secondary or builtin keyrings, the revocation list is not referenced.  Move
up the check to allow the revocation list to be used with all keyrings,
including the secondary and builtin, allowing the system owner to take
corrective action should a vulnerability be found within keys contained
within either keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..865a0510fdeb 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -243,6 +243,12 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 	if (ret < 0)
 		goto error;
 
+	ret = is_key_on_revocation_list(pkcs7);
+	if (ret != -ENOKEY) {
+		pr_devel("PKCS#7 key is on revocation list\n");
+		goto error;
+	}
+
 	if (!trusted_keys) {
 		trusted_keys = builtin_trusted_keys;
 	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
@@ -262,12 +268,6 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			pr_devel("PKCS#7 platform keyring is not available\n");
 			goto error;
 		}
-
-		ret = is_key_on_revocation_list(pkcs7);
-		if (ret != -ENOKEY) {
-			pr_devel("PKCS#7 platform key is on revocation list\n");
-			goto error;
-		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
 	if (ret < 0) {
-- 
2.27.0

