Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33BF6759F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjATQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:30:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E16DCE23C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:29:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBbuv003329;
        Fri, 20 Jan 2023 16:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hA19c2rPtl/N6V5J7vefooGvydfoGhc2+h/slssXe+0=;
 b=o0xmNjgeQ5/1MKPy7FGZnxPg0yigG2JvNHZl+a41DF0uQ5+aMYBXcSJ7kQCREwWxnbZj
 C5prrUUJCqH4rCJyrG8u/iRFYCBGF8ZziL9ATLmu0UZawmvxD25lHjgUCevfiKtl4/nE
 KNgZWNcHfbB4al28mgEjTliSm/BWYePsV/n77DH5fIP5sbqsezi6jfrGppv6nivB7Xba
 bKEx/JP2Sekz4paa/3Uakz53cxC9oOSKYheUCGVK8mDVz4/MPXCjzihU2ydkfq6BegE3
 OhX8+fIv0ldw0fXFIepK5dVDNJxNQ3RvZCCfNfPtSCPrjKNj5x2pd995oCVTT/corgFE oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFPGcn027926;
        Fri, 20 Jan 2023 16:28:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qud91tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWOJXb6QGwQEuSZb+ei/wGBZh7j0wLtapQmDrxfP5HGWmPMH+IbJ5egHBA+pv/6Xop7zydytoU4XcullJztejzL44DpEsSf1kN0s+ZFEp+z+YVTN5BkYIjt+m/Ur0y2w78XStr8iZ5moHASWdXejbgjcY9+iMQymtBbN12FQ4BsW5PJ0/57zuvP0ocEfOQycdaayihsvTFZGNmZXpKWf+YVxnsSR5WGDzGi05/srW8pFyL5VzEy8+gje9DQ7QHFP85zhHmWCi7HkH9oW82VC3Y23VBsXYkjcAHX8uqzGfrNzUw30pZifyawP012sqJXtmMGd0wuSizb+t7VTlCTcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA19c2rPtl/N6V5J7vefooGvydfoGhc2+h/slssXe+0=;
 b=FfbXGasX4NrHN7k63yPWz3GhwbX/RMcw6ZnZ72zYa9zQac9xE1bQlSTvdFi0Qb/U8EAa+ZzH0HXLgShZPPPALo2A4izL38VPUAvmwKZ56sk2xRIh7qg58wKPokd61OPZLlipQG3teT9MLwTyBOXpj8pBbeRukc3EcjIHJrI5v1zIHCMDqkr6jA9dQ0pxpNCFxjYXS6yHpfdxgB3x83P3tEDlYQv/ZYDAris6HUHVlQ7tM83MjRIdsrsqbcCJvisE6hG+CtXQrkYxLq0q+Kl0Wf438gqqBYnjaqUWM5RJuyKKy9lSBMgm83eLnHrzQyDSLKWKNrLLUDLmoHN0eAORUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hA19c2rPtl/N6V5J7vefooGvydfoGhc2+h/slssXe+0=;
 b=nM3Sa3BSDu345DI9lpyfZqBAlYRYImGlTsb4yhukBKUal8cnLlzStM2h5ECkLrwqB5kUIptuK/vcAkwBKTjEpuhLze1kRBq2+i1xDL/rvxEGXnqi2+Nj8ZWDIsr6Ms0g0cAhz1JHNa/BWia0QG4hOuqJfqUgz6I82IsfM/8F5js=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:28:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:09 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 23/49] madvise: Use vmi iterator for __split_vma() and vma_merge()
Date:   Fri, 20 Jan 2023 11:26:24 -0500
Message-Id: <20230120162650.984577-24-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 06739382-9a2f-4d48-48a5-08dafb03512c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoYsJN0TGcwjxhKq2LzpsUtF7EqIZMWghibuBI2ZtFJMwzmNBCBX2mkMUBZnIdnVwTuN+KOk1zNvUVOd9wwcF52ULVK3c0PCh5ZZSzgjiTX3FDQTpinc91Lr4j09xkOVo/oOSVIFTHs4WF936ioVY8eLj0WER1ynGaTzWgctGkE3KA52sN6/5uI8gwq8Iqm6or06q/4xqO+nC8o6aWQJGN4LAn3rmLl5m5iuDxdkgkzdotW54fW0bUfmQbXZsrrA3ydiwNYEVSkYh9d5rU6bad2XmIHFOoyvB40jsSuOP9pqQtb2tcaWuX8lsaJKYVWrBqX4U5Iw6p6Uwdtv2/Tnnh4yeIBT1zl668/CM1/Wy93LGgrgRCbHy7mpNCzRrwIRSXNqHecgUcf7o4/OBhvFIY6RLzdyijknb+gOZmGuOGnqTD3R5y3RTPEHNCUR//sOv6OIUO4BRKKSmLxaj7ccmzBA0aUbQ70XKmi9p8HSNL5CfTn5zvkYGlTYyiIJn1MD012Q25dTmzv4EOjVGBjnCietZVUYD5vsUvZRwY+RVt2XUZBbs+6432WWrIABt43DGN7kscLK+JH9AW8SM71FriDbmAheBkv0arY4QV64N/2rv/dhxIdnUSx4KWCpkC4CaIRObb6WGNUzz3Lr/uay3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZi6PPSDGUmUaz9a1i5C08i0WhqHLKuzZJ+Rwjj8Zm64zMMOOZGqdTIpqLYM?=
 =?us-ascii?Q?zLgQHMPLW2sRC3i5zDmijCZNaUgrd8mYF3oIK6DN35mEwUNtqIp0Bu1qN3ry?=
 =?us-ascii?Q?uaKypaVYCaDbxw/gQqb+pTohnN76/R1KACijG8Er1zbGtzw/a4xvrCrbiAFi?=
 =?us-ascii?Q?RVhamgA4sVFSDj0kq1tee96pKdZennzK5aDo+rAF0X/3oxwCUlak53udtFg4?=
 =?us-ascii?Q?cffnUWoLcGh6/d0q+qK+V0DHIyBzXrkMqyRXAl7ypiOmtwklzvG26x2tNdaD?=
 =?us-ascii?Q?suKqlLurQBqnK2hKgdFom8cuYUYl5hAWsvTytusLYLafzzyuI0jBZNNJIdEp?=
 =?us-ascii?Q?z8vE1nuDGzywILOWyQgl6Hfx2HzAs4lphFEExjFMJkZqZan33XQ9e8kCZx7F?=
 =?us-ascii?Q?wpnIlivadr6B4NHbmXUrf9mtRlofUsHTcu1z8YhcUppZpkIpKc8RC8uQtdcS?=
 =?us-ascii?Q?K0akWr2Bn3rr4cZAa4v1xYOJcDCzxITsv74I/RD9jtvPUHE/8lEjVWwptgKB?=
 =?us-ascii?Q?0PdG0YGAy65ax30jLgX+w6sjEVf08DeFR01XtbIi9XzFs7nSkODsbXmo/8Vr?=
 =?us-ascii?Q?XqXYEgmCftW3Hay3pcoXe5zxdW+kZNRVX6Rd10x6yhLEqkntT3Fz4QHiJBg4?=
 =?us-ascii?Q?XDlxG5XgJ3uEKFe3d9wdNiAOYLhMHxJQOYk4g8+onvIR+cQYUkTN03qE1lNt?=
 =?us-ascii?Q?WT208OauTrScHUmdc/kMDxFZPnZo4Ctmj7DwtKY2NsHCNmz87HEpKdH5WVpO?=
 =?us-ascii?Q?8TN0EbbCOQixoyT62ZHxenCXJpFFivdpCxgwF5W7uCCkWWQkMZTJWcS4+ZGv?=
 =?us-ascii?Q?tzou1sIDCPOIpm8ceLsuw/kr/tQHHSD1AU2X593AiPCDL/1RJoT+3tEO9LhJ?=
 =?us-ascii?Q?UJcY2JTJcT8h7hznRXH9k9SlBoMpQ9GRqwLd9J9Aljou47rK65Lx7bBSjyc4?=
 =?us-ascii?Q?ePd5fHCsNP44vL7dxfDtgLCQ4KSM/mKW/MiPK5AMmfilOK61pxxERjRGU7FR?=
 =?us-ascii?Q?pBO9dJDqkFYpX1E3qmr4/jwEgi7UfZw7xJcPyy9oComK0hqcHwLxMo6y/8if?=
 =?us-ascii?Q?4LN1l3kmisn7dwj2q6s0dol5at6IR8Ei76BkJP0Crrd7ZHiMYiOyhB3wW5Wa?=
 =?us-ascii?Q?WjO5Txdc+iLFwy/K7WApDcMAt/jlQ2W2Hed9R8Jv+xBCnz1ffB7ixJyeQo25?=
 =?us-ascii?Q?NV6fzc82/HXij8HyVVX29ZYAqWy83XkWo4/W2yqoDXsoBmQqwV5U5zjI+O1o?=
 =?us-ascii?Q?VLEE9qZghHZLki3jBj+Uv/SJccq2PUgZVPpeORPYZOSZNGhxxGQjwHay/ppi?=
 =?us-ascii?Q?ArSJke9yWIGI4L5BtxvF1pz8uOrlqSXelk1wK9vLBkHvxwj/F0XgqbYAqIn7?=
 =?us-ascii?Q?lrRkExaWPJMyIZCPkJmuGs/thxrfEzOSkJupfApWowe+TfHLfqOHMzXIXLvl?=
 =?us-ascii?Q?V5uuGCJjTBGFbPIKsl+qLWcISyPgY1wF3hWjAFa/Vm2hSoDTC78nGVxNJRnz?=
 =?us-ascii?Q?xeaE3PKZ7C13uoUHpjdKSDLltF4ZsM/Fccsl7nTu/Dtr61bpoDcpF9/i/6ah?=
 =?us-ascii?Q?WKB73aC8enG70nt/CFqZKzZE0jz/HvHwUgK53526mxtwb9kFKLoLF0xUSaT0?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xApimMY0x6yKnB/L+Pi0LdUieidn3hxdNRl6DOaqwFPk66zwxgsgZGIaPLcvyUB/7muj4dUW3s3kDS9DVz9g3uOsp39uINWWzsb+xmoEYPpJ/fOh5zN8O1+ec0sCbmbmPIT8A5uqbTvhjFYb+YAMjXCADyTCprkaYIBaWu1ctVA4kUnEigggypLg+JxZ7X0cb/1otnckphAuZoF/0ppYddPMZEHFeyTFoULAWw3NeHMFD9qqxA3C9qZRtldOQLMwcf6atzH8TNmMrvSTLfJjeGbABy4s369h9Ygg68tg0Tyhan2ZUJ+ywMTN2gSA1W7VSTuRmGuDXzws2CuWZxnpe0D5Deg5y7hKjk4rguhsIkMXvR0D11SDE28Cq1hFZezJELbQminZiQaFRHVXbCLxqAhYGldI42AWJO//M6kiJ5OimjVj2aenccoNR2gX6l0Dz7S5yMADpAZGtmntQoa/l/vAAwhjNb8uCVmm/kJBf4+JQ191ijXNcjxxr/NZ+K5I2kKGUYIYsvu0dEaN7MakPkARAfpKsG/whbsh58SW8M3/e/l7Rjfx8/AWGRm6Kf80nRqxdrMW8HqP2QnkOiE8/+wYYawSPer5osZorZO+tT93ISuNpfAzMNIRidMwNLQAfvl8LbeT+j4CY+s2ttJ8M0piL25sJ5HDix4p2sxQDxQKmVb6UJ2wm4xRwH1/rlz0SqsMJ8E3tpy/Zam1fLP3TqeFgDJO2ESIa/sniPg15j3fgffp/UrkXB7sJ4saghCLCAl+voWqPtV9UMpFESu3BHulOjaO50qkcuRDRmyHaIL5Hsfduz+tRmHpzn+nrTsB1RKd7k8LObl8mcxgV8QA6TolZ/4zq5ahiiCHhhmmo8h9GIzXi9ouMvzrKCig7CYGN990fDXJjg1W4+lxS5qfIA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06739382-9a2f-4d48-48a5-08dafb03512c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:09.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLaZkxRbKWTkJ07OM2IsWoDjA4ePoW+uBI4QGiuARKjxy1ideGr+9KoWzotlRU/tYQddKtQm1kdt3PLqApF5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: w69SVcE9lz4gLy-Q84EiJiEWzL-lYKES
X-Proofpoint-GUID: w69SVcE9lz4gLy-Q84EiJiEWzL-lYKES
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/madvise.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 92a3c6bd84c1..4d4471916465 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -142,6 +142,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	int error;
 	pgoff_t pgoff;
+	VMA_ITERATOR(vmi, mm, 0);
 
 	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
 		*prev = vma;
@@ -149,8 +150,8 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	}
 
 	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(mm, *prev, start, end, new_flags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma),
+	*prev = vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
 		vma = *prev;
@@ -162,7 +163,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	if (start != vma->vm_start) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count))
 			return -ENOMEM;
-		error = __split_vma(mm, vma, start, 1);
+		error = vmi__split_vma(&vmi, mm, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -170,7 +171,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	if (end != vma->vm_end) {
 		if (unlikely(mm->map_count >= sysctl_max_map_count))
 			return -ENOMEM;
-		error = __split_vma(mm, vma, end, 0);
+		error = vmi__split_vma(&vmi, mm, vma, end, 0);
 		if (error)
 			return error;
 	}
-- 
2.35.1

