Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B256D3CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjDCFXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjDCFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10406AD04
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332Le24N009559;
        Mon, 3 Apr 2023 05:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gW/w4UBNoRyDr+fj9Sa/039P6gNwlfFSpI3amaMp3cc=;
 b=Dn/H6HZmJlLesKaHwksiUDif7P9mM1uzZUQbaX7ujbmfxhyibCNFgboF/dDK/CBCwqu0
 h2QbvTUK+n1rQXsU6YoJwzJ1LeBU6ugQ+POVfi1CCeMxsxllbTsYWD4mCJJSd4lcySed
 MOhTtxMnW7vR5UWkfGDoSLAy057orTt5kyZ43n1A+GITTPyEPxd59Sn0HlHnShjkZovn
 CiVBxPJvoMsr/WIdfyKci22EVc/saxmgQzKI3WT4783X30rPMcYK1ZM2zE6DcY2WshJv
 fU/nC5drYb3LNlu8W+NyxEg94i7NPfGtMOMTBVpnPXnexiD1f9bR53BpGqZTlUJsa4ur ug== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnct4s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33358gdI028272;
        Mon, 3 Apr 2023 05:22:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt243jdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgCfHXKDhVlODPaTrw5tanTx1s4DBtDjp10We2gX9y1WCAYc5JSVdLm9NcTQL/PsmaXGpDcUIeCsglKey1HO7oTR1GND7JPpIIFa3tvq28/LbNZnnAD2w5ST1cRFqRL9+z4q05CutuvCMbsqci9OFMTO+mzy8DR8C4/HgGiARxf6+ghonpShoLolKP8CbK2BTn2ineBgD0ZhNqUHTr+HQAEtjpTt0jmsyCX8fhAPPctTrLuEtOAqF4Ce1BXWAAeT7/T2jkJ4b2ZNfSc8y4yHG8frlq2YOvl3EpPNj27DeBzUyexe80aPe6hF3loFZSCwut8f52zxZ8K4PTjCgc8swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW/w4UBNoRyDr+fj9Sa/039P6gNwlfFSpI3amaMp3cc=;
 b=Y0Cm+uvbhKlFfPzOGyQzMU+r4HcyxXl57tCCL7aBTcn8OhTeR/sJeuS5jgLVAX/ydBhX8nCHgVckAb1BX4T8MC4gfJTH4xt3VMLjGeMf3oF9QOEVLjCNOW865vGKED4loLRu0s1QD/gn1yEAq0Yy3hiYts0EdHP5JzGMHhBV4Tfq+aLAMngaUo7aYlPRtY8PN6CCuCdKBDG7gZKm8uvB2q6M86Nx7RC9uZg+2SV7CDdgbqxnQp/ygjMxLakNJ9G+LHvP7EgQbRmXUA9U8B1axiCyzMvWREOi1NOvHl9jFDf9zH+KcgzWR7J8SWX0A38cH/sLqwOj+n1PBnLTCESf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW/w4UBNoRyDr+fj9Sa/039P6gNwlfFSpI3amaMp3cc=;
 b=TUfpdY2tQMSA5eHHsYl5p6bY6EywNRdeKZjsmC2fKFyqoqO+MyeqKU6E7BcHFQ0J8vgYDFx3uq9YVTH/6+vuT7DPTFuVtRW+YzLijajZ7yuiAQdxIgZWgBaHA0ydlOzWuMdtsPUYtUc4G00QHExCXVdL3+MAevsGEf4VjuIuea4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:37 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 5/9] x86/clear_pages: add clear_pages()
Date:   Sun,  2 Apr 2023 22:22:29 -0700
Message-Id: <20230403052233.1880567-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fc5ff5-c6ed-4530-c68f-08db34036fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyFwhO7FrdtV/0UFCTJWxkzDFsU/vNJIVTciCP1I/JqKVaSZYgA+1t8RsdQr870dbd/hjMNcGFzL+hEx/Kms9eDvv2is2SneGKgPGv4fM5ZTgLXXek3jyKFXemjKOcwa7X6MZF4TuGQ+FoAJee64573fiXl0S9D6dLEK0Sxck3FKaBWVBQmgVdDc/zwTZpUj5DxafWRRedqiiOnqiLBllWozYFkmZRublZsWyfMmEKgCU38csPOW/mcNX4p46/H40SB46t5li5D8zb6kU+XFVTF3oa/G9iYuC8QhbJpY7FmvoH5us+WB2t4dphASX1sriblXzX+5Mmgd3VMLYZXeCgSjEmm74pSXHXawL8bbMHmSUsNgHA7b3Fd6nrx403dkYoKCjI1vHk8efgs3xxitry4C5vVhwpEJfX4NpTUk2ysUL89IWfVxBpHOfBideFJEN1tUnJjNZKMnSWCUVOtAVFO+Ae+DP/vg0os05zAo/C/wYnTUBsGPlHmS3HAiPaCDYW9i1mSIU4E0tSS37mOtTPWSFz1xUrtNmc0ARDWfdfGqjDd+Ws/qY5iqJk6pKo5w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(2906002)(86362001)(5660300002)(7416002)(8936002)(66476007)(66556008)(66946007)(8676002)(41300700001)(36756003)(4326008)(316002)(478600001)(103116003)(6486002)(186003)(26005)(1076003)(6506007)(6512007)(2616005)(83380400001)(6666004)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOjgWgbM6lFjlTtRLSnNCkEMEwDZYEDYYjHrEMfAGp5ldXwtbaEOmYfQ6KGU?=
 =?us-ascii?Q?UJwYfijNkHMz9ie3i5R9PugOFcFzQw54MuEYUS60CXM3NreNkbxzH9Sg8u3f?=
 =?us-ascii?Q?SGv94wGVXne0Jpi+bixg3hl+5LTaKpY2TI7Cc4521nc+SD4X+yEuRGUkfmR4?=
 =?us-ascii?Q?3QuYIIjLiH8ku6FZN+V9E5jhcDY2bMk8T9MjtyNCniA0+bKZXsrqlNzJAUD8?=
 =?us-ascii?Q?szfVoRnBlOKAsijKYrAuauxHrwEmunX5DzYpaVyyVxYHP4FQJ8Bw35TpY1fI?=
 =?us-ascii?Q?Slkrpb0hA1nNtQxIedW+750L0EnAFpU6XwDFo36uN7JqX4F8G2KdKG8vbA7a?=
 =?us-ascii?Q?Ozp+LUbt9zTBT9MzB8NMnEwDegPJfA8ygAjxZpw0FdKL+8qyl1bsj9zu1uh4?=
 =?us-ascii?Q?0tRAVsuoPwBVXoqQf01/j6xhNIeDr+NIEtwm0uiTJf8WA4tlVHO/BJ7lLaGQ?=
 =?us-ascii?Q?38c8pk42oDtIrwUqb+cRv0W+dEnUdSWltfeeA9ql/KR2Ngl1OfaV4uWVN1y8?=
 =?us-ascii?Q?FcKBwDiteJpQeiMjosyTCpV4GRQPDCaptbUNfIIBjbWwH2xFrPcySmznDmQH?=
 =?us-ascii?Q?KVRQaAYb3Lyg/4AfSzj4nIUkrYMo5XLij4USuBPTDO6qWADgDW7eyB3fZyIw?=
 =?us-ascii?Q?iO6ltyUDkUrc+B5vbRzqh01ayOoWnhAStXgTP8W/kt89CczJKDnZplLkFDXP?=
 =?us-ascii?Q?eCMXeyCttXTLYFgrWj7zCLMTveHUBDqR66q2X5Fc97l31nyIWjfiHn4GLepB?=
 =?us-ascii?Q?az56KRDsHN4Aoo+Tjl4BxDmVYo9DUi1k8Hl1CvotE1aUe/7n9YBOdn6SXpDa?=
 =?us-ascii?Q?SpaqN/Ovjn/DslDaG76Ssl9jP1i8WexH5XzcJi0vBxP7fz0E8ncZAGfMikQE?=
 =?us-ascii?Q?xkRGXM+tvBzoJhmxcVaA8icU6Qn7zPguA3g9H5RukupY1w/PKUre22FvU5xC?=
 =?us-ascii?Q?OFY47je35d8zSlUJJ0LNpqsy7gvZcgeB3mYy5kp2JiCmjzXnt6Jw26nC2ml5?=
 =?us-ascii?Q?RIjtEpcIH93U0ETqIuFhbbYYDLsxQ3Edla+cQEDSIav3kG/sPBoP4tzrgHFk?=
 =?us-ascii?Q?PsPj0SqyXPsnrIVE0gwZAdMst/wfR2IZEixV8sHY2phU0yk5/+DCOrZdK1Cl?=
 =?us-ascii?Q?wCuR5Qr6xuE4RtGIcGY2MxuUl5BgIDtu9A550lCJ4/I271lt7edHM0yiP8rW?=
 =?us-ascii?Q?Uz2VX5pgAY+2NiIcy4UWhyQ27UplYyEAdQdNrrDeY56qS5KmA00FpclsawSo?=
 =?us-ascii?Q?bjfXQYnyVu67IQknsKPJvn3g8ZFRb3DKDBpt/87+w2ZQCE30uhNA81TlpjPN?=
 =?us-ascii?Q?OuVdOwoDiSPRqPYgRdP9pOQmBEElvfRLl27tWxCvyX8pF+iSyb2YPblJjpQY?=
 =?us-ascii?Q?E4EY6FSHS0BBC0ZH1DxfK89FldvQBU8LelasydHrg4vox2QiotEpZnWqQo72?=
 =?us-ascii?Q?cWkL52UW5oLRpT6qUOJhEhHQy0os2XU+c6iNG/lkY+72O5pcWUCYu2YmexHV?=
 =?us-ascii?Q?RgvbmfOLJjoHAkCAj9eU4SfWPYzQxdflbaDUGRm34eWgJ/E7ZfEJ0RkF1NUc?=
 =?us-ascii?Q?5WwzzzQipahcXjT5IKYOmuGBJdPzyr/mpMp1QhVc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YLWSoUs2F+TjUZ9vlm7/o5qTYL00NfPC7EIcgf0lJhB9bywpH/JoKBV3IssJ?=
 =?us-ascii?Q?WP5Hn7VtDYJlpajko/SsVKZVzs/0XlZaoET8w/Hao9RXfyqCtMjS8n1GJnIm?=
 =?us-ascii?Q?8vD15iC8ZoxK9GXfRptzv82puZjq6zPMP3lZlOTx0MM12sJgp4PtaxFiShTA?=
 =?us-ascii?Q?yPPj+aEnid9y/FBNwp1BMrbDstIeBsU0AP8i1h6eTibAKytVL/c9dQQ4V4a5?=
 =?us-ascii?Q?7pD8rFlReQk3Tq5YvAofAe8jCGDtdCjW9rGQs4guwb7BlCXqbKxq9UXF89si?=
 =?us-ascii?Q?HX4U2x5AX5qTGZPyUOPaQLzGwn+sQiyy0zzs5HuiITV4lNWEDymCUmgYBqY2?=
 =?us-ascii?Q?kKhSx4stWYtAf6eUNozZA9127tTrQUw/0uSr0VrzTFksLi3oUFW+nk3zIW0k?=
 =?us-ascii?Q?/1DVbPgVFxNGYRWiQLLT2vgptFGQxdD3iR+igqjOHLvaw+PeDmE6l42vYidp?=
 =?us-ascii?Q?5VMWoaEoJETr91CWiTuQ3ByvBYbR8rMjZf9bqZRVGL9XxbSgGUYzfKBniMbF?=
 =?us-ascii?Q?ivytFyaWOukn8IyixkI26qecaY0cyF1pKCumIGoO1+EfUGybyOvYhUVfpisb?=
 =?us-ascii?Q?xZG449B5s5b6PQbGu3nQtqBBh87UzOx1vfBgHWgrLzxTvUC+j6qWEoX4E5H8?=
 =?us-ascii?Q?4GS9rnJuFF5DxVwwYUv8PLfTMap24i6ZXoCp56Z6XYMEdwXQGXYjRwW46++/?=
 =?us-ascii?Q?/HL0Z4nA1GOcHvNiOI836I+rS6QzLs6RGcsGK3yK3u4TVCPMRS8LosIRI5j1?=
 =?us-ascii?Q?Psfe/yx29c/SlVKvkTaF3FSzIr8L+TGQSm1D9cI1Si8NcF9CpIl5CV9gMvVs?=
 =?us-ascii?Q?KZTHjZeurOfpJUvyv1s2DBW0XIOlzcLPOjLusnKHpzVv+97aB2lQCxhGTI2q?=
 =?us-ascii?Q?g/i++qYRoC8s/2cwG6gYsN/dSAGiLZYB0wQRwHvSuZcOc6kj7mBoKB6WDpv5?=
 =?us-ascii?Q?ObFD9MvU4Ua71KNhcP4CuV6Rbzv5H4MBCOwcMQfgS89ywpgMaNd6E6dJlCwp?=
 =?us-ascii?Q?G1F886oEcE6sl2n7VUtA7ZElvAWMv6dye5A6RIKrIoFV5Jp/R6WGpHOgU8DF?=
 =?us-ascii?Q?0Mvw/axvLFIpxoM4cfihGGRvjcm3cNFjKsV+fNre3xG3K0wJMY3bzy2OiFpW?=
 =?us-ascii?Q?kq75V6JUFVVzvITfLw95X/echc8gKfibkTcWanAMreL7SjEes4z+KjM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc5ff5-c6ed-4530-c68f-08db34036fd5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:37.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFy+bbT+hkUU2yGypQNLEk/z1osGbg4aI0nNHM5E1Q1+V/ApZpOwebI0gzc9Zj7p6CDcnbTKWS1iPhvjSH61bzfhFrgiE+iSeUGwwvzo1qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-GUID: ajXacZ1gH2f6bdCwT9bIRPZ4J4mSVB7H
X-Proofpoint-ORIG-GUID: ajXacZ1gH2f6bdCwT9bIRPZ4J4mSVB7H
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear_pages() and define the ancillary clear_user_pages().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page.h    | 6 ++++++
 arch/x86/include/asm/page_32.h | 6 ++++++
 arch/x86/include/asm/page_64.h | 9 +++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..03e3c69fc427 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -28,6 +28,12 @@ static inline void clear_user_page(void *page, unsigned long vaddr,
 	clear_page(page);
 }
 
+static inline void clear_user_pages(void *page, unsigned long vaddr,
+				    struct page *pg, unsigned int nsubpages)
+{
+	clear_pages(page, nsubpages);
+}
+
 static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 				  struct page *topage)
 {
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 580d71aca65a..3523d1150cfc 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -22,6 +22,12 @@ static inline void clear_page(void *page)
 	memset(page, 0, PAGE_SIZE);
 }
 
+static inline void clear_pages(void *page, unsigned int nsubpages)
+{
+	for (int i = 0; i < nsubpages; i++)
+		clear_page(page + i * PAGE_SIZE);
+}
+
 static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 7ca3bd2448c1..42f6c45206c1 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,9 +43,9 @@ void clear_pages_orig(void *page, unsigned int length);
 void clear_pages_rep(void *page, unsigned int length);
 void clear_pages_erms(void *page, unsigned int length);
 
-static inline void clear_page(void *page)
+static inline void clear_pages(void *page, unsigned int nsubpages)
 {
-	unsigned long length = PAGE_SIZE;
+	unsigned int length = nsubpages * PAGE_SIZE;
 	/*
 	 * Clean up KMSAN metadata for the page being cleared. The assembly call
 	 * below clobbers @page, so we perform unpoisoning before it.
@@ -60,6 +60,11 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+static inline void clear_page(void *page)
+{
+	clear_pages(page, 1);
+}
+
 void copy_page(void *to, void *from);
 
 #ifdef CONFIG_X86_5LEVEL
-- 
2.31.1

