Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F36A8CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCBXL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCBXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:11:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C648E1A;
        Thu,  2 Mar 2023 15:11:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K6cKt009084;
        Thu, 2 Mar 2023 21:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=z/rOCmAvyi8i2VdWtpfwEs/0BfRAWc9YigOtYyw6vnc=;
 b=j3fvNvxgtryFqxkUWhyJ/F074yesaonRUO2GtV3YqupHEfPXZeW0C/XirFahm1YnTXTm
 hdp8kK+fM1GtU5rfqeoO3PP4lO+Q/MNzvzVG0QGlOP20LyPXJ5rRTNtOMecmnYAI0WQn
 JSZPZJfeT9NirZqT6CS5CJOMSBccQXS3WhbItuD/kurQsAY/9EvtSNMTbK4uV9BsbY/T
 1KG9owpmrKta8dDGwQ+ZNAcXahuiV/+jv+qMmtXLM+tOxcZGVKLye1rAVv3SOUoh3YoN
 KUBHoezVib0N1HGra08MhsLHlJYO2M/rRANwCv84Uf505I4KNyG/ggPYaVzCaNAopXse mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9an079-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322Kn5tD000665;
        Thu, 2 Mar 2023 21:18:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8samf3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR4RMPYJy+gMCB+9H9zzVuc6FES0arx7VI3/28SpJhHOM+1EhH/yoXIOmOZvzhCJ3cfbWukJ7wDN/MBujx/eaZGpz6eY9v/RmllClsLPG8y+SO0lfamo5682kNF71Zew78AbWMguqZUWwZtXlDkd5iQCxEaFgLwzehtrRa0jjydAkKoQISTC0Z8s7BiKoXisglG9b0DlNQxsb+n76Ne8DIO7Nt2dJ92XGGcOUCqYWbiZikoeXyrfkjRYHnObPwL7jEPEW0Q6QTmLB54AEInizASH430fH9uiAn0LQ2AhX3Q3ikM+Ouc/6SpS7SlZ1xUL1Df/+R4jO50PTyTUb/pwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/rOCmAvyi8i2VdWtpfwEs/0BfRAWc9YigOtYyw6vnc=;
 b=TtTj/ELtQ8wukbPIlTnUENVPAiYe/Ba/iVE9LlKUBOFaezKHKmpyx2WGVB+TLoNV5PmzQurWhFdoLYnQZ0Mhd93eiOt8QuRrwMttH3VLvDmvzJSRR5K/MJgi8zo37Inr7FcaudE8r6aWy0MWnJZNH5kQChJPj/lnv3q3zVfCZx2AssYV9/3NgEWM6FtQ0sK/Fo7WFCewlqTlyZ1TT7EewdQduzjww1SnNFWYMSAy+FZ8xGAB3A4lvIGos/6wehRonSzoOaYuSPiBFNZI0JStbL9B/FUIn2mWGV0bLpfu4AT7C6ulEIlIlkyWtWsdX5AGzs8Y/KX+QQ7ky2NzB4ReyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/rOCmAvyi8i2VdWtpfwEs/0BfRAWc9YigOtYyw6vnc=;
 b=nQTC0OXxRCy4pWmVC6dbVwHRUNrKxHMQ8Hl5ht0Z5+3F86K5x/pGO3L4LDGsIafG3KXXsRxG5gu/aMgYhI9RI+MkYqrx7QqFZOZdFY4CA0NDY3JmlCLz5rylCkXFF4IiH7xGQ+/yIiEGBXKHMY8/nI8Ix8/0hVt2/Lo9GeEgEDk=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 21:18:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:18:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: [PATCH 06/17] watch_queue: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:48 +0000
Message-Id: <20230302211759.30135-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ad66df-85d2-4a83-ed72-08db1b63b133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrtJ8BR3M2ExbAbEnivrAG2j5kH4xqenOXjhx3aYYIrxNdfjhy8elth17SWLpa/904hmWpc1Ekx69PXryi3c4idM+7KnbmlZNoJCAUzdDSgkgLo1czgIUcF/MIhV0jf7tB0rdDuwrL+1QXqdVMqgjiKUnV4l+ik1mQP2W/oksQvRBB1oTo0AzEA4C034SUJL58Kfx/D79wqiSyhcKr2e0RyYDD2P/Ttq1xUEHRooshOtFdEBg1Zd9KIknujnauUjVR6CnG+RW+QMfUbI/5JUz31cWXql6zFA9CblCJj+XLBEq5NLBLKjti+RgpppuQn3CjrtTSt1Y+9U07ETjfuQVkPeXy/77m0er6NWZQykwoJ5GzQt55h9qGFtrEiN49ewgcsqIbf3fqPJC6uJ0AePpdKRMsub9RLqBl1mXVVcU5I5auQylkHLvWnmW38mBbSbh7MKtIwcUGr2ik7+Y/6szsI4kgtuHsGVGrlgGYid5qztZoGYsPgN7jsy32GGX5T9nmE7NNfIW8HUs+q1zgZGLP84UvbeOZpXwflawVI29ppecUXZDzkW63QF+5OLQ7RlknvV8w6C9PBq62HJyfeDXcEmbH1kNU36qL6R+6MjlLQJniNu3fMb05XPGe7+qxmY1vpaLyWxeil4TALIs0Fbvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(5660300002)(44832011)(83380400001)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(38100700002)(36756003)(2906002)(6486002)(478600001)(86362001)(6506007)(186003)(6512007)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHmwGJ9LgAQmqIMknXnoAhCuhlV/T/SVjygRDyD1hhLZbKk5hQks0aVbpTNQ?=
 =?us-ascii?Q?81fj40gZBS2xweXAxVAwZUpps93UokhoVwPvcNOLV5cy78MzE4SoZOwhSqdu?=
 =?us-ascii?Q?waCTojWg1xJR5Du+B0XeiIYkkVxWaF8dIPGk1XzNKcGZqFs4gAcpyvcISOfF?=
 =?us-ascii?Q?wL5NlMuS01l2tHurJZbv8Z0sdLMorhDSI0epWeba1L/ilNeB7e6jhVPvU9Wn?=
 =?us-ascii?Q?2MXJqsA0uD+uneMd7eCqaZjzFFm/8fkcwKbfDX/pUr3EooHenNDgO0B6p0QM?=
 =?us-ascii?Q?t//IGGP0ZN73X4dDz7jTgHJoYuOKZPue6UTcRDby05ikuBDq2aoryiOxhfCu?=
 =?us-ascii?Q?w6pd5SIlCV0dRrqlaaX6qOj5R5CwO4uxTz1N2t5qdBLs3XFWRb1VOxgqBGcT?=
 =?us-ascii?Q?FLa/W8FlLWCPVj37HMmnsHOqQv/svle7LUu2G3D/nR/e12wnx94kOJ7jbCaT?=
 =?us-ascii?Q?ZYis/Ma5JD1WExIZpI7eOcUqWTujq9vJlq25pAUy3nLaO8F+A5MM9D3GPIMl?=
 =?us-ascii?Q?qZWkSgoFZJ05VhLwOPXaU8eScHOUL3ugEHAO8owvDCr+PodfzJDGxApXiw/Z?=
 =?us-ascii?Q?SGOU3L0dFsloKl24j1b0OwmzN2QcdQyWinO6usOj2QQ2gV7cKRb/da1D3UEG?=
 =?us-ascii?Q?I5tZKQkUPiCdHY47+vj+6O0NTxXJE+Ut+TGec3sfq6jlzOH4RM9Mt5BpAotx?=
 =?us-ascii?Q?66X8Vwbur7vThvuoTfSH+C7/2CYbqqzaMrM/XOrwrgbtRwUBSD9lcfPrp24z?=
 =?us-ascii?Q?QPGdPxTQ8VvhfMgd3gQIbf/VQ8EwGoumDvIYhvqear+pAN8ewQOPY9DFsXys?=
 =?us-ascii?Q?nRorBr1MkhNhuBa6lbPGEhSA4VcAWexNgyhPletn6b/g2eTSPus1NY43X6lk?=
 =?us-ascii?Q?u/v+pi8Lh6hhtp/Zvfv2GxFAwHVlbuHuq1cLCSjHka9ZRTddvih+hDcNIrqO?=
 =?us-ascii?Q?HZ3P8jHkn9emDH+lsOq70aAH3M9pZhsy1faypPMMLXgyQyJwELCsmoYwm0oG?=
 =?us-ascii?Q?fagiEp2nrr3PXqM0dSouoMOsQhZWEgRhrKgXF6BKr0NFKnJ6U5nKzP2p6NEd?=
 =?us-ascii?Q?BB2Qs9ovOonZUgysvClwilUJm1hi7snz9JdhdTcgSwi29hVLLQvtOLtb+4ZY?=
 =?us-ascii?Q?31OTLnI7+YYxdelAiehtWP5CzQoue/fflM1J9er6wCuYZXGgHZhB29tEH+Mv?=
 =?us-ascii?Q?wY82E0u3MAYYZCnSOG6YRU2WqV4pxL51+hpT2oOLx+Kskx7AFU9EgzLnEyfp?=
 =?us-ascii?Q?n/dk1zS8YahX1Zg9R8GrL0m9rJ2aKfPS+Xi5JlAFn4+sh1ev8I+91jeRWGFs?=
 =?us-ascii?Q?LuN3H4eVeLEVhYHiKUSXrl6tmFBRNPKN9hua0BEztb7yWWrZb1wCY5kmbicH?=
 =?us-ascii?Q?lPWz6YdFgbOHn3mBMepwwk3+IFXk4jKqyuZ9gA5vTGJrVhK2BVAD/nNsnZT0?=
 =?us-ascii?Q?MQNchXveOih4u5YVVLgJq7sxXwa6851UIKkPjalWn4zzX6SjnN0PH5iy8FH+?=
 =?us-ascii?Q?ntwW7CgyHUqP0oJ+A7cm0CITHUxbpP8/cCF0sgsRwPVmf77SAI3Fzocvq4Xw?=
 =?us-ascii?Q?Ljk/FI7Tv/cpEpUmF4mAIzQqS+2WjV07MVlPKZUnW4GU2ejSD/w/rxFEc71j?=
 =?us-ascii?Q?6IgqoYyEKfdu9coaj/sacME=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g5/sKwH9Dm0+pdPxo7mYd2rOKNxHGwMuNo6uT5v+23JT5ANTR+SlGCpESiqdglqcA9Ahl8FPsDAFgmoKsvLryzTnHGVvShh+P3jFmcpdY+uR9+Nl21wIvTwGsB6OG/rVITAzh767TP24oQ6sqgIzHQRzAYlzUUqRvLdqGpMriczFWc+bbG7ZAdEY304HarIn1kLjqRD9VFFF/hWwHCcCcZ63cvdvIgxDq5mDh79atG3IzDKQ6c/cSaPAB9LqmWPB+pvxEmay2b+lm0tD0dDcIawnP6TJyap9lOpHsSkDYv9jJaBuFMl1/Lf0csQxPFz4kIHsfgHajXC6zPAz38QBVPEHWspBcRn1SoKEl44nR07A1Z8rXBJS+g8hKNvM0DCBAwK/Cpymt3436b9lfZUghs9TK2DKuAujpWKtJzoXksKtMgK+8Nq9tCrdsYtpCxJVNJTmixOlvcsE9gcyYN+zS8BlCofIn7+/AeXIKWwHef01mSF18n7i3eQupOzPPESAle2r/60tmQY2U5AnIkjG8PhNaZtmKiyyxLyqbxgp+oVTFC5Z9O71d2TfW765dAhgU/XMTemdii/NY9yp4siFPWmHIQVYEdt2chcOHKE4c9QuUjEVG5e4AWWo1fF2TuFdYnJFTMaMgoYYrUHVV1avh0gA+LHdMKgVOG5hVLh3gBFYxi/ZCHn/RjfpZrIIHv75csvrJNw8/rmhD35599r/plvuUPiOvvQ+xdvfnu+0PckDdQHZPPOIwEk3nMsH9jIehz4qJREXn7+U4YsOBkBXqsMshT9TLnDGJ5vPZ43g5xZ/zFmiM62vs82gSHBjrNnm
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ad66df-85d2-4a83-ed72-08db1b63b133
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:18:39.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7jl8I7L63uCD0unHkShEZtnjen93E6hCrR7pnVogTLXGbygiv+aESnmNSPkrfm8MVm6gndKg/iZYeXkkokVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020183
X-Proofpoint-GUID: ngot_YV99ZEMd_twv5fGD6VcxspGrVnC
X-Proofpoint-ORIG-GUID: ngot_YV99ZEMd_twv5fGD6VcxspGrVnC
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
 kernel/watch_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c39..5deed017bef42 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -29,7 +29,6 @@
 
 MODULE_DESCRIPTION("Watch queue");
 MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
 
 #define WATCH_QUEUE_NOTE_SIZE 128
 #define WATCH_QUEUE_NOTES_PER_PAGE (PAGE_SIZE / WATCH_QUEUE_NOTE_SIZE)
-- 
2.39.1.268.g9de2f9a303

