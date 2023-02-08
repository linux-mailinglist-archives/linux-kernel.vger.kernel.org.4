Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93D68FAE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBHXIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBHXIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:08:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB628D13;
        Wed,  8 Feb 2023 15:08:42 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwxR0023291;
        Wed, 8 Feb 2023 23:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0uujwXDKqrBv0zAKcq0e1g3qbuVCMfNVGNipmqXKL48=;
 b=brd3of9oXHvnK5Js8DYIcFVpI772OG1Z6ipTbcrQC+xAVFhmFYoRKPwuYvg+qQQqnCzU
 fwolKi3a06bgaqwxHGSyMWAd2PozB9ChdIifzDNsU5HT1Ih3DGm4wI/lLKWLiCGUNqJH
 KBPvhLtLsxvh3PwBxabinxmBcit4emGczwKZH2LISEyGRHQRu4RqW6Mryp1vWWnIATIb
 QYzk6LZRjenho8P/2ImVolUnXY4sVBBgF2umMTX1cAfnE90iyeXjVHV2dEFMqfKU2SNQ
 flv0f5ot9pZIFyIigb10wmIJZqgs4fx7+H23HIg7fYBqkD6hgAo3xb16SfdYh04BCTo0 +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe9nhhf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:08:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318LRsOa035791;
        Wed, 8 Feb 2023 23:08:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdte7r14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsLVfvYJT38kF0AlHguc9CJWipmW3nrvWkYGsE40I41WpZFjwGZLhiqGSmbOXBdx4nBRcuMzF6Rc/Ce2Xg1yoQmx64dkRY1r203vHqZP+9GsF6AZx0K/URBEVnSSxv5MPoLcUnPzy99zr5eZnOTnWVcdHFCxmYL6Iw8DaUETaTTWUTJWSQUZZNMEHyazPaoRyYMcjdHTYN8DsvnuYA+dK3dqBsNiERXG3SXQBuv6DRRCU6g3fCYTDDzQpCP0nlpz+Vb8iUrtUq1i6SSS3a1fLBmZhbzLJ0gIPutlwqqY1C9K9m7fEFnB8itO1wtSTLl4bdmllAT43ijRinhzHGUt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uujwXDKqrBv0zAKcq0e1g3qbuVCMfNVGNipmqXKL48=;
 b=WxLP671t+NijaytSMkPNTAWmL6P9NrMTTTPVyNDJzhKbRlyAktHXv4NX6Zxsgz7o8UsJ44T1LRs+rGgR3odwwKRiFTC0V+YC+g1lHQNjeCgkfsGJiJcwnP/39oHD5fJpyk+xF5q1RUswBZn5ezzpILTEtY0mgI6nl0+EgCwmJLXqQxz3rqJG0f/W5sp170RvjLpKssAn5UOnbaZbxVD5U0wLQMcfeu1QcwkyXNsGEfw/7YTASVaf11SAEOVu7tFKrPMgrBkXQYA8QN4lZmAGVJvpiyCSGpuJnr7WnKqACnYANaV/mQYqbwC1E/ReDr2GUe25riBzdcVs8aU4kz3DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uujwXDKqrBv0zAKcq0e1g3qbuVCMfNVGNipmqXKL48=;
 b=drNSNs4tGkTu7DDsm+wPRCttreKh8Ndzsr7m1x948KxmlKzE3ZZKEdH69ABMAWZj5IWWgoWFSP8gwXgxrCj+MjMWYlxf1AoJxPxfEs5woOUNoGaNbOPhZyDgjm5M4lOD9NLID0lFD/1/DYAjZ+AiLh2+EUrg3awPMPkklkOs/tI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:08:26 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:08:26 +0000
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ufs: host: ufs-qcom: Add support for SM8550
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jrv21wq.fsf@ca-mkp.ca.oracle.com>
References: <20230119151406.4168685-1-abel.vesa@linaro.org>
Date:   Wed, 08 Feb 2023 18:08:24 -0500
In-Reply-To: <20230119151406.4168685-1-abel.vesa@linaro.org> (Abel Vesa's
        message of "Thu, 19 Jan 2023 17:14:04 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0145.namprd11.prod.outlook.com
 (2603:10b6:806:131::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cb6366-3520-4e42-37c9-08db0a29626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daXkshSyivgwQ5utOb1Mzzd5mwHXXBnChyN41G+GkrI2e3Tc5PjnjvoXIyGuV5kwgVOmppBwDlXlmkhhRUGrBv4trGKsQU68M4uYKIKnuXCsHwj/CfN5gDo9Inbaax3EFQl1GUjZl8DQ7NufIwx8/oHby2UM86nBEvDpy5Xhk20FOGBatI5MVVV5tyHOH6ErpuK84IeSqs9RbEVPNoi7nstkJDxbsMIiT2qm/1M8lTkkIHmTcCU7YsLlAye4Hy07NRy6hcnyhJOsVUoENIEjtgl99VEEndNVDEHcqDL63FHj4oM/VCNwR928I9GyT6M57L9X5f1zSvovL+kfm6QiuCJS0xdU7P6IHpWZ3ZANf3nbqrHrQ7Llc7v6v0KrsRsm5dqavNAJD/k0f6oPnBo4LpOOSQUoJzBDvBJEJg8CvbEhA+UQZANTzI3SpjeI6IylA0136jLEjr5x7LncDoAilvAwlMVoz8gAPDIT6rMDYbSbU9OLlO/kax2Fi4/rA6xSWECS6Pwo6KA6VXvpYRAskzQeel24mobFwk2OErmiMkeQ1jLrwhzvrXeqjaWDLLwsHK5R8a6WnyXIkzWtApc3KNIV+oAvO9s68qmiqM/QXC6xnyG6YY5a1Vfm9Vt7dRk9SrtVEtXPpWim+DHN+7JJeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199018)(6506007)(6512007)(26005)(186003)(316002)(2906002)(8936002)(558084003)(36916002)(54906003)(5660300002)(7416002)(478600001)(86362001)(6486002)(66476007)(66556008)(66946007)(41300700001)(6916009)(4326008)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zf8idp+sBXaAqYn7TSkZ5B4wtuU8McWPmBwsJxuxq+PgVwWDUaiMnt1JF/FU?=
 =?us-ascii?Q?W/e/953dyp8l+9qRVsWEK30CFBASxsrH2iLZNKt4QkoaJdMHTVcliP+uFgg+?=
 =?us-ascii?Q?SjYSCA7iHaxtVpnZSXiXRIYF+FH8wtAKiPqeGbY1OO7qkfX4HQT97azPUjRl?=
 =?us-ascii?Q?K2sLP8sJTtcCA1n5NTI531YWtu3OK5LTnhlXMdA5AYs0mCtGVQODII1CtH2w?=
 =?us-ascii?Q?8/ePiYYUJ1VOQ3Uh0zRdu980TOwAOtxablFoG3njXE6hvLH6vVGhGLfXWZ1S?=
 =?us-ascii?Q?BhCj8hYrYEb/oYX+okZn8fOtDGYX0F+GMDS81T5mTY5ImKy8/znmO1xeilR1?=
 =?us-ascii?Q?4gAKDC53nfHNRxaVcxO3s7FumILoxJWmhz5HBgQ4G6IADnFDKVNSMPTOv0CK?=
 =?us-ascii?Q?D3mf3slHJkl72zkk+VYT8XRuXV87BfwUotI3h7+NGAYqbg4Wu7hchuCsNe4C?=
 =?us-ascii?Q?9TiaW8Svrn60uhka+TRJYGm/35y55eTfg9F/vgyuE1GJJwxmJb8mUtyhj22k?=
 =?us-ascii?Q?GbIQejBooAZJ8N8A0G8179sxT6LbYQGkb2D/NwSQPkLA0TzVrHI2NmcxiAZF?=
 =?us-ascii?Q?8WK4r0w1PtvcGPCBcsHISGcfBZgtWqifJOpZFo0bN+v8KsBFd14PZYqj8DtR?=
 =?us-ascii?Q?55Eo0xZAxTsMcPQVs5hfgYaWYXqYqw0LoZmsPFluJjQacxf5fRV65WR5TAej?=
 =?us-ascii?Q?QyoJrYVsQitypP6NpP4feFw23G+eYLIo9Vdi0Ko2wzEd2G/w9Y2nzkQL2S4u?=
 =?us-ascii?Q?524q/llA2co+H3TxLiTqoeABsGuGtcHdaH81mZHpzLP9GIH9981Te6ttsAoR?=
 =?us-ascii?Q?iyM7rOzsnfwM1upfL78cYiQmzaQF1gTKxK1EaF+DCTcM+EuTyg5KeCoW3b5h?=
 =?us-ascii?Q?GTG9ogK+QwPAMtyWoxFHt08rEEBtEZdNo/f/qVVAqz0JnGT+RHntSJCNEmbV?=
 =?us-ascii?Q?zu/8wl7DaaqzMzsOw1ajKjDM11d2PNg2IjfenLpvdRFzb/6NEh8JlFRfJv15?=
 =?us-ascii?Q?yE/xrNvO1fY8Ya6UccIacPJIVIzYmaBzqVp5aiPiqsgyfCohXpEvl2wK1JFb?=
 =?us-ascii?Q?QOuRrW4ILEIVi4GOdXtkcDYuJPrfqIXCF8WP27zLLB7raxEuDt5luhCPFkSt?=
 =?us-ascii?Q?6klCmJ1hqKyxTwSBH4G9JOizp1jzfrgogD2gidLfK2+98dUx3D4k1dkCh1Ue?=
 =?us-ascii?Q?GXr6uqMwGWUXAraCQnOC7PrtNXHNnOlb72IGpWNNmT/us3Z+E3d1wjHmdvgT?=
 =?us-ascii?Q?2eLwygrEMWocdM5zFDWQBEPisuyBn+I7laNw5OTIFeVoz1sMzXn2+qNp4sso?=
 =?us-ascii?Q?p1hj/HydduzcKIAmSWWaC6sGRSffFEokDJpMGeS/S8Hjnw57A07pEc1LYE2D?=
 =?us-ascii?Q?6iecHPvFFsqN5dwCnWFSbBsI0UOlwQ2dJwXVyY8Uyo/MIVGLWQbNS4nEjHxL?=
 =?us-ascii?Q?+D2f7W0Wa9+yh8ajUewvLbLcQqk59cXV12czYFezlqmuu8T5QYAdzscU7XJp?=
 =?us-ascii?Q?+znpClF5bnITsFIVocZO6IJMDcjqhScJurOVxTEPlP403umPG8LXPPBG7YFd?=
 =?us-ascii?Q?WFwllt5JZTjSX/7YF5ptwPN/odXdCmYfGM21bAMzuJbJxiFgugxk9Co1IcbL?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qGLAfkQlnBkhOmMd0iHjH+wBJl1knx5TEl+gEfKHP685dlrt6GB+FdZ6wK0h?=
 =?us-ascii?Q?YhfZyvd4AV+XFREVZxnM6VAdlcQne/v7ZwQAljFx9MyZs4py7bwLQsE7Rydr?=
 =?us-ascii?Q?0SeqVtvC25QlVU7WTIA+5Y0WjJgxlgwYzL5Gahgc9165KVSoy8WcxLaYvz0E?=
 =?us-ascii?Q?hRW5O1nFmf/YeLeZFO/LZtnQnZkH+KSkUmybp2WffHDPhKCtFMFjgiuSv5iL?=
 =?us-ascii?Q?/n+jDSY2jPjd27msB79a7gPWVP07P7f0KQ0A5qTD25RAHDB6UykiHIBXoH07?=
 =?us-ascii?Q?X/LAcf5QPou0rgr5wVSjDYlaLqJ4wG6S6n0GOex6SygjSvRZao0EUslHk0X2?=
 =?us-ascii?Q?K6A7ZfK4Cx736Z5D3SvQ3SRqAqchG5/vbOROWmHIVv4TGAdKjr9RWNxivG+J?=
 =?us-ascii?Q?57XzTd2LwQZJidQD8+SVc1hPJXQlXPzcFSvCkUpgQy1J/dlwLsoiK0GcpDZG?=
 =?us-ascii?Q?QiNhWgRsb93x37BWIlqJGI+taep8NMuziCgnbM3qK8zwyh05eJaAJhQquuM1?=
 =?us-ascii?Q?rNu4+8nNsmmDWNYD4AiOcnYd52bRTr619OlSK2DD4FZfMzGFYe+IyhCzi+mN?=
 =?us-ascii?Q?XB2iyBaNRJdjYsfNFk3UV343RAO2/tFTvmOnZf2dJp/GCBaEmjWE8K0CjPoo?=
 =?us-ascii?Q?pLadYpnr4gwxIYPX/3qMicfBrmdRdnzvIuWYrvoQbHF9XlBPQ4qMx2YkKoe7?=
 =?us-ascii?Q?/JMPffRu9+w0xVcwvYeVMlpeZId30KBKeMI/XOpzuKLBMIqAGv8JSiBRVMyj?=
 =?us-ascii?Q?y8K4LzhDxvAMXFBspSSqwsHrg/Rq6oEcJEE0+B8piJzoMfwVynJiVCeXpGwO?=
 =?us-ascii?Q?H0RBkhMQvdjqjegv7KJDOL2c5rGq/LEsLIUFTP4o3qeWK+/xuqOgez5/OC4m?=
 =?us-ascii?Q?l/NUy/dLHid6m5yRc2mB+uV5fafnhzfJuYrEatVF8J7RZdxFcqYKqSOa/46m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cb6366-3520-4e42-37c9-08db0a29626c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:08:26.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEi9Y4K3RCtygr5mDxUUSnoZAS/1idWR9P5CD3Bm7lbl4RNQ4awYk0CaaGgby09UiEzHvLvlvv0UB8M0rhoWOWYL/zqAJg+DsNKmqjRznj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=724
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080196
X-Proofpoint-ORIG-GUID: KDEGEp0EBg5CpB3X0-m6_JvVCZ8QSd2C
X-Proofpoint-GUID: KDEGEp0EBg5CpB3X0-m6_JvVCZ8QSd2C
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Abel,

> This patchset adds UFS HC support for the new Qualcomm SM8550 SoC.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
