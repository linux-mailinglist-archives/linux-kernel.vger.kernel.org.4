Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE821700EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjELSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238007AbjELSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C983FE708
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF48VO032462;
        Fri, 12 May 2023 18:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=eZAjqdRyQtqTEEhCSc5fzztPveLNdBXCxTDYIz9swOQwmHXFzx3Z8BPfa6MPl7Q6zVzy
 lIkqePQapGT9CIYFChIt9WnGUEJen8s2RRV5fb6PP5VAYvGRzj0fTKtkPHpQSLIQO81F
 ZT0cLbnFEVJWp+qEKafJLZnFnO/jSOg/D+2ECpUEVWeGHaKJ07H9rM0O5v2EK+mchFIn
 dj9N+jpGymBjQUoXEZyekih3hX4u22RkllBWmilrL5u7f/fxr4CLaYIoxwHTSqVDvm+g
 sPY5fUcdDRP1xfubF1YeCVqF2zOO/TDycPaI6pjuN6lHa6Wg4zlbD4hW+oEevWMYN+TJ KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bkym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGdTBi030528;
        Fri, 12 May 2023 18:20:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81jxf91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBzNKGEKxXfL0U2MIVjJiG82bEhld0SMpq0OhJeZV8PAXHxzzcRVlf5KKa/o4PNVTWI71WWh7DqaCkgKaamPcXQCn3NkfPU2ePU0WjI5pCAxUMNhEWYS1NYdN5mmf4bspRRKBq/hsigS4bnDPN1mFaibIhQ3vIBHZwgHPIAuZq6GJfALDpC12UrUBhUeaZya5pozeFlD9NLARhK+x3OY85ZSYjbxmkWhWez3BXA9tLBPQ8ZImpGR4hNJCibDujeZdia8RQ3w0dIr8XYidnigqNbSkTh5uL3ocoFsz45Vlybpe0sI2gcL7MlIecENsypNz7B2bU1qTrtladYDGQVY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=gAWgRqRkoPPMW9w4d7wSw+AEm12mfjyeQkHzGeC480PuYulDDYfqgImpN10Th9I1UuwJir8WhZhOyXWZzvzZRTW1L4oBlZXwBauU8oM2hth9yQ1lvS70ahwDKumBVhBfAzSR7kh85PDkWWFk3QFjAcNy7hR9CpwWeNbuwcTQ+T61RyaGhwTzsHB3sZE6vI/W1djxSTweYIssgWhdsK05lJ14BdlRCSOISFQ2UgP0hNxtcr/rmfKihfPWHJqLtkNjVgTCITvLlXbKS5vaQmjAjKQSa579mXw6EMS5etgmhXK2kRkyeJvgULq1m8agzy0zQxUnA+OszyfRLW1bxIlgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO0W61VFFcUaz53IVxUaRxBQyFx/sbKsCEqLpzGF0n4=;
 b=rS/viB+3lF/1nXucy26//rDhkj3yrGS2DI+1Dumt4C+f55sXL+PyVhalpiMshgXPB3Fg/PimnBJb0KsSH9DBaSr8ssd3P6Kqpd2LQamPxPMHr1n/S/2HqY2r7Gx5e6UoldMZ/MzF71JfBUHxjOt02s9e3WM7eO/35kBC7FzLMNE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB5941.namprd10.prod.outlook.com (2603:10b6:8:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 18:20:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:20:52 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Binderman <dcb314@hotmail.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 01/35] maple_tree: Fix static analyser cppcheck issue
Date:   Fri, 12 May 2023 14:20:02 -0400
Message-Id: <20230512182036.359030-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d97f47-4070-4ff1-5f2b-08db53159e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oh3SWP8PC+BJkIGCRPABN3COKfjc2xOCE+BJJhO+H6TQiHzOGW5zyuTq/un7YqpqIygFxOXAlGCJYkp2QfSvzGfv1qQvnd3Q18d2y3Gy8paBVztHB+4Jb5rcnkfaMdJOUSJxEiGSeZCNz8nZ0g9tWCqE56XS+QnBfdE/Docv1Ki3ODBMmARjjGEskXowoPWxewN1IOsg5d5VMaOlf0C3zQh2wgXJYwJtvpZbha2zIet6U28WayjYf2/3VU1tzqd+fErtS3W6rGx5ihlViKC4AAEMNT8hpaG7wbdWOCFxKp066YVshiwQJOjcW5JXjgOm00KbJIVjBwO7h2i08S8i2vFSOyZkTrCvmEnDPiniOMKo92JA6jZzI2hhpk0CEDPaToytNmY9k5KFBb0ZfvZGvAwImu4tIy7XR0prfLZmHoCWlHtTUBG+PMjjkRO1/PnMol+7By88u1OXWEnOCUMxhjPMLO7zycOkQsPnOsXqXZsrPMzY55rDtMXzFf0CpJyyfyReMS4IJG9Y0a2mu9/3E8A7wojlAk7TuE16dyHuY+mkw6IzjNTxsE0XztMAJh4d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(6916009)(54906003)(6666004)(5660300002)(316002)(6506007)(1076003)(38100700002)(41300700001)(4326008)(66476007)(86362001)(26005)(66946007)(66556008)(6512007)(2906002)(8676002)(8936002)(186003)(45080400002)(6486002)(36756003)(478600001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8jMvU7nhWLS8IW4wBVyV0uNAsENws09/QxOEMVb3qDt5SVNFC/YJjtmOdfN?=
 =?us-ascii?Q?fMKHHT6JsywVuacvDUWkC4WDOhAuApi2sIwOM+ASqD09GICGEhL/x3WHevqj?=
 =?us-ascii?Q?yAT7e/tuNLxbqjnVy6df7wMtCzA67LaYZeMYWY2+sevp7CK8n+TG07Gr7Pwz?=
 =?us-ascii?Q?fy6d4ZARs+lub87917e89bG9fIW2rllFxJ7B5F9m4TgUUonH2jto9wCIfjOG?=
 =?us-ascii?Q?tvf5W57vkHGU+zyaTMD9fApk0E7ujyVjDeOFqsLcTGmVrBq+n6begr3t4iXw?=
 =?us-ascii?Q?00v4GqHHufkF4lc3a3sQeJ+th8FMk+AVo7Oy3+XoQRZ8fPBLbL7sKmpefWXY?=
 =?us-ascii?Q?dJvp9tNjk9oEx9cNtvx253QFqolaYtwnT/c6GzWb9O56i/Nm7FONbYsFthLL?=
 =?us-ascii?Q?em38oGEiW6yw9rbrh1jo8nr2OvVEwLziWg07mT59hM+brajN5oSDF2V60jix?=
 =?us-ascii?Q?ODIV7REEDSwibvxoIK3m341E27FUaKGO2P/0d7e15W21tD2iJlfG0Xhvtiie?=
 =?us-ascii?Q?v3sJlKSzEJOURhfB0U4SNq+DL5qLskn2bljeWTAW5zXcV8NCH7Xae0KTxv4o?=
 =?us-ascii?Q?yilCPjyodVC15nuYHvUTimMipEgD/gXEk46qaojhwzf2Scnh7zRU0t1fWwbM?=
 =?us-ascii?Q?oDxK32uWNcsZAVYum//YmluoI1kOxCB6wIxylX7yhsMYBFh/vukooD7vPrqA?=
 =?us-ascii?Q?ynkL8MHpmIGdC4loErLPzP7mRxBuzRiMH/aSOybTcRjwJGX0wSxDLGuJ6o2F?=
 =?us-ascii?Q?YXpN+cdaNRL7HstYHb1DUX0LtqX04YEz/cl68Ye+vpqsF/D+XEpHWX/lPTpK?=
 =?us-ascii?Q?/1vc1btfoePTfvITQulQfBupYKIY3r8iOQGEeXgpYlVk6thSoFrvx8/naITU?=
 =?us-ascii?Q?jDcG74UnWqikPpy70DiZGTvm4BKbqBcTYSLxr/p5PRu5Lt9u+2xebG1H62ge?=
 =?us-ascii?Q?YWvgBVQy+MqaIJlSY9vz0DlHVEMGZF01yOwsOVOoaQs9SG7Qyk0XoB4q+Csv?=
 =?us-ascii?Q?OfPICvpFgkVj/cb3VF1+YTL/IfuzVhyWQ4WZ3x8hrPNlOPIvWokBsVsez+2J?=
 =?us-ascii?Q?A+PN6/0LfHZvc7ukZhE3OEo49Wd/v6YFz+owba+ltFZcN13NWiahSEa5qK8h?=
 =?us-ascii?Q?vgUfLxnrlYr2Z3fLG/RM9rjdZ7ftdn2QAKT3ITUf8DM0hgAjE4ogiy0yG/Nr?=
 =?us-ascii?Q?EbiwedubSMVQ+HamqVTfCrCQUW1KLPh295p87fUDW3Mj3j0X/t9KhqBFxWAT?=
 =?us-ascii?Q?Z24w0CCTKICLJtv3TtUc5R67bfK7Q9n3/d4lBx3CktX9AWb9f9o5KsVfPPBf?=
 =?us-ascii?Q?u+RmCwk3QUAEX8L3JlWX1WjntePTdvVBFsluFKu0WFGlP8nGkBMY8rBVkZCO?=
 =?us-ascii?Q?QvZnyz21NQAoyceC61264XcgEEfBodGU1uoWqbsCHiiPf7CE94AvyTmfZio7?=
 =?us-ascii?Q?lVrA7SP2Ht1FVOJ4zzjJiSiUzTsBSeRIbT94ULdO/QCF6jpE3oZi1imIUPgI?=
 =?us-ascii?Q?+fFD578sm3Hm0rxaFrbQHFsQEaDiLv0++jfAKPOj/O8zOEQxZTYCq6/ZIy18?=
 =?us-ascii?Q?3Erjcg/X4xcvAhy73x7rupGR93NHaK3zGo2hlQj2zGyt26wYxhiUVQdJ9gJ/?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?an2cwyYZ5Eohgdz1GBM75vlG2id7yzX64oIZM/ux+u+m0tzKtUWww4iRdFKj?=
 =?us-ascii?Q?Ndg08cRLacnF4f7vTStEa49ClncyDMqBimxYenmqKA9Qpp2gCg19fUIYe1hK?=
 =?us-ascii?Q?Kyj0GLL6j5lpOa8JcfdZROa7rogDaEjJT8XYy2fwW5yuZMufXGKQZjBqP7Dd?=
 =?us-ascii?Q?ulRAYuDeSIKUwzLD97h06+QhGtHxJo3jnl5zwFU7bJdwtY1RRk29Fc1CzWZ1?=
 =?us-ascii?Q?ypmWXzgua0rdnq+k06PlhrzE/vCTQrFPF3zecjsAxS8kvUXLME0UIefSTY4Q?=
 =?us-ascii?Q?nKHv0SpKb4/ebVEvnwvKf65A8Mmtxcr+nwvLay/JOC8xMK2CyQMSkHBz9VWG?=
 =?us-ascii?Q?a2o8H4Cc8/xnck0TaI0LeQvdYUq/f7NQf4F4VSsr7fGn4sIO8lRmJyBT+oOc?=
 =?us-ascii?Q?PS3HV0WhZvVqPbimHoZO1nqpaypwAXb/6qIVLdIQvL41lJ0tm1XbzJL58OTV?=
 =?us-ascii?Q?q87G7zPqfwkIRYzpuUmG15/Nv6DCKK5v9uQ7WS775CEVdUekZMnrC8dczp4i?=
 =?us-ascii?Q?zRb//h8g0RPedkpumKjay0zSgQuUfGXQJ8ZK9oOrPcEnREpPvpoUsEqxnLR2?=
 =?us-ascii?Q?Lcg6GvjoirwPcBPCcXbW8py9zpYL9FAFvz0NfoiK9UHEobyCCeZam5buJczA?=
 =?us-ascii?Q?UeGAGO6TM0O9UOQzcLzbKfwXmiCbQbXueUlPaN0N6J2hC80Zu/SuQwSR2iSv?=
 =?us-ascii?Q?zFo21+FI4Ov7xEFRXWodQ6MvCAZvOk16wNJr82LQcY7Mqrxh/bhLiiXBy9vg?=
 =?us-ascii?Q?AeNpD/rkBDnkItrQ9RXZutgbKM69jPEq0hGsylpo55jGioT0zolVeAoTC7yP?=
 =?us-ascii?Q?zf9rKg25RSD8FvP/NHHD3PtPKOoZDpjS7El9nsFvVWezfZRsipCQdO5eBA3W?=
 =?us-ascii?Q?SIVK0oYgr9U8OwJ+QiEldeMEuxFlLvQE/fN9EYZKxPkkidsXRD0IAfOQpsuq?=
 =?us-ascii?Q?CIDxV5Fg2vqye8NuavVqpA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d97f47-4070-4ff1-5f2b-08db53159e64
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:20:52.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0FI1Xqqvcb41nV5FfIdWPMX2ps0ntp3HuwNqYllPh+JMImBgHoZgsKTCzmQxs00is9LEH2osWviu9xphGxN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120153
X-Proofpoint-GUID: chTRX0Ku52JleXOwKuUhgAN9nnOKy8Ze
X-Proofpoint-ORIG-GUID: chTRX0Ku52JleXOwKuUhgAN9nnOKy8Ze
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyser of the maple tree code noticed that the split variable
is being used to dereference into an array prior to checking the
variable itself.  Fix this issue by changing the order of the statement
to check the variable first.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang<zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..9cf4fca42310c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1943,8 +1943,9 @@ static inline int mab_calc_split(struct ma_state *mas,
 		 * causes one node to be deficient.
 		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
 		 */
-		while (((bn->pivot[split] - min) < slot_count - 1) &&
-		       (split < slot_count - 1) && (b_end - split > slot_min))
+		while ((split < slot_count - 1) &&
+		       ((bn->pivot[split] - min) < slot_count - 1) &&
+		       (b_end - split > slot_min))
 			split++;
 	}
 
-- 
2.39.2

