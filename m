Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA146A2327
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjBXUaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:30:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9A5DCFC;
        Fri, 24 Feb 2023 12:29:59 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoAxr008494;
        Fri, 24 Feb 2023 15:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=PlLEOTIJd6bJJIiFxC3IPEKwJnBtEqwMQyM5KgM7iYM=;
 b=SN30SDxm6Z5Ug6NLseeyg+FV70VLTpdTv+OFUEWI6GxEEqooHkZofs3zwiS8H8yVlx6L
 IDlBRYFoauF5v42dzzlbEScKrV0guHWnoZUgQlTAjpoPHrrj7fZHq1hl076T5yHJmNob
 nDkwognKrvbK552dtCIzKPlDp7rMxoliFyqEWWCOhWJZZ3gHAq1TVsfnlsFTdn1arlW+
 rHJGBdoztf6Cc9jMyXxsrkk9RaC47m85kuyLR9JUaroiJNNr9iJxswmwaPkSOIng+zsP
 hvAHzRnODP8fMFlUNy43qDcCFu1IGxYlXeW3esT71+Hxcnsaj/Hy1qbUtFXXhxRJnLI2 Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbw750-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OEFH32025896;
        Fri, 24 Feb 2023 15:10:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49kgvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl0D+RaAi1xIKx/stQNeeQVUZPhiNi5Aof8gpiCgZs2TacD8vNlrOcNvAKREt+nFBw/zgPtP0SWKFrBlGmknMB8N1aJEsKhyItaoJauGisHVthZ2tdKixe7GSQQOPQKRrUw9UnU56+IIugNwe1E9dEEvdrmwiKCL/+qV7GCf7dfEGrxwDH7wxXw1UTZfP6VRafIWLZ9wWAymuh/1VAYUmu+zHqqPk9rW53nGLTALJwuKJibsZWbZhaSloqfFML0t4yogrDFi9jBlABw84LLden3A300uOvKq9ChUFUfgE1dNva4wMp7j9svGSfnb1lil7I5WzlEeXdgyTh0y+Yydjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlLEOTIJd6bJJIiFxC3IPEKwJnBtEqwMQyM5KgM7iYM=;
 b=BjoTTKW3NKPBUVVR/i0k+QPoAur6X/Aj4CZcCS47H6qkpqhM5P2939scTGaXkDr7n+LMwIN7j93Nckh8RcSY562TanXL3XKqigsh3LFx4KoEUAUHduYiwnx9/qRrBbb+2sgV6fJ6NC3ODcoPOY1A25ojFH3xhvsBvrdYm2sQID4w3dr5i2Jp55IHi+vRUbBD/F9RNE9Y6CMw+oSsg30YMULRI9u//PS4PpzV2LEDM8OEd6gDY2Ati/8nTIWfmW3g82Vo50DsAXy354IpOlKk4M8tEhxS7dcdw1Xbdo8WZLW2v7syiEo1v9bmtuw6eFgBcCF3THZscpjsAwp0kPd3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlLEOTIJd6bJJIiFxC3IPEKwJnBtEqwMQyM5KgM7iYM=;
 b=xG5vwJudnkwtDnOnir1obWAfGxreL3hiyXnMaGlfPeCM4BaFpmUnaDWZkmwQhPw0Xqz/ltHzD0zmK2zzv4g7j9upPdvDwXoFtE5w6WSWDox3XVzbci2tsxwWMlhoQGYV2bLUAA9R/bf7PNXSh0fiZoVb/XIuWhKxnJgIdoK6qCU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 15:10:15 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:15 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 24/27] firmware: xilinx: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:08 +0000
Message-Id: <20230224150811.80316-25-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0522.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d14a4f7-413f-4959-981d-08db16793b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt28duRi7XGt7g736llboYmxN8wNRpo+D9rsnOlcDjGXGOsr+zd75vkQ7aoALndr3W636FwquCnlSRKUyqysikDwHJPsEEYDayfmwqq6oOrqITAVawZlW8qeyYjVwe7toswyv4UNabb/g+OPR/va+f9bZU3LdWZYDrHRHsiyogIBSVmtWVpgU6haF3yFy0TX+UGbnPTI7r8Kzu6nlu57Kq0JsL0iIKD0GqpYGLhtqlkjWjKesJkN1Au6fXwxMOmBErbUa38im7xyQEpWCtzZqma6guhifXCBS2mdp9G2rqyp/YtFoRD4wp5PvnQeJg2MARcb9RzZzpvI72RMApbIdOr8g41NVz87j+JqwtSbK5RAlRZetZOWaNLqXuPFsOl0+17dl080zoG9DhZR7BxapG5fGA2aXw2+RmcACM3ucWfbaKC9zAH9GjSd1ZyehB+Wu0rocRpMz0s4TlHN4kfPJCjyhBNv5t1I8GSA4+ZDDt2jAElvK7Xhnu99SUdY6nMDDEHEtCDa73dEmyDg9LhqhsM/0B4vUXuGN2Mnd/hbx34wMX1hFig198i6Hxz4E87UPYKaZghM/9xrjqYcN34UHCULPeYgExp2EOeYlTSGUZ+4XW5uuKAblPxENaELJg299igpWoVgfCur3oVj3Up3BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(83380400001)(36756003)(4326008)(66476007)(66556008)(66946007)(6916009)(8676002)(86362001)(2906002)(38100700002)(41300700001)(478600001)(186003)(2616005)(1076003)(54906003)(6666004)(6512007)(6506007)(316002)(8936002)(44832011)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsfoSHYXsZZZ0o2YCc3dD1Aq44BwyO/zFlbp/lM80FvOx1EXT2uLuSW/vQDj?=
 =?us-ascii?Q?TuTE1gPSUDne+03XxnANwe++OemwSfOL2OcDp2yIys/fbH7BespKtc5rIOHo?=
 =?us-ascii?Q?yOBRs1eBgjb79xiUZPbguCUlxzLUPYwDBg/hhka67LqWVKkqwu6Sbx+m6rcZ?=
 =?us-ascii?Q?7phoPQiRKXwx0vwtVw4rntKe9sTTKnr39UF9RQXiIk91CbnrAUlTxb9thFOd?=
 =?us-ascii?Q?GgYBiyOAgHyjBCcZVZM7BKdGtnrLDtMxB+nG33hL4eJQ1yPoUeoRZCG8cmsJ?=
 =?us-ascii?Q?qz/RE+GKsOWYkyEZKheR25OGWlW3fmkUW4sutL8zCO7EygWHS1eVxiQvCTXH?=
 =?us-ascii?Q?c8Z4kHeqRB/HD5Mq7GnNV5zidktngpg9rOSt/owJcJQIH+mWNSN+bF4YIOan?=
 =?us-ascii?Q?svrE+PARoH/tFVMvT95eIA06IfGzslCII0wZROa/aARFGx7Zbm8Bwo5vITKz?=
 =?us-ascii?Q?J80+cHny0tVSCUbwSAfFRpPpAeu2CdbdacinSqWbiOVs0ZVjmRPpy/Vi2WxT?=
 =?us-ascii?Q?i1S6XkhoD8INXDM2bfRyxnUmmP8tVRpkeJaPLdNAuBsBuyaMZr4IQderOn8s?=
 =?us-ascii?Q?a8ddybViqX/pbHnctSuPU/hX15JbXspUFxTvw9QvkhpiWDueWMUW2lWxSgwb?=
 =?us-ascii?Q?73P38u+XSggzCEEQE4AcdQncIaJdHtv+2UOpOZTHUAf3x8Vb3xcG5NJCBSGf?=
 =?us-ascii?Q?mntvIC5lqSYRDIFYrC7kfySspLgLXHJS3xH5uLCkqESXfvGTi/fgPG40D+76?=
 =?us-ascii?Q?hziEpIKv4juFz0TB3AlHpGa/TbyjLPJNncO7B0THkOxvawaMLKKKdVRM3Y3C?=
 =?us-ascii?Q?8pPpiKEcHcivzqCDXV4scNpAFpcTNvqRMvNVuxDgdgVm3azz3zOq6b7nV9kU?=
 =?us-ascii?Q?k6dHuEJx2Cyrdltr2U4ifTIkEWPF/5tLsQLT3CYlY4btgTPSM+fVdA1aao9y?=
 =?us-ascii?Q?JjhUidZQ6Oju96MOatTeKvU5kHFJW2Guz9kxDgRiK26WFVlfn032En3SkkmW?=
 =?us-ascii?Q?jgczz2IlRxA+lbUxuKChd2GBFM+pPb6VRxwNkPymFUrnj2WTkgcddU/KkJO4?=
 =?us-ascii?Q?9ItZft1UQx7RnoFsQynUzjy8K7rWCTH5T9nYazN8TfQAexvbNKyM8HBAo5a8?=
 =?us-ascii?Q?iyBaPLZgIxUr2kN8rZHICM6KmUdw/A0PwDa6xWQZ714cRM1PPNZ7pW5JJPu/?=
 =?us-ascii?Q?KeoCFcsYNLFsRmmYy4etq/7qpLYf6ix2RO+xJtxPZA95+5cFwG17CDQ78peG?=
 =?us-ascii?Q?xryiuwpgoQnem8R+R2UenGCKUUYOEe7hwGrukGreUWVsqfUpPCeff6PzPPVN?=
 =?us-ascii?Q?jGoFqP/8QU9KNauO/hgVYN/otesXHFjwrqLdA46PR4H8Cp451NlUhPMObo8l?=
 =?us-ascii?Q?PZtMrsi1RgggJmd0u4y/IaoN9yekQx6LxdQeLPqhI7tIcC795eCiFhoZ8Oai?=
 =?us-ascii?Q?UQ89ZAC/JbTxBws194F78ZjDWzLyb3MtVLZPIVDIp8LTfZZJvmDF6FXWZ0zm?=
 =?us-ascii?Q?3+NuYFGl4fk10m/B8iCf3fZ3f1ywJJ6StSVnCOfL4ycAcOVDn7A/+mWu30rJ?=
 =?us-ascii?Q?H2OlLy/MKM1kK3H5gPdEm1+72+5NwtaU3nWJEl2fIH4inT5ZtD99/bNLx5D3?=
 =?us-ascii?Q?DNmD/wsPhZy1uB70tACEF7M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cfYBKfU1lEf5x9VdLe5jVUXZ5eecGjWUw5w43EEDYn2b58RUxCgzzdwfp6Cd?=
 =?us-ascii?Q?AOIvj2Mze9FbswbZES8Wrn9fby60eCZ6M1oYzr30EeO9VSbHRhV8M75gWc3j?=
 =?us-ascii?Q?sD/GBtef6IzeoJ9ltOIt5CJ14Vbv4emk2OQn6xm2zdIEunT/9z5ZETviM8H7?=
 =?us-ascii?Q?Bsa+0N821gXI71J6nljLf4T0Nx11xkk21MRG1uMG3jmFhWakYrhjKYDLckhH?=
 =?us-ascii?Q?z0ejboFjO1djncPCKhwMOjwSkCNYCLDrEGq7C951xjQ6xEoz1Ub8Ddrxcq81?=
 =?us-ascii?Q?QUY+8NBCkeMlE8TLA52a7e3CN680QF2M/Iifb6c+7C+g3MvqA+xaN3jP1DM2?=
 =?us-ascii?Q?zkDosuL4/J5z74WE6ICn6JWMoP1m3QJxXQfaI8Pluu3988d/RJDTti4dQrag?=
 =?us-ascii?Q?THoSpQ70RgPuIUyBC5XU7E85kBUMGZEc61v3quoYLQQoBhZhYEsjjTiWQKHQ?=
 =?us-ascii?Q?+GB6q3edw8ue5O4IGnVAxA91qGGR5s7SvQHw9+cZV0sez/ijoyFASlzOYpN3?=
 =?us-ascii?Q?91vt30rtWZaVFsOycrbtMH+bgznH2urv9gkVt/Jx2xLZA5A4NgoN0eABzrIu?=
 =?us-ascii?Q?NImgm1Cw/118x1fOIRDoN3aGJKJxvJiCILXS5kLUaLB+wbaGYvAgg+lEat8h?=
 =?us-ascii?Q?E7kXZppWroHp5eqRewmigyp3py7qwblLsCYM7lF3S2GeaeWDfPcw5nErdBDa?=
 =?us-ascii?Q?b7uOjku4cJN9IAbujXZSwqMDTyCSw+c2A0XXZ4U+L4LwVZ6t3/2o60JgrMak?=
 =?us-ascii?Q?3IvEIyh8ZzGa1RsKyTUh9aOVe0xuSv2ZJtLYprl3qdMDSXOrZMAS5UQ0RPjF?=
 =?us-ascii?Q?p3hj+m3LLJUkCn0HgImQ9H1/OHwRovkaxQeyIAjv0SxNjhj47DETIfJwuXO3?=
 =?us-ascii?Q?E+g5H91pZcv9mN5QJzFvVufSc5k+aA6Az5RJVKJG4RjCWDfTez3SWkaJQzbt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d14a4f7-413f-4959-981d-08db16793b98
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:15.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muthvwkSAsxorSj0dJKT+2ksgibpmuxoaXtViEok7JA/sQXrMpBFPg8WXsfaGrFVbUCX0ggUqbl4RrbeTvEyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: ny7fN2U1bTExAzYQN65Cq0lEm5vSQYvN
X-Proofpoint-ORIG-GUID: ny7fN2U1bTExAzYQN65Cq0lEm5vSQYvN
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
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/nvmem/zynqmp_nvmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index e28d7b133e11..844c1d861dea 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -78,4 +78,3 @@ module_platform_driver(zynqmp_nvmem_driver);
 
 MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
 MODULE_DESCRIPTION("ZynqMP NVMEM driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

