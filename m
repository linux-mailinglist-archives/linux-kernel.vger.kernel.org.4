Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10B46EE3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjDYOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjDYOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:10:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3513FAD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDhpLG001868;
        Tue, 25 Apr 2023 14:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=M8UMuQxpQmvbH1W8NeGhIKkIYQ2+Q7fgiPOkD745LkA=;
 b=zDDUX8I0dvdmqR2Z8cfLgDPykjIpEq7q/Y0X7FDW6Sboi7CFv6cu0lL1N4yvNRGFNc2w
 RMlENCVU6HfXKHOc7TwUVrdmVknwdj2u5C+qefDmV1Jl3jBZtM0ltTibeQVO/EaKkmWJ
 tgAYUFVpHhnK+qhcyiS5jD7ZdfrfdUYMYrxpjJtcDgwf4AchjNNlHYwahBWpHHtREXB0
 OjieQUWgsrjAP1/+UdQjaExF43EcZ3hyPQCfTMM+yK68pI7o7lYA/H4fbmNBhGEINsVU
 Vgk8Gkaq799jR3+UIxyPcE897XnOlBE0ZzhyE8HfK3d2dqyqtNGkGK0dHVrB4v5g90zi ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47mcwfbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDUgY4006656;
        Tue, 25 Apr 2023 14:10:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gqrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbbehFnbvk6eBAIVyatUDVfOjDMQbGy3PQKMo+qMe5Bgsx/+3R+yM8AWXDk+p0ckLC9Q8BUo8iapW5r/Nb4abrUiwf9P1Q7Wbk6p5Ho4ay+ve2/5y6ab5dqa3TAJLuyZh1sPgIJIHzGZxxnWOpMh3MSrqSndDuEqYDVZqtEw33DB5baBGcBItBUVKundJSSsMQ5rxSrJxPOjX/iePu5EjZMvUy3aBGJZSHkgOJfQfyNhMO7SMKOEdKjmvimnMtbtbp+7nsCHHmV/vfFcKYjrBG/THMEwfgy6m4oL5z8yC6r1KdwXmCN9FI7UWPQeMZf+l7tum88LPBIoBYh2JpNYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8UMuQxpQmvbH1W8NeGhIKkIYQ2+Q7fgiPOkD745LkA=;
 b=Uatv503g37r57w+NHiafBOUCgTq6w94i0vrtb6gH7/EQqQ3ZPgGHl9IIE/hCDV+NBEALE1o8rE/oh2bgerwez3bhU58demjrvO9RHj45/yIBsEN5V8L40g01UAXKF8jzkq69MwELkaSRznuzRlLTvaDd/00bXMdx0K8ydkRuz+mdhRKNHg0EqxFb2EHVvMZUB3m6maFh0Yg/6qT2ouRw+4SwpJuxQjc7G9+PM+BV2c2mBJo2KFptbM4a26Fb6wOAsFb27uUwFflBxYUhT8D/w7ov3yzjdokubajOOv552Fh1hvKk4y43q7VEqJ/4bFL4VOhm51d7TYyoTHLyuROOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8UMuQxpQmvbH1W8NeGhIKkIYQ2+Q7fgiPOkD745LkA=;
 b=OySg8OPTfCYs6HbSKhfdQ1UvwBHVD0Gwf9aW+/r3OCy7N0DDgQyKSi8UpoLXqjDGGKm90LdO5Aclk1QE5Dek6iEIgHQ5xlJrbqcOCCdFeTMBJCliFOOp2fKrOHcuTvJFxs+LON7wdxz0FD7PYG16Gls+FDN8BLCbGLZlp+sQxYw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:10:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:31 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 05/34] maple_tree: Add format option to mt_dump()
Date:   Tue, 25 Apr 2023 10:09:26 -0400
Message-Id: <20230425140955.3834476-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0408.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7549c03c-4a94-4ebe-1fc6-08db4596d47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zD6YHC4n6X4FW1zgHBd2GGxxXlWByTT3+bUMJsFGCBKq4dJmbRotU1Pe0d1lLO3U6iLI98EE6RNgZuY7r+NaGGgcwoDaoLMEu2glxXOcynKfuZt/KTHnwKw/6Ude+gf0hzV9KgW4hFQ2/6L+Zvp9/yzVMIrg4KjF6aSL7GCudpcEHWsCiamHrZBVyzdvfonyYp2Za2rm78PKDLboYvTmBKTuHubqL+mPl+sUGnRScUZw5FHS+uHV6gY/4pOs4esC2o6kVRQQL59UkXjxpveNHS0rzqd8NHzzo9f/U1uaFaZxpzkJmgm0gwYCD4UEv3MLt6e1hTsgZL9goh53D+Luzh37+GxFaO4sTgu4bEE/G8cDFtq22fdpKzsUhyjVnJ+foobjiGNWlN1abzpD2pQYet3N1zc9VLIq6kaAqsRtE6OOYr6MYQxe+CgiBrunjkXfxmjcPTucIHUBQe9hKvgz8sHzz13IOQ6gKPunO6MUX5WihjRgkAtjxmL0m+tvfXvcBiojcldAxKVs3fYNUpTlAW1uQzjsLtBfGPOM5WrVEJblMBJzdQL/mSRRuhsRZCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(30864003)(2906002)(66476007)(66556008)(66946007)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(86362001)(186003)(26005)(6512007)(1076003)(107886003)(38100700002)(478600001)(6666004)(6486002)(83380400001)(2616005)(6506007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ddw+8nDZOfLu/eO6Q8oS72I3ut+JpJrLyLT3kYvh9fxVfMTTnLCzPpbUnLl?=
 =?us-ascii?Q?KmkjIKQ4BiSW710G/jaouvtqeR5+2aLMSBxSsp20GemHAcn/MR//Mv3Ek0cm?=
 =?us-ascii?Q?SY+G3EIXP/FG+wxRK9ZbQTz8Q6V1LiU0gqixrK6Io8nSii4VkVmtBoL7RPsX?=
 =?us-ascii?Q?3wG4FPz6zcdMXNBg4jSlr/MCGXHiA7rvil7zLSlAw0Dgc0sZOlOvN2l7qAW7?=
 =?us-ascii?Q?TxinAE1oMBB39oyg4m390Qw10Ss5XDco1/5IZ9RFe/X8v220IGQKmuW3i2g+?=
 =?us-ascii?Q?FbgmFnUnBLTGuWXwzQrCbLJ7omufA1FF3UzE04Gml5m0Lg3ITQWSxSrZUibk?=
 =?us-ascii?Q?YyckHwn8432NVGiIyfrrAGY9MdU4gJgN50Z1OxM9o7Q8YKGoGgUQxHeOqPFW?=
 =?us-ascii?Q?KqyN2WK2FlVkkHrKCI360s34ebw/dGj+ddm7kbuvOWChYul0hhLsmPa1pix1?=
 =?us-ascii?Q?WX3AGcH+sMVfCT5ePsnUy0Zc8v57vnWH0xbAmEtowKV0a/rHRnP4vOFkjfnz?=
 =?us-ascii?Q?WegfcBWImtccXmgAjNGxVR9SoQSVk3Wz/wrdgzeFXDYquQ/9a2T43emnIxXT?=
 =?us-ascii?Q?vqGT7RRxIBLm3bkWcU3UWg9PENHLb45b3WrSTwG0zjUtcE0e936qtlYv26FE?=
 =?us-ascii?Q?2PmS8rffPkGRdCJg+GBpCpOKzzlYz3GqNQpSnyUSj5VUNU6zST5Nmk3s4erx?=
 =?us-ascii?Q?t8pK075eoXL9n26+3yIQLX6ywX2Fg5orTSLUKTKbqD+Lq/3e4Db74wq2lRD3?=
 =?us-ascii?Q?jEyOTazFmglIukTVd6dwB1gRI9mX2iK3+s+71J4z3nzk6SFF33DqpjUch889?=
 =?us-ascii?Q?TjbnvgoeQEopI20WRUdZtKUK0O2W2UnAL+YC1yrEc0vPvXlDVJDKe59vlTKt?=
 =?us-ascii?Q?UVHniwRa8ODJdpKwQ8SlitlqZdFWa9Vo5iOS+Fo/8W8xgfzkitgXPhKX7XUe?=
 =?us-ascii?Q?GWpR13v0In2RIoyTiZGG5UkQDw0lpK4o/itDWWOtvjCqrYjiaVfs7ZWRv8VU?=
 =?us-ascii?Q?gOi5o2lZeUHOR5FBi7zQjjkH+6PlCcpJf6luSTQV7TzyYEP5Subjr356KArC?=
 =?us-ascii?Q?w9dtU4K8WyzWEVex6wYmmKzr+JUgLSnfl4cSzdv5DVBDRiBDZY8WvVnDiAyO?=
 =?us-ascii?Q?vqOVI0raKp5A5zFrPZSkvUUbtUb7rFRlVVcyYcUemglhQB6xpnBdg2oSRQij?=
 =?us-ascii?Q?rwNYuMMjuOt36RMtehLWT2EvY6YbDND7nI9mkETxZqNFXNZQ8DSt6GXTxs8S?=
 =?us-ascii?Q?tVH+1WS8pPI0vv6AOfNVjrCKGjgeHzJA9S/x3KZTbKwjjSw+zWElt5AtqHud?=
 =?us-ascii?Q?uQkr+CfIs8qX+/itT9WVsMWV9FenaH7i2A9ZRt1SEgeAO4k2VxfUl39FXUPi?=
 =?us-ascii?Q?W0m/l+rDb1cgqcnCg0D5T/V/q57El4B5I306EH72KjIg119KCK/Ga3/7sXoE?=
 =?us-ascii?Q?f4uR4PBUb9o1+YmHOtrGZuBlEBQWKlUGvCzVeJsAWJ4gG3V37I18g5uh0mje?=
 =?us-ascii?Q?d4Z0MUc9FDjuKn8gmfJ9qU8up+GUAKxIJ+lKWsAniuFBdyCm0xpwS07fdu+x?=
 =?us-ascii?Q?X7lz7RJ1BVpSoETvLeLlZalmHoDTX2GexZtqEIF50UombxURtiMATgZJXAlG?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MPOSuKWrGs8FudPmFuh52wxo6f0OBeDJD0kTQ1sWnXvnh0JAxiCHNKp9HvCYICUOfhxcZIfrOxZsA7IDCm8OyDY8lGLd5Y9Fino0352qL1xCCDoeZlxewt3sMB8x4yWYtoJM6LouNNnW0Ck1JKzot6iALYs5NuXUb1zkP0DS0DRb2mMZ2iEYzzJO1aENNFvWGtgt/F5WNZghlbQvkPsrPKoIqNyPnfj5KT61LimPwqlETN5mr3j0vBFKeOolW2QpX+WOLdBTcgq8m1QU0T4wVAC2WjCZjImqxlKzUpjBQuaUjTc4zGyTfHy2woUDbYTjNpUVbbx+LmD4imXrfokp1vC94f1C+jcjiS3nH0KZaanUmSeAFyEcEcbGJAw6rIv4/WmlGPdIStySDHfQ0XNqE94ORyKOXPcbXDRhpDbimdskiGBDMGkVEJizeU2QkJ7wJ1Frt1oaiYrr8LqtYYq7/fZhd2pyhqxYCFQgaoVMKxw2hR5blzvXU7ndkMv8q4wIH3uySXR4uWuLPa/A6nx9W6zalGuTG1bYaHJBtFrnT4FaewSqIipIZ/R68w7cm44bSpj9jcHjiRQ/CPCjOYmMU8ywMScq3UqqilWrIicerizZWuga5Gu/1ffdhUXVUY1eb4AP4FVB3VIsPejLsCrAdp1Zj/eAKajoox+HuTVt4glekFtLYVdR64CYoZv1QPkeg+fzS+a792Xg5nXwSzKn4jCow28b1e0jUUAb4FM595kHSt0i3sc1MvYOnRNwyADbsbk1XsN9/psIReSn+DamF1waAAAXQfbHxELCUcAKDyqfx/8LA18Ngja0iBRAH/wsJCvGqutdDq/s+5RwKpXPxmTPE1PgvbK911f9qq7skcYolB2qa7cw+PiObTMPzpglSGlrM7sOJsKChrz9nm8Weg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7549c03c-4a94-4ebe-1fc6-08db4596d47f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:31.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNqghwzQnwcKOpV/h2jDRJAv4gTvNJJu1MeCYgLgPnfj16VCoq15kv0IIBwoHZ/1qhd6YzN26kb4A9B52TOIXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: 3xO9_bMCJP6cWinIR3pQ7wWK6Ec8R1b9
X-Proofpoint-ORIG-GUID: 3xO9_bMCJP6cWinIR3pQ7wWK6Ec8R1b9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 1fadb5f5978b6..140fb271be4a4 100644
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
index dcab027b73440..535efc39f7758 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5700,7 +5700,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 	if (mas->index > mas->last)
-		pr_err("Error %lu > %lu %p\n", mas->index, mas->last, entry);
+		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
 	MT_BUG_ON(mas->tree, mas->index > mas->last);
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
@@ -6754,22 +6754,33 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
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
@@ -6783,7 +6794,8 @@ static void mt_dump_entry(void *entry, unsigned long min, unsigned long max,
 }
 
 static void mt_dump_range64(const struct maple_tree *mt, void *entry,
-			unsigned long min, unsigned long max, unsigned int depth)
+		unsigned long min, unsigned long max, unsigned int depth,
+		enum mt_dump_format format)
 {
 	struct maple_range_64 *node = &mte_to_node(entry)->mr64;
 	bool leaf = mte_is_leaf(entry);
@@ -6791,8 +6803,16 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
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
@@ -6805,24 +6825,32 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
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
@@ -6847,10 +6875,10 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
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
@@ -6864,13 +6892,14 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
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
@@ -6881,15 +6910,15 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
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
@@ -6897,16 +6926,16 @@ static void mt_dump_node(const struct maple_tree *mt, void *entry,
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
 
@@ -6959,7 +6988,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 						mas_mn(mas), i,
 						mas_get_slot(mas, i), gap,
 						p_end, p_start);
-					mt_dump(mas->tree);
+					mt_dump(mas->tree, mt_dump_hex);
 
 					MT_BUG_ON(mas->tree,
 						gap != p_end - p_start + 1);
@@ -6992,7 +7021,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 	MT_BUG_ON(mas->tree, max_gap > mas->max);
 	if (ma_gaps(p_mn, mas_parent_enum(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
-		mt_dump(mas->tree);
+		mt_dump(mas->tree, mt_dump_hex);
 	}
 
 	MT_BUG_ON(mas->tree,
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9f..d6929270dd36a 100644
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
index 68410c6d97aca..4c195920f5656 100644
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
index 536bbb8fa0aef..1554f90d497ef 100644
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
index 75df543e019c9..ebcb3faf85ea9 100644
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

