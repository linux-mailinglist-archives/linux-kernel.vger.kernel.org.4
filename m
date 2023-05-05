Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556B6F87EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjEERrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjEERrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:47:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82CD1C0EF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:46:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhLc8014779;
        Fri, 5 May 2023 17:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tPa63bPANKHAc8JBFv1ND1h+aRJpGkxzv6Wn7eeYyIg=;
 b=R0aSZ1ZitY5LiXrrBtuAp1RFmIIYDMY2e+SCtnUFQ1SccRxnjerB65dSPyMYQSOoh6Y7
 TwzxW3SmrR4BqUuGMr6YMFFBKIuW65r2B05/K7voGNWFWivzpjMoesBOSuh/K5rg5bhK
 eWvvBsn6JbG9WsHHvJ/mZfxm6ETn8yxNH45B6CzUaLcox8wOUc7x8D+otzUjZjz/4mKc
 w5650dfQ3Hd5w16QnPI7h00zWBIwoT5r1c8Wqtvm2iZhn3rdJQiOishpLWBOR/WM2oRy
 nzLZz+C8w9Lgnpuv9gEX5ZQzy8UskytIqZxOW/G0l4YIosw/pt/hs7Wosazzatfc3Vt0 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snede0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345H1IYa009860;
        Fri, 5 May 2023 17:44:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spankkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEAf6IOZXJ6mtGKq/Hg+/DaKljRLW/jrHZgPFvRbcYaTqme7LNdVRJ4oQqRLCDutwJXfdsQazRoiTS2jZgjk6pHGzl+ERpSBecuDPunsnuCuKvdbrdTGq9nAMjgYwx3ICHlkwckWaal71dRp6jg5bann7bfXjWaeTfqNC56dESpKBY2TOBec3UnxHPF0Wn2CEcNc7WyUNcsUdF1zKtzIk+VU0CaLed4D7ASbe+Is/tcoYaCUl6cMI35uc6BtxSBbvaQjIZYag2d1IgfSowUO7QFvKtfRoFE13dDOKBaxMDMea2CMkUq8Ri9dJnsqfcUTh38CcKbPngGg8aaO0pCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPa63bPANKHAc8JBFv1ND1h+aRJpGkxzv6Wn7eeYyIg=;
 b=O0WI8mU1JNq7htOfssJMMhD+Sr7JnbOTB4YjirdDz6EXSSc7VVzEjU1PN9VxuPUDGvD3R2J8QRtaXQi6GMyvfhBQ79AdZSM8QbGy29psxzAYM1nxxLhDwqfaytzXNpKitQfpRXfe6jOcABkYHjHZElrnBTub4R+XsA1BUi/hPPYQ/ZvK4k13c7dPHQ06FO/q2nh+45RpJ/7PBhkbuyi5ACTuDNtXe9NhS9GE8suASGI2zXRivgbF29v1sEBUeb/+BdFUWWzSCcJNzQ3QfOvZ9JFwojvHQ7pe3BDellLQFfd5ir2OXG2t8f1rdTR+iMl4wl4fB0EKPvrLpAxxONLKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPa63bPANKHAc8JBFv1ND1h+aRJpGkxzv6Wn7eeYyIg=;
 b=GYPIfb1usVhgbyewh3HpFbVkiFnVELQh1c9xFwB1MudicWv5jfMGBMiFaQv+8W4BN5BF1kETzgukKFDAjVxWXSD3hOW5cd9rE/RhYAR773oJSgUvxUMScCCIRWmy72xqz3moH75fFukOszIcnudCTpezUVqspNG/QiXdtNxvKDI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:54 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 31/36] maple_tree: Add mas_prev_range() and mas_find_range_rev interface
Date:   Fri,  5 May 2023 13:41:59 -0400
Message-Id: <20230505174204.2665599-32-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0414.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc96bf-1e3a-491a-1a01-08db4d906fb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ksz/gHHU1Ju6pYWKqJcqBUewojUUs5+cXPjlMsdMuZU331qWsSYCZKr6z/9Gjtk4NQJVMK+90S4qnSiFxHxfab3O2937kgYJGjG8kBQlZ7kOP/w9w52/m/b8Jrs+MqdFUPhnbfobX1xeIfWyp5rrCrYF9zcwKe/tHOvaUbqNIhHEac2gmsrWAvZjNfTmjMSIRojgZwWFz5lLZXn3yjOEIT9RIaWtvlkv4UufZaJACWPDQ+WADZf2dtL4baQZmuVeStHg2/ZcciKOxeYnnnG2SgwVvg8YfYAoUfs1T/ly61t1M8vPrOlpVptEhSwlmk/iRZ3otb8bsOFT0Xdj8mUskQx1MlJZmijTLR6GErWGUaUv+9QBTclc9/6sS29v67FBYo4jg+zuety/TOZlLLgZpxIwFwJXL6Di/9i4yNnIBbFHAl4OhNUBZfU1BIJVd6bU01kuN3t/W7BqkhWEuLuUyOHqD/1KQrrNqORCxvA5vlaQbN7XHcZZT/EygzrjDt0bLSzEaubM6b2Fba65MLIik6n7cEK0yCZ7m3GUZIMsLHBz2VSj2CZuf7Up4ys+vpOc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(1076003)(316002)(478600001)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2+py5iNpvfm2ZMC/+kQNxjdOPAUeYKQsXbwXpRJFCwlK1H9nVsJuLJiT0Vw?=
 =?us-ascii?Q?U7gNqSyxLQ4eBaG9/V/rJYFjEnfP0IydUHGgGxjBfgUN3NFYlclGKmDm/ipV?=
 =?us-ascii?Q?4Gi1nJQ3Cxh9trRse9lxeHd3gVemN5Mz7SWqGV3mK+F5eZlNWI6Agzmb+sPW?=
 =?us-ascii?Q?1K1U/SWizqsRQXLyDzxDHK5AFVpIdZU51UzgvYa77UX/SuZrSvFcRk+LpxF7?=
 =?us-ascii?Q?Co5lAuq1/1S9bhAjF4L2i+4hH1wL/CmmlN16y8JgiewbXtyk/Fb4LapF0aLK?=
 =?us-ascii?Q?ef5shzdEnUaAUuC0r6b9+EF2bGY8sRPNT8LCWOlXxGLyfuTWwHnoPNoq2CB0?=
 =?us-ascii?Q?jDZYPPS7uhMqFN+YTcSfvBt8BJ9fJOJBFTWBxR/sr4p6Tq79NcmsAZ7Dr3kp?=
 =?us-ascii?Q?kvAjIjWDewlFf1JXW18buBK71rFoaSL33IMApKPRZs/91py27ztbjBbonIIB?=
 =?us-ascii?Q?5fitGf6Xne5dS9ktMiUOq1CMb1PbGMEwPFIvswNS5CVJWE22i391fOTusHYl?=
 =?us-ascii?Q?gvL/TCAcy12xLfWf1+zmUi995/aKoN0hPt7KmTyZNeLjqiKO0UWDOy8scqKp?=
 =?us-ascii?Q?Q9eO2vkoxwZpXMwqL8vDQiHCfvoUdCCMgtlZ7MRDUGmcYbD/6Wr3OtMesG1Y?=
 =?us-ascii?Q?0ji3mmDORFFL2vCvdIY5+NcpflxQJLvWwVYZx8sg6nof4Pn6iloCTYtCVsii?=
 =?us-ascii?Q?/2OmN90c9ESsaG4be5ajvU3FCLEhscdmqvimuor7ufQvpIcF5fWAvv9jfDf2?=
 =?us-ascii?Q?hPkQCWhJNpAtl/0NnGBxt2eb/h3Pce9S0QTnOVZqZ5KJCr1BLzcu0Kw7ZLmS?=
 =?us-ascii?Q?7VFJJI9jq1eB9cpo+thk8QVpxsYMUcl1RPaX89RUXqOGAXSnvVOKsRpQk1EX?=
 =?us-ascii?Q?FW2DtbovmwX4kgBhRzRPN5+nAddAVpjY9jHKQ0VH5la17vHuWIN8ICyaiYA7?=
 =?us-ascii?Q?YU2e2eHVkSnwAhDCQfAK7w3oZHI6sJYa9xExhi1VO4QL3Y9tryUqbmCxg42Y?=
 =?us-ascii?Q?rDWytI2316z4RgPGJ139Yg68kS9GWRK1OUsh6J4+Aozz3DetwHKtw5DdQ8nu?=
 =?us-ascii?Q?iRMWjaszOfssemk5kcl4GWsQsgmGf9w6PUVRENi6OiT4LJ7bteNDmTf/MwKD?=
 =?us-ascii?Q?PPkuf2cTyayqfsnGjyLMA0l+FgGsGJmczngWktT2I8FeEEIjmryTDsVKYOSB?=
 =?us-ascii?Q?f7DS8Qpm4QlUvyuUV0RUsCTlGRQfwzLZSeGRK8JrW+kF0TXCjrSs35OoevSn?=
 =?us-ascii?Q?ehr1+mhvHIzBDWN+JPeIw6qKnB6rkKroCqxkiCGvmaBKSenuviKbQpiG7MjV?=
 =?us-ascii?Q?sJLdiHSPNmAl+BkLFJUKmrcCA+ozftgQ8wqB0bTqYStJvNweaetQXs0CpDiC?=
 =?us-ascii?Q?4wm7dpfdoo8n8fR5WlUSaNpAzc2S6aTJ62lc1kq8nlOOMP45qVMrDTvQsZM+?=
 =?us-ascii?Q?bSNl9paRBZWiC3RFI4+VBZIaxaexjKAoCzZMDEWRwCeyueKK9iF8wPff4D+v?=
 =?us-ascii?Q?Nn/YGgLSDz3HgE3t2WE6YpKbxkoPUO03lFRB8PS7YWJaU5Du5EXpaQeBCeNw?=
 =?us-ascii?Q?v8yQrsblMlYiu47CpwdiuwaGkBaen8r1HGn7kULLrtDYCy1DpDPvPsbt+/+J?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a4fM6A8RmU4BkPUJYpNK9+VlrZTObbAwjsKonpIjj6P3fEO99jFrvXQoL4EzVrIKNypJlMfKda9T0s4zwzRPRhvoX9RE0/zPh0oWbzrufv8Q3+fPuD5yXR52Pj6OBdXa1bN9MAfYWKEWrHa8fVh5GPSjnZlb7fxSzYXseWrZhwLxZEuVuC+FisJsdRtd+uzX+OSvCfjjfu2vwbq18NkF8COoN3Bm//9g1LGwQj/QQt4wFMZRGMOf/S0DI/tO92HCz3B2/fa/iRdFEuCyTliFXKoabENJmPpOEltnhtaAkH9MYBbDRgLB79ZoqE8JgHPLOAmrhPARXsZl2ELDnSYXTxEx5rts8399hi1SceYR0AnMmi9ganil+g3y+UoWgjO2Nn6+u28CsiGf4uFCjfLqe3BEFRVgHRZnyg/z1IosS0iVppuNeMYKe5gma5eWPwMtwB8Z/GBHE6Ss8t8XsxnC91uFQOVILkICzfiffJUIiCjIEi0oJMis3f832FZDe3nyKeeKcTHt3cHYY+kJKtYjEfhQ+VCIMIUXgsS2Gbe22U1oDP/b5Y2lPQoCNPvu+0nM7m3o02rz3hmFA4IFVxK1m2EP1eZ3coEPRsaXvs7G51UKkNbJ30gU8tNgJpCx2ODVh9ySSNqZ+FG332JD2dHfbrm+ehqF2r1nli3ZX1ubqPxZekKvptD1CcKywYRld9kvGk3BFkm7ZKhpo/UrZkeLWGjOaoWXM2r5prsGfyHRI4NeBAicRqTHyQQBIz/VzY+CIg7PjfR3ZhPkQR6jz3bW5thY/dOJOq41FvNYsYMdRPA4Ddbrdry+fDgEyh7ewv6fNUmpEdopijACd7iUK1xrudu5jurkBwzXjqD9nrD9li1zkXbTHVKhiY4qSsrfwz8dS08NYmrIDwv//nfvjlWO2g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc96bf-1e3a-491a-1a01-08db4d906fb5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:54.9124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khXMpdc/AlxjUbA2LahjqL8JJ2PTgY8aPzLRriYhjjSkFB8IdBJ5nYhDjkC7OKsq0gdIyNkWipVEYCIo/iJRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: p4grx47VenGKBkVqCEzh_UixfyMyIDKp
X-Proofpoint-ORIG-GUID: p4grx47VenGKBkVqCEzh_UixfyMyIDKp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the previous range
regardless of the value stored there.  Add this interface as well as the
'find' variant to support walking to the first value, then iterating
over the previous ranges.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |   1 +
 lib/maple_tree.c           | 160 +++++++++++++++++++++++++++----------
 2 files changed, 121 insertions(+), 40 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a4cd8f891a090..542b09118a09f 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -467,6 +467,7 @@ void mas_destroy(struct ma_state *mas);
 int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
+void *mas_prev_range(struct ma_state *mas, unsigned long max);
 void *mas_next(struct ma_state *mas, unsigned long max);
 void *mas_next_range(struct ma_state *mas, unsigned long max);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e050fd1f7cce8..f060c71965c0d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5924,18 +5924,8 @@ void *mt_next(struct maple_tree *mt, unsigned long index, unsigned long max)
 }
 EXPORT_SYMBOL_GPL(mt_next);
 
-/**
- * mas_prev() - Get the previous entry
- * @mas: The maple state
- * @min: The minimum value to check.
- *
- * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
- * searchable nodes.
- *
- * Return: the previous value or %NULL.
- */
-void *mas_prev(struct ma_state *mas, unsigned long min)
+static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
 	if (mas->index <= min)
 		goto none;
@@ -5953,7 +5943,8 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		if (!mas->index)
 			goto none;
 		mas->index = mas->last = 0;
-		return mas_root(mas);
+		*entry = mas_root(mas);
+		return true;
 	}
 
 	if (mas_is_none(mas)) {
@@ -5961,18 +5952,64 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 			/* Walked to out-of-range pointer? */
 			mas->index = mas->last = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
-		return NULL;
+		return true;
 	}
-	return mas_prev_slot(mas, min, false);
+
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_prev() - Get the previous entry
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, false);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
+/**
+ * mas_prev_range() - Advance to the previous range
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * searchable nodes.
+ *
+ * Return: the previous value or %NULL.
+ */
+void *mas_prev_range(struct ma_state *mas, unsigned long min)
+{
+	void *entry = NULL;
+
+	if (mas_prev_setup(mas, min, &entry))
+		return entry;
+
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_prev_slot);
+
 /**
  * mt_prev() - get the previous value in the maple tree
  * @mt: The maple tree
@@ -6116,20 +6153,15 @@ void *mas_find_range(struct ma_state *mas, unsigned long max)
 EXPORT_SYMBOL_GPL(mas_find_range);
 
 /**
- * mas_find_rev: On the first call, find the first non-null entry at or below
- * mas->index down to %min.  Otherwise find the first non-null entry below
- * mas->index down to %min.
- * @mas: The maple state
- * @min: The minimum value to check.
+ * mas_find_rev_setup() - Internal function to set up mas_find_*_rev()
  *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
- *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find_rev(struct ma_state *mas, unsigned long min)
+static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (mas->index <= min)
 			goto none;
@@ -6141,7 +6173,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
-			return NULL;
+			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
@@ -6149,14 +6181,12 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index < min)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 	}
 
 	if (unlikely(!mas_searchable(mas))) {
@@ -6170,22 +6200,72 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 			 */
 			mas->last = mas->index = 0;
 			mas->node = MAS_ROOT;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
 	}
 
 	if (mas->index < min)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return false;
 
 none:
 	mas->node = MAS_NONE;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find_rev: On the first call, find the first non-null entry at or below
+ * mas->index down to %min.  Otherwise find the first non-null entry below
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
+
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
 
+/**
+ * mas_find_range_rev: On the first call, find the first non-null entry at or
+ * below mas->index down to %min.  Otherwise advance to the previous slot after
+ * mas->index down to %min.
+ * @mas: The maple state
+ * @min: The minimum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
+{
+	void *entry;
+
+	if (mas_find_rev_setup(mas, min, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, true);
+}
+EXPORT_SYMBOL_GPL(mas_find_range_rev);
+
 /**
  * mas_erase() - Find the range in which index resides and erase the entire
  * range.
-- 
2.39.2

