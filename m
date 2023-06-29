Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19FB741DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjF2CCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjF2CCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:02:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F607132;
        Wed, 28 Jun 2023 19:02:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1qv6e011062;
        Thu, 29 Jun 2023 02:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jpDE7j7pilxY76JYIN4qCae3gDnlVece4K64qrJOirw=;
 b=uWjcAhjffjjj91prUaC7pLhyHgZaEaVJT9QjmweGpk0gRaGX+7N7YyN5ybcjfaV77E3p
 2e/GP1xXRsy5v2Ekh7cAY97Iy5K0zor+tqh+PXxjskoE09lnJ0Z/rpWjMP3wQ4l6rJaQ
 S9yyG4MjmUlJ15Sua9zhXarqYj5vDp6IYsRrruSYtSwqFdin4ZsIRPGDrzM+Vbf4WFY2
 bJei1k4J/eabiUIR9WUM6/q7jw5zA+YIq5viH6J3u5+CyA3KTvFZ3iM2lfdSOOTABn03
 6ojROpBD45tEndqPNC6S5zWZkLp/7dDCCnYseuYAOwgMja98Nrvjw33Qn8zMFxluL7Ik GQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtt17h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:01:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SNPbxR013249;
        Thu, 29 Jun 2023 02:01:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx727pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmxd3iG/O6V/jXYz7xgHQuIdCbTDQmahlwVDN7Yo/BI2BoSa4TZaOX6gCIl/QMU1SnvPqyIr6cD+BTw8rxsXuyaYMfkV8eg2jPdFX2raL9nCljfc0ltSHWb2CknV5KvMaR1PGAvee5RYrAplHiBcN2zu7l7XpYM/1x7Qu8oMWMKfIcgzm9buTDWQhS5w0cHvRfe9vrAHaRs3Svp/Yx12gbXtTogpz93DdqAiuYBxZ9Rs+GP5iGIkVpfbGk/6+sGmViBkCYHSypgfiR5t28HYMAC8pKJ01Jgy6RCW9E7NqdZiivVg5nGJ63uIKKQR0hkwIeJNYZ8DPsyW+B6PdHha6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpDE7j7pilxY76JYIN4qCae3gDnlVece4K64qrJOirw=;
 b=g2+4PPR7m2i57SVmfcKyHW7lPqYIU8g8dUYabAgjZBk0gP/7NEtLat2ewLnBVNB75V3xlhkUj+guTxLcUn9r4ZcbW3fRMAe0TMTVMQX9iMokJduLNVV0MVh8S1UBiltTJdUAYBHFDfn//DZB4j8yqKnhVcV8fY6A1pfpwzzMOCLxqJO/0jGGsFyX1lKRAPJ+XKYS1ZdX7bQ6Yzxf4IsDQVnWJ7i5hbAshUhOOF7/lwgn/JCXxmcdToFft0bdABKWZJV+C3dlAKIM+SJFZZUoxshI/NfRb3xQDngtbbj9XNHnOSocBz32g5m4op9Qy0P2BgJqDexP/BXpRVnKbYsntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpDE7j7pilxY76JYIN4qCae3gDnlVece4K64qrJOirw=;
 b=XC2TSvZ8zhey8i6mNHAZGWwBCnyBaRDSw8rG2TOCF4DVG0RY52LIRtkfPc9bim/YlDXEMLuViGMNHUjFTPaHYOu4BP7eiJ6+A1+KrnxpqqRruwwNwsR5anZDlGttOGXNAea2LVoTEdPr+7hPQIRd0AVKuUkCo8uTFDAl0Jro6mM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5736.namprd10.prod.outlook.com (2603:10b6:806:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 02:01:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:01:54 +0000
To:     Rong Tao <rtoax@foxmail.com>
Cc:     martin.petersen@oracle.com, corbet@lwn.net, rongtao@cestc.cn,
        linux-scsi@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        target-devel@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3] docs: target: Remove useless tcm_mod_builder.py
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1k3ni0s.fsf@ca-mkp.ca.oracle.com>
References: <tencent_58D7935159C421036421B42CD04B0A959207@qq.com>
Date:   Wed, 28 Jun 2023 22:01:52 -0400
In-Reply-To: <tencent_58D7935159C421036421B42CD04B0A959207@qq.com> (Rong Tao's
        message of "Mon, 26 Jun 2023 08:51:47 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e86edf7-64ee-4071-a483-08db7844cff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziMc1APU6A+fPvJoG5+d/liydrOqmeJagQTwtKXQaBswUpKYwkjyshq5u79b6J8HTqjr+poyyswSgvsro9s7qhDEXDQWMzcoIMa56X4Ylop5oYWwch3s3VprV8M5RgP5nckpXy2IQjGBAWrZiw/4TnG3ODkIeH3qx5VSQylWgqwsAWC16s3HUiqEgQveu38TZpwt14Do4eaJ9hIrAptf9vTz1n/kFc516bt6xuRMTILxeCT+tn2v96uwir9mVa/JuaY2vG/xro0h82kDeaGoUsw1kzqF9zPDm8epM0imu9F4n1o+dxTlJsn0bcZPyBCeXSTbsAW1DdVubRMZK1gyT6DTLDryCj4e9yiJxLC8A325Thm/4oalZVCXiVADi3kNCJYN6avODomXrW43OLlfhk02z5d6Yyha0lqHQUKLGDSwDd8G+RV3fFo7Y4xh8MIW5Kcb115HDpgtNySZQyiXmHMq59sW1N9K2V3F1TcDGrkBs6wsDVRJAq+GYVaLQhPwrcKa2JCiTNDsKuBz6m+mWUzN9/V503JumZvWblFBJRPZ8ZzWDNr6/BqTfC9Tvqmr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(66476007)(8676002)(41300700001)(66556008)(316002)(8936002)(66946007)(6506007)(6916009)(26005)(186003)(6512007)(478600001)(36916002)(6486002)(2906002)(5660300002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hWuEC784BUxhlgk3wTCOBpP6nEdzf4WpExu0ElaDCrcvaoX7N90qEyZRuR3w?=
 =?us-ascii?Q?gwHa+aiQ1Uyf6Xi9+RJ6cDxJaKy8EaCnag4NTltD5Ux5j0V7iYDblu+ovIrR?=
 =?us-ascii?Q?I9dPD0ElMIQDWXhW81e7Lyz72Sy7P6qi6XmHMvVw5XPUg3WZFwsjowL6tkq9?=
 =?us-ascii?Q?u24PJypyykSLzYTQp64TIekD4/ff572y/qohvsR9hlucFQvo8meBnXv8gyvr?=
 =?us-ascii?Q?fNoQPTq7LBGplh5EaX6vqQsroPCHcv1NMh0D6ZyQxS7pZNiPSqNw9KVaxF7q?=
 =?us-ascii?Q?ykQBA/tZ3rls1pszDh54B6/nRlwZ+Aj91n30HJ67HDr++347w5knlnZtx7Uo?=
 =?us-ascii?Q?XyKbjHwWVPT1tNytVOlN15Z+nktKQChC9Ug8XXX6MOTCeKnwvHJ8XO4eCoCw?=
 =?us-ascii?Q?eSINJcbEMzb6AINRzJ264BFCqmRVa5x2I72a5BM6pFzQL/Xwphf8POeFCTeB?=
 =?us-ascii?Q?v4eMKHrAjxornIyIfbA5ykWjqrQG2M66PnrQ6amT2U2nhse8RbNASp1uoKeF?=
 =?us-ascii?Q?V1CDlYN6cIDLQEcoOGcjDt87JY5EOPQFXIavWVumtyrZq2Z0oLeHP1/Xojjb?=
 =?us-ascii?Q?5EWTJ5JokucYtyaiXX+lDTlVrjw+ixhQctia79IAyFyEWCv974yxiNHLmAUt?=
 =?us-ascii?Q?W+ODb16rC/0pn9+slJqDxVWIgbu9T+1Lic6cblXHa/8zTWu0CyicLDu5aHDJ?=
 =?us-ascii?Q?/WZBYyUftkj0fHsLDMLly0U7aHczHyvCoPoss6wufzCpPv4rdp0O576q6QyU?=
 =?us-ascii?Q?xGzPrdPAX5I/4o08Q3iF4qtVQVYzzENwbWV2L+at4m3/Od9DOmYloYkb8vxx?=
 =?us-ascii?Q?RAmV7VMMs/Q5dbaQQoSGVoQyih2hk8hEF36LGl1H8OrFmskCRhdW+9G7ORJD?=
 =?us-ascii?Q?+oVKb3PPL71dQUxN4mSoTqmsu8tQeviYXLwZxDFdKwhZOnJ5iF+ftLhKlGLn?=
 =?us-ascii?Q?NRLls8nq/j3kN/Fh6st8UUp0/VrqmM1n6ZiZbB7TeB5DzBloC11yktVl2Lta?=
 =?us-ascii?Q?s+Wx2jjUZKhP7fcG7Ko8K17TFehjvD2+9J/VTM2oUSiP/Gq8Vlu12tHZZXQl?=
 =?us-ascii?Q?L/1itihtd5+KT5CWOmJDsgZ0XilKOZB5iFrINxRJ6JhRq6eS+YtLlJCJhuSn?=
 =?us-ascii?Q?OD4kec1GdGUeE2B251tCRjTGnpy+9VQrJeCWpKojTUjPmhmuFHpt+OYMsaU3?=
 =?us-ascii?Q?bPT9DNkgtQGXa3aA6qkJOKW8MBlJPeNUdJPdeKbwtcxuGOjOv5nk3aykVFI3?=
 =?us-ascii?Q?OT+3NXAp+fMLhhV17X4M1MkIxSP8CHoHYE+w4PAwzj3nKBhjM/L20QvO4RBx?=
 =?us-ascii?Q?oTQWCibnZhovWFO+44lSmbDUjljM1cT0VxkJhe9wGRRRCP1l47aQY6kmJY7k?=
 =?us-ascii?Q?4PkT+kNIO5SBkJdIM/JpvdSfoq+RPPSViVpgojYvPDBCbmLQnIRu/TGOVnYb?=
 =?us-ascii?Q?u9CaZR9JH4INeEROqCWt5p8dKvBOMw59e/iO+jh2GOqfqXc6mlHv2hb+7+Ii?=
 =?us-ascii?Q?lYUUWJQ6AFbfGxhFleAGpgSlgjEwTuRZUxPvdVjXS1BFDhbpxgq+AsDvs4VE?=
 =?us-ascii?Q?kPGl1pNGvMhYiH2U/sg3wwZhhqSDyZPGlre9SwlWt8lD5s7KmI6lJtCI95zv?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+CezlmgP/UCvHz5U1lO8Cgi0Z0w8Oh9N0knjG6Fy/8cIh986v1KFht+LDJUDmXUBSbazGaZ8N9yWdqdt89h2bn1aW3AU/kBzsJ5wqpHpdlkHWnFMoBBiNY0wSaGNgkdo1haM8XDCQyZMX8/WZRmkDK/q/EAp2eiolm7lp6QjD3tXMPvXT2pwn0fhHflUw+2ek4HzQ9QCLJSTMjFkDwCpGJAM7/FmauUw4+X81713d4ucPqMI1IqAcFwj6ECnAjyN1bA13s4k1qb4eEEheGiMHwCjGxTcnm1IrXE1st0aBo9bIiKkbxnrS03iSOQJ7jVpQh+ewnuDLRBH2UAB7CZSwaxU/JWS53Ypfnzbr9TLBERx/QhlOewsUllvtZmkGa7U6TS4GIjYBtQLav3EO99tCPBTHG1SYz1RpIHp98lMFu685+Ivwi3YP2sEXkblUSP10T3EuBUHvS7jxrKj7qIBsxMiWHIrk4Cn0ddQ90hOtdhDA0IZSZT8CN1Ul37LsHv/07zXD2J+jEiVdXZ7kVXYAAsquligHp79Cepk41z7IwUEE5ivedWKwcl5GombPeWAxpOzwBFfdOhf3tfL7djcNcCM63mH/r1excm/U5jRZMF2jwu4kM6HDhfMc9GlkhSRvNRIi+WkyVr0dAZZNq0Y9cchhdyqKjsDEOXLl/A/yEgopxFL72hJ4BQ+EdxQINbIeAd+oVGtEYSRaxi2taXy3QEVIY//TrJo6qfIgMZO432XHRfswKeWWEg64L/MsGwJ3Gz6fPtc9ENGKQELGhTh7Qq2Ngcvw+7e8NW8eFxqHCnP3emOpuH2XxtIYxLUO0+Igx7ldjLQptBQLP5UEZndw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e86edf7-64ee-4071-a483-08db7844cff8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 02:01:54.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5r3h3cu8B+iwJprzexpKV5dHxCzbo5yEgpJEQQvdjhaKnjUy+melgpvM5RnR6++hE+e4/F1R5sJA1y0k/YE7rR4KANXw9Bnj+cuOz2HU1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=618
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290017
X-Proofpoint-GUID: vlTWXUi9VfhKVMcdCrgJopCN--Euslxi
X-Proofpoint-ORIG-GUID: vlTWXUi9VfhKVMcdCrgJopCN--Euslxi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rong,

> This script is not used and requires additional development to sync
> with the SCSI target code.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
