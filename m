Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88667B7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjAYRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjAYRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:06:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933A1568A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:06:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PFNjYJ009501;
        Wed, 25 Jan 2023 17:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=UdhtyA4FjUASukxO52LXqmfhO0liNQG7ufMjwtkaCQs=;
 b=ec8Wf+NNAnZaMF4pz7BNFbwMI6v++VIkvDWAw5ufQ7z2KutMp+O5i5dUXrJf+UBU5KQo
 LfQj138ddgp1lNlmSy0AnHE+o05BngKvJ+VUv5Pb3hfpQQpxJf6CJAZZdraIuF32GGwK
 GMrnF8yq8cFXCy3IqH+CnzFqdTqnuVUvJeuUUS4WNhFRipgL19JUelIHfVyCKgoHAdro
 jq63NX4tCxVVfK2odxm5hzLa9cFIgevjqLaaZSnjI/OijhR6z6Kd0sK8GicXNxNdRzMk
 au5A54e+4oRt8ZpZZjgH28AJNj0axnQevbaurQ7EDxFJ6UOWM56DV8Y8AoUtxWqh57UV 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c8je1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PGFv2Z025048;
        Wed, 25 Jan 2023 17:05:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gdnbdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 17:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0i2zoZnZtaz1HJF8FaoNMruxMu9cr0U7TUHkNAch2piW7vtwrC3usJcBGMRCFlSTjTsD1KYoNCGG5U+JSUbgjt/dD20ENf301Pn33GbF3rDywVrogtrMZuFOh7cZuPGPvCEGD0ljp3Co4VGFPt+08Nhn2hAKgPcJwIh9QJRgaf1IBkOsfKCIz3quFQ/e1kO0D9lE0Tyxnwjd0FKhpUBL4Ncjvvx5vTsWb4/I2eXgqd82lM0/Zm7JDc0/8EfUkJOduCyfoDGhF1XuO0yff4JKEw+/aLUmuLsx4thKy0ztEa5TDRerWN7Hapke/DGehNlbLiwtQVMJC570LZVnjbJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdhtyA4FjUASukxO52LXqmfhO0liNQG7ufMjwtkaCQs=;
 b=mPB0JIZWb7TlardGCYS5Lu0z1EBc/KIU7+5b+Z5Tmv6uLA2M6I4TN4E0ORi2DGm8+DXamSIuYAKje+9hEOezNOTMVcUUXgP9Bid4KZHeu908ubB7tMvHfKfNFTFRuZQHHHKLnj9knXVyOZf/zoyBlpntkTSyc3hw9S4sX4C4FSa38odDwVOC9J1GQsQJc4G/MHU5TSmVnCxNY27f45xVNR+tqrW4zPQJ7PnoPnwwW+nY7XhG32+yU8kpH1Tk2ZsareKcvYqbUbax0eFazy+oIRTNWxfkEN7avAdxmbRkkoJ5oPdFTqFEXIYMoSI7U/jNWpejqufMwoQ7/eYqfImQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdhtyA4FjUASukxO52LXqmfhO0liNQG7ufMjwtkaCQs=;
 b=zKpmTxuI2pafxLfZ/w6TPrv2P4QwgSm0hMbS3007CzG0h5jJ5R7rfuWVzbLMUQk5WgxDQLcmdmo5cTEHOV3RwOhAEafMi4SdZp3CFUomzRw1dqH2Vm/3JmQh9LAKZgOb3XHajBiMtEjCyOQm5bNfzhHlCyjS1zF1rTXQB6I4QAA=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by MN2PR10MB4384.namprd10.prod.outlook.com (2603:10b6:208:198::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 17:05:47 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 17:05:47 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        gerald.schaefer@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 0/8] convert hugetlb fault functions to folios
Date:   Wed, 25 Jan 2023 09:05:29 -0800
Message-Id: <20230125170537.96973-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|MN2PR10MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: e662a0f6-872c-4ba0-3983-08dafef666e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0k6dLCRpX/TSqkY1NHny2wWBnTv23Tc367ZaNaTQNoCjZQWIGYhjiDt9+K2yybrebt1LbPRyIl+iBZU5xoGZDH1qdCHzSizCqIOpIHXXBtV4OukXxLMXCLuWYo7x+SMelrlqMRw5/3rj5YqQ45WRvl4w7cjkQsm/gKsdQN7zEfZGWoM7aPYS7JOCMB6UWxbGlrfOlr/X3O8ayHfj5hI1Ppkr+szUqSbFhlX4cFoMXiOGTsD85fn+t1erPQwnAYLgKa/h+61QgOwYGV/ubClRVqmalGmI0wchRtGD2BLeVMdQ9sw2mH4pUQb6xeCaGXaXusULM6tFHaoYoJ6l+LIUarRWLv+ffLKn80vfro65UvzQgCSVM0NeG+94ATr97MaqKWrZ9OmiLwLENAIWo79jPlT98HLOFARJiMexbzcDhOXVsklmArIvpKp1nGwElonGmD9k+iuwz/0tI2k7mFobLu1XoHAMGcofXO4Lux1RMoNY5yzOrOtfcme/LK4yCCdKxARvVBzDwQweqqIKSSyj7kNz5zyHNRh7CrD1w5+JOgFNm92H1QW4rztM+rFTX6DRtlaul0+vQun6cA3FX6GvjEuGfIc3Gg769wZXCurjqyDzTxOdMms6lobmqqIFfLKLag72aHY92a8wMvfFg5h1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(186003)(26005)(6512007)(38100700002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(8936002)(41300700001)(2906002)(44832011)(107886003)(6486002)(478600001)(5660300002)(6666004)(2616005)(1076003)(6506007)(316002)(86362001)(36756003)(40140700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkPYyEJG5RK4E7I6laEYdpaBFWI/nwkin3lxGmi7oyXH4ePd03MZ/fBa6dpT?=
 =?us-ascii?Q?rZHbgL4FiXBp/PFi+BEhgIpIF1le8cX1G3qL0spwySsG3X1zgnHyVgm8sfSq?=
 =?us-ascii?Q?eI0XqDpCZ7kHaVJMccTlehLUwhmCFcgg74N9g1kTm0DNnXbN3hiSN1Tr+ueN?=
 =?us-ascii?Q?mSiT2OXPhcYbJ8kC/+xeerfdiTl6LXcOltq3YQe99SzkDx1F5wu+O8H/ephU?=
 =?us-ascii?Q?491/93MdOFW5Ny//Pl0AV71nvwVQr6PvN0MPbXPKMBzNs9rui4STRcwjogUe?=
 =?us-ascii?Q?Vq9KQXJq0gKB0fF06MF5CG/dw6m8XSYhQQ6JS9AUWsyRvlEFrQ4ye/2QuWD7?=
 =?us-ascii?Q?snftrZf79LiymwGLWb8lhbnM/AiCULFaUWVvACE02kPmkkGJRqV6t5DAToVs?=
 =?us-ascii?Q?fCW6G0Wxtf/sDHyfnwoUKI81m/KnKECxmp4gt+jfriN0XMYSZHIEtJE6TyAE?=
 =?us-ascii?Q?qviLgqHwMwwK52viwQeXgQev5X3+Q5eBwPamJQTr98/ucFos1stByustUe5W?=
 =?us-ascii?Q?FBALKwQcU10JnZXKPyYvpCvhu4Jd6Pe6ZymKE65G1FScu8Sh5i6U8IG4Lnqu?=
 =?us-ascii?Q?uAAAALvShh0YZ01EUtH4kuVQvZNdxx2HLc38XZLKeJ4x93wM92sAgcbcdJY9?=
 =?us-ascii?Q?3By1dpjn0g7NTSJlsL+QRChjxnsFe4OX3/IHykh/C7vkaA6GvZ952RkZ8p+i?=
 =?us-ascii?Q?ZAvolbAU4rEZY/sLAWOIqj/zXGpo689lIfa6O6W4qDhQ4zPc2yZHgOAP/gYs?=
 =?us-ascii?Q?IwxeIpFUmc+prXCoZ7qLE6zSITTnPs180KZxeJrQR5bT/w5LC5iXsGdmv3GP?=
 =?us-ascii?Q?FkAKQZR+KCUzCQOaCRD/BvaG51uXc8N/eko0Ossg+4xR/Q+jdzoCnIwKI58a?=
 =?us-ascii?Q?NjgWUgCGHEt1xXWGtHCKg9qGewo24I8KcafgHY79J9TCtqChe8fDlcmYy9Re?=
 =?us-ascii?Q?fI6Cm/8d9GaEoDTfScGRzUxFYfoAjmG7/rtbpNSYunnczMmd3weQCeWsXyq0?=
 =?us-ascii?Q?+BJaOxmSwJpDdfX5cvUczsW1C5I6TuZKs01dB/a26WtaZbWgkZ83JBriyxbx?=
 =?us-ascii?Q?/88FNPwk4NJo64DcAPS1AnS3uv9dGMmWR1CsMsO7wQTCvB5wXOlrHLXgOWzF?=
 =?us-ascii?Q?/JS+s6czKvgtJYiPMQuVxZhpyAZfwN+yUlaCD5gguRUghqgT4DZZnc79uMTc?=
 =?us-ascii?Q?2VIcTGoKCluJ3OQeyC09umsSh8GSFHAMO8r4cE313BZel6szVp8yvRpp+lnB?=
 =?us-ascii?Q?RgHvoMH/QWJtfmhkZbDoNUvmMmJTcLY2Y8V8PcvWPcZi73I514jBqiNGl/2V?=
 =?us-ascii?Q?kBYX9oFpwxYJnLSAu64TYn5lnbPrTu5napEDKl4xdVJThicNvZx9DyloDwXs?=
 =?us-ascii?Q?AdwqQpjA3+OheoBJnmkZdHb6p53A+Uw1CHcc4anQQ9135FxnKPgCB1IgqOu4?=
 =?us-ascii?Q?WghFknmqI2LuxutyK6BTvw04y+myDXqQjllx2ODViXRGxdqEmBit/VyGA7o4?=
 =?us-ascii?Q?lPR/aNLRSnYBw/WcYs3+GmQEslv3wTMrDdRI5oQteNnHYvtGCxtLF17dSDG8?=
 =?us-ascii?Q?zi5RZ2Qd/2xWq/vTNX3XrhU5n2Ma/2bqQtAeRMUibpAbFcCHsU4jgDC4vI87?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?V/KFxRGMVON+XPscKaLrpB7nX2RI7q2oc8rdZScKjW2P7grDpU3zNnJ1j6I6?=
 =?us-ascii?Q?csbeIKL7UBzUkq9SNVsy7orC/Mp9zra8/TZzRXAFlsbDxUBUnYdFI0+Gym5e?=
 =?us-ascii?Q?nraDZAvTtNLAqvUuBFMJd8bmxjfUghHN3+DHb2bmpI2j7jiUZ5wYVoncwBNG?=
 =?us-ascii?Q?qejpkuUSLFJX2VVoZsP5gRxQW5F1UoV+EiFc78ByQ2p2unpK8zxg+xewSdkt?=
 =?us-ascii?Q?blp/VxkFw2e5+OlK6rsCwwr5FNtHuz8w/xpg448fE0FhOsW1mi0crJvpmKTG?=
 =?us-ascii?Q?FIaN6ARtG2DiYLMsRM2vMuAKImcGbdtD3gb54jFOQyjr8Fq+G/EM+cv/mNJZ?=
 =?us-ascii?Q?PIRzh7i81nErq3q7phs4u1DKmkLoWiXLe6Onoz7s80Avd+nySu9qHP26aLSd?=
 =?us-ascii?Q?8waEBi7hcnlrSrCpcE/jcps/IQf4ar06wrLOhKdbh2XEraFeY9UYnmwNNWjz?=
 =?us-ascii?Q?JGspWVXFmB0f+gQmvh39fM5OqdVU3QGQJSXttTc62HEXt8urFn2WgjFXgfcl?=
 =?us-ascii?Q?LylrwUNG2eS/1jCTgd9OSzJJZLI6YPJ3Jg6xLK5RzbOQeoi2RypSjCAvvgB3?=
 =?us-ascii?Q?QXQ03XczOCLA8v5UDmuEpkfFQegHwubdICWTdZshVTs+N26lAbity9dESDST?=
 =?us-ascii?Q?JarifWYQG1HFkTtHKWWVdxpzGUuuzJtq12jvA5qOsv8PlEAQsGo4UTeMDBb/?=
 =?us-ascii?Q?yO6h/zko3H6VqZDLLBuiPsBCCCbABmXfbj1At0+iw3/spgn+8YRGaP34NPpO?=
 =?us-ascii?Q?K+Mr913zV5fY/6LBfojxxFtCsGS+OtplRsEsWLyODOwspbvm4RAvZ+fJtN/b?=
 =?us-ascii?Q?M7grcfLFNLStAYNw7hNtJNbWaIXoZ0ECUcZoOBv5xawZcazDDcNEYRNgva4f?=
 =?us-ascii?Q?grtiN08LIiR5/2py7iPo4t0h8ad4jUOCs+/9xVNSuo7TsoFvq1x75g0zvmad?=
 =?us-ascii?Q?SLW5rBuHNZ0HLHEMzJyp0ljBG+esj2bl3C/1DH6cEYU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e662a0f6-872c-4ba0-3983-08dafef666e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:05:47.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+efVr+jwd425AbqOWhoP5U22aYFJPjz/mqOxRQcdsyQKcxRIIVE/o6yHgzyo1DZcMpqoON2hDdr1LMmQS9iQIbNCml3XpkTgWf4ImBkVG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=803 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250152
X-Proofpoint-ORIG-GUID: kQvGTX3x-LoQ5DAC9SFnS-2eGyKxON6E
X-Proofpoint-GUID: kQvGTX3x-LoQ5DAC9SFnS-2eGyKxON6E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== CHANGE LOG ===========================
v1 -> v2
	- Add r-b to patches 1,3

	- Refactor hugetlbfs_pagecache_present() to use rcu +
	  page_cache_next_miss() per Matthew in patch 2.

	- Change function name from putback_active_hugetlb_folio()
	  to folio_putback_active_hugetlb() per Matthew in patch 3.

	- Squashed v1 patches 4-5 into one patch to make for easier
	  review as did not need to handle null page case from
	  alloc_huge_page().
	  
	  Refactor hugetlbfs_fallocate() to use same rcu +
	  page_cache_next_miss() that Matthew suggested for 
	  hugetlbfs_pagecache_present() per Mike in patch 4.

	  Initialize h_cg variable to NULL in alloc_hugetlb_folio() to 
	  suppress compiler warning when CONFIG_CGROUP_HUGETLB is not set
	  per lkp@intel.com in patch 4.

	  Changed variable page_in_pagecache to folio_in_pagecache in
	  hugetlb_mcopy_atomic_pte() as the variable is set to true once
	  the folio variable is added to the page cache in patch 4.

	- Fixed wrong change from get_page(page) ->
	  folio_get(pagecache_folio) reported by Gerald Schaefer in
	  patch 7.


============== OVERVIEW ===========================
This series converts the hugetlb page faulting functions to operate on
folios. These include hugetlb_no_page(), hugetlb_wp(),
copy_hugetlb_page_range(), and hugetlb_mcopy_atomic_pte().

patch 1-3:
        - convert prerequisite helper functions to folios.

patch 4:
        - add a folio variable to the hugetlb fault functions to complete
	  conversion to folios.

patch 5-7:
        - convert three functions to take in a folio rather than a page as
          all callers now use folios.

patch 8:
	-update documentation that references alloc_huge_page

============== TEST COVERAGE ============================

Linux Test Project Hugetlb Test Fault Coverage

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_no_page'
FUNC                              COUNT
hugetlb_no_page                    7796

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_wp'
FUNC                              COUNT
hugetlb_wp                         4623

Using fallocate commands to create files on hugeltbfs

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlbfs*'
FUNC                              COUNT
hugetlbfs_fallocate                   1


Userfaultfd selftest
./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_mcopy_atomic_pte'
FUNC                              COUNT
hugetlb_mcopy_atomic_pte           6240


[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'copy_hugetlb_page_range'
FUNC                              COUNT
copy_hugetlb_page_range               3

============== PERFORMANCE ============================
using bpftrace to track time spent in fault functions over 10 rounds of
the LTP hugetlb tests

pre-patch:

@hugetlb_wp_nsecs:
[256, 512)          3675 |@@@@@@@@@@                                          |
[512, 1K)          18875 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)            1366 |@@@                                                 |
[2K, 4K)              77 |                                                    |
[4K, 8K)              12 |                                                    |
[8K, 16K)             10 |                                                    |
[16K, 32K)             2 |                                                    |
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             0 |                                                    |
[64M, 128M)            0 |                                                    |
[128M, 256M)           0 |                                                    |
[256M, 512M)           0 |                                                    |
[512M, 1G)             0 |                                                    |
[1G, 2G)               0 |                                                    |
[2G, 4G)               1 |                                                    |

@hugetlb_no_page_nsecs:                                                                                                                                                                                                                   
[64, 128)              1 |                                                    |                                                                                                                                                           
[128, 256)             0 |                                                    |                                                                                                                                                           
[256, 512)            67 |                                                    |                                                                                                                                                           
[512, 1K)             66 |                                                    |                                                                                                                                                           
[1K, 2K)              65 |                                                    |                                                                                                                                                           
[2K, 4K)             198 |                                                    |                                                                                                                                                           
[4K, 8K)              97 |                                                    |                                                                                                                                                           
[8K, 16K)              3 |                                                    |                                                                                                                                                           
[16K, 32K)             4 |                                                    |                                                                                                                                                           
[32K, 64K)           678 |                                                    |                                                                                                                                                           
[64K, 128K)         3401 |@                                                   |                                                                                                                                                           
[128K, 256K)       96746 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                                           
[256K, 512K)         107 |                                                    |                                                                                                                                                           
[512K, 1M)             0 |                                                    |                                                                                                                                                           
[1M, 2M)               1 |                                                    |                                                                                                                                                           
[2M, 4M)               0 |                                                    |                                                                                                                                                           
[4M, 8M)               1 |                                                    |                                                                                                                                                           
[8M, 16M)              0 |                                                    |                                                                                                                                                           
[16M, 32M)             0 |                                                    |                                                                                                                                                           
[32M, 64M)             0 |                                                    |                                                                                                                                                           
[64M, 128M)            0 |                                                    |                                                                                                                                                           
[128M, 256M)           0 |                                                    |                                                                                                                                                           
[256M, 512M)           0 |                                                    |                                                                                                                                                           
[512M, 1G)             0 |                                                    |                                                                                                                                                           
[1G, 2G)               0 |                                                    |                                                                                                                                                           
[2G, 4G)             283 |                                                    |

post-patch:

@hugetlb_wp_nsecs: 
[256, 512)         22282 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)          16242 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
[1K, 2K)            1579 |@@@                                                 |
[2K, 4K)              76 |                                                    |
[4K, 8K)              18 |                                                    |
[8K, 16K)             30 |                                                    |
[16K, 32K)             4 |                                                    |

@hugetlb_no_page_nsecs:                                                                                                                                                                                                                    
[256, 512)            92 |                                                    |                                                                                                                                                            
[512, 1K)             46 |                                                    |                                                                                                                                                            
[1K, 2K)              83 |                                                    |                                                                                                                                                            
[2K, 4K)             188 |                                                    |                                                                                                                                                            
[4K, 8K)              80 |                                                    |                                                                                                                                                            
[8K, 16K)             13 |                                                    |                                                                                                                                                            
[16K, 32K)             8 |                                                    |                                                                                                                                                            
[32K, 64K)          2332 |@                                                   |                                                                                                                                                            
[64K, 128K)         7992 |@@@                                                 |                                                                                                                                                            
[128K, 256K)      106347 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[256K, 512K)         143 |                                                    |
[512K, 1M)             1 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             0 |                                                    |
[64M, 128M)            0 |                                                    |
[128M, 256M)           0 |                                                    |
[256M, 512M)           0 |                                                    |
[512M, 1G)             0 |                                                    |
[1G, 2G)               0 |                                                    |
[2G, 4G)             606 |                                                    |

rebased on 01/24/23 mm-unstable

Sidhartha Kumar (8):
  mm/hugetlb: convert hugetlb_install_page to folios
  mm/hugetlb: convert hugetlbfs_pagecache_present() to folios
  mm/hugetlb: convert putback_active_hugepage to take in a folio
  mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()
  mm/hugetlb: convert restore_reserve_on_error to take in a folio
  mm/hugetlb: convert hugetlb_add_to_page_cache to take in a folio
  mm/hugetlb: convert hugetlb_wp() to take in a folio
  Documentation/mm: update hugetlbfs documentation to mention
    alloc_hugetlb_folio

 Documentation/mm/hugetlbfs_reserv.rst         |  21 +-
 .../zh_CN/mm/hugetlbfs_reserv.rst             |  14 +-
 fs/hugetlbfs/inode.c                          |  40 +--
 include/linux/hugetlb.h                       |  16 +-
 include/linux/rmap.h                          |   2 +-
 mm/hugetlb.c                                  | 279 +++++++++---------
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |   8 +-
 mm/rmap.c                                     |   6 +-
 9 files changed, 196 insertions(+), 196 deletions(-)

-- 
2.39.1

