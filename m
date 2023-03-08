Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701746B1246
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCHToj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCHToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:44:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CF08F728;
        Wed,  8 Mar 2023 11:43:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HiZI7010415;
        Wed, 8 Mar 2023 19:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=doLzkrsN+mD/pRpXCztFNm4aRzZfdwvglxqb42EnGO8=;
 b=llXyDP5VYBUMiBcj4Elr0mSHxxqfgK4i6YMw3SSTyvutm9okNOw92okH3134C7ezEHHD
 w78rKAKzIvZf6Z0M4/gedBtylmmYvNYa3H52hDlMtcX0qMn6iDRaDgEo7Q+MtVH7Pl1S
 ywRp8tpXjkoRD/Rvrtu8q6SaFqt7LH2Z5lMDCiQNW7LrI+jj8Vzg1+dk9q11NSSnKbkb
 5PNfZFrwKGZJkOcr7AltMb5nF2COgFWdXVVekaasaBJFid03E+ZwAaYaba7i7MyiLKNx
 XNo0azr8pnPkTF4iLKfrLzKdig5ctfj3bsXOMlDxv4MiXQXTOAlLbbZmhC3U0HT+zZOr WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416ws1wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JgPjJ020892;
        Wed, 8 Mar 2023 19:43:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fu8f11y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0s0e0/GA2uprnFQ1tTeG6vYJUjSaHM76iQaEUbXx/n5BU6AnaoylQavYSg+yRlxpru4XYnONLvwrtMSM910AHL7ypBvjjeh8cIDj7sfcdX5zbiBZxjgv0hMk7zEXH/2HUCZUIYAoaZOs9PlvQtgq+tR3XkgQ8/UidAHcwKkUu2TleLKaNZ23xse1oZl39Lf7F52Utf1dXVSdGT4cBFzzgu94ORfF2a07A0dAsyHPpjR1QP3fpZBbGZuKRcV5SL8Q+kYv6g2sFInf099Pttc+1G0Y8pCm9TOT/dU0j41HKtbZkCZwJqsuzL5/tkwWXCA26U+Ib2Obo95P9wsVaBH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doLzkrsN+mD/pRpXCztFNm4aRzZfdwvglxqb42EnGO8=;
 b=H5gTkJDW/IqIQAw+/gKedX2JILw5JF+zyTeXhsakwq8wlRoSYOu4ly+HH3xkmyXbhjONIPG2No3u0UrvjU1arNZHQ+WAwX9uxJHbmOsOoJUWrXFGB1wBdvt8DWFTAPkI5Ax6UztRZD9nJ4nb3FW9JuoeOBbBj+o06bXTMcjNjwF/MQLyoWp6F9Ns6y4J7GByjQz6ZDLJaA0rSg6uFzKmGg+ZKvTuHaglAljs42+yyTeLi17ROYr2fhtWv9M0MuAhhFynhfcm+oMjKvgnWsVk5V5ip/Gw1bGvD0/aS2E7xiNjO0ArvfVerr/qmTZxVhk2GkQw6UcW2Plr2abEOQMtQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doLzkrsN+mD/pRpXCztFNm4aRzZfdwvglxqb42EnGO8=;
 b=Cg4f+osrpJR7+AQUknpWXnLZqBjhUEe9ZwLx0gSOa39RRk5FLrpiMPLb/nwnceHY9jX6xYIYZeECNANxIYhLWjuiBQkeiWFq1kiH95VrRQPdO1O3i+3gIa46EHQC6JNZdyucfUDrOIF52/wp7mXLVyjUZu4SitZ3clXLH8GJmDw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:38 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:38 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 06/18] mfd: da9055-i2c: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:55 +0000
Message-Id: <20230308194307.374789-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b83c8e0-f75d-4bd1-f2e5-08db200d69a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctKgUkZGuvGN1kTpPS5J0/zy4ukprUdfJgGfNnK51ddMHs5CPc7IkRX238i+GQ+/ERDSx5ccJf7g/AcKjIhev/y0Z2FYnBm666DsDW8m0c+ZIl5CaeESjjdjYxgPnKiIWUUhBVHVXWkWDXYmvEX71ac5ucV+tH6tAd+oTbJsdAzo1eE3r0NQ/AxMvGaBzo5YIvSYgbcLiCecM7/Na9NVI0S2v2ETaBli8zj87xb2kI3Rr4zuNMau9Nd93H25HyJ2i07bN2ZeFQBXpyEq8ygU15o4mXBwX0k8k3o90LmPzv1+xolrX5AcC96Yrg91B42i/4OEgeK4hCMFaQQ80iXWFNzoxThjGDhUfu9zQBXozmxNkj+vySKKtTZMD4d2ESp5wcVgYJYBKxxXp69j0MofXzuJT0w6co7ICI57vLFjlPthi0Cv/YZkBe8w5jROWTP9zzFXxAGPNEdEon4AB10qYJfkDAUyksjhc8W6oQBckx1PikdmEkxIATq59+Si3LM0n7S68JHiTMV8kRyYiBbAjjX/AycWgD8Zj9/cMNDBrpnUpp6Jceik/0qI1STSYFhtTwKpmxdzFv9RNmg6NIeqJ0GG0jFkZ6iDiYwtywO3ySJjoH9dgTcTZcKRVPcHn+QlLWYeiHFnPeYl1H7wtVe1SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODQzR3gXiUiGk3uUf6KrXg3qSs3ln4g5qK7eOgdwgur+BgCiYNbh9MyIL1UD?=
 =?us-ascii?Q?UVBADxbVkfI9IAAY7aCwEYMOjOg+PfHb4dgb6HQoZDYTO4Wip8rRpXWYowsK?=
 =?us-ascii?Q?Gx+xFlZs4CMDYE2K/lUqiDssE5XjA1ozQbRCiwro48f1LuzgWP/XNL25v1ON?=
 =?us-ascii?Q?qcPD4mS5wAeAE0HHUOnlOYMAdNZJSvSOFovaCF0OfcHiVihRm4I1LnrHcxUr?=
 =?us-ascii?Q?y5YwSSqqh0J+Ddk6o1WDVrmOiBjJWAm/J34Wy/n21J+Nxoj4SfmGK6IIWuUb?=
 =?us-ascii?Q?cNzd7uVn8Ays46JJEJuWbD85FlkkHHAqqWhwIOKY5Gr1MAPSS8mSbeOPGrke?=
 =?us-ascii?Q?1k44CkTGV/0oRrVyUbviXAq0YRvCRAnSqWASZFLhIRdHk+qX23glwqyj8o7q?=
 =?us-ascii?Q?Q1+11qTZ85RzHpkT60M6yGuQpzJfsFllVSfRwqWUeuKDqfIsXzYhEZaCLpCD?=
 =?us-ascii?Q?ioqtexT/lUkxmlqu+8ASwgkCY7D4Cka8IFXp9vqpxdIlTpB91MPBGC4HewLo?=
 =?us-ascii?Q?FgKkYxWlOfgjAMiQY0TaFdzDHXaNiWtRdgkuC2aOQLCoTZR5ar3Q+oDiMBfZ?=
 =?us-ascii?Q?obutASpzDXSIy0Sc0wBOZiTYmPYOByNPNa9fHWqkwPaR4w3zhPGUxu2k60eu?=
 =?us-ascii?Q?j7JNfZWOqysmWJKcrtsVkVVSd9rtXyw/TIP8PGk5VffGaJVFb5GdWoXrWwXq?=
 =?us-ascii?Q?IGmQxrMoj39yIWcY0pSnHwgAVgpCv1actgjWzT050IeeR2pIU3fRBUctS6++?=
 =?us-ascii?Q?LyBGRqCNGGBXxX4/D9+xWMFlZ14MDvaL0clO2yknaIZTGvkrXGafpphpFbzZ?=
 =?us-ascii?Q?/nyyH670KwH62vvwgQREMZDMzLuAC4eVt2I8AGk/FdUrbwytyt78CglPlnXa?=
 =?us-ascii?Q?MKCosUdQeePFl7LEhkJgJqCk79xZJXZn0gEm2Rnk91U4Nt2d1DAVi6gYhRQ5?=
 =?us-ascii?Q?RLlzHySl4eMVQ3BxFJ90rX8jVPYlSEh7y8Tjn1KInvnvHcWfUgJkIjSKitu1?=
 =?us-ascii?Q?GiggJw9v9+ve2iFKthWTnZldG16sIb5v+grqZfigplo+tohnoO/msPPMCOlS?=
 =?us-ascii?Q?5O9j7EMDtduCi2cINJTHhXyhcP0cCjtGFeAeD8/0/D1yGiY6oewVJv9tZWY3?=
 =?us-ascii?Q?1wi49bbRgu2KQu7g+sABuYug2uYeu2FfgyBrnA7pTdv6S8TdKr6xODdlrmdC?=
 =?us-ascii?Q?/Nmq2AHvj9m1vfa67HH/eOBoYHUqvGkC01Zm/G6xPG/diGLJaVsyhiePyBvo?=
 =?us-ascii?Q?9JY3Uo27J6HFhTOK2/eqmEiDgsLtbqKhjWdF8YMghzlND2xVfZIhkZEYJcP+?=
 =?us-ascii?Q?vlu6g6+Qf6Vp98U7FcbCITXTyyxw/FCkziEDRxDbc0SRDLSNwrPWRXc9dHeu?=
 =?us-ascii?Q?iMKdv/Ln+TASfI1R5JbJ71OJkQ1jxAgFMJ/wuWH9jtKE6HOIFEgrwO7nUqYi?=
 =?us-ascii?Q?QZj9HJBtFPYUqPWvdZLaZFPUVDJr53moh89Q2A/VEpvf0nd2lUZTPVTsynBl?=
 =?us-ascii?Q?AtOeUIiB5VE7XwhHAgEMqHs6aPPbfkJmOPcCgwWzNi4QnH09tKivXkaxO6xv?=
 =?us-ascii?Q?gYib9ThkUGK2zd8YqhZPFxd9erSuRVA2ZY9xbSRyD6w+bqlBJ4FoL32H0gT5?=
 =?us-ascii?Q?pJZazL/wNN/4jprwS0NcZG0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FGYa4whKsosF4ZyHTEu69MuyBt+449si9pALWnz8f97HfEg9sWefpTOJeVF++cnkDSp6047pmaGAfHQXlPMw/s2ZouOLFV4fbsNKb1N2w8+FJFR/cGh74ocBp7viJeLNyIHPRaOkrJuIB2pSdo9D7RlvXBbRigdX0ZVj+lrqICjACRfuQFujpc3VCYjl1yepdj/Mugbxos4qAm9TfQ92zZPgfPX66mXwt+YEnnmSRgB6nZbwlvqAB80J6fRGdQvrsZn6yFBbAfrMQFUEhYCqvz8RmtBKynnn8z0BYaZjTfRH37yV3wbGJcUVoNk+VoKh47lO3MYKTHRW427vTfBi+dopRQ59AP7quuS0irhFM+o8q3sb9ND16PaYrBHLRV8CUesMreod3VPD6kdCY3dMBnZwgLXPujXUFnU+7a1MqEDvwJrJflsedBHDxam7QiLlM6GXpO1TzE5eXpNcJjA2XHC2BObbl/LbPNf0Gs0UccAlTawoQ9KOi1WmJSx6JFAhzfuAwSWJ5HmtfxPahIE4vLg0CRf/hDzc9dPizcBzrKy9u/HeqHaiLByQ/jULSJq7jGKfzXNkb3dAU3EhOUk33HFo0W+ZP0JuiBCTTJFErICxq48p8IKr1lNdCxwfg4fMSHeA6ZUq+cSsY5tpxUWMDX/UcxV6GauducF02mYrs1xDQrd6ZtVpTMAtmL5Gqm19IvMmgbhDYGWEEwTaV8RlXRDCV17dhqITBBOiuEucGWPOYbF1TC2QUqHT5fvXt4t48+sDCdP1VQ9hnGGoqDGxWpiQ0DN8g7WTOoP7BNP7vgn0nv3nhxze/EmTr7EwTqMM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b83c8e0-f75d-4bd1-f2e5-08db200d69a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:38.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlHbJQ9ohQEJv7p+wg8daMhUr/Pm+L3r0AWBVA2gh9enR5sDODWLQHB7qi+bhD3wteyXxykTXOcBBHvYeOstBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080166
X-Proofpoint-GUID: J_pfm37a8QBk27AR9PrujsB97IBXryEC
X-Proofpoint-ORIG-GUID: J_pfm37a8QBk27AR9PrujsB97IBXryEC
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
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/da9055-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 702abff506a1a..537fd5de3e6d4 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -97,4 +97,3 @@ module_exit(da9055_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

