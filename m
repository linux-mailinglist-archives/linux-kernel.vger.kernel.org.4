Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82381683980
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjAaWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjAaWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDF46157
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIipT4014564;
        Tue, 31 Jan 2023 22:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ueUn6sAjk+7F7fcd6w6E4ANiAyzQszRzkUoknyVe7y8=;
 b=xDMPIueyTsGGIR3aqR7G4PKLJAynIn3xeyQuGnMsqMLLIeUSi1e6V3G0HdkH0y37ZoEz
 RdEwTjhozygPrQuWdSslqdSEx9xfkXmacibqo//x74dgazRsEfuZdluizLlN8jZPLKnA
 6VX/l/pw303qn6NgQaSMa+sRx+u6CpZvyiEq5INKnjPZqKwejDdH4d1cUuFmMi/UpTRY
 pISznsuOWXKeyijjfudl4M8QlLs88ijKub/o5sLMZcWL26bUR715iKaqS5j/yey6uoS+
 Jy47EhxqpV7dBacXFlhWuyB/HdN9uejfPq1PTV/zEruI+ltEHHjHpdOkSJwj06vGChGJ Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvq9q0p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLD9MS031581;
        Tue, 31 Jan 2023 22:43:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d6xqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuJmzZmDhv9YokU/jTbSW+CIUrqkq5bnkHrmZYORfq7Gs7Kq/fl4rU7xd6Au4WTOhhM4j2fVHd7gHMQgi3KuVyr2UP5EAl2aqtZWjLTh9kVKphh5Kexl+9vmeG7GxUg/kXiKavLbGXQmk3HUTiMrzbRnZcLTt1pu5SpFRcgUT8/SPpEX574J4tYDUcJ8g+jRyJxQjkaZZAPku/ih423yCJwGrP8SvOG/Z+iCEot8go/aA12MZCSWA4jJeqgen+F7xMsQff20GihlVkRAn6mYRujkao/CmOKKwKprIi16UsrcpgIvQ6AVYHIprm2ygprWhWe0Dcf0+hJ6wiRHlocPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueUn6sAjk+7F7fcd6w6E4ANiAyzQszRzkUoknyVe7y8=;
 b=NFH9EQFXaFWdH0ZO4Nh1POJTm8jqjNMIDO6i8E5RCKLrtUrMt8NtHSDWd8liq7yzf7lvpSkEqg7hYzoRoVkV2QVKcOF1t9dbCpLyTY9rAXmgj0R/yMZ+YWOpFWTm7CVBIxGr5K5hWzn8oCRWe1KGst53NMvo8bV+pIk4FPW94MEv7aJiHEZyzfQqwIWuYgBIVC23sThBPvwnUtIY4RMYNbrWQ9DWw5MK6hWRMvDxpi5kDzEEWM8T9Pj87idIGFU87i0nEdJlmTJpdDsTbtUA7ypinAf0TWDqIQMipJ2StvDYb+/Qqzgzftz6kh3+YwvvxTqVxZ5dzdZUcHs0TrBUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueUn6sAjk+7F7fcd6w6E4ANiAyzQszRzkUoknyVe7y8=;
 b=pq3Si3/9GTEl0aUhTfybQ/t1T65hsAjF6JMeDo9O9fPsqN6J8R1XSm56aFGVjJhOcn+AxFhFg3zFRKLm2+R+MlMwzfh6fdihQVDi9cBiez9X6gUrRdtlYSy00OMN7DrgsIjziSo6T4uXda1qW+mxzrj9TKBvlgZRDDc4buVE/6c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:42:45 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:45 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v18 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Tue, 31 Jan 2023 17:42:29 -0500
Message-Id: <20230131224236.122805-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:8:57::22) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f9671054-121e-47d9-ba49-08db03dc7827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgSbg2679RhJx5YoSmT06GTpNayJjRyH6ZH1PDaBCwdpTjOo9mH47xkOdvmgqc50q3FsVziXuSj4+j6OPRLJY7fmMuNpw+5gp6h0XI/VFcN3iL2BnKnl+WwcOW6JwwkXozwizdQVk4YnFWYSYu1iis/ZkyB/Y3RRHPUgwcEuxlskHD6VAF9Jzr0W2v/yKvjPPVb9WBV4M94JVVFN+1suVdWcWMt/1FjDoS4DybWQ/+bfS4g1+UU1sqL/Lat9gfVopx3Skl9IL/HrxrUb9tTP6ogLPmxZA99l5sj2VN2PsRt+fgnOA0lu5bjyEm4977HOklLWOK315fLzLGZiqvMlSNwuVyaJbJOhTokJ395N9OOtcKgfgUg38DI42SK1smByXUHAO5pGiFrwmtRuC6bCi8IBVKxBjt+difaD5e4RSu7wXOsKtGLxXqbS2wKZWly/xUN19ai3JkdKQYToshuNTxySgWX6+5IGMo/TCixXN5KyeblUGYby2TDVcsd4H9C6JdbpFECmzy3hPi4IAgLdAMCLpvfmrF9AXeWmxHk7zi76+t7wQ/Mh84r3vNp4wgXYPeGzEz/xgLbtoV+aY/O2om8xyvgYBNEQZR2xApnzPy4Ww4Uci83aQJ6p2HLQ+36FSaQakv+aHDvNPiUBv9LgW9r2dGNdp1Kf6UTjMfYPeNKxmZAjNXxU5rnPX7NXtbXUWSLDqzRWrCJLiJ7lOhRRzB69mrJ1OAYrcrYGQ0ynyrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(83380400001)(41300700001)(316002)(8936002)(4326008)(66556008)(6506007)(8676002)(1076003)(66476007)(107886003)(6666004)(66946007)(6512007)(26005)(478600001)(6486002)(966005)(2616005)(86362001)(186003)(5660300002)(36756003)(7416002)(2906002)(38100700002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KS1bAXUx7LhxowDizzzj1Swi44sy8oaYvGhagSc5pcfy71KFeDPSHb5/znX?=
 =?us-ascii?Q?3ERrftJAUQVo0R0l+YL7WJI7rsUDu73FFberW1fgp9QOwJehME629oYlLh2q?=
 =?us-ascii?Q?PrXuEjeYBK+g2zmn4L0yQ5d5VT8G9F3sMsqWvn/eYkCSC0YDzyw5ckD9lurC?=
 =?us-ascii?Q?WI47sBE1k392FdKzCf9FZbJ27wrdQLik941J+WC+WkEHkce/YcTXGbJCynsx?=
 =?us-ascii?Q?z8utvrdszKRmiyUcdYXjNkNsiPu2TaHZAM97pvwwdCobfohsSEF0lk+lzPJz?=
 =?us-ascii?Q?LGj264zPrrNFO8lYLyuCBi8N1COoJY/ipphBTVGEpTnHHVFtAKoQb5w6jkLJ?=
 =?us-ascii?Q?bczT59kcwOhCTbqlgaV+nNOk7GlziHUV9HNN0i9vNVKm/ZCZhGIL4C9dSHYw?=
 =?us-ascii?Q?xy027i+K6mWgDmfdKMOWZjSZw1OdQWdjUDjriB4Gh96uS9gKd7/VLL10wi2T?=
 =?us-ascii?Q?qyQou0BVbqMD0/JSDilitZm/0MJBXVqxrsMUktWz4u779Dt6hu/PnUK32qsL?=
 =?us-ascii?Q?gr4j6vfRA1OsosVg2CJsR+/qJ9T8QVpN/VJVo5GatJJgCuPi5V74o4TG5BYy?=
 =?us-ascii?Q?L5XewbHvxezujjKqj0xvzFnfEwemoqFb9Nir610syP5PTdnfOY6iOpI7sIzT?=
 =?us-ascii?Q?7jp4sZtuxnp9TtEiRWKEfv+iiVBz42qg+uW+vennnC9MgvMvx2lL7sEDZ5Sg?=
 =?us-ascii?Q?1hpDgcaqieMppxTT68XaI9j27cr4m7di+VI36WXkdgt2tpk6M1pMDv+NWlV5?=
 =?us-ascii?Q?1/Aea20btl9U62a0c+RkOgEUCgHQTR+waFnybLArwz3A5RW6a8DLNTYEmQ0S?=
 =?us-ascii?Q?oM5aozVeH7ULRiVnExeplsgUrGD0kVYi49e21oPhQz15F+AJdo2Ac/GD7wI7?=
 =?us-ascii?Q?8EY5nbfNARkoduw74S/3ownVBiFwHBvhuMZkuOc+PhvmlCwQ9zuwmDyWojbQ?=
 =?us-ascii?Q?5VNVTGMdK4Bj/bBAjESmEWMtx7Uvs6+tvAvw7YfvvyYSpvwMPqEbdBqT/qvi?=
 =?us-ascii?Q?oh0BgnYew38i+p1SQ3DB3Gi418cX+ErfFgtfHUbjLI0/1JpP2qq+ZpOhrdtO?=
 =?us-ascii?Q?c121BTyxykyrogxa2IBG2baq5yOtN6/6t3JoKsnYo7zJbyWq43fti92eEN3/?=
 =?us-ascii?Q?6DG8Qly8Md6WXqCRzoexlRax9Hl7Km9o9CmIe3kRaXNdq/VvxS9kzIimECwX?=
 =?us-ascii?Q?xeu1wWhLbddtq4Tys3yaN4ufBLtdO7oZgME8MaWkGjztPEQo6A6omvQQxTZ0?=
 =?us-ascii?Q?z9O3c33tWTk9GnoZpc+ga1W8IoJYoO75UWfSt0ZZf8F5/JXcb0+TfCgPKqcz?=
 =?us-ascii?Q?QlBOdvHAWQnansq5aablumRLjuWugeqnU9Kwi5rNEYUUO0TMskjfP/Zn0rNl?=
 =?us-ascii?Q?m4yDq9m4+4WBrGlM9Hm47M30ulAshLDhYDMpfrnJqWlRAMGGGEqrszSGT11x?=
 =?us-ascii?Q?gr53hMaDhqzbDNKUj7tdFBW7cCxDnCRioV8lnJkG3tqWjj/MYHgQvEqLJxWA?=
 =?us-ascii?Q?3yN56mNWBpKcCq01fDsIF08By5MflhrWtUVzFyo67+NzG9eMzUdmk3oN1ATi?=
 =?us-ascii?Q?xWX0XwzaWroWQIlch5gnqaI8IcVj+8v8/ykpJ1AboC3ZcvDktLNLBpaSzcle?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9JO+3S1Fs9GLxs6V9sa7mfdH7uOG/BvBxQM14oFcoHSTcUURce8uDwJdzKX0?=
 =?us-ascii?Q?hPTa0cXfvyZqhMwSTSn4Q1polbywx2FmU6J3dDj41r0P8IFazYA2T6/IIkra?=
 =?us-ascii?Q?WqmKnGOWj7qxi93a2ogXxdiFXJOy9j5r9okLy+qkkVB5WBveVkiOoYGk/ygA?=
 =?us-ascii?Q?59LAvOTTB3YLAjW8wFijZi+1sDy2EFTQ1+HpC4jeYtcwFyJX73RhcKb88Hjj?=
 =?us-ascii?Q?BT6oRZSYVPLTnqAuygMMsJBJxSoHdZY1ZfR6eXIw9pLCshoc7N6IucWVSg7q?=
 =?us-ascii?Q?ylNs1pG8hJxtU9XLgI/pCZ/JkGqLE4Ko4KBsyQY+qtDychEwa1SupTouM4jS?=
 =?us-ascii?Q?8NHw3nzeCK7MGuKooJPvS/UMVDfwItt1ianPzXLSwj9Rq0vXqnIFb0HtQ09h?=
 =?us-ascii?Q?XwCpKFbUFzktakT4L3wlBONDbkfGylBFpDgYrVA05unCcT3bp74TokuXXw35?=
 =?us-ascii?Q?r74virgsXiLS+EXPx3X1dF2OHAtml8FDhWqpAmO8g5sAIdOfbSRJG7AuMWBe?=
 =?us-ascii?Q?n/7lsWpuRStGyTRTAP/ldJ8P/OmURUf8VLpT3znbJd3kI8eesOPjgEWQr9wa?=
 =?us-ascii?Q?wPZUNXfN8it632ZdNLNAxOICUhgOypjvHLpS+n9227xRF3BF6nTtRb/bX3rR?=
 =?us-ascii?Q?A+/Zf0iLfYTZTvOVbthWW2sY4yqJobaXUYK7u0QF5JSvTfoytql76V6SPbN/?=
 =?us-ascii?Q?cQAjRoOX/iacmc6/6VIBVRo9ayBlLwK9uvUV1ZyGg37iq+bRO62LXDCwIfNL?=
 =?us-ascii?Q?k4nGUQg8Zl87N7/M1fy//xovsMQArqSASRVet/myeJIPmeXRyyZsT0DZOFca?=
 =?us-ascii?Q?+68pQnaZsP0vyHruxgNuFEioa4celyw523hJJxpuDAQ4o3Wr+uRWoj/T8PJV?=
 =?us-ascii?Q?FoMW6krOKvqErgWOr6mm6N//1c+kVyacluI74TQnW4VJBf2yEIwkwbXynPzQ?=
 =?us-ascii?Q?/6B+zCjJPmmTxGpQUoxRjP/SKykeQT6b9zIzYs1uEMtEC3/AGfQ6WadDVE1X?=
 =?us-ascii?Q?f82heLk+JzAi4UNQ5TbKGUPuDiix18Icr59pSJlfgu9HF3bl2OeSPDlOuHCq?=
 =?us-ascii?Q?YihBKMdw5Vir8IuqTXNQRvubjHbHTYQxMsHGh8jWClmTNGep+0MUNuOGo2JD?=
 =?us-ascii?Q?33Yxug1PAZKibYT6qLPKtM4do9sCF7aZKcT6V37h8oJueE5GyYQgkfI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9671054-121e-47d9-ba49-08db03dc7827
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:45.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLwSfqF7gXMsoWfKvlNm3CIRnGOHlU14tghMISOGt+G2+6WXR1gW0Z8dDHRzD5+yzJ0n6I5AGAU7f8XPRDjbRvKLv3RzX2ENx4RKmqjkgvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310196
X-Proofpoint-ORIG-GUID: vEHEHN_Z2y9GLvEwcPNjSpSn-4LzftC3
X-Proofpoint-GUID: vEHEHN_Z2y9GLvEwcPNjSpSn-4LzftC3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   cpu and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v18: 31jan2023
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (7):
  crash: move a few code bits to setup support of crash hotplug
  crash: prototype change for crash_prepare_elf64_headers()
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/Kconfig                              |  13 +
 arch/x86/include/asm/kexec.h                  |  15 +
 arch/x86/kernel/crash.c                       | 124 ++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  53 ++-
 kernel/crash_core.c                           | 337 ++++++++++++++++++
 kernel/kexec_file.c                           | 187 +---------
 14 files changed, 595 insertions(+), 211 deletions(-)

-- 
2.31.1

