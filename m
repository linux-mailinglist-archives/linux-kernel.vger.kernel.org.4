Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6612570875D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjERR4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:56:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DBC2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:56:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrcP012408;
        Thu, 18 May 2023 14:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=da6ehd7axUic7ozbVPDbIbv6pwVFIrZh9LGE/avpY3w=;
 b=QGadCQ05E3W4uCHPNA4ZIhhro6RyoDzH8GZLM2EHTeeMmGSRseOYer7lJYcLTsA90au9
 igVZ0udCnRLPtFsP7Oj6+36WI9r4NuKNFDolarPpZt243sYAwtA95hTVaBG9X0NvswrE
 a9uGWceX8sTADFEjcdBibuTL8AlWFjpqxpk0LRadJ/No7KR4A/k084UiQQ3Bqd+UoZ7n
 OFiZO+ebtUCwkB9dXqB2x3066GFWwzeWr8n1U0XN1o9/y1CZm7ey7qtIDnASukW7axDY
 bKB361exWI7B16N0kQiQeaAvq3b+m+xWgUX9/tUz8F2ZYEPbxkfFLyxGmnN+6vz3wVZu Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjr8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE6YTd033869;
        Thu, 18 May 2023 14:56:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c7rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQQn7MC5Zgoo5bCdgl/SiynRzo4tA4njw6oPha3MxD7ZjKJsjeiojWPg0Y3yxcLHz2pon+1MCBtelIprpAU5SnDUR2VWB3Q37h8s8fs03EJlXc20ESTIRRcN3hmXcwcEA7uuAyQEAFH/IhqafhRmlOa0nIngj9i7wZbR/mED1Jw9lmJDENd5Y6/L691GT+7YgXqdoKU8Tt4RdnFt9F597oEpSYlk8msj93ieuXhgIIq3BmpddiSzlZoln0SXQJzTsat3gGT8bmTb2hCWNJtqeURQbDus/PLMS+bV+JKIJXBNAP8lLsWYRqfdXmV+zGLV1DIyGJ5Lmyi13O5t+Xgntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da6ehd7axUic7ozbVPDbIbv6pwVFIrZh9LGE/avpY3w=;
 b=j7ThFABXUhHG94e2HEIdv5OlzKmt1K62k4hLsSgTBV9+WPNzwRrDUCZr6GXqfMFqnAyqeFEfAxQF3RIqJ3sOANnCkmWtbKzr+TqfksBEiVYGdUd9+6XIaSkU8LMd8iKkeVhqHuqjaEqKGP+lWhs9560moytxNx0w51/tFalN43KhD6PkdL87BNn9lqIuFFl/H1+aG9YD1gsOHA7EvL9MX0R8KCTAsm7DgNILQ4lbPKI79iyjqoSZMsUtG7V7wT7Ngjhc/7tOcEeKFv8ry+PaILMzTBMTz4CWWGTGVDzyZNKx2vkmnweDpZCQqb34/PmaOLmjWJv1VYPLHaeqKxXxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da6ehd7axUic7ozbVPDbIbv6pwVFIrZh9LGE/avpY3w=;
 b=lXyULhhCNdq9dohecBHtPudL31A5N91WXBXmPIW9pNRJ9PYm0fUTHmo4d+UjAVamo/K7Cnghn7XUVCZYKfXRxqa8MKFFX41qjdZQGc4Ak2AiVz87EM6xree6t1XsC8nqCEEKOGjWSY95G+uqXnuxlEEJJNQzRYGAcm6nHhky200=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:00 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 05/35] maple_tree: Add format option to mt_dump()
Date:   Thu, 18 May 2023 10:55:14 -0400
Message-Id: <20230518145544.1722059-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9d5a01-e651-441c-dc57-08db57affe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyhsSvnznNAaIQlo0UZs3+p1I65YiEqIqlYmGohIqlbeiv1VSGvDAMY2VixgwSwiw3j9u4f6rgXdfoQDbNz+m3DEDpqHIC4PmriJPaJ5YP8NnwHsGnXfPUTzD4Hl4Ugpvxp9c1gtctrHTVW/8Xg1w9Zj3PAyMbEWf/0k/b4nv0LDuHEI9iIBAQBeEJUkcung8K/iHh791FqaQhuZtY9tUUHa8g3Lkog0piM0YPRRiv7VqkrZYCkZYtLHUTz/YQAbVgz2THCoBF9Ge9mSDgCisVgfEr748oogBNwR7M6nq9337ob8M9nrNSbLRiK4sjVh1SlY5LIv8ab2fcvMdSVjgiRqHphHjtI8V3ZsBh4BASgYi4wt3/P/sI+gpCMby8C/Oa1W8d+GdemMBQJKhRVGW/OQkizE9xmYij2yejwpUKCxKKRrzJ4gFf2P4Gy2C9oKizBd3QUALJF0mAURdOSR8Jwuc14R1OCocQiY1+YRCHb7GReIQQOI+qqZta7NJ+fDKsJZJlY7q0RyP3xShpf2RdsKLdcCSiiRQaotwY/lmKIyL7JtGUDkFX8RjXuKETK+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(30864003)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWMiATzmfxKtqxhYyZ3/PzZ4wWMFpPT+UFp7Be4344E7ROVnozC00eBi8AW4?=
 =?us-ascii?Q?FknXXl64DiWEkVHEqbfqVstmybzPRgWYQfkRyUcoFIAsSXkxTbWnGazvLzVX?=
 =?us-ascii?Q?34muunyB1HvbylfQu/bqdsVkxudBrDb1gs9jzKnhnFz84PrjvxR7V4d2oT1G?=
 =?us-ascii?Q?BX4ut2ldXlw0noC8NgOXQAX1ilUshfqPFerlSF0WePmC4v9uSLq9oXwgjWPr?=
 =?us-ascii?Q?gkeuBJRNzL5STOvPw5hv20j+kCp9bk3ebBHHsCTUIeHD36w6NoeeGUn0vn12?=
 =?us-ascii?Q?8irzGfLC9nLKuoytD5NwozxNqRjh3a9YPgnRW9bz4vUoeyG1srYnRX8P4Ft/?=
 =?us-ascii?Q?XnyZS1RHBybag4J2sl7zSZ3SOC81IpgIQBQ7g/AHK+RxFpQsDU9UFjAC7vfq?=
 =?us-ascii?Q?EXnXSx9+pt1aCF1t3Jbf7PlsSVu83gHi8YCX6pxp7EJZGG2M5LDx//P7Za+x?=
 =?us-ascii?Q?Uae8XEo88HyIU2zXyJCwNsfZsocetjHyvY18flxN2P6Tnl6PjKo52IvEGL7S?=
 =?us-ascii?Q?vmY61pNv/XUIA36q5sHCKD43akX3Ses+ZJKZdp2RHd9d9uOmzGwJ5D8K0LCO?=
 =?us-ascii?Q?BP6g7zGKQmI+ldrs70S0ct9t0UqicNXUIDZYDa3Zefab2ZahlOnMgNwKsdI/?=
 =?us-ascii?Q?mx2qWWiVuYynw06EWVS9LSGEvTQCaOYrlEMk6vDXjbdeVt9CNAPPJ/fgzjt0?=
 =?us-ascii?Q?T71JiTYqgAQwGN0EvIAu1dcFWBow52QPkH1+5NkhXSevXVcsTwWU04uNpkVH?=
 =?us-ascii?Q?p5Z9yorijzlL07tGBus52yR19h/pSdwSoGFMVDHTKYrG/+ajEG4VlBLIkig2?=
 =?us-ascii?Q?A5Hyk7Ny9fgG0Ael10RcKD+jgW4fehb1UHYRIiBu7HbkBjzoeKZRv2wHzty7?=
 =?us-ascii?Q?EsavkTJEulDEnomMbPV4pvMZTYHEzKeUXDi3/macQxivjwUYbQ4vua0AWpUs?=
 =?us-ascii?Q?8wfWPTmPCkBPIQskCOtmo6kGSqO2S0lbAPrRwrowjyzzeSs9w1GRsvsRvMc0?=
 =?us-ascii?Q?kdkRCGpHS52hsUpjUfRzIQYrFSnF3Dj4IOYbdCFcGul7c5qxTotGBMxYJB9R?=
 =?us-ascii?Q?+1rNR27m6NsMgL8qbJUDZgHnC+TsjEqQuCI4whby4wQsOO1JpM5iAHVVtz+c?=
 =?us-ascii?Q?p1NU0P7VxjDoVNbqoXLTZR8IyvduN/SHDhKeS9uWsaQAuuEjan9fgQaIHdG5?=
 =?us-ascii?Q?hIHI+n4gU8EEDsDsi559nJhjhLDlxhj9eFG38VQmCS3VN9ZC3AN+hipv8bOm?=
 =?us-ascii?Q?wa8CYZGld1y822i6p1DVQOwIHs4eqLzxge5k8rNWYfbUQalxGQmiA9I/J8Jt?=
 =?us-ascii?Q?/pa0OGi+pP32DVXIMOs411C9PuGWJpjy7fnJbrN+RA9MP0IpHeQWBiKnHqKk?=
 =?us-ascii?Q?8Fs9+9erLTEaZV1kMokL11UoJXIGAA88zU3X2wbS2ugVcH7GX4FCI5HB3BBw?=
 =?us-ascii?Q?+/fLMUTXYFHnJvnkpWppS2/7BGQ5wTbuJg+/Xsc4kWgjYaAtK+oFb35zbW0D?=
 =?us-ascii?Q?qaMyqeGOmH5ICcu81RPPAwQbG3EHcZYzuz0O4QlecaRQGxAe48835JangTAl?=
 =?us-ascii?Q?e6mXPQQ6x/UxlSxea3XrXrX1YsILtC7MU8TdiABzSCdXKwBQ+5np73LOun8e?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MWBWvEJ+tmuMAuEGeV63LlPAIqd8WZIClaNLHMKcLZI6WiJFEpmuZZWyQNnhemL9DFEwLH7dggJvt+7FZe2Z9GJuN0kFp4HTroFFiW3sUpi+ZzSzas5Vv6v7KFtw8rO1KaM6AKu4l6yWnr6SbNHPD9WQAxFkO6wPLGbtJ0PHrl4n+Ct2zyR6QmOQeqoS9on07UlD6eTiU6EsXr2XLXNeZ1qxsVkj1+vGbao+IgOE0vbrZGB6gpKTlgE3nzGn+bAlvArECXEDTDpMnY/RT4uBXxrypTACCx8BYKaO7KJgQZQQ7NMhLvsR8iq7DIrbHZCl3VKTPL9ertfpys5Szt6Uh0B3jJy+b/grW4AY2bgCsbm2asE7BO/TkgaBinH+ZmezKpA3Nx5dL8Tpt0KyoWO8F2TQj3HWCDbFPslgSDr1EXuxuecetppm7s603YwgkQyYGtkJSKJq1KSiKZ84ItxgCt6f7dkDz0TxSfB0UZBivX7LbrNpj6pZyEk4IAUbXb+ggAn/5ryTqhwqwpiSCZUat759HNN250dfAo6KWjHkuvn0UfXpU/dybfaFEVXU1r8zRYtrBLSMKm8Gwcvm86jHVzBHiFWyB+WvgtqfkumtV8R4SokMHOQtD4vTXYlkOWvOGxphc5KjgHvWMRYyP7Bt5Hk6JvDH271i/AmhYCcamaTr6q/71Q64xxBsv+bV4e+q9fUINqiwxi9w+FAbg2AQ/xFC30ThqhOOBMICCw8p8Uy4JeKR4kGr/ogE3MJ+p48AGnAIElhWQ9c9OZRY5tqrQd4ggxqxRScK2QVJhulqycAL03e5MqN/ZD3HU+28BwNpWP3uUa3UmALU6RRnNnN2nVR+YoJPhVQBEgjJVnRRgURWVSXCgmZ6RVJJOdA4GXE0vqBj5JZnrHT9QcI4cBL+Lg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9d5a01-e651-441c-dc57-08db57affe9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:00.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBG9APpBe4sb65LMmXx2iF/0SrVIssFxchEEGMeTt2sauxlu+GX7qKLMB+uytKXXSZZarpKVdrPCdhC+w7ljdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: c7Ia-eVElTnO90cOCSIY9-NYyRUxkCnZ
X-Proofpoint-ORIG-GUID: c7Ia-eVElTnO90cOCSIY9-NYyRUxkCnZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Allow different formatting strings to be used when dumping the tree.
Currently supports hex and decimal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  9 +++-
 lib/maple_tree.c                 | 87 +++++++++++++++++++++-----------
 lib/test_maple_tree.c            | 10 ++--
 mm/internal.h                    |  4 +-
 mm/mmap.c                        |  8 +--
 tools/testing/radix-tree/maple.c | 12 ++---
 6 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 1fadb5f5978b..140fb271be4a 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -670,10 +670,15 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max);
 
 
 #ifdef CONFIG_DEBUG_MAPLE_TREE
+enum mt_dump_format {
+	mt_dump_dec,
+	mt_dump_hex,
+};
+
 extern atomic_t maple_tree_tests_run;
 extern atomic_t maple_tree_tests_passed;
 
-void mt_dump(const struct maple_tree *mt);
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format);
 void mt_validate(struct maple_tree *mt);
 void mt_cache_shrink(void);
 #define MT_BUG_ON(__tree, __x) do {					\
@@ -681,7 +686,7 @@ void mt_cache_shrink(void);
 	if (__x) {							\
 		pr_info("BUG at %s:%d (%u)\n",				\
 		__func__, __LINE__, __x);				\
-		mt_dump(__tree);					\
+		mt_dump(__tree, mt_dump_hex);				\
 		pr_info("Pass: %u Run:%u\n",				\
 			atomic_read(&maple_tree_tests_passed),		\
 			atomic_read(&maple_tree_tests_run));		\
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1e7e7249a0cf..084868865849 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5699,7 +5699,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (mas->index > mas->last)
-		pr_err("Error %lu > %lu %p\n", mas->index, mas->last, entry);
+		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
 	MT_BUG_ON(mas->tree, mas->index > mas->last);
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
@@ -6753,22 +6753,33 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 /* Tree validations */
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth);
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format);
 static void mt_dump_range(unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
 	static const char spaces[] = "                                ";
 
-	if (min == max)
-		pr_info("%.*s%lu: ", depth * 2, spaces, min);
-	else
-		pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	switch(format) {
+	case mt_dump_hex:
+		if (min == max)
+			pr_info("%.*s%lx: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lx-%lx: ", depth * 2, spaces, min, max);
+		break;
+	default:
+	case mt_dump_dec:
+		if (min == max)
+			pr_info("%.*s%lu: ", depth * 2, spaces, min);
+		else
+			pr_info("%.*s%lu-%lu: ", depth * 2, spaces, min, max);
+	}
 }
 
 static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
-			  unsigned int depth)
+			  unsigned int depth, enum mt_dump_format format)
 {
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	if (xa_is_value(entry))
 		pr_cont("value %ld (0x%lx) [%p]\n", xa_to_value(entry),
@@ -6782,7 +6793,8 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 }
 
 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
 	bool leaf = mte_is_leaf(entry);
@@ -6790,8 +6802,16 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 	int i;
 
 	pr_cont(" contents: ");
-	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++)
-		pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+	for (i = 0; i < MAPLE_RANGE64_SLOTS - 1; i++) {
+		switch(format) {
+		case mt_dump_hex:
+			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			break;
+		default:
+		case mt_dump_dec:
+			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+		}
+	}
 	pr_cont("%p\n", node->slot[i]);
 	for (i = 0; i < MAPLE_RANGE64_SLOTS; i++) {
 		unsigned long last = max;
@@ -6804,24 +6824,32 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
 		if (last > max) {
-			pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+			switch(format) {
+			case mt_dump_hex:
+				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
-			break;
+				break;
+			default:
+			case mt_dump_dec:
+				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+					node, last, max, i);
+			}
 		}
 		first = last + 1;
 	}
 }
 
 static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+	unsigned long min, unsigned long max, unsigned int depth,
+	enum mt_dump_format format)
 {
 	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
 	bool leaf = mte_is_leaf(entry);
@@ -6846,10 +6874,10 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 			break;
 		if (leaf)
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 		else if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
-					first, last, depth + 1);
+					first, last, depth + 1, format);
 
 		if (last == max)
 			break;
@@ -6863,13 +6891,14 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 }
 
 static void mt_dump_node(const struct maple_tree *mt, void *entry,
-		unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_node *node = mte_to_node(entry);
 	unsigned int type = mte_node_type(entry);
 	unsigned int i;
 
-	mt_dump_range(min, max, depth);
+	mt_dump_range(min, max, depth, format);
 
 	pr_cont("node %p depth %d type %d parent %p", node, depth, type,
 			node ? node->parent : NULL);
@@ -6880,15 +6909,15 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 			if (min + i > max)
 				pr_cont("OUT OF RANGE: ");
 			mt_dump_entry(mt_slot(mt, node->slot, i),
-					min + i, min + i, depth);
+					min + i, min + i, depth, format);
 		}
 		break;
 	case maple_leaf_64:
 	case maple_range_64:
-		mt_dump_range64(mt, entry, min, max, depth);
+		mt_dump_range64(mt, entry, min, max, depth, format);
 		break;
 	case maple_arange_64:
-		mt_dump_arange64(mt, entry, min, max, depth);
+		mt_dump_arange64(mt, entry, min, max, depth, format);
 		break;
 
 	default:
@@ -6896,16 +6925,16 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
 	}
 }
 
-void mt_dump(const struct maple_tree *mt)
+void mt_dump(const struct maple_tree *mt, enum mt_dump_format format)
 {
 	void *entry = rcu_dereference_check(mt->ma_root, mt_locked(mt));
 
 	pr_info("maple_tree(%p) flags %X, height %u root %p\n",
 		 mt, mt->ma_flags, mt_height(mt), entry);
 	if (!xa_is_node(entry))
-		mt_dump_entry(entry, 0, 0, 0);
+		mt_dump_entry(entry, 0, 0, 0, format);
 	else if (entry)
-		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0);
+		mt_dump_node(mt, entry, 0, mt_node_max(entry), 0, format);
 }
 EXPORT_SYMBOL_GPL(mt_dump);
 
@@ -6958,7 +6987,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 						mas_mn(mas), i,
 						mas_get_slot(mas, i), gap,
 						p_end, p_start);
-					mt_dump(mas->tree);
+					mt_dump(mas->tree, mt_dump_hex);
 
 					MT_BUG_ON(mas->tree,
 						gap != p_end - p_start + 1);
@@ -6991,7 +7020,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
-		mt_dump(mas->tree);
+		mt_dump(mas->tree, mt_dump_hex);
 	}
 
 	MT_BUG_ON(mas->tree,
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9..d6929270dd36 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -219,7 +219,7 @@ static noinline void check_rev_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" %s test of 0-%lu %luK in %d active (%d total)\n",
 			__func__, max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -248,7 +248,7 @@ static noinline void check_seq(struct maple_tree *mt, unsigned long max,
 #ifndef __KERNEL__
 	if (verbose) {
 		rcu_barrier();
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_dec);
 		pr_info(" seq test of 0-%lu %luK in %d active (%d total)\n",
 			max, mt_get_alloc_size()/1024, mt_nr_allocated(),
 			mt_nr_tallocated());
@@ -893,7 +893,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 #if DEBUG_ALLOC_RANGE
 		pr_debug("\tInsert %lu-%lu\n", range[i] >> 12,
 			 (range[i + 1] >> 12) - 1);
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
 				xa_mk_value(range[i] >> 12), 0);
@@ -934,7 +934,7 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 				xa_mk_value(req_range[i] >> 12)); /* pointer */
 		mt_validate(mt);
 #if DEBUG_ALLOC_RANGE
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 	}
 
@@ -1572,7 +1572,7 @@ static noinline void check_node_overwrite(struct maple_tree *mt)
 		mtree_test_store_range(mt, i*100, i*100 + 50, xa_mk_value(i*100));
 
 	mtree_test_store_range(mt, 319951, 367950, NULL);
-	/*mt_dump(mt); */
+	/*mt_dump(mt, mt_dump_dec); */
 	mt_validate(mt);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..4c195920f565 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1051,13 +1051,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
 		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
 		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
 		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree);
+		mt_dump(vmi->mas.tree, mt_dump_hex);
 	}
 #endif
 
diff --git a/mm/mmap.c b/mm/mmap.c
index e96f96c69c34..76eaf12f1390 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -301,7 +301,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
-extern void mt_dump(const struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt, enum mt_dump_format fmt);
 
 /* Validate the maple tree */
 static void validate_mm_mt(struct mm_struct *mm)
@@ -323,18 +323,18 @@ static void validate_mm_mt(struct mm_struct *mm)
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
 
-			mt_dump(mas.tree);
+			mt_dump(mas.tree, mt_dump_hex);
 			if (vma_mt->vm_end != mas.last + 1) {
 				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
 						mm, vma_mt->vm_start, vma_mt->vm_end,
 						mas.index, mas.last);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_end != mas.last + 1, mm);
 			if (vma_mt->vm_start != mas.index) {
 				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
 						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree);
+				mt_dump(mas.tree, mt_dump_hex);
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start != mas.index, mm);
 		}
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 75df543e019c..ebcb3faf85ea 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -1054,7 +1054,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		if (entry_count)
 			MT_BUG_ON(mt, !mt_height(mt));
 #if check_erase2_debug > 1
-		mt_dump(mt);
+		mt_dump(mt, mt_dump_hex);
 #endif
 #if check_erase2_debug
 		pr_err("Done\n");
@@ -1085,7 +1085,7 @@ static noinline void check_erase2_testset(struct maple_tree *mt,
 		mas_for_each(&mas, foo, ULONG_MAX) {
 			if (xa_is_zero(foo)) {
 				if (addr == mas.index) {
-					mt_dump(mas.tree);
+					mt_dump(mas.tree, mt_dump_hex);
 					pr_err("retry failed %lu - %lu\n",
 						mas.index, mas.last);
 					MT_BUG_ON(mt, 1);
@@ -34513,7 +34513,7 @@ static void *rcu_reader_rev(void *ptr)
 			if (mas.index != r_start) {
 				alt = xa_mk_value(index + i * 2 + 1 +
 						  RCU_RANGE_COUNT);
-				mt_dump(test->mt);
+				mt_dump(test->mt, mt_dump_dec);
 				printk("Error: %lu-%lu %p != %lu-%lu %p %p line %d i %d\n",
 				       mas.index, mas.last, entry,
 				       r_start, r_end, expected, alt,
@@ -35784,10 +35784,10 @@ void farmer_tests(void)
 	struct maple_node *node;
 	DEFINE_MTREE(tree);
 
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	tree.ma_root = xa_mk_value(0);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node = mt_alloc_one(GFP_KERNEL);
 	node->parent = (void *)((unsigned long)(&tree) | 1);
@@ -35797,7 +35797,7 @@ void farmer_tests(void)
 	node->mr64.pivot[1] = 1;
 	node->mr64.pivot[2] = 0;
 	tree.ma_root = mt_mk_node(node, maple_leaf_64);
-	mt_dump(&tree);
+	mt_dump(&tree, mt_dump_dec);
 
 	node->parent = ma_parent_ptr(node);
 	ma_free_rcu(node);
-- 
2.39.2

