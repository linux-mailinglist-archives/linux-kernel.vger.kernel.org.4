Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEE718688
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjEaPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEaPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:38:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695412B;
        Wed, 31 May 2023 08:38:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERMW8021971;
        Wed, 31 May 2023 15:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=K4Vp/wG297dCDno/rYDmxslPcuR9l9A9DIV3PooKFvQ=;
 b=idYT3j8NBiN7sQf7fjEgargJCVfSnkc4tTRtK66iwHg7v2MCriDm1igNFGtAX8aFFBot
 92Rk+LDLAUoieLVYErONSCwbNtAX8SivLWcGd7YNKoEfCsv1Ywz9I0X7eGDMyb/Gfqlp
 xlib+nj1u6G7jGn+C9F6Y0cELrVEEkU2LqKQb6dQXCIxek5Br5tQ0lQwdmiKZNaPdjN1
 +eHiRyxnWfXVRiX1SXYWKRKJRpTt74XcgXWwvz2MAgRg6wGXePP3scuhHoKgZzWg9je/
 vC9CaOHCNV0zQ57aKShK0S/uuDe5vkQRxv3SFlHh5hRU5ELvt/H9P/1OQy/7sju9h7pJ eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjp7t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:37:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VEKVZO014704;
        Wed, 31 May 2023 15:37:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a5rssd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tex5pUfhGHH8LSeI2Gt16jxlevLlKyZZTI2r58C2jWFhei5iHbR2b9uSzLpRaberwYDkNKUeGP4JRlLSPAS5QLyV2GDpA4fiTVtdEhnojuAM8J5568DyMdXAw4bfU8SDrQLCe9NfZz9au3jlR2cCP0Wv4zHNUFzAGW9G08FOFQU8nKVgxxVEclWgXp8XTazPwaD0JRnMjf8YsTC9I8ivwzVZAI3zp0rCy49xe7At9LC6gGlKhh3LcahsTe0Npob7uNnswFbRcmBU8xmIy5zwoHv+17OCT5FVwlUVfmDg6Mk8FZ2XkZjk+PSVENWlXFxj91OHcydmpZCFheH81R2u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4Vp/wG297dCDno/rYDmxslPcuR9l9A9DIV3PooKFvQ=;
 b=IqYu8DjPXEbQxg/AuUv90icWWJSWrYsSJJUjk+SgKcKPwj6YC/3e/V4rNcDcw9Dty1GUwwkErQdeHOEGfbB84mYaMwGa57t0EHxsPAaLXvc70c/bWdHLWK87cCjdQ7S+PF0RBy3HsC0sHvVGPyAwvLlbfnvvm2oKvlYq5tZ9HJj0NA+DGkvlL2bA/wH6Ow9gIIX/I+Ktz21JulNUX+vw053Z2nWP3QKYM4VrgNWd4ckYtzpgNPdGk7zMMgmJINWuZYrUGp8HOai2uds7nQHsCF6FR0yzTrJ83Gep+GADN38XMtOk84DDVy4KepT0+e8XomxzsM24haQFEpoz6zXBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Vp/wG297dCDno/rYDmxslPcuR9l9A9DIV3PooKFvQ=;
 b=mi5z/7FkvOetQxjRqMz6HO8/PjsJSBpxYFoAStyqCWpg5KChyKz/dDrGECpbNqnVvf2PHYFfBjxRGwVqWuEDoY6octMGeM8FvRMHftAxz5eEFDkzz85Owk/fRE3uQMtTDvfuXyXLAVlfwcG85rfkhQEaE3UrdFmtf77icmbXRxA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 15:37:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 15:37:50 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: virtio_scsi: Remove a useless function call
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs7cfr5m.fsf@ca-mkp.ca.oracle.com>
References: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
Date:   Wed, 31 May 2023 11:37:47 -0400
In-Reply-To: <08740635cdb0f8293e57c557b22e048daae50961.1685345683.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Mon, 29 May 2023 09:35:08 +0200")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: bc838d34-86a0-4291-2efb-08db61ecfdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5kSE0HrIGbyHOHAfEOu7li9rH1N9QurbqJX54iZUtX16D4iQa5PEEbPes6dUf9ZLW4fxVM9B0dgrTxLlyM5GQzLCNWnq9qORlpZqMmxSwxbVRyxgRdda+aKb2yO5RE6z96LawcSKjkwUJNyKZHdZa21Xv6UoUpWS0y9xrPWHrv6fCNxG//nXYaJ6aNhQcrQ22EdTRQ1yDmoJx4mH6BOm3MCb43nGDmnpMtMs6cD3PTGc7bnqh4I96MO9ItUTMga7IIMDEAGyBKYCVhSGJEzcu2TfFeZMmhmTp2Bu0zTP8hIxG0AbVzHmyDq2YEA3vOO2jU6Mc/otg/pNMaAVRGIx17PJb7Tb7SaY4uxeGqj5WbYl04DF2DyLogN8wexQPv6ix3T1bAxUsIYW1oIHJEDuJvlyX5K73CciFK9Vbg9rJajdwfBQ43QZVRmkZBwjPTHY9xeg2ILhFFbcX9mzX1GaDN4Cd6mlzE3Dp4HqiO4aZfs7d/3bIactpTnRoheWRAJ1Kp72aOIjuV4ueskOQKsq/Ke3qvTnSjmQBYpdm88vhlOVa8cSUGPs46iBdsgi6OD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(6666004)(6486002)(66946007)(6916009)(66476007)(66556008)(54906003)(4326008)(316002)(478600001)(558084003)(86362001)(36916002)(186003)(6506007)(6512007)(26005)(41300700001)(8936002)(8676002)(7416002)(2906002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vzgYwO1fACElWT6jlHRfCYgFNmjBh8yCLqGgqU0jHamTxLQzUhi+6txxkQ4?=
 =?us-ascii?Q?9k3ioK92au6fyqCuk0e8vzRww9fIL4CwWx1jQoPUCNpnTEtPT6vdbCURzYip?=
 =?us-ascii?Q?GpQsDxaiZ9VzmRvnR9dqxWj+ht01WVgqax04OwO0MjkrH6hWGxaxUcOOJNGS?=
 =?us-ascii?Q?zj/UcofdA24iOSKyM8mCK4QDV4jm7WjLGy5W0m2JNoSUT+0GTpqCCQsEi9AV?=
 =?us-ascii?Q?2Dzw6yJHg4KPUHd1rZObVg56E6qKWBDF5Do6PtnggZda6wjFBWR9UsUaEejk?=
 =?us-ascii?Q?ALxz/2DVbGDsnfggkeb+RqApUrtczfM1AipAFbhWp4TLV3flR+7uULTiE+8n?=
 =?us-ascii?Q?S0B8a8rE3llOGCmMPxfkkHX/kppdksBcKfvuY+yJ7HiuTSd+Vq/To9pRwsQA?=
 =?us-ascii?Q?Li5SsHskGNBjLgXeaMQ7iP69nkaE17VdWtJ2B9tSWAfJ9USjWaHUZ8tZX8pQ?=
 =?us-ascii?Q?otugx50k7tHRgXhWNOY2Ex21ihoY00O/qlGmjpxGPH/mZrzkGYwtL1C6gN3B?=
 =?us-ascii?Q?NQCegZJch1kAMSBa2rGazQjK28BcgDKaN9nQpDzwPZ+e/+mJAEMPuo0Ny3BG?=
 =?us-ascii?Q?hfgTZDCb7pPEocqHTCVDT3aYQuhQpSr549ETqXgXWTedEmGOCg8KwWyPo7Sz?=
 =?us-ascii?Q?lujncguxy+gBMDeJw98V91F4YB3dA8n+k6QbdtoHgEs/8FWCAme2KG6pMI4t?=
 =?us-ascii?Q?ZvNesmIm2aCy+vkdl3EBYaMxng8/Xx2VpBqPXhmmxoDgKawWkKjQyXg96Onh?=
 =?us-ascii?Q?nawBO9MlcSW4JpFDunn44pbSGnETOI6pU8WscTsxxq9Kn0MKAWXswJ3dzBiJ?=
 =?us-ascii?Q?DY2oosIi+oflxZ+2muKGASWwkZjG3srLm7zVeRo9I+t09MEOSXOKwc827Yhe?=
 =?us-ascii?Q?KFFUtSGAaXpaf0ascbLBwYZuIWevhJsfQIlD+kritA1GjXdjPvf7j5w63a1W?=
 =?us-ascii?Q?OPA4CcEWmM2zMoZ8cn8GOPoHl88r3cP27Ocoqriso4TRfNv5hOndnldI1qoe?=
 =?us-ascii?Q?P3Yk+JFdeEpaDegr5Ezc+3cNrqxKxEQG7AkLaO0aYx6TsrY4griYSHnhq93a?=
 =?us-ascii?Q?KZhscdO1hJku2XcMzYWa7z1KPvb4xuSuuS6YRr+pR1WhDlX3x0F8AvhJD+92?=
 =?us-ascii?Q?Y+WGgIZEnzPaFil5OJq1lmw//7n0WUqiodTKsC6BIIuH6Ws5KW7wBNux5RkP?=
 =?us-ascii?Q?WJc3ffM2ZIxE4xAwIQjHxXJriQQgTdgkLnQ1FXfyDvkT8GB2ktN0+nyV/NsV?=
 =?us-ascii?Q?Rlsw5xOUjDzd067mFTVzCAD24HdW2HyVXuGlUfl4J+UQ8LeaU0saQ2GnzMBF?=
 =?us-ascii?Q?QIsP+t655gS3BMEPMfMS2KDJQ79Yo5oiw5arjmmLp9bLvbtFAhIRMyZmiMxD?=
 =?us-ascii?Q?MH6CD6G/VAPBZasPXUlobgPaif+uOuWnryYht/gDp+W+O1Jjo66E+ESloUv6?=
 =?us-ascii?Q?rEZR7/yVtGpSxc9Vo4ZC0/COMh1p7uSAgj/4NHotOtRh5ux2NLu/Rkr97CoK?=
 =?us-ascii?Q?9sW9qzFH8YLBUbB71Yr4yE7/VDhOpEhCl76sG4ifp3yqV12hRu7otFWYIEpK?=
 =?us-ascii?Q?R7XmE2HjIg/kAlcNv/J9US40S4Wz1qcMtShWmIV05qQ2iJ9H4ggfGcF4a0Yb?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NKIaJp2hhPxt5wqqMiKZSxBLUTEgY9403sGouLEEOL6DbPj9SSjIYEQW7SDQ?=
 =?us-ascii?Q?xZyfbGHWcWJrOad8dXoyApc8F0Sm89Sd9TV/9queqK1hpx7ZroVXrrb5I0Gs?=
 =?us-ascii?Q?uQg3YNdfoAN+o2YfULmScIbQOF0CE5/xjdSn5SYmVVl2mFxW4kbxagwnZ8n/?=
 =?us-ascii?Q?z5ul2UhnxE46eQkcoIt6w3SJRWSdHS/Lpx7a/9UaVcZ1hGbOcS3qC7DlDcyt?=
 =?us-ascii?Q?3HzkLmF63+ue9gOw4JGD8hFyRIDJOZMiCpEMfRZu6J9KaewyphMDKQ8P50vC?=
 =?us-ascii?Q?i/xHHG7+R4lJhqApwvxZixcUAOUoLbODDmamX6zJ/9KP1OSEHbl8nBB3peB5?=
 =?us-ascii?Q?QwUOvkxQp6b2BCRse5YLGJKft85gSXgX7p86O9VplKX675X0NdSzm6jLBqLZ?=
 =?us-ascii?Q?4QWRthbbFfZzt3PhxLiqE9PsZ5+BzbkHjguJfUR53gmxuAnuJ7bCpKfzaMAj?=
 =?us-ascii?Q?+Ydt0v5YIG3TRQ8bIlC38Sa8Jap2OmjRk82sN3bMfvr0CTMZMw2hpPbowNq9?=
 =?us-ascii?Q?0wHxbnBGQ9BFxBSYcRvzKFZwST7obynwqudwJloBtpTS4GpQxkag8Zd2o9dd?=
 =?us-ascii?Q?TnF1vNoFmpWtpCiLYzxwbwvakSI3+iDVEAVJF06IF7k4imjwXPMLUm31Q4ip?=
 =?us-ascii?Q?IORKfX2/7qq0ih+zG9I6P6ooc5x08VrwJC4RvURjY6Mixr1Q4bqjYmotfaHV?=
 =?us-ascii?Q?/1l880SxBjwtCr7erGydY/SwmUZnFVo5N+4sYHkDsx5CnthKGOSnhpC8fWXd?=
 =?us-ascii?Q?VFkwa/SGJCcKBM2E7h3qIGhRWpbeRA1hh0Ac0Kxm3sH48sWvFB/VGkY02iPJ?=
 =?us-ascii?Q?u8Q5w+L+b9GtAbdy7YG5sO2tlV71y03kIcMiEqT/twgqy1xjV0m2B/CJyYek?=
 =?us-ascii?Q?3g8Oku8LpdLXdVE5qTdEx/PwFoT9OI/pXQAJigMfaohOtp2QBkXmK53jswzK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc838d34-86a0-4291-2efb-08db61ecfdac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:37:50.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGYHCDaGE0iJeKha9I7mSrsUE19Gfgwx2S/EckZ25rCXxAEhy0RN0lv2cQz4pIydl+cC9vyAGlKh/KUy0jvbng+l2NUWXFxfy8cX9GBDbZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=746 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310133
X-Proofpoint-ORIG-GUID: t3rrt6Bji94BdtwBnFOilBkBhN-ZN1BO
X-Proofpoint-GUID: t3rrt6Bji94BdtwBnFOilBkBhN-ZN1BO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> 'inq_result' is known to be NULL. There is no point calling kfree().

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
