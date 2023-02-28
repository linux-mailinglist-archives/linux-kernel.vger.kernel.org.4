Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268A96A59C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjB1NE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB1NEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:04:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50D244B6;
        Tue, 28 Feb 2023 05:03:54 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6I6Y5028420;
        Tue, 28 Feb 2023 13:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=2dcEZEWJ7OrOBzaa5Ow0eUHQKXugKeDC6nZfH1ugso8=;
 b=RDqZe7EFZxrGDswC2rkhCASchDJwxCPNMpuj9Av16jalWSQ4jUt3oepKJ6XDJYCUDDgU
 LjEK8Rb78cj1M0ifMWSbNUDazNjOpGbXh9BVZmmYmgPPkaftjLg60W2NTbw0mhmw+Pu3
 +gNi+1SR7MdNXlDOoBRdW4w8UOC+QSnZGJUTRwBRVqmhEBzxoRY9L8xreI1D2Gt89i8C
 vjBflaSRvr+kkwppygRSQvyq2K4SBBgQBFXJY2Ygn84zPSRYcbqcA+mByFnW5ZcyEP6U
 AlRgdFaT96AUtFUJAqCMmGwz/t3FkxJ2/oKB822pz7k/xU5gT9/GNpeGJxLwVrZk2nz4 tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72e3pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SB0nSc031559;
        Tue, 28 Feb 2023 13:03:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sdh7dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjNWUvkcPoFlyfb3g07aewPcmihaUmjy171mWwl4VZ6BJoVOZGW7d2RZH/SrH/sWDcvMgoVJ3IVOUal/q21tumlqsfuneAKlYWApTCkm+DHoLeZ0rsPDKEvcALGyeRvqQlj2Ge+zxc2oub9Q6aLWcQlVCRqjb7YmBqROGptgXGR2bXKp+FmDjpQJ9wlXtaaKylmLD1c90h0I35gbf9KtMOTRVS88QSid1jGsQomyo/usf6E4WY58fav+emOQv7X8nxlu4AS1RhmXXd/r0jjCTzjsU689fUZQxH8QRB4JDlRrRkW7NKY2AyFIDgy0ss9krtthohARmsmgSOuNxVIxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dcEZEWJ7OrOBzaa5Ow0eUHQKXugKeDC6nZfH1ugso8=;
 b=RKmCodDtJbU4DTGO2k4N1wSQK/rTYy0x3Bckrh/zH3bWxsFL7X2DQiZ1q72mmkMzYdYkoKCFowKLeAEYgWhoemx4IQzHoK86UiDBizr9twgd9Xi3V3udwS58aXuxXgI/OGTVbyUehRewpspzWmADFO7pGUvKcEvIC8+EfzTdnfcynLU9umxq0kkZomx50+242aT3h3poYK3G6AwEuo1JKLLtrXQPAsmqt5gw6gRzxDiVkzilvZ3BLXRRvYtNStR/7Q/aL0mJt4J6wY0vu6tgUfey04dc0khrFCgXIUaYlaHaR216lhBVqQO1UScVIfL7QXXfO15xh6xSSrE4sdAN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dcEZEWJ7OrOBzaa5Ow0eUHQKXugKeDC6nZfH1ugso8=;
 b=B7j3w/VU4Dek0KwN1SG1Qo/jAK10ThYcAL3lAVGsc7glTbXFEIJ7R0rLPsOPV8s7RcFbbHhXS18YreNerF0hrzluanK6ELY12EVEGMbJCiRyI7BE58/zbiUz0nW4NCNF6rFjANN1UjPX4XfaxH6Ru4DfOyUQK3nG4DWBh+cdRRY=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Tue, 28 Feb
 2023 13:03:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:01 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 08/20] remoteproc: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:03 +0000
Message-Id: <20230228130215.289081-9-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0449.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::29) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f6f8f0-8206-4a3d-48f7-08db198c1f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /B8AG0g7oPA7KOuunrjlIwRuu9/8J4R46k8xShhqBSBbsk4TCyrHa/igkYWcUkjOKFKRhCQN0DphMbEjTPZDJH8k07zfM3W5BzLjfAm53Ve9bRvl9nppqcQj/K40uOyMsGWPPylczF0VbLVkDYy4NaBiKcuenaRNPqpv8zYEHGGnH98SeoTo8HEBTpjzM8RAXXSga2DOEbQBnpCVssV6VornIA5AT4LBDmCv82WS8lYLTQE4yu3Cby9E8RjzMQDrrkUrxw6YIN4BnVjOBQLpZuI5B1H0wgf3Sqdg/n0ReoleEQtH6F7nM2QBg3Q7sKUm1F2iEnBmxA/W+PF3amdD+la/z+TBbfyStm3WKGIDPyNEOXbdXBF4wctKmyJwr/DE3WsWeVOp8cOhtG/R/0dtWokNrCkcwgGYVba3P2sbLo2liazQPGEquv3eqz0Um41mcFUbuYnIwMc5c1wbZDTadmmCU8ey7pmNE+vjGDajZHJ8+mk3Y8kSbrYQIInLVBWRS/aheLlpX2BfLwNGlVs3yvQTyqu16ZgWFZBihAjz9ArdGMFW6BVZFCve4BcQ0eiMD2Mg4lQNzvHecXgOqXmdy0dRwV0AqMBWc4VI5fMa8nFmAZIzxOOuUMZm8aOcNfE2mMCC8XyreMq2nCoNb+HoIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(36756003)(44832011)(5660300002)(83380400001)(478600001)(6486002)(2616005)(6512007)(6506007)(1076003)(186003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(8936002)(54906003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dX92E4nSNOTirrwpJw/SUuXJxu4JowIVJVq+jr6/EfWhMAe6QMhYRFztqfVB?=
 =?us-ascii?Q?zdkaM/GipBaVpqZMApCxx5o+tvB4YHYVeyh5LUD0sWin7w8fMCN/duuhCYRb?=
 =?us-ascii?Q?vHuKXV9Inhh/r6r1eVyXVZxEdRGHDeP7CX/AUL/AuhJay4xti/uDT6UWCrvc?=
 =?us-ascii?Q?aHyu3/vHM1qiTlsg87mwMLrRnWO2Hf4ZiGt/UYSVGuolSR27LG8nvEdYyUf9?=
 =?us-ascii?Q?d84qazux2qvZZLTnYNf2QaI7SsGijM3XL0NM+eDmOo9Ma9b3+OvqL6Khj+Ex?=
 =?us-ascii?Q?C1rKItiadg6/Rvsedahq52dJUBB26SgFpTh93f26dUZelQgI/9KGtQh0y7LY?=
 =?us-ascii?Q?rFOeQs9ZFEBzBfdfJOhMdFsb3c0dr+WBYM8Bvg/EVMo0C+dEDwivK5JMGygV?=
 =?us-ascii?Q?CPH/8CSOn/Xcuo1mFn5Ez7bHqfqr1WxdJDEcdrC3dEFjSR90anhM6Fqxgel6?=
 =?us-ascii?Q?YaClgeamMdVgWSGmoUhrKBzOTnxPJNDT3En8C+plrqQutZTH1k6ITJK+kS7X?=
 =?us-ascii?Q?8dIbKF7QubjKSbTQzJRsYpdbi3QgTjUW1R4JoiNzf9b5Pn0iiQbAknMqxMsZ?=
 =?us-ascii?Q?iCni9yQTpt1gb1hETUaEteDIlG0yd4vTaTlTUt3ofubwrKXLEGzZa5diSWXt?=
 =?us-ascii?Q?sj/ERMr4F2C08GP67Gztf2gmSGK4x15wolZFd/KS6XgPRMIf8RMBnrbaIhua?=
 =?us-ascii?Q?TeWuOWchoAWid7eZqI6cypDd/DUN5hvecLMG4Z2KWtAiJfvWZTjm5Dnlyd5T?=
 =?us-ascii?Q?bPeu84dM/hCwg0amTSJCU5kCpcX+OE4a8y5wq9lcd8EgP5PWxiRJf3oHYjTw?=
 =?us-ascii?Q?E+ExKoIBcM5Y11bAivXRwFUUyLJVvfMc5b+tsTwVl6CePCFt2X4S0Eh+3M1O?=
 =?us-ascii?Q?d/QFrAZOq7RF4FFcYuK7dDesPxShz5ODbR0UdyFkVlVblKvmwI6pTdLWIQm+?=
 =?us-ascii?Q?GuIo1KWuDCz0O6s3RglDoA1S5YbZBohnuMSNqhc8dWqxWaoGg989emgkftIF?=
 =?us-ascii?Q?cKHo02ucp15FbQ0QbyObnwhkj4OtLZlmSJ7VXZSCPeAPVKvN2aI7+N74EW8R?=
 =?us-ascii?Q?b3b+BxZuxoSMj8nuSHlGeKfp3UyWOra+PDu86rm8LUEvXWkmCTrVY/IWvyN7?=
 =?us-ascii?Q?W0GpjwCHBO3txIZJVpSYAJA5mDyIX9WaI4OZnCvfDmHtIIUdpDzUmsMaqrpe?=
 =?us-ascii?Q?ND9qsuHNeghnamaKmxrU4YXluzWqQXzutZoiaacTWZVgFti3lt+8yUZ5srJg?=
 =?us-ascii?Q?XryBNZTCw/ml4sbs9azarA2DYZekn/elBi/u7q71M2+h9Gi3UnyY2riQL7LM?=
 =?us-ascii?Q?OtoCRwc4aZdGupggHv9c5aOAZcxE4ty8Ev9sZA2Nqs3zJQWcNeGNs9WV+XOA?=
 =?us-ascii?Q?4Aggr0hWI1hxSPYjwU2zLWYIFNWV62J6qKBm6KVIiapfGB7L6dgFpZ/jxUh9?=
 =?us-ascii?Q?Xo/c3Q7n6/VitemXls3kPSBgln+sS7UuhWLvVGLnSGkuQAMAuIhi9xu8OnMO?=
 =?us-ascii?Q?vyUs+be11Ntn+r5qb1UBcVXeedvuD+p273m0DEiH00tv0LUfHzgRBasOYmT1?=
 =?us-ascii?Q?9VkclNc/IM8vThQm/VRMQtaA36pQX1lChjJl1vS2G1Z73G7QF2dweHVkXLwC?=
 =?us-ascii?Q?D0YvLWaV1CRpFBgCVcZbMq0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XwrAoCqJMpU5pxXh54/p2843iOxxj4PLzB+zLzRkMf3xYUr/XzrHjNVnXPwOYe09lYeDq3aUqTunUcN9hny9Myd7MRlnFrqv8SY7Q9Y8yHQBNkJFhhnUQeAq4W8dx0HyJ5zn7diz+6EammqPbqBRO2PEokvFncwDtTTQL+6wJ5dzPpKo1wDOxdmAWMRR8UFOUrkCoEx68HAkRJgLaTp5jzNOzB+8ekFmK13vUGH6qAc65XFW835QBdJy1tkdAPum8XxMdYtnskUABoOFRQ9eq6Z23juydEV/SubjMHBEuIYyIszlDWRswwQJaVZ8sDB9gApcPYdbbTWzXoYRUfAduZYhVOMin6+IU6aOkywbUpV61o7+He9+MNzj4eDBCcpUNjT+d5zIf10YWV80gXSpyImrSrO9rKZrHhkxDJNSF6imCYBwReixC990oXMQ0kudbJmshOExGKADvo2GWrUmwqKGe0HXTCvKdcIdXFUsNbIZc6FdM4h7vbAN+N8vNffgtnsRaVpRvx3amEbq59no0QlpQ6nR8MiCOVzRojSzP3FKs/uMZdvLQ3Wk/fywiKSfd4CEusJt3wlkp6o1GsKKrcmAIQtFxmFoJeYhtEsh5qJuJzbuVFL8HA5LQmEOt1KFxk4Q7aUpqdpN9Mp/nCrNDGR5RQQnQuT3WUOrPi/XOSW5jqIbt/fH9eQgUMhia8wQEtkls3ObyPz4vPfoPGQY2iZFsGtPkpo76eK9NrL/yNm0MoGnLgFhOBu+eBJIlWzGTprdsfqDlOoSrNGOzSJyg4Lszukco6ZkN0caxcVGpFjJqgANaHa3fTef+VG1kwzKrjo00n9Ty0Aq6hOcqMFhY0lgG3T//Zf33gz9W+KX/Xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6f8f0-8206-4a3d-48f7-08db198c1f2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:01.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uahpps6aCEaPcWfIvGAVqZLxx9Y3vreP/yCwssY/tZqe1THhXvT/S1WUnkwvH9IhDHqY2O518HUjwf763w2YCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: T0LFvzhILp9LAyP-0BvX8_uJnGPrIHeu
X-Proofpoint-GUID: T0LFvzhILp9LAyP-0BvX8_uJnGPrIHeu
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
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
---
 drivers/remoteproc/remoteproc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1cd4815a6dd19..de1ace44cb57b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2765,5 +2765,4 @@ static void __exit remoteproc_exit(void)
 }
 module_exit(remoteproc_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Generic Remote Processor Framework");
-- 
2.39.1.268.g9de2f9a303

