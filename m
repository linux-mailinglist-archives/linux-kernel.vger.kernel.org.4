Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1C6B123E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCHToB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCHTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:43:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493A3BDA5;
        Wed,  8 Mar 2023 11:43:32 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328HilL5002864;
        Wed, 8 Mar 2023 19:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=rtwQ/q5CBqgtWby+optesM1ehvDbyWbtsg2BsxbVbXE=;
 b=sYOE2kdxjxfi+PWPs9k3yNksiEu4WZBo+a7Be0lXez2yXcdEMdynLGrp4n4dt2igHfJH
 jER+t33BDzOX9UFgZwbLeOGf7TT5OkcIGye6DPMtEGqgsnDD5MbYRuwcp+9l9zSDNdXH
 CfmoLHnA4fRxHNP0kaKa3aTrzT1JarhKMyoOotBPJq0+DwdP3bEKIgiaC81O+lt6Lg1f
 sLAzK+LjWvtT6YbT/2i4QsVeTQuZh84p0WwktCV1hHB7lJDNAszQJAn4ppIB8V7VKenu
 h3IgmkFgRxmTu4hrjX+hmWPFlyn1hofVjt7qzOkRq6VXSjgS1D3BvlioqiBz779axW/N Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p418y137j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328JB8EH015264;
        Wed, 8 Mar 2023 19:43:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6femr8gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 19:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlzTqY8fkLQSMkEH7PsBCy6LsfZWn/OqjIk8ZkRfz/YQClt+H6gjWUVLd80U3PFvInv0I2SNoBofLEDNwxTMEGXnPbIiLqkNEH61CvuKnJPNoTJI6Huq3wYsPyJitBvyqeIo+JDamhO/shzDIVJkSwNRNrGBj7GzF3d5XlVsfmASj5eRS+jtbbednTl+9IEAbDYaSDpwNbL1fILtVmwll6DEuMpbZIf498WFb/0MO/TduZbr5rl4YtyfJFqYLA/BT5X1fVOPUk+tfrfTE2/1ZVsDvvHa63NKhjatkJH7dro42W60gpOcyl7QIEaVev/GGwp4tdM7VYd1OgcwjCpJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtwQ/q5CBqgtWby+optesM1ehvDbyWbtsg2BsxbVbXE=;
 b=d+dFrxC9x/oC2/ZLoIFsUcb2++PLPXFxvvV5r/QTlgRAshHiexEv4ZcrWfzPfjHm+RalZPcNwPWYLZZpkfbIIRwTSye/8SMaWGEtJJ2watDDZb/CKGjNBNDhkuwQy18n6JskshhXDQT2i7TXljs4J47Xl8AbSFKDqHpELBWRo4BV/Yw3gFNqzw1x393/a62drU5IsSrNoUGW+viO/SUwIXQkOT8ZrHLXSGaDxGYaEWzINTMRWuvYtj/XYR5uJlc5X4AkKN7+mtNFbTqXoqgxVDQwU2/Yb5MPxR9iif6YHoqS6VLGpyQHeGQMvi4YCXgvb0KQTLfmz7cxUx/Hl62qzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtwQ/q5CBqgtWby+optesM1ehvDbyWbtsg2BsxbVbXE=;
 b=ggGKCHxk/gbVXX0vkKS0TEZpc2kpjYcptUUNmBE9vvEMmIKEAUF+sZdej3s+G7ZOxzuy1bSHUjcr7JgfIQ0FG0cMx6OxFxMyQH7RYsBKoTgFBXQRCUr2QOgDYnpFLrfV1k68V4hfhXnhbGdQa/yrhCkzycJIFtYJ4ziKojl0ToQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:43:24 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 19:43:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 03/18] mfd: da9052-i2c: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 19:42:52 +0000
Message-Id: <20230308194307.374789-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 85405494-d1a8-45ac-d56b-08db200d618a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hl3hOzv7U6GIZ/EtZClOTZFbzdr+pi24pde8Rp9OiWmKXintj9CBFkHK1RnL7m7A4RZb6hh2sj2CHV2A8lX5B1pDUzZdXYdoKGu3jSkXQYPWQBLXI289Gq2QZxF9TNBcN+91AosQRJOWru2le8PTVV1iaAPrfzey7Wz9mRTPwETpFiWdVbgTu1g8SWRw4ayusOuqUnG3+Exz3nj7Zz5DcjPJlEYoE3Pij7BgM6u8lZG/itNsGYoyNKWfkK2E8Flg6jiWlY1vC+n74CRzz9eirybVoUUpFSkOMf5f00H4XedchI1zMpS5KHLNITqQ5jvqM8ro1rAMv7yciWigfJ1ZGCTVAqpgL5u/lJzvq4ysiiz4aHWpvZ9ZYtVBfTzjpin0bVv+lP+E2KEFnqJXooTYGaI+zsyKAD+qQdQ1lU/eMeTbyOTeS2I5zZpPT1KFEiPSm18RSHTOvLaBEnkU1RLGrP16VhHCGxhkMH6qEZLzmXvH23auuqbJWQnJF1IcOt9WC1Ac7Cwr8/B3oiS7B2oFzZm1qxyR3FvoOiEeYtNXX9y9dnPRm5Y2e6NxnJceUPx2IyCXWTD3GLtxrPdJGg9OK+2yKjgJjT8oA4ynyDwiPAE1OE1hv5ewu+2Fm2WIK0VxSPt/S6T6rQKvqTyZrvQ/Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(5660300002)(44832011)(38100700002)(86362001)(8936002)(6916009)(36756003)(4326008)(8676002)(41300700001)(2906002)(66476007)(1076003)(6666004)(2616005)(6512007)(6506007)(186003)(83380400001)(316002)(478600001)(54906003)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i0Pgziosu4R8NPr4baIhgixSaoNOBta4vCf5X/01hmKa7lozqSPt1qUfVbs4?=
 =?us-ascii?Q?BkIsaEAlS4OKSR27PIQ/dIgDRqC+NaYK0A8EEp7ZB4lbZeE1OIVx69VmvDUJ?=
 =?us-ascii?Q?0pYrgfdN33XudRZNWmaFNboWgb/4TVJ/tmMPa5MmqTaK7bvXbrgjb3FJCieU?=
 =?us-ascii?Q?KSlr55ol6fJOnsdHFGDzH3iszAydyh7pzAOeffGAxhFg7+sqbGYn4AYaHXfB?=
 =?us-ascii?Q?MpidQaUSiHNxYm26qitBzCN9+Jn9oCUujsDgb0oftWMD4BdCjKxNkJjVZRbE?=
 =?us-ascii?Q?wIFF9ARiquRu5ptzDeqNwRaFQX9Cu7ON70zb8DMhv72eTJeefeQDnaWAkGa1?=
 =?us-ascii?Q?xbFyHBYb+uSXJlQjeUTdAvqfCIHCn+tLJk5HHTv343a61CF4MyiVKk0TX0q0?=
 =?us-ascii?Q?6bzY/YRnDWR8zl8psROaQ+fhLB220GZEwzcfiOxazyWo1TNoCjjGocm2hn1a?=
 =?us-ascii?Q?P+vNnjEdwk1DZOLOB24HO3djImP73ZKi2I97Lm9vQhb5sM40JCnZPa5u/5+u?=
 =?us-ascii?Q?X0/5HLPcYtKSA4Oy06mWfeWTUYblXp4Lvo+Pdb5KcCBpHI+b/LpxqaV42je7?=
 =?us-ascii?Q?Cqil3/LatkwYzDJbWUuFA1CIYftv/sAEOCTO1Ja3s6edpHKlDl826GGVpLW9?=
 =?us-ascii?Q?vrPWf5nX1lhbwdTBuQHxrELP8oEAPuzU5T4gp2HD26o4yme/zXweNa5iX+F4?=
 =?us-ascii?Q?JaqGnRebDrFXoLRtrnOuJEaxsJQNsL0WOXsJ2uM627+Yzz+gvOOGUfyICrqA?=
 =?us-ascii?Q?XkXhZkgslazHhUJtTwl6Uj5FGB2qhTIqfGjs3WdUUuGbaen/culTbD8gqduL?=
 =?us-ascii?Q?hDokrByAwFZqMB0EkGS9I5QodfbNgnf5mOtgvyKOf1pwwnqy4OYY8T89Vvka?=
 =?us-ascii?Q?G18scdCRfdNeOsNdEAZ2bV8zbyCEH5BUjEZpPYzE0z8xyMV6pjBWXSoRw9cZ?=
 =?us-ascii?Q?suRLv7Jo5fDjXvxG+0AZJpopkdP3fnaWL8ZDcvbYHuQLzr2vX4v5UB+oI2D2?=
 =?us-ascii?Q?bGgxl+Hxqv7pYLJXOaYNFRi3q+c1XxuNKBxP832vrFa7SkkW7ZRPqhOOl6P4?=
 =?us-ascii?Q?aI8+WyMJMIGFGEPWeFwWv0RJ/fozNWfwCxbAHqRXbL0YVHYLA0PXNoefb9Yy?=
 =?us-ascii?Q?DPDtFrHOeKWzP6I5D7YwwHyq8O7b64XfmxeZZWmlblVkMwtDWhff5JPdF2hZ?=
 =?us-ascii?Q?2fMmH1veh+JBN79qszrGk3MxWDUvvtawpWYHDIuJBHkqggiB6OzSXyDEpQ5i?=
 =?us-ascii?Q?vxTOvd4QWDVDhxI74j/tO6omn3PlGbRVNbkPFitU7AuglqgijfNdzEG1Ysy8?=
 =?us-ascii?Q?+j58Jo/PCe1DXG9eVmA+HqPG7AAzRtdwXDplmP++V7ZQ1O/zpb7aiqiwhxsK?=
 =?us-ascii?Q?4cBBSVcrSxMYL97RkFxeSuioH54H1H5NJcVHhgrgqKI+uj2Hm+pZaMqD+iqC?=
 =?us-ascii?Q?zhWyrXpwUh8GPpmN6peepSIhBeQtOoxrpo5NcD6e/TVPOizIsoEEnvlqcU/H?=
 =?us-ascii?Q?Nt2LuQU6bDXt48cMfqX02qv0PRbob/FLS5hHuS8Ntds2fjQaWkPhNzMZ8DGD?=
 =?us-ascii?Q?UyofKs12uvsehRVSHR+yLDGUVZrQ60O2QSwvs7a/WlxsdaCqsCFAtZwUuO26?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s8bHOajgHTIUJuobPocWyqfsr71SdR8vEv/DIaT1LKByV29MwtPlPtnsQYW6ZavzIcbbreTs9g9wxHhfakgOY8EvSwMX7PM51B4iaaqFYLYZH7n1bhpsaBoKrkOva35yxzBjzHbrqKkRaEr2v3AOw2MZUgByy1icTXKhbidj3k32+ODVVVEsSn5GX9sbgqtU083hHwjCH6RWiJSzHeM6G9T3WFoZHGabbrJ/KSVGgQx2Eulz1F0AWAs6lvdUNTHjlvCXQDEsxnMOYrd4KJJ2BxU4oBe99DStrgTmen53Ls/oGczU6+H+wVLv0nwRigLZXwE8Z9QUcTZWtySG39x+K2wFuEyuQScDL8lQxhNY3bPKgufj2oqSRsn1z2Zb0TceyrQhDM9sAEUJeysJ0uSy3fOdCPaxvbLhGtLhN2Uc5/5bOzixQaOU/xfdg67MKfq2w2pd4u+iHQnZt31j4CCANtbpdxvx9ucKZ0B36XrgB3sSIzxUpwor6ED1oe49zMg8PaQJzmPnIOJiyXpnZOBzoTWePTHIN2qKxI/WSI5aPqTKD6TSu0skcFrbW6lfsUPOSrgtwKTeBXr9+2HiK+D+sZJp5EaDaEiBMjc4vgf7MUeUoHMqRWKElIcwWqtCuQp7+L5u+j3cw411Ac5nDrBE+Z4NkjNiOJQO1t4qlngoOX5LmP12P29d29XkEjGA2t9yIefmD1E5FUKYdZUwcbtHBI6/BUgqRlkI2/QtISmoPNpa6zGkH6pmSIp8KCfM0ybzuSPCnjRsiKDxI9Uy8qvfTRRERXvxtLA8s3VBVYmfapJTYzoacHEGac6FXIdLPDdr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85405494-d1a8-45ac-d56b-08db200d618a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:43:24.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntH0emaWD2OsXHCt8y4T7ckNurQT3rqocGyxPtKv/MvPlyj8JaWXvOdKF9CvTZEOw/eowzQH55Ulh5r+KtyEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080166
X-Proofpoint-GUID: CYQPeBOVRPgmCWe4Ebct_jOCiH8wS9aq
X-Proofpoint-ORIG-GUID: CYQPeBOVRPgmCWe4Ebct_jOCiH8wS9aq
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
 drivers/mfd/da9052-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index ecb8077cdaaf9..03db7a2ccf7a0 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -209,4 +209,3 @@ module_exit(da9052_i2c_exit);
 
 MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
 MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

