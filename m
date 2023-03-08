Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957546B124C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCHTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCHTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B12EA0B2D;
        Wed,  8 Mar 2023 11:44:01 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiWKd009734;
        Wed, 8 Mar 2023 19:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=P9Zo8JNQmFWs5wD6b/cDMNk+OpO+b+eGn+nx7ahwq6k=;
 b=BL5vR/ZT2UJ8MJCMD7oQcC74xhyOmhKDAgWHE74NQqPXHAudIFU3RvYycHvdfMdkWBkx
 SIVTfOhc6MUkJLpOMjAZdlkxyIQMWYrbHC9gqLK/kKlS4yJckLqI5MmiJq5RKrmlwlwT
 cbxLk8hBCWh4kT1uv2Vjoa1go4xzHhQsf50masR4hsucfN3JCF6g90V0KXmw8UVIz1D/
 +lquWylbcC4nBgiulMyHtrDBSUjAuRqN3rMSBCsorrb7iqs35FdbyAX+zwulN8MJFiFB
 iOVpRcAXTbSzmFvYYQAUuZk/TGx915crM1oJJo+b+vpNuDGrrWeA64q1pOsCyXt7CbCj RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p5nn95cd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328I7MfL026693;
        Wed, 8 Mar 2023 19:43:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9u660a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1sBMGP+UEgG2Y1VADis4mE+0mVNTpjUIDqXp2e9RFw300uauUfJ8LZSTtVOryqlcSVdyJR3MgM1xwV9Qq/GETHcQ2ueMM581C+oJuqnyVAHPyIheigXpTm6GD41ePiNF1riSobcdx+hqbsrMF1NlISPDmTAB07mlsCR1LS305Yq8ik8fhstL9sW23mq2tmrJsYDa1Vt7PysLbNbZLakzaRREmPjMAXerF1xvYBRBXRQzK48CKqrW+7MmYnYcJIXn0hDyM8NeHeoBu7GROZTST969ZR2xyZXrbj+PWx5FKQcn2WAyCx+JHPA7aTGXPk6jw6YwkbdbOdnR6YfHgK/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9Zo8JNQmFWs5wD6b/cDMNk+OpO+b+eGn+nx7ahwq6k=;
 b=RwDt1vet0chr6CIg9f8uB22QKLgrtv+XpXJCd4Fu4nQ78Y9tKRZZzgPfDNu6E40lOP4I0w5LKRz/YyQcktVAj+8xQ3g4vgjLy0pIWyVs5vWqbbU4CZ9JHhQ1JspdHF6B4JNWhWlsqQURAacIsPulkPTCtF3QNozEHMydF3ZHaXALfw2kkpgS0eAo9ApwY6nv4Q2QMGnLFz3MJ2Pv7luvSlyeqDHC0Kmvlsxq/mbnVdM9R2qsdA2zwVC/jUqianMK+PzrJoNeSpGvxh+GBEbPupv+HAOa59D5yj5M7/pxmqvwIcGZcZzoEZo4iJVIw08qdN88FPAe6e6kE47ZeDPZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9Zo8JNQmFWs5wD6b/cDMNk+OpO+b+eGn+nx7ahwq6k=;
 b=HRi2ZNmKwRh2zGZelJ1t6yOOJb2PtRAPsx6u/zqaDqb88zuRsuNDasKp7Nm2QSrmXsFBoqT71nThk00cKKd3ZkPHtoHArIkFBCcmRbY6QrRJ1scgw006At7cmeqH0Bt2ZFNASLEVAv28GsRn8Ilc8xXRdL9sT8nKPxvkL5FHAPA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:48 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:48 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/18] mfd: stmpe-spi: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:57 +0000
Message-Id: <20230308194307.374789-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d12802-f10c-458e-087c-08db200d6f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19jX7THkCQtaK2Seo14udzJ9nASrmWp5QOaDow0qU6c0fu9tqnpBRv8+BnWfBmyBZYf937wS5olIZM2aouZpy8Gv0+NC0cCIfK5KL0V9PXwiOdHyULvWCVh7Km8o7JY07a8JrYon2eQfaHZRx2bRDqK/u2ulFXyTWUvVXh8mhZv6anzuZH/efazIM8oNbH/Jo7ouj5gpydtI4TEbc0RFr66RY5e7yFl9hwCe07BF6/3A1+AA4LKSKAqrNpv6Oz+4ncPGH5ehCUlyhGvrYZ4X1rOGhcUYC4Ij6wBsgA9rZS/dWhnQV/65LCBPCDFDsHXPmyCjl1yjcVEyHnlV6o0ZnNVO8/7YwQw+vVzQzGNO6bZMKpZKNLN0zBAGfdMTR37CjyfuTyzdBr+VD+YApxHNdE0Hx0O4SniyaDMiTsscw69G6zBPCTv65vAanAKB/rcFhRNJzBRslQQXSA8eGi2KtKiD3t28yTBfAGktZGXufElbHh8ZMHxQr/ZZ/g1a6aDpKaHoIATOUB9c+E9HDLEEhs/6L7MxD8qIs7wtoGm59xJKEJOPvqxaKIWODiSzxuh2Ze88Sqer2yWaXh0X860v3OSDhGlfPtyfr22nDJ7Z2he4wZOVykuu8m8WeG4R7wuQc3VWwvvrYigdyvau8q/eUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/1QzcHRlQlywirQzfjxNOb+zypZXfU7w76KHINu8iZC63ZJBNnkHKwO1vHT?=
 =?us-ascii?Q?EXS864cCRqVKFO7IHVLjhklZeDY0phVuSJxC7Z0lTAGTNAwrqYjdx4Ueauuy?=
 =?us-ascii?Q?cGWZ0NvzSMgS0i1aAaFi7Ia087KRsIysmt2At8cdl1BQymBrRo84rWYXBTjY?=
 =?us-ascii?Q?0pU2onHBGtTGq8lVA30/FdjxTzACOiWBjRzgNp4fvn8lDKvYBD+ljJcG7mKX?=
 =?us-ascii?Q?GuhlvcJfYJC1jjGxzWEOWl7qKKlSz+wR0H/OFQMtMDrKkhbrGz0Qgk7kZwod?=
 =?us-ascii?Q?uaG7pMscKqJPj3B1wGNx+pwb8c8AA+jeS7Ni1/mlEoMDozvsx0Mh5xAm7I87?=
 =?us-ascii?Q?0jSg984KfKf/6pGBKRicE1QAaoUxg+6dDB9c+swwhC8ZXKtsvC05ml4Iq58o?=
 =?us-ascii?Q?pVYTkN+WmpXFhxxwLKr2JhFmyprJCK9qMY4EgYYjnDHtwMLpURWv406UFbsu?=
 =?us-ascii?Q?UX2ZHVS4pvpNOWPC/2HDd4PjciYdLZffb6k2hkuBRNXNQxuv0vpRimhv6RFG?=
 =?us-ascii?Q?GKrIu/qZ69RcSJjlhZakf85HrmXPt2/AR0BB1JW8a1j3n5LRFEkVTSi8LKmh?=
 =?us-ascii?Q?4fUm1zbdJneDYHommuH6K7jre3ABOBGJEJgASgiNFYv9/UPp/XoedY7CRCRS?=
 =?us-ascii?Q?1njDTkKtAxjdre3v9P4iawRF71fZHUHhesM4F1SyavbLLWOm/n3egP9pyFvo?=
 =?us-ascii?Q?CFpOh6Jba0HEUZYuTrO40EE4qJ6Ft0/iLEkSY7y6lXq0AOKF5Z3gZP437U34?=
 =?us-ascii?Q?IsxJ1qwbJ5x15sOP0fPffOUOlUuImnfhPZrjOJDrim2YV4rSIXko+4Ru5pSA?=
 =?us-ascii?Q?mTB7SVVbJYQt6AjwpC+5DKTRsQKvGyyeOa869ahz0Ht7mH6HWfevHJDa50Jl?=
 =?us-ascii?Q?QYkTrfM+ykVI6xzClaH1EZ74KUp+1PhQlG6AyN15/rZZVO7cVHVPKt8aibpp?=
 =?us-ascii?Q?Jk0MyxVLaV/7176kAl1Tk3whZT/cai0VEcBaqH+p3k2kBS0ZjAhqkx5XuZrp?=
 =?us-ascii?Q?e4LNZGfMDmjYusR0+UpfpJVAuTur02ZztA6MKQKviY+/ridMSiWChWhfpApw?=
 =?us-ascii?Q?6fx8G0WJJ5Kd8ofF/uQVlNZ6SeUI9H6eUxnkx/ktUU2upJU29/i0txZZDfut?=
 =?us-ascii?Q?1ig/odLBa3DxY57YJTxJ3X+pTdEd+TKLWFYPaqTEJ866vxzCqzeb6E9ApEmu?=
 =?us-ascii?Q?J4dj7EcFgd2ucoSUExN6j7Y1iB8UY/e0Ea/s7wnGcxgIQjGnUSYnSkKwny9n?=
 =?us-ascii?Q?8Dt6h5io0mCTCRBoVOPva9CvKlyEF+bjmOHJ9728Z+J1//fkCs8v3tqrtJ+m?=
 =?us-ascii?Q?D0Qw0w9F0ATdEAP255KDHgCkJipNGNxbZhi1CbBUCoPvRlQ4vy29i2z8iG9r?=
 =?us-ascii?Q?jwTFYahg1s1IZ/aWBuuOMHx984z0lDEjt5Mtygiorsq4g4NpD7gbEFLR8KFp?=
 =?us-ascii?Q?18ODNHGA/kKpywYLlGQwG0B6DBxFVtu7un5elPfUEgIUp6k2x3tgHfVdRmvH?=
 =?us-ascii?Q?VQ2iOVl5CEI+CQJ6z37z4sbE7IW9AgMlTgHy/ygHYSYmqKR/Rx18uRMw97kG?=
 =?us-ascii?Q?nvCjnDpAlRmUAnMIEds2tK+cgNNHSB5X8N2mlJ/x/wCvoNInzVWYNQpCpIH1?=
 =?us-ascii?Q?GsXnPLvjzhzTi/y7EDbQ7bc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?29UcioTOykHJB1aSbATF3/6Cq+2+CaBoVZXbRX+Vecte0qJUAKKbtR9iZyDT?=
 =?us-ascii?Q?ObF2YrF/if2LvIfRy5ZL5+speXaFjc4UO8cStlgW1VXpUtYouF+J7xvBdzak?=
 =?us-ascii?Q?Z40YB0tLbUTmQynSejyijUlBX/wwkqvSQeOeJDgoETXWYA8vMYzCFokScGOZ?=
 =?us-ascii?Q?yh2/ohqcnB+9zN9DUprehd8AEhCN4jTVesU66Q7tu4G3+m+WKA6+/nPI95x+?=
 =?us-ascii?Q?3UovNfkxcI4WvJZYPCahroskxaWfybqdA8qbqLdyuATrWZ9wojN7kcMduJqQ?=
 =?us-ascii?Q?KQ80Iu9V4RO+YCKVfoz+gfJ0pacOwQgL6z/P2hW07u3AQ9N+Gmxh4f165/Ta?=
 =?us-ascii?Q?3wFGKI6i2FVbSvP+mmolnAilahMK1OZ2jQ6MIugaKXBfE7WLtAEqsGHJ+ZLE?=
 =?us-ascii?Q?vMzw1JRnqISISDx53yxKzj8c41Lxx/DWYpAdroguHxhHkvgemb/9ll00Jkxi?=
 =?us-ascii?Q?4cDyhpSafbMcQcz+cEO0aNRu0Pm3wa+vCRPbB2zA1SKbb6ffGflvwUNq5uC2?=
 =?us-ascii?Q?xIha1Gd2qwPji628wrNBSo4o5riJqhX9hK40D8YYXFHbqsdxj8UmrG5x5WL4?=
 =?us-ascii?Q?Ek7BLsFOOr+7HQ8z56qmlNmhb5DVUHx9lLr/ylL3JK8OAjR5Dug5/h3YR6uW?=
 =?us-ascii?Q?QPdTVp5AtuVIghxrJHjS9VRvd1qK2kxdqd/325ShFyhlKMsydK0x7H0MeV6M?=
 =?us-ascii?Q?H0jZunt47FbHmCkQt6oqn4GXRaBX4pGjOVZfrtkKQwVhDB96SATSm9vEWkCm?=
 =?us-ascii?Q?at7fuMBIfe8L8iwXe/ZM66v3JWcHwOTPAzbLFMQtLrzERkZsA3Z816a9KS32?=
 =?us-ascii?Q?iy4NBsB4ij16xYQ6rh7tgBTfYIJR7Z6erkVIdOBZRI0/xixI7sGLkQy9jzx4?=
 =?us-ascii?Q?5U/8AQLVM9ZexMcGXIGZPchzn1zmsRZSCO6tjAt+6YaA7h/g4EH7Cw+Sno3Q?=
 =?us-ascii?Q?oKRimV5Ogje6qswZPNONdWk0o014jI1ZyCSjNLN8r9Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d12802-f10c-458e-087c-08db200d6f1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:48.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk1T4XNxt0fo8OazG2ikmZQVTtlBTJHXSkmHiQmcwng1JDVIzXE5l+Rsgt4ecn7pPC+eX+UISYnOJFMAdp5LXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080166
X-Proofpoint-GUID: 7_Cg74RN6O-5Z8s-XM6-lF4I0IgvWDY7
X-Proofpoint-ORIG-GUID: 7_Cg74RN6O-5Z8s-XM6-lF4I0IgvWDY7
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
Cc: Lee Jones <lee@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mfd/stmpe-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index e9cbf33502b3d..792236f56399a 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -154,6 +154,5 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
 MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
-- 
2.39.1.268.g9de2f9a303

