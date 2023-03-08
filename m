Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F586B12E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCHUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCHUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:21:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953DBA872;
        Wed,  8 Mar 2023 12:21:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Jxf0i001674;
        Wed, 8 Mar 2023 20:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ieGin6y2CVdmVHD3w15Bhok25HTzg+iego48Ign4uR8=;
 b=WhibkwgdZToCDksEDhrW11m6O6YptBCSgLvDckBZUoDouei0K8DROilKrbSdHtlDUQWL
 EJxCXSdYxdACig8Gu+mZ8GoVMQqWDqEfUyUbXSrZNj60gLMgE6sYrcBr6hnQ77DKho0H
 3UPSBm3oN9KkCc+umZ4B5wECbmeBV++Vx43vfiE8YwJ1pOpGKf86XaIim3o6pCIPhUUL
 nqbju0jdzj0sfkLomh+dEFUsEhKKIzWWWaeX68Zg0bp267RKrt8+iQchCCKFYZAb0nam
 NTboAsWGgIrHfKo/v4z0y6h1KYnms+Xjm3cSs3I6RYDKevgllR7dcZu9AiZySYc33aQK VA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416ws4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:21:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328J1k6m020822;
        Wed, 8 Mar 2023 20:21:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu8ge6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO15cFOHvle7VLMLAM4oEGLcZ7ufx51a8/Jm4OUsZEKG292Pa6hIljceyAGs5kKx851O4MqpSYRqSPFVW9yt+FRfhxZQcjp9j8FnTWRJUSQ0Q3LujdwqsNDgQhkWazfHXKyoNFePLWKA0pIbEFg7NIl4tX+oFsgj5RlysmHOX+UfiM1UGJqNnOeEpdTX0DrjSF3vpJz3VrdyDc9unF160yUqOCYedMbWrqdAmtokd0bPTgkTSlCd6LlVmRnUefhlJcb64st5PrYJD6uBfh9vR4fjCKYOcKZqawCJyqti7zZM/WoirZu388dyHvPHjTkbt/AUkob37p6KG2KIqIFO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieGin6y2CVdmVHD3w15Bhok25HTzg+iego48Ign4uR8=;
 b=PTywtDeVxiWi1CkUJYLeBE1v73dmxOdVTNSUZ5USiud7BAkFT/nnSR0Pm48Yq4XBkg7cAOJaGS/MIuKK5qNBg3WyxX9S6JOdOhoGGo0/QVqBXhqDB5v/2I1lKiLydCmc7b6PO/oX4vuea45DtTvc+U/TOC/ZBjz+G2C26gIXQbzJKiax9b1Asjc4VCGO1+Tm/Cik7uxdwvNtOKljJOlSwYFx7llVvXudKEA9bwwbc9YOUJFjIg5l3drTAKgZVZoRXsmqd2609OflX5sSHNW5pGZhK/ddq3iDjt5g5VFJAPVs2uOb99hh3+PXxKS+P6UUVN9wh/w9nq7g5e1vdxJcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieGin6y2CVdmVHD3w15Bhok25HTzg+iego48Ign4uR8=;
 b=GUeP9VEB0OMcKG4mRRnAGt4jgjITEqDe8T/xhX4eGMltCMfk6sggH951kXMQng950PHXpBmCDAjouJ3GKc47x+4csAysNG5Rm/Y2pvSG4oLvdFOKxGlHlPP8ezXX55CX31KoSltRo8YiF5KGBiMPOz/cXVmdGHLTYoEoMPdsWZs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 20:21:34 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 20:21:34 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] memory: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 20:21:17 +0000
Message-Id: <20230308202117.426808-2-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308202117.426808-1-nick.alcock@oracle.com>
References: <20230308202117.426808-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 6688102f-6788-45c7-331e-08db2012b61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNfOJ0eqtGkEadMr6BMtpmy30XGH3wBORz3phCOna/8g+czEm7sRSm5iE3cpVMkbrobfP0HQJNNmirZlnaj6o6q5IvDt8Pg9BPbTpcU2q77Yhhua6+hpHzmSYcedoDLSkhu7wfRWKScYEqfzMAGMTxcRx6IQqhJxvMLEPJ1n7A0lUlYInaDg64iEGBJeXnxcJPpXd3dTOq+NtKBDS1DzvAAvDzp8XLwhAiN6SVkwOYK8x5CoAqcSgGhkF/V1TDuCOlodhBKjHmcvV7dQifD+3XxRwCOt1aQqRaRs+Ip+dVCxicL4uyUvqIf6rui25IhY62I525zxknMKcJLdk+rWxRW0OThXu4C6m8AJjKD49gO/h9ASkcZvdj3ezV3+2khcNul3DG2y65xhA1feXbtbh+iht3fJxTZbBZzpiINm68a8kAAjptKprLkp7/GgPlr9S2wByK56wVJ+iFMj7Ysd/GjbeOhLGtiLrb4JRHy4rXf3lJ6EyzEQUXaOD4RDJS5doQdqlpYt8iQuW+mGxwn+Va3ND6NOuZ3rD2rCU7HDOfZGNSVT9NsinuqFgPCc5mctk2Oc3hE6nWb3ugiNVgKuAQ0YpShDbx/uEDZHOjGcESXA1lQ0zBPt6eIn3KRlJFqv02UlyFGnOvRxK8lwn/1LOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(66946007)(66556008)(316002)(54906003)(186003)(2616005)(5660300002)(8676002)(86362001)(8936002)(6916009)(36756003)(4326008)(2906002)(44832011)(41300700001)(1076003)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGPKOy8h+jdMDdbkKQ0twLdq2dsjNa3GnbRBRVLhqgVHCevLNqe32+fCtIYe?=
 =?us-ascii?Q?9q+XBVb7d2HQR2ScWyIcLdTqbyffnUS0NF4bDdl1qWvYoBWw/a4/tcg3of9z?=
 =?us-ascii?Q?gOFpCLbTCydyzmeR5/K36NUVTqU1aamRP3Ix9tSMasJ+JZXtnUQf64z5UN8E?=
 =?us-ascii?Q?1/oJjmJmQX6pkusK73OuM81NNyrCGf/a1UXI3As7+86yhxEhkM9Bi+72CnJB?=
 =?us-ascii?Q?wOcok0JgipNzLP+GDEIPo+Ssh23FCPgNmt6xL8HORZk1jLj+sViN1ANVtokB?=
 =?us-ascii?Q?pEwh2eY8QLF7vfZOGlaKFKTclGCKpoArk3X320BydTpa0X8/kTEqrZ2LR05L?=
 =?us-ascii?Q?zS2OZiM34RcTUCieuJDf9f7MTXQ8yr1b/APq2BkjpFxlwV9Bco5neaCnCDut?=
 =?us-ascii?Q?ggieO2iAD5OiE4QbSV/JYwuYmxqPeKz7++19ImNX3RHoqoT3P3IdLKif1vx9?=
 =?us-ascii?Q?VbtCnT8OCk4aLB9Knnjbc/gkWshXfNLNP3zu5e8BHtAB1j3V31jT8M6X7aUw?=
 =?us-ascii?Q?WaNHDFIMuKU7eQu8Mf8z0KY1uA3yHUhG7HEhKJhRae8t5a8gBlhg2vAESzDh?=
 =?us-ascii?Q?fcIbRZsY06c9SMSc+n9MJgI6EF9Bv9I3Ad6dFMPVdj0TqxEeaV0uXZ+s2KJq?=
 =?us-ascii?Q?kdSlwVX2puKEnpa6CEPEASGLtzJbQXhI3cQ8Sbt9mRu8Mh9Kg6j0BX0okSQ3?=
 =?us-ascii?Q?LKbWD0J9NeVi8+OoUVn51oUM7PsNxSIXQAzDOfWwa9uLgdBwFBxOuYa+WV/n?=
 =?us-ascii?Q?p/XD+CuYEXOUfGhG1KPxMJ/ZTituzneld9Biscv8gA/zOwxtipaXZBLnAqKB?=
 =?us-ascii?Q?0reZyej4YdkS1Oko7tJmoYD1qCnmq9mUbKsXhTQGCXkMlx1PBm7axFooiypR?=
 =?us-ascii?Q?R6R3zunR4Ja685HNIwZJ5Zo5pRv736NXVNZGG4/yFxHfdA3Qa1fmg/dohcEG?=
 =?us-ascii?Q?TgUxFuETdjRuDcM0TkXf05lO0ED5/uHocr1qUt9ut4RC0ZIETUAmhXvPBGts?=
 =?us-ascii?Q?h7FNBgMmwTgoK38aie2QLmf6XezlS5XpxUulG5WAsn0RYqlJFAzTu7rx5jCJ?=
 =?us-ascii?Q?MJkNZanOySS6YuT+PeXyD+4KBYScA/9lJkrfhA1QnYWoUedpcHHgdyfEUQph?=
 =?us-ascii?Q?cGyD5lufzrwRqVfwP3DO461H4v0GNnEmeOUsFH1c/BnIY0LKAvZu+Qu2fX/H?=
 =?us-ascii?Q?z4SoirIoOw2nbgNmLtbH4wGdenlk3P/z6hRxOTGlXMf7BQ/+r981yYsn0JPH?=
 =?us-ascii?Q?7pMedjyoFiL52EGS/cET32mXnPKrvmlcmWy/TkVw6aTlfrZOu9+LUoZhVikP?=
 =?us-ascii?Q?j9gCgqqd016jI3Ml39pOecya3bjMHFabAfGqM8T2sd+m44Lbi+8ICRUacwuX?=
 =?us-ascii?Q?2a2O5zyuKmcuAVhXDzITkX48SmMVJi+9Oi2vNamirGlrc7+28dLHJRAHQ55C?=
 =?us-ascii?Q?gF7lSEpoctsHmURW30zuSTAifw0KDzJrQ3rdnso6Pm6NLHFY0k7s5e3jvOR8?=
 =?us-ascii?Q?taAtZ0hy5EVuugEe5lA6g9apYvuEkX+fFZb/WNYWroTo7Ijf9Tio5OZS+XFS?=
 =?us-ascii?Q?bt3WG7tIBgJIA6BkCjuT0wUR8WNzfM/1U0K8k2nIE8HPM89mGs/ZohRMJiLj?=
 =?us-ascii?Q?18kQB33UZzcEobk4uZASSaE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MxGqYYgFCgmQksQ8A6UrX5yH2AI0uYw1kibGy6ZTsXnHNOoWOcVcAVUM+tAb3ji76lZHWS6Kiu9krOtDZ6Gor8dQxg7n5PBoY+Fr3uHzrr7+PVWoGXYkRTab+U6F63ek20ygT7LoAJvVlPNs9B28cfE1KRIyjMvG4Etk+tg/ry3N1bMJE/X4929PondhC6oexUrshAkxpcAohkgXDWJGMv61fq+/RZfsF3gweP6Rk2ahacl1q0w1mw5tM7Dgzf43mIi23cA672uYG71QeWiJzRdFtRlfqRVXlK+lJIUHUQqd8fZsnvd1AhK8BhufjlMc1um+rcek2rlZhtEgl3DSrPASI6mzK8XwAPTRKCjK3wuqQbmPSspr51i3TN+P06rgRyTJy2T0OHqnypLTTX4IZ7awvTAYPB3rVXu1xPtmIji3lYy43DtfYIlBttbvE3wGDfIjqQfTnS9zBtzfivy6MGnxWR9AWcj1XmifIHGaZ/G0QXFj17G8mzoXrpW7t1htpqo4UBpV7pBFkY6Kyusrh+0+1AuHF0Upjh5DbBN6rQ4/FczHdfOmPqQ5f0/0iZQYDatU/YzzO+JkYCUHmWl+E7fRlLFVqUf5lFItZKC3M9OkCeNlrvwALTuIKNWTTJqagwqZndkx9ef5bjoHXp+yGHQ9VOpA+J0WGSvnZSD9tu4+RoshuMb0PhNyJ5DvDr7VHyyJKs7ZXUtBjD4NHJ+h41hGnTHrMLCYNVWPxlfUopGNvshiPoGkpWvxvgKUAub02hMyOYhqdZ0ABzX/wWvKIOuhfHYmyYLMf9QuUqxyxTYj9y6QuUWykfkfSCGiTzprQ+xwlQ2hi0DaLknrfOv0mkXgdqHuSc+J/nj51wKhfnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6688102f-6788-45c7-331e-08db2012b61b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:21:34.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5dn0dm/EzMA95BQE47w5EhJ2Lo7kx0L0+/hPvM3lv5fAGQVivWhnVwiTBnzf9+reBrbAGPzDqRKVDnJ+hhMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080170
X-Proofpoint-GUID: pX2NsVhaa3t8cnjvM2C348Qlj0XMzaXc
X-Proofpoint-ORIG-GUID: pX2NsVhaa3t8cnjvM2C348Qlj0XMzaXc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e3 ("kbuild: create modules.builtin without
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/bt1-l2-ctl.c   | 1 -
 drivers/memory/da8xx-ddrctl.c | 1 -
 drivers/memory/fsl_ifc.c      | 1 -
 drivers/memory/mvebu-devbus.c | 1 -
 4 files changed, 4 deletions(-)

checkpatch-clean now.  (Commits for other subsystems not adjusted,
for the sake of not clashing with things that have already got
upstream.)

diff --git a/drivers/memory/bt1-l2-ctl.c b/drivers/memory/bt1-l2-ctl.c
index 85965fa26e0bb..78bd71b203f2d 100644
--- a/drivers/memory/bt1-l2-ctl.c
+++ b/drivers/memory/bt1-l2-ctl.c
@@ -321,4 +321,3 @@ module_platform_driver(l2_ctl_driver);
 
 MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
 MODULE_DESCRIPTION("Baikal-T1 L2-cache driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index b32005bf269cb..0ef8cc878b95c 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -164,4 +164,3 @@ module_platform_driver(da8xx_ddrctl_driver);
 
 MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
 MODULE_DESCRIPTION("TI da8xx DDR2/mDDR controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index e83b61c925a4f..9e8d8e9c5ad86 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -327,6 +327,5 @@ static int __init fsl_ifc_init(void)
 }
 subsys_initcall(fsl_ifc_init);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Freescale Semiconductor");
 MODULE_DESCRIPTION("Freescale Integrated Flash Controller driver");
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index efc6c08db2b70..406fddcdba02a 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -341,6 +341,5 @@ static int __init mvebu_devbus_init(void)
 }
 module_init(mvebu_devbus_init);
 
-MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU SoC Device Bus controller");
-- 
2.39.1.268.g9de2f9a303

