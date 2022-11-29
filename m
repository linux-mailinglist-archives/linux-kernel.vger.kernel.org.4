Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D179563CB36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiK2Wve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiK2WvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EF1EEC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:11 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDsRB003558;
        Tue, 29 Nov 2022 22:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=b3PQObH1nF66pRxTQNIQTkBEH8mytBqt2q8Yl3YFS+0=;
 b=Nin72qJYi6Zk9IHrWlVZXZs8hKIcY7DM8sVvtdIq7tclso4UZYzEaslguWgt98S5hMu3
 QchTKhzj9RWkOidkKahkXgg3Acp9nqSRDh70TpB/ButHR+FsfjgCygXy7LWrVuD+d7mY
 UuMa62GeMMVeDLEebG8/Dmf5dRKpwC3W7XGBIN4IjEAFvywdAa/l6xdf5V+SOGK1IdoA
 zErOdnYTSz0whM3m8LtWKquK0J6Aefb+9BizttmSg8AaH2t2+2J19YrJGQbStY0IZE/K
 tDvr514V2xZWinAxxS3Z3XdwW619vXsJet9Wm+fJhhiYnfVJMvvHjhwJ4fZGYJMokqnP yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3yddn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATMJiCC011526;
        Tue, 29 Nov 2022 22:50:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398ebb3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUKSxc4qdn8/OL/zAbOAJxIEUyqx4YIc8pdOQmbGMXGeu9uUbNjV6LI66PR/I5egfxxVJs7XSMfSPc7oZTVbf+6rO/DmGvzrzoTJPi/NviQbtAKa6pPefxRi3kHFPFQqXy5mpFRpwjDmBJuk5fSf1qWHAuosm2UGEaoCZ5lWZQrNMobpLMnCpTgET1kSPVnpFhCafxgnHQmfRwN5CpyIPxtIQeoQzUo1Od1fk7MqVTRTkEYs0U2drcIzVjkWfbcioLD2PdU5qOd2yRT8b3dXr6BkXzZl6mMxq54YHEyKECAukiwEV1LgOiFwx9OAbGzKAaKDRshAniU4B3tiROqPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3PQObH1nF66pRxTQNIQTkBEH8mytBqt2q8Yl3YFS+0=;
 b=ey+mGLqXHEtcDf8ezyDnibsL+D9I45bAvNgOuOwK+i1FV5loHBfcp98BSDl0eHjVyTHwwbIXPewPlhltaWIAsvXTNYCA8jiM22BTvUrgsCYj6AdhfdPFrnFsi6/PmBGRBrjA5MUBqDiMB97Ewf6q5PBvl95Tzs601K/BxcT76Y9z5pI47MtqjMbvzjGiFpC9JJFHgpwelcpf/vVSIxNjjHaEMH4W7JKXbFKwhE0BPbAX09KdofQcBk58lCnGrsl9uQzxglbuPFYX1/KYyH2mMCLqUTCiNmCe7L2WsWDicmdUeoR+gQLqMlPhRrJLAv++FXSqvgkq2hTGINdfJT10Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3PQObH1nF66pRxTQNIQTkBEH8mytBqt2q8Yl3YFS+0=;
 b=CQZivqSlQkhq7RBWt46iNvbkmqem9N8bHNgRJ5dd89nCLmolLLvn01kq1EwprPV3xbDMuA9MXfNVJNNGESP6G7Mv8+eV2KPQpZ0JgAF7tn2hclGBNPq4nX1YPWEWPfITD9quXTWV2e8jFtKdmYI3mydvZPjgnepqIRf5rw0l/xw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:48 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 04/10] mm/hugetlb: convert remove_hugetlb_page() to folios
Date:   Tue, 29 Nov 2022 14:50:33 -0800
Message-Id: <20221129225039.82257-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:610:54::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 847f9a5b-08d0-4de4-cd6f-08dad25c2868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na2VxpQ2zzAMPMeVaVbT30tbkHMqjyZkyvDOg4FzZ8Xqnwm2CSfasiRCeLgqF+w5VsW6rAlPZmsLVBLUMjHFe2FCM1k6rLiQuQ0zGh6INriinLLnQM05SEWPLPsAmN0LCrZBq8DgwgnVOKUPX5GOuI8oOxRMvP7f+b2Y4DexNbSzVpxpppejdpi743GEM8+hXkNLGTSAj2mCY2p+LCaSC1ttfcNWm0xdNkof4v1EkI2l1+DXVKZr0A2sxmJm3EGcaQZ9c5wuPB+COMP1cQXUQB68Sj+vQlAfO9Aw5Rv0JkkoUoDh/lcbbbtEsrZwpuJokj+0hk3q3emPOs8mXqMWXbgJo5pp/uww+Fs2QqlZq/QF5ILoJJPy4A123QH8WNgyisWmRdYqvGfUdVrMaAPQ2IqrwjpsJaxLAPMI7wi74oDR0ViKI9fP8SRibssgVbwSH5o1kSEGhRiS61c0GJdTKCVY7CF6g4QNYq3NObesbn92Jrrqx12OKHAnBrY2pYBbxDJ05YMsn0aNJb3VDzwSFLi2/S+DciNeliVLP1ER83pkhEM61VBkYtIyJuyFSNA7lL9U1qlI4G1P8qLvL36V4AsvssQiwavssk5v4VdBTxAlnZvDuMK8p43Xt/MODVuUOAz367k5942tNr+rv3vhIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOFypu8SK4Ua8Hp9MGiUqhr9cbBV0N/ulDZQwH3OLUuwWg+bSQDgGBpmbqf+?=
 =?us-ascii?Q?OThA420pZw9OAyj98JsclY3VEPL+6DHlfsLcdjY45hN+3g4kiOTOSk6saLkM?=
 =?us-ascii?Q?yyOH0eVwuBUM1SyH6vNtXxos9YP+Uc5AsRMIyVpxjOpk5SetfSw069m7GN2/?=
 =?us-ascii?Q?tDW5qsWorZvGtWsFuorWCB9cQE/krZ6mfolRYfiUQ9nNlWbubr1yNhCSMbuH?=
 =?us-ascii?Q?iIxSxAlNS9eDNnX4fmH0U4xIU50v3l7ZmJdQITlFv9COhCqeNIqVbmuWzLxS?=
 =?us-ascii?Q?zlKRUB27L/icYL1aVMhBi839mkbZSWhr+1fhqA1iM8Olki8dDaRu3YPSBoOq?=
 =?us-ascii?Q?DaxlkCurceOaEHa+lJEzD3BMEKW36hvGsQqxvqLefDd2Q3LCK/0aNJtDjcBg?=
 =?us-ascii?Q?RMfrWkUkee/QZmNeYxU4EECwH+pTW6wCyFW2Z3ItDunoKbsfSqCXnBMf6QzD?=
 =?us-ascii?Q?u3mtbuVI0uyxLMMPlwgfB3cjWBVS64ggqRjHji8j7VNGLoo0gXU89hnnOycZ?=
 =?us-ascii?Q?zjvaLZvHwTKuam7owl6h3Fidu2We4/TVKuLUHPyIrZfR4KecWQzc7NAH4Mm4?=
 =?us-ascii?Q?Maq0HvMZVuir7Yz64JQaOkfGQXwIAx16pgZ7QApJsB8AzwsxQnx7lirWSO+C?=
 =?us-ascii?Q?c64H2CzTbwBLcyhVHllb4/u+GwTmORjlip18HAWB/39JZ8aJtRnME9SKWiNz?=
 =?us-ascii?Q?bpqxtYQOlqZyUDjeY5ZDfjN8EXMf6CfAWqNGl6gnRk9HoxczxC5CpS+xLwKZ?=
 =?us-ascii?Q?7pn5/2fNNqM7+RqzoJlEzwANnzt7in7xkeV93E0ZvR8qRbJEh2/DBN/iAxSQ?=
 =?us-ascii?Q?l8JRJUvJibOHT7IKq86bWJCfese4jplFNiPlECLxjMrAoPO8MAr0xpy+jTVt?=
 =?us-ascii?Q?KO++3rVEc0Hg2yAsMFhDT/QUUiYaWV19az0gbpS9mRmA6DbAFHb984+LwKR3?=
 =?us-ascii?Q?UqqQLHF6tDC01dR+GpSZLei5wihxfpVX4Ktx99mYkf00+Q4N0NDYhe9daXvc?=
 =?us-ascii?Q?lvyLHXE153xi0qJyrxuKkJdwMamyLyl3PgEJP/aC2jWz/rqs7U9k2Nz4YkS0?=
 =?us-ascii?Q?xweTqWbDMGEJzwHLKeq5imknpS7PbdDj/HAOUWqop5j8t+KInP9SfItdJWqE?=
 =?us-ascii?Q?EGYp/PC8wcD6kBZMyJ+LFV63C2Kn+04r0XTyJ9HbFZVBeg5S9lfNSc6+C5uy?=
 =?us-ascii?Q?o+etu1Tz8HI5xqcyOVO6oEngYIdXGZKqsgOgKKIEb70MxJtFWApNwM5U03sF?=
 =?us-ascii?Q?1QHFdR8H8x+AeJ+6YZYBoDqTd1MJ0Av79mNP3gZi5UfjTPlnrwSB3yXOfsI1?=
 =?us-ascii?Q?unIaZBwAO+/aArbBdjClipl8m6UqOK8gm/ZTmkdy5r1yIyPS7hjTq77GyLrM?=
 =?us-ascii?Q?lUpli6rTQKKHiuBE6Vbpl/vUTAdBUADaUfcNc1RBFqG1GQUnNdmVNhFQ5D3J?=
 =?us-ascii?Q?zi/Dioq2/0oynqVwJEa925t94kRRqsbnUz9B4totH1JXyQCo36A6zl1O1eBE?=
 =?us-ascii?Q?p8DAZBs40vvQLToAqxmbfU/bXqCjNZrygM+4e0OSzRoARiSJBzIVK2D5PKIP?=
 =?us-ascii?Q?jbWFXQRgc029xth9teA8nPd7BgeGejKbVPi0yHa+yPnDEkFHQgQly8x9C8Vy?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sKsHlhnCvwYwJCo6V5KZT3MH3PnDRxbzKnUr5lMCSr1Wv5cZnae1P9bWaEOS?=
 =?us-ascii?Q?VegZlDRHpiAs8y6EIrTET4CIIWXEdwf7yuQjuFv6oRRMfAWaHvoRmokRLz8p?=
 =?us-ascii?Q?IbFGt+mgPNXMMgfKPvG6Eg03Kj9vlib1QP0gzZnq5LRP2IscGyDww9TWTlan?=
 =?us-ascii?Q?mtGi++tS0HDU0bfD3w+m40aUPQSJZHDVkjMh4kDDlPUv6kWY9EI5YnKqed5t?=
 =?us-ascii?Q?TZuGf+R+M0JGMn29LboawmvzKTUohtYWz4YzklhlIOUJsAM9F1DI/g1QWxti?=
 =?us-ascii?Q?p/lNLtkzhQDf7D/MfulGFWsmdZ0NfuMwd3n9PRo7uOUBhaglJimqVG7UIHNC?=
 =?us-ascii?Q?P0zoRAERiIcKDBO5iozGkN3CQf7LFO3lgxDPrPuQ7SFsIgszomy+D45gILUw?=
 =?us-ascii?Q?FWWETK7asTsqFbrlQCHclFBsXahnfrAIgoVhP9lCFG6tY5G4bBIYZW76TSnD?=
 =?us-ascii?Q?z7EIAuX5rPhpbmveyD9+oV3Q5hA3P7ko0c+zEWIgnDZ1t2ZCqqpKPUNyQc1a?=
 =?us-ascii?Q?5R6abSdr7juIlB0kMYTkmxATwlGzo1z9M6t+FjPSR4bmVs57P+AwzFUjbMO4?=
 =?us-ascii?Q?EYe6u9L2X6HBc3X3MFlXFIeZdcw5RLNrkfUZDLvRorm0qUgfFI46jk8htMdC?=
 =?us-ascii?Q?KS7//UmCr6BphtwpJ9HHjidSiRh/Y1Ld6oJ6PpenGX6R2b56ZV0vBefyBx7j?=
 =?us-ascii?Q?Cp4Di5jiadsWpY8mAjqj8/auDynx5+OZS/Ct1m7+nLidih5+SltAzOcZrpck?=
 =?us-ascii?Q?Cn7rZ1mseBF7Yml+/fKC3pajf0CH+TSd9ARizlfX1U3HmOz8p3x6L1cyeG/q?=
 =?us-ascii?Q?bQEGcC9JO5t2CDFaSvXEIOReOXCXWsr+fxiFAPQdBzxh0+WtSBptR29yu4AY?=
 =?us-ascii?Q?HntLt7fIZhDJe6xIcYmz/pUxjNoqVyoFIp2zXUyUwI893fgTLByJd1nwlS98?=
 =?us-ascii?Q?c/5GNMVQ+PvBmgq+/ud3uVD0cwn4gPTae1vqMvKz4qHwvYI4qj2SD5mWfCEt?=
 =?us-ascii?Q?j6V30g2q56Pimz9a9qU4WO0wVt9Ky0D8OZ8XOLro3rQdVI4L+YPwoGIEDL2N?=
 =?us-ascii?Q?OCEAKhGfKpKtPWvGi8Tl2/mzsToklASpYJJ8FKkOn9VVrTZ2xA8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847f9a5b-08d0-4de4-cd6f-08dad25c2868
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:48.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQI7h5A5vQlTBqVm0YNWaWo3khSu8PqwN45mgYJ0P6NTlIunhRZpB7ykoQbqX5a0ENxP4kQE71bIJU1QPamF9PYoRRymFpa2nfVUPwwT0zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290137
X-Proofpoint-GUID: qxSd9BZT_RFKiDg5F6SuYd686uunYFpE
X-Proofpoint-ORIG-GUID: qxSd9BZT_RFKiDg5F6SuYd686uunYFpE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes page_folio() call by converting callers to directly pass a folio
into __remove_hugetlb_page().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0acabbf3025..90ba01a76f87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1432,19 +1432,18 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 #endif
 
 /*
- * Remove hugetlb page from lists, and update dtor so that page appears
+ * Remove hugetlb folio from lists, and update dtor so that the folio appears
  * as just a compound page.
  *
- * A reference is held on the page, except in the case of demote.
+ * A reference is held on the folio, except in the case of demote.
  *
  * Must be called with hugetlb lock held.
  */
-static void __remove_hugetlb_page(struct hstate *h, struct page *page,
+static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 							bool adjust_surplus,
 							bool demote)
 {
-	int nid = page_to_nid(page);
-	struct folio *folio = page_folio(page);
+	int nid = folio_nid(folio);
 
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
@@ -1453,9 +1452,9 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	list_del(&page->lru);
+	list_del(&folio->lru);
 
-	if (HPageFreed(page)) {
+	if (folio_test_hugetlb_freed(folio)) {
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
 	}
@@ -1485,26 +1484,26 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	 * be turned into a page of smaller size.
 	 */
 	if (!demote)
-		set_page_refcounted(page);
+		folio_ref_unfreeze(folio, 1);
 	if (hstate_is_gigantic(h))
-		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
 	else
-		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
 }
 
-static void remove_hugetlb_page(struct hstate *h, struct page *page,
+static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 							bool adjust_surplus)
 {
-	__remove_hugetlb_page(h, page, adjust_surplus, false);
+	__remove_hugetlb_folio(h, folio, adjust_surplus, false);
 }
 
-static void remove_hugetlb_page_for_demote(struct hstate *h, struct page *page,
+static void remove_hugetlb_folio_for_demote(struct hstate *h, struct folio *folio,
 							bool adjust_surplus)
 {
-	__remove_hugetlb_page(h, page, adjust_surplus, true);
+	__remove_hugetlb_folio(h, folio, adjust_surplus, true);
 }
 
 static void add_hugetlb_page(struct hstate *h, struct page *page,
@@ -1639,8 +1638,9 @@ static void free_hpage_workfn(struct work_struct *work)
 		/*
 		 * The VM_BUG_ON_PAGE(!PageHuge(page), page) in page_hstate()
 		 * is going to trigger because a previous call to
-		 * remove_hugetlb_page() will set_compound_page_dtor(page,
-		 * NULL_COMPOUND_DTOR), so do not use page_hstate() directly.
+		 * remove_hugetlb_folio() will call folio_set_compound_dtor
+		 * (folio, NULL_COMPOUND_DTOR), so do not use page_hstate()
+		 * directly.
 		 */
 		h = size_to_hstate(page_size(page));
 
@@ -1749,12 +1749,12 @@ void free_huge_page(struct page *page)
 		h->resv_huge_pages++;
 
 	if (folio_test_hugetlb_temporary(folio)) {
-		remove_hugetlb_page(h, page, false);
+		remove_hugetlb_folio(h, folio, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
 	} else if (h->surplus_huge_pages_node[nid]) {
 		/* remove the page from active list */
-		remove_hugetlb_page(h, page, true);
+		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
 	} else {
@@ -2092,6 +2092,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 {
 	int nr_nodes, node;
 	struct page *page = NULL;
+	struct folio *folio;
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
@@ -2103,7 +2104,8 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		    !list_empty(&h->hugepage_freelists[node])) {
 			page = list_entry(h->hugepage_freelists[node].next,
 					  struct page, lru);
-			remove_hugetlb_page(h, page, acct_surplus);
+			folio = page_folio(page);
+			remove_hugetlb_folio(h, folio, acct_surplus);
 			break;
 		}
 	}
@@ -2165,7 +2167,7 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_page(h, &folio->page, false);
+		remove_hugetlb_folio(h, folio, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
@@ -2803,7 +2805,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		 * and enqueue_huge_page() for new_page. The counters will remain
 		 * stable since this happens under the lock.
 		 */
-		remove_hugetlb_page(h, old_page, false);
+		remove_hugetlb_folio(h, old_folio, false);
 
 		/*
 		 * Ref count on new page is already zero as it was dropped
@@ -3230,7 +3232,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 				goto out;
 			if (PageHighMem(page))
 				continue;
-			remove_hugetlb_page(h, page, false);
+			remove_hugetlb_folio(h, page_folio(page), false);
 			list_add(&page->lru, &page_list);
 		}
 	}
@@ -3441,7 +3443,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 
 	target_hstate = size_to_hstate(PAGE_SIZE << h->demote_order);
 
-	remove_hugetlb_page_for_demote(h, page, false);
+	remove_hugetlb_folio_for_demote(h, folio, false);
 	spin_unlock_irq(&hugetlb_lock);
 
 	rc = hugetlb_vmemmap_restore(h, page);
-- 
2.38.1

