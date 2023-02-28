Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B56A59CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjB1NGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjB1NGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:06:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB39F2B2A9;
        Tue, 28 Feb 2023 05:05:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S5sKxm010726;
        Tue, 28 Feb 2023 13:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CIVTfAFGn5HUXVmasHBvfbZs2Qds44YyqnqNSJz9+jU=;
 b=Cd7JctBP/KRNfCm+7KBHN65WwTZsopdlrlcfH5Cg6MWAwrS4k0/Kuy1mZkBxq8DRDXNp
 bmdpfmpfgEHwat4KbmHQFRtSq3oPzLjNfQdXn6TAio0uLfxzPu6oj/IIsjix+Sx5Yq2M
 bcK7Cvl21Egji9oRdDpNgX+hqMHMtkDa41rNIXg4jabIA/cPBK5XLawJrG4kecNkU3dm
 Ivnp9KN9jXcFhSKO0kokhc9pfJIarYUoAkyMsTb3GiR5l9wBVL2alDkZ57SH+keasMI1
 tsyjmOrfUKn9V79Uj0eQWSnv0XzNFfbC/9nzpIZXGeOsG8+vjIBrXuuLwioZq64aZwuI YQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6ee61b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SBontM015946;
        Tue, 28 Feb 2023 13:03:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71nss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSNjlTJId6CKGrcQT72rj5hCgiuS59cnlq0HhwPA/zPwwIGSmaGaWDljTqApwR0kKgsjhYMJetAEQPSOks9Q93xFs5vlVPn7cyscOVCihRfk1bfM9F+s3S6EXX+4vdcThidF34fSza4XJ0mw3vY53mIZw6FFi4oiOX+JysyHtp0J4m91YfNMLMwKsKyAWkt6v4M2mMyxShFSms0o9I0W6h8QMlj0tj8EwyoAgM931t20CHCASTgUNxNfkJqIf/PRO8a+jgPxqwym3j7Y6eZv1uAgUWDesz0myPAsr075p7Zwtk6+VEGSnooBkrICfKJGSJCFD4yDs9UHMqCR2kBcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIVTfAFGn5HUXVmasHBvfbZs2Qds44YyqnqNSJz9+jU=;
 b=VOeVoP4wjsB23/EPkIgywVp1/wEvnKZrBR3T+B2lViNLRA/eHfMtR6ZLOwRfeKxbPGr4iYQKMRoyyS9pPYqxko3z4Vl8AK7P17EJWDIFV9Peyx9oqZXTqJxy8bYYhkVpQ39ovHl4wYmQMoMTC/5XseccU5TeNBL/7FHBDRqnU5zNQeaFMJo7vRYdWPoIUZzdenpVcPcS3KJssMBq6XX/VXyliC+zrxNDr6jE0m4N4FL0lpI+wsWoBz1kcsDnePIyritMc1149raUrEsUX/USOtqDJ7QuZDDUWRQA6r5uttFsmzaocvjUq+stPsJKLdZUcMFgqwUsT8bH+de9PgnidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIVTfAFGn5HUXVmasHBvfbZs2Qds44YyqnqNSJz9+jU=;
 b=CKLCfi6BY8H39zHUPv6bf8ERUFZlpy5se+akbVplKUyCuy91Br/+Sz68D+7ofeqYmTpP2yqfn1F4j1ut9Cbao0VgZTjU36KW4bgT4mLXmojFc+HkIa2AXYH0QxHLFDo8TBz8PeynsDdM/mIb/mE7RS6h2NQR0oRVDP1cd294uKw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:03:24 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:03:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 13/20] reset: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:08 +0000
Message-Id: <20230228130215.289081-14-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 74385189-1469-421b-0654-08db198c2d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny8hCTdmROxmGUGysPA6qTo8smQT9TiRSmP3sOAHYSpGwYSMk3/vIO4JSaZNWqARqfIyipiZWGWeZ0kVdBkHRYxmrzhEnFIc+82Zrk69DakrkWUnH7LqWAa53JGLLWwAoPbjRu99n6QdKa0JL6AuxNYqgGO24+KTAAuvZskhaygzF0gqinVU9ZPz7ex38k0b/toCInijdr8mI8RXngt37t4kKwnYCLn+u6TyUcoek5awgW/3+vsk8qb9Vp5TQj1bG9FBT0x20Sj55pcm8KetP3cooiFWnSweoEum3C3BDpsrhBLyEGSPSl0XN9nFQwFgCry8FYU5rfvrNiZ9gj18gguTx52Vz/A3URhjn/98tGt00MbFrpLP/IViN37jPfam99Bazz4Y+0D8WMU4cA52bp538jG9VlgQEMmPjyM/QxCJH2vJKNNcvy1q0fUPNZO2QRf/B6x0K9ICJtIyWp+HoVy+p4Gz7MHaqTfHKM1mF5C/7uexXGXGu413QSgwNzmO3d1Unh4RABPsCO2onn780jbyMdeE9KtJfifLR/8ROpdhG6Uo1xurQ3EGXdQswiyPT5JC9zegdY+vjefZgI2glv0Lgtw5fV8MmByU8yHdZzCjmGtcbw0sm7I6cmDEiaxLhrZ8/1UNGkxIPxooAak5IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lH3jhIos+PtSNKZwabMaJHXPurXet3zi/dOXOIw3KpCR23B6t3QoBxFTF3nd?=
 =?us-ascii?Q?bTouduQ1MoZETIB3LMO4lWjN0aON2pXz8N2nLkDn7VjQb969QttpAGC/HQpD?=
 =?us-ascii?Q?zVVEvk+ULuQKFtum8kpfsDleO6OD4Ig7OQNsJQB/mVCN0gjyudBPLfN18kGJ?=
 =?us-ascii?Q?Kia9fFnAZuGdO+F5oFBoi5TSke6tFZ9m48UHgfpKz8M7eIPZsU2dz0lp1pl0?=
 =?us-ascii?Q?c/ZNipwwJuhluX+lOFxIGnH5z+S4Zo104DyMX+LzpJS1L6Nmxqg7qDoygUrr?=
 =?us-ascii?Q?HuULe0QxfCysR1DxhgRHJ2arH20zLm11450Vu5lwwATbimOcmEVVLpUe6Rpa?=
 =?us-ascii?Q?xkTktUFsMjH5sm9+mvS27bzq9s38gkBjYgNITbiEsrI237vnrcuQYQwvhM7U?=
 =?us-ascii?Q?d4C1EvjRvrOmxnAJTuwvxtkMl2zMSjgvRoAwHln5HKeSQPuZ51TM4dGlnqaK?=
 =?us-ascii?Q?i9g+kFKeoCC2u1bdL4KxnUsCeP+8MAoJqv06j7Vovb9wsUL/Nn/HzE6n384t?=
 =?us-ascii?Q?GaMM5kVpep9REAQFGoX+AOThEgkaBC5W6ToIOh15mnk9QbEvs+RnipYWgunk?=
 =?us-ascii?Q?y6qD8F1cMxq+bsWBfyQPBU3TXh6jdKcUpfgm6ZDRcmqM2kl7+1vLvIgROdMO?=
 =?us-ascii?Q?MBIl/Izl0L5cI4Uc4MeuvRH88rvc+wXHHtZL1MUc1KZBYxKxIuOqlAQn3XCl?=
 =?us-ascii?Q?FKrxn51mGb3AKCAdoMElHYCastTDaGOClWMtklbtzHhH45Ha0XP0tV1sikYT?=
 =?us-ascii?Q?zkHavDwNTCdaI7fS+1xTnK0wtAzHLLGUsXL7kuRkxwCJ2WR3bzbFhBgUbEt1?=
 =?us-ascii?Q?PGrqtTLK09Ke5UNP6WHdQtnbRA6qJhyK5Z+Y53jMVaZ6DDbN4qw0BuP9MlIQ?=
 =?us-ascii?Q?GuFN9WSm6nOY5L18E8GWk6gxxMKVYiIx/6W1oSPHLj0H7G4c+SIvKYppHxJe?=
 =?us-ascii?Q?E4h09aV3NTsMFGE3IOP4cyUz3yXG+wtfcmo5XnC+BZWotByYs8mpymrjZkUf?=
 =?us-ascii?Q?n5IATyrMOdqqPaD9nc371yMAl2OIEych142y9t20JMFCM6qYDQxHBNqpZ9D6?=
 =?us-ascii?Q?vr+mmywkpzRoYFNaDpEaS80zV83Xz33RLb0eXOpw4R3pPuugYMWiWCBSnS3o?=
 =?us-ascii?Q?dvs/yKCKedaW8Ielz/A74/LP0SLAZ2SuPNouA2wEU0ZzzmY3Jo8DLyrKsIUD?=
 =?us-ascii?Q?AW4DX9h+iWDK9RLLVk+haUCcoKjqaL6iAYHy+zbH/G3E/t7fi7zepr+BNTiI?=
 =?us-ascii?Q?2A8LGRWA/atMsbcWOPxQ9EI8ZW/UTfLVNmwxgF9+4E9M+sv8XDPdDVQpL9LH?=
 =?us-ascii?Q?34+Al3G+Vdx8eHvJOkM0xL130o1Dys3l9cY7YdUKAmFOvhu3T+v4Jp6F8Wuh?=
 =?us-ascii?Q?ZQnxHQhVwo4gB5Aw5dHJmQ0wRwKdnefCvKj+9t2DuH143FLT/C5t2us1crqP?=
 =?us-ascii?Q?WBcB7/z+LzkQ9mOl6cI+bXvtIDjM7aLD295FstaBuKcIkBjVfpYS9uzyHJOp?=
 =?us-ascii?Q?Bk8f66ZrChqK8O4v3rroUGti6Y78wPZMCQDl4V2Fk/3JhrzR9M53EhaKknxh?=
 =?us-ascii?Q?pZcl2kwV1mG+grhQAwooBFMUUtivU/y6KSDANhcPt40v6XNzMK/q9LJUGtjd?=
 =?us-ascii?Q?oLGyEorC4fkW8jISzvbf2hI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?XgAzMZSpEQ44sy6Rc1EcKtwsYT0nwWfX9Qo7elhXqQAQsA8+RljqiVq569iz?=
 =?us-ascii?Q?q+LzINbSJYQNa6PItd5wCs1sraecMbj9dr7tZyeKO7eVNqdmmQHyDwuSiIw9?=
 =?us-ascii?Q?96YmtR5zAGYegKxhdpfCicXeDEVkUL7UZckaPq7ArWuKlbLzPp/benkztl/D?=
 =?us-ascii?Q?n2TrUjo+O3gctzJ95a1QMjXaDvz8sJE+qwhCToxSzCbVCFJHrNBnJ/gQEVHm?=
 =?us-ascii?Q?KKt2EK0yL5YzrlPEQlA6LT+xqkZY+08hHEyBMryMjKJppe1f17bgs5PlX1O7?=
 =?us-ascii?Q?5c3rPS8RF7sQEJTXixGuZu43slRn89LhPXyaKacZ68RAIzu5JynNEW5y/PXA?=
 =?us-ascii?Q?ysfwzeMjm4HEfdyIHVgjZuHSV9oA5L5D4Fzwa9Unv/zHEybzyp3+XxBqCmaA?=
 =?us-ascii?Q?6v0n2sv1ujThpeEjgKBjZYTnAG/Lt4cF4vkayg1DZXv7MJzt6jL4rNqB0KaW?=
 =?us-ascii?Q?lXHFYrRKCu5hN4sy8ymfrx5tM/WAp9wpyhKpvWUAGvAy/A7grTMxp5nDicrW?=
 =?us-ascii?Q?QlO/OOs3BIEOAciwsbCSlhDdnA+Ps8019WOjxsCGWwGYeE3KYehAeG96Ryeo?=
 =?us-ascii?Q?UZb+9iHHsy9w5+gJ/jqgjB66iLsDevwIgbb1/tBzT1pJnW6dVMIa/6ZDKO5d?=
 =?us-ascii?Q?7/6qUSMeoCvm7nhL+UTKSLMFVCGeInqEWsXwYDukGxa3dNHIlmQGEgLzUecf?=
 =?us-ascii?Q?RHpvEuCEBGUK3vpDFPqOzeBB8zNTF0NyZVWSnYFtqwrV6e92ytGLJlVNUt5j?=
 =?us-ascii?Q?Mocvb+Ms7ivruGWrOn5wk697uVRmAIYoLxChu4CHWC2TJDy6KkRPKFAJllq/?=
 =?us-ascii?Q?qvTky1YLbPLMrcSnO9mKz/tz20jquVCHrOOZYBhIh912ka6akmQDPXx4N0is?=
 =?us-ascii?Q?T927Z9tOSWGTn2jv/9qtYpevDz3ReSmEBnphj2Bzk6vKN6qEHPA2tD03ugZn?=
 =?us-ascii?Q?pXxXDIiI2lcBoUo1kNUIYw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74385189-1469-421b-0654-08db198c2d08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:03:24.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbwYMmeXjJh0yJ07ALBNe31FCJa+DamuEwn7xCV/8nm4LMN0lcfpJf/m5AL/dNrJj1VJ+9jcftLiMRD35UPGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280106
X-Proofpoint-ORIG-GUID: lP6NQNftXvaEzce6zQ-HYUC-daaksPOC
X-Proofpoint-GUID: lP6NQNftXvaEzce6zQ-HYUC-daaksPOC
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
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-riscv@lists.infradead.org
---
 drivers/reset/reset-mpfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index e003e50590ec5..e71ab73092abd 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -153,5 +153,4 @@ module_auxiliary_driver(mpfs_reset_driver);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(MCHP_CLK_MPFS);
-- 
2.39.1.268.g9de2f9a303

