Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710363CB31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiK2WvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiK2WvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:51:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3B70DC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:51:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATMDtFM003623;
        Tue, 29 Nov 2022 22:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=41NsoJ4o2oqWcaqkV/bF829aaUMi6RclrIsMH9Q0ko8=;
 b=MEzXMj+e2rAJwiq41FwXHk/3oOGxSQqXGozWRenMSmvN2nSMI9Bf5988AVZ10dEoQqvd
 va7IInA5xi6+NK/DUfbVD4IqBeAv94hdin05AC9URt5V2AjmZhbuaPoqytRPLgwBDOTA
 R6LpKly7Jct61Nikvqtw6fnZMlD2mm3q35YPeXKyej0g2gOjfBvyHHro6CN/F5XYBHM+
 EU3QPXscRRnW5e+hLcv9TmYuVFGVyTPaZ67l4ikACRcXNun0nYUPEykFJ3TFZ2IiSTb/
 PsKddk/N10N/3Fxyw8VLva5O1ut0iidCf4KidGiZxUrik30nlca+9B69erZs0eMLegsG JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3yddk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATLsMgw026761;
        Tue, 29 Nov 2022 22:50:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1w6781-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 22:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP/SeJ5uo5D6E9ZvfdzS6acOrQkOLBfyDHLssIFtNPPH/c0Vfcoe+wj/XYZjbRWqHRjmwVga35x004lYXmvZxT5UBlV3dyA3wMSAnKzY7SV83eRX/sMODpnfR3CV5WZJ3g/BIFYIzusGN8CNdJxcUvvax946IvfLEiz8EfYtlPaSgP0D+CyWmaaIpdDhz4FANnqh1bxz86THZ5bt86Luh/C66lI7BIZgBGX0OwWu7n1nqEbByFBvnwxcBgWCCJd672NPZsTk1Nx4qBwWG7bOjn+20SNeqfsfG7tkQD3kNNmNp2XyVESQPg57REno/J/uVKzYiwrXXOMMhX1h4Dj+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41NsoJ4o2oqWcaqkV/bF829aaUMi6RclrIsMH9Q0ko8=;
 b=oJX2gp+6Z2XrrzqyQzpX9JP0faIhCWo0K1iUOBLAkK5qpptyrHST1rA9zXbV1FnG4NN/829wNvGYIBCEpIJPMx0N7hcEhuEg1fjAHl35iMFS2RquUlHgnCXRI1DbSZo8rnxL0tYJbisMBQjYIH9CDAdrd6MQ8aP11F+sqDYTueJ3ojZHrk5u7C+uYtqCZE89b72DL5i7N6FQVgaBuuRyV/c1R+8H2Dgwdjq8ZS44o2LQZG2ege7b6ER9TzSXTMMzf7xWyOxIFaupk9Gc5pfmdCZGvnp3nSh799++iUZHMMpCAqAw88ZN2X2Cg0EIrtzNCROe/CtXkpKhLmncZ+w/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41NsoJ4o2oqWcaqkV/bF829aaUMi6RclrIsMH9Q0ko8=;
 b=JSMSZ/+FW1M4X1VHktpKk96qLwm97+9EorCe+baCvrDvTHoAMwQTJT721V08GLA9JbXYhfQE8I3tgUkq6wZtDP46lHyfc9mSLtm3iu0JCROK+hcILNuk0DyqWvA1IUP1/F9WxeECXVvLZtSZpqtjZxZJ+BkB5Ozw1JedOA6hEe8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO6PR10MB5586.namprd10.prod.outlook.com (2603:10b6:303:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 22:50:47 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 22:50:47 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com, david@redhat.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v5 03/10] mm/hugetlb: convert dissolve_free_huge_page() to folios
Date:   Tue, 29 Nov 2022 14:50:32 -0800
Message-Id: <20221129225039.82257-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO6PR10MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf304ed-02ae-45e8-bcdc-08dad25c27a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AObkcQOxBh/yPRut/BZvZPBsV99NP9vvz6bBWZPh2AsdsweHHtjLgf/rLJKkcTtDeeaZitgO8f3ZPXPD637oBtzuUPLXrUlb1TdEdzd29OZQT9Nqr6x7qMzvOHQfqQYGDztYUJUOh4kNkysRN4aj5z/G6AN44hEaIXv7RUTxjf5dugb822prpnPhYXxiCa/MlJFhHfVJZ1RbYrrbQxWastzb7XMyFcxCWTL+hauZDUOOKd3/bZ9OiX/OHPd4JT2EsVrOXZqulILbvtkTF7st6ndstmuHSB/UXIb1LqkSRMietOhegq/p7s0stmug0kuIYeOJKJPO4tjkhuWwUB+qrUbpbr6Upw6jG8nNbL7mqLqi0/Q6YehMbxCVuwlLZjwvYFDZ3F6o62N8R/n1QUvXvPDoLqANYdj0tq9udc+sREZCuZaF6FAMOink6L8dm2XZqKEvd+E/Xp03U8FQTmHVWSNIzEs9pqMbqVF0lYQCYdsn8hswRYMTgR5YUiz71nyshlYvfwPqe3I6Zdo7NqeuGOYR/2egTiEj+cgPEVfudjGAca/sqlIGsIVwsjk9oyyzswUJYKe6GzBIo7UQ1KcIwKjCcjQYeO07JI8xvvIhaBE5k5rgqDYfKKb/XxLp5E3s2l8fXXMELfkrEbYzMVIbL+7UCPTD9jrQY8a/cs+ESj+o2/82NaXY8IvlpxGv35D4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(2906002)(2616005)(6486002)(186003)(41300700001)(1076003)(478600001)(36756003)(6512007)(86362001)(26005)(7416002)(83380400001)(38100700002)(6506007)(8676002)(66556008)(66476007)(4326008)(6666004)(107886003)(44832011)(316002)(66946007)(5660300002)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlKzssi+8tjWZEw8jwwuryEoI0FquqE75Hx45eBVU1jIlvsqpv9UoaoLH9d1?=
 =?us-ascii?Q?vMZrn2nFlIQcC4HKS3p+dzC1D3L4D7+ytnQw/GLcu84AWbiFYxiN4bso5MtC?=
 =?us-ascii?Q?bRMs7gUEa5gQUNMBn03BeRToijooinVmcSAxwCfIbk0oMVWRTcHOizAS4wTx?=
 =?us-ascii?Q?QfE1gAAZWF1Isy3CaeFGaU0/tlKSKpzkH2mLFlmhlk4pxJxonUWfLX9SBzj1?=
 =?us-ascii?Q?BfrOqjt6Nic7zE3izVBDTv+MpM1sMSVw5PYoyvpIe5E2XB9KqfSEjTWwW+Tx?=
 =?us-ascii?Q?gf+Ywlab8ob5gwwbIcCSIqr5Qh9qYG8Y+HasEIpkv5VKxnyGHt0gMN7aLs7F?=
 =?us-ascii?Q?vkZvlDSqAtDQOyeHgD5KIm8xAgTocTq4vNB70MwM3Fs2U4fZp0/zHIX4Kgx2?=
 =?us-ascii?Q?gNXYMHMtjmI/qmOcFoYuowryHCsUcYx8mjKBLpYZEGBiqlU3x3/l+P2yhDZU?=
 =?us-ascii?Q?p+Ly0nHMuSdWT+hEe1a2rc82Qf/iO+Enf0u3FAP1a4N7jRNWXL7Vn/CO7/0L?=
 =?us-ascii?Q?rIXSPpfzL+selFv1EeNDtfY8eQ2R+s4MKzrPNgaldvlBm+cpI1cVw2DXR4JZ?=
 =?us-ascii?Q?wj5eLoo2iwzstTTbhxZ+jgvQAahr/XFmPInvF3AQFYAU36MLiScHH5uvVPpM?=
 =?us-ascii?Q?zPTqVZNObe2FcPiZKzy8ixEWrMvTjSP5zoZVl2ZzOjNlEnbM+cK2HA6Miqrv?=
 =?us-ascii?Q?uIECI9Em37fuccqsESFBN7V+9M3MEklLeApICJvyBLuZAmj6DcBJlgJZIHNE?=
 =?us-ascii?Q?CxCh/MoNFCDixYsKsYS0UZiQ2wrndvRMYt5V1FzrpboZi3MktZOq6YelhpRD?=
 =?us-ascii?Q?smu6FKwTy5zwojJadHRxa8chcXftmfylCMnOkA5eaVviyHtsZvjlSdyy7CDQ?=
 =?us-ascii?Q?gYGYYSW3FYzLyo4UzViDN+Nh1L4q87S9HgV8TkkwP2qeM8AOySD9SZtVUxuP?=
 =?us-ascii?Q?4ATMxuIGbh9RhSn4xaekLkjSbyNC+CpofL19cGZ7gQUrCmM/Xk8k1MTxANWD?=
 =?us-ascii?Q?5zZo2UkeKXA0LSMakaVUKpDGHzct8cpHtNeFosvNi2midbC2WA7JlFrxHGPi?=
 =?us-ascii?Q?CaRJ5w4AL/pdmKyKWX0t9Q0QwhSOuw2DPRFJhG0QSEMOoRDWqUDvPEoZ9vCT?=
 =?us-ascii?Q?mLggT9FLcLD6J7X+d/uPrkjXZkZ9qsh0iSB9DptWbmbNl2h99+qm5iBZtT2I?=
 =?us-ascii?Q?aaV8srbnZpsSjP/U+h47B07cEuYVqaexXLeNhQwQfDd+IBePU0PKEZi9qbJX?=
 =?us-ascii?Q?x8AW1fkRak2dhALxIS2IcZ2PTz7x32DT7mRVW5h+ZM/7mUeTM2BypB2A2exm?=
 =?us-ascii?Q?SQujdrjI7jEdoJIkomkzbYj4hUPYfhtZgjOlFI2Dp62/ZOxKzCD52vVe5w/9?=
 =?us-ascii?Q?60Dkbru9oITUS38QTJKdKgICnJ5bw/KdAGKP4lyi0NnAJwVhwZxiQXKrNmus?=
 =?us-ascii?Q?l95Gi/xjqDj0iXp5q4GYuki1zHr6oUpH2IY+la6Qcel6E5djDCh+P9dqm9WP?=
 =?us-ascii?Q?QCg+Qf9tq59den5ZvsAfqtbvaMg3/jki09qNGUW/YTTw/Y3n76aY1TgFFXlc?=
 =?us-ascii?Q?wm0N55P/kI1y+2RkswL1i+wfnrfHYZSGwCLPhwJw8J/98pwCVhdLBNl8jiYy?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rbPLmd4AS4Zs8U1P8HR4UDU1Jc7T6hBhWWCqcvQum6a9cVLHeDwIrBy+K3cy?=
 =?us-ascii?Q?FzDiKX6+KqzvdQvd/nEuMzFazZaYKSoUMX53ddY5u2Gz3NhwHaXlaaX9jPQY?=
 =?us-ascii?Q?VMHGdgnC40a8eI9cfke+M3/w9/3t3t7+GsQZ8kV1UiM8sb5+iLUlSRPtZBbW?=
 =?us-ascii?Q?SlkxkBccCS8rYlnCEsX8q7PFqQe06e9uYg834iJD1gSsir6bKgsjx2KuK81j?=
 =?us-ascii?Q?HcKhZ5JufuAGTRu73/tR2KYcH8bNY16YIGSybuJGuIUVXCPCOo4Mu5Arntgi?=
 =?us-ascii?Q?yVEqfv5Is9kLgWUVgBlVmSPGJ4+XfXO5VmeeZ2S92by6n6LdlRNofbscNiDA?=
 =?us-ascii?Q?DIgECrY+npftyMw+g6qkjl3uLnYoHxXOfDwYuMa3bbUFk5rqhXKeDJ0ipe3F?=
 =?us-ascii?Q?7BjHP+WTaBFOfBpvsu/mnFZn7d26YHdsJ+Y5Ws62lQaLY9NMyWn+RF27kLWX?=
 =?us-ascii?Q?zNLx/YDwU4iurWnrCCKjhS5XD4lCUMDKLNdmHiOqQ4+tVGnLf4oM1BmOQiE1?=
 =?us-ascii?Q?MekG4B8ULL/j26niR2hUy0jILUxmeltiXBP+6A18A8Drgmh0nOed95qm/a3K?=
 =?us-ascii?Q?qrK9ffgGT1t+tLufTi1ustE4sVquq5weAe7pxTkEl6lGamM9Kgt4bMHKjIxH?=
 =?us-ascii?Q?Vao0LryFy/mBwYgFrWe16lCI9UYbp8ABDkDEPfT7g1WHFxzxqA7NH0Se9Uoa?=
 =?us-ascii?Q?uj9r2bT4a5D2qGzDGNsHWUM7sCt5NLRRmqqyUtSIzEpIzKb/wNDMSkyxfI1G?=
 =?us-ascii?Q?b8HeaF3O7g4SGslyZ1Btm1GbwsmuZvYRjcLBg1sbJmQO2l50w2S2I31W6WbY?=
 =?us-ascii?Q?g7OXdxzp72axS/hjvirG7OZHp4qlGZfkHGEP8k0aotAeSC99vHeEnxCg0rXF?=
 =?us-ascii?Q?QYmdlVzGRoZ9SMHl03L5nDw+PmmJuNjshx0YxLqOq0oesXV/bQ4cu1y1U0WU?=
 =?us-ascii?Q?vZU5w+//R1SQLJtzUNUv0yXX7AGrcuzdvpwrf+l/qEGgbNgTo96lsSWevypH?=
 =?us-ascii?Q?hwffsnL7bPUbyvwJWN2Z8mg8W2zXMz0hkA1K1ZhD01Du6sDFbDy6LwEk+C9L?=
 =?us-ascii?Q?+UABXJYaWR8apNV7YwnAmGYt5AdhgWeQHsUkDIpJFfyTJvjENCU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf304ed-02ae-45e8-bcdc-08dad25c27a2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 22:50:47.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5Z3Cgo6oQSmF2bdmQ1SBCtVIDKuWixSUKKf4Qs/k7dY0UR9Jlyk7axBuAJyIq52apsKeP54I/cCw2wndLB2M6A8d5gXwmhkkrvmTLnJw7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290137
X-Proofpoint-GUID: sUO7fuynA6dTTnH-9Ia3zAJch81AtlSr
X-Proofpoint-ORIG-GUID: sUO7fuynA6dTTnH-9Ia3zAJch81AtlSr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes compound_head() call by using a folio rather than a head page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f6f791675c38..d0acabbf3025 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2128,21 +2128,21 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct folio *folio = page_folio(page);
 
 retry:
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
-	if (!PageHuge(page))
+	if (!folio_test_hugetlb(folio))
 		return 0;
 
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHuge(page)) {
+	if (!folio_test_hugetlb(folio)) {
 		rc = 0;
 		goto out;
 	}
 
-	if (!page_count(page)) {
-		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
+	if (!folio_ref_count(folio)) {
+		struct hstate *h = folio_hstate(folio);
 		if (!available_huge_pages(h))
 			goto out;
 
@@ -2150,7 +2150,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * We should make sure that the page is already on the free list
 		 * when it is dissolved.
 		 */
-		if (unlikely(!HPageFreed(head))) {
+		if (unlikely(!folio_test_hugetlb_freed(folio))) {
 			spin_unlock_irq(&hugetlb_lock);
 			cond_resched();
 
@@ -2165,7 +2165,7 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		remove_hugetlb_page(h, head, false);
+		remove_hugetlb_page(h, &folio->page, false);
 		h->max_huge_pages--;
 		spin_unlock_irq(&hugetlb_lock);
 
@@ -2177,12 +2177,12 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_restore(h, head);
+		rc = hugetlb_vmemmap_restore(h, &folio->page);
 		if (!rc) {
-			update_and_free_page(h, head, false);
+			update_and_free_page(h, &folio->page, false);
 		} else {
 			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_page(h, head, false);
+			add_hugetlb_page(h, &folio->page, false);
 			h->max_huge_pages++;
 			spin_unlock_irq(&hugetlb_lock);
 		}
-- 
2.38.1

