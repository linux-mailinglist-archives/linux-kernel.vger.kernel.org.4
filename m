Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E29469F43D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjBVMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjBVMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:16:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8523A85F;
        Wed, 22 Feb 2023 04:15:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x0Jc001203;
        Wed, 22 Feb 2023 12:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=20YLo72x2r1kZ11zeGXtbizXCF3EJ5azWfd3HBX1HBs=;
 b=0geTMpyf+CzuRIvVriw903vD5yBKMoNU6HoVUUUJM0DYjnQjFefkBZQmGw8n4WvNi3cf
 +QxXVfhzi41ajbq+sFTXWaW75v8kVMg2fBWYPQktSk6nPdHabutgdFbHFvn7TSn5qoj+
 6k8ye1pBbm3KXsEtKxWL0cGoM118IIZdH594MeL0S9TyLAq8IAyZZ3HaI1Cp5fW+BBBk
 +k7vqRl3RSAxn0ehoJCnk45v72wVnZhwrcvotjbMGknsgl4ilxGJyORFv2CYuF8bT7jd
 nSa3m6h8sMaBVL4IuSqJYD4/vJsFzuMx8+tQAvy9YnUQwyBFSG0RXJwXNtV57t4Aj/NS EQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfr9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBPJaw012965;
        Wed, 22 Feb 2023 12:15:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4dtaw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/otk7vfJyG+gYBjoy/1KgFXugZd/ys4YvPUJ6AxDS+o0mIL0NaO/8P5SsxmP/6aLbsIBKZ0/Te/LgfCCxok1IZ6OhBUoVdb7qFuOnLMkTfNugzzQGL/H1vNHLFENu9nzE39FWBrH3Oi08Vp6DeGGbLYrp8vT6pFfiDcbRv9P76lRBp167Q+IuubVOkfWTklCU5A12mL33gUS2K3dOBucgdiCFGHpIuOo38uvx/oxa06fbH3BV4M9nje9YuFvl6doduytb8g5CRWn57amBtAEKY3ALyaGf7crTP5uQise1G1h8/YDQ7Mg9yHxdCDH+Y8sU0vglm9UceSr4m5lOpe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20YLo72x2r1kZ11zeGXtbizXCF3EJ5azWfd3HBX1HBs=;
 b=LYlCKAzKFziP4+MNQeKG5VHx3dnnbOk+aP5FBlIwoh1JK7qy0EHeOMmx5eEMnepXY6dPOX9DQJOZtfXM/IJRMdRmxOG8H4Qz/jDoKZKSxPzwNFZqi8I4MxeA6/7exqZCbHoFkPY607OJHyjJ4uVIsZavoytLIS4hQPOCfBxnuu6SlohGtYvXdvVzLk9G4hpnw85fzdlN8zMJKv3f5fxolHeOQ7N5338g4Jmuo+3hbllYRKWEzQOyLsM1cE7DqKdBtN9Sn9tNKpYdcYBl8cCrg0GhU3stpeYnmhjaQCWllchUdJ07F9gL1wEvmdEXe4ISGV3+0MmgyOkMgGBnDPcjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20YLo72x2r1kZ11zeGXtbizXCF3EJ5azWfd3HBX1HBs=;
 b=0ABc/AZbuK0aaJvTKVZWCuslb5fX7ASF4uM6Ds21uKYzDy9cbQxfGwNuGU3wWJxEU0pMwky8KN8dxF3DDkZdCqayGw8Z3SAU6uqBelfktmu3pnATqe8SjDvPfk9p0PNe27qGxpui4tGR5WSkG9wATM9biFL8sVwrc2msqfOb37Q=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:15:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 03/27] kbuild, KEYS: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:29 +0000
Message-Id: <20230222121453.91915-4-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0407.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f38c5e-1cb2-4e71-f44d-08db14ce770e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWHsegwIf7X3eboXvPEIBY/ciLCgq0V6dcb2V/+BeH0q2nmHEkEl7PInijnWaaTJrN26egdnBVXTD2D23qq1UGH3X94ANbd08mvfVn2BbkqPovuYPZ8HAYx0vxkezlWtn/60x/Oe4af705GbM0s9fY2wOKsjFnzsAcbQr2+br5zNqX7wpDzzPuE3/TmXAq7gUlFZu7gYdZqNKdbprJ7AXBrBJBi6TD3AspLXqP7gLoP4hTqf98wmpUJQ1lyCG/pSQCz+TM6WMMr0VzjYIiCCF7ThFmneyYp+xSeCNwY6qYiDknB1Pys9cC1kbgDXG8nR7dUXQcaBzcZqKC10tV6SMxtyd5AZv5HpLc9leIvimLe6LAtyVfwvbiRpp4UhQSJEzzZldNYafFAEclCNZWjLaY4J2S7cMFj0jrPgUNCl96W4u3BUegj9JFGa6WVmU/nziXjFt388oPWR0b8lygmsJ3GWvM+8hur2THPukDu1/ZZoI/JZJFMmu3dZz2nISgh7D/VAnOhMSNX5DgPaIUch+t8Q0gbOh7f+PxqdFRLhFXtEZO4aAqUYG2AMUs/DtljV1qV6VIfclVEUMtkn+PF2NHk4gQtqRS4Lcg4G5/r+0CyTGp1br+O3p9JmOvS+kGqjJYeD7HIOTTneyvYIoojAIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoNTIsqLJpTHdpSlZeWwsstegh0dYB1860z5h284JYz4BKtzCHzk7+gLcENt?=
 =?us-ascii?Q?b+gUSDXGN0w6x62bMrnsvAdyC+tTXib6x6X73l5Zi6KoW145kG/7NXvGlJcr?=
 =?us-ascii?Q?2dMoIYFS6yvry2IpJY4ONi52DcuzeOgARiNZ5XIKDd3o936xRZTQxWptHWUB?=
 =?us-ascii?Q?ogvlaKoL9PDBa3LPlOVUD72xQfshCSg+DAEX5wHlGlqeQPugIG3J6ZzGwe0I?=
 =?us-ascii?Q?MqOSWg9ZnlQss/FWe8oqDowS6hIDdxrpt2kTbJPatRHNcgNvNvfgy6okRUtQ?=
 =?us-ascii?Q?zLkSbW4xHWM6w6QtUm/B5oj9KVkh38itGooByLxkInZ5Gthth+fviiYsNPwN?=
 =?us-ascii?Q?A56mnMLY72av+ZRzH7p/TdI+zF/dtFzmPV4MbmuJjP7A6dF7p7xMvLleKhH4?=
 =?us-ascii?Q?HBRPvx/3GgZaN9TxZ4btkid7K55ykQ5EAJQZ0jQQoI/kw1hh6Y8wx9U1hV4o?=
 =?us-ascii?Q?l42F5ieY52X+f9cMbJVb1sdB8XME+XoEls+67CVzVfbGvhWMaz/0z7gYW+Ga?=
 =?us-ascii?Q?VeUGEx9OHsWwhBnzMP7ACpVHV2+QCO57UaYHHKJjQX/llnaHM+hSk6e53lCn?=
 =?us-ascii?Q?cWitLlF6gN5Btr22w4/x8SlVD1bUbIDGnN1V5r6SGHfBiTa5NSOECG9Etglh?=
 =?us-ascii?Q?KvmETOLvDYoZZrNroR0dXYtIWIOI0OeDSHaokIEeXHyiagaVkP6cGH488EED?=
 =?us-ascii?Q?f+AfHkNE1iE95Je+5zjnmSaZCPMEKal41AKIu2+Dp0zfiGIQN8HooAFnDEq3?=
 =?us-ascii?Q?YiGo/Nyzhb7fZ2ZaZWFNAVmNtdEJ3qfNCcMOzamy6BIfinSxLOH23x2KPfpF?=
 =?us-ascii?Q?b5zFF3TcWxF3uljN8IVmEc3P8X3QEBm3UKZIFg+X3g+BMrfGVasznmnT8hV7?=
 =?us-ascii?Q?nA9xz6ElgVZMuebSWJ0aIfDnp3IyYA2ZOo/JjXUgAFDniKBRXQ74lEtANGvY?=
 =?us-ascii?Q?+m91VOCK/M1vvPmM+E7oks4tjFtn6m9mYfWBatzrPsp7MDzX3YSJAGFPecbi?=
 =?us-ascii?Q?/SmV7fPaKlr1pgY/PriadkJgz3TX5qSe7nUAKGQyreg/6fdHxkTKMn93QyW3?=
 =?us-ascii?Q?kUZqwu8V9/pYRf1d/FRTyLkfQ0/+FMEQg0nQoQwSmDGIEHklLj6Y/eAN01HX?=
 =?us-ascii?Q?pbJ0XeEfw5wWxrAUJn8Ptt4rq/HsEnownFogEz/imGdeeEclXgC8H7N43noh?=
 =?us-ascii?Q?V6b0yNAtA/+W76pmezH3POkLr0pAg9X9uoByYNjQKr3NdOSORNkFHXoEcksB?=
 =?us-ascii?Q?EFVwN6LsbM+tVe8yON4Clxn5i3EKdtxCUvc6xQcKFq4AVEQv/6k7A1PKab+O?=
 =?us-ascii?Q?5BQPSMPLLzEtHROKZZW/ZZ+gRuYEswuGaqbTADRIPT18a+iCxirFCkcUw/HI?=
 =?us-ascii?Q?uJytILZZSE6Vb312eHYV/zBpJCuRweuyDg7Y91gCxG+no+TdnEZuGyJjRhJk?=
 =?us-ascii?Q?+tuTFYhu4DNKD0T4AEHh7AfURMYTM4mTCxL4EGG00jTKoLYz8rOL1mZv0XgD?=
 =?us-ascii?Q?aJA8VAP2/EYCUQIImbgbFsZTghQCqFbGs0bIUH3UcNapYCMhJ83IseFGHril?=
 =?us-ascii?Q?8sO2h94rSCIe+BqQciODhgm5rCFDCLVVgMxAPEfUTaWPkEBtgjL7hd9JvB8j?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FOeEnxkk6H2QHE9Zih9hCNz8sbSEPd2QqVm7wfUTFR7rad8mopmqtUer2w4k?=
 =?us-ascii?Q?LPW6rkoa+qBU+tAQ9Dke8xHFlkO6peb/d6vzVuTd+egWeojhNYAl8Ts3DPRW?=
 =?us-ascii?Q?IK5Ai/DN4mWG41NWrU5DTPsyXsicD8DCeZ+dHc1orWH5CpLv0055jUFzFWj+?=
 =?us-ascii?Q?VPd4rmWhsZcXdPoOV0reSOsHagGUFqlkLpDWETHAiDx6PxDCjDL6LIpWZs4e?=
 =?us-ascii?Q?D0JL1oUAQzAFIxwT+ydny+CqrlidDd8hubCVpzBA6Ss7vEW9C3mhbIokBDY8?=
 =?us-ascii?Q?dmt7JbTBHAGwiXHUBlcUcW5Hl70FF/LtHZji957/+upWs6zp4yFUg5e62oSG?=
 =?us-ascii?Q?GB2ReU7uqEuc1d2mjfzWpLKas5z7eQjtk37ZJxOvY/sDQySm3JsjiWCcCDLm?=
 =?us-ascii?Q?OpFkEbfo4+oO074X+D9NkgRMdZVBXWsNpUgmnmQfIWcEh39Ww2NFwFPpAs01?=
 =?us-ascii?Q?JjjFp+RI8+PtiqvOztrP7KzeKTVMKhlRdHwwebfAzO56e4F/RxpERRcyYt+g?=
 =?us-ascii?Q?ELX/41U1Au8EF+elei9jMNaTQWyfw3SnIEJ6QNZMURxTxWoEgCBDlFizG/Oy?=
 =?us-ascii?Q?+DyC5BLq4O0cBcl7ttr1l2WWTQrddNUYyjAqdige/XT2P9ggHjPUWmPYIqsk?=
 =?us-ascii?Q?e9n9hI7sf/l8JJn2Mn+KJdBc0GJoTaWGItsM0KgK+VUTthDJfW3gS3R9dFJW?=
 =?us-ascii?Q?OnHzM/GXdNnmgo8ABpLSdbAKx1Q7rMgK9FuOt8yhjlmu6pfKYsi9oXvw5oSW?=
 =?us-ascii?Q?cz2W+r5ZVIN+tLeUC8mttR/iN0jsEDpWhkH3p5trfeFtmknc07+vN289o6ho?=
 =?us-ascii?Q?UJ5/MnEeeo5caAMZ7tZ5lSWruZoYFgzkmKnbLvxwqKSvOCyfu9rgixs2BIwZ?=
 =?us-ascii?Q?jgK0lrJKFZtGuHcGlpYKPt8mV+Mdahd0PzN1mVO4Wk6C4RzDaVCH/o2gDaYR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f38c5e-1cb2-4e71-f44d-08db14ce770e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:19.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFj4YimtZe3NcyXU0Kns1UcmN/PMtfUQd8ghWjnjyaH7IHaeEqLV1rZCjCuyH4YrvnfPquot9NPrLyET5F4Nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220108
X-Proofpoint-GUID: u_Kp6ZgisS9AgGcQxvRNaTFMGWy3XGP5
X-Proofpoint-ORIG-GUID: u_Kp6ZgisS9AgGcQxvRNaTFMGWy3XGP5
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
Cc: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
---
 crypto/asymmetric_keys/asymmetric_type.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 41a2f0eb4ce4..a5da8ccd353e 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -17,7 +17,6 @@
 #include <keys/user-type.h>
 #include "asymmetric_keys.h"
 
-MODULE_LICENSE("GPL");
 
 const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_MODULE_SIGNATURE]		= "mod sig",
-- 
2.39.1.268.g9de2f9a303

