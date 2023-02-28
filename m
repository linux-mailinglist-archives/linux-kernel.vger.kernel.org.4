Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBCD6A59BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjB1NDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjB1NDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:03:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8601E9EC4;
        Tue, 28 Feb 2023 05:02:56 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6B47w025751;
        Tue, 28 Feb 2023 13:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EiQzN1+idjptzTctEtx31B7WgJMmRbrDqBvzAtVQGL0=;
 b=LNtoe2f0slmkMoZ+KgtiquVi81rusHtA2qVsQDZ53X1d5PMRUf5Z6yEwCi1GpZvVOgil
 xSroBsEL5mG6T1N1EZV7zp++rZRaonvFnYi92yOGZKlyaj/Em/VGAxYiMOFilOw/ssiF
 hu8bogFpSufdv3DbkFsFpOLHB1PSQt+OpKFX3dJXP+DctkqFRiazE7Fkb2tYF9o+ylIS
 ItBwnPR6Qta4NP9B2Z4F2prAU/wLmlBOWXWCRk2/9rLcbihu5500tj70S+ixmQcgeT+T
 ENxbZOVdNxwVmlEjS489xeJPt2IgAC55VrVv69jgs12l2HpSWmv/U9/WgIUZTVei1h7P bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wp4c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SCCXbF015940;
        Tue, 28 Feb 2023 13:02:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s71mx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 13:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfukdAijoMiorqDOPTjBegtbIeMr8bcs3Z/748+oNlnGhQBZtvl5R+qTvAxrsC9iodQj47y4Zo29MBEDNQVv08PydAA9fYy/sfHBZB+NiaMOhMWhK76K8/82mB46TexYscyxrhIqwuflqmLQuYzlYwgWPs15Wy/nav3PvaQIc1+iBJ1hZ1621e+VHj73ZDYKaeKVkfFLIgpDKlDgTBlgQYUeSEYz9i5xKb00U7yY9JlovEso+mEX6awVBM+yQooPWYbv61GqaEebCo/J6uueL2KKGJ8bN1t8SuBE7ne9FFFs9n+LpMmBnP9JUOhYWcLo6413X2asfuZduWLbf04v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiQzN1+idjptzTctEtx31B7WgJMmRbrDqBvzAtVQGL0=;
 b=LdWck4AOpSZn81i6MuNaWq930veaFEhVEUZBel2Wb4WtkQuMf2+sGucU/yfVdzXhVTls/sYlzRbJWjqdGGhtZGHUdGVKXfx+KSkCOnQtIhtObgbE8sli6jghBcDp2aE3c7jDsjML21O0MK9zaRzQCbjX9OZGkKrfjzubDc7SQL8iXo4k8Se0OEynYsMoPE2KHDIwN3GyL4/yPgH8zzzt2SPMYljElnR8sB/w5RQQzPPlgzTyn8tGRCHRno6pLmTSkuDyl2+2ZcCz6Fla77mLNv7LABVn8uuDrsnXjv/eeK6wLX8A42sgjJYjViF+0ulepmrYgi0jEx2fUhqCQLAuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiQzN1+idjptzTctEtx31B7WgJMmRbrDqBvzAtVQGL0=;
 b=qsHNdOAZ5rUIDXs+Rw9+L/7ZeqHYpa4icll4Mg5TQIDPP9hqUa42G2ccr5jdhrLlAQT+PBVEz36Wd/l1/qHHBtjSbxwXq7++JXi7sK5WH0KP1oOMA71HpciNk2G5I4CTZ+1HkjQZ7erMHAm5Yfn1FPQvxQa4/dkBqzx+OUgEpnM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 13:02:48 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 13:02:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 05/20] lib: remove MODULE_LICENSE in non-modules
Date:   Tue, 28 Feb 2023 13:02:00 +0000
Message-Id: <20230228130215.289081-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f22975d-53bd-48f3-8c68-08db198c170f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+4WEGunIwaKROeHyIoiyy4GuPGZajnMBV+amHcA3+zqm6xQfzbuR+1UyCm7IZZ8TtU1mA1S/BBiBvKzy+ic3uVlfRRUl/whLt0kOtz5ztlFQFXpMIYKTL32uBJIhyDOdM+Qs0eEHjaDJb8IxyYDVuZIX20L/aBAtEq53uStz4kM31f9qwZXrN0dt7Wrb/FEskrndtNwHfwJ+0jROAjJuYsL3s8KwAiBBjUFHmEhA3A7iHhGXeFW00HdE+gotrvVjs7tmjmSPqFNVpkPm/WE2tGuoUAhLgp+p3HBtm5WXYVIMcTZu+buz9n9Do/XIWgH1QcxqHukb/wv1optw4QJR3HyiHw9jY1DB30VpenLGffp2g1zCeS1DcW29NGmDYDA5BlHvx9TgFr1Ad6jwVLZrtCu+aEwGFuJRGkJUG/XhHTO1uXb4HzYUx7vJIlc1BqOt7JY8XGjR3gxGzr982ZPZgo/8B8dnmzGpMwD/QJwNeaM941RsLY9Yi9gv3lUnElwDfe7/WiJCRtJSEpUMeOOuxIKFO2Ig/SQGZX0jCXOmv+C9bY84KGQZugO80tA45RVSFMUIm8l9u1xlQdVEWskRGN63wZwkUFPBAxzyCTlbR6i0Vz7YK1wVjJYR9eeZ99MuCusog6WyZW6dFSsp4kn6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(66946007)(6506007)(66476007)(66556008)(6666004)(316002)(6512007)(1076003)(186003)(54906003)(2906002)(478600001)(86362001)(6486002)(36756003)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(8676002)(6916009)(4326008)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SW0bdG5Dovay2Xxob+85cFMJ4ArhYYgaMVxqpPO7l2NfsW9IxrxER3pjcodw?=
 =?us-ascii?Q?HDEYI4IQ0L/emHcmHSn3/A+i9AJad6oe1XwSjXv3ANShQZjH9opGbwQzTpAe?=
 =?us-ascii?Q?egRDrQaNVr9xSmAAMHibHN+7WijzrEhojynCqgj5C1d86qkNKCCbd7vdkhuu?=
 =?us-ascii?Q?ng8nZ7T/YrEEqkn9OOOTkVez252NFWHXABgtpK0YgM6GuRlmarcKRHYPs69m?=
 =?us-ascii?Q?mV8KPLpxTgatMccAW5iFknauSQwLGtd1An/Ggu9fHTEXJumkwPEJ3lv5kPbF?=
 =?us-ascii?Q?s5CYREgNKjpNMTROn/LzPcf5JMG7srj8MRFxpggFflxluV/tZkr62LUw0Vp9?=
 =?us-ascii?Q?0S9iZ8sAkHZUf+Bw1nTZ9VATE81lde/3zNo54ZwsFEAbyUWn0S6My3M92N92?=
 =?us-ascii?Q?8nojhTrS9p92jiAtkIQZMNaF2hTc+IWB1a34ICUcNaotRr7y2W+vEBF7xIqJ?=
 =?us-ascii?Q?1VbJH3Lv4xpWXBVg6Fk0T3E88NylteDMqeGzJCJu0LeBDNywifNRRss25Jd4?=
 =?us-ascii?Q?trK5d+zw9DGHD4s+qnXhuU9P1ytbaXBoz+BmPhG93B8wv4ZQUd6EvHzCxfRV?=
 =?us-ascii?Q?nNVjj5o582efW7C0/p6VGMkWBq7HClxsg1KaC4NZ919U8YyvFoHUDM5+wrD+?=
 =?us-ascii?Q?MaKDLFbNJkqBTTLgkF+6i8nislx4+iOcTYG75VVF/VkGIhSCdxNHRR8Ct2ww?=
 =?us-ascii?Q?NUdqI+DuJF22crrXFvM/thwVVjVM9KB0LQaHNlMt5pZhSv6d1vOTaTDmqC/2?=
 =?us-ascii?Q?m7OVGlMv1y8Y4NLF3rDT8cyPhJDPvvnTI6uy+9eu8XCx3vxfEEw+QUniazJq?=
 =?us-ascii?Q?nGMoe7kqBawjh2vqPtJItLfVRuFZh40fDaN0bUJREfby4uzDJXQL+ERdXzHd?=
 =?us-ascii?Q?H8Gxlp2Wkxhyw+q5KgAbRgKluVTZTv4kAj+jnUE87o2cqnF7QlLfaErejqU3?=
 =?us-ascii?Q?2rzeAJCw93pxDaAHBMAfoge4fxOBlN1L+utdDYcN2AVZcwQSYgdtWK0dbbG1?=
 =?us-ascii?Q?j2KMQ906k0kuMkfrFXa3TUHTIrIgFkBE7sCskHWggn9X1HoqENipDQaC1B5w?=
 =?us-ascii?Q?CrKDf2+m5VYtZkBRnfFJ4keEH7hMctyxsdLZCT+g2ItJAXncQa40QC89k671?=
 =?us-ascii?Q?DfZuaRzal7N8GIfk3S1i9z7aMZVjFVxloogse4KuEymZW3avz6QoFVVC+x4B?=
 =?us-ascii?Q?+QYu6bQW9gfkNDYpVEqoAcuS6gI+w7GuIUpL+dHTwAmrvWRqip0CzVACkoWi?=
 =?us-ascii?Q?ObSpT8bqqMDi5GTv0GoZ3/Z2j9mvqyJjEI+kcqxYzJDQ5hm7oGGl3AxdEjL4?=
 =?us-ascii?Q?vvuZ9V/IC7+EDwtCToguW17bbnsVbIuvfYhDjqDFh0m45MojxsCf0ed7kYKn?=
 =?us-ascii?Q?Iw09eb74rF3/2AYj5AS+UBmEjmVk2AGHvYZn3DI6CwfJX+rroSX0jJzRs8us?=
 =?us-ascii?Q?yXqQxaIY2BJWRy7yR+YnHGTX/S0WQdaF084+QBlRGYM3Zpxh27b9wn+WRGUI?=
 =?us-ascii?Q?rDuKzcHkE/y3SqyG/qQesmFGmx2bFH3VhbjpnV0ZWvIqECk/xP/YlTR8WPoS?=
 =?us-ascii?Q?zXzjm9dl9VtylhBG6SIeQACiefoc0OF+wFoz9b1Vos+LuPCCFZel905wVbNr?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WuP1eCxWNZQqUhCCbir3H3Fabap2R6FR178eGrbEr48GNWLQxj98h3wBQJxE9r21oEu5qzvN2kBvUR3PN6DCNWTNKj4ACOJCKwnVGCPIjjDMa8u+xd8w/iG6dPI/o3NuqoBHrg/m+zW1+nKYWqODmLVug0oG1d4mVeAAtF0WNaGP78kf9MbgLobv7riibMlLcMU6ZmmsPnjm4XaAnhHfCL5svV81x5H363UWfQK5XlXFvRs9o96Iq9PhB1eoKmQ0r9A4NSQzkZ1cwq8yg94bCe5IPuBN+PbaiJWQYHrezhbkzQSz8jKiFGdd4VWTaJqFp56BdZy9AZUKFAlQxK8UzaEjNJAMawhiaFBDligoH664zf7gDY308KJyUKn73xaF63p6boQCaH0S4JBsHJs+R2INP5RVoUVv1Rdhf07DJ5uFEWrDZK0S1BZ4cOeBhOCmKoTWbk8gI0vC55z9fymEb4aqkuzsufbnzPWsRKsSWu0aQhhIXUxLaHOaQ/R7ifakEUHyI00p/jxIdBbg6CRTFtYulhv75GmHJ+ht6UfwG4xE40r6trYP1ZsD6CvPMfzFUoVWcd3WD/+FH0Avi3trSQ2EniYa6MOD+YLjVl7ZiMPnZpRopePOHiEXYY0JDkmc722InofYRmva2XEOTWwLqoB4kMT1D6LFs2h+e7LZE83B0MmPTWrDQhE+vOZS0JF4GS8pvXTTK0hrr3DoVIVzZWVcaXfWN51RvXYS3pX7vW28wkqyuCW6oRmtksj0/xpt+CQZHN2XOLKbQOhL2Qfun86zBBxveHNpWuSg1OWNHIWTB8vYdpivZZO5WNj34enLEGDIedfP7eySRMX9qhvdRW9U6+GbuXYIjKW012Ni2l0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f22975d-53bd-48f3-8c68-08db198c170f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:02:47.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIU79qMNiqUUjaV4R2xXkUf05Rt3uW9dBDHwlA3OHfXJcNfY4hdu16n+9vERlx5kuQ7JGSt3Zv2R5YP9uJtd5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_09,2023-02-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280105
X-Proofpoint-GUID: py97dq2b9CyoC3RE0Pihjto8KlB45WnR
X-Proofpoint-ORIG-GUID: py97dq2b9CyoC3RE0Pihjto8KlB45WnR
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
Cc: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/pldmfw/pldmfw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e77eb6d8e72e..54e1809a38fd9 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -875,5 +875,4 @@ int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw)
 EXPORT_SYMBOL(pldmfw_flash_image);
 
 MODULE_AUTHOR("Jacob Keller <jacob.e.keller@intel.com>");
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("PLDM firmware flash update library");
-- 
2.39.1.268.g9de2f9a303

