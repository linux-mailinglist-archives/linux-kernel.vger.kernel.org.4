Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E826EE3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjDYOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjDYOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:11:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDA1544A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:10:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi75n024299;
        Tue, 25 Apr 2023 14:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dQI17GQLfY51LpW9gZrstzngT29+VqpfaYKOYKfoYG0=;
 b=GsffDF5u733uUYrMFmn3waLnCoCz8dyoQQXj7n6ye8aAG2wQg59NhiIPZ7aPDOV8NMqK
 8VJ4TUXGwcA6Rl55OaG6eNZhXXLq7wcsHLW6OTsTKQod+3K3qtiXTwVRldtcDK/tL76B
 r9zZOIQkVrIAJ9Pc/No5pQp9BSQ0HsbD50ZYT1JznHIACWJqElxGL7FyRh443zzVwkVU
 OV1eD1NguDPpr0uRPodTLretbg+vR/uWupS2kOyIk6lqXbq7D2rSqHT3sn35UlfB4Tgx
 3hQh75fXnnUfVQXDsB7nxEGflAZhjf/2k0ODpGTf/fJtSDlmdmYx6VpSy75sL9B1aN11 UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46c45fv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDUQRA007393;
        Tue, 25 Apr 2023 14:10:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4616gd94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHAOZlWqu1Ahfdh6eUUHYod0dVUHa+zCPyjG+k448PZvur5t6OSdjDlREo+V7oQQN+0UQppauruqVQ8HmshLM2k9WIfXGepQVHu/QndDMs4vQgc6dI3rTQnA5vXZphH9Xa9pCGEVIlOLw1YWkYhZP4MLT4s6A8f3hiky+Zbiq96+vdWuXwNXg4QbeR31RhtIyYylVgNXyS5mLO6XFiIj9/CHgOV+2xwi2fVg0FPk17A6fTz0CcSb10RX8Px8YUR9ighiT3zXNAdtWWj7huCloVK0XELDneLX32smk3qP4mD53U6bdvJ2zII2sD8mnwPWr3dPQ1S1qvHNLumybs7etQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQI17GQLfY51LpW9gZrstzngT29+VqpfaYKOYKfoYG0=;
 b=UUJROVqsq47FodhDrAjxyp5sfocOz2HWFMNKbAEqF+rSvjs1VuQ5MnzgP/Cn03mGUcrGr/qxiKzi5H1kucJGph+7TaBk6UKs1sXTc6pe6zBPkKkftf5auWZKSobLOs9fzUFZP180Ieynq8+H8+Qx1Ygzt3AnJps7Qhg+JB0t5V85taCNXGj9PKucNKhEy8jsdE2kkDibrodUNEutrHjLF/68Hi0AbGbwB9etQSDRPhDB1+tBQi64SYi4WsaITjf6/0EhYi/BWeNssC2Jem5GhPVvcs1Bsxr/JkbRK+uRb2dtvy/8ucqchvgN34RCqaJ82oRjJ7H0LLOwjLAtNYGR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQI17GQLfY51LpW9gZrstzngT29+VqpfaYKOYKfoYG0=;
 b=fYilZPNWdCCSdvnbopIwggdXRNiJH0TL5rgY7Jp2NpqJRzOTKWTSlfT6Y9B4HiNRRRHwbrFBtmLGWbWTNYs9y0RtekIXfQD6x9Mj7TrTEzBGT3KEAQLAsR/n2p/TqSrh3+Mb0y7mQh3pbl0J9uHq/H9fmz4e2RYXbFnzrBl7M30=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:10:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:10:47 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 12/34] maple_tree: Use MAS_BUG_ON() from mas_topiary_range()
Date:   Tue, 25 Apr 2023 10:09:33 -0400
Message-Id: <20230425140955.3834476-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ce01c4b1-cc41-4e06-4efe-08db4596ddb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JjAe/a36ofjjEJ6UBXCShY+5zFfZdmJf3S1Kz75m8C6IN06UHVJ0DBEMzFDkIoxH06mbsbu9t3fKyshHumrMoaLywv+6qvrpsVLd+/baYc2N5G7ZUlB0VHpjEiMYNaKkhM03OoAi3Qy/o52o2k8yabopMEUZwoXV7NY+CTiG/GKCOX2TvRkgyQz7PvqID9kBoWJoJ6Pu1/uHNImvCLvxiz4XydWpLAaqF0Wd3ZJLgwrwlTegI0WuvDp1uD4HNOcoXuwgH8TvxIoRybjTQdeHOdgQa3Uxcy/nUTbRym/ampkEMAYABJTCxi+yce0/jWFrwpPnWxb33eQF65QWmKYOpMfhHY2yEEy1gNLp0DZBoONOJuE1jUtBoJ99ZeiDC4uxO2xj7cIWrX5OQ6DyXmd+KiP15HcgqYLrWSUUF60zznhOKvuAx/Tl640a9RYLB3UnlhN1gE+XnlYB0/utZQfO/Usmf+FzGKbZpjJ36vK00J7Jy0OeMPB6r3ojVdSsCgslGK2VohQJbCqWMx5UgJzf2x0TOnzXm8eBauYs7e8c1wq7MF+sHcCVqJz4v2Ajfxu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(4744005)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbXAWEvXKBa022r1UZuprTP+Acwr8qBtCNQRvxgzT4C1EPNX+AEeZnEKOY1L?=
 =?us-ascii?Q?6G9aKWAQS77dvo835yR34Ic+sXn1ZiMEAat0WX3U7WPTxDSBHmlRmjxh01yr?=
 =?us-ascii?Q?UchvVpGUVkvJplJ6QrsKB6I3Si3uC4ZtdzHxy6TMQM5T9NtE87I65J7Nj7VC?=
 =?us-ascii?Q?HAOLX5JRooF85hatom9MUJnRZ4VHJnwzKJKtVEUwU6OF6q7lgzeEAVz9cMEa?=
 =?us-ascii?Q?n1julFNRZycVr91WHUBH6+URAT32OH8PpYcFoYjwwIcxDdAZdImtxkiobdiW?=
 =?us-ascii?Q?6xw/c9QKY2o3Lu1wnKEVOeg9CKPG6hpm7dG0NfX5W/0YirA7kL5loNKe+uyR?=
 =?us-ascii?Q?rE8zx/HGJp0BSmdsZpVluT+ccQ9/qmutD45kdewoUleWNH+eLW6rojhnA/vx?=
 =?us-ascii?Q?p4spZlFVoQTwJNtErNd2qa7krss9X81E68/wZZFTzODaHo+MtWSaWLuZUZA5?=
 =?us-ascii?Q?2m9d7123yPryvcie0dZbA5SUBSQRdy3bIs/uKRD19PgdsDC9x2biuoSbZAsi?=
 =?us-ascii?Q?5/pona2rLSGzcSCwHIxh9/tDOO7xBlY46baMg9x3oI8/28+BL/bj2oJvb+Ih?=
 =?us-ascii?Q?/sSCRvWxi0Cs3eldp1f0gMC0lWwmIBSBidguHolaZ1/3vUxt6bAXnqQoaOD+?=
 =?us-ascii?Q?6kF8lngxs4jllZyjbSwzKKNeHCJP7lZDHEwEmTLFw5PHc2i/41F1LtDiEN8N?=
 =?us-ascii?Q?AC4dGzcujzBC9bCqg8LJsMTSQEep/PnfSwbujWP+QIo5RbdWn9lfNxmxOvDp?=
 =?us-ascii?Q?hzBHFv9w5MB4CMEjNruXdt/+HcIccMwrHm7rC8bdVeevv5JiwiJcb+ia1rpY?=
 =?us-ascii?Q?cjHceciegRQ7O9LLTVYfwX0TfbNVDjwpF5PMBxLvvfIqGm2qKc9nnahs46Nt?=
 =?us-ascii?Q?4h13frQc3u39x0gehpXLH4SE+lKOOH8vcA0EdPMwWGQ+ERo56KuYzgmlSF28?=
 =?us-ascii?Q?r6A/H50GQR3lHvZ3ay6ARfixUvW7asE8BPUQLKPLkWZ8qXIhLztlVegXtbrW?=
 =?us-ascii?Q?0hHOJlZnZldZuEH4cIBYzv6zsIJZTb4hMfoFXiDJnJ4lOVdD5W6QT3E0hqIx?=
 =?us-ascii?Q?L06SBE4LWSF+ak7n2ZPftJbRtRnHR2vEmVspTT5FGJtHBvD7eWavP2ZuuDGe?=
 =?us-ascii?Q?Q/1OD4mVWBHDkeZ64bEsxO12dxI1KVB2ADS6xvvY4PSOAAY+fvj790nlaFor?=
 =?us-ascii?Q?bQ69ldzN5112JofvoaO17Kr296JYZ1A9lMpKP3VGZxyBSx8rzYNAmH+EfHx4?=
 =?us-ascii?Q?rQ3EFMr9OVCBo5bSjoM/OYAJqWSLp74/WJKlNwtbOQu/8Zd6BFVU5V8e3n6n?=
 =?us-ascii?Q?cmNXlWA7at785U+14QBYtr4Uq8nzBe7hRClTES93sVFuC8vDmnT7CWRs46Lp?=
 =?us-ascii?Q?jJSPXk5Vb4arE//IFdQx0nW7nQEBUhb67FsU6kSVoEsvnf/QViKoemUuthhp?=
 =?us-ascii?Q?sV8r7HZ0oiLGAy0yZVIxeF+HBjAlvBhVAP/bjCEjDOgEme+STNVaq2zzdaBP?=
 =?us-ascii?Q?1GKTWu1bS3TdyczhHlAN1NIBRpvKWQTFfhJbh+1hE06bLMCfozl3aIss7Nld?=
 =?us-ascii?Q?bPmOm3jCq0o/iu2JwyomM10S+mF/hy0ovJnnrWondOob4l3FsPGunk+7NWEm?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +IaQsyDUazjxhAPupK/sTBxWv2/oCiLPfQhpb+YKatAjuyUdaWSuPYlTOXmb14GBX86hOtfSi1YpC10NKp//1cMq2EJKxDP2HOHi9fNxkOQ2SfptEfknDhj71kAPGmV5rRbwT8cR5SdW64OpOWpHKuyspC1M9qD7UWQdACA9q+f2Sm1uuG+MB8BV5NR9Ypd4rYkA1DCmCgvyDA0/i2JJwHsKV+YRJD9YCyQsGEd6ruIBPRVT16CxirPKG931l6NHZ079NpxexrHv5PgCxLpBuxBJuhtk28ek2SsztiUaf6mxm7mbAcPt/gPygR+wXwegBQmYwIOQYYa1L4tffn2c5Yi33qaXsQlBD93Rx1rNOgC5w9Ad+7lveFCbiRydT/8/DqL1BWRPWUT3EX4UKr4crZyf0ndbxMCrZj7qmy/wkNUc/bod3nVGeGUM/0WgjbyR1fwxZP8E302DQpE0wCsueF/HMAwKFVoxnsRcLvwQfZB6b02Zk3dCpKFSvRuw4AFI0S/zjx4jczF4CNRMel8xB3ki+ltqgCN0V08McqmdNfQ4lqJKIkSN3Kl9dFLoCn1N5KUXDOMHaL9/bDgPTdaMagR488jBfUUbGZSS14IfpMqAesjVB8QqQ1aWY4EZh9ekU2VDV6mpDI2GuVrJBGURiNMFZKlW3M77uY0maSkJFvT39tzSW0/5FUWuqNs+1p00zhyix99733S3bP7CPb2H8d8geu4LkGpSRJ1rhKbzOuiEtuZwdPs67hqmXag4j0ZAEGQhJrsxnL2+po14oCIZZjTHlDMlU+pGs8cTD8fPLBWYQPignwQTOS5o21ac72qwiCmG7PPAszCGiSojMzK2s3hk88x3mBw1nNp/lSYCxFoDp4S6OV5w+KAsreZguLtn6SUTzfaaYdgEm3acz118eQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce01c4b1-cc41-4e06-4efe-08db4596ddb7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:10:47.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyETaNh/Cszjiul96GjpYntb4vVfjtYnX1I2t6bXRYj9xoqEcfe30iHUWufMIxsQGfGmEfEjAOkkoHn380MkVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: Pa0eAAczEWgPjK72jytBzlBsdpgjZomV
X-Proofpoint-ORIG-GUID: Pa0eAAczEWgPjK72jytBzlBsdpgjZomV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the even of trying to remove data from a leaf node by use of
mas_topiary_range(), log the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f1ce3852712db..b8b8e5d9ed7e5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2346,7 +2346,8 @@ static inline void mas_topiary_range(struct ma_state *mas,
 	void __rcu **slots;
 	unsigned char offset;
 
-	MT_BUG_ON(mas->tree, mte_is_leaf(mas->node));
+	MAS_BUG_ON(mas, mte_is_leaf(mas->node));
+
 	slots = ma_slots(mas_mn(mas), mte_node_type(mas->node));
 	for (offset = start; offset <= end; offset++) {
 		struct maple_enode *enode = mas_slot_locked(mas, slots, offset);
-- 
2.39.2

