Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270B727404
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjFHBOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjFHBOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:14:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8AA269F;
        Wed,  7 Jun 2023 18:14:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357MJxlL011471;
        Thu, 8 Jun 2023 01:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=oMgWGY5ihKUHA70zt2K4eoEjJ1BN404tlRvZvS2Qg8A=;
 b=UUbx3ntSkkirHCcQzd1OiMp9cG3iUX44JVgr1l+L5rK611TVaitAtZ5OLM9hESa1XsVu
 mZFUuWaxoElBQlHWHI0cncip9gozQ8qlpg2veN0DhwFBufWEhJU1J436O+d/mviCkzm5
 6322Yz7xGXxshNTv3zEwxNO7LBj5uvkBezdL60cV42Lamqv89KtN39vEBYAaS3XXMoGV
 +p+bAfreyzm6z7RQkXDusDMe3valoCBhP1oxQVQ2ZAIfKB7H7v3BD3Fpd6+dbo6mOGil
 KShs3Wm1+EntrttIq5nHCWD9+A2oKhoPPL/FJX1IbsaKnNE2t/exElT8ehWThsQhR42x wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uu5t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:14:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NH6n7037147;
        Thu, 8 Jun 2023 01:14:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6hy84w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpXVKruS7CCH/FOmWx5WdBtWEiEuUuWGJ9AQ40wjb4nQEX0/lMN0N0k0C7Rm+KBVc6peQjAXnEhkrKkOsCYtrmC5W4KIQKFJaMqCcb7N4s8KbvscT9bFrKiwruxsT3O+Vxflq92t1wZGf7QiHXj1uxkpIp4O7AfzqQ/oR53kb+8aMpVcRED+l0wVVI4DZ5538G0Y/eHxQTr9hhxK7mnd0zIW+yyXclqNim5uoYLiBQKCrTKbuo5a6K99HjySY7otiRn1Y2V/yXbpYlosg/mABYkNyxI+FbuwQ8IRKYLy22tA8x264GGCFATHd0sD5CTtEbWF4AIlVE79WJ4N6gORIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMgWGY5ihKUHA70zt2K4eoEjJ1BN404tlRvZvS2Qg8A=;
 b=UmCezc76dG6Yixip65ihc/y2baO1HGvY5vQFErljhRYWvRX+d/mkyN9odirA5jt/js+o9R9nGoABDc0TZ1OCInWGHq5igKbOP1lGpLdxKlqMJJZINRm9jxkcecxgezYYpMgAiQfzfZRx+9ax9OhzLTZQ9juKGFl3ZzpyEh7aamcx5lldFqEcTEtOf7D1sUPsrIaNeCfmgBq1+KDEAsauLQSPbOglxUCAB4iLw/kk8LRxAm1/ijOaIEFLU8tXzx1wn82bvnwD8CV6YEsrTTckp940OkSa3HswQnPgZlGcrgGDVGyxnk/to9eQyxJX8+U0Cx/RhvKYW2I8EGwZVZyw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMgWGY5ihKUHA70zt2K4eoEjJ1BN404tlRvZvS2Qg8A=;
 b=LF7oQg87jMspo0WWngdaNOEcBXI/hwVXzSTr4l3RMDJMqBdfb4UySO5J/xulKEg4B4f4J4YUd/QNW6FJXGqQL90PD5Vdh3pBhXOdsAMq2LaeOCDnHZ8CYosieOdZJkIBTi/OqsbrxlxNCCJH+UhLQI2ZhOybmRxaO96EW+y40Qs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5178.namprd10.prod.outlook.com (2603:10b6:610:dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:14:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:14:03 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] scsi: lpfc: Avoid -Wstringop-overflow warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzwe4uy7.fsf@ca-mkp.ca.oracle.com>
References: <ZHkseX6TiFahvxJA@work>
Date:   Wed, 07 Jun 2023 21:14:01 -0400
In-Reply-To: <ZHkseX6TiFahvxJA@work> (Gustavo A. R. Silva's message of "Thu, 1
        Jun 2023 17:40:41 -0600")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:5:177::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afc9a0f-ba56-43d6-e3de-08db67bda62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDg9MZ75a1HX2HJ9mdnB9hxGhZq9ym15sdJVM+pLSlkN0oVAUm5C86B8DTQkgQftp+S8B/LhDCgZihXI0fJA2F75Db+ejNBAdi4LhURNlVSAGyTjFQZ78e7JdvVXMm9iDD6sZ0udQXOv5zPsceah/Dabr/EcBEtjbBeAq5wBFESN0wYE/gWPd9pmu2RV+Ynh6ndyxOv5V3GYyH4lVSceOSPlDwuM9t/8ubn/l4Vb9s1gwbaypTwd6/ZqZSJSRTy1tXAGSXfccwA5CLtpkmUbnUzBe1vOKvhiEoddw0TGXyKdaFiIV3TJAF5QUQ4W64hEG6ygyPpD/iIC/89x0obq2x3196kj2Rrg/PycBsbev/TMxjQGUe9bzCbiH9kdS7a92SDbe9AzxFZMSy3hqpDQ2jkbXOlwr1s+bjBSApgIYuR/LU1IIXS791PqINOUVixRI6p0TJe9R5/kLvd5BaKPbfiKz+MFxYni70dq5T0g8JvKgyE/RzKCysnFKk6rxnNsSfXMBhNjFYiu5uP0vk+JPaSJ2dMoEdAfs1hTHyxI4TdhHpKDoGIR6mRjf1q2lwpz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(478600001)(2906002)(36916002)(6486002)(558084003)(83380400001)(186003)(6506007)(86362001)(26005)(38100700002)(6512007)(5660300002)(316002)(41300700001)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDiKBYe1se2vgylDMMwcqHxEd9uLxYULGjy67Tge06RbcyuoQHdyGzSFtxV6?=
 =?us-ascii?Q?VibJs8/8Z04xqb241AOiBrg0/zLX1fXtV4phzA93mOtl5xMSg3UR8lD/Ub8C?=
 =?us-ascii?Q?wCiqGqjN8wAArq6BmmXhUYg0009DWT7cuich7h81nMmg8BulVmbq19O86o7B?=
 =?us-ascii?Q?XVmXStGFAbUtFMzoXuU0qGhpuaMuRotA+yWpjB9LpEDP6pxysbiEd+atSXHS?=
 =?us-ascii?Q?NCp74tMSoy06XCVUUBEqu5VFv6txWQ9p84Cg93lE8UquDq8gXpox5ccw3VdO?=
 =?us-ascii?Q?tUq6tOMrODdjXudvpTb8pU6n3XXLNFBS9FQQwlF07rfBXM4CkyOEnQxy66sl?=
 =?us-ascii?Q?zDBCjI1b+D3R+lnTKzoxEtzofc+JZIiHfK9LuonfiPPruHPBclyfwW3r5MN4?=
 =?us-ascii?Q?NGDhj3muWfRJVOtXedBHekGsxDq6ByM56ZpuIc93fmGOCJJ7azvlMTU7krkH?=
 =?us-ascii?Q?sB8S+r9508QkPApmJxwQt6W4vXxt1+eQ37K473YG7Oy6+X2ykIFt2r5iovBV?=
 =?us-ascii?Q?C42lpBZRK7pWe4Xd94RDidjPCjzLL55VzBM4rm1HxFzXxT7+BkDd9BmbnIEk?=
 =?us-ascii?Q?WrbcUFHTlSN7NLTi2g0BH2/TjNEIh6x5Ur1+K5je49VY2Arno2i6c21YXR/C?=
 =?us-ascii?Q?iDPlgIRGVAfcro3AF2ukXYEd2eXJGlThvOMtZzYT7j1duhAGE247fZvMjzAs?=
 =?us-ascii?Q?FtR2o06KOqR9xrST3K5CNX4HM0vARJ5bVxqcXoGcVmbLl+vfM6vTrocvfsE0?=
 =?us-ascii?Q?NU67igNDYlMUvIVYaxXBmE5ye2IiMAU4o7curjDaj3VA8HbbuQJ2uuqeWcnm?=
 =?us-ascii?Q?mUhYjct1P/hF8FgyawOAY3GDL4AWWMHmonKWoKwOQ5TDE4M/70mc1z/4gUPn?=
 =?us-ascii?Q?x1iubXd6LZ3I0fugZmw4aGqxeqtQoz1Ldjjmu3gCAH5zE2AEtByrYsB113q7?=
 =?us-ascii?Q?Q7TWzc+uKUrDW8kL/yFjCu7QdolFVk4vuWtTmR69RPpnmp6GAyjidVd/6PkF?=
 =?us-ascii?Q?TXu0MPDVuwEI3G9stRLA5pGdMvcCMIptSz+A3X4qbbbaf5fbmv8qBHL5GBfz?=
 =?us-ascii?Q?Udzm7tgzgLqy5kmfFG8nzgZHZv4OP9v5z2KbygcrUfih7wK4qPJMHOp7v2UD?=
 =?us-ascii?Q?cHZuydibis3QSkWnrT/NxdSGjcYSG5eQ4DFh6U6ldvLSJ+Ib/Gd3JsHOHFr5?=
 =?us-ascii?Q?0WFlQMlALbuNQZOAio968vem30w0JydftekoD6VV/iqHU7r+FrevmgXpDnkT?=
 =?us-ascii?Q?IF8TINnRk0k49Dk7ibSeSL1P1l+1sPn/72guRexbMxWHeituv9fiihpDHPxK?=
 =?us-ascii?Q?ffrK7S/XoSzF/wxCl4GLtM03Z/n1BpOh1J2awpgqsBI9tbmnPqbzR3qmjjBe?=
 =?us-ascii?Q?3PRHYKWIcx6HXf7CZgyKmms+sLu1W4SJWm+At2GgqjH4VkVIieZZoVevSiYk?=
 =?us-ascii?Q?AqH82r8gFjtguydqeqYOpMEHHJBvEjLd/I8WEiftPWHiL2zqY6FE+6bq6o7z?=
 =?us-ascii?Q?fKcoWiAOq7XWnJJIEBanzEatoPAxhRw4XJ0JP+tymJH8w6f3iCXMNtp9mACB?=
 =?us-ascii?Q?NDAO+ZLCjye22YcK8Hc3qYe77j1O8GFf4ceVP4T6vBygW+MDIHqzo7xZXHau?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4XtgMeV7JGitWQ4x7nao2v+0TCj+3YIzXKkTR2C9BqrSFEDtCyERuCyi65BDs9f3shU0XtFkBGvvkNrdDX5B2KZeEjvkTt3vM5eS6Z8PlA/krevhKTqyX0T6hfKqx/MQSxTVh5/tNp3YOdug/RFD22vT31PywEjxEmfvPvp+EjpLK3pdl5VbYyFF6c5IHxvfOJ5sEiKAqynSp1/62/tMPIVLxkJuGsjhzwze7u/a200obrvBHO1slXfGQ1+v9IrjHQ5MdxAzNVv8Tq3i+0T5fMwyDNki/gz6fB+HD2cVdoMFw9qyUu6MPRYc5hLU0nWx8GOck8mot09zQYezO0eO66Q8lOplJD8GhvW3pjG7Wyo7pWVh1bZU5g2ZSn7QmlK4H+cdNN5qZMOnWZHWIEcxpwszzVroOvvP9EVY9gDrjAyJI0/xnrecHBuaZOP6qHab5bLzG7Ja3pbwyFindJcTjhL5PqFAgXy/JCbwtKioSqivvYM/2NrbOvvqg2iyyf/k1N4n0PZBf3xbb+6Tm4GFqG+Fqlb+e9DSiWqE1YM0C6ncGEQC5mKTvmY+Cn7EJkKcxLTwCwjaElWfY3iyZoqoZaQ9POqWsiGOkiWikc8xhwLSaDe2F3fXdmkUQeC9T0/1SO2l2pRLjbnhSm/MbP1eADgeHnYMQ/MfwTWCcvpeVFLNVoT/r4thobUtfgyfFp/HZRu4MoJMc6+XZ33iSO/ydEgNwDuscDySQs/uz+6Zp6iq+M+KRCf4knKtG8adHa/g7J7v34dll4QJbkjh3dmghdIelFqVQfJ8hz4rFrGVPL6vcoT1pIchQKo+c5SESacpKH8XBSEHYl5rVYrPgAaTyemQFeyGviSz1S1rb3zKNKR6jnDKnKPilEJuixjTGa8KnND+oB0fWoHBT+RxPrc3Iw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afc9a0f-ba56-43d6-e3de-08db67bda62f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:14:03.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZKW/oecZg/QUsEOPUN0zgCuwfQwol91w4XWizJcOz5s3f2qyS6HtBzK19L8qTcj85YFOxEi8qRQ8pj+FUJzxBVBTDvFSJPvs/GmHQ4VJoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=684 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080006
X-Proofpoint-GUID: 9OYhkFmBJ1cwySgcbrMZEgcxBNpQpmoe
X-Proofpoint-ORIG-GUID: 9OYhkFmBJ1cwySgcbrMZEgcxBNpQpmoe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Prevent any potential integer wrapping issue, and avoid a
> -Wstringop-overflow warning by using the check_mul_overflow() helper.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
