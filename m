Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BA719069
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFACQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjFACQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:16:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB1121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:16:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKKa9q032512;
        Thu, 1 Jun 2023 02:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DXZBNJKbtXIsYjxQZmH5W+7HAnGRbpL0d1YP5gS3vCg=;
 b=Ini2PmSYs+MlpHE76jE7fgv7sxw6uw9/TE9JkjQS4BLvrkvxeYk/lZCTTauLSva1lAkv
 g6VBf1WUUqU9Y8TfU6nqnPJNfVaCgM7KcVtlhmtD542l13xFdjUfqEAvK/j+eOYc6YXS
 4C+5bi1TOgg9hBRKDpI5m0oHV5CAJ9XAnyMx8MQ+GMgQTfrxmOIAVGqlZwSIYw51dypj
 p4yk1wPVKbQK3I7uPXdQ/f1eZU68+4u9JSA6HCkCUQjV6IC53OxbouuLjlUO5gW1tk6n
 u7cQpm9rnWB6qYi+3UOs0wVP5sgehRLQLQZ4H93WOHBeJeaHcRYEd69bTSjgzmoOjjj/ BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb97hv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3511iDvS030012;
        Thu, 1 Jun 2023 02:16:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a78d62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TARRofr4cjUDTAqsiQ5nJKmGq+JbwsORo/M0ZgG7fpDekNw5cHeLQ026lzkUmmr6O1SVwf87UcTvEdcwyj8fv+WnnjKU2MQqWNNcIwAwgfEEK+QmJf1+a55WAOTcijaBwXmPgMfqQvPPNzMaiulNKMRjxCO4mMkiTu78u7fjJk4GSwjBJoV/Xf6vlMy3XskB+zLf1rirnnwiTv746n5bLQE87bwFd8656txoRF7kNp4SWmUBHeLYlWlXKvDvQ4pRt4JAbAjsN8gWlhUZHze4ypXbBaNF4FMfDJOkIbT903QhhintzVvkF5b1YJ6g62+kAnHFxU+NIJtJPf9Arb2JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXZBNJKbtXIsYjxQZmH5W+7HAnGRbpL0d1YP5gS3vCg=;
 b=jE9AHCRf2J0JnvYZzrWqKxtLCgFniD5bILQVjYMzgOTSKv1XFjl9MBV6L//xC67qxe2RckS+APapfGo3hQPRHtm6DEaipSkOgMAxDUcwYuN2OlurB7wteJVzQNixs2IrtSqyxz8BaDBTtm8nEJltYHJvZWMoEWruCzr8VmVBo93V/fkU+QbE34U4ar5ZBtpphTnXCKeAd1GSjoScozLuVHkHnILuGmjG3bQIvV5/bUEDvtkfulOtrk77tbKC8+x4PiTnRhCLzsvTHnhM4EJG7HuxKRIPWOb+tNEL+xrN1bLpg/SmOTUG55PQof7sE34w02i/gsS4RczuwkU+bQpngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXZBNJKbtXIsYjxQZmH5W+7HAnGRbpL0d1YP5gS3vCg=;
 b=o8dpbiBBq8iBErTv1ob8HEVetT7S4i7o3XXs0+y8imwxxFmkafAGsMR7Bhputi+8BiiwxR18eb/jfkHY7L9sD/f9n4DFpJyGkJD8yphS/Dz7c3jCVTz8YoABaLxXAHOAi3K7nbkCS2YFE+eY22pM9UgCVnYzz28r7gTnuFT48wk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:16 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 00/14] Reduce preallocations for maple tree
Date:   Wed, 31 May 2023 22:15:51 -0400
Message-Id: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0340.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: b0512e6f-9084-44ae-3489-08db62462e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2uYC4tNkU8eTIhOBoTeqCC5+ndXkJhOJE4sQZpiwJK2wgVlAjIG+yGysM3sJaPYVJdMcnDkOgHgbSCjYU/06Cs7btfsrrZOslcfaZ5Cq9w7b7e1oXgpBcdiqg2LWzsAcTzjLRXyjR+xLzKA2fofdgtdEU8A1ZL2oxsZr4xFhZ4IznFBV5pQaZ/ez3QU8ZYYLnJj4eq9DomC/e3tZR+sYvwcQAdQtbcPCAx+VTlNzvi67ojif3Zc8CtUewf9a51OFQOHH8cGsH1dVi3V3z0eJ0BQM/bD7v1cc4IyoFGgyJ5ckpiRuafLGuMQmMLEU2sY1QT7uJNlzuNJ88B0GqIYwKT1W3dEhbAbBAY9LSgCfgcASaavmxC1BcUIr1p1RBvH95lpYg2z9NXcUyQ1i6LyAJ/iV8+3BoU9Swb+8okopTAK4PfBIv6cisy4RnMExJfKqt9blNyACtR4o8o2drrDsI+5ji4yDG0jZFDdBl7SyWrhYoFfx9YaiuosNpp8GOhMRQBdWWhgl+bKO0Usf/ARoXjiLMLaGODbCyEOU3+1Pp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(966005)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0jO7AoY0r3CQdDOqW2T8pPFB8go+RVp0THeMccEOZ3U//LceD3I58H3WL5U?=
 =?us-ascii?Q?c9wUfThuWiTQrOu1UZ9OmGjAqTWB7N/jbOhghbnTa2dU2QZvOEdT1L3Nn0jl?=
 =?us-ascii?Q?OHr1Tjw+QUpVhvbH0DG/Ibx0fkNSynuqd0DYtGL3eYGkMRrfdhkm6yfpgJWq?=
 =?us-ascii?Q?EyEbNOiYy4jMW2AoOB8KfX5P6bxxPNy36S+lkzperwVwmNLASJs/6yzKM5gt?=
 =?us-ascii?Q?2UjY5vFNB1IDrrFi34vsWnfXDpRxc8hvA42mOsE8r13NiB/jya3itAYVhxFp?=
 =?us-ascii?Q?t5uAB4w85O8grGxQBIv4pR8DFgFZn3AQMQ23zYEWJDzyZ24wwjs0JwiE2++f?=
 =?us-ascii?Q?5PDIBYJa2BlYUeXBkv8zfPOUuW71JKv3gfegt6+8njSL/svdYnQ2DgZBC/VH?=
 =?us-ascii?Q?UzwOcgCJYZvK6kmMb2IFBhYVAQGWwgRJrssw7tD/qItsHJoFQlU3Oyq+FwyY?=
 =?us-ascii?Q?fExc3W7lMYnV75gzgvRMHMWsByUtjiTLiDowiLUguDqETUF5remMY3oUITNN?=
 =?us-ascii?Q?gXU7mMQkSDYeTGUnJ0ojHvTEF97Y412SpRqhxtqjEZX2V9tXC51m+igTDNEp?=
 =?us-ascii?Q?V4X3fVwXMXVrLZewkaT6Toe68yXIUMTJDue614ZzKyF5nLLm87El4hutvz/t?=
 =?us-ascii?Q?nUcjRZF0DG4w0wF6BrNyMm/pTul/ElyyzHoEuhpa+OjxKG/flrBw9xiNN9Z8?=
 =?us-ascii?Q?ayczXQPFhXAJkkGCo14KHEh9uENuUovCtrs/opYsHnsaK9nq4wsV3XhKLfKT?=
 =?us-ascii?Q?DqQDs8Eb0h7hkaxTSyqsQMf2Bs4tCxoGztz4Tf2XGDIUHkZrQQTo3+2afov/?=
 =?us-ascii?Q?6YA6BJh20dk8xR4t2n/ABm0Lm1ATuT14oudnYlZG4B0E7W3b1LaTV1s+n+wo?=
 =?us-ascii?Q?1Z1Z0o3Jpw3BQNWiq0evQtbU3SbIkLEDDVWSfuLU6mVgWIi3F9B75Kx8AHUM?=
 =?us-ascii?Q?mMxDh3/1OWKyT9MKQFqI4FfN8A3NECGi+xUh3XTpJMIZuKTUTP95kHoAM15J?=
 =?us-ascii?Q?fOU69++ujNxKx2RRFlGo0FzXO+pT5M80g7RFBZ1Uor1LbErOSJdjPW3z8Dss?=
 =?us-ascii?Q?y8gdMSZ6c1gKjpmYqiAkm3qOUiOLnJJ9hgoTQo6d9V/JSD3JGK6QDAxm/ll9?=
 =?us-ascii?Q?YiwkQDEjFt2wXSjvW4T89GT/w0Fi/X8RJdhKlGKGCEjSwVxqo78TCLRVWUn2?=
 =?us-ascii?Q?+j/vRX+Zxwih/e0R5D1ZO4+0Em97SIxNp2DAisTYteqCFhh3txXld2sXkrjh?=
 =?us-ascii?Q?ub82EU15LKC4+iQICA8iZJJyAiHWEA/Azz93hsIf+Zr5u7GK3r/WVGWB+3Jt?=
 =?us-ascii?Q?eEhqrGpupKzOfG1Zc8pparfo6QHLBUOL1Tj050gt7R5KfQ0AWruk0sf2oYJs?=
 =?us-ascii?Q?SobDqhOLZNYzd07Bq1hljdHLCavnR3ZR2e1oZQ4UHmopon9C42rofci9cS7/?=
 =?us-ascii?Q?wN8pRUyaY1COYtl5uYmZyZloG1rr9PsRYtWK18Waub4BwX1PG9ObQV5JuOo1?=
 =?us-ascii?Q?/z0KCh76cDcDypq2gvZogN+c1QtuKEgIH/oL9AH4tD16PdFhXFoUXm/Uz3nD?=
 =?us-ascii?Q?lXsNpsCRNEWhq+0P8My9cfdW0fRRPBsZB33K0r5fft/4K6tO66OKRUpp2lOt?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GfKA4Bxt1DRYtJUiiAYr/9a3hLDeAqORN6WmzACdIDLZ6VkNjke57w/dcuhCIKj9haScO+res18z2G1m0ZYepSRIELRaMcFULQQr/Nak2csXL1T2+qg6QZlkRctdpic5x/N22cat1ZqJk5DY4Tuc1E/SFR60NzMl4XI5uFY6eFcp/aZF+jDBJycoACvc+F9mKbLSqO4h4PySXVjbmDnjiv7eeasXHJK/6qaVZXTdZDOKAes4LE0vUzbWANpAS/tGItFJK2tuF5Ep1g83IAcUiUSKMPzeggSbwcrP9Yy7OwjPhk8EG+bt+ZK2wmsHqHNM9FVR70QfX3/K7Y+Doi9q7XyWd5hhTeEOikVB3C2M2YAV1MPHcUCXVL0epjOMZbnKLNJOIp5GloDNGRkNzJNQ7LTmttBfzK9sfsk1ZJ2JAJUNUVvv0NK6OFjYiq2qdAaqMAyBpFBbFrYBvEHd8haD3d5YvalfuZSG1h3Y6PA96b/No7pxGetR1vSBES9AOvysacO+75kCU3n7lnymydmt5d4l0n2XeUY4iMhcys72SPdufdKhtqcecaOu7WpglJFK7I1GaXefyVIfazLtcCxlf3FuOR3PEwebmPvYrOTKsbk82MFcjS5pQ/yr812P/sLSsUhDG80uRxUGc5c2Ng5AFdGEqqYTiUrbXOZnVkHhkLW1bGW35UMfRkSovRuLiPrnSncTCPxExS2nPyNTEZ73SBelHKQjGSAqwfLM270SwkiLPsob3oDmNpSbLzRwf8WBf+V4wdkACKWG8jHCfUNhlFzxqB9iT5unLAVdDbhtkDImr/FNWjePxxjipNSU4kI/xVE3HOrfQpVoi8rgmhnItdO9u0mspmEtkE30WG15X2LwPM5dotuxJlWxj4KCxuuvEcEdGPfb4NdJY+cuRnBMyA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0512e6f-9084-44ae-3489-08db62462e42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:16.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kZ1RZDbg6zaUQzp6GiQ8se5mupwRCSnuvkz9ggZIcvEL5cAxVdo+dZk9StnF6+vVJFRDUAYr/5vNHhIyZYFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: pEJ2Zag0rvTMbKcf1ly0-5Q8z07d2QWH
X-Proofpoint-ORIG-GUID: pEJ2Zag0rvTMbKcf1ly0-5Q8z07d2QWH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial work on preallocations showed no regression in performance
during testing, but recently some users (both on [1] and off [android]
list) have reported that preallocating the worst-case number of nodes
has caused some slow down.  This patch set addresses the number of
allocations in a few ways.

During munmap() most munmap() operations will remove a single VMA, so
leverage the fact that the maple tree can place a single pointer at
range 0 - 0 without allocating.  This is done by changing the index in
the 'sidetree'.

Re-introduce the entry argument to mas_preallocate() so that a more
intelligent guess of the node count can be made.

Patches are in the following order:
0001-0002: Testing framework for benchmarking some operations
0003-0004: Reduction of maple node allocation in sidetree
0005:      Small cleanup of do_vmi_align_munmap()
0006-0013: mas_preallocate() calculation change
0014:      Change the vma iterator order

[1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/

Liam R. Howlett (14):
  maple_tree: Add benchmarking for mas_for_each
  maple_tree: Add benchmarking for mas_prev()
  mm: Move unmap_vmas() declaration to internal header
  mm: Change do_vmi_align_munmap() side tree index
  mm: Remove prev check from do_vmi_align_munmap()
  maple_tree: Introduce __mas_set_range()
  mm: Remove re-walk from mmap_region()
  maple_tree: Re-introduce entry to mas_preallocate() arguments
  mm: Use vma_iter_clear_gfp() in nommu
  mm: Set up vma iterator for vma_iter_prealloc() calls
  maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
  maple_tree: Update mas_preallocate() testing
  maple_tree: Refine mas_preallocate() node calculations
  mm/mmap: Change vma iteration order in do_vmi_align_munmap()

 fs/exec.c                        |   1 +
 include/linux/maple_tree.h       |  23 ++++-
 include/linux/mm.h               |   4 -
 lib/maple_tree.c                 |  78 ++++++++++----
 lib/test_maple_tree.c            |  74 +++++++++++++
 mm/internal.h                    |  40 ++++++--
 mm/memory.c                      |  16 ++-
 mm/mmap.c                        | 171 ++++++++++++++++---------------
 mm/nommu.c                       |  45 ++++----
 tools/testing/radix-tree/maple.c |  59 ++++++-----
 10 files changed, 331 insertions(+), 180 deletions(-)

-- 
2.39.2

