Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B373945B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFVBRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVBRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:17:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA610D;
        Wed, 21 Jun 2023 18:17:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LL86cg023603;
        Thu, 22 Jun 2023 01:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Jjvz6t2jYFhorhV9vSRaV7e9WdT2ElC0h0MTYNKw9Mc=;
 b=lDUxOvKh+FF5WJWFm+id8+f3ZendfJywoStar+g6W9358SmCIyH12NUwtar9GhYuumc1
 2fb+Yb+6Ea4gE+zPKkvbqJhmM+kLvgN5QYRszhSEdfM0R5aexgQ/eU9VU+ToISXQFa0G
 B5kgd16sCmLGXlszS96WB55rUPgL7i+t0yLzBQoLJPeOE2AwlHNeLQEUx0tjy5U32JFQ
 fc09nv+eIcBSQmjNgRnuPzO24FrrYF+tI3lLR4vAkDOIwgef62wZ3ht7jYvD6vfpIJon
 9cgroioFGxhX6p0fHblg23AnhLzBK9+/jf4BYDa2DScUHxAeydT5jBoMU/iEtSpOypIy XQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa8n79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:16:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M16tbl005790;
        Thu, 22 Jun 2023 01:16:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396kfwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJL76r4fB1L4/NYpbx0Yl8zyHEpI3TYD96MZ7Q1vyee4sMuFUS50/GGTDf4rMcFGOf6xr/0AZwxvk4j8+jnbx9gzHahI6azQUlvvBgJYOZT4erlKVTAJWu4+fKI5in/bXu5lxoDR+QQ9ge4foycCimg5zBzg4pToodq03UrCwvbFcjZyS5P1GBmqZV8wcrBPVhviZYWrGnY/c8IjTVq6MSwoyLHipRw3jprkiMEekyjBD9k9al6O4a9VVQnzeoWHLrGm5AEENFvnIA9mtzaOqP+bCpgicDU1LAI9ctVR5+kyaeP1UoFDGwNk38MxY28g/u1r0YaIQZYMCXVw2tv2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjvz6t2jYFhorhV9vSRaV7e9WdT2ElC0h0MTYNKw9Mc=;
 b=VYOXuXLqCYJBmmk5ffkXlcBGvoBiC4OcEz5kRGGnmeV57+W5YRmx0HiQ4hbxoApnymPs35ud1sdCijevU3ckiYv/wjxmOiHJSqopJ7BeujqGW/ACJefRzyQY0vaa8YH4+mGS3WCEr8dHaAFUhd5jX6E9FVYMovwHqgMus5Mg2tKQZzxXYjDt0cGX7s9OZ81Ctn2KNnbqiiB/A+HmG8RMqSduS3PU9YG6H/i69K3YgbCYM6SGh9RSTOnmeyz1x4Dbv8CmDzL3OEznTrUA8UzccLI0ykuXXxKTpdmr5kgQO5JqxMadsIb0E4r5e1QPxBAbtkkCBUVjBupG7cu59JylHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjvz6t2jYFhorhV9vSRaV7e9WdT2ElC0h0MTYNKw9Mc=;
 b=KRIOlq0eUQM1SyVW6oygqr4neoyX8sTDUVd2af0hq1fctAy6GqcqxbkqDqK60uKi8Un1zwyqQZCgJda7HZvC965gWzr4/u0XOu/71ibZiy1XfnSEaR8VyeamR207qBZBhcRIhRv90XDZ5AG0wr0xi8ZUwETQir3IEOutq8cbc0A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 01:16:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 01:16:51 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: smartpqi: Replace one-element arrays with
 flexible-array members
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7l8qosw.fsf@ca-mkp.ca.oracle.com>
References: <ZJNdKDkuRbFZpASS@work>
Date:   Wed, 21 Jun 2023 21:16:44 -0400
In-Reply-To: <ZJNdKDkuRbFZpASS@work> (Gustavo A. R. Silva's message of "Wed,
        21 Jun 2023 14:27:20 -0600")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d9fd22-a487-4d70-a3c1-08db72be5baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTANiVAaKJgirnfIbMlj/3GPgBL0/5+haPNUqjt6jD5qkbbQHZucZIWi860beUpmpU8g1eaFdtN9n641PBSKc3YM18BNad2QZ/Evzjc+H09Fh92YYcOUxvw13TQePzzslBoflL1YKHC/9Ow8aghh7d2feh2wOcnQZchGpdiyZrfoOSaKlxwCLl2+kW+GAYo8d4Ng6UBI1zgxVxrvVxbIvWX/M18ddyyTUOpc3bJ5UCI2g4M4vScmNWdvA7EOc/rRseFtkwIDmDRmdus2mT6c9CkfmJ51vABnRFqszmrrYxc0o4kEXKDqX1VpFR+bX8nWyfg3BFAs7d2MEyAX4bUjRm8Y6b3C/AsVlfId8iaeA6umOY7XjwWPzj9iIV7ibBOF5VcRien//GjATYFckrJczuUqThIihIptN9pOSewXp8gDgvjYqrUGTHdxus4cAHWBGijcMgcqlMM029oaV3gfpcb63OfSKZpiX974PBJjrWhiQQGWoMB2AeI3t/3XW41MYcGiQ3KqXWOihSle3svisevFczfNsOOZxrf7U5fscpOXE48MWMPvTZWWy1rccr25
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(66946007)(4326008)(6916009)(66476007)(66556008)(316002)(4744005)(5660300002)(8676002)(8936002)(41300700001)(2906002)(6486002)(54906003)(86362001)(478600001)(38100700002)(6666004)(6506007)(6512007)(26005)(186003)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s75yBUvKVVOKh+MgjjOdqRAQzIYkBz7GwzLysX9SZ1bckHHmRZf5zsAURRQp?=
 =?us-ascii?Q?uKPw9kskevHtFyxa0MU3LC5LEEAFX05cfuQYECgYgXojBz8u3b33qat8afnO?=
 =?us-ascii?Q?YgCOsHuDB9EJji6erlEMExKrja8dcEl3zhO/Ln35R3g33jShi6BYN8R+DGsK?=
 =?us-ascii?Q?qBnJh1MlPRc2aNvoVl7KckAcn3jBN8bSgfvC6aAZRY+rUFbfYUOno+z2OpsG?=
 =?us-ascii?Q?l0KVlv+6Wt1gnUNQBUJScjYD1C0/FYa88EV95ZEqESLa2mYHMQmD00GdE6RV?=
 =?us-ascii?Q?QhCvIoi/0h6nagp7r64YT5yXUPDWMnshGihmszS4UvGXA172F/LZTRFXYsur?=
 =?us-ascii?Q?zR1myftr1Q9S4XX6yM6Y2BvnX/dEtygpLXReVHX36bGLixOy/BBfj6E9YibU?=
 =?us-ascii?Q?ZV3CSzT6/1Ew08tjaceLrmkw/IAkNRG57WeUtc+MWhuuzOErkPkfkZiAj8se?=
 =?us-ascii?Q?yKQqU4ADh+yxMb0ZWhQ1W6hRN/dlF+B3Esx86mvMCfEqh3wyRmrcAww+MIDp?=
 =?us-ascii?Q?sFICKS4vs1mRGTJCxH+3WbL15XWXT87U/jQujc339BTVW72hWYsVlbdqwBRJ?=
 =?us-ascii?Q?GVPtPWEqnwXqE3l+2qYGraFne9Luotuu4HxLecW9Be+pdeWSyCWMo4vFb7NZ?=
 =?us-ascii?Q?jsXxenvzq442Yb8i6y5ZOwvnWe7zG52ruipXZ71oVctql8WrOY1HRn4wmms7?=
 =?us-ascii?Q?ajvMR6/CJEpDXinOSEc29MhzFt5tiHzsifTxwadzr6yvsjY+ctyQ2j4QEi7R?=
 =?us-ascii?Q?6mycTN2JWxE+JJk6IffuZQqZhpVZIklI0h5UCXctFPK96rTAhi8dszUlVAsl?=
 =?us-ascii?Q?nVv/nHLWj//V5UjAX0q/7QILI6SU6xaNn0EgKrv27sPBT+sW2oEsBTkVx941?=
 =?us-ascii?Q?LTYBbE4YtQHacBpC02n0SEr2bXO7BXpymarTlq/qdzsC11GBkteq0lzNoH5R?=
 =?us-ascii?Q?8lZWj63sa7dvXe3MKV0HJlaYwcqEDd+bwsSuTZ/J80QJ7f37T1vK8gNW8W+H?=
 =?us-ascii?Q?MRJZ+A2f57ORH2rvfU+KgHMcjzq+fqO6h8IN3ENUw9lj92uyGjCazrotinyq?=
 =?us-ascii?Q?EUycLmUYecivVl3WPzG/CMZSC1y15gF89KbUrLEh8jYJdgbRWYVtj+nVxKMl?=
 =?us-ascii?Q?AI/cyIY4BqCz3irQu+sByNclVUvDkXy7lTeBpNJWqwRCl8IxdTKLYUslV9fD?=
 =?us-ascii?Q?nWRVuNz8OaeSXa7vyTQz+/FD9ePQm3THNRRJ061s31p/AbIkLh60UftOwe0b?=
 =?us-ascii?Q?jOBtjrF+POmQNY9uMHPYMSJCO+eCVX4rvYsSop1IYRjIj0wvtVYUc3YnOtWu?=
 =?us-ascii?Q?d+B/BH/eVr7RZV4NIGitd9kj7+CxtEsz3aOUJqv7Ge2/2UrOzt9v1Z0VMDgZ?=
 =?us-ascii?Q?1NBjzWMZV/chKfD1tXgQ1T3O0tG7VWuqtfZzxfT9Ns4cgOYB2pkda/je7uhT?=
 =?us-ascii?Q?yduwExmd8Nc6qLvD+bdFgccT8vzbREy4pV3keGLMnglKzqUFSYzsG67NSAga?=
 =?us-ascii?Q?uBg9R+wyjHleuUZn2Q/4X/SG4PzUAG4b05pByiKDeOMwG+H540E2vf80duFv?=
 =?us-ascii?Q?QdplkU3wKY7gvdBZ1Fj9hKhugUGLP2r+5RIDzqdGDBHyj44TEcKlbTzsLccv?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +JlGp8atMRAgzWsnBscqhKB/DVqVR7PT/f4ePmCQ9odewQsH21DHOg2+pH5uuhCb81at2GsOjcobGrgaZTaVj+UPCm/FyEui2xcsTi1wu+lX+9hZdzbABwC8i6BP4xW+5DUH75IwmIHp4xsBcLSb6sO4hcUNLXkQ/2gEpEmiHUQhF+7fQG1UoznFhhCFkBVjgBFLUybyGUGv0F6VGu5rEd5bp5rUzt2Hu6fZEYm4XUruyigRQbkYBoBu8sdY9Hl0tJNL48vd++3RVl6z1adCXWdEGSGwgsSnjYVqLya70dC/YmZJUIgvYCuzbPvcGcvT4SktYi1429sUk+zrJIf3jE9YtYb+A8jrocf4Cv2y8C5N8dNCSgkFc3Dob6uJoTC45IVUz4uzWd4YMX4rxexDXYKCoXj3CnXmg1OUoH5yjz/B/FZ0SDfYC3tGVoAO+G4x7vL+GmH5NpnAT2Er67mrz15HNiEhbuG/nt78oLavaBdJ0KjQX9dSt5GatBUXUvLk/VpTRL1qSeYJhxW9UlWfzAocFLcRwzF1544GLmHSBBDQG3Az/CTMQA4lzoXRDUSjYIXPVv+aJuAqD5TVylO6ITSViFjk90PzMJ73pkWXZsgQkrKTO8oC9D4k/9Mcfb/2a4QZQPjac27dlSTpJwuTDh93fWcRQ5ZN6gEn7Qjoc7pcRJbwC2cvOBqUD8kLwYmy+RbY4LbtHeTfj8AkkvLDbH3BM2kap3rAPmf9gbqgtpiXxY+Kbz6/bQ/AUKWpWNw61CJmUQRORt/Agko5wXTKK/B59uuxgcq2pzEyU4Ij0wIzLlKQLWnKmr1kxJAT2XGr0+w+2QsjoKJdC37Fst80ERYkM25E2kHyT6LSOl9e9UY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d9fd22-a487-4d70-a3c1-08db72be5baf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:16:51.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hulMQ8ZGwdZ36vWyrTcTAoNzu/xfZOkxrugNTlzGMFgGOfWgQYin8hkJs534lgpHxuT+ubXYfu54xaDmPwgOLOsUrOYFLQJ4L7ZbXLSes4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=692 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220007
X-Proofpoint-GUID: WO6dGpBhRxeiMQFR7M6psHt2L91JIE3B
X-Proofpoint-ORIG-GUID: WO6dGpBhRxeiMQFR7M6psHt2L91JIE3B
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

> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element arrays with
> flexible-array members in a couple of structures, and refactor the
> rest of the code, accordingly.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
