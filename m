Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB026F71A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEDRzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:55:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6459E72;
        Thu,  4 May 2023 10:55:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Fs8Op028937;
        Thu, 4 May 2023 17:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xGkPai7T8dHsohVMS0tBwsJGB+E18XEtp1+yFMTO4Fc=;
 b=m9OXAlV6nSPiyR056xJRfhCJnrY2oaDVuAY5tEmjZjMoEObOGWXhb5GC7FEL4tfKaVm5
 kaWJHGhmCB3GQVb6mQK3iX1lgmIX5acjtRDCJILZfrGEjW+V2xToFcLz8/Yigyf+P2hI
 v1Q/Vr3myGXnn3lgaC7d6hICPLLanIfehvMAqdP9iTpdGTtGVLtuzMOiwgqK7YBjSjBR
 5AG7kEAKg1OQZZeuaLzTxDBmRmicuBrRERe/B+oUfj5AzaRp2OklEeSTsENr9SqCX92G
 ejxox4Tz9BA7WC6SnlqZSEKmi5cvT1U8Vcrzuto9jgbLnIHnJQWILpFpFGZ8D4pzvkYx xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5ftj81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 17:55:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344Hj29Y020956;
        Thu, 4 May 2023 17:55:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tx87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 17:55:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLlZs7TYx93NiNSMhr9y/Nuu5EGKwTennWENGOn0Qqura/IjPdsQyFzF2l8Jh17MSsZv+a5nGuZs+uQSrMfzKlK+foCSeY/YiJonTypdaUFzEBfCfAKhPgjZcAfcTcb6XDvNyyyNaZHhY9cOXmxJ+UOZ0KtRJcyh5ATCdhzOnx/NhPTUZPHvSVqiO/gbJRv9P9BWh4T1q9t4V6ZKbBpo5I9PYCN+L/wRGbI4hiL7V5YBTNmw5sKEjQbz3OfOMWVJE+8UPYpZY0tNmLjnr8dvY/hf1peculrHuynf3PgtoQaMKg8q2f0+4H/Y7EcWRXy6HzwOkR9gLLRdb+AnDE3Z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGkPai7T8dHsohVMS0tBwsJGB+E18XEtp1+yFMTO4Fc=;
 b=O/xjsWRZFaSOrt3Zij4AOI7zdbqhv4lXc2rCEOMxN5bU2r9rSgGDrg+Nl4Nd/BXx2N6a/DD+GUHstqYK0HirUh7WYhWfMDiS8NwiZZQALAWg93/kKWICA7LmXU88AwDbb/mnZo7bM/Wgy0U3wm0pwmVNiUtb/sAsayRXyERr7N7FbhtJY/OhYKvazBXvBTXh3LvjXphC2g1Gv9yKXe+XDEeF4Tt1PF7UPt61hDGe0YfLSGX8VnlsW2JRXKo09lw3qdVa1ofY7fUEuv/ETAPsBbEJbyMHIGByfvAHPxN+Hv01s0KlA/YlCkI/x2uDTMvPto+v/o8Y9hxsuiEgd5HjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGkPai7T8dHsohVMS0tBwsJGB+E18XEtp1+yFMTO4Fc=;
 b=dQjxVXE+1MKThqGkHl6LAAJdWIMDm94XWWhZNVJGnHaebk+8J4oEnRwexDzlyFD1FfZuiKGbHpgQafbKSFuE/6E7q0N3acg6Yp+d04F4JhEYwBSg4GQthpiO+Sz3mID2krHAQtPm5GwvfSQRqTQIzfgK5eZzd3Q7BilE6TH++Hg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 17:55:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 17:55:21 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Stable@vger.kernel.org
Subject: [PATCH] maple_tree: Make maple state reusable after mas_empty_area()
Date:   Thu,  4 May 2023 13:55:09 -0400
Message-Id: <20230504175509.2195838-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaaaf6c-5b09-4618-6191-08db4cc8ba79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TXfVtHx/gelq7rJlKyhnx+ZzlzIroRS92cZ2XzOgrURdPRkHnvTHkDYJ1wgVb78S0YtDEqSnUGXYaNVhs4nHe+UqqZuha6/x+u1lPwH2kLVwoa5lSNsMHcxrGB5Nld8rccph8UIJEweDBR+lCAxIVYdYdaK/9OaEGbJg6eyei0pgwq2xJJ9ALw1rzWnb+gTfHTafgIN+RdCzTDzKUqYP7CJelEEayeJCErSVowXQzV6htfs446y864TLOQO2Xfn+N5rgXhk+W6JYyw5TnHfwdVdzo4ecqKwHeZbFf4FEaSU5B3R3HOdrW5U8eY+gr5eec/9Hudo+56sy6KmvoZJNJC4GWHxEJfgrnudogZm7z3HD+r/gvWo3JetP/CQQYiFL4ZkvkTYRXolb+DUAPu0gIqXDyfOpTgpmrDR8oeZqQUKxQ9HkAucFwlTAmZQoLHJ29Ya9ay91a3mwpJlqYxFu9TAfBhn5yN3VZ0tPpuDE6lwhkGPlTo8sC4c4mygSB7onINzCZdY8j02U/M90fuNuxDYELxWR410ct7tw03ZPJcyNzvo6JzQfuQZEK8lTKb/Ar9auLWJEV2hzuJQm+2Wug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(83380400001)(54906003)(478600001)(2906002)(8936002)(5660300002)(316002)(4326008)(66946007)(41300700001)(8676002)(66556008)(38100700002)(6916009)(86362001)(6486002)(36756003)(6666004)(186003)(26005)(1076003)(66476007)(6506007)(6512007)(966005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Zfs/d+6XEL00KyFB5lSZy7BeFUrtD2u2kqdcPxwXtT6L6wGWFfr7uY37jD3?=
 =?us-ascii?Q?gtbvjhBNRkY6go3xKkurcbOyPhb8s6qu8W5C7WsFj602M4yGiMdPkSyHXNj+?=
 =?us-ascii?Q?7UqkpO2+4jpOwSjAYexMIM7RRyEBXm2jNV9zq9F/zF7YlZEjQLQ+REoEO+q1?=
 =?us-ascii?Q?LNeZKMUsyLYx5q9G5ZZnufeTM9EmknArgaG47pFMW09F2X9a4eHoJaE6drhw?=
 =?us-ascii?Q?QfRbO1mBu9uBlba0CYEV01mtpBpWu7HSYXToleVAZRLSaVBEFTED5WpIGD9g?=
 =?us-ascii?Q?MKkvKGYS7ji9NId3rWNUrsm5AiqU1M1kL+EOAYWoug2lJD8ONqzCPqt4f9Ny?=
 =?us-ascii?Q?IxLNbrPbPBTJRww7imX5ISx2Qh2fNPCBpVKM0L/FF6D+mdLZoBFgyhYny9OL?=
 =?us-ascii?Q?Qvm0FhcmE0EccrzCBLfJZxYv5AkdH2/lCzUT4OmTrr2xUQTJ8c44rd0mYBUt?=
 =?us-ascii?Q?FQ0pyF4mXGqb+wS0ZucoSbFNSLMosgtW1yFRXl/Wa4qVZf8N1uEBw55l9QxK?=
 =?us-ascii?Q?3KBQP/DHeLhJJg0yBMX8YyDhiqY2g94ANm2e9LiLUMpRzbQh57/JuX7ouym2?=
 =?us-ascii?Q?DRB+0ISINxMgdT+d/6BHZEfniSsA9qjyJA4+TjCJdw+4UH85nk67tkcfrPO9?=
 =?us-ascii?Q?OZSzPXhm8T4NNbm5AIdpKeZ70JVIarxGUOCkZKbvgPiugzCyTcK1pDWJuczS?=
 =?us-ascii?Q?8o7Z0wWUU1dhe9xX+lOpVjf+FKuMYJNqfb4pBv9PST9o8AxzvKRqkP00I/hH?=
 =?us-ascii?Q?UGAql5fX6CVX+thHJ9TessQx+IXkz/kNarJb9rxn3WpPiuLfl2J/rG+ng2cR?=
 =?us-ascii?Q?19BnTlhlXDSgZ0AE/FAk9XAqTramQaKckuSWaFgOzEm1Q8mLesJSS7DGOKdU?=
 =?us-ascii?Q?9yZGrMzJm+kMjIvVnXBpLeSgNIjzY2iLJUOjW+E5x60mChcfB0QuUKcOs0S8?=
 =?us-ascii?Q?/qBelfarL8lKCkm6zGRkOLtK9zWqhCYMs6yqB1n19P3PVWVg7MhtS62oPxDZ?=
 =?us-ascii?Q?brE68MOYMCu/ibFhqlt0S1g7wZj84f18bn7LrktT5DhkxWwdTn8cjIDj0YyT?=
 =?us-ascii?Q?hRnivi7VbEsbaIX3aUi4gVWvvFG+VBoLBA1VfAYnRQADDlB52kdHcHiihIvb?=
 =?us-ascii?Q?cUgL7vSfRe0kKUL3/BKLhe/Okw4c5rG64T26TrQzfDO8MXvMZfiWd8RAg9rN?=
 =?us-ascii?Q?S92QkTPn5YFUigMfSBtkeXeK3cquhdw5XJ5JXO0rvA7k6e7a+4ZYk5zKrwSH?=
 =?us-ascii?Q?RvCnr4iFoEp8lQokTKkzdISJZWJ3uKcaHTojHKowCNhck8seMDYTNJxmKtj0?=
 =?us-ascii?Q?nu0n9hMvI2lnHvLQlAYz0pRQRZPOM7LyWcVAzWFN3ugY9pCuF9yvNeSfCbGT?=
 =?us-ascii?Q?64xfCjizHXmXWFqGzFEz7ry89GtQ+XLWNzQikVers77bRrjOALwt8gSLgBrw?=
 =?us-ascii?Q?PY3Z9QNTjIJMcGImU05nKGcwiXdatiU9NKemf7ZfU9m8VpuBRk3rb//c9VFm?=
 =?us-ascii?Q?k2jvQIzfur0ElTgPQmBalouKqcZK0dqy2LVcZDyOAFNKZ/eULXV3vhTNrYNW?=
 =?us-ascii?Q?J+KUUQDu2YPbya4+RwuyuQZ/JyRO3K05BFGwTrC3tURcepdOs6YqC1qz/zbz?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dfOCst/QFCQ7Q0jlVLxDwlf2kaxZsP7/sCsz2VEnuECsUoyftOaX0QUdzcRp?=
 =?us-ascii?Q?nuNAd8HWbRQZXN0j3G0l7LZNk+NIG1xC7p4ZzZIWhg2WsXY+4N9dfsf3Pxo6?=
 =?us-ascii?Q?3QLoI9V4MQagw3zq9Ou6rFpNHAK87OciBZHrGL5hjiaSg0FbVwrUlJdGKyOL?=
 =?us-ascii?Q?J4FMXvx2Z0oeq5syyQIvmZLs7IWCLZian/iEl6530VfSoZKvV2dqtpCwdgiJ?=
 =?us-ascii?Q?2RDiRadjJIqk8+KyBnSa7iqa/lfLom8AXdUumT24Wr9MPz4qo/J1Cgm8fEBT?=
 =?us-ascii?Q?Z/I3jTKZdm6u3RYfhPYBKDxnPDP+29xdsurfKhUKhor1jha8McdKyi2q6GnI?=
 =?us-ascii?Q?GQMQG0vJpkhQt74yG8lg5GIDMq318eSzIG4SnNqyHhqDm+Gt5MOhsDI0J3ha?=
 =?us-ascii?Q?ll5XMc/qzXufBvAZ6di1Aq43F/803VRNQiZihGe3E/qC+3CeYH0HRHnS469I?=
 =?us-ascii?Q?DX69TUy9bYaGYyc50jB/G01rIQ7IEAATaOYCs5fpgxFA78yOLmuW3nJDFc6a?=
 =?us-ascii?Q?+pAqmjQW/zK+8XcfLzypDAiBOowmAyxkG1PuB3H/vRRrHh7oaKDrXBO8tR00?=
 =?us-ascii?Q?6jXmLBCBXGGrOEwgYCW51oKCWGqgRiOYlKLvyM7f7l02VjyvmTtzdDlBjuR6?=
 =?us-ascii?Q?SP75294tLeyQwScNhfHAbGs8jY5DChgDxxcf25UTFODAUIjo2eXYPO5ZL2Qx?=
 =?us-ascii?Q?H2NODGkkGK64MoQuhBpYy4Xo9TLpitYbCAica6YT0NdvNtPu5IyUGbbT++OV?=
 =?us-ascii?Q?u/abFJretrjRq8pVhcHdnictwRNRXXcQDNbjbXwWTbO/vS7sKZnQVVfZ86k1?=
 =?us-ascii?Q?brAP3erSMt0m9HCeaWxACHJ5VWEsbDAhcmtBpduR7phmnDTUKLcucaIsL4Yb?=
 =?us-ascii?Q?DJ5509UkYhZklasMF5uOFNpSIQ1hzrsL4C6bwVgrf0dETwEr2XAQ08D4WN9+?=
 =?us-ascii?Q?GRHZaOAVrhwtPdTYnz3G+SB9HonCyyNNxBdsr8pW8cHXVovJWZyTT15GkRHw?=
 =?us-ascii?Q?kpf/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaaaf6c-5b09-4618-6191-08db4cc8ba79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:55:20.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntDkJ3CCETTnnwgmaOaPS4ve93xFsIJpVl5KsYoAahf3OVPgX9BvssUGfAWjkN3k4FgOWGHrKJKYu2m8e/nqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040143
X-Proofpoint-GUID: _e8tXct4rZroGHLRfuVLdig2Xgd2SSAD
X-Proofpoint-ORIG-GUID: _e8tXct4rZroGHLRfuVLdig2Xgd2SSAD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not update the min and max of the maple state to the slot of the leaf
node.  Leaving the min and max to the node entry allows for the maple
state to be used in other operations.

Users would get unexpected results from other operations on the maple
state after calling the affected function.

Reported-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Reported-by: Tad <support@spotco.us>
Reported-by: Michael Keyes <mgkeyes@vigovproductions.net>
Link: https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608624d.camel@intel.com/
Link: https://lore.kernel.org/linux-mm/e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us/
Fixes: Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..1c4bc7a988ed3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5285,10 +5285,6 @@ static inline int mas_sparse_area(struct ma_state *mas, unsigned long min,
 int mas_empty_area(struct ma_state *mas, unsigned long min,
 		unsigned long max, unsigned long size)
 {
-	unsigned char offset;
-	unsigned long *pivots;
-	enum maple_type mt;
-
 	if (min >= max)
 		return -EINVAL;
 
@@ -5311,18 +5307,9 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 	if (unlikely(mas_is_err(mas)))
 		return xa_err(mas->node);
 
-	offset = mas->offset;
-	if (unlikely(offset == MAPLE_NODE_SLOTS))
+	if (unlikely(mas->offset == MAPLE_NODE_SLOTS))
 		return -EBUSY;
 
-	mt = mte_node_type(mas->node);
-	pivots = ma_pivots(mas_mn(mas), mt);
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-
-	if (offset < mt_pivots[mt])
-		mas->max = pivots[offset];
-
 	if (mas->index < mas->min)
 		mas->index = mas->min;
 
-- 
2.39.2

