Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEEF69AD88
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBQOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBQOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:12:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2D6C031;
        Fri, 17 Feb 2023 06:11:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hqBZ003551;
        Fri, 17 Feb 2023 14:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EUkt+uREkBEJIj2nVJ6yFTWxghXUw9giR6sYjv6Azmo=;
 b=zG1tcaCjXlEjWEa2tnqSNdaS1HPzY9y8C5o7QlhHnZ3p3ksRYQxo2VlU5oefHzn1xf/r
 dIL7jX0c/pChcTQWTgYZDfJykiPQ5WBD9Mwtbb2QHmQZO8u1kkJ4VJ3xBH6yTPaU4q8l
 zANmaSy2cDGhtr/+u/pICxFh16nluvtm0lAYAKVtXZxy1puY7juyutRE5qhpKgM2Q8xd
 tkPzIFkBM7JznOdqAJbqpGv5+8de7IRUZuf/Xb70gpuzOdiFfMoYgnV7CcYCd8/LI6Cl
 ScCnZXfpYsu411j4wEdHDPBEUf9zXa7tQTcUvzScruiBSsqzcVv4W/Qns8yVkJ1ozwfe Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np3ju5y9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HC5wNB019937;
        Fri, 17 Feb 2023 14:11:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fapn1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkAiejS7HqRKrBYCb/Fj3O3OVNZBd75ObYEnxJEzxuVdFw+wSLwYuBPQJ/LbvF/R7xbEWhEvbxWgFtZ5MHx5crXewMSKNONAo42GJTQELM7u2Y7lwDXHr4KiZKaDhE+e1KQ+IKtH/eM+XVWYh2hY2QFEKYyPsGusx/2+mWpLsHznCeg10Qj1PTb11of+8VNXwrLtayK3y3mhjZdFVMuB/B1VY84KGxutxBzXx46A/llBHWk2qWFJuKnIOxEcVIVymAjxpx/iqeHkOOEhD6vr83EQnKIQfsHt4q3AxoJoE0isU0LmG5FHX3Wv22gn12ja/komc+W8VdgnJv4kasiaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUkt+uREkBEJIj2nVJ6yFTWxghXUw9giR6sYjv6Azmo=;
 b=RglvJLDH98L3r5183f6M14WQI+QKqkY36ayYaXxonnZ6eYUbTsRUNZ+9fLlELkfpR9cgW9t1wGwysCPDGYCWLKiz631rf5NKUZyQhthWZE2N1aKDNLlgyqnflL8w5f8aEQq/iHwV8ZVvVr+9KfwXQ4+tY4PzbfuAgTO7HWujVDPiaYXuvuBKqzjIt79mjaXlW1SRa6sdkJXZGO/qGpkgqn/ULYmNKXdPcxVDVShQYo9kP4umcRIiSRIT3fHdgTycdBsOp7/oaTapcupEzbarKNXhfKuPeBfL+bdMpQXf91Cn+K3qEdqVvynjiLm0MdcOOF3S2gcuhD1OMsk7kmNTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUkt+uREkBEJIj2nVJ6yFTWxghXUw9giR6sYjv6Azmo=;
 b=SvYlurYHQr7zJdOMwLwIbcgiUoB40fka3RHrfHOb9Chou7/HInyjpOaMNcNcNU2Z3Xpk31wkd75/sRJhopnsDLwfkCn7Mk62UEPQeHAE6T0Dfn3eMSfHRnKBiynQgW5igfnSXVNH12W/XkGxDQYmoBdFKrsC4I7KPH1JMTR9wNQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 14:11:33 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:33 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 05/24] kbuild, cpufreq: amd-pstate: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:40 +0000
Message-Id: <20230217141059.392471-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5f1711-cc1b-41df-b067-08db10f0df87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FWZ3g2NF2+y76ALinvmTSwpJZJcfVHGKz1+TzI2Ju2RmnStMwrtnnN/ztXCmvENEI3/e9yUkgcFo10cziamAqjbQISqMpBG3AxI9rK6bfGxDlcW80jiVBh6JxPmhJlc+1iOM7hI8db767V97C/VbldKg3aGS+ZwTQTIuS3V0zwaUtuaV8jnHSeToOUJ566CBdGcTjfZvixvFZCzmbE7NakdQPThTXuWdAJMtOnL+fo87xEtGNuwdJCaOTlEGyTuG/qC+PbjzYuRTWtoiM992THnkD32FD1FFX5NtCmhdmU8KTcrsSbgS5wVkjD0Ld4zVJdPZLc9IQt2Ijif9vlkJgMZl/eAh39Pmu1n9tOcP+xVUWlMzbgtVzHFfU9puD4goYvP0Jx+V0L1iPqJP1eYe8Din6/dffVLqYgk2I7jKdBJMFyvl9Degacbn3Wd7jyDorkh3mjEgFXtGkHpBAQ0SMSsMPLAxTeDkoE4zKT2eicKldNHcTBQ6SeomWvFr8giomDWebHi84qxmBW7rsEnXyDlaIAFRyFBk2m4PDeH2NIFTI0v5nSWWQCT7l1LMJ3dU0WKIVTBtiLNhxH83/VoOiZUIWQoD3qSn38AVCq7tR05lo75RNlc0q0pw4CYcD6FGTcBwbFSoavJv62pr4xPtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(8676002)(6916009)(83380400001)(54906003)(1076003)(66946007)(5660300002)(8936002)(2616005)(316002)(4326008)(66556008)(41300700001)(66476007)(6666004)(6506007)(186003)(478600001)(6512007)(36756003)(86362001)(2906002)(38100700002)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dhjL1Aas1ewl51bhkNQUwGdsvJ5KFRIJh4Q6uKuEVlQr/AmXqZxRrOiPPFsH?=
 =?us-ascii?Q?tUHbrPcMGlhdCU1hMO/9tYGNTsYX7CNhF/7N70AoGQ5qezplQjRgfP2cXQ1L?=
 =?us-ascii?Q?ucNZoFUMo2La2BOtWFNqDuNTqNT8Mvsn8SV9jXIqtyHE7X3GpsZT1mKDZpDF?=
 =?us-ascii?Q?lbq4tM+lpHEiGzVXhrw+juByxnayUNWWyleRfiTT5AlDRHmNuHbQ1Jbmcwaf?=
 =?us-ascii?Q?dv7BvByzd1k+9NJMoEHVmp7UyFR/lW7Ssk7JVnjHw3kVghoFPkAFuUH1Wf5d?=
 =?us-ascii?Q?7U7QormUtG3canQMitk/138MqpifiZenvnJxIKHHnIXB26d3VlG7KMGiuZAH?=
 =?us-ascii?Q?f+YE+gKLJhmdJiiFZ/FvtNB9SYz6FGyjqjvA0o+ltI39rywKIm67rwaZyaJa?=
 =?us-ascii?Q?p3sGCt9BAroozDt37SzPa8AImLKTzo4x1vqexfZQ/itwj5PHiedV4ifie0E3?=
 =?us-ascii?Q?hXKgc2hv1ETZ/WcGoyhw/kZ/8AhC3s6HSX2BGvuDVthBrca+HU2+CFmViHf3?=
 =?us-ascii?Q?jxUJ0FHfn1HOjxm+0zZGxxiCVbgKlBmhQ2Jx/4EZWzyZDLUC8jiTDbn/KnjI?=
 =?us-ascii?Q?tbcrFevsOhGSkj51uPFvGjJB0Kj/OhZ+hQEf63GHosOMeXid1vA7nwpt/rVL?=
 =?us-ascii?Q?to44CYjtizPbk791COqwjf+byGGXRysRM8KXWRlZwzKbtb43v/VjZ6kthPFa?=
 =?us-ascii?Q?4DtZWsgXqhL618otbmUykDYLBhnCskWwdhp3dJkiw0ISGcGlb1KoQIGnMSW7?=
 =?us-ascii?Q?1LITb3/3Mz4w93ahR9F41tV+uAnj8hMa3khCUiFyUbCCkb2ah/bJSbLivSg/?=
 =?us-ascii?Q?gqMyFx2n5MkSVUHqSkYVegS1RR2ZVRBokYBa7cZLfuxMY5E5lmxxBKv3yaVi?=
 =?us-ascii?Q?JFcOKsVb10H+TgNJkn+3upy5zHP/Uf3wIJPE8PXzc4lGOjtKL9Zfomnwt6oj?=
 =?us-ascii?Q?fSuWYin6sLn9DZwwzr6O2lZ0dO7YRMefNuuEsGqBovWYY0cLr1FrUAIl2whi?=
 =?us-ascii?Q?5ODUNAii1RB9oOWQG4Kb3Pj5XWMBnjfs9xojsRNWDjS4NoWsrfZsdM9qZ2rP?=
 =?us-ascii?Q?W98RE6TiS6aQIZl0PH5kM5g8FzoSCFXPWUMcKK47pgC7fVroODZePjeaw/tW?=
 =?us-ascii?Q?FkZymyEqkefdVR1kAuN58TGo/T38B2MVIC7vsTTIIEO2I39+fumA2pzuhwHH?=
 =?us-ascii?Q?q04H1L3MNYZVA0e4f/fF2YaonqC6e46pxd7lB2TPJUvvWi7SqurxKQoKLEbi?=
 =?us-ascii?Q?F1Q8sQhOeYIp+QhQ2DUyMZEM+L9TK9KyuUXnc6zqu6EXaSqx17YHaZ5anzsh?=
 =?us-ascii?Q?LQo/Y6Jf/IFL7J/ooRggdcG8hPmsql/Z7VRe3TallU4bnqAkMrBzbX9OCrb3?=
 =?us-ascii?Q?pEXKcFt+oZ2t5HzmHtLA/L59YmGUfMDl3nj1fmSq3AOeoie4DqWZNmIGFKXE?=
 =?us-ascii?Q?cz3DJllZ1LHa3c3kaPHpWTPPXDgYOf8Oxc7DxNc0uVq8lT6Iwtw0e9OUX8+o?=
 =?us-ascii?Q?QK+8S0zgBSEyFzo1k1+pnKC79RXefLR7QQXIA9CWY5FOsIzN/iT7VPl7JzHb?=
 =?us-ascii?Q?lSkQQnnKCU7ZxWyAgZHffDspiTV7nfW6YSx9nf2vg4M0E7PCUR6LY+y42zuf?=
 =?us-ascii?Q?P7GvuWNYoWLUq9Llr5qQyDg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DqEiGimZ7sS5xjW+Jv4AWLazKMQhm+CYGk5kD0gRMzog6wamK7Uek7hM13/RkItPB7K++jtqWI4xTcvKDtguXehoGoNQopS0qn5wRme7wUI68EcTccGPxLYEQM4x7buqJxN8Dsny0mzzhGrMMcFzSR9AV9wb+pDFpbTJ8pA+6u6ePAd8IqPrk5GrVir0ZyRNXEbyktewtbVHj+wgM3sMxtFV51mwHPgOO6hs8VRk5TaFJmWUcDCrmJb135yOz+n6haB5qvoMnbWFWP4IAi1RCMYz2Cu5XsbZUDfTF8AOOu+OPGSYfa5BJGa2jXsvzL1aXcMWFeHJG84xGwUT8Sz29D61Gkx+s0z4KEt38ksfsA1vrwqPYU596XB4UmQfhPLAsDVdZCzCXIWbgQ8aD//8TkRtyxJjTcIxqEUNYwHpEQN+33BIsb6OkaiGfmJCKJsYUcQRz69TsxM8kC3125PuyD4PvET/BSeiL/rvojqTf6v50fzXsq1FcwzEbXwmZQR0keV1lVTxPmub27Om0sSel9grTVmSZzc9zZa3FhFxLYIBuQFOrlA89A/wN8UMgghLaIPguc3rDPwl/DaKlDtg2Gcvx/yZU6VsoQkPm4VSiYrOe14sVJQkcoC+K7BgKzMFtdBby7VNPLLXvOEgEl80vEefV+isSPk0llurziK7MxjUEIhzoWces1syhONjNf6TCPi8bNC8f+FhGfXRMg5wtyxOcQf8MenXd7uZryq5EUwakK0CU6YefvOltZ2ZK49SnoUSAmR5mXbvY28KdIBoDRt5GXVAIDIMf6zOw7UFr46Z8dC/DwfakEBUPEX7dQUytJHvR1Udygddyc0BlHnzjRWlg3+KJM14nXeE1a7FltWZPeVQ7sZeQ6c45gxe/f5M
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5f1711-cc1b-41df-b067-08db10f0df87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:33.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQHSuGJujPg0003uQdxp9bdzxlQKsUIU+7U6dw4Z8Jg5QAkzpogt2Qos8SeOr0Q88F65Ck/pPxqQv5v+uj7FLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-ORIG-GUID: DRR3VbIPAHaf8DzzdF_krV0wyRixY8Xt
X-Proofpoint-GUID: DRR3VbIPAHaf8DzzdF_krV0wyRixY8Xt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpufreq/amd-pstate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c17bd845f5fc..adbc7b0921aa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -686,4 +686,3 @@ early_param("amd_pstate", amd_pstate_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

