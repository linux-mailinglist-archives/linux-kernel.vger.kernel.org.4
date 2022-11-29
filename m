Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE763CB37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiK2Wvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiK2WvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5062370DC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMECvT020355;
        Tue, 29 Nov 2022 22:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5+i5cFJ8kWF6G8sf4E5wI57dFP15IxoGxTJ3putGXAY=;
 b=GJTXJmuxlEvTuttYDr2jx4fLe6X9hNNqJdcWgCkhnuegcjHMoQrDmPeMu9ybStJVYTuS
 v/NGVvYlfC/IpQtOA+fFN7Ys3EnRNaOLSg+GEIAEiIrv/SLPWHEEgrgS3d8IQimNyB39
 +9yQNZO1kLB/O/1sqjhIsCnSmi2FiNYzZIDyTEhBamUp5wpaNLL+OoNBnl3E2CmmVesf
 4aaWnuUACCU9S+SK9qz9ybKc0Fjhfhckn1gnWTVRzsfVeNvCQGIW3Legx+N5xLkxbwIA
 uBHRLvduLkQM1nhaNtSCk/s4SXGVKREd9v9FpfRsJVL3j26XAoRFpsRO1H5dHFApxUx0 IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3xht7m1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATMbKGT026751;
        Tue, 29 Nov 2022 22:50:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1w67b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGouup2fAid1VzYimwHOcwh0/ij7aJkfC68b/VAcilxTbUz9mULlR808zBbS5J/efcLPh02L727AXh6aUbAOikXKbR58/qOKEUJS/9lrs23MYOj1RdFnezDORYU7aZireHmAtn2pUDptqXkbfCRcE/CnuGSjlbSJlk/sUdfxFNmlsQUSsFtWM9C9eYFRQ9sjZ5jdbW7bgYQzt4HoS/WJMn/8t5vYkmH3GsQXY/EkNmYNe3GYRtSaAwgPfR6fp01yakYLZSS+9evpvKmaKXypeGYPTKvGKWFS/KokPfsOgG87RnwGO/tEG5V31ur8Bw19IR7dzyIY2Tmz3DgDv8W05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+i5cFJ8kWF6G8sf4E5wI57dFP15IxoGxTJ3putGXAY=;
 b=YvaTNfpZIbfLqQhRiMmert7DACcpdY5AmLcwUyLL9xCXzDi0zo4lhCTWwHZLmZjM3z9Sc7uHsMpWrF8JIX5EVL+kojy7+sPH6Kd6Uj/nKEQ4oho/IDxVNl2qDbRBseAQmmTFUAyHfVGVCP7jBvp6xx85UlLZmJL/EoOe6hP9vQKoq2m50KqqS+Wy90LGKbMBGWJmJGu/zUjSAheCni1wETpG6vRiWsuXpsouUpwrCvMasOZqYmazRi6jnDmUi51VBFffzXSzuwIXCpLqE1ATeHVFcdC/zHS4NZZ9z8hij3PTcbUhG6DvlOD7tZ0chESbTP+ndsRMenl4rt3dPJ0j+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+i5cFJ8kWF6G8sf4E5wI57dFP15IxoGxTJ3putGXAY=;
 b=GcYcZq4ja7zi9nPHD+pb2rMJfyC427m//ep0Y88pc+vos5fjIbPPADM8NxKdOajYckhBjmqbtlqxbHtOFxk7rgPINvki/m9u3jB2UuO89o6G1YgIlaQG39EoMnWExznCR8b9B+gwTDs3lzVSCQFJBxBk//QalHupOcpgPFu6sc8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 07/10] mm/hugetlb: convert enqueue_huge_page() to folios
Date:   Tue, 29 Nov 2022 14:50:36 -0800
Message-Id: <20221129225039.82257-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: fccaf2cc-c035-4088-110b-08dad25c2ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE0AK+qYqiz6a3qPWEmKAHmLA6htAxb8oNoo4I5CGZ4GkqtFi6MdFT+88ROFXmJn+WdgAA8r5H9rHI41cKLqkPSQhC1reVIvPaHoMhv+x5phD87bUeFSWzpVyZgE+96VTwY/nfC4GRPNoZ/xgYXPiWYamcY0Sry3G8a+F/Q7sycy3lXJQPqOcA+3skdZJrMk1GLb+OQNu+8sQycEMUwrhC9jcSHFqMI9KErPaXXLJkBFC25Kv8x/1XWWjQizfYJ6Z6qt9GSPTx2KAGhQjyrZ5Tf3og5Piv6MrVsXh1flDaQpOD5vrNkdpYmzTR34S8IKhfWDPz1R6kvgzJshovA59QrilLldEb8MmfMv/N+uI/9gSEkXZL2fZSPgSzp3UPVl2iIdfSDdf/3sHKmbiHqFipuqwU0HYxJyYjgKDlPJGJPGwqiAhzTgBvMrD59jABq3BoFLZp3dkUBwyRB9ttHjJ1ZCGsorrTfuH13ZPUixk/fBf7RSnsIEG0dJXGcGXzDPgfB0KftdsnOdtIglUfBy1Ukn655e4DGWaaXoPaK6eh780/tb37axNiPHXhDuwZHIOYMjEbjvAtEl7bwq19pbkh28jVO7mOHW2P9IYBVKKFwZ7ZTwpbOjKKTRC9T5ETM2O6g8PL6oZqZTlrphrw3JX2UvyrshG0r0IQmiyYmXQ+cgE+j6FWs+kC9EcJ6MnOrH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BTRBQb7Owkh6FM7LAhC93iL6Q43wKVPfs5M/morIqekFctCBUipL+uaQB7Ez?=
 =?us-ascii?Q?9K/2kq0LfFMufNnLlRQyZ1DIC45r7rRIIaljx0wnIIbxAhAP2cwXb12s/DE6?=
 =?us-ascii?Q?vA+wy0Imz4G7Ljtrv7qKy9YT39UOKtGlveVmCnUqvqGwS1C1O+NrU6CuqlaO?=
 =?us-ascii?Q?3W1+Qx+V+ltIs47Bsi8Mnni4XarHg6Ny5ewRMypkx4vDPa4ju0NOXfAyleGt?=
 =?us-ascii?Q?qzdh2LStxyl1r9AbrNj7A0dBrvfee0pNC0JupWzkaRdoV9MXSP/Ppitmd17I?=
 =?us-ascii?Q?VqXRW7oiGDLmf5bg2FIUNPPUifT0HTvLOZvkX2POzNjJpY3T1SEBb6QSs+T5?=
 =?us-ascii?Q?dVUKWzty4vKIhmKGTCJunzWi4JA8neGzclDea7clIghKj0iPSI5HSB1wr1wh?=
 =?us-ascii?Q?REDaWmMLSER9e5WasChd107dk733Ly06HUeCjUd6uY+JWfIl5GV5a+nvodNu?=
 =?us-ascii?Q?jx/5y/Q+dAVhAMILMKyph1UQBXhBVQyzPVzS5jmU6O838sUxjt3T0qJbcz+E?=
 =?us-ascii?Q?FMbwVi7Mx/p53mNzBh2q3c+1+0rTRYTsDGlfb2g/t5N76Mnk0NQdNxIFhxYW?=
 =?us-ascii?Q?fFeUZZ7Hqoq36Ca/O0SPwa2nBkn1asyGF4GyTEoT6exD7kZXMdlmikXMJcFc?=
 =?us-ascii?Q?Ro/BwlmXHm0VYXngYkXmp3OS9LDglsVpmYPRRpTEYxkGTem66YzbR2KpulKj?=
 =?us-ascii?Q?ivBDv3lKk/21qx/WCXRPP+R7zZOQ7xlRyTtnKCoiFdhv8n8ZHxQAsGh6FqYD?=
 =?us-ascii?Q?jwBxo2KFIEOwwa4ahp29iw62oLaAwDg99Y2i1fkJ09vXNYmauqZ4I3sNu9Ot?=
 =?us-ascii?Q?dK9Lm5OkQZwVWQhzvq0A64FZLQkLvaGnF3euClG3SDCC/PXShDV/0CqASr4Q?=
 =?us-ascii?Q?7qhoweEnm3WwzcvyTXA85WXFwV29s0Wqe58LBYhmRiNE0ael57TACvuteQvn?=
 =?us-ascii?Q?/Fbc0aM1ivTp5rSMd6ohOroYwS8OkOFGzIRDqrMiKnopBjQS7I/wm6gu6FWc?=
 =?us-ascii?Q?vA7g1/+ikXzrvLi4h68HPqKNcwavR9DuIedir0MlRqgJLAuadEGzRUh6vAa8?=
 =?us-ascii?Q?luZG+qXBukKZsTKW2mfHormiLJbPamPFOgcheNsXvYrTu5lMtGTqKvyuJvaz?=
 =?us-ascii?Q?BjZG0jnBGmta4HTR7PWP8VHNPfrnBnQlrSpCCKOVja5/4tRHv9J2ZE82jFkS?=
 =?us-ascii?Q?P++x0cYlNmmfm4t39thROUxT24NVk+4WO/2Lovl6M61bDfNHlbP/na8bR32G?=
 =?us-ascii?Q?zaguYtzXw5OTytPRZulE7S2TRFX1sXYi+evUDURw/yRM1I0uAHI21zxIBoI+?=
 =?us-ascii?Q?SLv+LFOOzRWcuQR8/07xlVb7pin+NuIgxZDT2OIU0SzNerh87PIyjv+4y774?=
 =?us-ascii?Q?/LcKfMmlMnMux+Gn84x991vuTLKJWb4HN2jPH8krzjjgcpVrKnIsXyr6Tf8R?=
 =?us-ascii?Q?/EyxUtQ3kvUjJ9V5P8uRbRm+8W81VdbAlCWA6P3AXwsRH6lKogk5J8YYI25+?=
 =?us-ascii?Q?rG2+jO/DDC2w9i/jKgbjEoTeV32OpNkMKv9WgQEuDuvWuWWUBeFxvcOHUAN+?=
 =?us-ascii?Q?KsduxQiYDT6LigvFPlOIqmQCerqfsmCKGMkSIeZ/yoZx3Mqp1L9eIV7s5JKp?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/0ULNJDEiepCteEbCyRJ/Y0yDM3p62I7oq1CLzVS0fhaBIc9J9ADbcazuFFn?=
 =?us-ascii?Q?08m9Ts9PVstk4VbJrIpBhpV3CHC1NhVQ4rJ4U+aFGBkGi5iPcshG+0UI75o8?=
 =?us-ascii?Q?T9MDu7JhLwzjEIIY6t0dVNPncji7+t+QMKRD9CsxNmZ4iG/69tVvGJGMxoRU?=
 =?us-ascii?Q?PsX4izv98mRDTLlm3G3WZaZ1Xom1PUymH79HoLK8RqU/MiYKWGbiwjC8JWjU?=
 =?us-ascii?Q?ZSnbymj92yv3focHzX+gyU7cyjMl8G2dDP/O1HUjdyi84UDnt7Io0RuCnTBT?=
 =?us-ascii?Q?g7lfWKnoaMdn0ljoHQaf1Apo1abPcsjExHgR+YvunSrAhM9jVA2Xor1GNDVU?=
 =?us-ascii?Q?2CgVEtBI6C6dw3QR+qSrPE0xOmZeT24RkDKbx1IePrtqcw+RUYwsHLto9iZV?=
 =?us-ascii?Q?K1bmm1CPeMgqy1cns0+Tfgjv6oZt+5Q4tHTbpdKzOUaWma4PfbihmgVfQRoE?=
 =?us-ascii?Q?pXxmlj+GscTVaqNumdM0abMIMcww3QnKXinKBQoyqmiSoqifQaz2AvjCnzxu?=
 =?us-ascii?Q?Csctj/OMh6ZdrCZZcVhK6eF5LUl/IXMW5TsRNz5DOl5vKzPmYB1lLDziOScU?=
 =?us-ascii?Q?p66TwXuRFYdwMkLZsRPpG2LZeAu1/DD6iieiLMzkPYDqVNEy5SwcDtoyp4Q0?=
 =?us-ascii?Q?Fx0upVWG9TSqEIziSa9W0YnXPcHgE9yOqwMr6ApDTWvjHTTifzHaV7eH8Hrn?=
 =?us-ascii?Q?3wGAQOkefALpGi1zpFVfDw4+6JOqZXtPQ+ANGwuzlUw7ZtPAuuaLeK9D8mRA?=
 =?us-ascii?Q?9n5G4KR6XHnyYkIQrRyyb8jpWWccRoiJtT8Q8GgYQTTsCY1LHQvTvMfKCwmi?=
 =?us-ascii?Q?sGjBiBnOylqb1fIGy9wBPmtvgRAiFDgYPTeVvPLJhNmMFzNC3+TOaIP1Ky8E?=
 =?us-ascii?Q?OSMckTHO4KWI3+i4yi+z65qlpAPndTatGrsDn6A6J9yw29FMnb1natGxZY+3?=
 =?us-ascii?Q?+oU11keDIz9FdSo5y5+mqlI5ywM+gCMCgyzvVsWx4XBsh/9lwf+hr8AMxpax?=
 =?us-ascii?Q?HKePE7pvJol0mOfmP+qaSDSNf3dZtpwnToENOOUBTyDYp8zNQaQS7K2ltQ7P?=
 =?us-ascii?Q?HO1yX4HvuE/e16OiR+W1+SOAHmUhWto7kd0pPkLMZxDRhCv6yTU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccaf2cc-c035-4088-110b-08dad25c2ad5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:52.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mimBSlHJQjMHi47JATmhwfHw88LRLBwqdaswpel7FDWS1iaFWUkTfhY3fhYsaDh3Ljzh0d7uFF/nF4AyD/ewF0C5JMiPVWPEyRczSDQENzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: zoup_tALKEOz5kMrv6Cwwv0OJ8OjBQg-
X-Proofpoint-ORIG-GUID: zoup_tALKEOz5kMrv6Cwwv0OJ8OjBQg-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert callers of enqueue_huge_page() to pass in a folio, function is
renamed to enqueue_hugetlb_folio().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57909a0e7157..c889593d5053 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1127,17 +1127,17 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
-static void enqueue_huge_page(struct hstate *h, struct page *page)
+static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	int nid = page_to_nid(page);
+	int nid = folio_nid(folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	VM_BUG_ON_PAGE(page_count(page), page);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 
-	list_move(&page->lru, &h->hugepage_freelists[nid]);
+	list_move(&folio->lru, &h->hugepage_freelists[nid]);
 	h->free_huge_pages++;
 	h->free_huge_pages_node[nid]++;
-	SetHPageFreed(page);
+	folio_set_hugetlb_freed(folio);
 }
 
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
@@ -1549,7 +1549,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 		return;
 
 	arch_clear_hugepage_flags(&folio->page);
-	enqueue_huge_page(h, &folio->page);
+	enqueue_hugetlb_folio(h, folio);
 }
 
 static void __update_and_free_page(struct hstate *h, struct page *page)
@@ -1761,7 +1761,7 @@ void free_huge_page(struct page *page)
 		update_and_free_hugetlb_folio(h, folio, true);
 	} else {
 		arch_clear_hugepage_flags(page);
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, folio);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 	}
 }
@@ -2438,7 +2438,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		if ((--needed) < 0)
 			break;
 		/* Add the page to the hugetlb allocator */
-		enqueue_huge_page(h, page);
+		enqueue_hugetlb_folio(h, page_folio(page));
 	}
 free:
 	spin_unlock_irq(&hugetlb_lock);
@@ -2804,8 +2804,8 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Ok, old_page is still a genuine free hugepage. Remove it from
 		 * the freelist and decrease the counters. These will be
 		 * incremented again when calling __prep_account_new_huge_page()
-		 * and enqueue_huge_page() for new_page. The counters will remain
-		 * stable since this happens under the lock.
+		 * and enqueue_hugetlb_folio() for new_folio. The counters will
+		 * remain stable since this happens under the lock.
 		 */
 		remove_hugetlb_folio(h, old_folio, false);
 
@@ -2814,7 +2814,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * earlier.  It can be directly added to the pool free list.
 		 */
 		__prep_account_new_huge_page(h, nid);
-		enqueue_huge_page(h, new_page);
+		enqueue_hugetlb_folio(h, new_folio);
 
 		/*
 		 * Pages have been replaced, we can safely free the old one.
-- 
2.38.1

