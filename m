Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B363CB38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiK2Wvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiK2WvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4470DF6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDZrP028271;
        Tue, 29 Nov 2022 22:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=y8+A3q3OU7z0MZTrGwpnM52Q3PMm64WXjLUV67OQZgM=;
 b=tAzCtDgmycQQei0gR4i3Ln31fzYcu5p7V2mp7KlUosOqbJHO+/vbR5jL7hpwNXzUPnIo
 TvmWA9o+sV9H003iLyWh4wuSkvJIgcwNbA4NPAohpgQ4F06zF4GruxPzvNMKD46RhWrs
 11XAYj247LVefUCEqI8CxdwQmxatxtL/W9fTRvRnv7zV2PTxov9dJpQ9f0kFNRPwWco6
 UiXRLDlmwHaQVd2K9LW1rky3fPqO6YnLmnHMhTYfZ/0N7rk1IO6XyXXM24Sd+P+77vLE
 0WfJbfrYT7PPxjJMSBbg8HjZHaaj1jphWziaROts7jvy+PWWKMWAlWh971wbyooFyQbf fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2rh7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATMUMvI027897;
        Tue, 29 Nov 2022 22:50:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m4a2hp9tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPNoLGk0VTxXj4BJ1xZtDpleFhzeyy02s7orktl4ShhagS/prMOzsj62NyrZB73JUzAnP/6EW9T4T6KsQflzxMD3ZsE8XtX3C//Z9ZzON295cRLtSDFtyinS8Nt2xEqR5MsMgI0srlBXJJq/WVAPWmYlO8AijmZGgUWAauSmBEgWDIggK8E3OUtMnSrKhpHaiCgopkLWaYhbIGkmmZKRZ8YzwhrrvAS0yJ+JZyscCBMR/cyNWPovJMhA3U5PubRaOWDD5BfV1F5CXZtW4gyS3KGM/KWr43rBVnEeUFAfbw7ZRnpnkrsbOhE+6CXBCB//kej1oki5nBy4mNBkT3/hAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8+A3q3OU7z0MZTrGwpnM52Q3PMm64WXjLUV67OQZgM=;
 b=BYYlaTbq4sfBYnjhhqYPamkrWzeg16xO8Vrf/noe7LeQeXzIcFKT3uuPeFwVf2Au6UJxYm/zu99ywnjN8eL6uOqnBZbjSP1z/K7WIqn9+hhPjYSPT6Ojs5GchXdTSheVBgPlEON/Y2ZI4QgXuV4laHs2asIjphTysVj6Yjnc3SI2/przmuDTGPc4w7mTAqRXU+L0m8n4h1e81Icr7zEW+Ze3VA+oIfYSNSdWW7BvjNMFn7branW0J65isR/IhJPIxi1dVk900+1DHFwmIgL8D5z2g142GRxQiMG/YJbwmiC4NVRIQ26ngqT/esYXqOpy86s8oTzvtqv2bBXmPLIajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8+A3q3OU7z0MZTrGwpnM52Q3PMm64WXjLUV67OQZgM=;
 b=wCn6i8rkAvTKWXkotHpeAQaDlcJtd2d0q0dlmnSvqZE5YLo1mvYb8Iix/uv/z2Kn/92nv+go4Re7brHz42G+M1o+crnYlr2fDeyZgQg47HdK5bUIR7L91P9EJjAXCyJIx8IlNbqfv5FDXql4O/r+fht3F+M5NEibfm7AbcQ2wzo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 05/10] mm/hugetlb: convert update_and_free_page() to folios
Date:   Tue, 29 Nov 2022 14:50:34 -0800
Message-Id: <20221129225039.82257-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:610:54::40) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 923a941b-32c1-48ea-a991-08dad25c292e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6XJOlgCLzzqDQC7Le423cIE/7oqbcNMN/OWFxnXLIJZnyNBa1jAg/GA6QnPcdPi09XtOhpvgXQ0oG4pH3fkayg05SBBc8rfcRLPOuF0g9lP3KJphMS6RJA5aBm263JFvbzW3AdjmAgm8sK+Yll4SKVLJUIo6vXruwydgjTVplw3B+zJwlgUDitaGf8wguN5eOWOJ/agB892pm0DjogMGVgeelTk7yOczLjhwi9rlee8qHpO8CbRHUc2c0f8AuG9ydDb5zz1QXIfUHHnPJVY6hol8wpdOkU155jcaFKoxCm8tOXy4CqdPO8vqQm9Bivkqpckh6Q4uWCfII8iC6bpCJNm0fMmeYk4Bj+Ih4ApWlGOAWEwWTiI1uO904exLAcjLUKXV0/ibfCPX9QV63wJnNew2Ha8xm9gzZPDLi1YwSJ/2+JbvkhWQ8iio5mOpTe0RBUpq1h+1scupAYxqEg0s7s7EmI/vltakV/r6siQE8lbnjPjHNsWLtMvWEIfIHYsrWAvlgH7+3XGKtiOSXK2pqS2G8bdeJTKwD7qMXJDGr7ohTBCdcvtyRhSrD6vp5iCjGUcwkMEVGlU/VCxawLhhEtpGD3nwx/YyrLUkIgKlvdUDXwT6qzyChe33thNurZS1NCG26Cad/sLI8BwT23TdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(15650500001)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4VE+sPk/nhewN62ki+pzizJfVk5mw2EjMhVOf9f+JGpa1VmdzBwPyjjtmBnH?=
 =?us-ascii?Q?g0av+ppFyu4rFHGuf8Qwa6QtHBWBw8SPYh/EFRfTNHLqWXregseOVJ6FBEau?=
 =?us-ascii?Q?uBwx3hAUm8K1NMRD8fJk4QvuwRM/E3lrj3KBx/ZRAKobg/p/D9MmHTVKCfaJ?=
 =?us-ascii?Q?MfRpL2OaO8SiYNTScxDhXKk4vaKjkZDKao5FNwswcD5dXOUA06tukOcK1T2g?=
 =?us-ascii?Q?A/7ulQfmIQ2u/P+xfR1FivPP+kdRDKPLvVZW2wjo7vy1leGAkc1gCGFxvcCR?=
 =?us-ascii?Q?8naoI2k0FzZVUzRcVsCbobLCAW6DQZ0g75NA+EFvTfgSjZJnZYocyx4bVMOg?=
 =?us-ascii?Q?XEY3bXbctTIq1O4woJhidy6c80dKW9/pHZ2xJYwrKalaJAg0aRGZNGl4YLPy?=
 =?us-ascii?Q?uchDQQ4we9h9T+NKViDBi1VKawub5K5QMsr0cWWrkGkkXubcYEobwKY8JiqL?=
 =?us-ascii?Q?RIQBiIxIns8DxmFNb9kBCx7yYhIL4xbodw3eTVStdveA3bvAZlA/G3O/Xtl9?=
 =?us-ascii?Q?K/evtOmqwNiKwikar7DrASqwFbNGDsSHZU6dFDZ+jIEQBkrDQmfwOUaljPWC?=
 =?us-ascii?Q?Qe4C82VzsKboavrcMSo9YeDlQcWIXsr+CjrCs1UxkTsNcPojJiewYLRszzpZ?=
 =?us-ascii?Q?85Z0tcyZj3c8Z6LG7K3QZ4pA4z/i4/eVipmtYnrXD5T+9NE/Z8Wk6hHjkzcG?=
 =?us-ascii?Q?PaDNJQhxJdPePpatW58fw0w0zcUH2XEfLGh3qy3okJDVp3Uk+ub4p1QtxcOh?=
 =?us-ascii?Q?YWNC6K7pc9LbxLjiRpqDPUYRpODinLwZ7R54zkjwOZ3JqFQyNJQlZkvuL382?=
 =?us-ascii?Q?f58j686FRb970qgSzUNhZM18/Y1y93OjoXud1bHfMxCGFPBwUib7ucCcZQ3k?=
 =?us-ascii?Q?/Ntia8Rj2EEmfeTQ32Fz8sxq4Usw952bSkiNWBaBceeqOnwt1guy5CwLgGOT?=
 =?us-ascii?Q?m54Gl4Hw6cz1iDkttYAyYQCTiztiCvh3KW8n1bWkapAIsQGpov+gBwDGv082?=
 =?us-ascii?Q?k/jylDn27MVaOs/9uj3he7LoRX+wEeLY89XrhMCsrnCfOrDM5qBxFlmxrjAA?=
 =?us-ascii?Q?lx6fuzKJAbysubH0eBCwJ+VTMqqHUnFNuDjNZb7x9ZH3Uvp1zwdjHjE02dED?=
 =?us-ascii?Q?Yh9yrIyAo9CZiooasRPWT73xVIBmZKawVi9Luxf2fppVn8FWw4DxmsudnZIa?=
 =?us-ascii?Q?WAooN9uXLWh8/wbfF6acPt28HNSuoBk5PajEIUwmWn2roEyTO9/X0QBi4sJf?=
 =?us-ascii?Q?076yP6QXjCTdN/lTXSLAX/brN85HVzE/He8C8L/8B62ZVo40nGUQmQ9yiguI?=
 =?us-ascii?Q?Z3azOh6qhye1JWUSWp1mJjr4PdbUgdu3WouKJgBBltzk6aGP6mgoL+rF3FxX?=
 =?us-ascii?Q?VUb1fEXuhS7flebq08Jyf08XIVC3FWxRn4wIAZBEziVEVOw0NzMhzrfFEZ1k?=
 =?us-ascii?Q?dF25qvtrLL3a4N9nWNbiymD6WsUUo2lONfZmftoiu5adX8/7bNteKVwcOBFd?=
 =?us-ascii?Q?VyyuaSg26kTOBQRcVCQJdBQG4cS4TTWEHrlFXzOuB0gUBESF3t6WAcboiwVU?=
 =?us-ascii?Q?FxV5uTJ8Gb04sA96tNc9ntKYMCmDLCWLv3ujPldhgawQ0Ol312/iytF8M6Xt?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W5/m6QHFKNWqqr8eK64FFBZ5Ln47QbTx+MVNx1JAZhzUHFqFi0HMIQdnFPjE?=
 =?us-ascii?Q?RB60YZ1C7oIblicXXJrwvAkmw0MHU6sr6te3Dp9MbVb6kWj2cuJhYSABewam?=
 =?us-ascii?Q?rlk9EqPtsyr7qhpl21tIfXnRhJH00Zz0Emx1y+6RGqW1s4s93G5lnAYkks7J?=
 =?us-ascii?Q?i01bE/U/FvFIalQcDmNqZ5dAJi3cENYV1GKuIBRvpRhpZmvQG7P9WOATE8ld?=
 =?us-ascii?Q?mtevjFoEyS1E7rmVulPah3G4eCZ2egJLky3xTJ90Laa+7gFWeRXqPXBogtnp?=
 =?us-ascii?Q?mVYTHNBjPDojzCEauDSxH7ZM0M212ochABMGH9imhEnAaNyxWPQV5Z+Z6qHg?=
 =?us-ascii?Q?is+WBKuw/zzx67KOY6zhAbselJCdNrU/NvZUAd8azPHNl0yynTWbsxlmOoKP?=
 =?us-ascii?Q?IlNGUFDpTS5V5eOKHkzv18rw1tMpJD5l+0qR3hT2C9rPuor8HjW6rwMKJMQx?=
 =?us-ascii?Q?1MeaKA40me/y+OSj/7uAErrIReGi2T7F9F4mQiH6NjznoC5zo2W+8qKw1mBk?=
 =?us-ascii?Q?XgvoFG7pJc4B2xHWLAk3bxlqajY1tr8Je+FYntThWhAkI9A37vRLVOd//9Lk?=
 =?us-ascii?Q?0zcpfNqYRNdfkN5kb+b+H+z8idDCRmjcamCcLn0izWNf8JsMVBhHtWLKHYBW?=
 =?us-ascii?Q?HcqNBy9J419NG0NM0WupaFNrjVPcjPDyYBojuesXz/LTEiMPPTdQxSR4x30u?=
 =?us-ascii?Q?mxwtwx0/uhkTf19lcKkL/2Lmk3/06MbFmHnUEL6bkj/uQxhbureqymNDhlc1?=
 =?us-ascii?Q?MLEpHuPjLsSbeJ5jX8gU4Aww+fYVxhqzdoBW3JXDvNOfWSQOkudqoaH8Oe0l?=
 =?us-ascii?Q?MRwKokzyQ6x1kuJtgULZddb9HpaiF0RgjC9pPyLnZO9pNjm33NiqcarxgY8o?=
 =?us-ascii?Q?DnWrJv5Zzo0M8UjaX4p+UdBrSCrHrSCinrNx6NewRM7xvAbW0TZC4JN0uQ6g?=
 =?us-ascii?Q?Btf/SYl7topgINRkPd4VkZaw/XFzRLHe7AaTkMN014yY0zGrhLyWRYT4L86F?=
 =?us-ascii?Q?3JlyOV7SbPwXdfWHxOE/c8p8gDwBHiHs84EGmfBUbT3tM85JzXoo88CnIxJs?=
 =?us-ascii?Q?DwADb0FTgQspal6SdBhkYlOLOT9bzDg8hCUKowpzEsljgYIE47g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923a941b-32c1-48ea-a991-08dad25c292e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:50.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csn6WYul6NfqAr9CXNnHyWuaHmNbuNO1bGehdbzBcypPFDvGJH08C2whlGHXU4j/UvV3fwH4r+NCQP7c689daHbVvBw4AskhyHLYM/UMXpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: yQXmKFIDwUELylECXPH4Tt3IGGWoX5Zk
X-Proofpoint-ORIG-GUID: yQXmKFIDwUELylECXPH4Tt3IGGWoX5Zk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make more progress on converting the free_huge_page() destructor to
operate on folios by converting update_and_free_page() to folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 90ba01a76f87..83777d1ccbf3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1478,7 +1478,7 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	 * apply.
 	 *
 	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_page is called.
+	 * after update_and_free_hugetlb_folio is called.
 	 *
 	 * In the case of demote we do not ref count the page as it will soon
 	 * be turned into a page of smaller size.
@@ -1609,7 +1609,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 }
 
 /*
- * As update_and_free_page() can be called under any context, so we cannot
+ * As update_and_free_hugetlb_folio() can be called under any context, so we cannot
  * use GFP_KERNEL to allocate vmemmap pages. However, we can defer the
  * actual freeing in a workqueue to prevent from using GFP_ATOMIC to allocate
  * the vmemmap pages.
@@ -1657,11 +1657,11 @@ static inline void flush_free_hpage_work(struct hstate *h)
 		flush_work(&free_hpage_work);
 }
 
-static void update_and_free_page(struct hstate *h, struct page *page,
+static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 				 bool atomic)
 {
-	if (!HPageVmemmapOptimized(page) || !atomic) {
-		__update_and_free_page(h, page);
+	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
+		__update_and_free_page(h, &folio->page);
 		return;
 	}
 
@@ -1672,16 +1672,18 @@ static void update_and_free_page(struct hstate *h, struct page *page,
 	 * empty. Otherwise, schedule_work() had been called but the workfn
 	 * hasn't retrieved the list yet.
 	 */
-	if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
+	if (llist_add((struct llist_node *)&folio->mapping, &hpage_freelist))
 		schedule_work(&free_hpage_work);
 }
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct page *page, *t_page;
+	struct folio *folio;
 
 	list_for_each_entry_safe(page, t_page, list, lru) {
-		update_and_free_page(h, page, false);
+		folio = page_folio(page);
+		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
 }
@@ -1751,12 +1753,12 @@ void free_huge_page(struct page *page)
 	if (folio_test_hugetlb_temporary(folio)) {
 		remove_hugetlb_folio(h, folio, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page, true);
+		update_and_free_hugetlb_folio(h, folio, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
 		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
-		update_and_free_page(h, page, true);
+		update_and_free_hugetlb_folio(h, folio, true);
 	} else {
 		arch_clear_hugepage_flags(page);
 		enqueue_huge_page(h, page);
@@ -2172,8 +2174,8 @@ int dissolve_free_huge_page(struct page *page)
 		spin_unlock_irq(&hugetlb_lock);
 
 		/*
-		 * Normally update_and_free_page will allocate required vmemmmap
-		 * before freeing the page.  update_and_free_page will fail to
+		 * Normally update_and_free_hugtlb_folio will allocate required vmemmmap
+		 * before freeing the page.  update_and_free_hugtlb_folio will fail to
 		 * free the page if it can not allocate required vmemmap.  We
 		 * need to adjust max_huge_pages if the page is not freed.
 		 * Attempt to allocate vmemmmap here so that we can take
@@ -2181,7 +2183,7 @@ int dissolve_free_huge_page(struct page *page)
 		 */
 		rc = hugetlb_vmemmap_restore(h, &folio->page);
 		if (!rc) {
-			update_and_free_page(h, &folio->page, false);
+			update_and_free_hugetlb_folio(h, folio, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
 			add_hugetlb_page(h, &folio->page, false);
@@ -2818,7 +2820,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * Pages have been replaced, we can safely free the old one.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		update_and_free_page(h, old_page, false);
+		update_and_free_hugetlb_folio(h, old_folio, false);
 	}
 
 	return ret;
@@ -2827,7 +2829,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	spin_unlock_irq(&hugetlb_lock);
 	/* Page has a zero ref count, but needs a ref to be freed */
 	folio_ref_unfreeze(new_folio, 1);
-	update_and_free_page(h, new_page, false);
+	update_and_free_hugetlb_folio(h, new_folio, false);
 
 	return ret;
 }
-- 
2.38.1

