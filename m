Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED07A727400
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjFHBMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjFHBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:12:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36926AD;
        Wed,  7 Jun 2023 18:12:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357NSmar011468;
        Thu, 8 Jun 2023 01:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Vdn6UX7/u/KPUpDUPTzEN/G9yrdjQFWEZUfJfdurpc0=;
 b=VcnvFSpjctoX2Mv/VUChqxzEU3yd33HK3PIN1+VrdAC/1hq411K7jxpBwT9UrFaT28Lx
 DtY2Hv7u1uhzBL/iutsb0EdORzhkEmAdVZjThjfIQBWAKHbn6EXZ8btijNa50JVVKhhY
 8rCK6ImTKqzexR85n3fAyndU2hTs0x9cgg/xbbe+jsPOLrHI1QO5PsI5dOHJmP9/Z84s
 ve8uGZKXvarApQumRbzbjmgtXnsrTzPFvrgZqSPeJRZWC9tULV872Qb+q6nwQW8dRV/m
 WoVG+mJ0hm2ZSeOk1zO4qOGGyVlvYNAb1xi6PLQRKkYTPq/DTVChViwDoMxECG30tDe0 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uu5rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:12:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357N9BtF035912;
        Thu, 8 Jun 2023 01:12:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6s80mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPT3WzYbSJcorGMJ3zZ5oJg2Mha3ItzvSFMhbT7px1xgyLfpAVjzjC3RKQzDKIDEgnUmZCQ/Vn4p5x1Hk+/zGsrZqOvXFVBQ3F5UDbarSsC7gQ9qy1PZSsbyNu6yy59Dmq60WEzdxLSAi0ZbcofKTPdeJFlUXA6u4Vwga//YonDkcjaA8G35wER3GH+xkg4OLHVFcPTdCo3vmLS/K8w46lHj2xZSdkQDEUwDJEA+fAzEysMwxhty9XiMsJ6AO23n1sraxSbQXcPpRYYId2LoclXyF72N48Kwk4QBzJhqaawFlm5YEta8QFqzTWf24CdQnnakaVJu0Js1Wt10eETnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdn6UX7/u/KPUpDUPTzEN/G9yrdjQFWEZUfJfdurpc0=;
 b=D2CYYzxhNk5fHAo4EVfgdNJSM3gTuqwhBkJHVTWzd77BBJnvOBijRfU4/z634IzPfpWIwDBJwHBQoBATWcndCM1YfEqre/EKoZHs1MBGmawBXl5RCVT7D1e/ZVwHeG+hY3LVKKImUJjrr0Ll8nrxyCd00YEo0fgMud7G2YevPfYzfmgDulRyssf12Lfqknr2gdWvBr5yjQ3vwLNYUjTYS1f/HTvtIkpHxE+oWDYHDEfcr91II43mFXFiz5/HX1xPqMud6+VET7nlQ1lLHz9PNZ7C05msUdJDYWyJacCMNh1mWBIOBpjLw/uhbVVbHT/ChywWtauNeKpsRXk7Spkxfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdn6UX7/u/KPUpDUPTzEN/G9yrdjQFWEZUfJfdurpc0=;
 b=o8EMo34n8qx5Kj6QFonzjOGEtCxwh+eo5PvDz2WvmEz7XFS/K69KQzOIHnQUDis9/WEU9N42CV1JQjw5ZYNenT8SoPy/H1dSt6mUPFgya9/OdAG/T6joS9wcUnfiuGFlhQfOG2YGOb7xQyP5aPoAM1FxuBKAgQCz9S7CZmk6j68=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 01:12:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:12:22 +0000
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
Subject: Re: [PATCH v2] ufs: core: Combine ufshcd_mq_poll_cqe functions
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm664v14.fsf@ca-mkp.ca.oracle.com>
References: <20230601225048.12228-1-stanley.chu@mediatek.com>
Date:   Wed, 07 Jun 2023 21:12:15 -0400
In-Reply-To: <20230601225048.12228-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Fri, 2 Jun 2023 06:50:48 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 580cf749-9832-479d-a3eb-08db67bd6977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AUSSSQg+KS4usuV+LSgiUS+X7T/V2AM6s0Bc5hwNshHBzH8j8L53tSHxe6pqS4XN9fh89rztGcpj56tGaQbPLCasxNBXF48fW95CzVyH+O0vKxLnOvjaqgnl6bvleL7yOvn3WnA8ziq/QeOSqBMhBLj5tbF3mCnVwZmBvl0LK5eSREmuPl1f0oCOAPPUd5uA8UYJU764g1ROvMkwINucsfuWaLjht9Awd91NWeD8JRtXCuNhsRGBKFvpd2qrCAHh4j+BmjlvJ0J5asLWSiPrt30PTOva1jmxsvKeHSqn0hsIrCeS04n5YpdBTqthkgJyHmqVWEV9TUlWTcz3mzjySas8uowF2NHWoMfDt7QJ/4vECUItm6LQpNY/kmgWygBZhQv4Din1fl5TPJXSwgKrglhEcjmCoAcg+sGs6Q3DVfvDlOlrlfWZoxOwsaqj96v0Zqdw+5MVPVhSRjbb4aamZ0VNcAFHBANJsEVZNjQQzJ7aaQ/tBN6x8d0uKSDWhd5WnAYX7Jcm53E1hk4sgzeG8XuKvCK6FlM5tomu2PD3WudWe9QV9iRFZaj1hjxab31
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(316002)(6486002)(41300700001)(36916002)(83380400001)(86362001)(6506007)(186003)(6512007)(26005)(2906002)(4744005)(38100700002)(5660300002)(8936002)(8676002)(66946007)(54906003)(478600001)(6666004)(66556008)(4326008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zX/B4xBWhvJ6U2SoUN69KMvjjgQiQbI5bK5kMFdqbhYdyHFp9bfZFesmzqzm?=
 =?us-ascii?Q?U6XY85UVUa5aGH4vT3yoDAnCAPsJSd+vNIJqn588tW62D4oiyz5P2oW+9xC0?=
 =?us-ascii?Q?BCK/qOOOEAmI2w0AN2c6SQ804YUxM67rzX5h5U1KiWbhwz2iHJcZKUnuvazY?=
 =?us-ascii?Q?r0nZf1rpnnPctX7oYoh58eVPPhawijNb4xerDn4UZlrce9w0VS1nRMXJVNks?=
 =?us-ascii?Q?GzoP5VgnXn7k5GdLZvv//ZVokOwryapthGA8/dWwkV9vRZtUoKOf7llMR7Fy?=
 =?us-ascii?Q?E38ZHEuXs86fJ9e4cDdHI+L4ConVuVkRQ0WDmIQAO6mErDHgQyyr0gdZiP3F?=
 =?us-ascii?Q?Id3gAE3DYFwhDsG/wA5CKvntUbOJHPuDiKGAVFAZ6MDP+ogPoaXSS7DycMaZ?=
 =?us-ascii?Q?emrToNxJ7CUbGeT2/czeoHSckd782P99YfM9TgF5Wn7YsTj4GExsrDBO8Zwd?=
 =?us-ascii?Q?nt2BLSt/cvy7S2bCD6V6NDHrlwkAmR4MSoLmMYeKjDhvqOYYs7vuTRiOpOyZ?=
 =?us-ascii?Q?niVi/Xi9cTLeAFjSF1Miw1FAWlIdoRCaucZE/sPah4Z7mA9rzgK51/Id1dDV?=
 =?us-ascii?Q?/Ub7753K5+Q2hVevx8VM+qPZQ1AI0DgrAPgAFnfJ+E2GJBSEwwLfbDavXiM9?=
 =?us-ascii?Q?9uM8eJtiV2MCinaSYyzOCsHmUaM6Cgp3k0cqyzj1JDKCEc+iZ+KoDGcAyE8d?=
 =?us-ascii?Q?1GdjyUbf3iYOKK79CJijnDy5nDMPOzyWyJzK6vY9XXSmVarsFmT4hN/56Sup?=
 =?us-ascii?Q?DDFzV0QzS+Ou+asiUrXJHpbodA4M9z7+2EZIqRLdeBuF3Bl04j5d/5eZHtDH?=
 =?us-ascii?Q?LjGEBQCOh115PcG10dbh12UryCq13BadcnANFCof5E5pAarHE7ZiOGJ02uHA?=
 =?us-ascii?Q?Q1vbda7esgPAJyYtTi+AnVcBqbM7Zcv0y280AprnA/pwNaxk0kdipVhvTbA3?=
 =?us-ascii?Q?EYJRwZPNH6PIG3BBVzBgW+/T8TIYeqKcRls6xZ557kiRqWMMLOBp5Kc62LTX?=
 =?us-ascii?Q?ZN6pyWDt7iQL8VH1+Xmmm3do9cie5HIcf8i3xMpcDKiEKCYPC/AEhxOMVdw2?=
 =?us-ascii?Q?fuqNoeaJr5uFZC5BXwlNy7ILuH4Ys8jN5GXuhfZX2sHOcd6Ng/FKNSs0GjfC?=
 =?us-ascii?Q?8lzDxXagUvjZBJ2Lf405xgGYl5nYtNtYjQgYD/5aydEXcAaVXsBqs0zK9DtH?=
 =?us-ascii?Q?C/14FqqOyZ74OiV2HIpOo+RpXyYw6sl5tuNYG+TyYeJfw6GZP/GOWfKgXmMC?=
 =?us-ascii?Q?0HcvcQS0q48OAL6/b1ibyCg7B0onfbbQY2L+Mao8cMEeRWJy2dAO80wi/OEr?=
 =?us-ascii?Q?bcKrS+tgCZGfR8J/Vqsx6U1PpG8fc5TNo0WYEwSbiG80PWzxRIHVnUtE0OQ3?=
 =?us-ascii?Q?p9ifZw+lKfxbb42znq2fwhkczkjyDhw5Ot+56FRslGO+QwPduC9wMviRAU7V?=
 =?us-ascii?Q?pYfe7xnjmG1La3NsVVfxt1AEgVHlZdQf6T6nKZVrnYhElPGGSQt/ALVAR7Iv?=
 =?us-ascii?Q?rc0T1efEuM5V+YHwnb7++VdrtJy6p36Ot9Z8J/rph0aIgVgIcQISSrRrzuty?=
 =?us-ascii?Q?nPPNvKOGofKsqF1OSKzEFNSRyI+M6w8u6ADa7CKx9Il/3MO8/g2Lli5wA4p2?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sfNgeYuIExm2+XasqoCAVvOxiozeS63Ory9h7Iygt/a3Dsjy/+lcLf0Hc3HI6EnMBFMwD39chfg9VObZro0VINKEJ4Fw7sLa4Fy9jRT1TPi/q3oskMXbjrr0dFm13wN8TCiOYRBFWcUPoI73HMnGAEKgw/k14U2rrU+UU+J5EYOAN5zH7xUsQoJZvxyDYxVyuE52InRmLxHL1vVQKg5IlDvC/wfZVe1TEouAYK2EuvhQI2Fk8++zotW0zgL4c6AqSBmXxuk3FRoZbsN9zOgZfJDX2I93YMNwP3kOGPELYWn3QfJEGpN+9DSIEnQKjslM9pDShGiPqbV1yc5KhGLEhjU2CvRHS6HO5CYM9a6sszjcRAX61ABtOmoFYd1Ik9m4ngig9nEk6jLcHtRoRumABJZpU7Kmkpmcs4M8RITXyKoTs70HNDQes/CU6hrN1HHzNBBQisuJ6nAo5nQDCNS76jcV+PC4C+FHCfjdJNQiRbMZJKfZyvoc36v9dYiQUqz7bJaZOoiSjzKDrAtE8+psydO3Iide4na8f1xDdLMGbWqx5nl0UdmtGX9NvirmCF5kOg0+gFIpAPvwF8C+VytguagRd1G7Swit7WoAvmPDWt8ahjkNK0GD0No2NoE5wpMO9XMksHAD9OOg2ZhxPVMVivsukZ20DBnLN6ph+sWV+tR32iX/NFR9UUR1uZ7zzbqPjTxjF6zAVCf1XHL1eVqv+MwT6oPG/jVSb5tuA6tgE/+2Qy8ZjZYl/pZ+nQ1nJ7LzqI/ozz81Zww3bQfZ2QdXqV/ob5AWt97IqKNhNM9be1rv3kGL7NTrvD5cl5c8z/xhE6k+hKpfr6odRSYEKlWJ1CyYNp3gi6NlqcXYpBma70Ko4MQBJH/4yj6hXdJfsuBUuttRpG2bhl1+UpDx5DuFjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580cf749-9832-479d-a3eb-08db67bd6977
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:12:22.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCDFa0zZ80/dBZRmIMVm9sY8MQJuxTAfQFEWQL8zMgWXE6PyMyeoXE7oOBIvKZ0y/1greEsjQb86F2EjeBPo4Vp9qLAtqERRhbn0/7HTFDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=762
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080006
X-Proofpoint-GUID: EyBvwDctXwhAj9Wuvb5LKlHRkRpEJgc1
X-Proofpoint-ORIG-GUID: EyBvwDctXwhAj9Wuvb5LKlHRkRpEJgc1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> Currently, ufshcd_mcq_poll_cqe_nolock() is only called by
> ufshcd_mcq_poll_cqe_lock() with the addition of a spinlock wrapper
> for ufshcd_mcq_poll_cqe_nolock(). Combining these two functions
> into one would result in cleaner code.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
