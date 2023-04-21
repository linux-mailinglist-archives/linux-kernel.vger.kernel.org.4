Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF056EAC23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDUN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjDUN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:57:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E412CA3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:57:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYeTk014605;
        Fri, 21 Apr 2023 13:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7TPHWbKml+7jE5nazbOtx+SnQImpE8T1NpsH1HJMmnA=;
 b=bDt4sMlwzk7CyWHXsADIzSMwsdSwXdWRj3uGCWiAL+gVtbE3uYUatUOLwJ09ZuOCHOBe
 gKXsbqv699H6Bg4hyRKhANmpMr9R0Xb2Frt1cbkFLHWOW+pbaNOh9BR9bJQoPo6xtBqg
 g0lnG1FNXrmh654liOOo++Na+DhtPjMfWiBRGxk3TdGZ6R8DzMxnMVdnqdE0x/NH6YcX
 +DG+r99Q8UuO//BD2SCj9jTgGa8V1BiZBjbqFflf55KNc4bxN2xlnGq4IYHSM+lclo8g
 YRviS6U257bfc1HN9XlRAYPJKqVMy4VWJrjNuK8o2XADx2YzTaCUemRbDt1uEmmAKo5z bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfuna92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LDDfCx037106;
        Fri, 21 Apr 2023 13:56:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcfpwgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 13:56:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaHgisfzmOf7X4t7WaOxVM8LaeeLUMkKMfOOgOSsrkOaHXOPBZZfhgf5iexYfzwl7XmUWE87dQKIyQao8e8x4wMBUiYPWDFZ9VHdObxZUKqQR9xlvJ8igKTKgzjsW7qrIzowkc3aF1DmdEM7s6GD7mL+40A0ixsq66DoA38kd2FvL0Duc9xcMNu/0a7IfJ6DougWeoc+g7Muk8r4FTrFfJpYg9yICn4QRMKj0jKk3TEjaClaWk5Nc7BNOkKWcs9KHq/d1aQ71zZYDJcaX45mO8qkmTVfr8gxzDd69jsoM8knTiqmZhArDoa05tSSFU5lz6/QCtbRJCbeT8PcXu+d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TPHWbKml+7jE5nazbOtx+SnQImpE8T1NpsH1HJMmnA=;
 b=DoLY9L1Lg8Pp+hLpRV8Kzh2+1McvIRnGDqAEm0Dp1GJSceSWsw+YebqLVkq64HMKeKKHqB391S7A0/oseKycNsSWz+pQPTk53SFGEA5f8sBRv5XvKaBOzvKGB5eZlsOCSc8JovLz2HMmN55ojo7VDnveL0PrOE9fX0mW3oC/ez+uoPpQHZnKikuRUQKkIOXt7fv4rTjCkRn330FUIdPmP5yenMRp5SlcUf3ojzz4c+Lz3wCXPRaasdECB0AoXKoj2K1zzt7G8ZmQVvDz66fSLj1397YC7dzyziQ9LOrIKyyqqtD4WjqhZKz64NHAWKmTdGCeQpvMZ0f+swFLGaAYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TPHWbKml+7jE5nazbOtx+SnQImpE8T1NpsH1HJMmnA=;
 b=WzdfU3MQMM8yXRo2FMjDDfJwdjyQ60QYu7v/8qqnvYrqaUxhiuLxR1SuGbUZmdw+uc7S33+BTzTprY9Dl8kwu5QauyZTxrSxDKTCKHb0Wb09MvhhdVyk2e2DglGcyILp27ZQzAE82eVVfx3ddpMpS2HNlGSCSvalSxccOLqVRCs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 13:56:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:56:26 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 3/4] maple_tree: Fix mas_empty_area() search
Date:   Fri, 21 Apr 2023 09:55:58 -0400
Message-Id: <20230421135559.2163923-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
References: <20230421135559.2163923-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7e4c96-1e0d-4026-6c78-08db4270332d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdahpS22DQUUyvP5taRaU6my1O2l6ezCs+xPa3wT7N64xS9NCzsiQ9/Z4vFetZp7PhhW1eieIKa637P36cAM7i40A5jWH/9LjUBQn0a3KxHq/V8BlVffv/hrtAE6YcweK/bldOtczST2lCUpzQnC3ndLPqm9++x747BonoqwmdjXE73NFTstRyvxmkP1xkx/NhKgqoqtQGdK4996RWPInABWve9JGFzI4YkBG80Jfuh0yjBqsygpEZ3L5b16osvVgGb80MVV/eXZszC5BHDWO+qPJdnimWlKwSOzA2iTOhIpKEeQ1gckZNJLLQo1zs4Dfc+5TdslWbvSN+7M4DNMnMnQXA6e+aLJus6OSHR2SLQzE3aJVmkwt02kprlC/zLZsFBvBor1vKexN3d1LhqfE+SoUS4GxwT4vLb16UM7hkZCirVgQNBSvPLwxZU7eIh0KxJ5+vOLsQTCpRuUdEPNYkkV8w4GzINpuABsK112P6r5uMlRH3srZ3OhkiiQM8XoGxytXppH2cOvLWeVPNod5R038LcORjScO3R8rr4CRfEdv/GK0yQNLMG+662n7Wcv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(8676002)(8936002)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(316002)(2906002)(5660300002)(186003)(107886003)(86362001)(1076003)(6506007)(26005)(6512007)(36756003)(83380400001)(2616005)(54906003)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oi/mRNp0E+XVTGEBbmVkZjwzi0in6Mn4tY6QSJ/8W115AhnMmupYWcufiw1/?=
 =?us-ascii?Q?H1eyyUllIKuM7b+vM2xNdnMYMmb9GodXkInEWPZXB47WqUvpyehqpXbMhbMm?=
 =?us-ascii?Q?dyZza63O/u08gjHtIUH6wljndEbL1tjecqPc8LZmNIHh1POr9U7BKjHBM6Re?=
 =?us-ascii?Q?qnBReV3BzXHAmF1wJ+jbJ4D2Gfo2AdeGrUQPn9PqrQz+/CDG6b2qSwyjPs6i?=
 =?us-ascii?Q?zbQAj3qHGe0s2atSd+LOvgTsNxYuztWhcXLC0m9fEguugtyuC6mOyLL8fHwS?=
 =?us-ascii?Q?/jUDyCfmQ8XHGfx2Uxjb9/bnrlELHjx4znMsK/tqt1TKRBlDffse+YiMss4F?=
 =?us-ascii?Q?3bOzR0YXN8UvPoawGqR3Y8I1TzVZyd0HZC1HpXZYBusGR4UqCM2UBsZ1gYTq?=
 =?us-ascii?Q?YWSOei1RV6tUpgdBQv2QDSwY8+9kAXCupJ6iy6exmt3oIQ96fO5KeB7jglTB?=
 =?us-ascii?Q?CxCDPUrRBjMdfItUqMaVhsSLqnqv3opJBZ2kbRydg7ttDn+f7ObxbTdDt2RM?=
 =?us-ascii?Q?B08Dv/fifxTvJVQ1he5njc7VgcII5+7poO3Se7Vbq32PKSqllhbKia7HoEih?=
 =?us-ascii?Q?oyh2wlcM5zTz1hCKEbis6hQNpwhTvnF5xgKMYOx3zkc6Wu6DlupPA5hw+5EZ?=
 =?us-ascii?Q?Ttn3MRTBqqHxtuOpVT2LTxLAEMuxbq7eSOMNe1N22ngxIgIWOD24vtiT3Ky1?=
 =?us-ascii?Q?tzDfjvwu7i38LmqbWyiXb8g4SXF8elmpPyh3Xy5MQuRK/lxAFI/CMwoQsSMe?=
 =?us-ascii?Q?jsfM9UwIloi4Huc5TTrUeSkujSX+06WV5gSSS+xjvymHild0GwYIxxILcRMP?=
 =?us-ascii?Q?rrzCgEhOFCoG2bnGydHwiQOiMDyckvcyAxEqWBs2NFKyB+cOQ/zX8+9WO5NE?=
 =?us-ascii?Q?7/rKANENQgoAAMXgHh/sP5xGcVNAIqZJRfJ1MvBnD1gDxltg98zAAI2f03Gh?=
 =?us-ascii?Q?qoGce8Dv5UAVewgFbFraQ5z5m7CrvtzM0wE1Vy3J+sAA9UDqrFMjDzbiWcp3?=
 =?us-ascii?Q?J6cdMSQwIAbvM/qXJ0F/htlKn+LYvu6LOFaxiOBJCoUJ+VN7MRozDFChFkF/?=
 =?us-ascii?Q?8Ioj92virSzIOqpkerEndTJIVR/9Zk6A2IM2b/LjIXBZCzDKpMNXiF52//+N?=
 =?us-ascii?Q?plqFxQ/S2hQiR2iqVTGZGXb4rRN6nbLokuuxvb+PdyLMgjBtdOmDt991v3VC?=
 =?us-ascii?Q?FGTuHv45SAjVYuRNz+bGB36KtJbHpGdyjvb00lUY5n57ne83rZo3anXG+FdP?=
 =?us-ascii?Q?mpsGd4ydzTiIOreE3A5Z2KhOraqADHhenLGMJQhD9/I+MZF9BJHR9ADibi45?=
 =?us-ascii?Q?y0fmo/8CrHUtWaOGXZSWfyrddWVMBQc8jYJiekkFzwAk09tMOxEicVAmdoRi?=
 =?us-ascii?Q?4ItUYoBbwfGDKsxul2d7fpYvSE0qhb2LSRyVDLwF1taum+kzPK9CHXaR6NUS?=
 =?us-ascii?Q?6gCsGx00XwVjkmhkd4DjWZrwg9xXCErpT/hZb5XXsTy5hgX+QLJSvB3D7ymS?=
 =?us-ascii?Q?gRvdaSBNAI8SS+s9IRJsDN8iY/K+tMbWi9Ylqh9TYC4A42/N+yyOkoQKw7pg?=
 =?us-ascii?Q?GZlELbOI6uH7CzWjX0rWLJi+0Rxe5LUWd8UDZaRfGmO9fJNKLCnYyfMD4Jta?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YmVfvVisaWyf/owDnKvjANhB/A8tjaasayT5+d+ECuwSARqEKVXnZtiIx+v2?=
 =?us-ascii?Q?mdfSIKTgyTthAxlg7WY390Dwd5OXfzSXlOwAbEUTj2+udmCg6G/Uf3i9PcyQ?=
 =?us-ascii?Q?yOWW4jQbsgPY3MERReWx9x5IRwIkTKcLbY7kUCt5ePJBwymN25hPRytXQEFy?=
 =?us-ascii?Q?TIB9Q433YAWbIkX3AOIwjqF2FbPDV8LJUY8Nv+vA+q5aD0o4e7GLfJhD3i9z?=
 =?us-ascii?Q?hBRqthC/FkJvDx+Av6oXyIUvLni0Ao5EbiTzDdScTJpbTIZguhzLDpAMMR0L?=
 =?us-ascii?Q?sfo+KtW6Vz4Zuh/DVOuedguezn5wCIY+b7ULWHzPOVkX0lVWiVZ+rU70UNh/?=
 =?us-ascii?Q?dHXhvDbDNqLYe0dnIscL4oPFkmlFxyWH6LPMqFLIlzpD6jeg+CSWKtgags6o?=
 =?us-ascii?Q?yIh/IIsmzCbd4uXAJVUqrJyDI0Qq95elJOryz5rPTIjbvfg2C0KVPso9OQ1D?=
 =?us-ascii?Q?ETK7XPvAv+a0BvR7ElGZIm1FU/U2lbRv7Q1Ino12GzqQxuGGA9BlUBXXrThG?=
 =?us-ascii?Q?PlqzfcR1GtbYg/GWXL0dyIXMdmbidX2pdkT29lzNUqfrPVOjnF9zYb4/jwlU?=
 =?us-ascii?Q?MezPiW4tFYHhOYWnx7IO8ecomv/LWAoUNAKqJMucybKCSCn1ZfLulDFqQSxW?=
 =?us-ascii?Q?QbUAfFw+OQtRGNRkrqYTlRZ9WtNfAYdNMY0xfyzzNmMZhU98yM+EY9Pnec1L?=
 =?us-ascii?Q?JeVSTdbHgs9uW/LZ7DhHYiM1CxocB/yjzC7gG6pO2b9PVTPap0u2R+pE2tcn?=
 =?us-ascii?Q?m0/D2p5SwhmIl+RLhcEWTvRBszibCL5HZdY+wuBXnO0NEISh3zSO9T5R3HXS?=
 =?us-ascii?Q?T4bZPPy8RKiBHaTn4Z3ru0PQJtxubHytUc6y2iqQCrb2c/A6Us0woj6zgpY0?=
 =?us-ascii?Q?/Q9UTU1bCu9t+pz0rB7uii8tKPjU/Gw/2dOTv8P+LyHRKUYSie4Y7RLBEAI8?=
 =?us-ascii?Q?7FucC/9nR/0PFPIY8I2K/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7e4c96-1e0d-4026-6c78-08db4270332d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 13:56:26.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz9kVsCYohCBgtUmm2HoAieKwz5CaLA6l9ZVFNtOjVvIwI4T+3oM4C1xQ1wWwj265BIGjbNLcnm36/bY1wfuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210121
X-Proofpoint-GUID: XAcGehv1Thb_F5yBuoLg8inbmZcWdz_i
X-Proofpoint-ORIG-GUID: XAcGehv1Thb_F5yBuoLg8inbmZcWdz_i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal function of mas_awalk() was incorrectly skipping the last
entry in a node, which could potentially be NULL.  This is only a
problem for the left-most node in the tree - otherwise that NULL would
not exist.

Fix mas_awalk() by using the metadata to obtain the end of the node for
the loop and the logical pivot as apposed to the raw pivot value.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cf4f6cdcaad38..51910c74d4895 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5029,10 +5029,10 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 {
 	enum maple_type type = mte_node_type(mas->node);
 	unsigned long pivot, min, gap = 0;
-	unsigned char offset;
-	unsigned long *gaps;
-	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
-	void __rcu **slots = ma_slots(mas_mn(mas), type);
+	unsigned char offset, data_end;
+	unsigned long *gaps, *pivots;
+	void __rcu **slots;
+	struct maple_node *node;
 	bool found = false;
 
 	if (ma_is_dense(type)) {
@@ -5040,13 +5040,15 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
 		return true;
 	}
 
-	gaps = ma_gaps(mte_to_node(mas->node), type);
+	node = mas_mn(mas);
+	pivots = ma_pivots(node, type);
+	slots = ma_slots(node, type);
+	gaps = ma_gaps(node, type);
 	offset = mas->offset;
 	min = mas_safe_min(mas, pivots, offset);
-	for (; offset < mt_slots[type]; offset++) {
-		pivot = mas_safe_pivot(mas, pivots, offset, type);
-		if (offset && !pivot)
-			break;
+	data_end = ma_data_end(node, type, pivots, mas->max);
+	for (; offset <= data_end; offset++) {
+		pivot = mas_logical_pivot(mas, pivots, offset, type);
 
 		/* Not within lower bounds */
 		if (mas->index > pivot)
-- 
2.39.2

