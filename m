Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CED719046
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFAByw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFAByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:54:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D3EE2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 18:54:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJqMv2016271;
        Thu, 1 Jun 2023 01:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=NBpoGoAitacZ1ThYk84ex4ArPoUpq1LOHrol1aC5nTg=;
 b=R8Ry3BrjdtNCN6b08yowZ+j1Y9vAhZi3LtKRU/Kp9ILah9LH6Quk5ra7bCBH3aanPjUY
 /bvyJanxwHzFwVTJIo2sszX070rarr6R3BySCPbf+7R7R1ct8zdFWQzvlIiZsuKjqqiv
 upFhbPMLdkHF5XMYBImU8T1nZ5sFpl8lP/L6UvGGlHv74tG1YepwOnR1xuuip98YTCTZ
 zZYCVSOjGATe7/++Fimill6Q2LTNHJicOpAgYH7NAdtccpq8TXPxTSxQyYeXLVaN7j4X
 k80xoP0CJiG8ZehgIll4X73XXkSIJ0FAAxr75KYbO6ybS/+oYDfvNV6WTyP/UJlVQ5WM Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmeqgn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 01:54:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VNQ8kN004399;
        Thu, 1 Jun 2023 01:54:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ye43nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 01:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1jGaQaAmQM//iBgahnQIzeE6BJ4pT0zStdLC7aJUCSq/Uz3Pb1hHMPIeHx9KdJ8CPFLXkgxrVw9cD2BpNLJI9/R1X18OFEG7KIvlUBWEcuft6tfEzesu+IDDTjyVmQDaRX4dVnjFZMeIR8+Pyou4lm/RrFhrLS+hkD5n68x29Nxat6HuJViVjOJhbh3Cii03MDBvhH6tMuoB/xnOG58D1g0XrHl6Hcxyct1sj1R880382vR77XpJC2AhdhYML5lf9z0iW+1hzVWGXhZ4Jf6NIy2AqYdw69m1s/ZH5EnWyaH49Af+lA0vd9S4aCDMns8Yv4qJHsP1YykpYDlqCPXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBpoGoAitacZ1ThYk84ex4ArPoUpq1LOHrol1aC5nTg=;
 b=WVjDx4GzUc5/xX/1EzQQ8LNfnvnYsG9/AN5SrcolPq+Qw7Ko8cXdqbHaBEJLKNHEAwNcROvIVUWxRovMrnllikSj39g+EwspHllx3w76HHjNcezpbebjQncvTiiNYSPNV2S4ZsxjOW751hFWBTd30O6uzgfDwPRmZBZjfKC8Nn27PhhaXjuvRgivKFT+zPsxx4ohHWQn3/8fnDJwtC05TfstFVpSj1Obixc9uHQ6M6UM5dz9o2cctPRVjQytByhiRFIQyfRY7Jhox/PT+wA/oONYtK3SsMwgtHhPZs3CA/QYWVZBKhQI+cBaQv/mbcfA8iZvg1eocbxSNNGPqESryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBpoGoAitacZ1ThYk84ex4ArPoUpq1LOHrol1aC5nTg=;
 b=d/VHSUc9rjw+tDE7+YDezeOngBJ0EFcwz1NPODSXxpEZKxfuU2fW0sqiJtlXM5Gz6BbqZ+555hzATZd4+XH6sUjtqOmpfgdtLLdL+z3qgmecdBsd4uiMShb2e72gGs+Liz4XUarsOvd/uaxACWs95BSXy8I3WdMavn1RysC2gP8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4245.namprd10.prod.outlook.com (2603:10b6:610:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 01:54:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 01:54:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] userfaultfd: Fix regression in userfaultfd_unmap_prep()
Date:   Wed, 31 May 2023 21:54:02 -0400
Message-Id: <20230601015402.2819343-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH2PR10MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 942a335b-5e18-4150-6c4f-08db624318c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: To+GanI2zYfXYQ5p8WSVGGlfGaGq5QZsTaqd5ZhJaUZat0CagVLQ5esAGhcTmavohD9nHx3sZsAB74IZRJzrtxZyzqLBQl4/cVsVcgSBiD78onogBwoJWJVLlDUfnJG9gj03OsUOF5iW1apr+BZc0KyBfcg5+xXfJQ4l746LxZQs4lPmPIU3DgnYVki957AZFoqYmSoKOtkfOhNaQ729LPw8pWpEkKplzf21XIjL6T9QWaF93oQI/CHcoSqIV0bcnGVPpl5qjYm+8Yy9QUDGhUL9M6U1bwAfvSxZVPH86r9WmM3KBOLVQAVzHjcB4eoCTV51WB7NLwmQijGgWTUe1gWFGwQVJqYFSZNi7qP3E2WscW/RymR0wvtsu88dnQtzxXsCxgX3sHa8Nayzob9tQPpJWPy/QHnDwm9ZqDTvTXHSpstkipCIhPzGViJUxP21MWFcNepWp9CvB8ZuoxIWtpayF5PGjsxHmpkkiIE3oOZXj9+sr9aG3SOe11Osj28RaWupXaI54Q1o+D/ZkdDNIP9JpxVP2TfWFQQD42kCh8qc4E1ygq26+j0XVln5A+Fs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(41300700001)(2906002)(66946007)(66556008)(66476007)(5660300002)(6916009)(4326008)(316002)(8676002)(8936002)(54906003)(6486002)(6666004)(478600001)(1076003)(26005)(6506007)(36756003)(186003)(2616005)(83380400001)(86362001)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KLMC/nLsUvYdqXHuhsXjFOaTRAlu8p1BuqLjSrhiqED6f7hBZO7SmN1ySQZ?=
 =?us-ascii?Q?HpInFJDwhac30Q9l+koQH/GiPPnGrpvhOAVV6xao7zTh8LmGyUTJyEAbm1hb?=
 =?us-ascii?Q?aEFKSBISjAXveTMtwTjpuYAeD/jwDfDGVRPVdcH8KMWM+QYLz5GGr4iN0FaN?=
 =?us-ascii?Q?QqcaB6CE1DJowBW2P5XufiejEpCEyR+Ls3yFRiaBRzZjJ9cAspuo1i/fRoUX?=
 =?us-ascii?Q?UTqIWEr9q6tsI0tdGSNRmxdsEdEK5/Vyo5i85LJlORhyAEDaaV3i3Hesn97Q?=
 =?us-ascii?Q?F0j8CTzkUIEa8umpTjxyO74JQMpOkmgcKMAcpk8iJ/DkMyCbzFzfxybun4xO?=
 =?us-ascii?Q?2jCTSHHoL1IitTSP5cVwuQJUzyVkoTxKCob0Q4uDlQVDVzO0kQvLq6mw6cML?=
 =?us-ascii?Q?Fpf8OPFPlgXDPuMntWZ+py5ojQwODI6YqrjbEvvTH2US6kIvtI5vEAKn0fUO?=
 =?us-ascii?Q?tb6bMokWiXS5Sk9bowvy4+SfVWYvyIR1itZ2lrzM+GVx5XGFwQXM85vNLt6v?=
 =?us-ascii?Q?1EJZ5WHr/JV4uroImSUS/LoDZq9Y5lDbRptTzLPQI5AtZpYySP9CEFNRRKsN?=
 =?us-ascii?Q?FUes/W8gJMvTyaa3BH+cMLDvGVX92IMuGBlF+6oP4G5lyLirPX6Cas1ePc1V?=
 =?us-ascii?Q?uCYe7xDABuFDsRGykLkImmIPsgS8wSGkHcOB8o39USypSbMAXie02RsCoXD6?=
 =?us-ascii?Q?dib8SCyeU1zGoMqZLuOktJpBeIkM2tIfOjyinXgGViNViw1RdtyY25SGR3fd?=
 =?us-ascii?Q?URYCYVKy5VIrAP7vDgeRoCmhb+EmZiktDVK2+VufbNxvBNmuFGdwFas6kdNo?=
 =?us-ascii?Q?7C0deDHPuntG3nFe5FNXDh26SdcdOi43ppbk+ZiBj2+qLr8K4kEB6CHjrvBW?=
 =?us-ascii?Q?NjLLQ64a42pdOIWM+TTRJpmtC4c/BN2Yj9PXoje6Japgw43ER5fkAMV2UriJ?=
 =?us-ascii?Q?fQeMjlx6cla5GuGVgeKV9WTBwFGv2Q1Zg+A0eSjFxukvil/LrVoZ10dV0GM7?=
 =?us-ascii?Q?R6T7e5A+mJqypvCLlcUhW6+W+33q9LykWj+ztTTp8cOZuOJPZvAlQxak6FYz?=
 =?us-ascii?Q?+s3t8Pc3BXfAEaVpYdWqhDhxEMZwTpq0GmV02IOpQ90S+aDZXntm3NPtOGMr?=
 =?us-ascii?Q?T+Hc0fk1XwCn+70jjsf5aibiKjtfMYdq9t+mt1axc+ZqjS4Ljfx22v+EBzk/?=
 =?us-ascii?Q?Sd/gsu4tTaO1ndAI5p6E1QetyEt4XF3goipY6+r98rNXb9DDSj8+l1OjgrRx?=
 =?us-ascii?Q?Zm9Yy2SozPXRmvS2LLH59OhwO2xPZOMtf89bX0fsr7/9YJ8qJi3Yd5n8/qmZ?=
 =?us-ascii?Q?C7Sbv/FmTik+rGYw0bkdFiH6Pims9LYGf+2HgPgrtNvUVqdNic/zr1a0oZr3?=
 =?us-ascii?Q?xyY60uTEVpZ/ssI1mq49PAPS1XHwhvNLJ6qnMq5fnYs3gpi9LlzZLk6e2zX+?=
 =?us-ascii?Q?pZzsZXpLwU1dzvwOHUmV3SNpZKgvA+14skQwe38klkp4dcBhnXvnIXG9E8MS?=
 =?us-ascii?Q?YFiSdV6oEgqgZfadUEwk3w3vOMsYKs7mG42t3+XILmZH7JWMfaddJXgGYw4D?=
 =?us-ascii?Q?43YRBnR013wJS9lIxUc21f7R+Ma5eWGrC9+muY8+ikYqRFpLq3uA+baKm4ps?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XrfRrRLd0JZNjuZS4gPEd6m95QKDg/hPo18w2r1FxHVHNRAqEaUC1znO1L8I?=
 =?us-ascii?Q?M6ybW2pMe5YjeuhyJaQc5FRWJdJyRYoMKqm9J0dH8xuZ6XnBLxcXYvn0Q5wW?=
 =?us-ascii?Q?yN9R7fk+1h2kxuha0yTxvfnKcvshArZodyOcrGBhJ2pcymcpk7IpDvtNryc0?=
 =?us-ascii?Q?srK7eF5CnbqIKBX7NkAwU2pXE6jDQr7SVxTUhit4ntQQN1Abr9EecmR9wxAf?=
 =?us-ascii?Q?ubuY7pcI1LGtMJguvHrCm5ueUZabPmiHnUNpzzy0VVoId+UnNnmdu8xru+l2?=
 =?us-ascii?Q?5+qfIQ9HL+mfO1ZC6FSRYlD0VqeA54G46prqbtFWq7EUeqS+drj6d26vLxsH?=
 =?us-ascii?Q?liHmndZvsGaU/xrI3Vm6jxHOnmUV5tIxn6gy1VxEfm22mK421wHNwyrs3bD0?=
 =?us-ascii?Q?E0TCcq+AJ+7JQIfC6hVdI52g1nsBoLtfZ+070Sx7rWZVGVOic14mca+hDZtg?=
 =?us-ascii?Q?dfJ44+ZcSbrjkozulIQBvqopZYsv+QSnZ+1rQKUwjksl4PyQUO/S0eW7AoLH?=
 =?us-ascii?Q?+IyPpcuvVZurZ7bQRENhcxcvnPFDTGoS3gPslsnMwVcTz7Wg/sfHvbB8BrRa?=
 =?us-ascii?Q?ephnPtTWae8SF5hqRNbtHw1rJpkmFMPjo1CxlW6X9qXNe+L1qDKHtzT5Q8nB?=
 =?us-ascii?Q?E663XbZBI8P30OqPtYstpglWF6ez4l2AYMsM+mB6FzaMqroHjTozqbhHZhsG?=
 =?us-ascii?Q?18L+yNsoEGacm7qzi3V0dMetyzkGyACunZhK3JWluvnYOhYGnINA1fCTMyYp?=
 =?us-ascii?Q?JFkkj7WnKwOdz5TiqwbB70QaqA4V2xIzho/lLis/CgkDI+SI2Ipx8m25nqS2?=
 =?us-ascii?Q?njFtLiOoUYvH+UAZ6eiEn/CoUsjTuDao6bsUm2xNOhhbbNRtPNCcG/zDJ4R9?=
 =?us-ascii?Q?mGByYqB9JLs7EMT7lg0G+gwh0OQM8kIdSA1vfz7I1f+gmyNux0mWya4PUV1y?=
 =?us-ascii?Q?a4FL82A7N2v7BTnkIW9lIA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942a335b-5e18-4150-6c4f-08db624318c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:54:12.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgqZaj8RhkUn73XsI9laMe7lHdMBPWGfABHtrAosUNYmPc9R3+3KkKVKxQh+liQZDyzNa4nk+u5KESc/dxlCLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010013
X-Proofpoint-ORIG-GUID: SuHcv1e9HOSErL6lMYHOicCvLoIvRvT7
X-Proofpoint-GUID: SuHcv1e9HOSErL6lMYHOicCvLoIvRvT7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Android reported a regression in the userfaultfd unmap path.  A closer
inspection on the userfaultfd_unmap_prep() change showed that a second
tree walk would be necessary in the reworked code.

Fix the regression by passing each VMA that will be unmapped through to
the userfaultfd_unmap_prep() function as they are added to the unmap
list, instead of re-walking the tree for the VMA.

Fixes: 69dbe6daf104 ("userfaultfd: use maple tree iterator to iterate VMAs")
Reported-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c              | 35 +++++++++++++++--------------------
 include/linux/userfaultfd_k.h |  6 +++---
 mm/mmap.c                     | 31 +++++++++++++++----------------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4e800bb7d2ab..a2a42a02848f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -857,31 +857,26 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx, struct list_head *unmaps,
 	return false;
 }
 
-int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+int userfaultfd_unmap_prep(struct vm_area_struct *vma, unsigned long start,
 			   unsigned long end, struct list_head *unmaps)
 {
-	VMA_ITERATOR(vmi, mm, start);
-	struct vm_area_struct *vma;
-
-	for_each_vma_range(vmi, vma, end) {
-		struct userfaultfd_unmap_ctx *unmap_ctx;
-		struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+	struct userfaultfd_unmap_ctx *unmap_ctx;
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
 
-		if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_UNMAP) ||
-		    has_unmap_ctx(ctx, unmaps, start, end))
-			continue;
+	if (!ctx || !(ctx->features & UFFD_FEATURE_EVENT_UNMAP) ||
+	    has_unmap_ctx(ctx, unmaps, start, end))
+		return 0;
 
-		unmap_ctx = kzalloc(sizeof(*unmap_ctx), GFP_KERNEL);
-		if (!unmap_ctx)
-			return -ENOMEM;
+	unmap_ctx = kzalloc(sizeof(*unmap_ctx), GFP_KERNEL);
+	if (!unmap_ctx)
+		return -ENOMEM;
 
-		userfaultfd_ctx_get(ctx);
-		atomic_inc(&ctx->mmap_changing);
-		unmap_ctx->ctx = ctx;
-		unmap_ctx->start = start;
-		unmap_ctx->end = end;
-		list_add_tail(&unmap_ctx->list, unmaps);
-	}
+	userfaultfd_ctx_get(ctx);
+	atomic_inc(&ctx->mmap_changing);
+	unmap_ctx->ctx = ctx;
+	unmap_ctx->start = start;
+	unmap_ctx->end = end;
+	list_add_tail(&unmap_ctx->list, unmaps);
 
 	return 0;
 }
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index d78b01524349..ac7b0c96d351 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -188,8 +188,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
 			       unsigned long end);
 
-extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
-				  unsigned long end, struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
@@ -271,7 +271,7 @@ static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 	return true;
 }
 
-static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
+static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 99dc60f64816..1503a7bdb192 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2420,6 +2420,21 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			goto munmap_sidetree_failed;
 
 		count++;
+		if (unlikely(uf)) {
+			/*
+			 * If userfaultfd_unmap_prep returns an error the vmas
+			 * will remain split, but userland will get a
+			 * highly unexpected error anyway. This is no
+			 * different than the case where the first of the two
+			 * __split_vma fails, but we don't undo the first
+			 * split, despite we could. This is unlikely enough
+			 * failure that it's not worth optimizing it for.
+			 */
+			error = userfaultfd_unmap_prep(next, start, end, uf);
+
+			if (error)
+				goto userfaultfd_error;
+		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 		BUG_ON(next->vm_start < start);
 		BUG_ON(next->vm_start > end);
@@ -2432,22 +2447,6 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!next)
 		next = vma_next(vmi);
 
-	if (unlikely(uf)) {
-		/*
-		 * If userfaultfd_unmap_prep returns an error the vmas
-		 * will remain split, but userland will get a
-		 * highly unexpected error anyway. This is no
-		 * different than the case where the first of the two
-		 * __split_vma fails, but we don't undo the first
-		 * split, despite we could. This is unlikely enough
-		 * failure that it's not worth optimizing it for.
-		 */
-		error = userfaultfd_unmap_prep(mm, start, end, uf);
-
-		if (error)
-			goto userfaultfd_error;
-	}
-
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-- 
2.39.2

