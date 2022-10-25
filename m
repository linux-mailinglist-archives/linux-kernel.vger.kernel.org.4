Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B3860D0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiJYPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiJYPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:33:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC65BB3A6;
        Tue, 25 Oct 2022 08:33:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PFTulE023414;
        Tue, 25 Oct 2022 15:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=AQKfWvYPG1fY+cprL2ygqP5adC2OINl0HM+Y8eo56MY=;
 b=BgsCqNDoCla1vsq2OtwT8WPe4xcvuT4ndaXXQmbznKsJlFxH7wGIbGUWlgEbv5Ij0KBp
 Mw6KyEuNF6MyNUy6ectU93JXKN2+4ik3K7PBUX8Y5/zVXLNMXtiwN7dA2Fru+2jibGtz
 gW1Llz68OK4stlsY2caXNR4BgNHNy/LQLRm22SbicMjIjgbXQahFdhh78d8/LluT7thj
 I63LBYIr4NSM4ugWPSAP4ePDcb/HaNOsfKIqutD/ENtSZxGdLJr9gfReZvtA7JsN303O
 44MyXi7+9heqEhjPskR7Y9MU2Sdyd4oOLYgTMl73/hZyrwdr4dJp7Kd1atUitshAZgpw Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741vbvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:33:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PEmitV039926;
        Tue, 25 Oct 2022 15:32:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yas9fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc52alK8kDJvlvq5OcgXinxoIEdTujTmQo9gnAo5t8rA135icZL1NhCUiU7viSTocwGAgU8Gyr0q9ljX1omPaT/1WRQVwOdRSmLw8wwHcu7RNjUfuC1r7lK3/uBJfrfrcB+Cn5etYxybSnef0VdFCSCZmYa2LvIExYjGNriJ3yEKxd5rk9EYkORtDCS8SZ4idUdLUa7ifZIUxsWnPJMF/+VNfHc3+N6Xa28Cw7Lrdoen4I90cKNx/og9YDXTh2A9kKoYIUdMhcqkGVE2VJYe0DataRH2y5nxKdnU1qrxurHfuoXyUXujN8IPH7IpUA5QkYjvphamDRpEqH2imfi3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQKfWvYPG1fY+cprL2ygqP5adC2OINl0HM+Y8eo56MY=;
 b=aqqswRCV4JxGOjhZAbaw7G7brLkPGEp1KS4nRYqu3PdC3GfBkUIRVGWUF6oOhTGnAbxuMv6EQlYWwMqCexM0a5Vdob0Ahsg3SoHUL26zhj6vxjHnBK9xF6+msiAFb6gl7OSNWu/u2xuuag5cIPtgs33Nib0JcJmPf8FQUOhUseTJ7yltgcUj+/THJBrh8pJZ859RKThEqLm7O4wrXSb7YGyoUC6VmcCI5XOX4n4tE2V/h8nwBFc5p1YB0om/vV0BHGiF157I5xHyvHLiLmSNeLX7S5kw1aOP0gImUVw6EAdL5R0VLxwudF0tAaZjVK9/sZyhkc3yn/w3UkxGxvXSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQKfWvYPG1fY+cprL2ygqP5adC2OINl0HM+Y8eo56MY=;
 b=M3uOizinxyXbeAYUyb59+0GlCY7IPqtqi5Pvx+GPQoRKTfRx8fmAvNkqjh0YsTD+w5dSnD/Q4O8q5NpwNndcv+xBCFaDk7JTUbduPAdB8hvREBb7TZMRQM0TxIJ7YxFFUQIDNF+vokAJdKEvhULbDWklXz9K7t8Cioy+tGu8kw8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB4837.namprd10.prod.outlook.com
 (2603:10b6:408:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 15:32:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 15:32:56 +0000
Date:   Tue, 25 Oct 2022 18:32:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/retpoline: Fix crash printing warning
Message-ID: <Y1gBoUZrRK5N/lCB@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 567bff20-68a8-49b3-d987-08dab69e30c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5r/yo0m49mlD6CGk6lZ8JyMO7A8h7B0yNGsyDm2p2Gu2yL69zp2mDh7RBT2hzHTy0Dq3GoRk17nCz0OktkX1ojJTLh7NIjRt70rR1/hXkSPpdUqBGQpkabsOshxTh1giKh3N52N+o2/KyC9Fb7BGptFN0+Roi0jEaXfdSYryTrfK/85FWeKWNEnClC2uJkn6qTUKmTvTslv3+Az3ofWe1RduaHsYRN/tvc89lUS/bs7heEJQZ3PQ0WEVNiUNNetHSGYyWIv9IZ14E38jog/3jZCiztalp+AYzTMP4//tnvvLXYEbVQ/FL9UrxQcSu+SpaAGUBFoogvXKWW9hNMITJceeZyBf95PmLOySC14o76Yja0I3cAgUjhu59FZIeMpdiNABce4V6fPpCRuJ/CMEJ64aPSPhiCQ33GIw3gWgTEwQfMatBozqNRiU092hkQj+MzHGuFncmX3GVgOc9e2sRNrmxBf0z52U9La5sVeobuf2Uhv+AyqtF6fS8EVNQuSyOr9n3N6Ke0xU7+/96uoxnzZrD0RmNa1zW7GTgJSthZPef91lm1TnkvmHYeALM8HeDbzaSGXp37fUxPge8D/ROhwLiRxU3mQUTqavm2l3tuM39Se6g+DhuyAf7Zo04dHr7oNieNpXwnIBQDWGsOycs3pBpmlxSrnt6A84ZdgzLYRt7TyPYgpzWyGOgSjkHjKKzUBma28KbtTcQHHJ70JuBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(6486002)(478600001)(33716001)(110136005)(6512007)(9686003)(316002)(83380400001)(86362001)(38100700002)(54906003)(6506007)(66946007)(66556008)(4326008)(8676002)(6666004)(186003)(4744005)(41300700001)(66476007)(26005)(7416002)(2906002)(44832011)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkuvVOB57Olcqewz/1n+QIp/15NwbZDfpEZtHh1SnyK7BaEx9koxLtlW7lf2?=
 =?us-ascii?Q?2AksKN1uRd2I0fhjcukpn1yl9fPIpFDKXS35dMGjlPblbfTacRdyNbYilM3e?=
 =?us-ascii?Q?UA7FZepuMYHbP5eqEXMzmTyBtLyZu5f7u/bRzCpoWB4sdk5wWMSwVBIr0Ziw?=
 =?us-ascii?Q?EkeZg645LzpYKjDeOe2RGy7yRv3R3f6/EzwuQfc0dJiOEJ0IpQV6yqiPszhw?=
 =?us-ascii?Q?uRpyXRqmhL1TsNEJA3/so7sA/ET2TN4GkC9/zpccc2S35HnUnH9DQf5ErUez?=
 =?us-ascii?Q?T5y+LYsvz8UxapwsorZBgkYZY6RyRNDRl2jpf5zNHixuennsD9zwWfbx8Q7m?=
 =?us-ascii?Q?sHLU0BmnGNd0rTwaZG7bpb/klx5vc2YYIY5X7n/BTAKeJ1Sbnwdk4nV4s9HP?=
 =?us-ascii?Q?gV6czd83ffiQ1o95VU8oEjjONL18yD/8wOUccTdcx4cvE1hslOcU0eAzmcOf?=
 =?us-ascii?Q?M5EnHm9sQ+OdAugpUNUj0H2G32y1mo/z4uDPp2PzndDG6JMhJThPW/HJ4tdC?=
 =?us-ascii?Q?K8Rn69fyxmEtYccbDynPXJvXnDD2Pu3mLz6SiQUaS0ZwoWaRXyf0BvSypbaq?=
 =?us-ascii?Q?qOsO+ZUhSvhqWBaGUyfVEEfaSyluoFrOY+0HMa1Wy6bmWtKmq6VPhXIl6rP1?=
 =?us-ascii?Q?CLfy2iG0l3cdm0GI7lkEMV9ojF+B6rkakjcgnB55qyRgq/4cCuNwFwl08KXy?=
 =?us-ascii?Q?/mA1sql8AXPxBggI67ReKp7nLe7fenYm4/HWpYG9sgqKNwA4VYlkWH9ceiW6?=
 =?us-ascii?Q?pSZvbwvfpmuFRzjB76NdUDyTTxNnAAIBx54lfF2fS3EicZT8+RsMRnYkvNUk?=
 =?us-ascii?Q?CfFgO1tsYiUSoSDZTJ9XvaBXP2yz24dSck9PDzyB5WvOyvYfb6myLer04a97?=
 =?us-ascii?Q?OJz5h36aWgXSNURlb2hCI2BimVdtd0P/KDRHgNOPf3IEcKErwkzqRJj/sqei?=
 =?us-ascii?Q?g6Wq8mbwHcagxX39bMoXsJ/GrAX3bk7hcbAx+GNAEy+XJFWFmksf5KrfKtyc?=
 =?us-ascii?Q?KiLe/uxk+w1CW+gbxELCZiWJQLRMufV8XzoWw1WJ1ZK2ntpLgQ6gqGwfSwSh?=
 =?us-ascii?Q?VQDxbv4DnxG10tU6Fm285qQNLWQYmNjFUo3gLzpR//xDyppLS6s4oODLREKc?=
 =?us-ascii?Q?zA9lWv1P84oY4qLzDd791SjunR67aZ6bWaH7+k5gaMUQ/uHlHtH/Z7Cekgwq?=
 =?us-ascii?Q?RZoPk6AGX5YebA5uow6p0d9Y9GVDSeJ/27CnTXfP/mvGwDMxVX05JI73w6Zx?=
 =?us-ascii?Q?wOKTWQrvNDwcaZtXtoX3FT5khohLq4UGQdgBhXFx4eQ7c4RnlyV7J6RVuZJX?=
 =?us-ascii?Q?hHe0WfKFn3vSHC1nytAD8mYTHmKbrmyO6IXphQeEpqEjLhtelzOFnnsLD2NQ?=
 =?us-ascii?Q?zj/ogujSzjr+PdIlCC/k4ZmkuBu5sk90YwRUTN25dqaxwRvSmiKCVGURw/gO?=
 =?us-ascii?Q?VO/yjwk4ZNxNELPiRf4aCWUU1Q4AO92N9WS+r4ltAMJ+rfckaDNBwd2tOHAw?=
 =?us-ascii?Q?Ihar2Co0dvO8YS4vgYCLg6xIRYqL+0Yx5DZaIPRzQd+7ZKMiPmQziIlcU2q2?=
 =?us-ascii?Q?KPfIiJEImUYhGBt27kNnov470mOjl3lXMYdPDOj0/SC6H7JEUXjmYg+1WTEy?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567bff20-68a8-49b3-d987-08dab69e30c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 15:32:56.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZNi+mxkZ0Swpuq2FP/Tbfl0IAJwd3otnaQxhyTImUv9SBFfUO+FzfOCmbWl58CRlBwHXZ1lOe2IHAbVGa2F/6RUDaRftZRWon0I26BOmVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250089
X-Proofpoint-GUID: XpKdkFnYnVZTLZhFrbPHhrYPIonTcBiz
X-Proofpoint-ORIG-GUID: XpKdkFnYnVZTLZhFrbPHhrYPIonTcBiz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first argument of WARN() is a condition, so this will use "addr"
as the format string and possibly crash.

Fixes: 3b6c1747da48 ("x86/retpoline: Add SKL retthunk retpolines")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 19221d77dc27..b4ac4e58c010 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -418,7 +418,7 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
 		break;
 
 	default:
-		WARN("%pS %px %*ph\n", addr, addr, 6, addr);
+		WARN(1, "%pS %px %*ph\n", addr, addr, 6, addr);
 		return -1;
 	}
 
-- 
2.35.1

