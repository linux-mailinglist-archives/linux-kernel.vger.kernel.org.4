Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F26B7EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCMRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:11:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315754E5D6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:10:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DH0CrT022831;
        Mon, 13 Mar 2023 17:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=KyH+F1sDtzem0VhGONOId1Ga9KenqV0TkTwzelT46tY=;
 b=BuIQUC17hjXCNfa7LE6ipRDgsDpKTXLVzFZMulJr6XriaYACklD0UfZRIhNE9s3NbguM
 cFwaFZ/D7ew6abMqLvdiVzW5BioX/CxMNor1Na7J7958AGwiFackE/woheVFBmZD8zgt
 hvIKiJ9k4VjJtZ1C0By/XOPg6XBw0pGfIhVUc3oZEoovlGI3Ud1xiQS7RiJlV3bqsHbD
 EZsKL+dLokVi6cl58rZYmIOmi2w6gSUw4qaPP9dgoL4Hw/9AJQynwc4DvmUEfWSgDl8/
 HMzMxXyvhUf9f7fdryt7ULC4iECrB6+BLlkiwwOpAFdxMiE9vBciYSkEl+dle/iWdFZv tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8ge2vc6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 17:08:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DGjCL4015268;
        Mon, 13 Mar 2023 17:08:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g35fsbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 17:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSwimG9O0dZbWVfp36Ek5jPOGoQIrFljNzdOhofghzNEl1XgMeYHQ7pCiVmM9uiO2Mp6aVuwL8lszlTMgGMwmUmPmdd4+W+skJnNCjx0CCiKog8cypWbv4AjrHVJ+fheiLNmILGuRBcM+Wh4fs6R7jLs+xs5b3PxZn8Homi/S67rMiwq8aoGa38ixQyZEGIsBw1F0P7fFoU29jUrHcaF8wCbSPOcme62/KuJkg8HUMGqQAPwtt4HMIwcsChOqm2JlciCZk+69wgTR9QH3+j0GWaZLmAM6L0eyhYTEti/chNewKty3hBblT9IS83XYF2o1//LA0zZP3BFWvjMppbbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyH+F1sDtzem0VhGONOId1Ga9KenqV0TkTwzelT46tY=;
 b=CZST+cj8QCn3Wr1VNrxM2zKKt8qr6FA3UslhoxPPbaSdWw1nkp2qjKvYTqU9Rkd5eH6B0spoq7lZjOdbBeAlkxYfqnupNL2GinJWzftWj+yg6g+EuUYunNmUYFoDd8Q6ZCvd6yE4Wkpqk41alYd0eVJYT4tx6S3xE83cBurF+DMq1xIS1KugknuQpGdwdurhgBivNl7q7lKQGb0Yo6WyUxPIuUBroODn/N0eUgR4tExcalwFqOLK+N6cy4o4NJPTpmwf/OtFHFTwh4Nd4hmlt8Cli4uVlHgGEul/WyYDC4E6g3Bnv4XVHtYjwVN/xFuABGogOqMGHVYl80dcdRtXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyH+F1sDtzem0VhGONOId1Ga9KenqV0TkTwzelT46tY=;
 b=GdXfOE1i950j4UnwA9RPA1qQpXs5hHJdOfF8EaaEEHHFZQGftM8/J29ww1IicukFy8yPepuwGfTGXsdDG56xWxqKT1c3gG8Q5My94aaRZQQka9ZXCiEB8GZWQkmDa1o1r6/GxIqqVONHPlDUOnBCoAEEciZP6Rk5FO00mfaV8B8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO6PR10MB5649.namprd10.prod.outlook.com (2603:10b6:303:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23; Mon, 13 Mar
 2023 17:08:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:08:41 +0000
Date:   Mon, 13 Mar 2023 10:08:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, vbabka@suse.cz, william.lam@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
Message-ID: <20230313170838.GA3044@monkey>
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO6PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb3451c-3f91-4a03-2b15-08db23e5984a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1ORb+5Q6OEVckKusKq34NBeZMdM1cJac1RCEPJ2djbX2jTlPKicWRBhRtdAQ19PEv2fD1llb4eksYM+OzoxjVbw8BHAqddAs7mfCEpVVO82Yj9VOTQn/WOIJIsAH03gIU+Z6Nf7obD4CSauXd5sx6j+HPkrUCdPGSf2jo0JKCpCZr51Jif3d4J+MA7a27LS8uMJbqz/XqPSt5yULpH5Kx3jjBwI5vDrwYSJCmuxIGBLIYtiNSdg1tWPAmS3DK1IcXccRJ9h+HbThqVonXzr2/lz9kcXayVMdQmBKpMB7jR8c7bOg4Jp6zZLLg5ojpVr/WDoH6oennAl0lZNpQ6jo3ZMGoBUzDy18hPfS3mfv3ahlhvVxyNBFVfQjjPO31mYC0isLgkhATADPMhR0KRO47KpDcEenWZGa/rCUzqa9Ljg0Kjf3YOQryYMDxLJNwrZAQywnUfsB79Gfkzy1/KQIjvXAVqBVA5PjfzhT+4bndhJ0AYFf/HA2XyN2ELeWqDiKRC52nWj8fs8Qce+5SaIHiuWEEwOWKEiEGheD9S6pjTgpUbafHOQ6tkFgjgkIHwPjFnQz8urNGneZnq1+QyrqxmaWZE73+ogPMPNOPzp/G2h8LE2mRxi19onbbpyAhjCs4yXdyqCQsywedjChEXv0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199018)(33716001)(33656002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007)(8676002)(6916009)(478600001)(41300700001)(8936002)(1076003)(44832011)(5660300002)(316002)(2906002)(6486002)(83380400001)(53546011)(26005)(9686003)(6506007)(6666004)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9GYTjzjn1q5wNAJhv9fS02FTdi8oiO8X0aSYBBFmPczLmL0uigsuWYDhUfg?=
 =?us-ascii?Q?6HAR5XN4MeDuX1BpkSHPn/qpe6YjAZM2Y6BeDag4tO8colL/DFyGMSgBD64p?=
 =?us-ascii?Q?c4K6bY3Xik2wS0YIAqMUMN1VrXLs3agugN4d6K/S7jkF/eBPZWE5i5m0zN0x?=
 =?us-ascii?Q?xr7MacJhmcqa1K3GrE1en9HjpvK0j+wn6b0tXxQYQ+Tx9F4k5LXU9B5pRHsk?=
 =?us-ascii?Q?TspUuWMkQqYlU9qIP0Z5MQ91DY1U6w89qEK//+iE3olfU2Yd9kenY3QUfOJ1?=
 =?us-ascii?Q?AZSalYJW5zCaB8vIgCKYWyg0FSSBWBDpgb2IwthQkuNlLfDgJUFpEjwQh6ow?=
 =?us-ascii?Q?KyIp/hVJf4+LT8WMeg29NxN5t1VyDnxw9UCw3okqc3IcgTtoO5jeZZ29XZyh?=
 =?us-ascii?Q?gGOmkdkY8DWcu7jA6ke0rroKOPUyLKnppYvi0wNbC+5zsgIa6+YdiIA6Pyve?=
 =?us-ascii?Q?vWbtQnZCZNnJqo/DYqPOzXN3ngqZfsforCtkJiBVskd+GdMmemhKYhbIMNCA?=
 =?us-ascii?Q?umXwQB6lkzzNsToQ2feo/Iiot2hc1u7vXhuEbRAW8+oiKmlqyyZM9HhWTUVd?=
 =?us-ascii?Q?1GsZwtVoPqSUGbvzOxDfo7kq7WQ1ug9CfkNeSSu75UCUip3Ubyb/ljBs37fL?=
 =?us-ascii?Q?bxVYuSplqcgBLViN2DvbnJCjB0jaT9n5MnkBfCVTM20rjFlVVE4mrgmvnEKt?=
 =?us-ascii?Q?KWPgekTmRuWLSenM4YdHZy81oxPhUH4Por2LFfQU80GP5AvPyRgNe4sOIGm6?=
 =?us-ascii?Q?X67qWR6QcPGEVwKfda0AmCU1ncjgOEUrkuk2HDisBzv8WEso1860vXBbdUvN?=
 =?us-ascii?Q?QOCff8gdYgkB7K/d7kDEbDl23owRJDQ2dSfUp1zOfSndO9whpuYg2ZvIhwbx?=
 =?us-ascii?Q?YELynogmmrUuBB8Da6/VF+ZJztJCkpDWVOpnwcb5cDfmGOT5dLEarICjtAN8?=
 =?us-ascii?Q?dSiuFpD1SyhD5vgvEPMJLya3C5+TeAslRu1ge5nRRdT3KvxL73/d3j+cEXfD?=
 =?us-ascii?Q?IETABe0wJ+c8X8vHNIA5tsGLcNS7hfKL51UaiB7QT0RSQbmdCWZcc7TkoQA5?=
 =?us-ascii?Q?ADXNbEuKzIZDsgzz+5MfluZ9kPE5CmfuDoPce6ZH9/1hpPDGp5R8172RRkkU?=
 =?us-ascii?Q?X9DxxKnFMVAftAjrPP3d2bdUwvLR+k/FvvpakeQbGWWJQnFthDhas/tC/h01?=
 =?us-ascii?Q?i1dbIAOu+OHexa5VrMGElWYb1tKj/9oMDgXmNspCExI0WIl2RpyujPbaByxs?=
 =?us-ascii?Q?B1mhbt5uJ8miAvqux1mPkvWyEMN/WcA+N4m6Ishd8XUOnYRmUjw4vuV5WziZ?=
 =?us-ascii?Q?oTRt/+GrlahKoG2IZ8OEuQ+Noeb3CMGIJ3tgzkmu5NlZkVOrNwIdAZjquL88?=
 =?us-ascii?Q?XW34oiLUhQ6Xjme4PM9jcpUjZ5U//nhdkseZH/gTO7Gl/IDuXqmj3G2qKC/2?=
 =?us-ascii?Q?rY6UtKOTori0eh4eqi+eubBZE/RKF4ZyqiSn6GU3Ul58F5mIr8ABjG14lu7r?=
 =?us-ascii?Q?ZSelrI3SapRQQzNAERY72trEhit1a1t0+X2j0KNb/lITF4HrXR+bhu2zPL6l?=
 =?us-ascii?Q?izbNBznbyCEpb6MYx/epEWrxqNkVd2xOKbjNVmLROlIwHgpD1N3OsVwsmgH3?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5j5E7WLW8Q+08CUwXAfI0XCmTwjs+Nu/b47wkZGlmYlEVXortEEfc19oqHH0?=
 =?us-ascii?Q?Rfh/EErSu17kBMJsI5VKv3E7+5JWRf4Pu5W64aZvhduPtfJGN/c4m6bNi/bM?=
 =?us-ascii?Q?/OMyphPrR+0rRMCIeuapuThRKjAjEanUBOLz7cMpuxZdU1CWufd0rhLNr4gF?=
 =?us-ascii?Q?ZbUrS9wtP2FBF5TOsq7INnk52cWSmQYyVw+yoS4HP4dHddKTxC7rgTigDsmX?=
 =?us-ascii?Q?E/OZ7ulywgnbBVrqoYvY9/yUjgaC2Gsk5PrPMRWCC74s9MBL0qqgFNQf7OFY?=
 =?us-ascii?Q?0qCadcLfuL2uXyrM6jVy7lLRyWBufL9b+ZRqhDILUKvXba699Q7wKvmwLXLu?=
 =?us-ascii?Q?2ke0AzKw3VNXIsBD3yPLFuD1zNYL0/eFyndxKIAPJ1FZS7qbA2J6sImnEPsy?=
 =?us-ascii?Q?yADBgC5hYQ3ltK8iXUUqNNyLhM/pALYt04OQYTBCcMtjBnGdOcCEs+9bAX7Z?=
 =?us-ascii?Q?x6VrWl7aLWMqo/ZVLU9+O5BTy8av1B73EWKv/o06V9y2dFXt0aaYFsItQo1t?=
 =?us-ascii?Q?gufiwNEqUvG9EfvJAnS/eMhjsM96PCal0BY05EGg0cURak2fBu60r8dtX6hB?=
 =?us-ascii?Q?XY4tQspbthlGh5LUcC0eZmD2zhmikq/lhM7Z2BRyYtEWD/+S2bhAFDdP6r4s?=
 =?us-ascii?Q?ecZBn9EMum/hcvDZ64ptgVOQmqJKbsrpD/ey9h3o0FiTtikzuuc6b+Rz/zJ/?=
 =?us-ascii?Q?ZJ22OBNjXmg+MM3gJBwS7KoRu/1XH9IAjLnpv4RbPaMMlYYHu9SlUA6/Ewgm?=
 =?us-ascii?Q?Vkx7Xyu3FS1pIm1fHOzIJ/yUiwiDMXFN0SPKKXMIdgg9Zg07CPShoW4jfSOy?=
 =?us-ascii?Q?YCioe3kvRawpJic+vcl42J7HykAYFnQh0VqgtgEZeu6oGImbUix2I610PFX4?=
 =?us-ascii?Q?Qlshxy2SRJRGjyAlwhiMUcZAg5NbiBvJh5oQVvfq5w0+Efey3kTu/s6p4NfH?=
 =?us-ascii?Q?OFchckugvv3mTI4jPLOVvwelEwkR9FXWq04+te6GqS8Tf2ZegioL6Lh4/qZf?=
 =?us-ascii?Q?RvOs7zdqLuLhWnjW2tVdNeNQZw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb3451c-3f91-4a03-2b15-08db23e5984a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 17:08:41.5193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJto4uHMRA2l+tPTL4DiTpbXfo9rcmMrXuzyIsygyBeBOtnRKfEH9FcON+EyMPCmXNKaoKd0lPGmzCd4gYhGvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_08,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=958 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130134
X-Proofpoint-GUID: 5EEirGYBeUcbVhNIY17w0OhTOdXAebgT
X-Proofpoint-ORIG-GUID: 5EEirGYBeUcbVhNIY17w0OhTOdXAebgT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/23 18:37, Baolin Wang wrote:
> When trying to isolate a migratable pageblock, it can contain several
> normal pages or several hugetlb pages (e.g. CONT-PTE 64K hugetlb on arm64)
> in a pageblock. That means we may hold the lru lock of a normal page to
> continue to isolate the next hugetlb page by isolate_or_dissolve_huge_page()
> in the same migratable pageblock.
> 
> However in the isolate_or_dissolve_huge_page(), it may allocate a new hugetlb
> page and dissolve the old one by alloc_and_dissolve_hugetlb_folio() if the
> hugetlb's refcount is zero. That means we can still enter the direct compaction
> path to allocate a new hugetlb page under the current lru lock, which
> may cause possible deadlock.
> 
> To avoid this possible deadlock, we should release the lru lock when trying
> to isolate a hugetbl page. Moreover it does not make sense to take the lru
> lock to isolate a hugetlb, which is not in the lru list.
> 
> Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/compaction.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c9d9ad958e2a..ac8ff152421a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c

Thanks!

I suspect holding the lru lock when calling isolate_or_dissolve_huge_page was
not considered.  However, I wonder if this can really happen in practice?

Before the code below, there is this:

		/*
		 * Periodically drop the lock (if held) regardless of its
		 * contention, to give chance to IRQs. Abort completely if
		 * a fatal signal is pending.
		 */
		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
			if (locked) {
				unlock_page_lruvec_irqrestore(locked, flags);
				locked = NULL;
			}
			...
		}

It would seem that the pfn of a hugetlb page would always be a multiple of
COMPACT_CLUSTER_MAX so we would drop the lock.  However, I am not sure if
that is ALWAYS true and would prefer something like the code you suggested.

Did you actually see this deadlock in practice?
-- 
Mike Kravetz

> @@ -893,6 +893,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		if (PageHuge(page) && cc->alloc_contig) {
> +			if (locked) {
> +				unlock_page_lruvec_irqrestore(locked, flags);
> +				locked = NULL;
> +			}
> +
>  			ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);
>  
>  			/*
> -- 
> 2.27.0
> 
> 
